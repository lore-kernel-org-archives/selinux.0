Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA07848
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2001 10:22:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA00273
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2001 14:22:45 GMT
Received: from mx02.uni-tuebingen.de (mx02.uni-tuebingen.de [134.2.3.12])
	by jazzswing.ncsc.mil  with ESMTP id OAA00269
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2001 14:22:44 GMT
Received: from linux16.zdv.uni-tuebingen.de (linux16.zdv.uni-tuebingen.de [134.2.18.16])
	by mx02.uni-tuebingen.de (8.9.3/8.9.3) with ESMTP id QAA02087
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2001 16:22:43 +0200
Date: Fri, 18 May 2001 16:22:43 +0200 (CEST)
From: Jan Petranek <jan.petranek@student.uni-tuebingen.de>
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: SELinux as a desktop / workstation?
In-Reply-To: <200105120051.UAA25152@idiot-savant.mitre.org>
Message-ID: <Pine.LNX.4.30.0105181548250.6378-100000@linux16.zdv.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 11 May 2001, Bede McCall wrote:

> Date: Fri, 11 May 2001 20:51:10 -0400 (EDT)
> From: Bede McCall <bede@mitre.org>
> To: g.montgomery@gte.net
> Cc: jan.petranek@student.uni-tuebingen.de, selinux@tycho.nsa.gov
> Subject: Re: SELinux as a desktop / workstation?
>
> Offhand, I'd say you're describing the sort of thing prospective ASPs
> have in mind as the ideal network, albeit not for security reasons.
> I'm not as convinced as some folks that ASPs are a teriffic idea --
> for now, at least.

Actually, I was thinking of my own box only.

> The popularity of simple, stateless clients comes and goes.  For
> example, we've seen IBM 3270s, X terminals, diskless workstations
> (e.g., Sun's early systems running ND) and now SunRay, which bears a
> family resemblance to X terminals and 3270s.  The history stretches
> back to the glory days of Big Iron about 25 years ago, as punch cards
> and batch systems were (finally) on their way out and decent multiuser
> OS's were starting to show up (and many users thought the Lear ADM-3A
> terminal was really hot stuff).

Well, a thin-client/server approach is a good thing, but they will be used
only in certain environments. A typical scenario is a bank, where all the
clerks have a thin-client connecting to a transaction monitor - the latter
one is surrounded by thick walls and a squad of highly skilled
specialists, who keep the machine secure. The users can easily comply with
the security, as they have (related to software) no other choice. If a
clerk wants to browse the web, a simple look on a 3270-CUI will almost
certainly stop him. In the other case, the system administrator will just
smack him with the OS/390-manual.

But take a look at another scenario: A company, that develops software.
The users need
-acces to the internet. Doubly so, if they are
developing open source.
-mail to communicate with other programmers / companies
-their own private files, like private keys (You want to be sure, that the
patch your programmer just send in from wherever he is can be trusted).
-quite a lot of freedom to configure their desktop
-a compiler
-the possibility of running code from alien source, so they can evaluate
it. (this is granted by combining the compiler and acces to the web
already, I just wanted to point it out).

And in this scenario, a thin client is completely useless. Even, if you
put the whole applications on a server - like a remote desktop - the
software from alien source still has to run somewhere. Well, you might put
the sensitive things on a server (like the keys) and do everything else on
the local machine.

Third scenario: More and more people connect their box to the web. Thanks
to better pricing, they can stay almost permanently connected. What a
heaven for script-kiddies!

So, that would be a good place for an OS, that supports fine-grained
security policies: E.g. you could state, that the only way to acces
private keys is via the pgp-interface. Or, that if you surf the web, the
web browser will run in his own sandbox, without even knowing about your
newest software project. And the file-sharing utility would share exactly
the files you want to. Sounds like heaven, eh?

The reason I'm writing this is, that I'm a bit concerned about security
issues. Up to now, very little viruses have shaken the linux community,
but except for selinux and sandbox, there is no thing that prevents code
running in the user space from doing anything in the user space. If you
put a mail-client or web-browser for instance in the user space that
allows the execution of active code, root will stay protected, but the
user may loose a lot.

Thank you all for your comments on that,

JanP


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
