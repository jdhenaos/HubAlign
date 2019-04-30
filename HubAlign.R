library(igraph)

net1 <- read.graph("Documents/Alignment/HubALIGN/HubAlign-master/example/Test1.tab","ncol")
net2 <- read.graph("Documents/Alignment/HubALIGN/HubAlign-master/example/Test2.tab","ncol")

bitscore <- read.table("Documents/Alignment/HubALIGN/HubAlign-master/example/Test1_Test2.bitscore")

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

