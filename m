Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1NIOXtK024206
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 13:24:33 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1NIPq0Z016496
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 18:25:52 GMT
Subject: Re: Samba policy patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <92F5A105-2A19-4AA0-956B-C9E963A762CC@sf-net.com>
References: <92F5A105-2A19-4AA0-956B-C9E963A762CC@sf-net.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 13:26:07 -0500
Message-Id: <1172255167.15371.71.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-19 at 13:40 +0100, Stefan Schulze Frielinghaus wrote:
> While using samba and SELinux with Debian GNU/Linux (etch) the  
> following files need to be labeled correctly:
> /var/run/samba/gencache.tdb
> /var/run/samba/share_info.tdb
> 
> Should also concern other distributions than Debian.

The patch is malformed because the lines wrapped.  Merged by hand.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
