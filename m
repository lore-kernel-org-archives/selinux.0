Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8TBknrT014487
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 07:46:49 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8TBkkjQ005385
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 11:46:47 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: postfix, spamd, cupsd all attempting name_bind to 25, 893 etc. as "reserved_port_t"
Date: Wed, 29 Sep 2004 21:46:41 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040926171824.GD28076@lkcl.net> <20040926190736.GA2529@jmh.mhn.de> <20040926210308.GJ28076@lkcl.net>
In-Reply-To: <20040926210308.GJ28076@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409292146.41496.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 27 Sep 2004 07:03, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
>  yes i ended up with those programs.  and libsepol which doesn't have a
>  dpkg thing for it so i tarred it up to put onto the test machine.

libsepol is in my Debian repository, just not in main.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
