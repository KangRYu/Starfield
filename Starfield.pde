import java.util.*; 

// Settings
double maxSpeed = 40;
int explosionSize = 50;
// States
List<Particle> allParticles = new ArrayList<Particle>();

void setup(){
	size(500, 500);
	// Style settings
	stroke(255);
	strokeWeight(2);
	noFill();
}
void draw(){
	background(30); // Redraws the background
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
}
void mousePressed() {
	for(int i = 0; i < explosionSize; i++) {
		allParticles.add(new Particle(mouseX, mouseY));
	}
}
class Particle {
	double x, y; // Position of the particle
	double w, h; // The dimensions of the particle
	double speed; // The speed of the particle
	double angle; // The angle of the particle in radians
	Particle(double argX, double argY) {
		x = argX;
		y = argY;
		w = 15 * Math.random();
		h = w;
		// Decides on random values for the speed of the particle and the angle of the particle
		speed = Math.random() * maxSpeed;
		angle = Math.random() * 360;
	}
	void move() { // Updates the position of the particle
		x += Math.cos(angle) * speed;
		y += Math.sin(angle) * speed;
		// Damps the speed
		speed *= 0.95;
	}
	void show() { // Draws the particle
		rect((float)x, (float)y, (float)x, (float)y);
		//ellipse((float)x, (float)y, (float)w, (float)h);
	}
}

class OddballParticle { //inherits from Particle
	//your code here
}


