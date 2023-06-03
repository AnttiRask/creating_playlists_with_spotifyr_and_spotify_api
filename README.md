# SpotifyAPI

The code for this repo was originally written by [Marc Eixarch](https://github.com/Marceix).

I've made some minor changes to the code, but my main contribution here was to add the _scopes_ that are nowadays needed to use the Spotify API.

## What you need to do if you wish to use the code:

1) Get Spotify API Keys (you can find instructions in Marc's [original repo](https://github.com/eivicent/r-meetups-hki/tree/main/2023_03_28_SpotifyR)
2) Create secret.R in the R folder
3) Add these lines (replace the placeholders with your own Spotify keys):

.SPOTIFY_CLIENT_ID     <- "<your Spotify Client ID here>"
.SPOTIFY_CLIENT_SECRET <- "<your Spotify Client Secret here>"
.USER_ID               <- "<your Spotify User Name here>"