import numpy as np
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans

DEFAULT_CLUSTER_FEATURES = [
    "tenure_days",
    "recency_days",
    "value_proxy",
    "true_cancellation_rate",
    "discount_sensitivity",
    "bundling_ratio",
    "avg_nights_stayed",
    "avg_bags",
]

def make_cluster_matrix(df: pd.DataFrame, features=None) -> pd.DataFrame:
    if features is None:
        features = DEFAULT_CLUSTER_FEATURES

    X = df[features].copy()

    # simple imputations
    for col in ["value_proxy", "bundling_ratio", "avg_nights_stayed", "avg_bags"]:
        if col in X.columns:
            X[col] = X[col].fillna(0)

    for col in ["true_cancellation_rate", "discount_sensitivity"]:
        if col in X.columns:
            X[col] = pd.to_numeric(X[col], errors="coerce").fillna(0).clip(0, 1)

    return X

def scale_for_clustering(X: pd.DataFrame):
    scaler = StandardScaler()
    return scaler.fit_transform(X)

def fit_kmeans_segments(df: pd.DataFrame, X_scaled, k=5):
    df = df.copy()
    km = KMeans(n_clusters=k, random_state=42, n_init=10)
    df["segment"] = km.fit_predict(X_scaled)
    return df

def segment_profile(df: pd.DataFrame, features=None):
    if features is None:
        features = DEFAULT_CLUSTER_FEATURES
    return df.groupby("segment")[features].mean().round
