//FUNCTION wavefront algorithm to find most efficient path to goal
void WavefrontSearch()
{
  int goal_x, goal_y;
  bool foundWave = true;
  int currentWave = 2; //Looking for goal first
 
  while(foundWave == true)
  {
    foundWave = false;
    for(int y=0; y < y_size; y++)
    {
      for(int x=0; x < x_size; x++)
      {
        if(map[x][y] == currentWave)
        {
          foundWave = true;
          goal_x = x;
          goal_y = y;
 
          if(goal_x > 0) //This code checks the array bounds heading WEST
            if(map[goal_x-1][goal_y] == 0)  //This code checks the WEST direction
              map[goal_x-1][goal_y] = currentWave + 1;
 
          if(goal_x < (x_size - 1)) //This code checks the array bounds heading EAST
            if(map[goal_x+1][goal_y] == 0)//This code checks the EAST direction
              map[goal_x+1][goal_y] = currentWave + 1;
 
          if(goal_y > 0)//This code checks the array bounds heading SOUTH
            if(map[goal_x][goal_y-1] == 0) //This code checks the SOUTH direction
              map[goal_x][goal_y-1] = currentWave + 1;
 
          if(goal_y < (y_size - 1))//This code checks the array bounds heading NORTH
            if(map[goal_x][goal_y+1] == 0) //This code checks the NORTH direction
              map[goal_x][goal_y+1] = currentWave + 1;
        }
      }
    }
    currentWave++;
    PrintWavefrontMap();
    wait1Msec(500);
  }
}
