Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA11708
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2001 20:51:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA00006
	for <selinux@tycho.nsa.gov>; Sat, 12 May 2001 00:51:19 GMT
Received: from smtpproxy1.mitre.org (mb-20-100.mitre.org [129.83.20.100])
	by jazzswing.ncsc.mil  with ESMTP id AAA29998
	for <selinux@tycho.nsa.gov>; Sat, 12 May 2001 00:51:19 GMT
Date: Fri, 11 May 2001 20:51:10 -0400 (EDT)
From: bede@mitre.org (Bede McCall)
Message-Id: <200105120051.UAA25152@idiot-savant.mitre.org>
To: g.montgomery@gte.net
CC: jan.petranek@student.uni-tuebingen.de, selinux@tycho.nsa.gov
In-reply-to: <3AFC56A5.8F0F2686@gte.net> (g.montgomery@gte.net)
Subject: Re: SELinux as a desktop / workstation?
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Offhand, I'd say you're describing the sort of thing prospective ASPs
have in mind as the ideal network, albeit not for security reasons.
I'm not as convinced as some folks that ASPs are a teriffic idea --
for now, at least.

The popularity of simple, stateless clients comes and goes.  For
example, we've seen IBM 3270s, X terminals, diskless workstations
(e.g., Sun's early systems running ND) and now SunRay, which bears a
family resemblance to X terminals and 3270s.  The history stretches
back to the glory days of Big Iron about 25 years ago, as punch cards
and batch systems were (finally) on their way out and decent multiuser
OS's were starting to show up (and many users thought the Lear ADM-3A
terminal was really hot stuff).

Securing simple, stateless clients is essentially a no-brainer,
letting you can focus all your energy on securing the server(s).  On
the down side, when someone finally breaks into a server, everyone's
instantly in deep trouble.

Of course, if someone gets into a stateful client (an easier job,
overall) they can gain access to anything that client had stored
locally, which might include keys, passwords, etc. allowing access to
one or more servers. It's also a lot harder to detect such intrusions,
mainly because users aren't as attuned to such things as sysadmins.
You can mitigate some of the server access-control problems (e.g., by
using "smart cards").

I think there's a good compromise design, though.

I think the facts argue in favor of distributed systems where *most*
of the executable applications reside on clients and *most* of the raw
data resides on servers.  A secure client with enough local stable
storage to hold at least a working set of raw data, a little non-global
information (e.g., local static configuration data) plus swap space
for its applications seems like a reasonable compromise.  Ob. selinux:
something like the SELinux-based kernel could be a very good choice of
OS on both client and server, given such a configuration.

While they will always have their place, simple-client schemes
generally haven't had a good survival rate, primarily because of the
non-security aspects of what you're doing.  For one thing, if the
server(s) for some group of clients crashes or becomes unavailable for
any reason, the users can't get any work done.  As Sun discovered
with ND, if you try to emulate stable storage on the client but locate
it physically on the ND server, you can congest the network very
quickly with swapping traffic (...and thereby make the application
server(s) unavailable).  Some folks will argue that there is easily
enough bandwidth in contemporary networks to overcome the congestion
problems we saw in early systems like ND, so they see ASPs and
"ultra-thin" clients as a very credible future.  I think that in the
case of hardware networks they're probably right, but the problem of
server robustness is as yet unsolved.


-- 
  Bede McCall   <bede@mitre.org>
  MITRE Corporation                        Tel: (781) 271-2839
  202 Burlington Road                      FAX: (781) 271-2423
  Bedford, Massachusetts  01730-1420

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
