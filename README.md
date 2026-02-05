# TravelTide Customer Segmentation

## Project Description
This project analyzes customer behavior data from TravelTide to build meaningful customer segments for business and marketing use cases.

## Project Summary
The main goal of this project is to identify distinct customer segments based on lifecycle and behavioral features, and to compare a business-rule-based segmentation with machine learning clustering.

Key outcomes:
- A business-driven segmentation used as the main operational framework.
- A KMeans clustering model used as a benchmark.
- A fully automatic clustering used as additional validation.

## Key Points and Insights
- High-value customers show low recency and high spending.
- Price-sensitive users have high discount sensitivity and bundling ratios.
- Inactive users show long recency and low value.
- Machine learning clusters largely align with business-defined segments.

## Links to Files
- [TravelTide Notebook](https://colab.research.google.com/drive/1uKo_wnUx-fGkJ7zp-MnUuiSvtUc8uJ2y?usp=drive_link)
- [Project Report and Executive Summary](https://drive.google.com/file/d/1zH2REMhhOW4CtbFRQVvXTybtBtHFQZvv/view?usp=sharing)
- [Tableau Public Visualization](https://public.tableau.com/app/profile/marija.pavlova/viz/Mappe2_17702397427380/Dashboard1)
- [Final CSV Dataset with Rewards Program](visuals/traveltide_final_users_rewards_program.csv)  
- [Segment Profile Table](visuals/segment_profile.csv)  
- [Segment Comparison Table](visuals/segment_comparison.csv)  
- [Elbow Method Plot](visuals/elbow_method.png)  
- [Silhouette Score Plot](visuals/silhouette_scores.png)  
- [Boxplots of Clustering Features](visuals/boxplots_clustering_features.png)  
- [Distribution of Avg Nights Stayed](visuals/distribution_avg_nights_stayed.png)	

## Installation
This project is designed to run in Google Colab.

## Usage
1. Open `TravelTide.ipynb` in Google Colab.
2. Run the first cell to mount Google Drive.
3. Run all cells in order to reproduce the analysis.

## Directory Structure
