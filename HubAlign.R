library(igraph)

net1 <- read.graph("Documents/Alignment/HubALIGN/HubAlign-master/example/Test1.tab","ncol")
net2 <- read.graph("Documents/Alignment/HubALIGN/HubAlign-master/example/Test2.tab","ncol")

bitscore <- read.table("Documents/Alignment/HubALIGN/HubAlign-master/example/Test1_Test2.bitscore",
                       sep = "\t")

if(gsize(net2) > gsize(net1)){
  network1 <- net2
  network2 <- net1
}else{
  network1 <- net1
  network2 <- net2
}

if(max(degree(network1) > max(degree(network2)))){
  maxDeg <- max(degree(network1))
}else{
  maxDeg <- max(degree(network2))
}

blast <- vector(length = gsize(network1))

blast <- matrix(0,nrow = gsize(network1),ncol = gsize(network2))

temp <- as.data.frame(matrix(0,nrow = gsize(network1),ncol = gsize(network2)),row.names = V(network1),
                      col.names= V(network2))

max <- max(bitscore$V3)

for (i in seq(nrow(bitscore))) {
  temp[bitscore[i,1],bitscore[i,2]] <- bitscore[i,3]
}

for (a in seq(gsize(network1))) {
  for (b in seq(gsize(network2))) {
    blast[a,b] <- temp[a,b] / max
  }
}

if(gsize(network2) > gsize(network1)){
  coeff <- gsize(network2) / gsize(network1)
}else{
  coeff <- gsize(network1) / gsize(network2)
}


alignScore <- matrix(0, nrow = gsize(network1), ncol = gsize(network2))
alignNodes1 <- rep(FALSE,gsize(network1))
alignNodes2 <- rep(FALSE,gsize(network2))
alignment <- rep(-1,gsize(network1))
best <- rep(-1,gsize(network1))


