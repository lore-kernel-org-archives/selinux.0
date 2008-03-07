Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m27KaSMv017319
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 15:36:28 -0500
Received: from web36601.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m27KaRWe015171
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 20:36:27 GMT
Date: Fri, 7 Mar 2008 10:49:36 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 1/2] VFS: Factor out part of vfs_setxattr so it can be called from the SELinux hook for inode_setsecctx.
To: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Cc: Dave Quigley <dpquigl@tycho.nsa.gov>, Christoph Hellwig <hch@lst.de>,
        chrisw@sous-sol.org, jmorris@namei.org, viro@zeniv.linux.org.uk,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <1204913853.1397.490.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <233981.53031.qm@web36601.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> 
> On Fri, 2008-03-07 at 10:14 -0800, Casey Schaufler wrote:
> > --- Dave Quigley <dpquigl@tycho.nsa.gov> wrote:
> > 
> > > For some odd reason I can't quite parse the first two parts
> > 
> > Let me try a different angle on the question. Maybe it just
> > doesn't come up as a real issue, and I'm concerned about nothing.
> > 
> > Just for grins lets say I wanted to set the secctx on a directory
> > in a derivative of ramfs in some unspecified way that is not
> > related to mkdir. There are no on-disk inodes. Should the code call
> > inode_setsecctx, inode_notifysecctx, or both? It seems rational to
> > me to call inode_setsecctx, but since the differentiation between
> > the interfaces is the "on disk" factor and ramfs only exists as
> > in core, it would seem that inode_notifysecctx would be correct.
> 
> If you are setting (changing) the value, then use inode_setsecctx (or
> the existing inode_setsecurity, which is used by the xattr code, but
> that is limited to setting a single xattr value by name).

So any code that wants to explicitly set the secctx (as opposed to a
specific attribute value) calls inode_setsecctx. This makes perfect
sense.

> If you are just notifying the security module of a value that should be
> associated with the inode, use inode_notifysecctx.

So this is a way for filesystem code to pass information to an LSM
without specifying semantics. Is there an expectation that
inode_getsecctx return the value sent by inode_notifysecctx, or
would you expect the "notify" secctx to be stored elsewhere? 

> Reasonable?

I think that the theory is fine, but I forsee implementation
complications if the details of what is expected of an LSM aren't
clear. At this point I'm not objecting to the interface so much as
hoping to be able to use it properly, even with my limited and
deteriorating mental facilties.

Thank you.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
