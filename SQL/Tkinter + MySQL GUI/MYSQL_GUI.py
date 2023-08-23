import tkinter as tk
from tkinter import ttk
from tkinter import Scrollbar
from tkinter import messagebox
from tkinter import Canvas
from MakingRaw import *
from join2raw import *
import customtkinter as ctk
from tkinter import filedialog
import shutil
import os
import pyodbc

# Create the main window
window = tk.Tk()
window.title("Database Interface")
window.geometry("1000x600")
ctk.set_default_color_theme("dark-blue")
ctk.set_appearance_mode("Dark")


# Function to connect to the MySQL database and return the connection and cursor objects
def connect_to_database():
    dsn = 'DeepScan'
    conn = pyodbc.connect(f"DSN={dsn}")
    cursor = conn.cursor()
    return conn, cursor


# Function to close the database connection
def close_database_connection(conn, cursor):
    cursor.close()
    conn.close()


# Create a tab control
tab_control = ttk.Notebook(window)


# Function to populate each table
def populate_table(tab, query):
    # Clear existing data
    for child in tab.winfo_children():
        child.destroy()

    # Connect to the database
    conn, cursor = connect_to_database()

    # Create a Treeview widget
    tree = ttk.Treeview(tab)

    # Define columns
    tree["columns"] = ("Server Name", "File Path", "Protected File", "Interesting", "Exception")

    # Format columns
    tree.column("#0", width=0, stretch=tk.NO)
    tree.column("Server Name", anchor=tk.W, width=100)
    tree.column("File Path", anchor=tk.CENTER, width=350)
    tree.column("Protected File", anchor=tk.W, width=100)
    tree.column("Interesting", anchor=tk.CENTER, width=100)
    tree.column("Exception", anchor=tk.W, width=100)

    # Create headings
    tree.heading("#0", text="", anchor=tk.W)
    tree.heading("Server Name", text="Server Name", anchor=tk.W)
    tree.heading("File Path", text="File Path", anchor=tk.CENTER)
    tree.heading("Protected File", text="Protected File", anchor=tk.W)
    tree.heading("Interesting", text="Interesting", anchor=tk.CENTER)
    tree.heading("Exception", text="Exception", anchor=tk.W)

    # Create a scrollbar
    scrollbar = Scrollbar(tab, orient="vertical", command=tree.yview)
    scrollbar.pack(side="right", fill="y")

    # Configure the Treeview widget to use the scrollbar
    tree.configure(yscrollcommand=scrollbar.set)

    # Execute the query
    cursor.execute(query)
    rows = cursor.fetchall()

    # Insert data into the table
    for row in rows:
        cleaned_row = [str(item).replace('(', '').replace(')', '').replace("'", "") for item in row]
        tree.insert("", tk.END, values=cleaned_row)

    # Pack the Treeview widget
    tree.pack(fill=tk.BOTH, expand=True)

    # Close the database connection
    close_database_connection(conn, cursor)


# Create tabs
tab1 = ttk.Frame(tab_control)
tab2 = ttk.Frame(tab_control)
tab3 = ttk.Frame(tab_control)
tab4 = ttk.Frame(tab_control)

# Add tabs to the tab control
tab_control.add(tab1, text="Raw Data")
tab_control.add(tab2, text="Exceptions")
tab_control.add(tab3, text="Non Exceptions")
tab_control.add(tab4, text="Non Exceptions")

# Populate each tab with the respective table data
populate_table(tab1, "SELECT * FROM tableoffiles")
populate_table(tab2, "SELECT * FROM tableofexceptions")
populate_table(tab3, "SELECT * FROM tableofsum")
populate_table(tab4, "SELECT * FROM posfactors")

# Function to refresh the table values
def refresh_tables():
    # Refresh data in each table
    populate_table(tab1, "SELECT * FROM tableoffiles")
    populate_table(tab2, "SELECT * FROM tableofexceptions")
    populate_table(tab3, "SELECT * FROM tableofsum")
    populate_table(tab4, "SELECT * FROM posfactors")
def sql_backend():
    fileimport()
    process_files()
    add_column_to_table()
    update_table_exceptions()
    Sum_of_tables()

# Function to get the currently selected row in the active tab's Treeview
def selectedRow():
    # Get the currently active tab
    active_tab = tab_control.tab(tab_control.select(), "text")

    if active_tab == "Raw Data":
        tree = tab1.winfo_children()[0]  # The first child of tab1 should be the Treeview
    elif active_tab == "Exceptions":
        tree = tab2.winfo_children()[0]  # The first child of tab2 should be the Treeview
    elif active_tab == "Non Exceptions":
        tree = tab3.winfo_children()[0]  # The first child of tab3 should be the Treeview
    else:
        tk.messagebox.showinfo("Info", "This is not a valid tab for the swap")
        print("No valid tab selected.")
        return

    # Get the currently selected item in the Treeview
    curItem = tree.focus()
    if not curItem:
        messagebox.showinfo("Information", "No row selected. Please select a row and try again.")
        return

    # Get the data of the selected row and print them to the console
    contents = tree.item(curItem)
    print(contents['values'])
    conn, cursor = connect_to_database()
    exceptions = contents['values'][4]
    filepath = (contents['values'][1],)
    Ex_to_Z = "update tableoffiles set Exceptions = 0 where DataLocation = ?"
    drop_f_ex = "Delete From tableofexceptions where DataLocation = ?"
    Ex_to_O = "update tableoffiles set Exceptions = 1 where DataLocation = ?"
    add_f_ex = "Insert into tableofexceptions select * from tableoffiles where DataLocation = ?"
    drop_f_sum = "Delete From tableofsum where DataLocation = ?"
    add_to_sum = "Insert into tableofsum select * from tableoffiles where DataLocation = ?"
    if exceptions == 1:
        # Prompt the user for confirmation using a file dialog
        confirmed = tk.messagebox.askyesno("Confirmation", "Are you sure you want to remove this Exception?")

        if confirmed:
            cursor.execute(Ex_to_Z, filepath)
            print("setting except to 0")
            cursor.execute(drop_f_ex, filepath)
            print("add to except")
            cursor.execute(add_to_sum, filepath)
            print("adding to sum")
            conn.commit()
            print("committing to db")
            refresh_tables()
            print("refreshing tables")
        else:
            print("Action cancelled.")

    elif exceptions == 0:
        # Prompt the user for confirmation using a file dialog
        confirmed = tk.messagebox.askyesno("Confirmation", "Are you sure you want to set this value as an exception?")

        if confirmed:
            cursor.execute(Ex_to_O, filepath)
            print("setting except to 1")
            cursor.execute(add_f_ex, filepath)
            print("add to except")
            cursor.execute(drop_f_sum, filepath)
            print("removing from sum")
            conn.commit()
            print("committing to db")
            refresh_tables()
            print("refreshing tables")
        else:
            print("Action cancelled.")

    else:
        print("invalid exception")
        return


def execute_query_to_excel():
    dsn = 'DeepScan'
    conn = pyodbc.connect(f"DSN={dsn}")

    # Function to execute an SQL query and return the result as a pandas dataframe
    def execute_query_to_dataframe(query):
        cursor = conn.cursor()
        cursor.execute(query)
        data = cursor.fetchall()
        column_names = [desc[0] for desc in cursor.description]
        cursor.close()

        # Flatten the data
        flattened_data = [item for sublist in data for item in sublist]

        # Reshape the data
        reshaped_data = [flattened_data[i:i + len(column_names)] for i in
                         range(0, len(flattened_data), len(column_names))]

        # Create the DataFrame
        df = pd.DataFrame(reshaped_data, columns=column_names)

        return df

    query = {
        'table1': "SELECT * FROM tableoffiles;",
        'table2': "SELECT * FROM tableofexceptions;",
        'table3': "SELECT * FROM tableofsum;",
        'table4': "SELECT * FROm posfactors;"
    }

    # Fetch data from the MySQL tables
    df_table1 = execute_query_to_dataframe(query['table1'])
    df_table2 = execute_query_to_dataframe(query['table2'])
    df_table3 = execute_query_to_dataframe(query['table3'])
    df_table4 = execute_query_to_dataframe(query['table4'])

    # Close the database connection
    conn.close()

    # Ask the user to choose the file location and name
    file_path = filedialog.asksaveasfilename(defaultextension=".xlsx",
                                             filetypes=[("Excel Files", "*.xlsx")])

    if file_path:
        # Write dataframes to an Excel file with different sheets
        with pd.ExcelWriter(file_path, engine='openpyxl') as writer:
            df_table1.to_excel(writer, sheet_name='tableoffiles', index=False)
            df_table2.to_excel(writer, sheet_name='tableofexceptions', index=False)
            df_table3.to_excel(writer, sheet_name='tableofsum', index=False)
            df_table4.to_excel(writer, sheet_name='Intersting + Protected', index=False)



        print("Dataframes have been saved to Excel with different sheets.")
    else:
        print("File saving cancelled by the user.")


def show_files(folder_path, listbox):
    if folder_path:
        file_list = os.listdir(folder_path)
        listbox.delete(0, tk.END)
        for file in file_list:
            listbox.insert(tk.END, file)

def browse_csv_file(listbox):
    file_path = filedialog.askopenfilename(
        filetypes=[("CSV Files", "*.csv"), ("All Files", "*.*")]
    )
    if file_path:
        destination_folder = r"C:\Users\Micha\OneDrive\Documents\CODE"
        destination_path = os.path.join(destination_folder, os.path.basename(file_path))

        try:
            shutil.move(file_path, destination_path)
            print("File moved to:", destination_path)
            show_files(destination_folder, listbox)
        except Exception as e:
            print("Error moving file:", e)

def fetch_server_names():
    dsn = 'DeepScan'
    conn = pyodbc.connect(f"DSN={dsn}")

    cursor = conn.cursor()
    cursor.execute("SELECT server_name FROM unique_server_names")

    server_names = cursor.fetchall()
    conn.close()
    return server_names

def fetch_server_data(selected_servers):
    dsn = 'DeepScan'
    conn = pyodbc.connect(f"DSN={dsn}")

    cursor = conn.cursor()
    placeholders = ', '.join(['?'] * len(selected_servers))
    query = f"SELECT tableoffiles.* FROM tableoffiles INNER JOIN unique_server_names ON tableoffiles.servername = unique_server_names.server_name WHERE unique_server_names.server_name IN ({placeholders})"
    cursor.execute(query, selected_servers)


    server_data = cursor.fetchall()
    conn.close()
    return server_data

def non_exeptions_OPsitive():
    dsn = 'DeepScan'
    conn = pyodbc.connect(f"DSN={dsn}")

    cursor = conn.cursor()
    query = "Select * From posfactors"
    cursor.execute(query)

    server_data = cursor.fetchall()
    conn.close()
    print(server_data)
    return server_data

def fetch_non_exceptions_data(selected_servers):
    dsn = 'DeepScan'
    conn = pyodbc.connect(f"DSN={dsn}")

    cursor = conn.cursor()
    placeholders = ', '.join(['?'] * len(selected_servers))
    query = f"SELECT tableofsum.* FROM tableofsum INNER JOIN unique_server_names ON tableofsum.servername = unique_server_names.server_name WHERE unique_server_names.server_name IN ({placeholders})"
    cursor.execute(query, selected_servers)

    non_exceptions_data = cursor.fetchall()
    conn.close()
    return non_exceptions_data

def fetch_exceptions_data(selected_servers):
    dsn = 'DeepScan'
    conn = pyodbc.connect(f"DSN={dsn}")

    cursor = conn.cursor()
    placeholders = ', '.join(['?'] * len(selected_servers))
    query = f"SELECT tableofexceptions.* FROM tableofexceptions INNER JOIN unique_server_names ON tableofexceptions.servername = unique_server_names.server_name WHERE unique_server_names.server_name IN ({placeholders})"
    cursor.execute(query, selected_servers)

    exceptions_data = cursor.fetchall()
    conn.close()
    return exceptions_data


def create_checkboxes(server_window):
    server_names = fetch_server_names()
    selected_server_names = []  # Array to store ticked server names
    checkbox_vars = []
    canvas = Canvas(server_window)
    canvas.grid(row=1, column=0)

    scrollbar = Scrollbar(server_window, orient="vertical", command=canvas.yview)
    scrollbar.grid(row=1, column=1, sticky="ns")

    canvas.configure(yscrollcommand=scrollbar.set)
    canvas.bind('<Configure>', lambda e: canvas.configure(scrollregion=canvas.bbox("all")))

    frame = tk.Frame(canvas)
    canvas.create_window((0, 0), window=frame, anchor='nw')

    for i, server_name in enumerate(server_names):
        name = server_name[0]
        var = tk.IntVar()
        checkbox_vars.append(var)

        checkbox = tk.Checkbutton(frame, text=name, variable=var)
        checkbox.grid(row=i, column=0, sticky="w")

    return server_names, checkbox_vars

def export_data_to_excel(server_names, checkbox_vars):
    selected_server_names = [server_names[i][0] for i, var in enumerate(checkbox_vars) if var.get() == 1]

    # Get the selected value from the drop-down menu
    selected_option = drop_down_var.get()

    if selected_server_names:
        while True:
            # Create a Pandas Excel writer
            file_path = filedialog.asksaveasfilename(
                initialfile="server_data.xlsx",
                defaultextension=".xlsx",
                filetypes=[("Excel files", "*.xlsx"), ("All files", "*.*")]
            )

            if not file_path:
                # User canceled file selection
                print("No output location selected.")
                return

            if not file_path.lower().endswith('.xlsx'):
                file_path += '.xlsx'

            try:
                writer = pd.ExcelWriter(file_path, engine='xlsxwriter')

                if selected_option == "Only Exceptions":
                    all_server_data = [fetch_exceptions_data([server_name]) for server_name in selected_server_names]
                    flattened_data = [item for sublist in all_server_data for item in sublist]
                    list_data = [list(row) for row in flattened_data]
                    df = pd.DataFrame(list_data, columns=["Server Name", "Data Location", "protected","interesting content", "Exceptions"])
                    df.to_excel(writer, index=False, sheet_name="Exceptions")

                elif selected_option == "Only Non-Exceptions":
                    all_server_data = [fetch_non_exceptions_data([server_name]) for server_name in selected_server_names]
                    flattened_data = [item for sublist in all_server_data for item in sublist]
                    list_data = [list(row) for row in flattened_data]
                    df = pd.DataFrame(list_data, columns=["Server Name", "Data Location", "protected","interesting content", "Exceptions"])
                    df.to_excel(writer, index=False, sheet_name="Raw Data")

                elif selected_option == "Both":
                    all_server_data = [fetch_server_data([server_name]) for server_name in selected_server_names]
                    flattened_data = [item for sublist in all_server_data for item in sublist]
                    list_data = [list(row) for row in flattened_data]
                    print(flattened_data[:5])
                    server_df = pd.DataFrame(list_data, columns=["Server Name", "Data Location", "protected", "interesting content", "Exceptions"])
                    server_df.to_excel(writer, index=False, sheet_name="Raw Data")

                elif selected_option == "protected+intresting":
                    all_server_data = [non_exeptions_OPsitive()]
                    flattened_data = [item for sublist in all_server_data for item in sublist]
                    list_data = [list(row) for row in flattened_data]
                    server_df = pd.DataFrame(list_data, columns=["Server Name", "Data Location", "protected","interesting content", "Exceptions"])

                    server_df.to_excel(writer, index=False, sheet_name="Raw Data")
                # Close the writer to save the data to the file
                writer.close()

                print(f"\nData exported to {file_path}")
                break

            except PermissionError:
                print("Permission error. Please choose a different output location.")
                continue

    else:
        print("No server names ticked.")

def on_dropdown_change(*args):
    selected_option = drop_down_var.get()
    print(f"Selected option: {selected_option}")

def on_export_button_click():
    export_data_to_excel(server_names, checkbox_vars)

def create_ribbon(server_window):
    ribbon = tk.Frame(server_window, bg="lightgray", padx=10, pady=5)
    ribbon.grid(row=0, column=0, columnspan=2, sticky="we")

    export_button = tk.Button(ribbon, text="Export to Excel", command=on_export_button_click)
    export_button.pack(side=tk.LEFT)

    # Add a drop-down menu with 3 options
    global drop_down_var  # Need to make drop_down_var global to access it in other functions
    drop_down_var = tk.StringVar(value="Both")
    drop_down_var.trace("w", on_dropdown_change)  # Call on_dropdown_change when the drop-down value changes
    drop_down_menu = tk.OptionMenu(ribbon, drop_down_var, "Only Exceptions", "Only Non-Exceptions", "Both", "protected+intresting")
    drop_down_menu.pack(side=tk.LEFT)

def open_server_name_viewer():
    server_window = tk.Toplevel(window)
    server_window.title("Server Names with Tick Boxes")

    create_ribbon(server_window)  # Create the ribbon containing the "Export to Excel" button
    global server_names, checkbox_vars  # Ensure they're accessible globally
    server_names, checkbox_vars = create_checkboxes(server_window)


def open_file_list_viewer():
    viewer = tk.Toplevel(window)
    viewer.title("File List Viewer")

    ribbon = tk.Frame(viewer, bd=5)
    ribbon.pack(side=tk.TOP, fill=tk.X)

    button = tk.Button(ribbon, text="Add new CSV to View", command=lambda: browse_csv_file(listbox))
    button.pack(side=tk.LEFT, padx=5, pady=5)

    listbox_frame = tk.Frame(viewer)
    listbox_frame.pack(fill="both", expand=True)

    listbox = tk.Listbox(listbox_frame, selectmode=tk.SINGLE, font=("Helvetica", 14))
    listbox.grid(row=0, column=0, sticky="nsew")

    scrollbar = tk.Scrollbar(listbox_frame, command=listbox.yview)
    scrollbar.grid(row=0, column=1, sticky="ns")
    listbox.config(yscrollcommand=scrollbar.set)

    listbox_frame.grid_columnconfigure(0, weight=1)
    listbox_frame.grid_rowconfigure(0, weight=1)

    show_files(r"C:\Users\Micha\OneDrive\Documents\CODE", listbox)


# Create a Frame for the ribbon at the bottom
ribbon_frame = tk.Frame(window)
ribbon_frame.pack(side="top", fill="x")

# Exception Button: Update the command to call selectedRow()
Exception_button = ttk.Button(ribbon_frame, text="Exceptions Swap", command=selectedRow)
Exception_button.pack(side="left", padx=5, pady=2)

as_button = ttk.Button(ribbon_frame, text="Rescan host file", command=sql_backend)
as_button.pack(side="left", padx=5, pady=2)

# Create a Refresh button
refresh_button = ttk.Button(ribbon_frame, text="Refresh View", command=refresh_tables)
refresh_button.pack(side="left", padx=5, pady=2)

# Create the button to execute the query and save to Excel
execute_button = ttk.Button(ribbon_frame, text="Export tables", command=execute_query_to_excel)
execute_button.pack(side="left", padx=5, pady=2)


# Create the button to execute the query and save to Excel
execute_button = ttk.Button(ribbon_frame, text="Open Individal table Export", command=open_server_name_viewer)
execute_button.pack(side="left", padx=5, pady=2)

# Create a button to trigger file selection
select_button = ttk.Button(ribbon_frame, text="Open File List Viewer", command=open_file_list_viewer)
select_button.pack(side="left", padx=5, pady=2)

# Create a tab control
tab_control = ttk.Notebook(window)

# Create tabs
tab1 = ttk.Frame(tab_control)
tab2 = ttk.Frame(tab_control)
tab3 = ttk.Frame(tab_control)
tab4 = ttk.Frame(tab_control)
# Add tabs to the tab control
tab_control.add(tab1, text="Raw Data")
tab_control.add(tab2, text="Exceptions")
tab_control.add(tab3, text="Non Exceptions")
tab_control.add(tab4, text="Test")

# Pack the tab control to the right side of the window
tab_control.pack(side="top", fill="both", expand=True)

# Set column weight to make the tab control fill the available width
window.grid_columnconfigure(0, weight=1)

# Populate each tab with the respective table data
populate_table(tab1, "SELECT * FROM tableoffiles")
populate_table(tab2, "SELECT * FROM tableofexceptions")
populate_table(tab3, "SELECT * FROM tableofsum")
populate_table(tab4, "SELECT * FROM posfactors")
# Run the main event loop
window.mainloop()
