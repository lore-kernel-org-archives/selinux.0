Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9J8jIi015060
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 14:08:45 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9J8kEj005414
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 19:08:47 GMT
Subject: Re: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux list <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Colin Walters <walters@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <1102616319.32175.184.camel@moss-spartans.epoch.ncsc.mil>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
	 <1102614445.4509.25.camel@aeon>
	 <1102614805.32175.176.camel@moss-spartans.epoch.ncsc.mil>
	 <1102615951.4509.50.camel@aeon>
	 <1102616319.32175.184.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 06:08:37 +1100
Message-Id: <1102619317.4509.61.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 13:18 -0500, Stephen Smalley wrote:
> On Thu, 2004-12-09 at 13:12, Russell Coker wrote:
> > Last time I mentioned this I was informed that it is impractically
> > difficult for the kernel code to differentiate between an application
> > such as ls calling readlink(2) and the kernel code calling it as part of
> > a file open operation.
> 
> Not sure who said that, but there are two separate LSM hooks on those
> code paths, security_inode_readlink() vs. security_inode_follow_link(). 
> They just happen to perform the same check in SELinux presently. 
> Whether or not it is legitimate to separate them in the access control
> model is another question; if you don't want the admin following the
> link, why do you want an application he runs to rely on the information
> returned by readlink?

You are correct that there are cases of applications calling readlink(2)
for the purpose of canonicalising a path which would be vulnerable to
race conditions after such a change.  However writing an application
that does such things in a manner such that it is not vulnerable to any
race conditions is really difficult and it seems likely that most such
applications can be attacked in other ways (which will be more difficult
to implement).

But it would catch the majority of attacks and make it more difficult
for an attack to leave a file system.  Some of the attacks might work if
the attacker found a symlink in a directory that they could rename - but
the attacker would need to discover the contents of the sym-link which
should be impossible.

> In any event, we could apply different permission checks - it just
> requires defining a new permission in the lnk_file class and modifying
> the selinux_inode_follow_link() hook function to use it.  Trivial patch,
> anyone could do it (but then you would need to identify all the places
> in the policy where you would need to add it).

Fixing the policy should be easy enough.

> > The solution then would be to have a separate domain for the
> > administrator to run ls which can read all sym-links while other
> > programs the administrator may run (rm, cp, mv, etc) will be denied
> > access to read many types of sym-link.  Is this a good idea?
> 
> Seems painful.

Yes.  But it would give a practical use for ls_exec_t.  ;)

> > Can we break the tradition of having only /home/$USER in this regard?
> > There are several other categories of files that are relevant to
> > security that could benefit from similar treatment if we go down that
> > path.
> 
> For MLS, we'll need multiple home directories per user anyway, although
> they could all be rooted under /home/$USER and polyinstantiated
> directories could be used to transparently redirect to the right member
> subdirectory.

That's an entirely different issue.

If we have both strict policy in it's current form and MLS then we would
have two ways of categorising the files (role and level).  I think that
probably the best thing to do for MLS is to polyinstantiate /home per
MLS level.  Anything else seems to get too confusing too fast.

I hope that we don't plan on supporting polyinstantiation for MLS over
NFS.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
