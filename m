Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2EKNCDo025038
	for <selinux@tycho.nsa.gov>; Mon, 14 Mar 2005 15:23:12 -0500 (EST)
Subject: Re: Latest patches
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <423253FB.6090602@redhat.com>
References: <423253FB.6090602@redhat.com>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 15:18:55 -0500
Message-Id: <1110831535.3182.9.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

Also:
- Made sysadm_r the first role for root, so root's home will be labled
as sysadm_home_dir_t instead of staff_home_dir_t.
- Modified fs_use and Makefile to reflect jfs now supporting security
xattrs.
- Added an ifdef to nrpe.fc to prevent duplicate nagios and netsaint
rules.

On Fri, 2005-03-11 at 21:29 -0500, Daniel J Walsh wrote:
> Fixed to Makefile to better handle local.users
> 
> Ivan's Gift policy
> 
> Fixes to expand targeted policy.  (Adding dhcpc, ifconfig, hostname, 
> consoletype)
> 
> Fixes to fs_daemon
> 
> Added a bunch of dontaudit of net_admin for many policies.


-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
