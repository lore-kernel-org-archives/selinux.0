Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8OFXdrT018327
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 11:33:39 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8OFXarq026641
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 15:33:37 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: start_udev
Date: Sat, 25 Sep 2004 01:33:34 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200409240339.57966.russell@coker.com.au> <20040923210726.GB5940@lkcl.net>
In-Reply-To: <20040923210726.GB5940@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409250133.34257.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 24 Sep 2004 07:07, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> any chance that script could be pushed upstream so that debian can use
> it and stop creating those same symlinks from /etc/init.d/udev?

It would probably be best for someone who uses udev on Debian (such as you) to 
go to 
http://download.fedora.redhat.com/pub/fedora/linux/core/development/SRPMS/ , 
download the rpm package and use rpm2cpio to extract the file and make a 
Debian bug report with the file attached.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
