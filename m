Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1NFqtmr000534
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2005 10:52:55 -0500 (EST)
Subject: Re: [RFC][PATCH] Pass requested protection to
	security_file_mmap/mprotect hooks
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Wright <chrisw@osdl.org>
Cc: lsm <linux-security-module@wirex.com>, James Morris <jmorris@redhat.com>,
   selinux@tycho.nsa.gov, Ivan Gyurdiev <ivg2@cornell.edu>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20050222234737.GK15867@shell0.pdx.osdl.net>
References: <1109095368.15893.17.camel@moss-spartans.epoch.ncsc.mil>
	 <20050222234737.GK15867@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 08:09:58 -0500
Message-Id: <1109164198.17298.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-22 at 15:47 -0800, Chris Wright wrote:
> Only other way I can see is to effectively tweak policy based on
> tsk->personality.  While it seems ugly, it's an accurate reflection
> of both policy and reality (with some confusion of audit messages when
> building policy).  But your patch is probably the most straight-forward
> way to do it.

Yes, the patch lets us distinguish between application-requested execute
protection and the implied execute protection by read-implies-exec
logic, which I think is useful, e.g. we'll still apply execute-related
checking when ld.so explicitly requests an executable mapping.  It also
avoids having to explicitly check current->personality and file-
>f_vfsmnt->mnt_flags again for READ_IMPLIES_EXEC and MNT_NOEXEC
respectively in the security module.

> Do you want to sample prot after it's been cleared of GROWSUP/DOWN bits
> just to keep reqport as clean as possible?

Good idea.

> unnecessary initialization

Ok, thanks.

> Looks an unnecessary duplicate 

Yes, good catch.

Ok, I'll rework accordingly and plan to submit post 2.6.11.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
