Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9HwPIi014390
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 12:58:25 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9HumPS010461
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 17:56:48 GMT
Subject: Re: Single home directory type for all roles.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <rcoker@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux list <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Colin Walters <walters@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <1102614445.4509.25.camel@aeon>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
	 <1102614445.4509.25.camel@aeon>
Content-Type: text/plain
Message-Id: <1102614805.32175.176.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 09 Dec 2004 12:53:26 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 12:47, Russell Coker wrote:
> However there still are issues because sysadm_t can read symlinks of
> type user_tmp_t, so a user can attempt a symlink race condition attack
> on the administrator.

Yes, that should be removed IMHO.  Currently only occurs due to allow
rule on sysadmfile:lnk_file.   

> Having a tunable to allow user roles to read each other's temporary
> files would be much better than any other "solution" to this problem.

No, having an explicit type for the purpose of sharing is preferable, so
that the user has to explicitly indicate what he wants to share, either
by relabeling or by copying into a shared directory that has that type.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
