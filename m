Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA01121
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 08:52:23 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA22276
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 13:50:10 GMT
Received: from prserv.net (asmtp1.prserv.net [32.97.166.51])
	by jazzswing.ncsc.mil  with ESMTP id NAA22272
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 13:50:09 GMT
Message-Id: <200211291350.NAA22272@jazzswing.ncsc.mil>
Date: Fri, 29 Nov 2002 8:48:52 -0500
From: "Subba Rao" <sailorn@attglobal.net>
To: Russell Coker <russell@coker.com.au>, selinux <selinux@tycho.nsa.gov>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: Building SELinux - System requirement and 'warning' messages
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I apologize for the programming style of  the developers.   I am a very big proponent of secure software and what I said was uncalled for.
When I tried to compile FreeS/Wan and SELinux (2 seperate machines), both of them spewed out lot of warning messages (actually tons).  The
packages did finally compile but with lots of warning messages.

I will start the build process from scratch i.e. reinstall Slackware 8.1 and try to build SELinux on top of it.  I will share the messages I get.

Subba Rao
sailorn@attglobal.net
2002-11-29

======= At 2002-11-29, 13:58:00 you wrote: =======

>On Fri, 29 Nov 2002 12:45, Subba Rao wrote:
>> My build process has stopped 3 times so far complaining about some missing
>> packages such as PAM, Kerberos and now BSD lib. Is there a library or
>> system requirements list for SELinux?
>
>There is no requirement for Kerberos in SE Linux.  Brian May might be doing 
>something with Kerberos and SE Linux as both are projects that interest him, 
>but apart from that I don't know of anyone who uses them both.
>
>I suspect that it's not SE Linux that you are having problems here but some of 
>the utilities.
>
>> One other note is that I noticed lots (I mean lots) of warning messages
>> while building SELinux.
>> sshd.c	clientloop.c	auth1.c	servconf.c	session.c	ssh-keygen.c	sysctl.c The
>
>At least half of them are from the ssh source.
>
>> above are a few files to name but there are several more files in the list
>> with tons of warning messages.  Is this Slackware distro problem or SELinux
>> code problem?  The build completes but it is not comforting to see so many
>> warning messages while building it.  It makes you wonder of the
>> programmer's skill level.
>
>Making such accusations about programming skills is not a good idea, after all 
>if you were such a skillful programmer then surely you would have fixed all 
>the warnings in question and sent a patch to the list.  :-#
>
>But seriously, if you send some of the error messages to the list then perhaps 
>we can work out where the problem lies.  I can see that a large part of your 
>problem is due to ssh, but apart from that there is not nearly enough 
>information to diagnose it properly or offer a solution.
>
>Of course you could just migrate to Debian.  On Debian SE Linux mostly just 
>works without requiring any compilation etc.
>
>-- 
>http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
>http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
>http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
>http://www.coker.com.au/~russell/  My home page

= = = = = = = = = = = = = = = = = = = =
			





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
