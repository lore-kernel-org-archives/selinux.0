Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96KF6rT008537
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 16:15:06 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i96KDwnN025143
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 20:13:58 GMT
Subject: Re: [PATCH] security/selinux/netif.c has a serious problem
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0410061602000.1417-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0410061602000.1417-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1097093531.11370.100.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 06 Oct 2004 16:12:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-10-06 at 16:03, James Morris wrote:
> > Perhaps we need to move the rcu_read_lock/unlock to the hook functions
> > that call sel_netif_lookup?
> 
> We shouldn't push locking to the caller, there must be another way.

Comparing with the AVC, we have avc_has_perm_noaudit() perform the
rcu_read_lock/unlock, but it holds the lock until it has copied the
result, and merely returns a copy of the decision to the caller, not a
reference to a node itself.  You could do likewise for sel_netif_lookup
and only have it return copies of the SIDs to the caller.  The netif AVC
entry reference is obsolete anyway with the introduction of RCU for the
AVC.  No need for any atomic operations on the read path, which is one
of the stated purposes of RCU (Documentation/RCU/rcu.txt) - readers need
not acquire any locks, perform any atomic instructions, ...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
