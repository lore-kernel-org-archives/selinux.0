Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NFGZrT018622
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 11:16:35 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NFGYwb000751
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 15:16:34 GMT
Subject: Re: conflict between libselinux and libsepol
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1093035295.4212.9.camel@nexus.verbum.private>
References: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
	 <1092972342.29540.35.camel@nexus.verbum.private>
	 <1093002523.16585.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1093013527.9495.0.camel@nexus.verbum.private>
	 <1093015484.16585.199.camel@moss-spartans.epoch.ncsc.mil>
	 <1093028441.16585.265.camel@moss-spartans.epoch.ncsc.mil>
	 <1093030667.4212.4.camel@nexus.verbum.private>
	 <1093035295.4212.9.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1093274109.27211.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 23 Aug 2004 11:15:09 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-20 at 16:54, Colin Walters wrote:
> And a patch for the policy Makefile to cause it to verify the file
> contexts under the "policy" target.  I think this makes sense because
> conceptually the file contexts is part of the whole system security
> policy.

Committed, with s/setfiles/$(SETFILES)/.
Note however that the 'policy' target is not used in common practice
once the policy is installed, so if someone does local customization and
does a make (== make install by default), it won't be validated in this
manner.  The spec file does a 'make policy' in the %build, so it will
perform such validation, but manual usage of the policy target is
typically limited to testing/development.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
