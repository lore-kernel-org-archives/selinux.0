Date: Tue, 1 Oct 2002 07:34:16 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: trivial logging bug
In-Reply-To: <200209302137.15850.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210010733000.1579-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 30 Sep 2002, Russell Coker wrote:

> On Mon, 30 Sep 2002 20:55, Stephen Smalley wrote:
> > On Mon, 30 Sep 2002, Russell Coker wrote:
> > This behavior is due to the security_ops->inode_rmdir hook being called
> > after the d_unhash on the dentry in vfs_rmdir, so the dentry appears
> > "deleted" to the pathname generation code.  To fix, we would need to move
> > up the hook call in the LSM patch.  Other than potentially confusing
> > output, I don't think that it is a real concern.
>
> OK, well just finding and removing the "(deleted)" string before displaying
> the message will give a good result for the users...

No, I would expect us to submit a change to the LSM patch to move the hook
call prior to the d_unhash.  I was simply noting that it isn't a security
issue, so we don't need an immediate fix.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
