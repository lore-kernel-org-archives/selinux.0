Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9ICXIi014538
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 13:12:33 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9ICYEj003138
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 18:12:35 GMT
Subject: Re: Single home directory type for all roles.
From: Russell Coker <rcoker@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux list <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Colin Walters <walters@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <1102614805.32175.176.camel@moss-spartans.epoch.ncsc.mil>
References: <20041207000805.GH3678@jmh.mhn.de>
	 <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil>
	 <41B8826D.30105@redhat.com>
	 <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil>
	 <1102614445.4509.25.camel@aeon>
	 <1102614805.32175.176.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 05:12:31 +1100
Message-Id: <1102615951.4509.50.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 12:53 -0500, Stephen Smalley wrote:
> On Thu, 2004-12-09 at 12:47, Russell Coker wrote:
> > However there still are issues because sysadm_t can read symlinks of
> > type user_tmp_t, so a user can attempt a symlink race condition attack
> > on the administrator.
> 
> Yes, that should be removed IMHO.  Currently only occurs due to allow
> rule on sysadmfile:lnk_file.   

The problem with such a change is that it interferes with the operation
of "ls -l /tmp" (which is IMHO a fairly important operation for a system
administrator).  I can imagine a situation where one user is trying a
race condition against another user but the administrator doesn't notice
because "ls -l /tmp" doesn't display full information.

Last time I mentioned this I was informed that it is impractically
difficult for the kernel code to differentiate between an application
such as ls calling readlink(2) and the kernel code calling it as part of
a file open operation.

The solution then would be to have a separate domain for the
administrator to run ls which can read all sym-links while other
programs the administrator may run (rm, cp, mv, etc) will be denied
access to read many types of sym-link.  Is this a good idea?

> > Having a tunable to allow user roles to read each other's temporary
> > files would be much better than any other "solution" to this problem.
> 
> No, having an explicit type for the purpose of sharing is preferable, so
> that the user has to explicitly indicate what he wants to share, either
> by relabeling or by copying into a shared directory that has that type.

Relabeling probably isn't an option for the scenario under discussion.
A shared directory will work.

I have been considering such issues for a while and come to the
conclusion that having ALL files that a user creates under /home/$USER
is a limitation on what we can do in this regard.  If we
had /home/share/$USER for sharing files then we could deny
relabelto/from user_share_t and of course deny all users the ability to
write to /home/share so the users would then be unable to mess this up.
If we have shared files in /home/$USER/Public as Colin suggests then
users will do "mv Public Public.old ; mkdir Public" and then whinge when
things stop working (this is the big problem with all labeling under the
home directory but it becomes worse when sharing files with other
users).

Can we break the tradition of having only /home/$USER in this regard?
There are several other categories of files that are relevant to
security that could benefit from similar treatment if we go down that
path.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
