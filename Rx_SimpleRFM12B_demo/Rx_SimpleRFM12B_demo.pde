//Simple RFM12B wireless demo - Receiver - no ack
//Glyn Hudson openenergymonitor.org GNU GPL V3 7/7/11
//Credit to JCW from Jeelabs.org for RFM12 

#include <RF12.h>
#include <Ports.h> //from jeelabs.org

#define myNodeID 30          //node ID of Rx (range 0-30) 
#define network     212      //network group (can be in the range 1-250).
#define freq RF12_433MHZ     //Freq of RF12B can be RF12_433MHZ, RF12_868MHZ or RF12_915MHZ. Match freq to module

#define RADIO_SYNC_MODE 2 //sync mode to 2 if fuses are Arduino default. Mode 3, full powerdown) only used with 258 CK startup fuse

#define COLLECT 0x20 // collect mode, i.e. pass incoming without sending acks


typedef struct {		//data Structure to be sent, called payload
  	  int data1;		// current transformer 1]
	  float data2;		// emontx voltage
} Payload;
Payload demo;

void setup() {
  
  rf12_initialize(myNodeID,freq,network);   //Initialize RFM12 with settings defined above  
  Serial.begin(9600); 
  Serial.println("RF12B demo Receiver - Simple demo"); 
  
  Serial.print("Node: "); 
  Serial.print(myNodeID); 
  Serial.print(" Freq: "); 
  Serial.print("433Mhz"); 
  Serial.print(" Network: "); 
  Serial.println(network);
}

void loop() {
  
  if (rf12_recvDone() && rf12_crc == 0 && (rf12_hdr & RF12_HDR_CTL) == 0) {
    demo=*(Payload*) rf12_data;            // Get the payload
    
   Serial.print(demo.data1); Serial.print("  ");
   Serial.println(demo.data2); 
  }
}