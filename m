Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBJIYSiB012670
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 13:34:28 -0500
Received: from web51507.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kBJIZ3ds014834
	for <selinux@tycho.nsa.gov>; Tue, 19 Dec 2006 18:35:04 GMT
Message-ID: <20061219183442.99467.qmail@web51507.mail.yahoo.com>
Date: Tue, 19 Dec 2006 10:34:42 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: superblock_doinit emits a message for every mount
To: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
In-Reply-To: <1166550751.20187.63.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Do we need them?  Are they really anything other than debugging?

Seems like that should be KERN_DEBUG if we keep it. If there's anything important
regarding security attributes, it should go to audit logs, errors should go to
syslog, everything else is noise/debug.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
