Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FGSBL9008559
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 11:28:11 -0500 (EST)
Received: from web50201.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j1FGR3EP005815
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 16:27:04 GMT
Message-ID: <20050215162704.15893.qmail@web50201.mail.yahoo.com>
Date: Tue, 15 Feb 2005 08:27:04 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Setting loginuid
To: Steve G <linux_4ever@yahoo.com>, selinux@tycho.nsa.gov
In-Reply-To: <20050215155312.45937.qmail@web50601.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Steve G <linux_4ever@yahoo.com> wrote:

> 2) patch all entry point programs to explicitly set
> the loginuid after the fork.
> This keep the parent process clean, but creates a
> lot of patches (20 - 30
> programs).

Some programs that use PAM, including su, are
not login sessions and hence must not set the
loginuid. Because the definition of a login
session is less clear than it might be I
suggest that the individual programs will have
to be responsible for determining if the
loginuid should be set. There are also programs,
cron comes to mind, that do not use pam (does it?)
that do create login sessions.


=====
Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
