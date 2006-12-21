Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBLF4TWx030049
	for <selinux@tycho.nsa.gov>; Thu, 21 Dec 2006 10:04:29 -0500
Received: from web51513.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kBLF55YS017244
	for <selinux@tycho.nsa.gov>; Thu, 21 Dec 2006 15:05:06 GMT
Date: Thu, 21 Dec 2006 07:05:04 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] change printks from KERN_INFO to KERN_DEBUG
To: Eric Paris <eparis@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@redhat.com>
In-Reply-To: <1166670449.23016.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <34763.81442.qm@web51513.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Currently it means that access decisions which would rely on that
>class/perm will be denied.  They will still be logged based on the
>kernel's view.  So actually the logging is still correct and complete.

This sounds like it should go to syslog as an error then. Errors do not need to
be audited, just access control decisions and significant changes in state of
security functions like loading policy, disabling selinux, flipping boolean, etc.

I also wonder if there should be a way to cause the system to panic if a policy
loads that has these kind of holes in it?

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
