Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: trivial logging bug
Date: Mon, 30 Sep 2002 21:37:15 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0209301451040.7010-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0209301451040.7010-100000@raven>
MIME-Version: 1.0
Message-Id: <200209302137.15850.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 30 Sep 2002 20:55, Stephen Smalley wrote:
> On Mon, 30 Sep 2002, Russell Coker wrote:
> This behavior is due to the security_ops->inode_rmdir hook being called
> after the d_unhash on the dentry in vfs_rmdir, so the dentry appears
> "deleted" to the pathname generation code.  To fix, we would need to move
> up the hook call in the LSM patch.  Other than potentially confusing
> output, I don't think that it is a real concern.

OK, well just finding and removing the "(deleted)" string before displaying 
the message will give a good result for the users...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
