Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5EDXFgA014586
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2005 09:33:15 -0400 (EDT)
Subject: Re: [PATCH] devpts xattr support
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: James Morris <jmorris@redhat.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>,
   Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
In-Reply-To: <42ADF43D.9080002@trustedcs.com>
References: 
	 <Xine.LNX.4.44.0410271428590.10702-100000@thoron.boston.redhat.com>
	 <1118691161.24565.147.camel@moss-spartans.epoch.ncsc.mil>
	 <42ADF43D.9080002@trustedcs.com>
Content-Type: text/plain
Date: Tue, 14 Jun 2005 09:15:18 -0400
Message-Id: <1118754918.32637.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-06-13 at 16:01 -0500, Darrel Goeddel wrote:
> What about the case of an xattr handle being present that does not support security
> attributes?  Or the case where an appropriate handler exists but there is no data stored
> on the filesystem (I think this still happens for directories that are mounted over at
> install time on Fedora Core).  Changing the above to:
> 
> 	}
> 	if ((error == -EOPNOTSUPP || error == -ENODATA) &&
> 	    !strncmp(kname, XATTR_SECURITY_PREFIX, sizeof XATTR_SECURITY_PREFIX - 1)) {
> 
> would handle those cases as well (I think that gets em all).

If the filesystem has an xattr handler at all, I think that the right
solution is to extend that handler to deal with security attributes, and
this has already been done for the usual suspects (ext[23], reiserfs,
xfs, jfs).  Not sure about whether we want to hide the ENODATA case from
userspace; setfiles, restorecon, and chcon all have explicit checks for
that case presently (e.g. you want setfiles to assign a label in the
ENODATA case even if the default incore inode label happens to match
file_contexts).

> > +		const char *suffix = kname + sizeof XATTR_SECURITY_PREFIX - 1;
> > +		error = security_inode_getsecurity(d->d_inode, suffix, kvalue, size);
> 
> Shouldn't we also check security_inode_getxattr before going ahead with the
> security_ionde_getxattr_checkin the "fallback" case?

We should apply a permission check, but having two hook calls at the
same location is rather ugly.  Possibly we could duplicate the check in
the inode_getsecurity hook as well.  Only case where that would be a
problem is if the kernel internally calls it for some reason and doesn't
want to apply a check based on the current process.

Other questions:
- Do we want the same kind of fallbacks for listxattr and setxattr?  For
the latter, we definitely don't want to allow setxattr of /proc inodes,
but that could be prevented by policy, whereas we do want to allow
setxattr of devpts and tmpfs inodes (as we presently do by their own
xattr handlers).  Once we have that support, we should be able to drop
the xattr handlers in devpts and tmpfs entirely, right?
- How do we want to handle removexattr?  We don't presently allow it
ever in SELinux, but other security modules might be willing to allow
removal of their security attributes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
