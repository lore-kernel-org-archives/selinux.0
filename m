Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA22420
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2001 13:31:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA18257
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2001 17:31:39 GMT
Received: from zuul.dsndata.com (zuul.dsndata.com [198.183.3.2])
	by jazzband.ncsc.mil  with SMTP id RAA18253
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2001 17:31:34 GMT
Received: from dsndata.com(localhost[127.0.0.1]) (2029 bytes) by zuul.dsndata.com
	via sendmail with P:esmtp/R:bind_hosts/T:inet_zone_bind_smtp
	(sender: <willdye@dsndata.com>)
	id <m14xBKd-00007kC@zuul.dsndata.com>
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2001 12:31:31 -0500 (CDT)
	(Smail-3.2.0.102 1998-Aug-2 #1 built 1998-Nov-18)
Message-Id: <m14xBKd-00007kC@zuul.dsndata.com>
Reply-To: willdye@dsndata.com
To: selinux@tycho.nsa.gov
Subject: Re: SELinux as a desktop / workstation? 
In-reply-to: Your message of "Tue, 08 May 2001 13:55:29 +0200."
         <Pine.LNX.4.30.0105081344290.18206-100000@linux45.zdv.uni-tuebingen.de>
Cc: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
Date: Tue, 08 May 2001 12:31:29 -0500
From: Will Dye <willdye@dsndata.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Jan Petranek writes:

> I assume, that most of you are using SELinux for server purposes. 
> Is there someone, who is using it for his everyday-desktop machine?


A lot of Linux distros still turn on potentially-hazardous services 
by default, even on "workstation" installations.  I've read advice 
colums that strongly advise turning nearly all services off at all 
times, but personally I like having those options around.  I don't 
always know in advance when I might want to dial in from home to 
one of my work machines, for example.  Linux has not suffered as 
much as Windows from viruses & trojans, but it is not immune.  For 
these and other reasons, even Linux "workstation" installations may 
want ways to limit the amount of damage done by break-ins.

As long as the machine can handle a bit of a slowdown, I think it's 
a good idea to put something like SELinux on *every* system -- even 
my dinky old Toshiba 320CT laptop (266 MHz Pentium 1, 32 megs RAM).
There's a lot you can tweak if you need to cut back on the security 
processing overhead.  Desktop or server, I like my data intact.

Just one opinion,

--Will

 _____________________________________________________________________
 William Dye, Interim Chief Executive Cat-Herder, the Tweakdom Project
 Open-source tweaks to "Freedom", an Internet privacy software system.
 http://tweakdom.sourceforge.net   No relation Zero-Knowledge Systems.




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
