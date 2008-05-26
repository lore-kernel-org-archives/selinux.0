Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4QIdLIc002137
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2008 14:39:21 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m4QIdLTO016655
	for <selinux@tycho.nsa.gov>; Mon, 26 May 2008 18:39:21 GMT
Subject: Re: Updated kernel/filesystem.* patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4836D221.3080605@redhat.com>
References: <4836D221.3080605@redhat.com>
Content-Type: text/plain
Date: Mon, 26 May 2008 14:38:34 -0400
Message-Id: <1211827114.11188.188.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-05-23 at 10:18 -0400, Daniel J Walsh wrote:
> Gzip archive attachment (kernel_filesystem.patch.gz)

The .if part didn't apply, so I just merged the .te changes.  With all
of these filesystems being labeled nfs_t, I'm starting to kick around
the idea that we should make a network_fs_t.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
