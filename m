Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8CF1eLa024818
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 11:01:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8CF02LY013193
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 15:00:02 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8CExxsG013190
	for <selinux@tycho.nsa.gov>; Fri, 12 Sep 2003 15:00:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: rfs xattr's, mkinitrd and other stories
Date: Sat, 13 Sep 2003 01:00:49 +1000
Cc: Dale Amon <amon@vnl.com>, Colin Walters <walters@verbum.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030910164854.GO5397@vnl.com> <200309111048.16590.russell@coker.com.au> <20030912142131.GA4648@vnl.com>
In-Reply-To: <20030912142131.GA4648@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309130100.49934.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 13 Sep 2003 00:21, Dale Amon wrote:
> Do you edit /etc/mkinitrd/mkinitrd.conf to change
> 	MKIMAGE='mkcramfs %s %s > /dev/null'
> to
> 	MKIMAGE='genromfs -d %s -f %s > /dev/null'

MKIMAGE='genromfs -f /dev/fd/1 -d %s | gzip -9 > %s'

I use the above to gzip compress it in the same command (an uncompressed gzip 
is no good).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
