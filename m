Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iATJSKIi013125
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 14:28:20 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iATJSNkk012311
	for <selinux@tycho.nsa.gov>; Mon, 29 Nov 2004 19:28:23 GMT
Subject: Re: cups-config-daemon ?
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: Tom London <selinux@gmail.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200411291904.56706.russell@coker.com.au>
References: <4c4ba153041128115177c696b8@mail.gmail.com>
	 <200411291904.56706.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1101756656.3219.12.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 29 Nov 2004 14:30:57 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Mon, 2004-11-29 at 03:04, Russell Coker wrote:
> On Monday 29 November 2004 06:51, Tom London <selinux@gmail.com> wrote:
> > Running strict/enforcing, latest Rawhide.
> >
> > I think the following is coming from cups-config-daemon
> >
> > I'm always a bit suspicious of fd denials....
> > these are to /dev/null...
> > Is this an open file leaking across an exec?
> 
> I don't think that this is a problem.  Granting access to /dev/null is not an 
> issue.  For cron jobs this sort of thing is common.
> 
> The attached patch should do the job.
> 
> > Help welcomed.....
> >    tom
> >
> >
> > Nov 28 10:12:25 fedora cups: cupsd shutdown succeeded
> > Nov 28 10:12:25 fedora kernel: audit(1101665545.088:0): avc:  denied
> > { use } for  pid=4223 exe=/usr/bin/python path=/dev/null dev=tmpfs
> > ino=3516 scontext=system_u:system_r:cupsd_config_t
> > tcontext=system_u:system_r:system_crond_t tclass=fd
> > Nov 28 10:12:25 fedora kernel: audit(1101665545.088:0): avc:  denied
> > { use } for  pid=4223 exe=/usr/bin/python path=/dev/null dev=tmpfs
> > ino=3516 scontext=system_u:system_r:cupsd_config_t
> > tcontext=system_u:system_r:logrotate_t tclass=fd
> > Nov 28 10:12:25 fedora kernel: audit(1101665545.088:0): avc:  denied
> > { use } for  pid=4223 exe=/usr/bin/python path=/dev/null dev=tmpfs
> > ino=3516 scontext=system_u:system_r:cupsd_config_t
> > tcontext=system_u:system_r:logrotate_t tclass=fd
> > Nov 28 10:12:25 fedora kernel: audit(1101665545.232:0): avc:  denied
> > { use } for  pid=4226 exe=/usr/sbin/cupsd path=/dev/null dev=tmpfs
> > ino=3516 scontext=system_u:system_r:cupsd_t
> > tcontext=system_u:system_r:system_crond_t tclass=fd
> > Nov 28 10:12:25 fedora cups: cupsd startup succeeded
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
