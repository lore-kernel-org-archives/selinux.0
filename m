Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5NDDTuW027106
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 09:13:29 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m5NDDSvu023767
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 13:13:29 GMT
Subject: Re: pam_mount
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1214047062.30904.13.camel@vogon>
References: <1214047062.30904.13.camel@vogon>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Jun 2008 09:12:30 -0400
Message-Id: <1214226750.11146.232.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-06-21 at 13:17 +0200, Stefan Schulze Frielinghaus wrote:
> I try to temporarily create a policy fix for pam_mount and I'm running
> into some problems.
> 
> While using local console login mount_t tries to "getattr" every
> sock_file in /var/run which I could dontaudit using the following:
> 
> dontaudit mount_t pidfile:sock_file getattr;
> 
> But there is still another very annoying AVC message which I get for
> every directory in /proc which is not labeled as proc_t.
> 
> type=1400 audit(1214045895.760:29702): avc:  denied  { getattr } for
> pid=28153 comm="fuser" path="/proc/1" dev=proc ino=1675
> scontext=system_u:system_r:mount_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:init_t:s0 tclass=dir
> 
> type=1400 audit(1214045895.762:29703): avc:  denied  { search } for
> pid=28153 comm="fuser" name="1" dev=proc ino=1675
> scontext=system_u:system_r:mount_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:init_t:s0 tclass=dir
> 
> For the first few tries I dontaudit every occurrence (over a dozen
> types) but I realized that's something I can't win ;-) So I tried using
> the following rule:

﻿This is due to all of the /proc/pid entries being labeled with the
domain's type.  You need domain_dontaudit_search_all_domains_state(),
and probably kernel_dontaudit_list_all_sysctls() too.

> dontaudit mount_t proc_type:dir { getattr search };
> 
> But the AVC is still generated. I hoped that proc_type is an attribute
> for every file/dir under /proc. Am I wrong? Or why doesn't the dontaudit
> rule count?

Right now domain types are not included in the proc_type.  The sysctl
types are not included either.  I don't know that we've ever considered
extending that attribute to include all of those types.  Right now it
just includes all the types prefixed with proc, for example, proc_t,
proc_kmsg_t, proc_net_t, etc.  It may be ok, since the attribute is only
used in two rules, one is a dontaudit and one is an allow for
unconfined.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
