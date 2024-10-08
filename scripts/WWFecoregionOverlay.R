## find the biome in the WWF Terrestrial Ecoregions of the World shapefile for specific lat/lon coordinates

# libraries
library(terra)

# coordinate example
lat.ex <- 43.608979250502436
lon.ex <- 3.878053035338895
pts <- vect(cbind(lon.ex, lat.ex), crs="+proj=longlat")

# WWF ecoregion polygon # download shapefile from: https://www.worldwildlife.org/publications/terrestrial-ecoregions-of-the-world
WWFecoregions <- vect("wwf_terr_ecos.shp") 
WWFecoregions
head(WWFecoregions['BIOME'])
table(WWFecoregions$BIOME)

# biome name key (https://databasin.org/datasets/68635d7c77f1475f9b6c1d1dbe0a4c4c/)
biome.names <- c('Tropical & Subtropical Moist Broadleaf Forests',
                 'Tropical & Subtropical Dry Broadleaf Forests',
                 'Tropical & Subtropical Coniferous Forests',
                 'Temperate Broadleaf & Mixed Forests',
                 'Temperate Conifer Forests',
                 'Boreal Forests/Taiga',
                 'Tropical & Subtropical Grasslands, Savannas & Shrublands',
                 'Temperate Grasslands, Savannas & Shrublands',
                 'Flooded Grasslands & Savannas',
                 'Montane Grasslands & Shrublands',
                 'Tundra',
                 'Mediterranean Forests, Woodlands & Scrub',
                 'Deserts & Xeric Shrublands',
                 'Mangroves')
biome.key <- data.frame('value'=seq(1,14,1), 'name'=biome.names)

# plot (warning: can take some time to plot)
terra::plot(WWFecoregions, 'BIOME')

# extract
ecoregpts <- terra::extract(WWFecoregions, pts)
biome.key$name[which(biome.key$value == ecoregpts$BIOME)]
