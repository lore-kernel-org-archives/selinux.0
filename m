Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PBhVrT004603
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 07:43:31 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PBhTuQ005029
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 11:43:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: prelink on debian
Date: Wed, 25 Aug 2004 21:43:25 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040823232135.GA12720@lkcl.net>
In-Reply-To: <20040823232135.GA12720@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408252143.25077.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Aug 2004 09:21, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> prelink is a script on debian: i had to add this because prelink checks
> that there's > 50mb of disk space and then exec's prelink.bin.

OK, this needs a ifdef(`distro_debian', around it.

Do you think we should have the shell script labelled as sbin_t on Debian?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
