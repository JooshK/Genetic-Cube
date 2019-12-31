class DNA {
  //Each 'gene' is a list of moves
  //int[] genes;
  float fitness;
  ArrayList<Move> genes;
  int score;
  int num;
  Move childGenes;
  //Con. Makes random sequence
  DNA(int num) {
    //genes = new int[num];
    ArrayList<Move> genes = new ArrayList<Move>(num);
    for (int i = 0; i < genes.size(); i++) {
      int r = int(random(allMoves.length));
      Move m = allMoves[r];
      genes.add(m);
    }
  }
  void fitness(ArrayList<Move> n) {
    for (int i = 0; i < genes.size(); i++) {
      if (genes.get(i) == n.get(i)) {
        score++;
      }
    }
    fitness = pow(2, score);
  }

  //Prob broken from line 35 on 
  DNA crossover(DNA partner) {
    // A new child
    DNA child = new DNA(genes.size());

    int midpoint = int(random(genes.size())); // Pick a midpoint

    // Half from one, half from the other
    for (int i = 0; i < genes.size(); i++) {
      if (i > midpoint) {
        childGenes = child.genes.get(i);
        childGenes = genes.get(i);
      } else {
        childGenes = partner.genes.get(i);
      }
    }
    return child;
  }

  Move getMove(int index) {
    return genes.get(index);
  }



  // Based on a mutation probability, picks a new random character
  //If Err, bc it might replace whole array 
  void mutate(float mutationRate) {
    for (int i = 0; i < genes.size(); i++) {
      if (random(1) < mutationRate) {
        int r = int(random(allMoves.length));
        Move m = allMoves[r];
        genes.add(m);
      }
    }
  }
}
