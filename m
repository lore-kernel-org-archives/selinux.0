Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: Tracy R Reed <treed@ultraviolet.org>
Subject: Re: SELinux, KDE, and honeypots
Date: Thu, 10 Jul 2003 03:25:00 -0400
Cc: SELinux@tycho.nsa.gov
References: <200307082303.22083.wlsel@verizon.net> <20030709154140.B28893@ultraviolet.org>
In-Reply-To: <20030709154140.B28893@ultraviolet.org>
MIME-Version: 1.0
Message-Id: <200307100325.00769.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 09 July 2003 06:41 pm, Tracy R Reed wrote:
> On Tue, Jul 08, 2003 at 11:03:22PM -0400, Bill Laut spake thusly:
> > needs to be modified is kdm.  Is this a correct assumption, or should I
> > expect it to be more involved than that?
>
> rjc has already offered a good answer to this. kdm isn't easily patched,
> use something else or startx.
>

I appreciate what you're saying, but if I had to go the startx route it will 
be a burr under my saddle until I finally get kdm patched.  Maybe if I bloody 
my head from banging against it long enough, I'll think otherwise....

>
> > The idea I had was to create a pseudo-device driver that leverages
> > NetFilter to output all traffic from all TCP streams to a user-mode
> > daemon that writes the packets for each stream into their own separate
> > disk files (and governing
>
> I think this is a pretty slick idea. Although I doubt you have to make it
> as fancy as a device driver. I would log everything to an external host
> and let that external host also do the sniffing. It could save everything
> for a certain amount of time before deleting it (I might go for a week
> since this box shouldn't get much traffic and gentle probes can be made
> over a long period of time before they pick your box as a target or
> discover a vulnerability that will allow them to cause an access
> violation) and if there was an access violation it could permanently save
> all traffic up to that point and any future traffic of any ip that had
> communicated with the box within a minute before and after the violation
> occurred. Pretty much all of the vulnerabilities I am aware of cause
> instantaneous results but if there are some that might cause a time delay
> between the network traffic and the access violation  the window can be
> widened to an hour or a day or whatever. It just means we'll have more
> data to go through but this box should not be receiving much traffic
> anyhow.
>

Yes, I agree wth everything you said.  One of the contingencies I'm 
anticipating is something I call (for lack of a better term) a "refractive 
vector."  This is where the attacker slowly, carefully, methodically "cases" 
the target, ever so gently probing here and there, while installing the 
payload piece by piece while looking for a way in, but constantly vigilant to 
see if they've been detected.

Analyzing such refractive vectors can border on thaumatology--especially if 
they've been artfully hidden in deliberately-manufactured "background noise."

This is where large disk drives are a blessing, so that the necessary data are 
not lost over time--which can be one of the attacker's goals.

>
> Oh, and of course you would want to run the box in permissive mode for all
> of this so that their exploit can actually work and you can learn
> something.
>

Exactly.  This is the essence of my tangential labelling this abstraction as a 
honeypot, although if I were professional about it I would scrub all 
identifiable features so that the attacker couldn't fingerprint it as an 
SELinux-based box.  No sense setting a trap if the perp can detect it.

>
> > Does this idea sound reasonable?  Has someone already done it using
> > SELinux? If not, how would you improve it?
>
> I am not aware of anyone having done it either. Kinda wish I had thought
> of it actually. :) My suggestions for improvement are above. Sounds like a
> very interesting project.
>

Thank you.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
