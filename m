Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2AJEhRb021421
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 14:14:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2AJEg0F012236
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 19:14:42 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
        by jazzband.ncsc.mil  with ESMTP id i2AJEggZ012233 for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 19:14:42 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2AJEfL6006841
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 14:14:41 -0500
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i2AJEfQk006839
	for selinux@tycho.nsa.gov; Wed, 10 Mar 2004 14:14:41 -0500
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2A1ZRRb016283
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 20:35:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2A1ZQ0F008556
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 01:35:26 GMT
Received: from omx2.sgi.com (mtvcafw.sgi.com [192.48.171.6])
        by jazzband.ncsc.mil  with ESMTP id i2A1ZPgZ008553 for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 01:35:25 GMT
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id i2A3aC7b026591
	for <@external-mail-relay.sgi.com:selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 19:36:13 -0800
Date: Wed, 10 Mar 2004 12:34:56 +1100
From: Nathan Scott <nathans@sgi.com>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: linux-xfs@oss.sgi.com
Subject: Re: XFS and SE Linux
Message-ID: <20040310013456.GC1004@frodo>
References: <200403100014.03542.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200403100014.03542.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Russell,

Thanks for sending this out.  Couple of additions...

On Wed, Mar 10, 2004 at 12:14:03AM +1100, Russell Coker wrote:
> XFS defaults to an Inode size of 256 bytes and a block size of 4K on i386.

These default values are platform independent.

> The "security.selinux" xattr name and the data stored in it can apparently be 
> counted on to not fit into the <50 bytes left in a 256 byte Inode after all 
> the other meta-data is stored.  This will mean that a new block is used for 
> the XATTR (which in 99.99% of all cases will be the only XATTR on the file).
> 
> Using an extra 4K block per file is a significant waste of disk space, XFS 
> apparently does not support block sharing so you have 4K of disk space for 50 
> bytes of data.

It also amounts to a fairly significant performance hit, since
there is additional I/O involved once the attributes are no longer
inline.  When we tweaked the ACL code to be more conscious of this
issue, speedups were of the order 10x-12x IIRC.

Heavy users of extended attributes should always use larger inode
sizes with XFS.

> If at mkfs time you make the Inode 512 bytes in size you will have enough 
> space for the SE Linux xattr.  This will save huge amounts of space on a SE 
> Linux system as there will effectively be 256 bytes of overhead per file 
> instead of 4096.

That extra inline space is also available for use by inline
directory entries (and of course other extended attributes),
so its not useless overhead either.

cheers.

-- 
Nathan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
