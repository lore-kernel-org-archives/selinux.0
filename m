Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UL3PDo018818
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 16:03:25 -0500 (EST)
Received: from web51507.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j2UL2Co4001359
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 21:02:12 GMT
Message-ID: <20050330210212.38072.qmail@web51507.mail.yahoo.com>
Date: Wed, 30 Mar 2005 13:02:12 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Getting the real task name in avc messages
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>Note that anytime avc_audit generates an audit message, audit_log_exit
>will be called upon syscall exit, so by adding a call to your new function 
>to audit_log_exit, you'll ensure that this information is recorded for 
>every avc denial as well as every other audit message.

I'm not sure we need this information for regular auditing. I haven't seen
regular audit messages that showed the interpreter instead of the program. The
problem does exist for avc denials.

>Note that the comm field is less complete (not a full path and may even
>be truncated) and is not trustworthy (can be changed by the process to
>any arbitrary string).  So you can't rely on it, but it can be useful
>for debugging.

I know about that. I know where to find the full path (example code is over in
the proc file system), but I don't have time to improve this patch right now. I
just want to get this out in the open and show that the status quo can be
improved a little.

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
