Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KBgMrT002993
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 07:42:22 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KBff4v001619
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 11:41:41 GMT
Subject: Re: restorecon
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200408201918.40233.russell@coker.com.au>
References: <200408201918.40233.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093002067.16585.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 20 Aug 2004 07:41:07 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-20 at 05:18, Russell Coker wrote:
> In 1.16 there is a new check in restorecon:
<snip>
> Is this really what we want?

We definitely want to apply realpath() in the case where the final
component is not a symlink, so that commands like:
	cd /etc; restorecon passwd shadow group (i.e. relative paths)
	-or-
	restorecon /usr/lib/X11/config (i.e. intermediate symlinks)
will work and apply the same security context that would be applied by
setfiles.

In the case where the final component is a symlink, restorecon can't
tell whether the user meant to restore the context on the symlink itself
or on the referenced file.  At present, it just falls back to the old
behavior (apply to the symlink) with a warning.

> I've attached a patch for policycoreutils to fix this.  In the case of the 
> target being a sym-link it calls realpath() on the parent directory.

Reasonable.  But still doesn't address the issue of whether the user
meant to relabel the symlink itself or the referenced file.

> To test this create a sym-link /etc/foo pointing to /lib and then try 
> relabelling /etc/foo/X where X is a sym-link.
> 
> Of course this shouldn't be an issue if the machine is in enforcing mode as 
> restorecon_t can only get read access to lnk_file class through the following 
> rules:

Yes, restorecon and setfiles are very limited in the set of symlink
types that they can read.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
