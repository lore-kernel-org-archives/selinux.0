Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9QEkFXZ012752
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 10:46:16 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9QEiwC0023586
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 14:44:58 GMT
Subject: Re: [PATCH] devpts xattr support
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <417E5BB5.1010300@trustedcs.com>
References: <417E5BB5.1010300@trustedcs.com>
Content-Type: text/plain
Message-Id: <1098801765.27060.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 26 Oct 2004 10:42:46 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-26 at 10:14, Darrel Goeddel wrote:
> Below is a patch (against the SourceForge CVS) that will give xattr 
> support to directories in a devpts filesystem.  This will allow the 
> context of the root node to be retrieved and modified.  Note that there 
> are other filesystems using the simple_dir_inode_operations that may 
> need to be changed later as xattr support is spread to more filesystems 
> (devpts is the only one causing a problem right now), so a more general 
> fix may be wanted/needed later.  Any comments are appreciated.

Thanks.  Let's step back for a moment from the implementation and talk
about the general issue IIUC:  you want userspace to be able to get and
set the file context of any file (as seen internally by the SELinux
module), regardless of the underlying filesystem type, using a single
API.  That is what we had with the original SELinux API; stat_secure and
friends always returned the incore inode SID directly.  In contrast,
using the xattr API and framework, we must add xattr handlers to each
filesystem implementation (and for each kind of inode, as in your patch)
in order to export file contexts to userspace, even when those handlers
do nothing more than call into the security module to map an incore
inode SID to a context (as with devpts and tmpfs).  IIRC,
TrustedBSD/FreeBSD approached this issue differently, with separate and
orthogonal APIs for xattrs vs. MAC labels so that you could get the MAC
label of a file independently of whether or not the filesystem supported
extended attributes (e.g. singe-level filesystems).  So now would be a
good time to confirm that we want to proceed down this path of adding
more fake xattr handlers wherever the filesystem does not natively
support xattrs so that userspace can have a single consistent interface
for getting file contexts.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
