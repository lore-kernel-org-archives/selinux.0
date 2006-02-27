Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1RGQHKF030709
	for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2006 11:26:17 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1RGQFku001534
	for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2006 16:26:15 GMT
Subject: Re: Latest changes to policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43FE0C4D.1000003@redhat.com>
References: <43FE0C4D.1000003@redhat.com>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 11:29:51 -0500
Message-Id: <1141057791.30819.111.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-23 at 14:26 -0500, Daniel J Walsh wrote:
> Make polyinstantiation work for /tmp

Why does the files_polyinstantiate_all() need the relabeling?

> Automount now needs to getattr on all directories.

I'd be interested to find out why, this seems like an odd behavior to
me.

The remainder is merged, except the Makefile.devel change; with the
symlink setup you have in FC, it seems like it should work as is.
 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
