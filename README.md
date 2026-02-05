# TravelTide Customer Segmentation

## Project Description
This project analyzes customer behavior data from TravelTide to build meaningful customer segments for business and marketing use cases.

## Project Summary
The goal of this project is to identify distinct customer segments based on lifecycle and behavioral features, and to compare a business-rule-based segmentation approach with machine learning clustering techniques.

Key outcomes:
- A business-driven segmentation used as the primary operational framework.
- A KMeans clustering model used as a benchmark.
- A fully unsupervised clustering approach used as additional validation.

## Data Preparation and Modeling
Primary user-level features were engineered in SQL and aggregated at the user level.
All numerical features were standardized using z-score normalization prior to clustering to ensure comparable feature scales.

## Key Points and Insights
- High-value customers exhibit low recency and high spending.
- Price-sensitive users show high discount sensitivity and higher bundling ratios.
- Inactive users are characterized by long recency and low overall value.
- Machine learning clusters largely align with business-defined segments.

## Links to Files

- [SQL Primary Feature Engineering](sql/primary_feature_engineering.sql)
- [User-Level Primary Features Dataset for Segmentation Analysis](data/user_primary_features.csv)
- [TravelTide Jupyter Notebook](TravelTide.ipynb)
- [Project Report and Executive Summary](reports/TravelTide_Project_Report.pdf)
- [Tableau Public Visualization Dashboard](https://public.tableau.com/app/profile/marija.pavlova/viz/Mappe2_17702397427380/Dashboard1)

### Segmentation Outputs and Visuals
- [Final CSV Dataset with Rewards Program](visuals/traveltide_final_users_rewards_program.csv)
- [Perks Mapping Visualization](visuals/Perks%20Mapping.png)
- [Sample User Personas Visualization](visuals/Real%20Personas.png)
- [Segment Profile Table](visuals/segment_profile.csv)
- [Segment Comparison Table](visuals/segment_comparison.csv)
- [Elbow Method Plot](visuals/elbow_method.png)
- [Silhouette Score Plot](visuals/silhouette_scores.png)
- [Boxplots of Clustering Features](visuals/boxplots_clustering_features.png)
- [Distribution of Average Nights Stayed](visuals/distribution_avg_nights_stayed.png)
- [Python Source Code (Feature Engineering & Segmentation)](src/)


## Installation
This project is designed to run in Google Colab.

## Usage
1. Open `TravelTide.ipynb` in Google Colab.
2. Run the first cell to mount Google Drive.
3. Run all cells in order to reproduce the analysis.

## Directory Structure
TravelTide/
├── sql/ # SQL scripts for primary feature engineering
├── src/ # Python source code for feature processing and segmentation
├── visuals/ # Generated plots, tables, and visual assets
├── data/ # User-level datasets and feature tables
├── TravelTide.ipynb # Main analysis and clustering notebook
├── README.md # Project overview and documentation
