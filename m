Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3SC9aRb005606
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 08:09:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3SC9YYW019495
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 12:09:34 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i3SC9XBf019492 for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 12:09:33 GMT
Subject: Re: preserving user-set contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@snu.edu>
Cc: Colin Walters <walters@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <408F2DA6.7030605@snu.edu>
References: <1082752649.12608.111.camel@nexus.verbum.private>
	 <1082989812.22940.43.camel@moss-spartans.epoch.ncsc.mil>
	 <1083116682.3390.34.camel@nexus.verbum.private>  <408F2DA6.7030605@snu.edu>
Content-Type: text/plain
Message-Id: <1083154160.25987.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 28 Apr 2004 08:09:20 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-04-28 at 00:05, Joshua Brindle wrote:
> This xattr could be protected by selinux couldn't it?
> 
> user.selinux could be 0 or 1 and selinux_inode_security could be 
> modified to apply policy to setting this attribute..
> 
> So not only would there be DAC restrictions we could also enforce 
> writing the label only on files that the user has the ability to relabel 
>   to.

Using the "user" namespace may be inappropriate, given its intended
usage and access control model per attr(5).  Adding another attribute
under the "security" namespace and altering selinux_inode_setxattr and
selinux_inode_removexattr to check a new permission to the file when
setting this attribute would be possible, but I'm not convinced that
this is desirable.

A simpler alternative would be to support two variants of the file
contexts configuration; one for initial install labeling and one for
runtime relabeling, and if the administrator is ok with users being able
to customize their home directories, then he can mark /home as <<none>>
in the config for runtime relabeling so that any local customizations in
home directories will always be preserved.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
