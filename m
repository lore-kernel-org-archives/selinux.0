Date: Mon, 30 Sep 2002 14:55:20 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: trivial logging bug
In-Reply-To: <200209302004.38709.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0209301451040.7010-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 30 Sep 2002, Russell Coker wrote:

> avc:  denied  { rmdir } for  pid=9631 exe=/bin/rm path=/rjc/.ssh/old (deleted)
> dev=03:07 ino=3406 scontext=rjc:user_r:user_t
> tcontext=system_u:object_r:user_home_ssh_t tclass=dir
>
> The above is from an rmdir operation.  It seems that the dentry gets updated
> with the new name BEFORE the operation is permitted so we get (deleted) in
> the log message which is confusing.
>
> I think that perhaps the logging code should be changed to remove the last 10
> characters of the file name.
>
> However maybe it would be more correct in terms of code operation to have the
> check earlier?  (I don't know I haven't looked at the code in question).

This behavior is due to the security_ops->inode_rmdir hook being called
after the d_unhash on the dentry in vfs_rmdir, so the dentry appears
"deleted" to the pathname generation code.  To fix, we would need to move
up the hook call in the LSM patch.  Other than potentially confusing
output, I don't think that it is a real concern.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
