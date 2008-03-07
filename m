Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m27IESX0029281
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 13:14:28 -0500
Received: from web36601.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m27IEOYd020209
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 18:14:25 GMT
Date: Fri, 7 Mar 2008 10:14:15 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 1/2] VFS: Factor out part of vfs_setxattr so it can be called from the SELinux hook for inode_setsecctx.
To: Dave Quigley <dpquigl@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: Christoph Hellwig <hch@lst.de>, chrisw@sous-sol.org, sds@tycho.nsa.gov,
        jmorris@namei.org, viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1204911451.14520.292.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <520476.89184.qm@web36601.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Dave Quigley <dpquigl@tycho.nsa.gov> wrote:

> For some odd reason I can't quite parse the first two parts

Let me try a different angle on the question. Maybe it just
doesn't come up as a real issue, and I'm concerned about nothing.

Just for grins lets say I wanted to set the secctx on a directory
in a derivative of ramfs in some unspecified way that is not
related to mkdir. There are no on-disk inodes. Should the code call
inode_setsecctx, inode_notifysecctx, or both? It seems rational to
me to call inode_setsecctx, but since the differentiation between
the interfaces is the "on disk" factor and ramfs only exists as
in core, it would seem that inode_notifysecctx would be correct.

Like I say, maybe it never comes up, but having these two very
similar interfaces (or the old flag) begs the question of when
to use each for things other than their original purpose. I think
we'll live in a better LSM if it's clear.

> of your
> email but to answer your question about it being an NFS only hook. As of
> right now the only user is going to be NFS however any remote filesystem
> (labeled CIFS anyone?) will potentially have this problem. Also even
> though we don't have one today if there ever were an LSM that used
> multiple xattrs for their security attributes this is a useful interface
> to them. So there are many uses for this hook but currently the only one
> is NFS.

Ok then, no worries.

Thank you


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
