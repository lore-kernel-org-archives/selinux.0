Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBFErkRb020024
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 09:53:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBFEqvjx002996
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 14:52:57 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hBFEquSR002993
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 14:52:57 GMT
Subject: Re: [patch] add source line numbers to checkpolicy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   Howard Holm <hdholm@epoch.ncsc.mil>, Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <1071478020.17990.8.camel@nexus.verbum.private>
References: <1071478020.17990.8.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1071500009.28044.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 15 Dec 2003 09:53:29 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-15 at 03:47, Colin Walters wrote:
> Attached are two patches which have checkpolicy emit the source line
> number where an error occurred, if available.  This would have been
> fairly trivial, except it required rewriting the sample policy Makefile
> to not invoke m4 multiple times.  
> 
> It all seems to work fine, but the changes to the Makefile should
> probably be looked at carefully - I don't understand why it wasn't
> written like this in the first place, so I'm wondering if I'm missing
> something.

Thanks, this looks useful.  If I recall correctly, we originally split
up the m4 processing because we were encountering a m4 failure due to
the number of arguments.  I'm not sure what version of m4 that was, but
the m4 on RHEL3 and FC1 appear to work fine with your patch and all
existing .te files enabled, so perhaps that limitation was eliminated. 
Given this change, I would think that we could also factor out
tmp/program_unused_flags.te and $(ALL_MACROS) from ALLTEFILES and
CONSTRAINT_CONTEXT_MACRO_FILES and only include them once in POLICYFILES
prior to TE_RBAC_FILES.

The fact that you retain the policy.conf line information as well as the
source line information is important, as some tools now use that
information (e.g. Tresys setools), and since the source file and line
information doesn't deal with macro expansion.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
