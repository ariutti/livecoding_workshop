("setup.scd").loadRelative;

~kick = Pbind(\instrument, \kick, \dur, 1, \amp, 0.5);
~kick.play;

~hh = Pbind(\instrument, \hh, \dur, 2);
~hh.play;

~kick2 = Pbind(\instrument, \gplay1, \buf, d["k"][1], \amp, 0.2, \dur, 0.75, \rate, Pwhite(0.3,1.7));
~kick2.play;

~synth = Pbind(\instrument, \sinfb, \scale, Scale.major, \octave, Prand([3,4],inf), \degree, Prand([0,2,4,6,11],inf), \dur, 0.25, \fb, 0.6, \amp, 0.1);
~synth.play;

~bass = Pbind(\instrument, \bass2, \scale, Scale.major, \degree, Prand([2,4,7],inf), \octave, 2, \amp, 1);
~bass.play;

