Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA40sqXZ019936
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 19:54:52 -0500 (EST)
Received: from smtp.puc.cl (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA40soJZ014784
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 00:54:51 GMT
Received: from tayataf.puc.cl (HELO mx1.puc.cl) ([146.155.99.171])
          (envelope-sender <amery@geeks.cl>)
          by tarahuin-smtp.puc.cl (qmail-ldap-1.03) with SMTP
          for <selinux@tycho.nsa.gov>; 4 Nov 2004 00:54:46 -0000
Message-ID: <41897DD3.5060407@geeks.cl>
Date: Wed, 03 Nov 2004 21:54:43 -0300
From: Alejandro Mery <amery@geeks.cl>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov
Subject: Re: selinux without sysvinit
References: <4188E956.7020808@geeks.cl> <1099508399.1213.188.camel@moss-spar
	tans.epoch.ncsc.mil>
In-Reply-To: <1099508399.1213.188.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> You either need to load a policy prior to running your runit program
> (e.g. via an initrd, which is what we originally did), or modify your
> runit program to load a policy and re-exec itself into the correct
> security domain (as is done by the sysvinit patch).

what do you think about an selinux init to load policy and replace 
itself with /sbin/init (any) after that?

Regards,
Alejandro Mery

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
