Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9INYIi014640
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 13:23:34 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9INbEj003493
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 18:23:37 GMT
Subject: Re: Single home directory type for all roles.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <rcoker@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux list <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Colin Walters <walters@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <1102615951.4509.50.camel@aeon>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
	 <1102614445.4509.25.camel@aeon>
	 <1102614805.32175.176.camel@moss-spartans.epoch.ncsc.mil>
	 <1102615951.4509.50.camel@aeon>
Content-Type: text/plain
Message-Id: <1102616319.32175.184.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 09 Dec 2004 13:18:39 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 13:12, Russell Coker wrote:
> Last time I mentioned this I was informed that it is impractically
> difficult for the kernel code to differentiate between an application
> such as ls calling readlink(2) and the kernel code calling it as part of
> a file open operation.

Not sure who said that, but there are two separate LSM hooks on those
code paths, security_inode_readlink() vs. security_inode_follow_link(). 
They just happen to perform the same check in SELinux presently. 
Whether or not it is legitimate to separate them in the access control
model is another question; if you don't want the admin following the
link, why do you want an application he runs to rely on the information
returned by readlink?
In any event, we could apply different permission checks - it just
requires defining a new permission in the lnk_file class and modifying
the selinux_inode_follow_link() hook function to use it.  Trivial patch,
anyone could do it (but then you would need to identify all the places
in the policy where you would need to add it).

> The solution then would be to have a separate domain for the
> administrator to run ls which can read all sym-links while other
> programs the administrator may run (rm, cp, mv, etc) will be denied
> access to read many types of sym-link.  Is this a good idea?

Seems painful.

> Can we break the tradition of having only /home/$USER in this regard?
> There are several other categories of files that are relevant to
> security that could benefit from similar treatment if we go down that
> path.

For MLS, we'll need multiple home directories per user anyway, although
they could all be rooted under /home/$USER and polyinstantiated
directories could be used to transparently redirect to the right member
subdirectory.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
