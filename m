Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6S8MVrT008182
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 04:22:31 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6S8LxAN026990
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 08:22:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: file_contexts patch
Date: Wed, 28 Jul 2004 16:48:09 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux ML <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
References: <20040716201531.GB4940@obadja.jmh.mhn.de> <1090873552.25761.28.camel@moss-spartans.epoch.ncsc.mil> <20040726220609.GB2175@jmh.mhn.de>
In-Reply-To: <20040726220609.GB2175@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407281648.09337.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Jul 2004 08:06, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> To support distro-specific file contexts we would have to modify the
> build to include the tunables when creating the file_contexts file (it
> is already run through m4). Something like the following quick patch:

Good idea.  I've put it in my tree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
