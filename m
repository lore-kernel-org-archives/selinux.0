Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k42HtDYS007933
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 13:55:13 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k42HtBUP019583
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 17:55:12 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <44579740.4010708@redhat.com>
References: <445767D1.3040406@redhat.com> <1146583155.20331.65.camel@sgc>
	 <44579740.4010708@redhat.com>
Content-Type: text/plain
Date: Tue, 02 May 2006 13:57:47 -0400
Message-Id: <1146592667.20331.71.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 13:30 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Tue, 2006-05-02 at 10:08 -0400, Daniel J Walsh wrote:
> >> cups needs to be able to create socket to itself.
> >
> > This needs more investigation; we need to find out more about this
> > generic socket so we can add a specific class for it.
> >
> >   
> http://www.redhat.com/archives/fedora-selinux-list/2006-April/msg00216.html

So it appears that a class for appletalk sockets needs to be added.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
