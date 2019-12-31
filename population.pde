class Population {

  float mutationRate;           // Mutation rate
  DNA[] population;             // Array to hold the current population
  ArrayList<DNA> matingPool;    // ArrayList which we will use for our "mating pool"
  int generations;              // Number of generations
  boolean finished;             // Are we finished evolving?
  int perfectScore;
  ArrayList<Move> target;
  int fitness;
  int score;

  Population(float m, ArrayList<Move> p, int num) {
    mutationRate = m;
    target = p;
    population = new DNA[num];
    calcFitness();
    matingPool = new ArrayList<DNA>();
    finished = false;
    generations = 0;

    for (int i = 0; i < p.size(); i++) {
      score++;
    }
    fitness = int(pow(2.0, score));
    perfectScore = fitness;
  }

  void calcFitness() {
    for (int i = 0; i < population.length; i++) {
      population[i].fitness(target);
    }
  }
  
  void natrualSelection() {
    matingPool.clear();
    float maxFitness = 0;
    for (int i = 0; i < population.length; i++) {
      if (population[i].fitness > maxFitness) {
        maxFitness = population[i].fitness;
      }

      for (int k = 0; k < population.length; k++) {
        float fitness = map(population[k].fitness, 0, maxFitness, 0, 1);
        int n = int(fitness * 100);  

        for (int j = 0; j < n; j++) {            
          matingPool.add(population[i]);
        }
      }
    }
  }

  void generate() {
    for (int i = 0; i < population.length; i++) {
      int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));
      DNA partnerA = matingPool.get(a);
      DNA partnerB = matingPool.get(b);
      DNA child = partnerA.crossover(partnerB);
      child.mutate(mutationRate);
      population[i] = child;
    }
    generations++;
  }

  boolean finished() {
    return finished;
  }

  int getGeneration() {
    return generations;
  }

  float getAverageFitness() {
    float total = 0;
    for (int i = 0; i < population.length; i++) {
      total += population[i].fitness;
    }
    return total / (population.length);
  }


  Move getBest() {
    float worldrecord = 0.0f;
    int index = 0;
    for (int i = 0; i < population.length; i++) {
      if (population[i].fitness > worldrecord) {
        index = i;
        worldrecord = population[i].fitness;
      }
    }

    if (solved) finished = true;
    return population[index].getMove(index);
  }
}
