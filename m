Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1GDxgXf026700
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 08:59:42 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1GDxd8P006146
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 13:59:40 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k1GDwaeO016702
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 08:58:36 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k1GDwawq016701
	for selinux@tycho.nsa.gov; Thu, 16 Feb 2006 08:58:36 -0500
From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] collect security labels on user =?utf-8?q?processes=09generating_audit?= messages
Date: Wed, 15 Feb 2006 11:41:42 -0500
Cc: linux-audit@redhat.com, James Morris <jmorris@namei.org>,
   selinux@tycho.nsa.gov
References: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com> <200602151122.37945.sgrubb@redhat.com> <1140021440.14253.411.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1140021440.14253.411.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200602151141.42778.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 15 February 2006 11:37, Stephen Smalley wrote:
> > It creates parsing problems without a value. If I saw "tty="  and that's
> > all, I'd think the audit system malfunctioned and file a bugzilla. I
> > don't want that.
>
> OTOH, if I see (null), I tend to assume a bug in the code.  Isn't it
> saner to just omit the name=value pair altogether if the value is NULL?

No, cause then I have non-normalized records.

> Otherwise, you are adding extra processing on the generation and parsing
> side for no benefit, along with wasting space in the audit message.

There is a benefit...no missing fields means that the record is normalized. 
This is a required step before we create a binary format record. 

There are performance benefits in the kernel as well as user space. The kernel 
doesn't have to have an "if" statement with 2 nearly identical calls to 
audit_log_format or 2 back to back calls to the same function adding a new 
piece of info. 

In userspace, I can parse it faster since I don't have to backtrack and 
re-parse from the last good token to look for the next field after deciding 
one is missing.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
