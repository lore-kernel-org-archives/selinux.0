Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9REaKXZ021243
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 10:36:21 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9REZ3rP003249
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 14:35:03 GMT
Subject: Re: latest diffs.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <417D72B8.5040008@redhat.com>
References: <417D72B8.5040008@redhat.com>
Content-Type: text/plain
Message-Id: <1098887701.2293.17.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 27 Oct 2004 10:35:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

Changed the "ifdef(`nfs_home_dirs', `" in base_user_macros.te to "if
(nfs_home_dirs)" which is obviously what you meant.

On Mon, 2004-10-25 at 17:40, Daniel J Walsh wrote:
> Removed more tunables
> use_games not needed, if you do not want games, don't include games.te
> Added boolean disable_games to disable games transition.
> 
> Change nfs_home_dirs to a boolean.
> 
> Change user_net_control to a boolean.
> 
> Turn off nscd_all_connect (Hopefully eliminate).
> 
> Cleanup nscd.
> 
> Dan
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
