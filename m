Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA03385
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 16:38:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA07596
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 21:36:31 GMT
Received: from prserv.net (asmtp1.prserv.net [32.97.166.51])
	by jazzswing.ncsc.mil  with ESMTP id VAA07592
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 21:36:30 GMT
Message-Id: <200211292136.VAA07592@jazzswing.ncsc.mil>
Date: Fri, 29 Nov 2002 16:35:18 -0500
From: "Subba Rao" <sailorn@attglobal.net>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Building SELinux - System requirement and 'warning' messages
Mime-Version: 1.0
Content-Type: text/plain;
      charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

Thanks for pointing this out.  I guess I will move my server to SuSe or Redhat.

Subba Rao
sailorn@attglobal.net
2002-11-29

======= At 2002-11-29, 15:34:00 you wrote: =======

>> I am running Slackware Linux 8.1 on one of my spare systems and am trying to 
>install SELinux on this system.
>> It is a holiday project I guess.  I have been following the instructions in 
>the README files in 'selinux' directory.
>> My build process has stopped 3 times so far complaining about some missing 
>packages such as PAM, Kerberos and now BSD lib.
>> Is there a library or system requirements list for SELinux?
>
>No, but the web site notes that we have only built and used SELinux
>on RedHat 7.x.  The modified daemons and utilities are mostly derived from
>the RedHat 7.2 sources, so you need to port the SELinux patches for the
>modified applications if you want to use another distribution.   You also
>need to adapt the policy configuration for other distributions.  Russell Coker 
>has done this work for Debian, and Carsten Grohmann has done some
>work on SuSE policy changes.  See http://selinux.sourceforge.net/distros.
>
>--
>Stephen Smalley, NSA
>sds@epoch.ncsc.mil

= = = = = = = = = = = = = = = = = = = =
			





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
