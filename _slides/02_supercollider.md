# SuperCollider


<!-- .slide: data-background-size="contain" data-background-color="#000" data-background-image="/_images/na/james_mccarty_emu.jpg" -->
<!-- james McCartney -->


<!-- .slide: data-background-size="contain" data-background-color="#fff" data-background-image="/_images/na/survey_253/platforms.png" -->
<!-- question 4 -->


>lo stato dell'arte nell'ambito della programmazione audio: non c'è altro software disponibile che sia insieme così potente, efficiente e flessibile.

<p style="font-size:0.5em">Andrea Valle, 2015</p>


<!-- .slide: data-background-size="contain" data-background-color="#fff" data-background-image="/_images/na/survey_253/what_I_think_of_SC.png" -->
<!-- what people think -->



# Applicazioni


<!-- .slide: data-background-size="contain" data-background-color="#000" data-background-image="/_images/na/A.png" -->
<!-- Composizione Elettroacustica / Physical  computing -->


<!-- .slide: data-background-size="contain" data-background-color="#fff" data-background-image="/_images/na/B.png" -->
<!-- Data sonification -->


<!-- .slide: data-background-size="contain" data-background-color="#000" data-background-image="/_images/na/08-DOTDOTDOT_Enel_Trezzo.jpg" -->
<!-- Spazializzazione / complessi sistemi multicanale -->


<!-- .slide: data-background-size="contain" data-background-color="#000" data-background-image="/_images/na/Dotdotdot_M9_FilippoBamberghi_2018_07-p-1600.jpg" -->
<!-- Audio interattivo in contesti multimediali -->


<!-- .slide: data-background-size="contain" data-background-color="#000" data-background-image="/_images/na/C.png" -->
<!-- Live-coding / laptop ensemble -->


<!-- .slide: data-background-size="contain" data-background-color="#fff" data-background-image="/_images/na/D.png" -->
<!-- e molto altro... -->



# Utenti


<!-- .slide: data-background-size="contain" data-background-color="#fff" data-background-image="/_images/na/survey_253/use_of_SC.png" -->
<!-- question 9 -->


<!-- .slide: data-background-size="contain" data-background-color="#fff" data-background-image="/_images/na/survey_253/SC_community.png" -->
<!-- word cloud -->



# Architettura


>SuperCollider is an <strong style="color:#fee715;">environment</strong> and <strong style="color:#fee715;">programming language</strong> originally released in 1996 by James McCartney for <strong style="color:#fee715;">real-time audio synthesis</strong> and <strong style="color:#fee715;">algorithmic composition</strong>

<p style="font-size:0.5em, text-color:#f00">Wikipedia</p>


<!-- .slide: data-background-color="#fff" -->
![architecture](/_images/na/structureEn.png)<!-- .element: style="width:90%; height:auto;" -->


<!-- .slide: data-background-color="#fff" -->
![architecture](/_images/na/scEn.png)<!-- .element: style="width:90%; height:auto;" -->



# Clients


<!-- .slide: data-background-size="contain" data-background-color="#fff" data-background-image="/_images/na/survey_253/SC_clients.png" -->
<!--question 7 -->



# Hands on


<!-- .slide: data-background-size="contain" data-background-color="#000" data-background-image="/_images/na/03.png" -->
<!--question 7 -->



# SuperCollider


## Sintesi e campioni


### definizione di synth (SynthDef)

<p style="font-size:0.6em;text-align:left;">
SynthDef(\k,{|out=0, amp=1|<br/>
	var sig, env, freq, body, env_b;<br/>
	freq = EnvGen.ar(Env([100, 60, 20],[0.001, 0.02]));<br/>
	sig =  LFPulse.ar(freq,0, 0.5);<br/>
	env = EnvGen.kr(Env([0.5,1,0.5,0],[0.001, 0.05, 0.2],[-4,-2,-4]), doneAction:2);<br/>
	sig = sig\*env;<br/>
	body = SinOsc.ar(freq,0, env);<br/>
	body = body + WhiteNoise.ar(0.5);<br/>
	sig = sig + body;<br/>
	sig = LPF.ar(sig, freq*1.5, env);<br/>
	sig = sig * 1.1;<br/>
	sig = sig.clip2(0.8);<br/>
	Out.ar(out, sig!2*amp);<br/>
}).add;
</p>


### lettura e manipolazione dei campioni
<p style="font-size:0.6em;text-align:left;">
SynthDef(\gplay2,<br/>
	{<br/>
	    |out=0, buf=0, rate=1, d=15, trig=1, pos=0, amp=0.5, pan=0|<br/>
	    sig,env;<br/>
	    sig = PlayBuf.ar(2,buf,BufRateScale.ir(buf) \* rate,
	    trig,BufDur.kr(buf)\*pos\*s.sampleRate,doneAction:2);<br/>
	    env = EnvGen.ar(Env.linen(0.0,d,0),doneAction:2);<br/>
	    psig = sig \* env;<br/>
	    Out.ar(out,Pan2.ar(sig*amp,pan));<br/>
}).add;</p>



## I pattern

Trasformazioni matematiche su stream di valori numerici

* Pattern per la generazione di stream di valori (es. Pseq, Prand, Pwhite)
* Pattern per la generazione di stream di eventi


### Pbind: pattern in SuperCollider

**Pbind** è usato per creare pattern sonori.
Si può specificare lo strumento da usare e la durata dell'evento sonoro. Inoltre tutti i valori specificati come argomenti nella definizione dello strumento sono controllabili tramite Pbind.


<p style="font-size:0.5em;text-align:left">
SynthDef(\synth1,{<br/>
	arg freq=220,amp=1,out=0,feedback=0,pan=0,atk=0.1,sus=0.3,rel=0.1;<br/>
	var sig = SinOscFB.ar(freq,feedback);<br/>
	var env = EnvGen.ar(Env.linen(atk,sus,rel),doneAction:2);<br/>
	Out.ar(out,Pan2.ar(sig*env*amp,pan));<br/>
	}).add;<br/></p>
<p style="font-size:0.5em;text-align:left">
Synth(\synth1,[\feedback,0.5]);<br/><br/>
<span style="color:yellow">
p=Pbind(<br/>\instrument,\synth1,<br/>\scale,Scale.chromatic(\et12),<br/>\degree,Pseq([0,3,7],inf),<br/>\dur, Pseq([1,0.5,0.5],inf),<br/>\feedback,Pwhite(0.01,0.7));
p.play;</span></p>


Sentiamolo!


## ProxySpace: creazione e manipolazione dei pattern in tempo reale

* Pbind
* PDef
* Pbindef
* TDef
* NDef
