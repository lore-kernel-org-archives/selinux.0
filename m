Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9QI0QXZ014642
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 14:00:27 -0400 (EDT)
Received: from tcsfw2.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9QHx1C2011308
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 17:59:09 GMT
Message-ID: <417E90DB.7050405@trustedcs.com>
Date: Tue, 26 Oct 2004 13:00:59 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>, Chad Hanson <chanson@TrustedCS.com>
Subject: Re: [PATCH] devpts xattr support
References: <417E5BB5.1010300@trustedcs.com> <1098801765.27060.39.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1098801765.27060.39.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Thanks.  Let's step back for a moment from the implementation and talk
> about the general issue IIUC:  you want userspace to be able to get and
> set the file context of any file (as seen internally by the SELinux
> module), regardless of the underlying filesystem type, using a single
> API.  That is what we had with the original SELinux API; stat_secure and
> friends always returned the incore inode SID directly.  In contrast,
> using the xattr API and framework, we must add xattr handlers to each
> filesystem implementation (and for each kind of inode, as in your patch)
> in order to export file contexts to userspace, even when those handlers
> do nothing more than call into the security module to map an incore
> inode SID to a context (as with devpts and tmpfs).  IIRC,
> TrustedBSD/FreeBSD approached this issue differently, with separate and
> orthogonal APIs for xattrs vs. MAC labels so that you could get the MAC
> label of a file independently of whether or not the filesystem supported
> extended attributes (e.g. singe-level filesystems).  So now would be a
> good time to confirm that we want to proceed down this path of adding
> more fake xattr handlers wherever the filesystem does not natively
> support xattrs so that userspace can have a single consistent interface
> for getting file contexts.
> 

Your understanding is correct.  We want to provide an interface that
will allow userspace the ability to get/set the security attributes on
any file (with the proper checks, of course), simialr to the old SELinux 
API.  We basically need to be able to see the security attributes that 
are being enforced.  Since there are files that receive their attributes 
from sources other than xattrs (such as genfscon, transition SIDS, and 
straight process SIDS), an interface which directly looks at the incore 
inode for those files would be great.

IMHO the "nicest" way to achieve this would be to abandon the use of the
xattr interface between libselinux and the kernel.  The get/set SID
operations would then be achieved through a new interface (we had toyed
with the idea of a transaction node in selinuxfs).  This interface would 
not be a duplicate of the xattr interfaces, rather it would be more of a 
specialized wrapper using the xattrs internally.  The standard xattr 
system would still be used internally for permanent storage on supported 
filesystems.  The get operation would look up the file and return the 
SID that was placed on the incore inode through the current means - no 
modifications needed in the SID association.  The set operation would 
also do a lookup,  set the SID on the incore inode, and then propagate 
that  information to the xattr system if it is supported by that 
filesystem very much like the post_create function.  These new 
interfaces would alleviate the need for enhancing all of the pseudo 
filesystems to include xattr support, and it would be a quick road to 
full attribute support for all files under SELinux.

I will try to get a chance to look at the BSD interfaces to see if there 
are close to what I am envisioning.

Darrel Goeddel
Senior Secure Systems Engineer

Trusted Computer Solutions             E: dgoeddel@trustedcs.com
121 West Goose Alley                   V: 217.384.0028 x19
Urbana, IL  61801                      F: 217.384.0288


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
