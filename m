Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8CEMELa024566
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 10:22:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8CEMCmw024485
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 14:22:13 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8CEMC9d024476 for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 14:22:12 GMT
Date: Fri, 12 Sep 2003 15:21:31 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, Colin Walters <walters@verbum.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: rfs xattr's, mkinitrd and other stories
Message-ID: <20030912142131.GA4648@vnl.com>
References: <20030910164854.GO5397@vnl.com> <20030910230519.GU5397@vnl.com> <20030910233424.GV5397@vnl.com> <200309111048.16590.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309111048.16590.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 11, 2003 at 10:48:16AM +1000, Russell Coker wrote:
> are other file systems that do it better.  I suggest using a gzip compressed 
> romfs, it will be considerably smaller than cramfs for the same file storage 
> and work more reliably.
> 
> The Debian mkinitrd is more flexible than the Red Hat one.  So once you have 
> the correct scripts dropped in place (as Colin's package does) then you just 
> create an initrd in the regular fashion.  For Red Hat a patch to mkinitrd was 
> shipped because there is no other way to do it.

Do you edit /etc/mkinitrd/mkinitrd.conf to change
	MKIMAGE='mkcramfs %s %s > /dev/null'
to
	MKIMAGE='genromfs -d %s -f %s > /dev/null'

then? Or do you just do it all manually?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
