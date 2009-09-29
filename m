From: Paul Moore <paul.moore@hp.com>
To: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: MCS and default labels
Date: Tue, 29 Sep 2009 16:54:07 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, russell@coker.com.au,
        Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>,
        selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
References: <20090908055806.GA24297@myhost.felk.cvut.cz> <1254226904.2252.28.camel@moss-pluto.epoch.ncsc.mil> <f73f7ab80909290654l25863d74n7b5919028cfde66d@mail.gmail.com>
In-Reply-To: <f73f7ab80909290654l25863d74n7b5919028cfde66d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <200909291654.07458.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 29 September 2009 09:54:56 am Kyle Moffett wrote:
> The problem is that there is no way to do catch-all rules *based* on
> the MLS label.  For example, if I have a TopSecret wire and I want to
> allow (for example) Unclass and TS//SI/TK traffic over it without
> risking mixing of data or exposure, there is no way for me to set it
> up without a lot of manual and duplicated configuration.  What I want
> to happen is:

Just a few questions so I'm clear on your problem.

>   (1) If any of 8 different SELinux domains of TS-level processes (IE:
> s4) try to communicate out the network interface, the policy is "none"

So any of the eight domains can send network traffic w/o IPsec as long as 
their MLS label is "s4" ...

>   (2) If those *same* SELinux domains with any of TS//SI/TK (s4:c1),
> TS//BYEMAN (s4:c2) try to communicate, the policy should be
> "esp/transport//require", using *different* certificates depending on
> the domain.

... and these same eight domains need to send network traffic using IPsec/ESP 
when their MLS label is "s4:c1" or "s4:c2" (do you really mean different 
certificates for each connection, which implies a new phase-1 IKE negotiation 
or did you simply mean new ESP SAs?)

>   (3) Again, if those *same* SELinux domains with U (IE: s1) try to
> communicate, the policy would be "ah/transport//require", (and yet
> more certificates).

... and if these same eight domains need to send network traffic using 
IPsec/AH when their MLS label is "s1" (once again, do you really mean SA 
instead of cert)?

> If it's possible to do this with the existing tools, that's great, but
> I played around with it for a good long while and was not able to work
> out a way to do so.

The different IPsec configurations per label is a little interesting, and not 
something that I've heard of people using (until just now).  I'd have to go 
spelunking in the code but I'm pretty sure you can't pick SPD rules based on 
security labels (you can authorize access to a rule using labels, but I don't 
believe the label acts as a selector).  I imagine you could get something 
working with manual SA creation but that is too ugly to spend much time 
thinking about it.

At this point I have to ask some workaround type questions - can you isolate 
the traffic using traditional IPsec traffic selectors instead of labels, e.g. 
protocol/port?  Is there any harm in applying both AH and ESP to all traffic 
that needs IPsec protection?  Do you need to convey the type information 
across the wire or is the MLS label sufficient?  Depending on your answers we 
may be able to arrive at a solution with the existing code.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
