Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9KCTIi015716
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 15:12:29 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9KCWEj008210
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 20:12:32 GMT
Subject: Re: Single home directory type for all roles.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <rcoker@redhat.com>, Colin Walters <walters@redhat.com>,
   SE Linux list <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <41B8AB69.1060805@redhat.com>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102613299.10785.21.camel@nexus.verbum.private>
	 <1102615344.4509.39.camel@aeon>  <41B8AB69.1060805@redhat.com>
Content-Type: text/plain
Message-Id: <1102622855.32175.240.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 09 Dec 2004 15:07:35 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 14:45, Daniel J Walsh wrote:
> Yes up to now they have had too, but we are trying to expand the number 
> of users of strict policy. 
> I believe if you have to massively relabel in the course of 
> administrating the machine, we have a bug.

Massively relabeling would indeed be wrong.  At most, we're talking
about a user's own files, and even there, I don't think we want to
automatically relabel anyway.  It requires knowledge of:
- the relationship between the old role and new role,
- the data in question.

The admin may just choose to move aside the old home directory and start
a new one for the user, e.g. with "clean" dotfiles to avoid tainting.

> I want to go back to the separation between user and staff without the 
> differences in file system.

If there is no difference in the filesystem, then what real separation
have you achieved?  At that point, you are relying entirely on DAC to
protect staff_r's files from user_r (except for relying on SELinux to
prevent DAC overrides by user_r).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
