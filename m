Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96JkArT008167
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 15:46:11 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i96Jk9co000744
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 19:46:09 GMT
Subject: Re: [PATCH] security/selinux/netif.c has a serious problem
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0410061453220.1041-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0410061453220.1041-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1097091790.11370.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 06 Oct 2004 15:43:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-10-06 at 14:58, James Morris wrote:
> It's bad form for a function to maybe take a lock and keep it (in this 
> case disable preemption, although that could possibly change).
> 
> Below is a simpler patch which only allows the netif to be destroyed once.
> 
> Please review.

Doesn't this still allow the netif to be destroyed (e.g. upon
preemption) while it is still in use by a hook function?  Perhaps we
need to move the rcu_read_lock/unlock to the hook functions that call
sel_netif_lookup?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
