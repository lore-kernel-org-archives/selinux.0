Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k09HUlXf000443
	for <selinux@tycho.nsa.gov>; Mon, 9 Jan 2006 12:30:47 -0500 (EST)
Received: from web51511.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k09HUkNp017709
	for <selinux@tycho.nsa.gov>; Mon, 9 Jan 2006 17:30:46 GMT
Message-ID: <20060109173011.55998.qmail@web51511.mail.yahoo.com>
Date: Mon, 9 Jan 2006 09:30:11 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Auditallow execmem
To: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@namei.org>, SELinux-dev@tresys.com,
   Steve G <linux_4ever@yahoo.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1136824668.19934.61.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Not sure whether it might be simpler to instead implement a solution in
>the kernel audit framework for such selective filtering or in auditd
>itself.

Not sure this is a good way to go at this point. The audit system is time
constrained. It is in a race with the kernel to keep the audit log queue as empty
as possible. The messages would be in text at this point which would require
parsing. I'd also have to keep a cache around and currently there's no malloc's
in the normal logging path to make sure we do not leak memory. (The audit daemon
makes itself exempt from OOM killer actions, so we try to make absolute sure this
could never happen.)

As for doing this in the audit framework, we have the same problem. SE Linux
currently calls audit_log_format which means we have everything in text by the
time we'd notice that its a duplicate. Parsing in the kernel doesn't sound good
to me. 

I don't think the audit subsystem should get in the business of message
compression either. This is one of the things that distinguish it from syslog.
You get all the messages all the time.

-Steve


		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
