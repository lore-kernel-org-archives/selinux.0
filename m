Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QDOXrT027278
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 09:24:33 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QDNU76013709
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 13:23:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: udev_uses_tmpfs
Date: Sun, 26 Sep 2004 23:24:29 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040926120608.GG26338@lkcl.net>
In-Reply-To: <20040926120608.GG26338@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409262324.29324.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 26 Sep 2004 22:06, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> if there are _really_ some redhat-specific things such as "only redhat
> does udev+tmpfs from its initial ramdisk" then fine.

That's what it is.

If tmpfs is mounted after the machine boots (as done in Debian) then it can be 
correctly labelled before use.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
