Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i29E0qRb012354
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 09:00:52 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i29E0p0F013087
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 14:00:51 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i29E0ogZ013083 for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 14:00:50 GMT
Subject: Re: XFS and SE Linux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200403100014.03542.russell@coker.com.au>
References: <200403100014.03542.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1078840842.4022.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 09 Mar 2004 09:00:43 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-03-09 at 08:14, Russell Coker wrote:
> Currently in SE Linux the contexts for files are of the form 
> "system_u:object_r:file_t", why not express them on disk as 
> "system_u:file_t"?  Saving 9 bytes in this manner could make some of them fit 
> into a 256 byte Inode in XFS which would be a significant advantage.  Also 
> for Ext2/Ext3 it will save some space as well.

Why not just fix XFS to handle xattrs sanely?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
