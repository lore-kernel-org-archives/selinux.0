Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k28Iiitw030332
	for <selinux@tycho.nsa.gov>; Wed, 8 Mar 2006 13:44:44 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k28Iigbn013924
	for <selinux@tycho.nsa.gov>; Wed, 8 Mar 2006 18:44:42 GMT
Subject: Re: Current diff from debian svn
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1141767635.5082.36.camel@wintermute.xmldesign.de>
References: <1141767635.5082.36.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 13:44:13 -0500
Message-Id: <1141843453.30819.184.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-03-07 at 22:40 +0100, Erich Schubert wrote:
> Attached is the current diff from debian refpolicy SVN to yours, updated
> to match the 20060307-2 cvs dump.

> - small tweak to logrotate to support logcheck

Dropped this since it uses cron_t in the logrotate module.  Cron needs
to use a logrotate interface.

> - amavis policy
> - clamd policy

These were already added.

> - dpkg/apt-get policy

Some reordering done.

> - some tweaks for rpm/userdomain/usermanage for dpkg/apt
>   (the rpm one needs to be reviewed seriously)

I dropped the rpm_manage_db(apt_t) until its clear that its needed

The remainder should be merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
