"v1a1l1e1_setup.scd".loadRelative; // carico synthdef, snippets e campioni, anche se non utilizzerò campioni

~k = Pbind(\instrument, \kick, \dur, Pbjorklund2(3,16),\amp,0.4); // cassa 1
~k2 = Pbind(\instrument,\kick2,\dur,1,\amp,Prand([0.3,0.5],inf)); // cassa 2

~k1.play;~k2.play; // play delle due casse in sync

~hh = Pbind(\instrument,\hh,\dur,Pseq([0.5,Pseq([0.5],inf)],inf),\amp,0.3); // hihat offsettati
~hh.stop;

~rev = {GVerb.ar(Mix.ar([~pitch_s.ar,~chaos.ar,~mix.ar,~n_env.ar,~bd.ar,~hh.ar]),80,60,LFNoise0.kr(0.1).range(0.5,0.8))}; // riverbero (è cresciuto nel corso della performance)
~rev.stop(10);

~bd = Pbind(\instrument,\bd,\amp,0.2,\dur,1); // tom
~bd.play;

~r1 = Pbind(\instrument,\ring1,\d,0.4,\dur,0.25,\scale,Scale.chromatic(\et12),\degree,Prand([2,6,9,11],inf),\octave,2,\amp,0.4); // linea di basso 1
~r2 = Pbind(\instrument,\ring1, \d,0.3,\dur,0.25,\scale,Scale.chromatic(\et12),\degree,Pstutter(2,Prand([2,6,10,-4],inf)),\ocatve,3,\amp,0.3); // linea di basso 2
~r1.play;~r2.play; // linee di basso in play in sync

// costruzione del noise
~n = {RLPFD.ar(Pan2.ar(WhiteNoise.ar(1),0),LFNoise1.kr(0.1).range(200,1000),LFNoise0.kr(0.1).range(0.2,0.5),TRand.kr(0.001,0.4,Dust.kr(4)))};
~n_env={EnvGen.ar(Env.perc(0.001,0.01))}; // inviluppo del noise
~noise= {~n*~n_env};
~n_del = {CombC.ar(Mix.ar(~noise.ar),0.2,LFNoise0.kr(0.1).range(0.2,0.4),5,0.4)};
~n.play;
~k2.stop(10);
~hh.stop(30);

~r1.stop(60);

~bd.stop(10);
~sine = {SinOsc.ar([60,60.2],0,0.2)};
~pulse = {Pulse.ar([10,10.1],LFNoise0.kr(0.1).range(0.001,0.9),0.5)};
~mix = { ~sine * ~pulse};
~mix.play;   // segnale pulsato

~henon = {Henon2DN.ar(2200,LFNoise0.kr(0.1).range(3300,5500).round(1100),LFNoise2.kr(0.5,0.2,1.2),LFNoise2.kr(0.1,0.15,0.15))*0.5};
~chaosEnv = {EnvGen.ar(Env.perc(0,0.02),Dust.kr(SinOsc.kr(0.01).range(1,10)))};
~chaos = {Pan2.ar(~henon*~chaosEnv)};
~henon.stop;~chaosEnv.stop;
~chaos.stop; // generatore caotico

~pitch_s = {PitchShift.ar(Mix.ar([~noise.ar]),0.2,TRand.kr(0.1,1.2,Dust.kr(2)))};
~pitch_s.stop; // pitch shifter sul noise

~k = Pbind(\instrument,\kick,\amp,5,\dur,1); // cassa
~k.play;




~bd.stop;
~k.stop(5);