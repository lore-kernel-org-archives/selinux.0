Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5GEqlgA000964
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 10:52:47 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5GEi9Zm023268
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 14:44:10 GMT
Message-ID: <42B19094.2050805@trustedcs.com>
Date: Thu, 16 Jun 2005 09:45:40 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: James Morris <jmorris@redhat.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>,
   =?ISO-8859-1?Q?Lorenzo_Hern=E1nde?=
 =?ISO-8859-1?Q?z_Garc=EDa-Hierro?= <lorenzo@gnu.org>
Subject: Re: [PATCH] devpts xattr support
References: <Xine.LNX.4.44.0410271428590.10702-100000@thoron.boston.redhat.com>	 <1118691161.24565.147.camel@moss-spartans.epoch.ncsc.mil>	 <42ADF43D.9080002@trustedcs.com> <1118754918.32637.16.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1118754918.32637.16.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2005-06-13 at 16:01 -0500, Darrel Goeddel wrote:
> 
>>What about the case of an xattr handle being present that does not support security
>>attributes?  Or the case where an appropriate handler exists but there is no data stored
>>on the filesystem (I think this still happens for directories that are mounted over at
>>install time on Fedora Core).  Changing the above to:
>>
>>	}
>>	if ((error == -EOPNOTSUPP || error == -ENODATA) &&
>>	    !strncmp(kname, XATTR_SECURITY_PREFIX, sizeof XATTR_SECURITY_PREFIX - 1)) {
>>
>>would handle those cases as well (I think that gets em all).
> 
> 
> If the filesystem has an xattr handler at all, I think that the right
> solution is to extend that handler to deal with security attributes, and
> this has already been done for the usual suspects (ext[23], reiserfs,
> xfs, jfs).

That seems reasonable.

> Not sure about whether we want to hide the ENODATA case from
> userspace; setfiles, restorecon, and chcon all have explicit checks for
> that case presently (e.g. you want setfiles to assign a label in the
> ENODATA case even if the default incore inode label happens to match
> file_contexts).

It certainly seems that we would want to preserve that error case.  I do remember
some confusion here when mounting a newly created filesystem and having ls
return NULL for the security context.  Using the fallback after getting ENODATA
gave the "seemingly desired" functionality of returning the context that is being
used for enforcement.  That context could be inferred from the policy - I just
wonder if that will be good enough for a CC eval.

Another potential area of suestion may be that selinux_inode_getxattr() will
return -EOPNOTSUPP for filesystems with the behavior of SECURITY_FS_USE_MNTPOINT.
This will make it impossible to get the context being used for enforcement, although
it is better than getting a completely unrelated context that be returned from the
filesystem's getxattr.  Sure would be nice to have the old security APIs back...
Maybe we could add a new SELINUX_ENFORCEABLE xattr that would always call
security_inode_getsecurity without consulting the filesystem :)

> 
>>>+		const char *suffix = kname + sizeof XATTR_SECURITY_PREFIX - 1;
>>>+		error = security_inode_getsecurity(d->d_inode, suffix, kvalue, size);
>>
>>Shouldn't we also check security_inode_getxattr before going ahead with the
>>security_ionde_getxattr_checkin the "fallback" case?
> 
> 
> We should apply a permission check, but having two hook calls at the
> same location is rather ugly.  Possibly we could duplicate the check in
> the inode_getsecurity hook as well.  Only case where that would be a
> problem is if the kernel internally calls it for some reason and doesn't
> want to apply a check based on the current process.

If the audit subsystem will make use of security_inode_getsecurity hook, that
will be the case.

> Other questions:
> - Do we want the same kind of fallbacks for listxattr and setxattr?  For
> the latter, we definitely don't want to allow setxattr of /proc inodes,
> but that could be prevented by policy, whereas we do want to allow
> setxattr of devpts and tmpfs inodes (as we presently do by their own
> xattr handlers).  Once we have that support, we should be able to drop
> the xattr handlers in devpts and tmpfs entirely, right?

I am not sure how useful a listxattr fallback would be, but I can see no
problems with it.  It seems that we would also want to then extend the
existing listxattr functions of the pseudo filesystems to include a
consultation to the lsm as well so they can spit out security info just
as if they had not implemented the listxattr function.  

I have a bit more concern about the setxattr fallback. Since this operation
is a bit more important, I like the extra thought that is required for
adding the proper support.

> - How do we want to handle removexattr?  We don't presently allow it
> ever in SELinux, but other security modules might be willing to allow
> removal of their security attributes.
> 

If we do without a setxattr fallback, we wouldn't want a removexattr fallback.
If there is a setxattr fallback, we would most likely want a removexattr
fallback as well - just not with an SELinux implementation.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
