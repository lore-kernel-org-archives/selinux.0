Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA11047
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2001 16:57:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA14323
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2001 20:57:27 GMT
Received: from smtppop1pub.verizon.net (smtppop1pub.gte.net [206.46.170.20])
	by jazzband.ncsc.mil  with ESMTP id UAA14319
	for <selinux@tycho.nsa.gov>; Fri, 11 May 2001 20:57:26 GMT
Message-ID: <3AFC56A5.8F0F2686@gte.net>
Date: Fri, 11 May 2001 14:16:21 -0700
From: "g.montgomery" <g.montgomery@gte.net>
MIME-Version: 1.0
To: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
CC: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: SELinux as a desktop / workstation?
References: <Pine.LNX.4.30.0105081344290.18206-100000@linux45.zdv.uni-tuebingen.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jan Petranek wrote:
> 
> Hello there,
> 
Jan,
	I have been lurking on this list for a while,
as I am interested in bringing something like selinux
to the military applications environment in the
command and control field.  So, I do not speak with
authority, not having brought up SELinx, yet.

	But, I think I have seen the model which
appeals to my sensibilities, and other companies
are adopting the same model.  That is the ultra-secure
server, serving a set of ultra-thin clients.  That is,
the clients are like the Sun Sunray network appliance,
with no hard disk, no resident programs, and only the
RAM, and sufficient windowing software to get the
pixels on the screen.  Physical access of course,
is followed up by network access controlled by
Smart Card authentication/authorization (if I have
those terms right), and the session follows the
smart card.  Pull it out, and move to a different
network appliance, login, and your session has
magically moved there.

This provokes the question:

Is it better to put horsepower in both the server
and the client and try to keep them both secure
(especially in a multi-level security environment)
given that the constraints on the data and software
at the client end may be different than those
on the server end; or is it better to "put
all your eggs in one basket" so to speak, and
make the server the recipient of most all your
securification efforts?  (Of course, with the
constraint that the ultra-thin client is also
physically and electronically controlled for
access and authentication/authorization to the
required level.) 

Off the top of my head, considerations:
Pro:
	system administration at client end eliminated
	better control over centralized applications and databases	
Con:
	higher throughput required at server
	high bandwidth required between server and client
	
> I assume, that most of you are using SELinux for server purposes. Is there
> someone, who is using it for his everyday-desktop machine?
> 
> The reason for this question is:
> - a server needs higher security levels than a client (normally, because
> it is more exposed).
> - a server can be limited to certain tasks (e.g. serving web-pages only),
> whereas a workstation has to fit far more general needs (involving the use
> of code belonging to the users), so far more complicated policies
> would be necessary.
> 
> On the other hand, it would be useful, if simple workstations would offer
> high (or at least a medium) level of security. For e.g., if the user
> installs a program in his own userspace, he would want to limit the
> program to certain capabilities. (You don't want your brand-new
> napster-client to share your private keys with the napster-community ;)
> 
> Thank you,
> 
> JanP
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
