Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NCtHrT017703
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 08:55:17 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NCsWAS027498
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 12:54:32 GMT
Subject: Re: conflict between libselinux and libsepol
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Colin Walters <walters@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <4126812A.2050004@tresys.com>
References: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
	 <1092972342.29540.35.camel@nexus.verbum.private>
	 <1093002523.16585.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1093013527.9495.0.camel@nexus.verbum.private>
	 <1093015484.16585.199.camel@moss-spartans.epoch.ncsc.mil>
	 <1093028441.16585.265.camel@moss-spartans.epoch.ncsc.mil>
	 <1093030667.4212.4.camel@nexus.verbum.private>
	 <1093035295.4212.9.camel@nexus.verbum.private>
	 <4126812A.2050004@tresys.com>
Content-Type: text/plain
Message-Id: <1093265616.27211.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 23 Aug 2004 08:53:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-20 at 18:54, Joshua Brindle wrote:
> How is this the case at all? Conceptually the file contexts is *not* 
> part of the system policy, afaik that is a major design feature of 
> SELinux, that the enforcement and labeling is totally seperate (with the 
> exception of ocontext stuff ofcourse)
> 
> I believe this is the case, unless Steve disagrees ofcourse :)

Colin's patch is simply to allow verification of a file_contexts
configuration against a given policy at policy build time.  That is
reasonable.

On a side note, the file contexts configuration has become an aspect of
the runtime "policy" in the broader sense, since it is now used during
normal system operation for things like rpm, udev, restorecon, etc
rather than only for system installation and major policy upgrades.  But
it is not part of the kernel policy.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
