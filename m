Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9REJFXZ021086
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 10:19:15 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9REHvrP002061
	for <selinux@tycho.nsa.gov>; Wed, 27 Oct 2004 14:17:57 GMT
Subject: Re: [PATCH] devpts xattr support
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>, Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <417E90DB.7050405@trustedcs.com>
References: <417E5BB5.1010300@trustedcs.com>
	 <1098801765.27060.39.camel@moss-spartans.epoch.ncsc.mil>
	 <417E90DB.7050405@trustedcs.com>
Content-Type: text/plain
Message-Id: <1098886534.30470.112.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 27 Oct 2004 10:15:34 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-10-26 at 14:00, Darrel Goeddel wrote:
> IMHO the "nicest" way to achieve this would be to abandon the use of the
> xattr interface between libselinux and the kernel.  The get/set SID
> operations would then be achieved through a new interface (we had toyed
> with the idea of a transaction node in selinuxfs).  This interface would 
> not be a duplicate of the xattr interfaces, rather it would be more of a 
> specialized wrapper using the xattrs internally.  The standard xattr 
> system would still be used internally for permanent storage on supported 
> filesystems.  The get operation would look up the file and return the 
> SID that was placed on the incore inode through the current means - no 
> modifications needed in the SID association.  The set operation would 
> also do a lookup,  set the SID on the incore inode, and then propagate 
> that  information to the xattr system if it is supported by that 
> filesystem very much like the post_create function.  These new 
> interfaces would alleviate the need for enhancing all of the pseudo 
> filesystems to include xattr support, and it would be a quick road to 
> full attribute support for all files under SELinux.

While I'm sympathetic to the notion (as it is more in line with the
original stat_secure/chsid API), I have a hard time seeing how this will
fly upstream.  What about every other attribute, e.g. POSIX ACLs; will
these too ultimately get their own API separate and orthogonal to the
xattr API?  Even the xattr API itself is controversial (vs.
attributes-as-files).  I also shudder a bit at the thought of this API
via selinuxfs, particularly f[gs]etfilecon.

On the other hand, adding a fake xattr handler to every filesystem that
doesn't natively support them also seems difficult to accept; we've only
done this to date on a demand basis; devpts needed the support for pty
relabeling, tmpfs needed support for udev.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
