import java.util.*; 

// Settings
double maxSpeed = 5;
int explosionSize = 50;
int spawnInterval = 10;
// States
List<Particle> allParticles = new ArrayList<Particle>();
int interval = 0;

void setup(){
	size(500, 500);
	// Style settings
	stroke(255);
	strokeWeight(2);
	noFill();
	rectMode(CENTER);
}
void draw(){
	background(30); // Redraws the background

	// Spawns particles
	if(interval == spawnInterval) {
		for(int i = 0; i < explosionSize; i++) {
			if(Math.random() * 100 < 33) {
				allParticles.add(new Particle(width/2, height/2));
			}
			else {
				allParticles.add(new SquareParticle(width/2, height/2));
			}
		}
		interval = 0; // Reset interval
	}

	List<Particle> persistingParticles = new ArrayList<Particle>(); // Temp array that holds the particles that will carry over
	for(Particle parts : allParticles) { // Iterates through all particles
		parts.move();
		parts.show();
		if(!(parts.x > width + parts.w / 2 || parts.x < -parts.w / 2 || parts.y > height + parts.h / 2 || parts.y < -parts.h / 2)) {
			if(parts.speed > 0.1) { // Only keeps particle if it still has some speed
				persistingParticles.add(parts);
			}
		}
	}

	allParticles.clear(); // Clears the array
	allParticles = persistingParticles; // Overwrite the particles array with the particles that are still visible within the screen

	interval++; // Iterates the interval
}

class Particle {
	double originX, originY; // The position the particle started from
	double x, y; // Position of the particle
	double w, h; // The dimensions of the particle
	double speed; // The speed of the particle
	double angle; // The angle of the particle in radians
	Particle(double argX, double argY) {
		x = argX;
		y = argY;
		originX = x;
		originY = y;
		w = 15 * Math.random();
		h = w;
		// Decides on random values for the speed of the particle and the angle of the particle
		speed = Math.random() * maxSpeed;
		angle = Math.toRadians(Math.random() * 360);
		// Offset position a bit from the center
		x += Math.cos(angle) * 50;
		y += Math.sin(angle) * 50;
	}
	void move() { // Updates the position of the particle
		x += Math.cos(angle) * speed;
		y += Math.sin(angle) * speed;
		// Damps the speed
		speed *= 1.05;
	}
	void show() { // Draws the particle
		ellipse((float)x, (float)y, (float)(w * (distanceFromOrigin()/50)), (float)(h * (distanceFromOrigin()/50)));
	}
	double distanceFromOrigin() { // Returns the distance from the origin based on the current position
		double displacementX = x - originX;
		double displacementY = y - originY;
		double displacement = Math.sqrt(pow((float)displacementX, 2) + pow((float)displacementY, 2));
		return Math.abs(displacement);
	}
}

class SquareParticle extends Particle { //inherits from Particle
	SquareParticle(double argX, double argY) {
		super(argX, argY);
	}
	void show() {
		rect((float)x, (float)y, (float)w, (float)h);
	}
}


