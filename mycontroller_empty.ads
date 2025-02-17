with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Types;
with MicroBit.Ultrasonic;
use MicroBit;
with MicroBit.Types; use MicroBit.Types;
with MicroBit.MotorDriver; use MicroBit.MotorDriver;
with Priorities;

package MyController_empty is

   package sensor_front is new Ultrasonic(Trigger_Pin => MB_P1, Echo_Pin => MB_P0);
   package sensor_right is new Ultrasonic(Trigger_Pin => MB_P15, Echo_Pin => MB_P2);
   package sensor_left  is new Ultrasonic(Trigger_Pin => MB_P13, Echo_Pin => MB_P12);
   package sensor_back  is new Ultrasonic(Trigger_Pin => MB_P14, Echo_Pin => MB_P16);

   --  package sensor_front is new Ultrasonic(Trigger_Pin => MB_P16, Echo_Pin => MB_P0);
   --  package sensor_right is new Ultrasonic(Trigger_Pin => MB_P15, Echo_Pin => MB_P1);
   --  package sensor_left  is new Ultrasonic(Trigger_Pin => MB_P13, Echo_Pin => MB_P12);
   --  package sensor_back  is new Ultrasonic(Trigger_Pin => MB_P14, Echo_Pin => MB_P2);





   -- protected for sense task
   protected type UpdateSensor is

      function Get_Sensor_Front  return Distance_cm;
      function Get_Sensor_Right  return Distance_cm;
      function Get_Sensor_Left   return Distance_cm;
      function Get_Sensor_Back   return Distance_cm;

      procedure UpdateDistances(F, R, L, B : Distance_cm);

      private

         distance_front : Distance_cm := 0;
         distance_right : Distance_cm := 0;
         distance_left  : Distance_cm := 0;
         distance_back  : Distance_cm := 0;

   end UpdateSensor;

   -- variable so that we can use the UpdateSensor
   SharedDataSense : UpdateSensor;

   -- new types for think tasken

      type Drive_Direction is(Drive_Forward,
                              Drive_Backwards,
                              Drive_Lateral_Right,
                              Drive_Lateral_Left,
                              -- Rotate_Right_45,
                              --Rotate_Left_45,
                              --Stop_Driving,
                              NoCommand);

   -- this type is not used anymore

   --  type Threat_Side is record
   --     Front : Boolean := False;
   --     Right : Boolean := False;
   --     Left  : Boolean := False;
   --     Back  : Boolean := False;
   --  end record;

   -- protected for think task

   protected type MakeDecisions is

      --  function detectThreat return Threat_Side;

      procedure SetNavigation;

      function GetCommand return Drive_Direction;

      --  function Stop_Car return Boolean;

      --  function GetThreatFront return Boolean;
      --  function GetThreatRight return Boolean;
      --  function GetThreatLeft return Boolean;
      --  function GetThreatBack return Boolean;

      --  procedure ThreatAtFront;
      --  procedure ThreatAtRight;
      --  procedure ThreatAtLeft;
      --  procedure ThreatAtBack;

      private

      --  threatFront : Boolean := False;
      --  threatRight : Boolean := False;
      --  threatLeft  : Boolean := False;
      --  threatBack  : Boolean := False;

      command : Drive_Direction := NoCommand;



   end MakeDecisions;

   -- variable so that we can use MakeDecisions

   DoTheDecision : MakeDecisions;

   protected type ActOnDecision is
      procedure ExecuteDecision;
      procedure PrintCounter;

      -- procedure Rotate;
      private

      speed : Speeds := (0, 0, 0, 0); --the defult is just stand there
      counter : Natural := 0;
      counter_Stop : Natural := 50; -- for 0.5 s
      should_Stop : Boolean := False;

   end ActOnDecision;

   type Directions is (Forward, Stop);

   task sense with Priority => Priorities.sense;

   task think with Priority=> Priorities.think; -- what happens for the set direction if think and sense have the same prio and period?
                                 -- what happens if think has a higher priority? Why is think' set direction overwritten by sense' set direction?

   task act with Priority=> Priorities.act;







   --  protected MotorDriver is
   --     function GetDirection return Directions;
   --     procedure SetDirection (V : Directions);
   --  private
   --     DriveDirection : Directions := Stop;
   --  end MotorDriver;
end MyController_empty;



