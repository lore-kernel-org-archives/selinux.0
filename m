Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5FMrGh000665
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 10:23:26 -0500 (EST)
Received: from smtp.puc.cl (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5EwsF9023639
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 14:59:07 GMT
Received: from tayataf.puc.cl (HELO mx1.puc.cl) ([146.155.99.171])
          (envelope-sender <amery@geeks.cl>)
          by coihuin-smtp.puc.cl (qmail-ldap-1.03) with SMTP
          for <selinux@tycho.nsa.gov>; 5 Nov 2004 14:58:54 -0000
Message-ID: <418B9531.7090303@geeks.cl>
Date: Fri, 05 Nov 2004 11:58:57 -0300
From: Alejandro Mery <amery@geeks.cl>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov
Subject: Re: selinux without sysvinit
References: <4188E956.7020808@geeks.cl>	 <1099508399.1213.188.camel@moss-spa
	r tans.epoch.ncsc.mil>	 <41897DD3.5060407@geeks.cl> <1099579644.3174.73.cam
	el@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1099579644.3174.73.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Yes, that should work as well, and I think some people have actually
> used that approach in the past.  But if you decide to move aside
> /sbin/init and replace it with a small program that loads policy and
> then runs the real init program, be careful that telinit is then
> redirected to the real init program.

i was thinking in a /sbin/seinit with proper init= on loader, hardcoded 
to execve /sbin/init and /bin/sh after that.

may this affect telinit?

Alejandro

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
