Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7GJHIrT009155
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 15:17:18 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7GJGcqL019324
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 19:16:39 GMT
Subject: Re: [patch] setting default role from ssh
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Colin Walters <walters@verbum.org>, selinux@tycho.nsa.gov,
   Nalin The Nalinator Dahyabhai <nalin@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <41210415.9070405@tresys.com>
References: <1092513257.4515.28.camel@nexus.verbum.private>
	 <1092665369.16631.53.camel@moss-spartans.epoch.ncsc.mil>
	 <1092670862.9971.20.camel@nexus.verbum.private>
	 <41210415.9070405@tresys.com>
Content-Type: text/plain
Message-Id: <1092683761.16631.224.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 16 Aug 2004 15:16:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-16 at 14:59, Joshua Brindle wrote:
> If this is implemented would it be possible to define a mechanism for 
> controlling roles reachable in this manner?

Policy already dictates what domains can be reached by sshd, and
user-role authorizations limit what a given user can do.  We could have
the new function only accept roles that are explicitly listed for sshd
in the default_contexts configuration (system or per-user), just as
get_default_context() only returns contexts that are listed there.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
