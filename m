Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8CGOULa025554
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 12:24:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8CGMqLY019019
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 16:22:52 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8CGMpsG019016
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 16:22:52 GMT
Date: Fri, 12 Sep 2003 17:24:24 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, Colin Walters <walters@verbum.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: rfs xattr's, mkinitrd and other stories
Message-ID: <20030912162424.GB13578@vnl.com>
References: <20030910164854.GO5397@vnl.com> <200309111048.16590.russell@coker.com.au> <20030912142131.GA4648@vnl.com> <200309130100.49934.russell@coker.com.au> <20030912160613.GA13578@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030912160613.GA13578@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 12, 2003 at 05:06:13PM +0100, Dale Amon wrote:
> 	mkinitrd /boot.romfs

Er, I meant:
	mkinitrd -o /boot.romfs


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
