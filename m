Subject: Re: Latest Ref Policy Diffs
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@namei.org>,
   SE Linux <selinux@tycho.nsa.gov>, rohara@redhat.com
In-Reply-To: <1134399286.7305.49.camel@moss-spartans.epoch.ncsc.mil>
References: <4398A239.1080005@redhat.com>
	 <1134399286.7305.49.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 13:31:47 -0500
Message-Id: <1134412307.13662.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > gfs support is added
> 
> I don't think gfs supports security xattrs yet, so I don't think you
> want it to use fs_use_xattr as its labeling mechanism.  Even if it did
> support security xattrs, we are going to run into a problem with
> performing the inode security initialization on d_instantiate for remote
> (or userspace) filesystems, because we cannot propagate ERESTARTSYS from
> d_instantiate up the call chain presently, and such filesystems may need
> to return that when they have to wait on a reply from the peer.  We'll
> have the same issue for NFSv4.
> 

I know Red Hat engineering has added support for security xattrs to GFS
and has it working.  I think this is why Dan pushed this upstream.  I
don't know if this GFS code is released or anything like that, so I'm
copying the engineer working an it.  Hopefully he can also comment on
your other point.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
