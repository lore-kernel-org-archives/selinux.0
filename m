Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2E6Pl37020460
	for <selinux@tycho.nsa.gov>; Wed, 14 Mar 2007 02:25:47 -0400
Received: from web86909.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2E6PkK1012506
	for <selinux@tycho.nsa.gov>; Wed, 14 Mar 2007 06:25:46 GMT
Date: Wed, 14 Mar 2007 06:25:32 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Re: Confirmation about task_has_security in selinuxfs.c
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1173806818.2068.96.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <574941.32780.qm@web86909.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> The first question to ask is what are you trying to
> do with your module,

I was intrested in LSM Stacking for my project. On
this line, i found that SELinux is also built using
LSM, and some kind of stacking mechanism is possible
with SELinux, though, this assumption proved it self
wrong.

Is this possible, to compile the SELinux LSM without
Kernel re-compilation (may be a stupid question).
Because it takes too much time to recompile the kernel
each time, a change is made.

Thank You,
JG





	
	
		
___________________________________________________________ 
New Yahoo! Mail is the ultimate force in competitive emailing. Find out more at the Yahoo! Mail Championships. Plus: play games and win prizes. 
http://uk.rd.yahoo.com/evt=44106/*http://mail.yahoo.net/uk 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
