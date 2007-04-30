Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UF06Ls000446
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 11:00:06 -0400
Received: from web51502.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3UF04id001116
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 15:00:05 GMT
Message-ID: <20070430145914.7790.qmail@web51502.mail.re2.yahoo.com>
Date: Mon, 30 Apr 2007 07:59:14 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Patch to cleanup audit handling in policy.
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1177942650.3570.78.camel@sgc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>I'm not convinced that these are necessary.

The audit policy seems very broken. It allows way too much permission to
applications. The audit_control permission means that they can potentially delete
audit rules or change the loginuid. That should not be handed out like candy. 

The interfaces that Dan created allows the exact kind of permission to be applied
without having to copy and paste individual permissions which is error prone.
(There are only 4 use cases of the audit system.) Part of what makes it error
prone is the naming convention for all the pieces. Example: "audit_write" is that
for the capability, the netlink interface, or audit logs?

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
