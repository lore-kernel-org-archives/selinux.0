Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i920hOrT006002
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 20:43:24 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i920hKEZ019546
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 00:43:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: policy patches
Date: Sat, 2 Oct 2004 10:43:19 +1000
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
References: <200409292354.15227.russell@coker.com.au> <200410020344.04225.russell@coker.com.au> <415DC1D7.9040109@redhat.com>
In-Reply-To: <415DC1D7.9040109@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410021043.19336.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

+dontaudit $1_mozilla_t tmp_t:lnk_file read;

This should not be possible.  If tmp_t:lnk_file gets generated with strict 
policy then we have a bug somewhere else.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
