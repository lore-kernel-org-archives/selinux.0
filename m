Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NJORrT020641
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 15:24:27 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NJOPwb009616
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 19:24:25 GMT
Subject: Re: conflict between libselinux and libsepol
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1093030667.4212.4.camel@nexus.verbum.private>
References: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
	 <1092972342.29540.35.camel@nexus.verbum.private>
	 <1093002523.16585.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1093013527.9495.0.camel@nexus.verbum.private>
	 <1093015484.16585.199.camel@moss-spartans.epoch.ncsc.mil>
	 <1093028441.16585.265.camel@moss-spartans.epoch.ncsc.mil>
	 <1093030667.4212.4.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1093288981.27211.262.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 23 Aug 2004 15:23:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-20 at 15:37, Colin Walters wrote:
> Here's an updated patch against setfiles.

Likely bug:  if the context is valid in the specified binary policy but
not in the currently loaded policy on a SELinux system, then it fails
the validation check since you fall through to the
security_check_context call even if policyfile is set.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
