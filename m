Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAUJ6FRh000820
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 14:06:15 -0500
Received: from g4t0015.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAUJ6Esp007258
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 19:06:14 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Todd C. Miller" <tmiller@tresys.com>
Subject: Re: PATCH: peersid capability support
Date: Fri, 30 Nov 2007 14:06:10 -0500
Cc: selinux@tycho.nsa.gov
References: <200711301734.lAUHYKFJ031076@cadmus.columbia.tresys.com>
In-Reply-To: <200711301734.lAUHYKFJ031076@cadmus.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711301406.10774.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 30 November 2007 12:34:20 pm Todd C. Miller wrote:
> I see what happened.  When generating the patch I did an svn revert not
> realizing that of course it wouldn't revert a new file it knew nothing
> about.  So effectively the new files were duplicated--one copy in the
> patch and one on the filesystem.
>
> Here's a fixed diff that applies to a fresh checkout.

Thanks, that applied without problem.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
