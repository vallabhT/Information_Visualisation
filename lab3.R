plot(disease_prevalence)
plot(data_certainty)

str(disease_prevalence)

r <- aggregate(disease_prevalence, fact=4, mean)
plot(r) 

pixel_idx <- which(!is.na(getValues(r)))

# extracting the values from each pixel/raster cell
vals <- extract(r, pixel_idx)
coords <- xyFromCell(r, pixel_idx)   # technically we will be plotting the coordinates

coords
r
# the size of each coordinate point is dictated by this 'size' parameter:
size <- vals / max(vals)

size



r2 <- aggregate(data_certainty, fact=4, mean)
pixel_idx2 <- which(!is.na(getValues(r2)))

# same extracting principle
vals2 <- extract(r2, pixel_idx2)
coords2 <- xyFromCell(r2, pixel_idx2)



# value of uncertainty will play a role in the colour of the point in the plot
uncertainty <- vals2 / max(vals2)


par(mar = c(0, 0, 0, 0))



# using a continuous colour palette
Pal <- colorRampPalette(c('#e5f5e0','#00441b'))





# get plot
plot(coords, pch = 19, cex = size * 2.5, asp = 1,   # plot points with cex = size
     axes = FALSE, xlab = "", ylab = "",
     col = Pal(10)[as.numeric(cut(uncertainty, breaks = 10))])


# figuring out point sizes and text for the legend
# point size

minimum <- round(min(vals), 2)
maximum <- round(max(vals), 2)
middle <- round(minimum + (maximum - minimum)/2, 2)

legendText1 <- paste0(minimum * 100, "%")
legendText2 <- paste0(middle * 100, "%")
legendText3 <- paste0(maximum * 100, "%")


legend(-4000000, -1500000, # legend 1
       legend = c(legendText1, legendText2, legendText3),
       pch = c(19, 19, 19),
       pt.cex = c(0.01, 2.5/2, 2.5),
       col = c("#74c476", "#74c476", "#74c476"),
       title = "Prevalence:",
       bty = "n")


legend(-4000000, -2500000,    # legend 2
       legend = c("Low", "Mid", "High"),
       pch = c(19, 19, 19),
       pt.cex = c(2.5/2, 2.5/2, 2.5/2),
       col = c("#e5f5e0", "#74c476", "#00441b"),
       title = "Certainty:",
       bty = "n")


