Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8FK5KrT020369
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 16:05:20 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8FK5JhN015667
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 20:05:19 GMT
Subject: Re: [patch] add proc_fs attribute
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Colin Walters <walters@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1095202603.8379.27.camel@nexus.verbum.private>
References: <1095202603.8379.27.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1095278665.13380.8.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 15 Sep 2004 16:04:25 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged as part of Dan's second patch.

On Tue, 2004-09-14 at 18:56, Colin Walters wrote:
> Hi,
> 
> The attached patch should fix this denial:
> 
> audit(1095188105.721:0): avc:  denied  { read }
> for  pid=2789 exe=/sbin/mdadm name=mdstat dev=proc ino=-268435080
> scontext=user_u:system_r:unconfined_t
> tcontext=system_u:object_r:proc_mdstat_t tclass=file
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
