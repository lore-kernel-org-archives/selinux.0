Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA12363
	for <selinux@tycho.nsa.gov>; Sat, 12 May 2001 01:57:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA08498
	for <selinux@tycho.nsa.gov>; Sat, 12 May 2001 05:57:49 GMT
Received: from smtppop3pub.verizon.net (smtppop3pub.gte.net [206.46.170.22])
	by jazzswing.ncsc.mil  with ESMTP id FAA08494
	for <selinux@tycho.nsa.gov>; Sat, 12 May 2001 05:57:48 GMT
Message-ID: <3AFCD530.EB61F4AB@gte.net>
Date: Fri, 11 May 2001 23:16:16 -0700
From: "g.montgomery" <g.montgomery@gte.net>
MIME-Version: 1.0
To: Bede McCall <bede@mitre.org>
CC: jan.petranek@student.uni-tuebingen.de, selinux@tycho.nsa.gov
Subject: Re: SELinux as a desktop / workstation?
References: <200105120051.UAA25152@idiot-savant.mitre.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Bede McCall wrote:
> 
> Offhand, I'd say you're describing the sort of thing prospective ASPs
> have in mind as the ideal network, albeit not for security reasons.
> I'm not as convinced as some folks that ASPs are a teriffic idea --
> for now, at least.
> 

I concur regarding ASPs - not sure I'd ever feel secure with
my stuff all being done "out there" in the great server
in the sky.  Of course, I still appear at the bank to do
my banking, and I even carry cash to buy stuff - old
fashioned, I guess.

> The popularity of simple, stateless clients comes and goes.  For
> example, we've seen IBM 3270s, X terminals, diskless workstations
> (e.g., Sun's early systems running ND) and now SunRay, which bears a
> family resemblance to X terminals and 3270s.  The history stretches
> back to the glory days of Big Iron about 25 years ago, as punch cards
> and batch systems were (finally) on their way out and decent multiuser
> OS's were starting to show up (and many users thought the Lear ADM-3A
> terminal was really hot stuff).
>

Yeah, been through all those devices, having started
opting for software back when Fortran was cool, and
programming in BAL/360 was for "real men".  A lot
has changed.
 
> Securing simple, stateless clients is essentially a no-brainer,
> letting you can focus all your energy on securing the server(s).  On
> the down side, when someone finally breaks into a server, everyone's
> instantly in deep trouble.
>

Yes, but if someone breaks into a critical server, you are in
trouble, no matter the system architecture. The idea is
to keep break-ins from happening.  The kinds of systems
I have dealt with have both physical and comsec security,
so break-ins of the "cracker" type are unlikely. (Has
anyone ever cracked SIPRNET, for example?)
 
> Of course, if someone gets into a stateful client (an easier job,
> overall) they can gain access to anything that client had stored
> locally, which might include keys, passwords, etc. allowing access to
> one or more servers. It's also a lot harder to detect such intrusions,
> mainly because users aren't as attuned to such things as sysadmins.
> You can mitigate some of the server access-control problems (e.g., by
> using "smart cards").
> 

Precisely.  

> I think there's a good compromise design, though.
> 
> I think the facts argue in favor of distributed systems where *most*
> of the executable applications reside on clients and *most* of the raw
> data resides on servers.  A secure client with enough local stable
> storage to hold at least a working set of raw data, a little non-global
> information (e.g., local static configuration data) plus swap space
> for its applications seems like a reasonable compromise.  Ob. selinux:
> something like the SELinux-based kernel could be a very good choice of
> OS on both client and server, given such a configuration.
> 
I like both your points.  First, I have seen a particular Sun
workstation (don't remember the model) which had a local
disk to hold enough of the operating system after booting
over the LAN, plus swap, data, and enough memory to
work in the problem space.  The advantage of this
arrangement was that there was light lan traffic, and
the local disk cached everything it needed to operate,
so it was quite fast - faster than x-terminals, etc. 
The admin problem was minimal.  I suppose there is still
an issue of volatile storage of (potentially) sensitive
or classified information, but that seems solvable. I
don't know how popular those were in general, but the
sysadmins in the lab I was working in at the time
liked them because the users didn't complain about
the slowness of the LAN, their displays were snappy,
and there was little sysadmin to take care of.  Everything
came from the server over the LAN, system was realtively
balanced.

Second, I have been wondering if selinux would provide
a good platform for both client and server, employing
MLS perhaps, and extending that across the system, with
a client node operating at a specific clearance level
as designated by the authentication/authorization
token (e.g., a programmed smart card).

> While they will always have their place, simple-client schemes
> generally haven't had a good survival rate, primarily because of the
> non-security aspects of what you're doing.  For one thing, if the
> server(s) for some group of clients crashes or becomes unavailable for
> any reason, the users can't get any work done.  As Sun discovered
> with ND, if you try to emulate stable storage on the client but locate
> it physically on the ND server, you can congest the network very
> quickly with swapping traffic (...and thereby make the application
> server(s) unavailable).  Some folks will argue that there is easily
> enough bandwidth in contemporary networks to overcome the congestion
> problems we saw in early systems like ND, so they see ASPs and
> "ultra-thin" clients as a very credible future.  I think that in the
> case of hardware networks they're probably right, but the problem of
> server robustness is as yet unsolved.
> 

True - server robustness is what one has to strive for.
To obtain availability of 5 nines, it would be
essential to have redundancy, "fail-safe" mechanisms,
etc.  While processor clustering, RAID, and other
techniques offer much, they are insufficient by themselves.
One needs a top-notch system design to approach the
"non-stop" operation demanded in mission critical
applications.  A system I recently worked on had
duplicate Sun servers, dual LAN arrangements, and in
general, a completely redundant set of nodes for
everything in the computing center.  I think the
(calculated) Availability was adequate for the
application, which was required to work with no
more than 15 minutes of down time in a year (IIRC).

Since the project was terminated for the
convenience ($$ shift) of the Government, we will never
know if the system would have met our projections,
but we felt we were on the right track.

BTW, that system had very thick dual-headed,
database hosting client nodes, so it doesn't
fit my mold of ultra-thin clients at all.  And the
thick client workstations were a bear to
develop software for and to administer in a 
DIICOE environment, which is one of the reasons
I have developed a liking for the thin clients.

When you are developing a system where most
of the interfaces must be developed from
scratch (that is, there is no well-oiled,
tried and proven message-passing protocol
which will support), then the interface between
the server and client is extremely important.
If you have a complex interface, with many
levels of statefulness, then it will take you
many years of testing to get the bugs out.
Not that it is easy if all the processing is done
on a server and "pixels" are shot out to an
ultra-thin client - it's just harder to do.
And, the other thing that happens when you
put that much functionality out in the
workstations is that you have to educate the
display developer guys/gals as to the 
functionality of your system, (the domain)
since they have part of the functionality 
out there in the client.  This increases the
cost of development, and results in a very
difficult project management problem. Better
if you can consider the client to be a
chunk of hardware, with NO software, if
possible.

So, if it sounds like I am letting the 
bureaucratic issues such as project management
get in the way of the system design, it 
just could be.  On the other hand, you could
look at it this way - If I can design a
system which requires 30% less in project
funding on a $300M project, and I only have
to spend say $200K x 10 (installations) extra as
an example, haven't I reduced the project
risk?  Shouldn't I consider that as an
important design criterion? I attribute
the extra cost to the increased server
power beyond the offset of the cheaper
client units. Round numbers - lots of
clients, so cutting the cost of them
by even a small amount significantly
reduces the system cost.

Sigh!  I guess there is no one system architecture
which answers all the mail.  Geez, have
I gotten off the selinux topic.  Probably
get flamed by someone.  Sorry!

Back on topic - has anyone suggested such
an archane thing as to use SELinux in
a beowulf cluster?

> --
>   Bede McCall   <bede@mitre.org>
>   MITRE Corporation                        Tel: (781) 271-2839
>   202 Burlington Road                      FAX: (781) 271-2423
>   Bedford, Massachusetts  01730-1420
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


Respectfully,
-- 
Gene Montgomery

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
