# Libraries needed
library(conflicted)
library(shiny)
library(spotifyr)
library(tidyverse)

# Define UI for application 
ui <- fluidPage(
    # Application title
    titlePanel("Spotify Playlist Generator"),
    
    # Sidebar layout with input and output definitions
    sidebarLayout(
        sidebarPanel(
            numericInput("num_top_artists", "Number of top artists:", min = 1, max = 50, value = 5),
            numericInput("energy", "Minimum energy (0 - 1):", min = 0, max = 1, value = 0.6),
            numericInput("valence", "Minimum valence (0 - 1):", min = 0, max = 1, value = 0.6),
            actionButton("generate", "Generate Playlist")
        ),
        
        mainPanel(
            textOutput("playlist_link")
        )
    )
)

# Define server logic
server <- function(input, output) {
    observeEvent(input$generate, {
        # Get top artists
        my_top_artists <- get_my_top_artists_or_tracks(
            type          = "artists", 
            limit         = input$num_top_artists,  
            time_range    = "medium_term",
            authorization = get_authorized("user-top-read")
        )
        
        # Get song recommendations
        my_happy_and_energetic_songs <- get_recommendations(
            seed_artists = head(my_top_artists, 5) %>% pull(id),
            min_energy   = input$energy,
            min_valence  = input$valence
        )
        
        # Create an empty playlist
        playlist_id <- create_playlist(
            user_id       = .USER_ID,
            name          = str_glue("My Happy and Energetic Songs ({Sys.Date()})"),
            description   = "Generated with R!",
            authorization = get_authorized("playlist-modify-public")
        )$id
        
        # Populate the created playlist
        add_tracks_to_playlist(
            playlist_id   = playlist_id,
            uris          = my_happy_and_energetic_songs$id,
            authorization = get_authorized("playlist-modify-public")
        )
        
        output$playlist_link <- renderText(str_glue("The playlist was created. Here is the link: https://open.spotify.com/playlist/{playlist_id}"))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
