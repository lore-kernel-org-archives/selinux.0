Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB8KLxIi008303
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 15:21:59 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB8KKLTx015529
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 20:20:22 GMT
Subject: Re: getfilecon() and friends in libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
   James Morris <jmorris@redhat.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <20041208193658.89005.qmail@web50208.mail.yahoo.com>
References: <20041208193658.89005.qmail@web50208.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1102537018.26951.182.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 08 Dec 2004 15:17:00 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-12-08 at 14:36, Casey Schaufler wrote:
> Be careful of virtual file systems (e.g. autofs,
> automount) as some implementations have semantics
> that differ between the mount point and contained
> objects. I have seen device file system
> implementations that claimed to implement extended
> attributes but that had enormously odd behaviors.

Good point.  A specific example that exists today is devpts; we only
implemented fake xattr handlers for the pty nodes themselves, not for
the root directory, so getfilecon /dev/pts will fail while getfilecon
/dev/pts/0 will succeed.  Darrel Goeddel posted a patch earlier to add
support for the /dev/pts root as well, and there was some discussion of
the need for wider support for getting file contexts without needing to
patch every pseudo filesystem to export xattr handlers.  That latter
should be much easier due to the xattr code consolidation and generic
code created by James Morris, but it would still be nice to have a
fallback in the VFS for the security namespace that would just get the
security attribute from the security module.  That discussion started at
http://marc.theaimsgroup.com/?l=selinux&m=109880845227851&w=2.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
