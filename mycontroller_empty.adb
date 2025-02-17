with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Ultrasonic;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;

package body MyController_empty is

   protected body UpdateSensor is

            -- front sensor
      function Get_Sensor_Front return Distance_cm is
      begin
         if distance_front < 0 or distance_front > 35 then
            return 0;
         else
            return distance_front;
         end if;

      end Get_Sensor_Front;

      -- right sensor
      function Get_Sensor_Right return Distance_cm is
      begin
         if distance_right < 0  or distance_right > 35 then
            return 0;
         else
            return distance_right;
         end if;

      end Get_Sensor_Right;

      -- left sensor

      function Get_Sensor_Left return Distance_cm is
      begin
         if distance_left < 0 or distance_left > 35 then
            return 0;
         else
            return distance_left;
         end if;

      end Get_Sensor_Left;

      -- back sensor

      function Get_Sensor_Back return Distance_cm is
      begin
         if distance_back < 0  or distance_back > 35 then -- we arent interested in cars that far away
            return 0;
         else
            return distance_back;
         end if;

      end Get_Sensor_back;

      procedure UpdateDistances(F, R, L, B : Distance_cm) is
      begin
         distance_front := F;
         distance_right := R;
         distance_left  := L;
         distance_back  := B;

         --  Put_Line("Updated distance");
         --  Put_Line("Front: " & Distance_cm'Image(distance_front));
         --  Put_Line("Right: " & Distance_cm'Image(distance_right));
         --  Put_Line("Left: " & Distance_cm'Image(distance_left));
         --  Put_Line("Back: " & Distance_cm'Image(distance_back));

      end UpdateDistances;


   end UpdateSensor;

   protected body MakeDecisions is

      --  function detectThreat return Boolean is
      --  begin

      --     threatFront := SharedDataSense.Get_Sensor_Front <= 20;
      --     threatFront := SharedDataSense.Get_Sensor_Front <= 20;
      --     threatFront := SharedDataSense.Get_Sensor_Front <= 20;
      --     threatFront := SharedDataSense.Get_Sensor_Front <= 20;
      --     if SharedDataSense.Get_Sensor_Front <= 20 then
      --        threatFront := True;
      --        return threatFront;
      --     elsif SharedDataSense.Get_Sensor_Right <= 20 then
      --        threatRight := True;
      --        return threatRight;
      --     elsif SharedDataSense.Get_Sensor_Left <= 20 then
      --        threatLeft := True;
      --        return threatLeft;
      --     elsif SharedDataSense.Get_Sensor_Back <= 20 then
      --        threatBack := True;
      --        return threatBack;
      --     end if;
      --  end detectThreat;

      --  function GetThreatFront return Boolean is
      --  begin
      --     return threatBack;
      --  end GetThreatFront;

      --  function GetThreatRight return Boolean is
      --  begin
      --     return threatRight;
      --  end GetThreatRight;

      --  function GetThreatLeft return Boolean is
      --  begin
      --  return ;
      --  function GetThreatBack return Boolean;

      --  procedure ThreatAtFront is
      --     begin
      --        if SharedDataSense.Get_Sensor_Front <= 35 then
      --        threatFront := True;
      --     end if;
      --  end ThreatAtFront;

      --  procedure ThreatAtRight is
      --     begin
      --        if SharedDataSense.Get_Sensor_Right <= 35 then
      --        threatRight := True;
      --     end if;
      --  end ThreatAtRight;


      --  procedure ThreatAtLeft is
      --     begin
      --        if SharedDataSense.Get_Sensor_Left <= 35 then
      --        threatLeft := True;
      --     end if;
      --  end ThreatAtLeft;


      --  procedure ThreatAtBack  is
      --     begin
      --        if SharedDataSense.Get_Sensor_Back <= 35 then
      --        threatBack := True;
      --     end if;
      --  end ThreatAtBack;



      --  function detectThreat return Threat_Side is
      --     Threat_Status : Threat_Side;
      --     begin
      --        Threat_Status.Front := SharedDataSense.Get_Sensor_Front <= 35;
      --        Threat_Status.Right := SharedDataSense.Get_Sensor_Right <= 35;
      --        Threat_Status.Left  := SharedDataSense.Get_Sensor_Left  <= 35;
      --        Threat_Status.Back  := SharedDataSense.Get_Sensor_Back  <= 35;

      --     return Threat_Status;

      --  end detectThreat;

      procedure SetNavigation is
      -- Found_Threats : Threat_Side;
      begin
         --current threat side using the detect threat function
         -- Found_Threats := detectThreat;

            if SharedDataSense.Get_Sensor_Front > 0 then
               command := Drive_Backwards;
               Put_Line("Threat Front, Drive Back");
            elsif SharedDataSense.Get_Sensor_Right > 0 then
               command := Drive_Lateral_Left;
               Put_Line("Threat Right, Drive Left");

            elsif SharedDataSense.Get_Sensor_Left > 0 then
               command := Drive_Lateral_Right;
               Put_Line("Threat Left, Drive Right");

            elsif SharedDataSense.Get_Sensor_Back > 0 then
               command := Drive_Forward;
               Put_Line("Threat Back, Drive Forward");
            else
               command := Drive_Forward;
               Put_Line("No threat, drive Forward");
            end if;

         --  else
         --     command := Drive_Forward;
         --     Put_Line("There is no threat");
         --  end if;

      end SetNavigation;





       function GetCommand return Drive_Direction is
       begin
            return command;
       end GetCommand;

      --   procedure ThreatAtFront is
      --   Found_Threats : Threat_Side;
      --   begin
      --   Found_Threats := detectThreat;

      --     if Found_Threats.Front then
      --           loop
      --           desiredDistance := SharedDataSense.Get_Sensor_Front;
      --           command := Drive_Backwards;
      --           Put_Line("There is a threat in the front");

      --           exit when desiredDistance >= 20;
      --           end loop;
      --     elsif not threatFront then
      --        command := Drive_Forward;
      --     end if;
      --   end ThreatAtFront;

      --   procedure ThreatAtRight is
      --   Found_Threats : Threat_Side;
      --   begin
      --   Found_Threats := detectThreat;

      --     if  Found_Threats.Right then
      --        loop
      --           desiredDistance := SharedDataSense.Get_Sensor_Right;
      --           command := Drive_Lateral_Left;
      --           Put_Line("There is a threat on the right");

      --           exit when desiredDistance >= 20;
      --        end loop;

      --        command := Rotate_Left_45;

      --     end if;

      --  end ThreatAtRight;

      --  procedure ThreatAtLeft is
      --  Found_Threats : Threat_Side;
      --  begin
      --  Found_Threats := detectThreat;

      --     if  Found_Threats.Left then
      --        loop
      --           desiredDistance := SharedDataSense.Get_Sensor_Left;
      --           command := Drive_Lateral_Right;
      --           Put_Line("There is a threat on the left");

      --           exit when desiredDistance >= 20;
      --        end loop;

      --        command := Rotate_Right_45;

      --     end if;
      --  end ThreatAtLeft;

      --  procedure ThreatAtBack is
      --  Found_Threats : Threat_Side;
      --  begin
      --  Found_Threats := detectThreat;
      --     if  Found_Threats.Back then
      --        loop
      --           desiredDistance := SharedDataSense.Get_Sensor_Back;
      --           command := Drive_Forward;
      --           Put_Line("There is a threat in the back");

      --           exit when desiredDistance >= 20;
      --        end loop;
      --     end if;
      --  end ThreatAtBack;

   end MakeDecisions;

   protected body ActOnDecision is

      procedure ExecuteDecision is
         Current_Command : Drive_Direction := DoTheDecision.GetCommand;
         should_Stop : Boolean := False;
         begin

         -- if the car should stop then this will start

         if should_Stop and (counter < counter_Stop) then
            MotorDriver.Drive(Stop, speed);
            Put_Line("Stopping car for 0.5 sec");
            counter := counter + 1;

            if counter >= counter_Stop then
               should_Stop := False;
               counter := 0;
            end if;

         else
            case Current_Command is
               when Drive_Backwards =>
                  begin
                     should_Stop := True;
                     speed := (4000, 4000, 4000, 4000);
                     MotorDriver.Drive(Backward, speed);
                     Put_Line("Driving Backward");
                     counter := 0;
               end;
               when Drive_Lateral_Right =>
                     begin
                        should_Stop := True;
                        speed := (3000, 3000, 3000, 3000);
                        MotorDriver.Drive(Lateral_Right, speed);
                        Put_Line("Drive lateral right");
                        counter := 0;
                     end;
               when Drive_Lateral_Left =>
                  begin
                     should_Stop := True;
                     speed := (3000, 3000, 3000, 3000);
                     MotorDriver.Drive(Lateral_Left, speed);
                     Put_Line("Drive lateral left");
                     counter := 0;
                  end;
               when Drive_Forward =>
                  begin
                     should_Stop := True;
                     speed := (4000, 4000, 4000, 4000);
                     MotorDriver.Drive(Forward, speed);
                     Put_Line("Drive forward");
                     counter := 0;
                  end;
               when NoCommand =>
                  begin
                        should_Stop := True;
                        speed := (2000, 2000, 2000, 2000);
                        MotorDriver.Drive(Forward, speed);
                        counter := 0;
                  end;
            end case;
         end if;
      end ExecuteDecision;

      procedure PrintCounter is
      begin
         Put("Counter: " & Integer'Image(counter));
      end PrintCounter;

   end ActOnDecision;

   ActOutDecision : ActOnDecision;

   task body sense is
      -- Start, Stop : Time;
      -- Elapsed : Time_Span;
   begin
      loop
         -- Start := Clock;

         SharedDataSense.UpdateDistances(sensor_front.Read, sensor_right.Read, sensor_left.Read, sensor_back.Read);
         --SharedDataSense.UpdateDistances( 100,100,100,100);
         Put_Line("Front: " & Distance_cm'Image(SharedDataSense.Get_Sensor_Front));
         Put_Line(" ");
         Put_Line("Right: " & Distance_cm'Image(SharedDataSense.Get_Sensor_Right));
         Put_Line(" ");
         Put_Line("Left: " & Distance_cm'Image(SharedDataSense.Get_Sensor_Left));
         Put_Line(" ");
         Put_Line("Back: " & Distance_cm'Image(SharedDataSense.Get_Sensor_Back));
         Put_Line(" ");

         -- Stop := Clock;
         --Elapsed := Stop - Start;
         --Put_Line ("Elapsed time" & To_Duration(Elapsed)'Image);

         delay (0.12); --simulate 50 ms execution time, replace with your code


         --MotorDriver.SetDirection (Stop);

         -- delay until myClock + Milliseconds(80);
      end loop;
   end sense;

   task body think is
      myClock : Time;
      -- Start, Stop : Time;
      -- elapsed : Time_Span;
   begin
      loop
         -- Start := Clock;
         myClock := Clock;

         DoTheDecision.SetNavigation;
         --  DoTheDecision.ThreatAtFront;
         --  DoTheDecision.ThreatAtRight;
         --  DoTheDecision.ThreatAtLeft;
         --  DoTheDecision.ThreatAtBack;

         -- Stop := Clock;
         -- elapsed := stop - start;
         -- Put_Line ("Elapsed time" & To_Duration(elapsed)'Image);


         delay until myClock + Milliseconds(70);
      end loop;
   end think;

   task body act is
      Start, Stop : Time;
      elapsed : Time_Span;
      myClock : Time;
   begin
      loop
         Start := Clock;
         myClock := Clock;

         ActOutDecision.ExecuteDecision;
         -- ActOutDecision.PrintCounter;
         Stop := Clock;
         elapsed := Stop - Start;
         Put_Line ("Elapsed time" & To_Duration(elapsed)'Image);

         delay until myClock + Milliseconds(60);
      end loop;
   end act;

   --   protected body MotorDriver is
   --     --  procedures can modify the data
   --     procedure SetDirection (V : Directions) is
   --     begin
   --        DriveDirection := V;
   --     end SetDirection;

   --     --  functions cannot modify the data
   --     function GetDirection return Directions is
   --     begin
   --        return DriveDirection;
   --     end GetDirection;
   --   end MotorDriver;
end MyController_empty;
