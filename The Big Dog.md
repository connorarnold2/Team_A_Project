# Team_A_Project
Team Computing (Robotics) - CA
#pragma config(Sensor, S1,     lightSensor,    sensorLightActive)
#pragma config(Sensor, S2,     touchSensor,    sensorTouch)

//Global co-ordinates variables
int x = 0;
int y = 0;

//Orientation of robot
int pivot_right_fxn_counter = 0;
int pivot_left_fxn_counter = 0;

//Prototypes
void forward(void);
void wait(void);
void blackcell(void);
void back_it_up(void);
void pivot_left(void);
void pivot_right(void);

task main()
{
  int block_count = 0;

  //Infinite loop to put the robot in a cycle of actions
	while(1==1)
	{
		//As long as the touch sensor is not pressed, the NXT will navigate the map, calling these functions
		if(SensorValue(touchSensor) == 0)
		{
			forward();
			wait();
			blackcell();

			while(SensorValue(lightSensor) < 50)
			{
				blackcell();
			}//End while
		}//End if

		//Once the touch sensor has been pressed, these set of actions will be called
		else
		{
			block_count = block_count + 1;

			if(block_count == 1)
			{
			  ClearTimer(T1);
			  while(time1 [T1] < 2000)
			  {
			    nxtDisplayString(3, "Block 1 Found!");
			    motor[motorB] = 0;
			    motor[motorC] = 0;
			  }//End while
			}//End if

			if(block_count == 2)
		  {
		    ClearTimer(T1);
		    while(time1 [T1] < 2000)
		    {
		      nxtDisplayString(3, "Block 2 Found!");
		    }//End while

		    wait();

		    /*RETURN*/

		    break;
		  }//End if

			back_it_up();

			int block_direction = rand() % 2;

			if(block_direction == 0)
			{
			  pivot_left();
			}//End if

			else
			{
			  pivot_right();
			}//End else
		}//End else
	}//End while
}//End main

//Implement forward fxn
void forward(void)
{
	motor[motorB] = 30;
	motor[motorC] = 30;
	wait1Msec(920);

	//Configures orientation of robot
	if(pivot_right_fxn_counter > 1)
	{
		if((pivot_right_fxn_counter % 2) == 0)
		{
			x--;
		}//End if

		else
		{
			y--;
		}//End else
	}//End if

	if(pivot_left_fxn_counter > 1)
	{
		if((pivot_left_fxn_counter % 2) == 0)
		{
			x--;
		}//End if

		else
		{
			y++;
		}//End else
	}//End if
}//End forward fxn

//Implement wait fxn
void wait()
{
	ClearTimer(T1);

	while(time1 [T1] < 1000)
	{
		motor[motorB] = 0;
		motor[motorC] = 0;

		nxtDisplayString(3, "%d, %d", x, y);
	}//End while
}//End wait fxn

//Implement blackcell fxn
void blackcell()
{
	if(SensorValue (lightSensor) < 50)
	{
		back_it_up();

		int direction = rand() % 2;
		int last_turn;

		if ((direction == 0) && (last_turn == 0))
		{
			pivot_right();
			last_turn = 1;
		}//End if

		else
		{
			pivot_left();
			last_turn = 0;
		}//End else

		wait();
	}//End if
}//End blackcell fxn

//Implement back_it_up
void back_it_up()
{
	motor[motorB] = -30;
	motor[motorC] = -30;
	wait1Msec(180);
}//End back_it_up fxn

//Implement pivot_right fxn
void pivot_right()
{
	motor[motorB] = -30;
	motor[motorC] = 30;
	wait1Msec(600);

	pivot_right_fxn_counter++;
}//End pivot_right fxn

//Implement pivot_left fxn
void pivot_left()
{
	motor[motorB] = 30;
	motor[motorC] = -30;
	wait1Msec(600);

	pivot_left_fxn_counter++;
}//End pivot_left fxn
