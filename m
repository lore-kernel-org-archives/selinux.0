Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FFsJL9008287
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 10:54:20 -0500 (EST)
Received: from web50601.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j1FFrCEP004456
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 15:53:12 GMT
Message-ID: <20050215155312.45937.qmail@web50601.mail.yahoo.com>
Date: Tue, 15 Feb 2005 07:53:12 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Setting loginuid
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The 2.6.11 kernel will have the /proc/pid/loginuid attribute that can be accessed
to see what the original login uid was for a user's process. I remember several
people on this list interested in this being implemented. There's 2 ways I'm
considering for implementing the userspace portion of this feature and I wanted
to get opinions/feedback.

1) Use pam to set the information "pre-fork" and let the child inherit the
loginuid from the parent process. This muddies up the entry point program's
information, but is easier to do.

2) patch all entry point programs to explicitly set the loginuid after the fork.
This keep the parent process clean, but creates a lot of patches (20 - 30
programs).

Thanks,
-Steve Grubb

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
