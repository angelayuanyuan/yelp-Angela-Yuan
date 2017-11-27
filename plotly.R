Sys.setenv("plotly_username"="angelayuanyuan")
Sys.setenv("plotly_api_key"="a3TiWCGjFyJ4PFKUC7iX")

Sys.setenv('MAPBOX_TOKEN' = 'pk.eyJ1IjoiYW5nZWxheXVhbnl1YW4iLCJhIjoiY2phaW94NHd3MjJiZjJ6cGxqMjRzbmV0cyJ9.FXxSxGIl4vysLYWzehQlPw')

p <- info.chinese %>%
  plot_mapbox(lat = ~latitude, lon = ~longitude,
              split = ~stars, size=5,
              mode = 'scattermapbox', hoverinfo='name') %>%
  layout(title = 'Location of Chinese Restaurants',
         font = list(color='black'),
         plot_bgcolor = '#191A1A', paper_bgcolor = 'white',
         mapbox = list(style = 'light'),
         legend = list(orientation = 'h',
                       font = list(size = 8)),
         margin = list(l = 25, r = 25,
                       b = 25, t = 25,
                       pad = 2))

p

api_create(p,filename = "location-graph", sharing = "public")