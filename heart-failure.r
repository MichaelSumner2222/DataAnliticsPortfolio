{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "6afa1c31",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2023-07-05T16:43:31.442802Z",
     "iopub.status.busy": "2023-07-05T16:43:31.440651Z",
     "iopub.status.idle": "2023-07-05T16:43:32.607591Z",
     "shell.execute_reply": "2023-07-05T16:43:32.605825Z"
    },
    "papermill": {
     "duration": 1.176017,
     "end_time": "2023-07-05T16:43:32.609935",
     "exception": false,
     "start_time": "2023-07-05T16:43:31.433918",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching core tidyverse packages\u001b[22m ──────────────────────── tidyverse 2.0.0 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mdplyr    \u001b[39m 1.1.2     \u001b[32m✔\u001b[39m \u001b[34mreadr    \u001b[39m 2.1.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mforcats  \u001b[39m 1.0.0     \u001b[32m✔\u001b[39m \u001b[34mstringr  \u001b[39m 1.5.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2  \u001b[39m 3.4.2     \u001b[32m✔\u001b[39m \u001b[34mtibble   \u001b[39m 3.2.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mlubridate\u001b[39m 1.9.2     \u001b[32m✔\u001b[39m \u001b[34mtidyr    \u001b[39m 1.3.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mpurrr    \u001b[39m 1.0.1     \n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\u001b[36mℹ\u001b[39m Use the conflicted package (\u001b[3m\u001b[34m<http://conflicted.r-lib.org/>\u001b[39m\u001b[23m) to force all conflicts to become errors\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "'heart-failure-prediction'"
      ],
      "text/latex": [
       "'heart-failure-prediction'"
      ],
      "text/markdown": [
       "'heart-failure-prediction'"
      ],
      "text/plain": [
       "[1] \"heart-failure-prediction\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# This R environment comes with many helpful analytics packages installed\n",
    "# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats\n",
    "# For example, here's a helpful package to load\n",
    "\n",
    "library(tidyverse) # metapackage of all tidyverse packages\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n",
    "\n",
    "list.files(path = \"../input\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "c177fb2b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-05T16:43:32.648380Z",
     "iopub.status.busy": "2023-07-05T16:43:32.619477Z",
     "iopub.status.idle": "2023-07-05T16:43:32.856498Z",
     "shell.execute_reply": "2023-07-05T16:43:32.854649Z"
    },
    "papermill": {
     "duration": 0.245521,
     "end_time": "2023-07-05T16:43:32.859509",
     "exception": false,
     "start_time": "2023-07-05T16:43:32.613988",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "heart_failure <- read_csv(\"/kaggle/input/heart-failure-prediction/heart.csv\", show_col_types = FALSE)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "37ab17e4",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-05T16:43:32.871594Z",
     "iopub.status.busy": "2023-07-05T16:43:32.870056Z",
     "iopub.status.idle": "2023-07-05T16:43:32.887290Z",
     "shell.execute_reply": "2023-07-05T16:43:32.885520Z"
    },
    "papermill": {
     "duration": 0.026159,
     "end_time": "2023-07-05T16:43:32.889866",
     "exception": false,
     "start_time": "2023-07-05T16:43:32.863707",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'Age'</li><li>'Sex'</li><li>'ChestPainType'</li><li>'RestingBP'</li><li>'Cholesterol'</li><li>'FastingBS'</li><li>'RestingECG'</li><li>'MaxHR'</li><li>'ExerciseAngina'</li><li>'Oldpeak'</li><li>'ST_Slope'</li><li>'HeartDisease'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'Age'\n",
       "\\item 'Sex'\n",
       "\\item 'ChestPainType'\n",
       "\\item 'RestingBP'\n",
       "\\item 'Cholesterol'\n",
       "\\item 'FastingBS'\n",
       "\\item 'RestingECG'\n",
       "\\item 'MaxHR'\n",
       "\\item 'ExerciseAngina'\n",
       "\\item 'Oldpeak'\n",
       "\\item 'ST\\_Slope'\n",
       "\\item 'HeartDisease'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'Age'\n",
       "2. 'Sex'\n",
       "3. 'ChestPainType'\n",
       "4. 'RestingBP'\n",
       "5. 'Cholesterol'\n",
       "6. 'FastingBS'\n",
       "7. 'RestingECG'\n",
       "8. 'MaxHR'\n",
       "9. 'ExerciseAngina'\n",
       "10. 'Oldpeak'\n",
       "11. 'ST_Slope'\n",
       "12. 'HeartDisease'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"Age\"            \"Sex\"            \"ChestPainType\"  \"RestingBP\"     \n",
       " [5] \"Cholesterol\"    \"FastingBS\"      \"RestingECG\"     \"MaxHR\"         \n",
       " [9] \"ExerciseAngina\" \"Oldpeak\"        \"ST_Slope\"       \"HeartDisease\"  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "names(heart_failure)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "40d4ac1d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-05T16:43:32.901653Z",
     "iopub.status.busy": "2023-07-05T16:43:32.900074Z",
     "iopub.status.idle": "2023-07-05T16:43:32.944915Z",
     "shell.execute_reply": "2023-07-05T16:43:32.943233Z"
    },
    "papermill": {
     "duration": 0.053308,
     "end_time": "2023-07-05T16:43:32.947295",
     "exception": false,
     "start_time": "2023-07-05T16:43:32.893987",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 12</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Age</th><th scope=col>Sex</th><th scope=col>ChestPainType</th><th scope=col>RestingBP</th><th scope=col>Cholesterol</th><th scope=col>FastingBS</th><th scope=col>RestingECG</th><th scope=col>MaxHR</th><th scope=col>ExerciseAngina</th><th scope=col>Oldpeak</th><th scope=col>ST_Slope</th><th scope=col>HeartDisease</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>40</td><td>M</td><td>ATA</td><td>140</td><td>289</td><td>0</td><td>Normal</td><td>172</td><td>N</td><td>0.0</td><td>Up  </td><td>0</td></tr>\n",
       "\t<tr><td>49</td><td>F</td><td>NAP</td><td>160</td><td>180</td><td>0</td><td>Normal</td><td>156</td><td>N</td><td>1.0</td><td>Flat</td><td>1</td></tr>\n",
       "\t<tr><td>37</td><td>M</td><td>ATA</td><td>130</td><td>283</td><td>0</td><td>ST    </td><td> 98</td><td>N</td><td>0.0</td><td>Up  </td><td>0</td></tr>\n",
       "\t<tr><td>48</td><td>F</td><td>ASY</td><td>138</td><td>214</td><td>0</td><td>Normal</td><td>108</td><td>Y</td><td>1.5</td><td>Flat</td><td>1</td></tr>\n",
       "\t<tr><td>54</td><td>M</td><td>NAP</td><td>150</td><td>195</td><td>0</td><td>Normal</td><td>122</td><td>N</td><td>0.0</td><td>Up  </td><td>0</td></tr>\n",
       "\t<tr><td>39</td><td>M</td><td>NAP</td><td>120</td><td>339</td><td>0</td><td>Normal</td><td>170</td><td>N</td><td>0.0</td><td>Up  </td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 12\n",
       "\\begin{tabular}{llllllllllll}\n",
       " Age & Sex & ChestPainType & RestingBP & Cholesterol & FastingBS & RestingECG & MaxHR & ExerciseAngina & Oldpeak & ST\\_Slope & HeartDisease\\\\\n",
       " <dbl> & <chr> & <chr> & <dbl> & <dbl> & <dbl> & <chr> & <dbl> & <chr> & <dbl> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 40 & M & ATA & 140 & 289 & 0 & Normal & 172 & N & 0.0 & Up   & 0\\\\\n",
       "\t 49 & F & NAP & 160 & 180 & 0 & Normal & 156 & N & 1.0 & Flat & 1\\\\\n",
       "\t 37 & M & ATA & 130 & 283 & 0 & ST     &  98 & N & 0.0 & Up   & 0\\\\\n",
       "\t 48 & F & ASY & 138 & 214 & 0 & Normal & 108 & Y & 1.5 & Flat & 1\\\\\n",
       "\t 54 & M & NAP & 150 & 195 & 0 & Normal & 122 & N & 0.0 & Up   & 0\\\\\n",
       "\t 39 & M & NAP & 120 & 339 & 0 & Normal & 170 & N & 0.0 & Up   & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 12\n",
       "\n",
       "| Age &lt;dbl&gt; | Sex &lt;chr&gt; | ChestPainType &lt;chr&gt; | RestingBP &lt;dbl&gt; | Cholesterol &lt;dbl&gt; | FastingBS &lt;dbl&gt; | RestingECG &lt;chr&gt; | MaxHR &lt;dbl&gt; | ExerciseAngina &lt;chr&gt; | Oldpeak &lt;dbl&gt; | ST_Slope &lt;chr&gt; | HeartDisease &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 40 | M | ATA | 140 | 289 | 0 | Normal | 172 | N | 0.0 | Up   | 0 |\n",
       "| 49 | F | NAP | 160 | 180 | 0 | Normal | 156 | N | 1.0 | Flat | 1 |\n",
       "| 37 | M | ATA | 130 | 283 | 0 | ST     |  98 | N | 0.0 | Up   | 0 |\n",
       "| 48 | F | ASY | 138 | 214 | 0 | Normal | 108 | Y | 1.5 | Flat | 1 |\n",
       "| 54 | M | NAP | 150 | 195 | 0 | Normal | 122 | N | 0.0 | Up   | 0 |\n",
       "| 39 | M | NAP | 120 | 339 | 0 | Normal | 170 | N | 0.0 | Up   | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "  Age Sex ChestPainType RestingBP Cholesterol FastingBS RestingECG MaxHR\n",
       "1 40  M   ATA           140       289         0         Normal     172  \n",
       "2 49  F   NAP           160       180         0         Normal     156  \n",
       "3 37  M   ATA           130       283         0         ST          98  \n",
       "4 48  F   ASY           138       214         0         Normal     108  \n",
       "5 54  M   NAP           150       195         0         Normal     122  \n",
       "6 39  M   NAP           120       339         0         Normal     170  \n",
       "  ExerciseAngina Oldpeak ST_Slope HeartDisease\n",
       "1 N              0.0     Up       0           \n",
       "2 N              1.0     Flat     1           \n",
       "3 N              0.0     Up       0           \n",
       "4 Y              1.5     Flat     1           \n",
       "5 N              0.0     Up       0           \n",
       "6 N              0.0     Up       0           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(heart_failure)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "63853c8e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-05T16:43:32.959475Z",
     "iopub.status.busy": "2023-07-05T16:43:32.957863Z",
     "iopub.status.idle": "2023-07-05T16:43:33.026201Z",
     "shell.execute_reply": "2023-07-05T16:43:33.023925Z"
    },
    "papermill": {
     "duration": 0.07751,
     "end_time": "2023-07-05T16:43:33.029200",
     "exception": false,
     "start_time": "2023-07-05T16:43:32.951690",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 50 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Age</th><th scope=col>count</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>28</td><td> 1</td></tr>\n",
       "\t<tr><td>29</td><td> 3</td></tr>\n",
       "\t<tr><td>30</td><td> 1</td></tr>\n",
       "\t<tr><td>31</td><td> 2</td></tr>\n",
       "\t<tr><td>32</td><td> 5</td></tr>\n",
       "\t<tr><td>33</td><td> 2</td></tr>\n",
       "\t<tr><td>34</td><td> 7</td></tr>\n",
       "\t<tr><td>35</td><td>11</td></tr>\n",
       "\t<tr><td>36</td><td> 6</td></tr>\n",
       "\t<tr><td>37</td><td>11</td></tr>\n",
       "\t<tr><td>38</td><td>16</td></tr>\n",
       "\t<tr><td>39</td><td>15</td></tr>\n",
       "\t<tr><td>40</td><td>13</td></tr>\n",
       "\t<tr><td>41</td><td>24</td></tr>\n",
       "\t<tr><td>42</td><td>18</td></tr>\n",
       "\t<tr><td>43</td><td>24</td></tr>\n",
       "\t<tr><td>44</td><td>19</td></tr>\n",
       "\t<tr><td>45</td><td>18</td></tr>\n",
       "\t<tr><td>46</td><td>24</td></tr>\n",
       "\t<tr><td>47</td><td>19</td></tr>\n",
       "\t<tr><td>48</td><td>31</td></tr>\n",
       "\t<tr><td>49</td><td>21</td></tr>\n",
       "\t<tr><td>50</td><td>25</td></tr>\n",
       "\t<tr><td>51</td><td>35</td></tr>\n",
       "\t<tr><td>52</td><td>36</td></tr>\n",
       "\t<tr><td>53</td><td>33</td></tr>\n",
       "\t<tr><td>54</td><td>51</td></tr>\n",
       "\t<tr><td>55</td><td>41</td></tr>\n",
       "\t<tr><td>56</td><td>38</td></tr>\n",
       "\t<tr><td>57</td><td>38</td></tr>\n",
       "\t<tr><td>58</td><td>42</td></tr>\n",
       "\t<tr><td>59</td><td>35</td></tr>\n",
       "\t<tr><td>60</td><td>32</td></tr>\n",
       "\t<tr><td>61</td><td>31</td></tr>\n",
       "\t<tr><td>62</td><td>35</td></tr>\n",
       "\t<tr><td>63</td><td>30</td></tr>\n",
       "\t<tr><td>64</td><td>22</td></tr>\n",
       "\t<tr><td>65</td><td>21</td></tr>\n",
       "\t<tr><td>66</td><td>13</td></tr>\n",
       "\t<tr><td>67</td><td>15</td></tr>\n",
       "\t<tr><td>68</td><td>10</td></tr>\n",
       "\t<tr><td>69</td><td>13</td></tr>\n",
       "\t<tr><td>70</td><td> 7</td></tr>\n",
       "\t<tr><td>71</td><td> 5</td></tr>\n",
       "\t<tr><td>72</td><td> 4</td></tr>\n",
       "\t<tr><td>73</td><td> 1</td></tr>\n",
       "\t<tr><td>74</td><td> 7</td></tr>\n",
       "\t<tr><td>75</td><td> 3</td></tr>\n",
       "\t<tr><td>76</td><td> 2</td></tr>\n",
       "\t<tr><td>77</td><td> 2</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 50 × 2\n",
       "\\begin{tabular}{ll}\n",
       " Age & count\\\\\n",
       " <dbl> & <int>\\\\\n",
       "\\hline\n",
       "\t 28 &  1\\\\\n",
       "\t 29 &  3\\\\\n",
       "\t 30 &  1\\\\\n",
       "\t 31 &  2\\\\\n",
       "\t 32 &  5\\\\\n",
       "\t 33 &  2\\\\\n",
       "\t 34 &  7\\\\\n",
       "\t 35 & 11\\\\\n",
       "\t 36 &  6\\\\\n",
       "\t 37 & 11\\\\\n",
       "\t 38 & 16\\\\\n",
       "\t 39 & 15\\\\\n",
       "\t 40 & 13\\\\\n",
       "\t 41 & 24\\\\\n",
       "\t 42 & 18\\\\\n",
       "\t 43 & 24\\\\\n",
       "\t 44 & 19\\\\\n",
       "\t 45 & 18\\\\\n",
       "\t 46 & 24\\\\\n",
       "\t 47 & 19\\\\\n",
       "\t 48 & 31\\\\\n",
       "\t 49 & 21\\\\\n",
       "\t 50 & 25\\\\\n",
       "\t 51 & 35\\\\\n",
       "\t 52 & 36\\\\\n",
       "\t 53 & 33\\\\\n",
       "\t 54 & 51\\\\\n",
       "\t 55 & 41\\\\\n",
       "\t 56 & 38\\\\\n",
       "\t 57 & 38\\\\\n",
       "\t 58 & 42\\\\\n",
       "\t 59 & 35\\\\\n",
       "\t 60 & 32\\\\\n",
       "\t 61 & 31\\\\\n",
       "\t 62 & 35\\\\\n",
       "\t 63 & 30\\\\\n",
       "\t 64 & 22\\\\\n",
       "\t 65 & 21\\\\\n",
       "\t 66 & 13\\\\\n",
       "\t 67 & 15\\\\\n",
       "\t 68 & 10\\\\\n",
       "\t 69 & 13\\\\\n",
       "\t 70 &  7\\\\\n",
       "\t 71 &  5\\\\\n",
       "\t 72 &  4\\\\\n",
       "\t 73 &  1\\\\\n",
       "\t 74 &  7\\\\\n",
       "\t 75 &  3\\\\\n",
       "\t 76 &  2\\\\\n",
       "\t 77 &  2\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 50 × 2\n",
       "\n",
       "| Age &lt;dbl&gt; | count &lt;int&gt; |\n",
       "|---|---|\n",
       "| 28 |  1 |\n",
       "| 29 |  3 |\n",
       "| 30 |  1 |\n",
       "| 31 |  2 |\n",
       "| 32 |  5 |\n",
       "| 33 |  2 |\n",
       "| 34 |  7 |\n",
       "| 35 | 11 |\n",
       "| 36 |  6 |\n",
       "| 37 | 11 |\n",
       "| 38 | 16 |\n",
       "| 39 | 15 |\n",
       "| 40 | 13 |\n",
       "| 41 | 24 |\n",
       "| 42 | 18 |\n",
       "| 43 | 24 |\n",
       "| 44 | 19 |\n",
       "| 45 | 18 |\n",
       "| 46 | 24 |\n",
       "| 47 | 19 |\n",
       "| 48 | 31 |\n",
       "| 49 | 21 |\n",
       "| 50 | 25 |\n",
       "| 51 | 35 |\n",
       "| 52 | 36 |\n",
       "| 53 | 33 |\n",
       "| 54 | 51 |\n",
       "| 55 | 41 |\n",
       "| 56 | 38 |\n",
       "| 57 | 38 |\n",
       "| 58 | 42 |\n",
       "| 59 | 35 |\n",
       "| 60 | 32 |\n",
       "| 61 | 31 |\n",
       "| 62 | 35 |\n",
       "| 63 | 30 |\n",
       "| 64 | 22 |\n",
       "| 65 | 21 |\n",
       "| 66 | 13 |\n",
       "| 67 | 15 |\n",
       "| 68 | 10 |\n",
       "| 69 | 13 |\n",
       "| 70 |  7 |\n",
       "| 71 |  5 |\n",
       "| 72 |  4 |\n",
       "| 73 |  1 |\n",
       "| 74 |  7 |\n",
       "| 75 |  3 |\n",
       "| 76 |  2 |\n",
       "| 77 |  2 |\n",
       "\n"
      ],
      "text/plain": [
       "   Age count\n",
       "1  28   1   \n",
       "2  29   3   \n",
       "3  30   1   \n",
       "4  31   2   \n",
       "5  32   5   \n",
       "6  33   2   \n",
       "7  34   7   \n",
       "8  35  11   \n",
       "9  36   6   \n",
       "10 37  11   \n",
       "11 38  16   \n",
       "12 39  15   \n",
       "13 40  13   \n",
       "14 41  24   \n",
       "15 42  18   \n",
       "16 43  24   \n",
       "17 44  19   \n",
       "18 45  18   \n",
       "19 46  24   \n",
       "20 47  19   \n",
       "21 48  31   \n",
       "22 49  21   \n",
       "23 50  25   \n",
       "24 51  35   \n",
       "25 52  36   \n",
       "26 53  33   \n",
       "27 54  51   \n",
       "28 55  41   \n",
       "29 56  38   \n",
       "30 57  38   \n",
       "31 58  42   \n",
       "32 59  35   \n",
       "33 60  32   \n",
       "34 61  31   \n",
       "35 62  35   \n",
       "36 63  30   \n",
       "37 64  22   \n",
       "38 65  21   \n",
       "39 66  13   \n",
       "40 67  15   \n",
       "41 68  10   \n",
       "42 69  13   \n",
       "43 70   7   \n",
       "44 71   5   \n",
       "45 72   4   \n",
       "46 73   1   \n",
       "47 74   7   \n",
       "48 75   3   \n",
       "49 76   2   \n",
       "50 77   2   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "heart_failure %>%\n",
    "group_by(Age)%>%\n",
    "summarize(count =n())\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "e18a3ea7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-05T16:43:33.041836Z",
     "iopub.status.busy": "2023-07-05T16:43:33.040275Z",
     "iopub.status.idle": "2023-07-05T16:43:33.588789Z",
     "shell.execute_reply": "2023-07-05T16:43:33.586067Z"
    },
    "papermill": {
     "duration": 0.557955,
     "end_time": "2023-07-05T16:43:33.591761",
     "exception": false,
     "start_time": "2023-07-05T16:43:33.033806",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nO3deXzcdZ348c/cudo0JUChIFAKFMohsCtWRS5R0cUDqghaCkjl0ojUVX8cC1pQ\nUSgYRFAQF12OKq7igYosS9EFlEO5sUDlkHIU2qZJmnvm90dqChTKtE3mm/n0+fyDR78zX5L3\nZz5J+uo3k0mqVCoFAACqXzrpAQAAGB7CDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEtmkB1gLnZ2dvb29SU8xPNLp9JgxY0IIHR0dAwMDSY8zPAYXtXz58mhe9TqTyTQ0NIQQ\n2tvbi8Vi0uMMj8FFtbW1JT3IsMnlcnV1dSGEmD72stlsXV3d8uXLkx5k2OTz+dra2lKpFNOi\ncrlcTU1Ne3t70oMMm0KhUFNTUywWY1pUPp/P5XKdnZ1JDzKcmpqaXu+uagq7YrEYTQOFENLp\ndIhrUaVSKZ1OF4vFaBoonU7Ht02pVCqdTkeznBBCJpMZ3KaBgYFowm7wYy+mbRr8+hBCiGlR\n2Ww2lUrFtKIot6lUKkW2TWvmW7EAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQ\ndgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACR\nEHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAA\nkRB2AACREHYAAJEQdgAAkRB2AACRyCY9AECcWlpayjyztbV1RCcBNhyu2AEARELYAQBEQtgB\nAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEokIvUPz87afN+tr9L7/luCt//P6mmhCKt1z7\nnV/ees/T7Zkdd97rqJajt6nNVGYkAIDIVCjslv11We1GB3921tShWybV50MIC396+gXznpxx\n0qePaer/1XcvPu2U/qsuOT5VmZkAAOJSobB74aHl43Z629veNvUVt5Z65857ePKMudPftU0I\nYfK54SMzv3nNszOO2Ky+MlMBAMSkQs+xu3d5T9Pu4wa6lj/3wrLSP2/sabv1qe6Bg/bffPCw\n0LT3bg35O+c/X5mRAAAiU6Erdn/p6Cv+sfWjFz3SVypl6zd+zxGfPe7gXXs77wsh7FS3aoap\nddkbH2gbOrzvvvuOOeaYocM5c+YcdNBBlRm4YsaNG5f0CMNs/PjxSY8w/JqampIeYZg1Nzcn\nPcLw22ijjZIeYR293nZEuU3xLSq+FaXT6fgWFdOKBgYG1nBvJcJuoPeZtlRm6/HTzr16TuPA\n8jt+ffn5l51e2O6HH853hhCac6t+WqI5l+lb3leBkQAA4lOJsMvkJ1533XX/PGre5/AvLbjx\nsJsvf+DQz9WFEJb0FSfkV35H+MW+gWzTqpG22GKLU089dehw8uTJHR0dFRi4AtLpdF1dXQih\nq6trzeldRVKpVH19fWdnZ6lUeuOzq0Emk6mtrQ0hrFixolgsJj3O8Bj82IvmUymEkM1ma2pq\nQgjV+7G3+nZkMpmamprOzs5E5hkJuVyuUCiE11ps9cpms/l8fsWKFUkPMmzy+Xw+ny+VSpF9\n7GWz2a6urqQHGTalUmnMmDGvd2+FvhX7KntuUnvz0sW5ul1CmP9IV9+EfGHw9gVd/Y1TG4dO\nGz9+/CGHHDJ02N7e3t3dXelZR0YmkxkMu56env7+/qTHGR7pdLq+vr6npyeaBsrlcoNh19PT\nE01/Z7PZurq6aD6VQgj5fH4w7Lq7u6s07FbfjlwuV1NTE9M2hRAGwy6mRRUKhVwuF9OKUqnU\nYNjFtKgQQjqdjmxFawi7SvzwxLIFF3/y2JOe7/3nX/algfnPrhi30/Y14/abmM/ccNviwZv7\nOu65q713j/0mVGAkAID4VCLsxk46bKMVz3/xy9+964EFjz7412su/MKtnWM+dez2IZWbPX3K\no98/6+Z7FixaeP/lZ8ytn3jgjM291gkAwLqoxLdi09nmORd/+QeXXvWts0/tzo6dNHnnL174\nld0bciGEyYedfWLPhVfPPeOl7tS2u+0zZ/Ysr04MALBuKvQcu0LT1OP/31ePX/2OVObAmbMP\nnFmZKQAAYlahFygGAGCkCTsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCA\nSAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsA\ngEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7\nAIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgI\n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\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEtmkBwBIXktLS5lntra2jugkAOvDFTsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsA\ngEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEhkkx5gLdTW1o4ZMybpKYbZuHHjkh5h\nmI0fPz7pEYZfU1NT0iMMs+bm5qRHGH4bbbTRq2454ogjhv29JPvQlf/eR+jM8h/Sq6++ej3f\n3erW/72PhPg+m9LpdHyLimlFAwMDa7i3msKup6eno6Mj6SmGRyaTGYzU9vb2Ne9QFUmn02PH\njm1rayuVSknPMjyy2WxDQ0MIYfny5cViMelxhsfgx96yZcuSHmTY5HK5+vr6EEJlPvaSfejK\nf+/Jnrn6yfl8vq6ubm3fyDqrzHvJ5XK1tbXLly+vwPuqjEKhUFtbWywWI1tULpeLph9CCKVS\naQ2XG6op7IrFYn9/f9JTDI+hv34GBgaiWVQ6nQ4hDAwMRNNAqVRq8A8DAwPR9PegaD7qwj8/\n8EII/f39FQi7ZB+68t97smeufnI2m12HN7LOKvNeMplMqVSK6bMpl8sN/iGmRWWz2Ww2G9OK\n1sxz7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHs\nAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh\n7AAAIiHsAAAiIewAACIh7AAAIpFNegCAatLS0pL0CACvyxU7AIBICDsAgEgIOwCASAg7AIBI\nCDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBIZJMeAIAItbS0\nlHlma2vriE4CGxRX7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewA\nACIh7AAAIiHsAAAiIewAACKRTXoAIGZ+EzxvqPwPEuANuWIHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEIkKvUBx7/IFl7Vefvv9CzuL2a223+Ow406c9qaGEEIIxVuu\n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\nDQYbKISQy+WqtBhWN7ioUdips2bNKvPMK6+88uWHQ9uUz+erdJvy+XxVnEmZbGhVWKsHaubM\nmeWc9qqvTiNk8KJDKpWKaa/T6XQ6nY5pRcVicQ33VlMn9fb29vT0JD3F8MhkMk1NTSGEjo6O\n/v7+pMcZHul0evz48e3t7Wv+mBvN2traXn6Yy+UaGxtDCO3t7QMDAwkNtV5etaJReyZlsqFV\nYSQeqMo8+LW1tfX19cViMaa9rqmpKRQKMa0ohFAoFF7vrki+swkAgLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\niISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIRDbp\nAWAUaWlpSXoEIAZlfjFpbW2N772TLFfsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHs\nAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh\n7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIpFNegCq\nWEtLSzmntba2DvvbBABW54odAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0A\nQCQq/QLF/3nCzJqvXPqxjWv/eUPxlmu/88tb73m6PbPjznsd1XL0NrWZCo8EABCHSl6xKz32\nxyt+tmhZf6k0dNPCn55+wbzbpx0y68yTj6x7/KbTTrmstIY3AADA66vQFbvn/nDh6d/7vxfa\nel5xa6l37ryHJ8+YO/1d24QQJp8bPjLzm9c8O+OIzeorMxUAQEwqdMVu/K7Tv3Tm184794sv\nv7Gn7danugcO2n/zwcNC0967NeTvnP98ZUYCAIhMha7Y5Ru3mNwYBnprXn5jb+d9IYSd6lbN\nMLUue+MDbUOHDz744Gc+85mhw1NPPfWAAw4Y+WErqrGxMekRRtxGG22U9AgbrvIf/GTPpEw2\ntCpUy4P/em8znU5HttepVCqmFQ0MDKzh3kr/8MTLFXs6QwjNuVU/LdGcy/Qt7xs6HBgYWL58\n+dBhX19fKpWq5IQVEN+KVrchrHHUKv/BT/ZMymRDq8IIPfhHHHFEOWdeffXV6//e49vrmFa0\n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\noVCoq6uLaUW1tbWDYRfTompqagqFQkwrCiGsIeyS/OGJmnH7Tcxnbrht8eBhX8c9d7X37rHf\nhARHAgCoXom+3EkqN3v6lEe/f9bN9yxYtPD+y8+YWz/xwBmb1yc5EgBA1Ur4N09MPuzsE3su\nvHruGS91p7bdbZ85s2elkh0IAKBqJf0rxVKZA2fOPnBmwlMAAEQg4V8pBgDAcBF2AACREHYA\nAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2\nAACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQ\ndgAAkRB2AACREHYAAJEQdgAAkcgmPcAGqqur6+GHHw4hbLXVVoVCIelxhk1fX1+pVEp6imGz\nfPnyBx98MIQwadKkbDaST5ZSqdTX15f0FMNp6dKlDzzwQAhh8uTJ6XQk/1iNb5teeOGF++67\nL4Sw/fbbJz3LsCkWi5Ft06JFixYvXpzNZidNmpT0LMOmWCz29/cnPUXlpGL6a7iKPPHEE9On\nTw8hXHnllVOnTk16HF7bX//612OPPTaEcP3110+cODHpcXhtt9xyy+c///kQwvz58+vr65Me\nh9d2/fXXz5kzJ5vN3nHHHUnPwuu68sorL7rooubm5t/+9rdJz8I6iuRftwAACDsAgEgIOwCA\nSHiOXTJWrFhx2223hRDe8pa3jB07NulxeG3Lli276667Qghvf/vba2trkx6H1zb0rPx99903\nmp9xic+iRYseeuihdDq9//77Jz0Lr+uJJ5547LHH8vn8O9/5zqRnYR0JOwCASPhWLABAJIQd\nvLae5W1dRdezAagmno9SIb3LF1zWevnt9y/sLGa32n6Pw447cdqbGkIIIRRvufY7v7z1nqfb\nMzvuvNdRLUdvU5tJeFZC6F76p1nHfO0dl1x13ITB10WzTaPI87efNutr97/8luOu/PH7m2ps\n02jz9/+77qobbnvob880brHjocd+9l07N4UQbNPo0f7M+R8/Yf6rbszX73bdNXNsU/XyHLvK\nKF147OF3Nex10iff15zu/N95F/3mkfrLrm5tzqYX/vTUz/3XkzNO+vSOTf2/+u7F92b2veqS\n41NJj7uBKxW7v3X8UTc/t+L937tmMOxs06jyt0tO+o8/v/mzs1a9svekf3nrhLzPptHlxbuv\n+ORXfvXeo0/cZ8fNFtxy5X/euPirP7psp7qsbRo9BroW/OkvL778ljuuaH106omXfO6dtqmK\nlRh53cv+5+CDD75lWffgYV/ngwcffPC3n2kvFXtO+siHTvnpwpWnLbn14IMPvmpRR3KTUiqV\nSn+54pRPzL7k4IMPvvTZjlKpZJtGm1s//YlPfeOBV99qm0aZLx9x6KcvG9qmgQvOPP3y+5fY\nptFs2d+uOfRjX3qpr2ibqprn2FVCOtt8zDHH7DU2v/I4lQ0h1GXSPW23PtU9cND+mw/eXGja\ne7eG/J3zn09qTkIIyx/72dm/6TrjzEOHbrFNo829y3uadh830LX8uReWDX3HwTaNKr3tt9/V\n3vv+Q7f95w3pk8+a88mdm2zTqFUaaJ/75evef9oXxmdTtqmqeY5dJeTqd/3Qh3YNISz965/+\n8vwLd/1u3sZTD56xSV3XovtCCDvVrdqFqXXZGx9oS2zQDV6x97mvnvFf7/3id7erW/Vskt5O\n2zS6/KWjr/jH1o9e9EhfqZSt3/g9R3z2uIN3tU2jSu/yO0MImz746y9e86vHn+vadKtt/+3I\nzxz05gm2adRa+LM5jzd/+Ms7NwVf9KqcsKuo52/9/a8efeapf3S949BJqRCKPZ0hhObcqoZo\nzmX6lvclN+CG7rffPH3JHicdu2dzaWDp0I22aVQZ6H2mLZXZevy0c6+e0ziw/I5fX37+ZacX\ntvvhh/O2aRQZ6FkeQvjGd/7w0U+dcMymhYfn//jSM0/o+faP9uuzTaNRsffZc6559JDWM1ce\n+qJXzYRdRU1pOX1uCB1P33FCy9fnTNxp9vZ1IYQlfcUJ+ZXfE3+xbyDbZFOS8cIdF1/x0IRL\n/3PfV92eLtimUSSTn3jdddf986h5n8O/tODGw26+/IFDP2ebRpF0NhNC2Pc/zvzwlKYQwg47\n7rbo9o/+/DsPHPBp2zQaPX3D3I6G/Q+ZOPgiAL7oVTfPsauE5Y/94de/+/PQYcOWb/23jWqe\nvOnZXN0uIYRHulb9M2hBV3/j1MYERiSExX+4r7f9vmMO/dAHPvCBD354Zgjh1586fPrhZ9im\nUW7PTWr7li+2TaNKtm67EMLbVr6oUwghvHWzup4XF9mmUal05U/+Pvnjhwwd26aqJuwqoa9r\n/vcuveDFvuLK41L/gyv6695UXzNuv4n5zA23LV55Wsc9d7X37rHfhMQG3bBte+Spc//p/PPO\nCiG8/bRzvvHVE2zTqLJswcWfPPak53uHPpsG5j+7YtxO29umUaWm6T1N2fTNC5avPC4N3PLM\nijHbbmubRqEVL/zk7o6+T75z1S7YpqqWOeuss5KeIX4146f8+efX37CgfYuNxnS++I8brznv\nfx7rPfH0I7esyU8p3nvtVTdsMnlKoWvRNV8/79m6d37l8Hd4raBEZBvGjR8yrubaeT/fdcas\nA7fcKKQytmn0yDdOuu3H866/d8kWmzZ2Ln76xqvOv+Hx0ilzZm5WyNmm0SOVLuzQc/cV3/99\nzYRNst0v/s9V5/9qwYqTzv7klrW+6I06T/7ku7c8s+NxH33nqpt80atmXqC4Qjqf/vPF37v6\nr397uquU22q73T901PH7bt8YQgilgd//8MJ5v//zS92pbXfb5/jZsybXeR5D8koDSz/44ZlD\nL1Bsm0aVnqUP/uDSq/7v3gXd2bGTJu/84U8e99YtbdPoU+r/3Y9af/r7P7/Um99q2x3/beaJ\n++/gi95o9P2jD7tt6y9+/8w9XnGrbapawg4AIBKeYwcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhB7BSaaBtm9pcKpXa8sDrkp4FYF0IO4CVXrh79hPd/SGEZ/9w8pJ+L94O\nVB9hB7DS7065IZVKnfOpHQZ6npl91wtJjwOw1vxKMYAQQhjo/ccmDVv1bfqZZ/+8Y8Pmx2/2\ntisX/d+RSQ8FsHZcsQMIIYRF//vZJX3F3c44vn6z4w4YV/PCnacs6i2+/IRn/3jlYe975xbj\n6jbeYuqJ593wxPUHpFKp5/pWntPx5K0nf+w9b9p4XKF+/JTd9//yd28ovtZ7ARhRrtgBhBDC\nBbs0z35w2R+XrXjb2Pz/fWrHd1z2yEdv+se8AyYO3rvkvm9ts+cpA5u+7ahPvKuw9NEf/eDa\nuqljn/zr0md7Bybk0p2Lfr7b5I8+lZr48aOnT27O3HvLT34yf+Gbj/zBX648KtE1ARscYQcQ\n+lc8MHbMrvmtT132+NkhhOVPfrVx69M2fvO3X/jLSYMnHLPFmKvbp9777B93qMuGEF68++JN\n/vUzpVJpMOy+vHPzOX/fZP5T90zbqGbw/J/P3v3Dc/969uPLTpvUmNSigA2Qb8UChCev/1xX\nsbTnV44aPBz7pi/s0ZB/6f4vPdY9EELoXvLLHzzTsdPJlwxWXQihec+TTn/TmME/9694cM5D\nS6accOVQ1YUQ3vcf3wohzLtkQSVXAZBNegCA5F1x2p0hhC0fv+7883ODt0wdV7ino/3kG//x\nqw9s1fXif4cQtv3om17+vxyw18ZznlweQuhe8puBUun+89+SOv/Vb7bt/rYKDA8wRNgBG7qe\ntvnnPrE8hHDlmf/vVXfd/sVrwwe+WCr2rP5/pbKplX9K50MIu3zhim/uv/mrzik0vnnYpwVY\nA9+KBTZ0j135/wZKpXd+75HSyxX7po0tLF1w5r2dfTVNB4QQFv730y//v/7vTy8O/qFm/Psy\nqVT/sh3e8zIHvHOrZcuWpbauS2A9wAZM2AEburlfuy+VLlx4+KRX3JrKfvOISaVizyk/f7Ju\nk5kfbK598LyTFnb1D9655P7Lzli48tus2ZrJZ+00/tEfzfyf51YM/d/XnPTBww8//ClfYoHK\n8lOxwAat68Wf1G380eZd5y6+93Ovuqvz2UsbNj+hcZtTly0858V7Lpzy1s/3bLb3rJnvLix7\n9IeXXfuW3Rp+/qfFbf3FsZlUx1M/nrr9x5/NbPnhj31gz+3GP3DzvB/9/qFdjvrRfT/4RCKL\nAjZYwg7YoN192pv/5av3fux//nHN/hNXv/eQjet+/lLvrctWvGNsfukD1x3T8o0//umB3Ba7\nf/YbV+z53Xe/+8bFxf6VV+naFvzui1/82vW33L2kNz9p+50OO+m00z/53qGn4QFUhrADeEOl\nu+++J9+4/S6TxwzddPkOG7W8OG3FS79KcCyAVxF2AG/srY01Dzee1PbUylc06V/x0Fbjd82/\n+xd//8X7kh0M4OW83AnAG7v09H12/8LcdxxVe9xBu6fan7p27leeGxhz7ff2TXougFdwxQ6g\nLL9u/fezL7/+4cee6C+Mf/Pb3vPZs877yL9unPRQAK8g7AAAIuFFlgAAIiHsAAAiIewAACIh\n7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACLx/wGUZ1LWIu5MoAAAAABJRU5ErkJggg=="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "heart_failure %>%\n",
    "group_by(Age)%>%\n",
    "summarize(count =n()) %>%\n",
    "ggplot() +\n",
    "geom_col(aes (x=Age, y=count))\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "7d96629a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-05T16:43:33.606906Z",
     "iopub.status.busy": "2023-07-05T16:43:33.605377Z",
     "iopub.status.idle": "2023-07-05T16:43:33.638395Z",
     "shell.execute_reply": "2023-07-05T16:43:33.636181Z"
    },
    "papermill": {
     "duration": 0.04245,
     "end_time": "2023-07-05T16:43:33.640817",
     "exception": false,
     "start_time": "2023-07-05T16:43:33.598367",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>Sex</th><th scope=col>count</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>F</td><td>193</td></tr>\n",
       "\t<tr><td>M</td><td>725</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " Sex & count\\\\\n",
       " <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t F & 193\\\\\n",
       "\t M & 725\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 2 × 2\n",
       "\n",
       "| Sex &lt;chr&gt; | count &lt;int&gt; |\n",
       "|---|---|\n",
       "| F | 193 |\n",
       "| M | 725 |\n",
       "\n"
      ],
      "text/plain": [
       "  Sex count\n",
       "1 F   193  \n",
       "2 M   725  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "heart_failure %>%\n",
    "group_by(Sex)%>%\n",
    "summarize(count =n())\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "78559add",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-05T16:43:33.654950Z",
     "iopub.status.busy": "2023-07-05T16:43:33.653444Z",
     "iopub.status.idle": "2023-07-05T16:43:33.940874Z",
     "shell.execute_reply": "2023-07-05T16:43:33.938102Z"
    },
    "papermill": {
     "duration": 0.297667,
     "end_time": "2023-07-05T16:43:33.943800",
     "exception": false,
     "start_time": "2023-07-05T16:43:33.646133",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\nwQYAAAAASUVORK5CYII="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "heart_failure %>%\n",
    "group_by(Sex)%>%\n",
    "summarize(count =n()) %>%\n",
    "ggplot() +\n",
    "geom_col(aes (x=Sex, y=count))\n",
    "\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "3354990c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-05T16:43:33.958366Z",
     "iopub.status.busy": "2023-07-05T16:43:33.956827Z",
     "iopub.status.idle": "2023-07-05T16:43:33.995800Z",
     "shell.execute_reply": "2023-07-05T16:43:33.993929Z"
    },
    "papermill": {
     "duration": 0.049478,
     "end_time": "2023-07-05T16:43:33.998959",
     "exception": false,
     "start_time": "2023-07-05T16:43:33.949481",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 4 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>ChestPainType</th><th scope=col>count</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>ASY</td><td>496</td></tr>\n",
       "\t<tr><td>ATA</td><td>173</td></tr>\n",
       "\t<tr><td>NAP</td><td>203</td></tr>\n",
       "\t<tr><td>TA </td><td> 46</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 4 × 2\n",
       "\\begin{tabular}{ll}\n",
       " ChestPainType & count\\\\\n",
       " <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t ASY & 496\\\\\n",
       "\t ATA & 173\\\\\n",
       "\t NAP & 203\\\\\n",
       "\t TA  &  46\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 4 × 2\n",
       "\n",
       "| ChestPainType &lt;chr&gt; | count &lt;int&gt; |\n",
       "|---|---|\n",
       "| ASY | 496 |\n",
       "| ATA | 173 |\n",
       "| NAP | 203 |\n",
       "| TA  |  46 |\n",
       "\n"
      ],
      "text/plain": [
       "  ChestPainType count\n",
       "1 ASY           496  \n",
       "2 ATA           173  \n",
       "3 NAP           203  \n",
       "4 TA             46  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "heart_failure %>%\n",
    "group_by(ChestPainType)%>%\n",
    "summarize(count =n())\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "95f6709a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-05T16:43:34.014133Z",
     "iopub.status.busy": "2023-07-05T16:43:34.012546Z",
     "iopub.status.idle": "2023-07-05T16:43:34.240355Z",
     "shell.execute_reply": "2023-07-05T16:43:34.238564Z"
    },
    "papermill": {
     "duration": 0.237921,
     "end_time": "2023-07-05T16:43:34.242654",
     "exception": false,
     "start_time": "2023-07-05T16:43:34.004733",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nOzde5zUVf348TOXvbC7wAKLooCIoKCokJqGaYhppWlZongJr1+8FpmaWmDitfxm\naJh3tLtKaqam9U1/3io1NcpLSqCUdxEEFhb2Mjszvz9WF5RlWITdWY7P5x8+Zj7nw+x753EY\nX8xlN5HP5wMAABu/ZLEHAABgwxB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACR\nSBd7gA2gubl52bJlxZ5i45ZMJrt37x5CWL58eXNzc7HHoSvq0aNHIpGor69vamoq9ix0RVVV\nValUqqmpqb6+vtiz0BV169attLS0ubl5+fLlxZ5lo9erV681LcUQdvl8PpvNFnuKjVs+n08m\nkyGEXC7nzqRNyWQykUj468aaJBKJlocRO4Q1aXkYsUM6lJdiAQAiIewAACIh7AAAIiHsAAAi\nIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAA\nIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAike6cLzP/8ckTv//cqkdO/Plv\nvtirPITcw7defc+js15bltp2+92OmXTs4G6p908psAQAwId1Utgt+eeSbn0O/ObEEa1Htqos\nDSHMu2PK5TNfmXDq14/r1fz7666afHrzr685KRFC4SUAAFbXSWH3zgtLq7fbfffdR3zgaL5p\n2swXh06YNm6fwSGEoZeGQ47+4S1vTThis8pCSwAAtKWT3mP3zNLGXp+oztYvffudJfn3DzbW\nPvpqQ3a/vTdvuVrWa8+RVaVPPTK/8BIAAG3qpGfs/lGXyf1l+qFXzs7k8+nKvp8/4psnHrhj\n0/JnQwjbVaycYURF+k/P14YQCiy1uOeeexYtWtRyuU+fPmPHju2cbyRWicR7r3KXlZWl0520\nK9gYlZaWtu4WWFUymQwhpFKpbt26FXsWuqKW/7kkk0k7ZD3l8/kCq53xv/Bs0xu1idSWvUdf\nevOFPbNLn7h3xo9umFK29S++Uro8hFBTsvIjETUlqczSTAgh17jGpRYzZ86cPXt2y+VRo0Yd\ncMABnfCNfByUl5cXewS6tNLS0tLS0mJPQddVUlJSUlJS7CnoulKpVGWld1Wtl2w2W2C1M8Iu\nVdr/9ttvf/9azZjDz5nzp/EPznj+4G9VhBAWZXL9St97RXhhJpvulQ4hJMvWuNRik002WbZs\nWcvlvn37Fv4maY9UKhVCyOVyhf8pwMeWHUJhyWQykUjk8/lcLlfsWeiK7JANJZfLtTwgt6k4\nL7rtvEm3BxcvKKnYIYRHZtdn+pWWtRyfU9/cc0TPEEKBpRbTpk1rvZzJZBYvXtyJ40comUz2\n7t07hLBs2bJMJrPW8/kY6tOnTyKRWLFiRUNDQ7FnoSuqrq5Op9ONjY11dXXFnoWuqKqqqry8\nvLm5uba2du1nU1BNTc2aljrjwxNL5lx1/P+cOr/p/ULPZx95a0X1dtuUV4/tX5q677EFLYcz\ndbOeXta009h+IYQCSwAAtKkzwq7HVuP7rJh/9vnXPf38nLn/+uctV5z16PLuJ/zPNiFRcsa4\n4XNvnPrgrDlvzntuxrnTKvvvO2HzyhBCoSUAANqS6Jy3yzQu/tdPr/31X5+Z05DusdXQ7b9y\n/ImfGlgZQgj57P2/uGLm/U++25AYMnLMSWdMHNr6SdgCSx+UyWQ8r7ueWl+Kra2t9VIsbWp5\nKbaurs5LsbSp5aXYhoYGL8XSppaXYv0ve4Mo8FJsJ4Vdh+qIXTJp0qQNe4N0ZdOnTy/2CBsB\nYUdhwo7ChN0GVOT32AEA0AmEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQd\nAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSE\nHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAk\nhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBA\nJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0A\nQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQd\nAEAkhB0AQCTSxR5gA0gkEtXV1cWego2Y/dMeiUQihFBRUVFeXl7sWeiKUqlUCKG0tNRfKNqU\nTCZDCOl02g5ZT7lcrsBqDGGXz+cbGxuLPQUbsYaGhmKPsBGorKxMJBKZTCaTyRR7Frqibt26\npVKpbDbrAZk2lZWVJZPJXC7nIXc95fP50tLSNa3GEHbB/5hZP/ZPe1RWVoYQMpmMu4s2tTyV\nm81m7RDalE6nS0pKhN0G0b179zUteY8dAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQd\nAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSE\nHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAk\nhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBA\nJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0A\nQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQd\nAEAkhB0AQCSKEHaNS2vrc/nO/7oAAHFLd/LXa1j8t4nHfX+Pa359Yr/KEEIIuYdvvfqeR2e9\ntiy17fa7HTPp2MHdUu+fW2AJAIAP69Rn7PK5hmvPvrw2m2s9Mu+OKZfPfHz0Vyeed9pRFS8/\nMPn0G/LtWAIAYHWdGnbP/Hzy33vstfJ6vmnazBeHTrho3D6jR+y852mXnlr3xn23vLV8LUsA\nALSl88Ju6Ut3XvSH+nPPO7j1SGPto682ZPfbe/OWq2W99hxZVfrUI/MLLwEA0KZOeo9drunt\nS8791RfOvm7ripXvk2ta/mwIYbuKlTOMqEj/6fnawkstnnzyyaVLl7ZcrqqqGjFiRAd/B8Ss\nrKys2CNsNNLptLuLNiUSiRBCKpWyQ2hTKpUKISSTSTtkPeXzhd6b1klh98cfTlm006n/s3NN\nPru49WCucXkIoaZkZerVlKQySzOFl1pMnz599uzZLZdHjRo1Y8aMDv4OiFn37t2LPcJGo7y8\nvLy8vNhT0HWVlJSUlJQUewq6rlQq5SF3PWWz2QKrnfFS7DtPXHXTC/0uOW2vD3/tsooQwqLM\nys9SLMxk01XpwksAALSpM1JpwZ+fbVr21nEHH9R65N4TDr+/cuSvrt4zhEdm12f6lb73rOyc\n+uaeI3qGEEoqdljTUovrrruutVjz+fy7777bCd8IsbJ/2qN3796JRGL58uUNDQ3FnoWuqGfP\nnul0uqGhYflyH3SjDVVVVWVlZZlMpvWdVHxkffr0WdNSZ4TdkKO+O+0r772Kms8tPePMqZ+e\nfPEhm/Qpr+7bv/Sa+x5bsNd+A0IImbpZTy9rGje2XwihvHrsmpZaVFZWtl7OZDK1tbUBPqrC\n71dgVfl83t1FYXYIbWrdGHZIh+qMsCvfdNDQTd+73PIeu+pBW23VrzKEcMa44d++ceqDm541\nvLrxriunVfbfd8LmlSGEkChZ4xIAAG0p8rvWho6/6JTGK26edu67DYkhI8dceMbERDuWAABY\nXSKCZ0Q74qXYSZMmbdgbpCubPn16sUfYCPTp0yeRSNTV1XmPHW2qrq5ueY9dXV1dsWehK6qq\nqiovL/fuqQ2ipqZmTUud+psnAADoOMIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEuliD7ABJBKJ7t27F3sKNmL2T3skEokQQnl5eUlJSbFnoStKJpMhhJKS\nEn+haFM6nQ4hpFIpO2Q95fP5AqsxhF0IIZfLFXsENmL2T/vl83l3FwXYIayVHbKeCt+BMYRd\nPp9fvnx5sadgI2b/tEd5eXkikWhsbGxoaCj2LHRFJSUlyWSyubnZXyjalEgkUqlUNpu1Q9Zf\nZWXlmpa8xw4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLC\nDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACAS\nwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLpzvkyTUvn3DB9xuPPzVueSw/aZqfxJ54yeouqEEIIuYdvvfqeR2e9tiy17fa7HTPp2MHd\nUu//oQJLAAB8WOc8Y5e/+vTvPb5ws1OnXPy/U8/aLvXi/555zsLmXAhh3h1TLp/5+OivTjzv\ntKMqXn5g8uk35N//MwWWAABYXWeEXWPtQw++s2Li+aeM3mHY1iN2Ou6cb2cbXp35zoqQb5o2\n88WhEy4at8/oETvvedqlp9a9cd8tby0PIRRaAgCgLZ3xUmwyXXPcccft1qP0veuJdAihIpVs\nrH301YbspL03bzlc1mvPkVU/fuqR+UcctlWBpZYj77zzTiaTee/2k8ny8vJO+EaIVSrlVf72\nSiaT7i4KSCQSdghtSiQSwQ7ZEPL5Qi9hdkbYlVTueNBBO4YQFv/zb/+Y/87T/zez74gDJ2xS\nUf/msyGE7SpWzjCiIv2n52tDCE3L17jU4vTTT589e3bL5VGjRs2YMaMTvhFi1atXr2KPsNGo\nqKioqKgo9hR0XWVlZWVlZcWegq4rnU57yF1P2Wy2wGonfXiixfxH7//93Ddefb1+j4O3SoSQ\na1weQqgpWVnuNSWpzNJMKLgEAECbOjXshk+aMi2EuteeOHnSDy7sv90Z21SEEBZlcv1K33ur\n38JMNt0rHUJIlq1xqcWFF17Y0NDQcrm0tHTJkiWd+Y0QGfunPXr27JlIJOrr6xsbG4s9C11R\n9+7dU6lUY2NjfX19sWehK6qoqCgtLW1ubq6rqyv2LBu3fD5f4FnPzgi7pS/9+c8vl33x87u2\nXK0a+KkD+pT/8YG3SkbtEMIjs+sz/Urfe95+Tn1zzxE9QwglFWtcajF48ODWy5lMprZ25au0\nsK6am5uLPcJGI5vNurtoU8v7fvL5vB1Cm3K5XLBDOl5nfCo2U//I9ddevjCTe+96vvlfK5or\ntqgsrx7bvzR132ML3jutbtbTy5p2GtsvhFBgCQCANnVG2PUafsLgksZzvn/jrOfnvPTCM7dO\nP+vZ+m5fO2zLkCg5Y9zwuTdOfXDWnDfnPTfj3GmV/fedsHllCKHQEgAAbemUH3dSssnFPzrn\nqutvvuyCP9bnSwZt/YnTLj1vdM+yEMLQ8Red0njFzdPOfbchMWTkmAvPmJh4/08VWAIAYHWJ\nwj8NZaPQEe+xmzRp0oa9Qbqy6dOnF3uEjUCfPn0SiURdXV3r55ZgVdXV1el0uqGhwVvjaVNV\nVVV5ebm3xW8QNTU1a1rqnF8pBgBAhxN2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2\nAACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQ\ndgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACR\nEHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAA\nkRB2AACREHYAAJEQdgAAkRB2AACRaG/YjR49+rLX61Y//vZjk/bce8IGHQkAgI8iXXh56X9e\neqspG0J44okntnrxxX8v7/HB9fzz9z762J//21HTAQDQbmsJuzu+sNtxcxa1XL75c7ve3NY5\nPbY8dUNPBQDAOltL2O1+wbRrlzSEEE466aQxF15+eN9uHzohWdJ99MHjOmo6AADabS1hN2z8\n0cNCCCHceuutBx33PyduXtUJMwEA8BGsJexaPfTQQyGERa/PW7A8s/rqsGHDNuRQAACsu/aG\nXcPCBw7eY/x9/17U5mo+n99wIwEA8FG0N+yu//KEP8xddsDJ53xhxy3TiQ4dCQCAj6K9YXfR\nUwu2Gv/be67+UodOAwDAR9auH1Cczy5bkMkOGr9jR08DAMBH1q6wS6Sq9qoun/ezpzt6GgAA\nPrJ2/kqxxK2/v7DpD1875sKfz1/e3LETAQDwkbT3PXbjzrlr081Kfv69Y35x3vG9+/XrlvrA\nByhee+21DpgNAIB10N6wq6mpqanZZ9CoDh0GAICPrr1hd+edd3boHAAArKd2vscOAICurr3P\n2NXW1hZY7dmz54YYBgCAj669YVddXV1g1a8UAwAouvaG3dSpUz9wPd/85rwXfjfzrkWJ/lOv\nuWSDjwUAwLpKrM+TbfXz//bZbcbMHXzKgn9O24Azravm5ubGxsYNe5sTJ07csDdIV3bDDTcU\ne4SNQEVFRSKRaGpqymQyxZ6Frqhbt27JZDKTyTQ1NRV7FrqisrKydDqdzWYbGhqKPcvGLZ/P\nV1VVrWm1vc/YtanbprvdcMGo7U+7/JHa74/pWbY+N7We0un1+kb4mLN/2iORSIQQksmku4sC\n7BDWpOUxJJFI2CHrqfBTcut751YMqEgkUsMqStbzdtZHPp9ftmxZEQdgY2f/tEdpaWkikWho\naPCvbdpUXV3d8oxdXV1dsWehK6qqqkqlUtls1kPu+isvL1/T0nr9uJNcZsHl5/6zpOoT/Ur8\n2BQAgCJr7zN2o0ePXu1Y7q25z77ybsMuU36yYWcCAOAjWJ+XYpMDd9j7oM9+7X8n77bBxgEA\n4KNqb9g9/vjjHToHAADrad2esVvxxj9vv+v+F+a9uSKb3myrEZ87aNzOA9f4gVsAADrTOoTd\nHd877MiLf9OYW/kh28mnnXTI5F/PvODgDhgMAIB1095Ps/7ntiPHXThzkzHHzbz/b2+88+7i\nBW8+9eDtx++16W8uHDfht//tyAkBAGiX9j5jd9lpd1f1P2b2AzdUJBMtR3YZe/DOY/bLDer3\nm2/8KHz1yg6bEACAdmnvM3a3LlixzQnfbK26FolkxTe/Pqx+wS0dMBgAAOumvWFXlUw2zG/j\nx803zG9IpHx+AgCg+Nobdqdt3fOlX5zy9OLGVQ821c76+ow5PYd+swMGAwBg3bT3PXbH3n7B\neSO+8ektRx739WM/vePQ8lD/8nOP/ewnN81ZUTr9tmM7dEQAANqjvWFXPeyUF+5Pf+2U7157\nyTnXvn+w97DPXHXVL08aXt1BwwEA0H7r8HPsBow94eEXJ74+++//evnNxlC2+Vbb7bTtwPa+\nlAsAQAdb198VmxgwfJcBwztkFAAA1sc6POO28O+/m3jwvsf87pWWqw98/hOjvzjhN08u6JjB\nAABYN+0Nu9q512/zqYNvuufvJeXv/ZHeO239yoO3Hv7pra95cXGHjQcAQHu1N+xu/Mp3l3f7\nxKOvvnHDFwa2HNnp+7+Z9+pju1U0nHvI9R02HgAA7dXesLv8pdqhR/3k0/26rXqwvO8np580\nbMncH3fAYAAArJv2hl02ny/tWbr68VRFKoTcBh0JAICPor1h9/Ute/z7uimvNWZXPZhremvq\nT2Z3H3BiBwwGAMC6ae+POznpjnMvHnXmiOF7n3H6sZ/ecWhFMvOfF/7282k/eODd5qn3fb1D\nRwQAoD3aG3a9t//Wv+5JHXLi5KmTHm09WN57+Pm33HbuJ/t2zGwAAKyDdfgBxVvuN+mpV056\n/olH/jH7lRXZ9GZbjdhrzC49UomOGw4AgPZbx988kSjdfvS+24/umFkAAFgPftcrAEAkhB0A\nQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQd\nAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSE\nHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAk\nhB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJNKd82XyzYvvvOG6Pzz2zLsNyc0Gbv2lCSd9/hP9\nQggh5B6+9ep7Hp312rLUttvvdsykYwd3S73/hwosAXRpkyZNKvYIdJ7p06cXewR4Tyc9Y/en\nS8781cNvH3DMpEsvPHvvIY1XTz31rtfqQgjz7phy+czHR3914nmnHVXx8gOTT78h//4fKbAE\nAMDqOuMZu2zja9f+feGYSy778oheIYSth+/w1pPj77p29pcv2nHazBeHTpg2bp/BIYShl4ZD\njv7hLW9NOGKzypBvWuMSAABt6Yxn7LIN/x00ePD+W3V//0DiEz3LmmrrGmsffbUhu9/em7cc\nLeu158iq0qcemR9CKLAEAECbOuMZu9Kee15xxZ6tVzN1s296s27LiUOblv8mhLBdxcoZRlSk\n//R8bQihafmza1pq8bWvfW327Nktl0eNGjVjxowO/iaIWU1NTbFH2GhUVVVVVVUVewroWjyG\ntF9JSYm7az1ls9kCq5304YlW/33q3iun/7R5q/2/u2//zH+XhxBqSlZ+JKKmJJVZmgkh5BrX\nuAQAQJs6L+waF8++6cdX/vGZRWPGnXzxEXuXJxLLyipCCIsyuX6l770ivDCTTfdKhxCSa15q\nMWnSpKVLl7ZcrqqqWrZsWad9I8TH/mmPqqqqRCLR0NCQyfgnFnyAx5D2KC8vLykpyWazK1as\nKPYsG7d8Pt+jR481rXZS2C37zwNnfPuq1I77/e8NRw2rKW85WFKxQwiPzK7P9Cstazkyp765\n54iehZda7Lrrrq2XM5lMbe3KV2lhXTU2NhZ7hI1Ayyuwzc3N7i74EH8p2qOkpKSkpCSXy7m7\nOlRnfHgin1tx8XeuKfvsN67+3gmtVRdCKK8e2780dd9jC1quZupmPb2saaex/QovAQDQps54\nxm7F2798YUXm+B0r//70060HS7ptPXJEzzPGDf/2jVMf3PSs4dWNd105rbL/vhM2rwwhhETJ\nGpcAAGhLZ4Rd7b//G0K48dKLVz3Yc6tzf3nFJ4eOv+iUxitunnbuuw2JISPHXHjGxMT7JxRY\nAgBgdZ0RdpuP/f7dY9ewlkjte/QZ+x69jksAAKymk36lGAAAHU3YAQBEQtgBAERC2AEARELY\nAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC\n2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBE\nQtgBAERC2AEARELYAQBEQtgBAERC2AEARCJd7AFgozRp0qRij0DnmT59erFHAGgXz9gBAERC\n2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBE\nQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEA\nRELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAEQiXewBNoyysrJij8BG\nzP6hMDuEwuyQ9kilUiGEZDLp7lpP+Xy+wGoMYZdIJCoqKoo9BRsx+4fC7BAKs0PaI5lMtvzX\n3bWecrlcgdUYwi6fzy9ZsqTYU7ARW7x4cbFHoEuzQyjMDmmPqqqq8vLy5ubm2traYs+y0aup\nqVnTkvfYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBE\nQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEA\nRELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgB\nAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELY\nAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARDcQhL4AABo7SURB\nVELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgB\nAERC2AEARELYAQBEIt3JX+9nJx9dfsG1h/Xt9v6B3MO3Xn3Po7NeW5badvvdjpl07OBuqXYs\nAQDwYZ35jF3+pb/cdOebS5rz+dZD8+6YcvnMx0d/deJ5px1V8fIDk0+/Id+OJQAAVtdJz9i9\n/ecrplz/13dqGz9wNN80beaLQydMG7fP4BDC0EvDIUf/8Ja3JhyxWWWhJQAA2tJJz9j13nHc\nOed9/7JLz171YGPto682ZPfbe/OWq2W99hxZVfrUI/MLLwEA0KZOesautOeAoT1Dtql81YNN\ny58NIWxXsXKGERXpPz1fW3ipxemnn/7yyy+3XN5uu+0uuuiijhyfyPXq1avYI9Cl2SEUZoe0\nRzKZDCGk02l313rK5XIFVjv7wxOryjUuDyHUlKz8SERNSSqzNFN4qcU777zzxhtvtFzu27dv\nKuVzFXx09g+F2SEUZoe0XyKRcHd1qGKGXbKsIoSwKJPrV/reK8ILM9l0r3ThpRYHHnjgbrvt\n1nK5X79+9fX1nTk5kbF/KMwOoTA7pD1KS0tTqVQul2tsbFz72axZLperrFzjRw6KGXYlFTuE\n8Mjs+ky/0rKWI3Pqm3uO6Fl4qcX48eNbL2cymdra2gAf1fLly4s9Al2aHUJhdkh7tDxXl81m\n3V3rr0DYFfMHFJdXj+1fmrrvsQUtVzN1s55e1rTT2H6FlwAAaFNRf/NEouSMccPn3jj1wVlz\n3pz33Ixzp1X233fC5pVrWQIAoC3FfCk2hDB0/EWnNF5x87Rz321IDBk55sIzJibasQQAwOo6\nNexSpQPuvvvuDxxKpPY9+ox9j27r7AJLAACspqgvxQIAsOEIOwCASAg7AIBICDsAgEgIOwCA\nSAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsA\ngEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7\nAIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgI\nOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBI\n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\n3Qcd8+srv9p65K/nHffD565f3LxHj9LNnvrb30r+9s639+zXupqtXxxC6FdVUoRZKZ4C+6RX\nuo23Va7r+cQhXTH8gpN2PeXq7z2xS1XrQZuBdrJVOoEnYCLXsPCeJ5c1ffKksaseHHnCZ3PN\ntdf/a1GqfKvvHDDsL9O+9ZNf3/XkrGeff3bWn+//3fnf+nGPrfY/ajPvpfsYKbxP1v98YtJ/\n37MPGJD67d/eablqM9BOtkrnEHaRm/ur+1LlW5y4bfWqB6v6HzGyqvS5Gx8LIew68dLzTj5w\n/qw/Xv6D86dMveSmOx7ut/dRP77sBP92+lhZ6z5Zz/OJS/KoC75R8f7PFrYZaCdbpXMk8j6N\nAgAQBc/YAQBEQtgBAERC2AEARELYAQBEQtgBAERC2AEARELYAQBEQtgBXUWu+d1bLvv25z61\nXd/qqnRZ5WZDdjz01Kl/X9Cw6jm3blvTrdc+nTDM4rnHJz4olS7fZNCIQ79x8bz65nbeyPcG\n9ey+2cTC5zyw36BEQb99t369vxvg48LvigW6hMyyWYfusvfv5tQOGDn2y4fvU9Kw4N8vPH3b\n1ef/7mc33/LCrIMHVa39JtbPO3+bcvxFz3zn13fs3qO09eDm+x53xMjeLZcblrw968G7bvvJ\nlP+795nX587snlr7r2dJptOp3Fr+/Txo3Ilnbr+45XIu8860H/+iYpOvnHLUkNYTtu7mFzcD\n7eU3TwBdQD5z2s6bT392+Vk/f+gHR+7WevilP1y8/QHnlg06rnbejJYjt25bc+zbo+oXP7DB\nR/jvXZ8dfNCDdyxc8dU+3UIIi+ce33ubm3a/9sW/njh85Zi55eftMeTCx+cf+uDrM8f23+Az\nZJb/o7Rqp01G3TP/Hwds8BsHPg68FAsU35sPn/zjfyzc7XsPrlp1IYSh+02+9QtbLP3PjVe8\nUVes2VaVSFZ+62fjQgjP/OK/63Ez+YZMbgNN9P4tZpuy/pEOCDugK7j91DuT6R6/OuuTqy/t\ne/21M2bMGPbBEKp/+7ETvvTpPj0qKvv03+0LR93/+vLWpbpXHj3tsM9v0be6rLL38E/sff51\n9636R3OZhVedc9yOQ/qVl5T06DPws+MnPbGwIYRwyeDqwQc9GEI4uKaix8CzCs2aSIYQso3Z\nlmsv3n3VQXvtVNOzMl3abbMhOx591vRFzSsL65LB1a3vsbt125qeg7731kNX7zSoV7fSVGWf\n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"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "heart_failure %>%\n",
    "group_by(ChestPainType) %>%\n",
    "summarize(count =n()) %>%\n",
    "ggplot() +\n",
    "geom_col(aes (x=ChestPainType, y=count))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "cbab106c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-05T16:43:34.258437Z",
     "iopub.status.busy": "2023-07-05T16:43:34.256927Z",
     "iopub.status.idle": "2023-07-05T16:43:34.318478Z",
     "shell.execute_reply": "2023-07-05T16:43:34.316677Z"
    },
    "papermill": {
     "duration": 0.07201,
     "end_time": "2023-07-05T16:43:34.320890",
     "exception": false,
     "start_time": "2023-07-05T16:43:34.248880",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 67 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>RestingBP</th><th scope=col>count</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>  0</td><td>  1</td></tr>\n",
       "\t<tr><td> 80</td><td>  1</td></tr>\n",
       "\t<tr><td> 92</td><td>  1</td></tr>\n",
       "\t<tr><td> 94</td><td>  2</td></tr>\n",
       "\t<tr><td> 95</td><td>  6</td></tr>\n",
       "\t<tr><td> 96</td><td>  1</td></tr>\n",
       "\t<tr><td> 98</td><td>  1</td></tr>\n",
       "\t<tr><td>100</td><td> 15</td></tr>\n",
       "\t<tr><td>101</td><td>  1</td></tr>\n",
       "\t<tr><td>102</td><td>  3</td></tr>\n",
       "\t<tr><td>104</td><td>  3</td></tr>\n",
       "\t<tr><td>105</td><td>  9</td></tr>\n",
       "\t<tr><td>106</td><td>  3</td></tr>\n",
       "\t<tr><td>108</td><td>  7</td></tr>\n",
       "\t<tr><td>110</td><td> 58</td></tr>\n",
       "\t<tr><td>112</td><td> 14</td></tr>\n",
       "\t<tr><td>113</td><td>  1</td></tr>\n",
       "\t<tr><td>114</td><td>  2</td></tr>\n",
       "\t<tr><td>115</td><td> 19</td></tr>\n",
       "\t<tr><td>116</td><td>  2</td></tr>\n",
       "\t<tr><td>117</td><td>  1</td></tr>\n",
       "\t<tr><td>118</td><td> 10</td></tr>\n",
       "\t<tr><td>120</td><td>132</td></tr>\n",
       "\t<tr><td>122</td><td> 12</td></tr>\n",
       "\t<tr><td>123</td><td>  2</td></tr>\n",
       "\t<tr><td>124</td><td> 12</td></tr>\n",
       "\t<tr><td>125</td><td> 29</td></tr>\n",
       "\t<tr><td>126</td><td>  7</td></tr>\n",
       "\t<tr><td>127</td><td>  1</td></tr>\n",
       "\t<tr><td>128</td><td> 18</td></tr>\n",
       "\t<tr><td>⋮</td><td>⋮</td></tr>\n",
       "\t<tr><td>136</td><td> 13</td></tr>\n",
       "\t<tr><td>137</td><td>  5</td></tr>\n",
       "\t<tr><td>138</td><td> 17</td></tr>\n",
       "\t<tr><td>139</td><td>  5</td></tr>\n",
       "\t<tr><td>140</td><td>107</td></tr>\n",
       "\t<tr><td>141</td><td>  3</td></tr>\n",
       "\t<tr><td>142</td><td> 11</td></tr>\n",
       "\t<tr><td>143</td><td>  2</td></tr>\n",
       "\t<tr><td>144</td><td>  8</td></tr>\n",
       "\t<tr><td>145</td><td> 18</td></tr>\n",
       "\t<tr><td>146</td><td>  4</td></tr>\n",
       "\t<tr><td>148</td><td>  2</td></tr>\n",
       "\t<tr><td>150</td><td> 55</td></tr>\n",
       "\t<tr><td>152</td><td>  7</td></tr>\n",
       "\t<tr><td>154</td><td>  3</td></tr>\n",
       "\t<tr><td>155</td><td>  8</td></tr>\n",
       "\t<tr><td>156</td><td>  2</td></tr>\n",
       "\t<tr><td>158</td><td>  4</td></tr>\n",
       "\t<tr><td>160</td><td> 50</td></tr>\n",
       "\t<tr><td>164</td><td>  1</td></tr>\n",
       "\t<tr><td>165</td><td>  2</td></tr>\n",
       "\t<tr><td>170</td><td> 14</td></tr>\n",
       "\t<tr><td>172</td><td>  2</td></tr>\n",
       "\t<tr><td>174</td><td>  1</td></tr>\n",
       "\t<tr><td>178</td><td>  3</td></tr>\n",
       "\t<tr><td>180</td><td> 12</td></tr>\n",
       "\t<tr><td>185</td><td>  1</td></tr>\n",
       "\t<tr><td>190</td><td>  2</td></tr>\n",
       "\t<tr><td>192</td><td>  1</td></tr>\n",
       "\t<tr><td>200</td><td>  4</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 67 × 2\n",
       "\\begin{tabular}{ll}\n",
       " RestingBP & count\\\\\n",
       " <dbl> & <int>\\\\\n",
       "\\hline\n",
       "\t   0 &   1\\\\\n",
       "\t  80 &   1\\\\\n",
       "\t  92 &   1\\\\\n",
       "\t  94 &   2\\\\\n",
       "\t  95 &   6\\\\\n",
       "\t  96 &   1\\\\\n",
       "\t  98 &   1\\\\\n",
       "\t 100 &  15\\\\\n",
       "\t 101 &   1\\\\\n",
       "\t 102 &   3\\\\\n",
       "\t 104 &   3\\\\\n",
       "\t 105 &   9\\\\\n",
       "\t 106 &   3\\\\\n",
       "\t 108 &   7\\\\\n",
       "\t 110 &  58\\\\\n",
       "\t 112 &  14\\\\\n",
       "\t 113 &   1\\\\\n",
       "\t 114 &   2\\\\\n",
       "\t 115 &  19\\\\\n",
       "\t 116 &   2\\\\\n",
       "\t 117 &   1\\\\\n",
       "\t 118 &  10\\\\\n",
       "\t 120 & 132\\\\\n",
       "\t 122 &  12\\\\\n",
       "\t 123 &   2\\\\\n",
       "\t 124 &  12\\\\\n",
       "\t 125 &  29\\\\\n",
       "\t 126 &   7\\\\\n",
       "\t 127 &   1\\\\\n",
       "\t 128 &  18\\\\\n",
       "\t ⋮ & ⋮\\\\\n",
       "\t 136 &  13\\\\\n",
       "\t 137 &   5\\\\\n",
       "\t 138 &  17\\\\\n",
       "\t 139 &   5\\\\\n",
       "\t 140 & 107\\\\\n",
       "\t 141 &   3\\\\\n",
       "\t 142 &  11\\\\\n",
       "\t 143 &   2\\\\\n",
       "\t 144 &   8\\\\\n",
       "\t 145 &  18\\\\\n",
       "\t 146 &   4\\\\\n",
       "\t 148 &   2\\\\\n",
       "\t 150 &  55\\\\\n",
       "\t 152 &   7\\\\\n",
       "\t 154 &   3\\\\\n",
       "\t 155 &   8\\\\\n",
       "\t 156 &   2\\\\\n",
       "\t 158 &   4\\\\\n",
       "\t 160 &  50\\\\\n",
       "\t 164 &   1\\\\\n",
       "\t 165 &   2\\\\\n",
       "\t 170 &  14\\\\\n",
       "\t 172 &   2\\\\\n",
       "\t 174 &   1\\\\\n",
       "\t 178 &   3\\\\\n",
       "\t 180 &  12\\\\\n",
       "\t 185 &   1\\\\\n",
       "\t 190 &   2\\\\\n",
       "\t 192 &   1\\\\\n",
       "\t 200 &   4\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 67 × 2\n",
       "\n",
       "| RestingBP &lt;dbl&gt; | count &lt;int&gt; |\n",
       "|---|---|\n",
       "|   0 |   1 |\n",
       "|  80 |   1 |\n",
       "|  92 |   1 |\n",
       "|  94 |   2 |\n",
       "|  95 |   6 |\n",
       "|  96 |   1 |\n",
       "|  98 |   1 |\n",
       "| 100 |  15 |\n",
       "| 101 |   1 |\n",
       "| 102 |   3 |\n",
       "| 104 |   3 |\n",
       "| 105 |   9 |\n",
       "| 106 |   3 |\n",
       "| 108 |   7 |\n",
       "| 110 |  58 |\n",
       "| 112 |  14 |\n",
       "| 113 |   1 |\n",
       "| 114 |   2 |\n",
       "| 115 |  19 |\n",
       "| 116 |   2 |\n",
       "| 117 |   1 |\n",
       "| 118 |  10 |\n",
       "| 120 | 132 |\n",
       "| 122 |  12 |\n",
       "| 123 |   2 |\n",
       "| 124 |  12 |\n",
       "| 125 |  29 |\n",
       "| 126 |   7 |\n",
       "| 127 |   1 |\n",
       "| 128 |  18 |\n",
       "| ⋮ | ⋮ |\n",
       "| 136 |  13 |\n",
       "| 137 |   5 |\n",
       "| 138 |  17 |\n",
       "| 139 |   5 |\n",
       "| 140 | 107 |\n",
       "| 141 |   3 |\n",
       "| 142 |  11 |\n",
       "| 143 |   2 |\n",
       "| 144 |   8 |\n",
       "| 145 |  18 |\n",
       "| 146 |   4 |\n",
       "| 148 |   2 |\n",
       "| 150 |  55 |\n",
       "| 152 |   7 |\n",
       "| 154 |   3 |\n",
       "| 155 |   8 |\n",
       "| 156 |   2 |\n",
       "| 158 |   4 |\n",
       "| 160 |  50 |\n",
       "| 164 |   1 |\n",
       "| 165 |   2 |\n",
       "| 170 |  14 |\n",
       "| 172 |   2 |\n",
       "| 174 |   1 |\n",
       "| 178 |   3 |\n",
       "| 180 |  12 |\n",
       "| 185 |   1 |\n",
       "| 190 |   2 |\n",
       "| 192 |   1 |\n",
       "| 200 |   4 |\n",
       "\n"
      ],
      "text/plain": [
       "   RestingBP count\n",
       "1    0         1  \n",
       "2   80         1  \n",
       "3   92         1  \n",
       "4   94         2  \n",
       "5   95         6  \n",
       "6   96         1  \n",
       "7   98         1  \n",
       "8  100        15  \n",
       "9  101         1  \n",
       "10 102         3  \n",
       "11 104         3  \n",
       "12 105         9  \n",
       "13 106         3  \n",
       "14 108         7  \n",
       "15 110        58  \n",
       "16 112        14  \n",
       "17 113         1  \n",
       "18 114         2  \n",
       "19 115        19  \n",
       "20 116         2  \n",
       "21 117         1  \n",
       "22 118        10  \n",
       "23 120       132  \n",
       "24 122        12  \n",
       "25 123         2  \n",
       "26 124        12  \n",
       "27 125        29  \n",
       "28 126         7  \n",
       "29 127         1  \n",
       "30 128        18  \n",
       "⋮  ⋮         ⋮    \n",
       "38 136        13  \n",
       "39 137         5  \n",
       "40 138        17  \n",
       "41 139         5  \n",
       "42 140       107  \n",
       "43 141         3  \n",
       "44 142        11  \n",
       "45 143         2  \n",
       "46 144         8  \n",
       "47 145        18  \n",
       "48 146         4  \n",
       "49 148         2  \n",
       "50 150        55  \n",
       "51 152         7  \n",
       "52 154         3  \n",
       "53 155         8  \n",
       "54 156         2  \n",
       "55 158         4  \n",
       "56 160        50  \n",
       "57 164         1  \n",
       "58 165         2  \n",
       "59 170        14  \n",
       "60 172         2  \n",
       "61 174         1  \n",
       "62 178         3  \n",
       "63 180        12  \n",
       "64 185         1  \n",
       "65 190         2  \n",
       "66 192         1  \n",
       "67 200         4  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "heart_failure %>%\n",
    "group_by(RestingBP)%>%\n",
    "summarize(count =n())"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "d37c7cf9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-05T16:43:34.338242Z",
     "iopub.status.busy": "2023-07-05T16:43:34.336676Z",
     "iopub.status.idle": "2023-07-05T16:43:34.575184Z",
     "shell.execute_reply": "2023-07-05T16:43:34.573438Z"
    },
    "papermill": {
     "duration": 0.249846,
     "end_time": "2023-07-05T16:43:34.577506",
     "exception": false,
     "start_time": "2023-07-05T16:43:34.327660",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "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\n//DHO4wppZTyxWKhbzD/P/zGw2ZsP7qUUkr1voVzH7n6sitOPXSXPz9z0y8/9dql77bObgfv\nt/X4/svd8x6/5dqrfvS1mb/6xW3/uu/S0YXcIM4DrO588gSwulrw0MzODT+77Sm33nzyNksv\nry66c9u1t72rK9313OItVu0zfB68ateN9rj2x08vfs8a7as27EvdfPw2rzvzttMfXnDi+qOX\nLKzMv3Xrdba7v2+dBYv+0Z7PpZSeve9D4ze9cIfz7rn+sM2X3K3et+jkN2582o1P7HPtvy7d\ned3BHQxYrXkpFoimpWPLM1+3Vr2v+rO5XU1ZYb27Ojiv+5Y6p52x+bje7ofuXjzQy6y5fMfH\nv7tXSum27z84KOsFwhB2QEC93bWU0qtbnz9ct/Ch2R9739tevebY1o7xm0/b5TPfvHrpEOur\nPv31Tx281cYT21paxqyx/q77zvjj090ppTM2GrvRHtemlN47oTxm/U/2L1nyHrtLtpjQucGn\nH/vdudtuMK69VOhYY93t3n7ANf9atPQYj/3he/u+803rjS2vud7UI7509YNX7ZrL5R4fsALv\nebanUJo45RUPNObyKaVaT21FtgoQn/fYAdH0dt3/2bvndqy9x95rtqeUFj165TZb7PNwbt0P\nHHTI5AmF237/o1MO/88rb/jOrd87sP/+57xzm0/89vGd9z107w+vv+Dhm847/+tv+b+Hn33k\nyvd/74r1fnvsAaf+deZlP33zWpu9fEWVBX94/TtmT9rniLN32Pzp2//3C9/8wbu3fXrBk78o\npJRSmnv7Vzbf+Zja2jscePhxrc/e94MT3nX11DEDjN09/7GrLjhp5oML3nTCz/pfh12uvq6v\nffjylNLm+22wUlsICEvYAau3R6+ZdXz32i9cqy+e99jvr/jRA+O2u/T6/+kPrC+99cMP5yZf\n9/At09doSymldOaVx07b86yDPnvynidO6uztmvP/fvvo+m+//LcXv6f/r3jP6De86zvXX/F0\n175v2iX37PiU0rRd3rLrst5j1z3vd+ud8vvZJ++UUkrpiNc9s/Gel1197bye3ca2ppQ+8c6Z\nPeXX3zbnd5uViyml4w+dvtbrP/qSv2Hmq8fM/PclG7/n8789fceX3O2hn5x1/INr9F/umf/E\nLdf+5Lq/zRuz4Z7ff/urV3yDAZEJO2D19vgfvnPmH166cNt93zBtrfaUUu/iu067e+6UY375\nQtWllNI7P/2VdNZOl35jzolffH0u317KpXn3XHHTP3d73fqjU0rTv3D9U19oaNX5Qvknx78Y\nYVvvs0G67IHnan0ppe65P/vOIwunffobm73wouqE1x4589UnnPbQgqX/hhfPik2pXlt8/23X\nXnXFcVP+69mbrzpj1FKnuz7yq/PP/NXzl3O5wprrT37XEcef88VjxhWdEgv8G2EHrN5eclbs\n4rmPXv3Nj+59wplvyr35/ovf1j33l7V6/Y4v/0fuyy/9wvl3zE8pFVrX/9Xn9v+vE/7nPza4\neIMtt9th++3ftMvb9t7rreMbaKZiectXlV58p3JuqS/pevqKlNLG+/zbEbVdt1vzJWH39hNP\nX/qs2JTSbz89/S2nnfm+Sz/88/02XrLwJWfFAiyPsANCKY9fZ6/jf7TzFzr++OuvpPS2lC+l\nlF7zyQu/uMs6L7lna+fzOfimT37vyQOPv/LKn/9+9h+u/813Lzr/7GM+vv2Vd/5ut6UO8i1T\nLteyvJvqfT3LuH8Dsfim485Np21709l3pKXCDqBBzooF4sm/ZWxrtetvKaW28e8s5HK98zZ7\n21J2fdMG8+bNy21YTilVF/7tT3/607/GTH7foZ8473+uvOMfc++++tTFj//x6Jm3rsoEbeN2\nTSk9cMU/l154/Z+ebuBLCymlvopPlQBWhrADAirkcrWex1JKxbbJp0wZf98PDvjt44uX3Hrx\nke9+//vf/3A+pZQWPfGN7bfffp8zX8y4DV/3+pRS76IX02olfo97ea0D3j2h/a4vHbnkg7/m\n3nH+SQ/Mf8UvvPHsI1NKWxyx5QqvEsBLsUBIG7QX633z/rCg8sYxpY9dfe75m37gHRtvuef7\n3vXaTcbfee2lP/jNnNcc+IP91yqnlDo3/Mxb1vzWb0970zsfOGj7qZP65j145QUXFlrWOOWM\naSmlltEtKaVvffWCni3+Y7/3bbcCE+SKF/zqjM23/8TWm+92yAFvbZ133/fPv2T3/5hw5Z+e\nKi/1q0x+feYpC8csOXmi6++3/+7yX93evubO/3PgJoO4NYCRQ9gBAW3xwQ3SCU8f/JEr5vzw\nfaNevc/tt3ced9znrrri21dWSpM2nXLy+b+c+aG3998zV+j86R3XHHf0yVf98oe/+eGi9nGv\n2nbH/S4/+fN7rDcqpbTWdp//r23/ds1nj7lj6kkrFnYpTdj2Y/fdst7BM77wgy+f1rLetKMv\nufW133zrVYX2MUud7jr73LNmv3A5l8t3dE7cdd+Pn/H1M9ZvLQzKdgBGGp8VCzAU6jfffEup\nc9PXTH7xpNcLNltjxtPTFz/z8wzHAmITdgBDYvvOtns6j5z/8PO/Z6V38d0bjN+q9Naf/uOn\n78x2MCAwL8UCDInzZu407ZNnvfHA9sPeMS333MOXnHXq47XRl3zrzVnPBUTmiB3AUPnFrP93\n+gVX3XP/g72t47fZ4W1Hn/KlvV+/ZtZDAZEJOwCAIPweOwCAIIQdAEAQwg4AIAhhBwAQhLAD\nAAhC2AEABCHsAACCEHYAAEEIOwCAIP4/tb1ISAgFJTsAAAAASUVORK5CYII="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "heart_failure %>%\n",
    "group_by(RestingBP) %>%\n",
    "summarize(count =n()) %>%\n",
    "ggplot() +\n",
    "geom_col(aes (x=RestingBP, y=count))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "ea89daf4",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-05T16:43:34.595064Z",
     "iopub.status.busy": "2023-07-05T16:43:34.593564Z",
     "iopub.status.idle": "2023-07-05T16:43:34.623589Z",
     "shell.execute_reply": "2023-07-05T16:43:34.621843Z"
    },
    "papermill": {
     "duration": 0.041425,
     "end_time": "2023-07-05T16:43:34.626060",
     "exception": false,
     "start_time": "2023-07-05T16:43:34.584635",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>HeartDisease</th><th scope=col>count</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>0</td><td>410</td></tr>\n",
       "\t<tr><td>1</td><td>508</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " HeartDisease & count\\\\\n",
       " <dbl> & <int>\\\\\n",
       "\\hline\n",
       "\t 0 & 410\\\\\n",
       "\t 1 & 508\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 2 × 2\n",
       "\n",
       "| HeartDisease &lt;dbl&gt; | count &lt;int&gt; |\n",
       "|---|---|\n",
       "| 0 | 410 |\n",
       "| 1 | 508 |\n",
       "\n"
      ],
      "text/plain": [
       "  HeartDisease count\n",
       "1 0            410  \n",
       "2 1            508  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "heart_failure %>%\n",
    "group_by(HeartDisease)%>%\n",
    "summarize(count =n())\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "c3a55573",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-07-05T16:43:34.643916Z",
     "iopub.status.busy": "2023-07-05T16:43:34.642318Z",
     "iopub.status.idle": "2023-07-05T16:43:34.887631Z",
     "shell.execute_reply": "2023-07-05T16:43:34.885739Z"
    },
    "papermill": {
     "duration": 0.257055,
     "end_time": "2023-07-05T16:43:34.890293",
     "exception": false,
     "start_time": "2023-07-05T16:43:34.633238",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nOzdeZzUdf3A8c/s7uwuu8ByrIigIocXIKDmgUYI3qlpiqkZ4hFqakhiSilKoqZZ\naJpHaaZWKpV5az81D1K0NPJAIVS88gC5FhbYe35/rC4L7C7DsTvLh+fzjx4z38/Md94zu319\nMdcmUqlUAABg05eV6QEAANg4hB0AQCSEHQBAJIQdAEAkhB0AQCSEHQBAJIQdAEAkhB0AQCSi\nCrvEGnLy2nbvuePRp/3w4dcXrHbhf/9oUCKROPS5Tzb6GKvt+fvd2yUSiVkrqjb6Da15W63E\n8s+eOWX/3Yvb5m7Z78cNXqBs0WOJRCInr1tje3jq0B6JRGKPq19vthnXX0F21pq/afWVVKf1\npd+r/exev3qPRCKx/4PvN+PoAMQuJ9MDbHzb9O6Tl/ji9IolCz/74O37b//5A3fccMJVj/3x\nh8PXe7epmmXTXnw1J2/bvb6yzcYZdNOcIR2XDjn6jncWd91t+EF7bp/pWdK1ro/t1r365Dfy\nz6Ko/rUEwCYlwrB78LW3di1M1p1d9unMu66beO41f777gv3b9HrvtmO2q92+3bGT7thpYfed\nOqa526oVs7/61a+233ZCyQeXNX3Jdd1z+tacoflua/2lKn75bkmyYOd3X36qICux9su3Dun/\nfGv96dU3B7fL3ZBbbI0/OwA2cRGG3WoKt9r5e1dP2XO7qq+c9de7Tjrsim+8sWUyK4TQebcj\nRu3WLLfYfHvO7G2lKVWzojKVKijotwlVXUa0wp8dAJu6zeVVo92/96eRWxZWLn/re0/8r7lu\nI1U+r7KmuXbeXGqWlTXLm/82GZvkT61xkd0dANbR5hJ2IWRf+KP+IYQXL/9X7flXf7L7ah87\nWDjj0TEnHNJnq855ydyizlsPOfyUe//5We3SvTsX57bdLYSw5MNJiUSi846/CyHM+vW+iUTi\nnHcXl37w2PFD+rbNLfj9vOUN7jmEkErV/O1X44f03a5dfm7HLlvvP+L0R+p9nuPF7/VNJBLH\nzFzlEx6p6pJEIlG4xbFNzNDQbdU894effuNrA7bo0Da3sKhn/33OuvTWT8qr65bfvvNriUTi\ntLcXvfL7i/pv3aFtm2ROXmHPAUMu/vWTaTyMa9n5U4f2yMrpEEJYPv8viUSiXffvp7HPdfDB\n83effNR+3bt0zCvosP0ue5z1k1veWb5KmKaqS+7+xfn779m3c1FhTm6bLbbZ4dATx/zfrJK6\nCzT4U2vwsd1Aa52kwd+TOun8SjR2d2qX1vpYARCfzSfswtbfGBpCKHnnjw2uzp9+be9dv3HD\nvf+3qGCrPffda+v2pc8/eseJ+25/w8xFIYSdTz/3gnGnhBDy2u87fvz4sWcMqLti+ZJ/DRnw\nzYferh580GHbt2n0pe37x+596Pev/udHZX369qpc9OnT99165O69Ln/y4/Tnb2KG+q4/abf9\nRv74kednZHfuNXjgDiWz/3XzZaf37X/0W6v+R/2Dh87bc9RP36/Zcv8jjhzcv8v7bzx/xZkH\nHXH9jKZnWOvOt/vWWeMvGBtCSBbsOH78+HHnHJj+HVyrl64b1ftr37nroanVhd32GLDd4vde\nvXni9wbtcPDT81bUXiBVvfSMfXY48fxfPPufT7fZYeBX99il7bIP/3b3DYcN3Pnh+Svq72q1\nn1qaj2360p9ko1jzl3CtjxUAcUpFpPYeTS+taHB1xYIHQwg5+b1qz/5n4m4hhEOe/bj27Pk9\n2ocQRt467cuLVz980V4hhC673VZ7vqJ0egih/bYT6nY485Z9QghderYd/qO7l1fX1G1fbc/n\ndGsbQkgkskf/6omKmlQqlaou//zGsweHEJIFO39YVpVKpaaduXMI4ei35tcfuKZqcQihoHhE\n3ZY1Z1jttt677zshhLyiPR58/YtdVSydfd5+W4UQehx+Z+2W2XcMqX2g9j3vrhXVX+xn6vXf\nCCG06XxEEw9vOjtvcOw1rVj4aAghkcjZqRHbFiZDCF+56rW6q5TMuSkvK5HbdpffPPVO7Zbq\nyvk3n7N3CKGoz+m19+PjZ44NIbTbdsSshWVfDrP016fsEELY5fx/1W5p7Ke25mPbmDZZiRBC\njx12XHPs/gMPSKU9yWo/u9eu+koIYfgD79WeTfNXosG7k85jBUCUNqOwK1/yYgghkdWm9uxq\n/1ndvk0yhPD2isq6y1eU/mfixIlX/vyBL882HHYFWxy32n8pGwy7Ht/4w6qXqj6nV1EI4dD7\n5qQ2Xth9t1vbEMIPXvis/n4ql8/slpedyMp/tbQi9WXYFRQfXVFT70I1ZZ2SWdl53Rp86NLf\neYNjr6k27Naqftj97qtbhRDOevaTVXZUUzlyy8IQwi2flqZSqXd+P/aoo4760VMf17/I4jnn\nhxC2PeTJ2rON/dTWNewaVPfPhnQm2Yhht9rdSeexAiBKm9FLsTWV80MI2blbNbj6zW6FIYQD\njx772ItvVaRCCCFZOOjSSy/90bgjm97ttkeOSedB/NbPD1t1Q9b51+0ZQnjturfSuHZaqsve\n+92ny3La9P7Z4C3rb89ps9PPdylO1ZT94p2Vb/DqMeL8ZP0+SeR1TWaHVKPfrLtOO09Tdu5W\njf1ePnnItqtetuayVz7PThZP/tqqP75EztnHbhdCuOe5z0IIvb9z7f3333/l/iu/97h80Yd/\nuf5va950mj+1JkxbUr7m2JUr3q1dTX+SjWLVu5PWYwVAlOL/upM6FUumhRCSbRt++9SEv9/1\n7wNP+vvjNx72+I3Jtl123WOvrw4ddtRxo4bs1Knp3XbcPa3vITtqy4LVtnQaNCyEJ5d/PCuE\nwxq8yrqqWPpSdSrVtuOhOWs8o7T98C3DK3M/eHNxGFhcu6XDLh2ab+cbXXXZe++VVYUwP7+R\nZ8uWvLWk9kTV8vf/eOvvn/vnf95+Z877H7z/v3kN52aaP7UNkeYkG0X9u5P+YwVAfDajsPvf\no8+EEIr6fKfB1bY9jnjqv3NffuK+hx57curz016e+si/nnn42p9ccMT4vzx4ZVNP2uU0/oGJ\n+hJr/Ec2kZUbQkhktWn0Oql1/d6KRp9vS2QnQgg1FTWrbWmmnW90qVRlCCEnf7vzxx7f4AW6\n7rVFCGHB9Nv2HHrWnNLK4u1332/vPb92+Al9dujbv9eze+41ebXLp/lTW2/pT7JuGvmVqH93\n0nysAIjS5hN2NZOvmBFCGHzxHo1eJJG7x8En7HHwCSGE6hXz/v6X275z2iUPX/XNu3+w7Ntb\nNJ5f6Xlo3orV/lDBojefCSEU9dupsatUrnh7nW4it91e2YlE2aK/VYeQverSnGfnhhC69V+3\nZ+labOdrlZPfe4tk9sKa5Vf+9KdNBOnZXx87p7TyB3e/PPmEr9RtXPL+P5tvsBaeJJ1fiTQf\nKwCitLm8x+7120747aelyYK+txy09Zqry+f9Yfvttx+w93l1W7LbdDlo5I+v375jKpV6clHZ\nhg8w5YLV3l9Vc933Xwgh7PfDvnWbls1d5YY+fuLKdbqJ7PzeJ21ZULXinQtfmlt/e9WK2edN\nn5/Iyh234/q//tisO1+7RPLCHTtUV8y76J/zVl2oOWdg76222urBBWWp6pI/zVuek7dt/ZYK\nISyZvdHexZimjTjJ+vxKpPFYresYAGwq4g+78vnv3H7JyD3O+HMIYdRdj3ZJNnCX8zsetPiD\n92b86/pLHlz5RW7z33zk0vdKEomck+q9PS5VvZ7vT3r//hPPufW52hfSaqoW/Wbs0MmzF7fZ\n4pBfDd4yfPmOt3+eMXHul382YNFbDxwx6rEGd9XEDBN+eUQI4VeHHvnYzMW1W6qWzfnR4cP+\nV161zSG37Nku2dgV09GsO1+rk353ZgjhFwcceO+/Pq3dkqpe+vvz97/x9Tnl7b91ZOf8RHa7\nnvnZ1RUf3f7morprvfyXyQd885EQQvWKtL6bd71/vvVtlEnW6VdiNWt9rNbl3gCwSWnGT9y2\nuNp7tN0OK79XrOfWWyazEiGERFbet3/29/oXXu3LJl78yUG1V+/SZ+DwA/bfY0CfrEQihHDA\n+P+rvUB15fy8rEQikTz4mONPO+ep1JffNDHkjtmrjbHm153k5G27T5c2IYS8Dt332KN/UW52\nCCEnf7s731pUe5nykhe2y88JIeQX9/36N48dtmf/NlmJ3LYDdilM1v9uizVnWO22UqmaySfu\nEkJIJLK33nG3r+3Rt21OVgihqM+RM5d/8U0utV93ss8tM1cbu29BsomPqaa589S6fN3JWj8V\nW//rTlKp1P0XfPF1x9sN2HP/Yfv2Ls4PIeQV7frYZ8tqLzDtkqEhhKzswq8edMS3jjpk4A5b\nZmW3PeHC8bW3dfL3zl5eXdPYT23Nx7YxtV930uCnYuukM0nTX3eS5q9EY3dnrY8VAFGKMOzq\ny0oWbLXt9keefN6Dr36+2oXXSKLUC3/82TeG7LZFUWF2Vk67Tt32Oej4Gx/4T/2rPHfV6B5d\nirJycncY+qfUuoRdXvt9K0vf+fl5Jw3YrmubZLLjlj0OP2ncCx+t8nVii956+JTD9+nS/os3\n87XdZsg9by4aUVywWiGtNsOa9yKVqv77nZcftm//Tu3a5OS323bnvc+85Ncfl6/8mrMNCLu1\n7zzVnGGXSqX+89CNxx645xYd2+Yk87fsNeDb517x5uL6gVX9yC8vHNxv2za52W07dtnnsO88\n8PqCVCr1q1FDi/JzCjtvs6Sq0bBLrfHYNiadsEtnkqbDLpXer0QTd2dtjxUAEUqkGv/qMjKi\natmC9z5e3muHbbLXflk2C34lAEiTsAMAiET8H54AANhMCDsAgEgIOwCASAg7AIBICDsAgEgI\nOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASORkeoCNoKqqatmyZZmegs1Ffn5+\ndnZ2VVVVeXl5pmcBMq+wsDCEUF5eXlVVlelZ2FwUFRU1thRD2KVSqcrKykxPweaioKAgJyen\nqqrKbx0QQsjJyQkhlJWVOSbQGngpFgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAg\nEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4A\nIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIOACASwg4AIBLCDgAgEsIO\nACASwg4AIBLCDgAgEsIOACASOZkeAGAzMmbMmEyPAKTl+uuvz/QI68MzdgAAkRB2AACREHYA\nAJEQdgAAkWihD0/MffGi0T99o/6WM+7802Ed80Ooefbemx6eOv2jpdk799/r5DGn9GyT/eVF\nmlgCAGB1LRR2i19d3KbzEeeO7le3pVdhbghhzn0XXzvlg5Fnn3Nqx6pHfn3jRedV/fHmMxMh\nNL0EAMCaWijs5r21pEPfffbZp98qW1MVk6fM7DNy8ogDeoYQ+lwdjh11zT2fjvz2VoVNLQEA\n0JAWeo/da0vKO+7aoXrFks/mLU59ubG8ZOqHZdWHDu9Wezav45CBbXNffm5u00sAADSohZ6x\n+09pZc3z13/rhlmVqVRO4RYHf/vcM44YULHs9RBC34KVM/QryHliRkkIoYmlWk8//fTixYtr\nT3fs2HGPPfZomTsCWVlZIYTs7Oz8/PxMzwJAc2m1B/lUKtXEakuEXXXFxyWJ7O06Db767klF\n1UteevS2X9x6cd72d30zd1kIoTi58iMRxcnsyiWVIYSa8kaXat1+++2zZs2qPT1o0KBhw4a1\nwB2BOslkMplMZnoKAJpL27ZtMz1Cw6qrq5tYbYmwy87t/pe//OXLc8VDTxg/+4njnr5txjE/\nKAghLKys6Zr7xSvC8yurczrmhBCy8hpdqlVQUNC+ffu6003XK2xEicQXn+HxWwcQsVZ7kM/8\nM3Zr2r1Lm6cXfZ4s2CWE52atqOyam1e7ffaKqqJ+RSGEJpZq/eY3v6k7XVlZuWDBghYcn81a\nUVFRMpksKysrLS3N9CwANJfWnBbFxcWNLbXEhycWz77xtO+ePbei5ovzqernPl3eoe8O+R2G\ndc/Nfmza57WbK0unv7K0YrdhXUMITSwBANCglgi79r2O67x87oU/+fUrM2a//ear91x3wdRl\n7U7/7g4hkRw3Yqe3fzvx6emzP5nzxm0TJhd2P3Bkt8IQQlNLAAA0JNEyLyGXL3rzd7f88YXX\nZpfltO/Vp/83Tztj720KQwghVf3kXddNefJfC8oSvQcOPXPc6D51n4RtYmlVlZWVJSUlDS7B\nRuelWDbEmDFjMj0CkJbrr78+0yM0qomXYlso7JqVsKMlCTs2hLCDTcUmGnYt9AXFAAA0N2EH\nABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlh\nBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJ\nYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQ\nCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEH\nABAJYQcAEAlhBwAQCWEHABCJnEwPsHHk5ERyR2j9EolECCErK8tvHUDEWu1BPpVKNbHaSode\nJ4lEokOHDpmegs1Lbm5ubm5upqcAoLm02rSorq5uYjWGsEulUvPnz8/0FGwuioqKkslkWVlZ\naWlppmcBoLm05rQoLi5ubMl77AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHs\nAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh\n7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAi\nIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAA\nIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewAACIh7AAAIiHsAAAiIewA\nACKRk+kBIjdmzJhMjwCk5frrr8/0CAAbyjN2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAA\nkchA2JUvKVlRk2r52wUAiFtLf49d2aJ/jj71p1+9+Y9ndC0MIYRQ8+y9Nz08dfpHS7N37r/X\nyWNO6dkm+8vLNrEEAMDqWvQZu1RN2S0XXltSXVO3Zc59F1875cXBR4++dOxJBe8+ddF5t6bS\nWAIAYE0tGnav3XnRv9vvt/J8qmLylJl9Rl4+4oDB/XYfMvbqs0s/fuyeT5etZQkAgIa0XNgt\neef+yx9fMeHSY+q2lJdM/bCs+tDh3WrP5nUcMrBt7svPzW16CQCABrXQe+xqKj67csIfDrnw\n19sXrHyfXMWy10MIfQtWztCvIOeJGSVNL9V67733ysrKak/n5uZ27ty5me8BELmcHH87G1ip\n1R4TUqmm3pvWQkP/7ZqLF+529nd3L05VL6rbWFO+LIRQnFyZesXJ7MollU0v1ZowYcKsWbNq\nTw8aNOi2225r5nsARK5Dhw6ZHgFoRVrtMaG6urqJ1ZZ4KXbeSzfe/lbXK8fut/pt5xWEEBZW\nrvwsxfzK6py2OU0vAQDQoJZIpc//8XrF0k9PPeaoui2Pnn7Ck4UD/3DTkBCem7WismtuXu32\n2SuqivoVhRCSBbs0tlRr0qRJ9V+KXbx4cQvcESBiDiNAfa32mJBKpTp27NjYakuEXe+Tfjz5\nm1+8ipqqWTLu/In7XnTFsV0653fYonvuzY9N+3y/Q7cOIVSWTn9lacWIYV1DCPkdhjW2VKtn\nz551pysrK0tKSgLABqiqqsr0CEArsokeE1oi7PK37NFnyy9O177HrkOPXr26FoYQxo3Y6Ye/\nnfj0lhfs1KH8wRsmF3Y/cGS3whBCSCQbXQIAoCEZftdan+MuP6v8ursnT1hQlug9cOikcaMT\naSwBALCmlg67RHbHhx56qP75A0eNO3BUwxdtdAkAgDW06F+eAACg+Qg7AIBICDsAgEgIOwCA\nSAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsA\ngEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7\nAIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgI\nOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBI\nCDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCA\nSAg7AIBICDsAgEjkZHqAjSCRSBQXF2d6CmDT5jAC1NdqjwnV1dVNrMYQdqlUavHixZmeAti0\nOYwA9bXaY0IqlerYsWNjqzGEXQihqqoq0yMAmzaHEaC+TfSY4D12AACREHYAAJEQdgAAkRB2\nAACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQ\ndgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACR\nEHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAA\nkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYA\nAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2AACREHYAAJEQdgAAkRB2\nAACREHYAAJHIaZmbqVgy+9brb3vxjTnLanJ67LDbcWecNXjbtiGEEGqevfemh6dO/2hp9s79\n9zp5zCk922R/eaUmlgAAWF3LPGOXuum8S16cv9XZF1/xs4kX9M2e+bPzx8+vqgkhzLnv4mun\nvDj46NGXjj2p4N2nLjrv1tSX12liCQCANbVE2JWXPPP0vOWjf3LW4F123L7fbqeO/2F12YdT\n5i0PqYrJU2b2GXn5iAMG99t9yNirzy79+LF7Pl0WQmhqCQCAhrRE2GXlFJ966ql7tc/94nwi\nJ4RQkJ1VXjL1w7LqQ4d3q92c13HIwLa5Lz83N4TQxBIAAA1qiffYJQsHHHXUgBDColf/+Z+5\n8175vylb9DtiZJeCFZ+8HkLoW7Byhn4FOU/MKAkhVCxrdKnW6aef/s4779Se7t+//y9/+csW\nuCNAxDp37pzpEYBWpNUeE6qrq5tYbaEPT9SaO/XJR97++MP/rfjqMb0SIdSULwshFCdXfiSi\nOJlduaQyNLlUa/ny5UuWLKk7nUgkWuYuALFyGAHqa7XHhKYHa9Gw22nMxZNDKP3ope+NuWpS\n977jdigIISysrOma+8UrwvMrq3M65oQQsvIaXap16qmnLl68uPZ0x44dS0tLW/KOAPFxGAHq\na7XHhFQq1a5du8ZWWyLslrzzj3+8m3fYwXvWnm27zd6Hd87/21OfJgftEsJzs1ZUds3Nq12a\nvaKqqF9RCCFZ0OhSreHDh9edrqysLClZ+SotwHooKyvL9AhAK9KajwlNhF1LfHiicsVzv7nl\n2vmVNV+cT1W9ubyqYNvC/A7DuudmPzbt8y8uVjr9laUVuw3rGkJoYgkAgAa1RNh13On0nsny\n8T/97fQZs99567V7r7/g9RVtvnP8diGRHDdip7d/O/Hp6bM/mfPGbRMmF3Y/cGS3whBCU0sA\nADSkJV6KzUp2ueIX42/8zd0/v+xvK1LJHtvvOvbqSwcX5YUQ+hx3+Vnl1909ecKCskTvgUMn\njRtd94bAJpYAAFhTC314onCbPS+YtGcDC4nsA0eNO3BUQ9dpYgkAgDW0zJ8UAwCg2Qk7AIBI\nCDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCA\nSAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsA\ngEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEikG3aDBw/++f9K19z+2bQxQ4aP3Kgj\nAQCwPnKaXl7y3jufVlSHEF566aVeM2f+d1n7VddTMx6dOu0f7zfXdAAApG0tYXffIXudOnth\n7em7D9rz7oYu0367szf2VAAArLO1hN0+l02+ZXFZCOHMM88cOunaE7Zos9oFspLtBh8zormm\nAwAgbWsJux2PG7VjCCGEe++996hTv3tGt7YtMBMAAOthLWFX55lnngkhLPzfnM+XVa65uuOO\nO27MoQAAWHfphl3Z/KeO+epxj/13YYOrqVRq440EAMD6SDfsfnPkyMffXnr498YfMmC7nESz\njgQAwPpIN+wuf/nzXsf99eGbvtGs0wAAsN7S+oLiVPXSzyurexw3oLmnAQBgvaUVdonstvt1\nyJ9zxyvNPQ0AAOstzT8plrj3kUkVj3/n5El3zl1W1bwTAQCwXtJ9j92I8Q9uuVXyzktOvuvS\n0zp17dome5UPUHz00UfNMBsAAOsg3bArLi4uLj6gx6BmHQYAgPWXbtjdf//9zToHAAAbKN2w\nKykpaWK1qKhoYwwDAMD6SzfsOnTo0MSqvzwBAJBx6YbdxIkTVzmfqvpkzr0F+vsAABuaSURB\n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\nAkTJYQSor9UeE2pqagoKChpbbaGwW/reU+N+eGP2gEN/dutJOxbn125MFuwSwnOzVlR2zc2r\n3TJ7RVVRv6Kml2qdeuqpdacrKytLSla+SguwHkpLSzM9AtCKtOZjQhNh1xIfnkjVLL/iRzfn\n7f/9my45va7qQgj5HYZ1z81+bNrntWcrS6e/srRit2Fdm14CAKBBLfGM3fLPfv/W8srTBhT+\n+5VX6jYm22w/sF/RuBE7/fC3E5/e8oKdOpQ/eMPkwu4HjuxWGEIIiWSjSwAANKQlwq7kv++H\nEH579RX1Nxb1mvD76/boc9zlZ5Vfd/fkCQvKEr0HDp00bnTiyws0sQQAwJpaIuy6DfvpQ8Ma\nWUtkHzhq3IGj1nEJAIA1tNCfFAMAoLkJOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgI\nOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBI\nCDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCA\nSAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsA\ngEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7\nAIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASAg7AIBICDsAgEgIOwCASORkeoCNIJFIFBYW\nZnoKYNPmMALU12qPCTU1NU2sxhB2IYSsLE89AhvEYQSor9UeExKJRBOrMYRdKpVaunRppqcA\nNm0OI0B9rfmYkJ+f39hSK61RAADWlbADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLAD\nAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISw\nAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiE\nsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCI\nhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMAiISwAwCIhLADAIiEsAMA\n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\nv3V2srD/+G3arbZUWfrf6W8u7jxw9+NPP//4088PIcx8fFLfr19y7sX/ef3aDZp5vfe88e43\n0Kr5uhNgU5WT32di305v/37U3z9b+ba5e84+8oQTTvgwK1Qtn1WdSnUatHvd0vJPp/3i46Uh\npPW1c6kmL1VTtXDySftOLSkfetkf2mav/ia7ZXNv3nvvvb911X/qtmz3lT1CCFXLqjZw5vXe\nM7CZ8IwdsAkb+9hNt+5w4qG9+3/z+G/svn2nGU9P+f2Ts3c5+fcjuxSEmuMP6HzWM9ccfk7y\n/N23Lpjz5ku33fJQ7675FR9Nv/6Pfz7thBGFWWt86iGEEEKyXTKE8Jsbbivfec9vH79X7cb3\n7vn5j16tfadbTcnnH0595ME3567Y/ugrHvnBwDX3ULTdTw7Y4jd/n/S1r885Ze9+vWoWv//A\nbbdnJztPvHLXDZx5/fcMbCYy/bFcgNXVft3Jt2ctWHPpsb23CvW+7iT1/+3cPyvEYQDA8bjr\nOufuOnfUiXQZxCJZpNQpBmG4zaIMBpPXoFu9BfIWDAaK1aZYDFYZFMlwKVweC/XLYJDF4/NZ\nn54/47eepyeEx6ujjUa9WspncuXRiZmtncPXt4+h1vXJ2sLUQKW7WB2eXVo9uHy4O9uu9eQy\n+b6b53YIYW+knC3NfdnipXWxPFnLptL9483w+d1JUlehPDa92Nw9bidmJb87CSE83Z5urswP\n9RbTnalCZbDeWN8/v/+VM/94ZeA/6Ajf3zcAAPBHeHkBABAJYQcAEAlhBwAQCWEHABAJYQcA\nEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABAJYQcAEAlhBwAQCWEHABCJd2ab2NQQXZNIAAAA\nAElFTkSuQmCC"
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "heart_failure %>%\n",
    "group_by(HeartDisease) %>%\n",
    "summarize(count = n()) %>%\n",
    "ggplot() +\n",
    "geom_col(aes(x = factor(HeartDisease), y = count)) +\n",
    "labs(x = \"HeartDisease\", y = \"Count\") +\n",
    "ggtitle(\"Distribution of Heart Failure\")"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 6.940054,
   "end_time": "2023-07-05T16:43:35.020451",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2023-07-05T16:43:28.080397",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
