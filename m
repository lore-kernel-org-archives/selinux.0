Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i87CDqrT025575
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 08:13:53 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i87CDoll007122
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 12:13:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: dpkg and selinux
Date: Tue, 7 Sep 2004 22:13:47 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>, debian-dpkg@lists.debian.org
References: <20040831234115.GZ4375@lkcl.net> <20040901101921.GC5882@lkcl.net> <20040901174718.GE4400@lkcl.net>
In-Reply-To: <20040901174718.GE4400@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409072213.47126.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2 Sep 2004 03:47, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> consequently, in short, it's probably best to patch dpkg's
> "tarobject()" function to set the SE/Linux file permissions,
> and to have those permissions preserved as the unpacked
> archive is then moved into place.

That's probably correct.  Code contributions are welcome...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
