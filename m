Subject: Re: Patch for restorecond to not report an error if
	filesystem	does not support XATTR
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <4570F505.5050305@tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885C80CA@exchange.columbia.tresys.com>
	 <1164913329.23019.978.camel@moss-spartans.epoch.ncsc.mil>
	 <4570F505.5050305@tresys.com>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 15:10:09 -0500
Message-Id: <1165263009.2923.132.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-12-01 at 22:37 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > 
> > Interesting question...the policy Makefile and the fixfiles script have
> > always just used a hardcoded list of filesystem types known to support
> > file security labeling.  And the policy configuration explicitly
> > specifies the filesystem types for which SELinux tries to use xattrs, as
> > the mere presence of an xattr handler has never been a sufficient test.
> > Possibly we should be extracting that list from policy and making it
> > available for programs that need to know it.
> > 
> > Even testing the result of setxattr for EOPNOTSUPP is not 100%, as
> > setxattr will also fall back to setting the incore value if a) you pass
> > permission checks and b) the filesystem provides no setxattr method at
> > all (NFS happens to provide one, but it only supports ACLs).  So it
> > could succeed (e.g. devpts nodes) or fail with -EACCES (e.g. proc).
> > 
> 
> Can we make an selinuxfs node that just outputs the list of fs_use_xattr 
> filesystems?

That could be done.  But that will require a kernel patch, whereas you
could just have the policy build process emit the list to a config file
and install it somewhere under /etc/selinux/ for reading by restorecond
and fixfiles (and the policy Makefile could generate the list privately
for its own use for the relabel target).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
