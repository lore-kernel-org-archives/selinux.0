Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAPGLoIi026389
	for <selinux@tycho.nsa.gov>; Thu, 25 Nov 2004 11:21:50 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAPGLr4B025677
	for <selinux@tycho.nsa.gov>; Thu, 25 Nov 2004 16:21:53 GMT
Date: Thu, 25 Nov 2004 16:32:32 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: policy patch
Message-ID: <20041125163232.GA26737@lkcl.net>
References: <200411260027.41899.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200411260027.41899.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Nov 26, 2004 at 12:27:39AM +1100, Russell Coker wrote:
> The attached patch makes some trivial policy changes.
> 
> Allows Debian systems to touch /etc from an init script.
 
 i fixed the /etc/init.d script which does the /etc touching,
 sent a patch to the maintainer of initscripts.

 lessavalook.... yes: mountvirtfs - it calls a bash function
 dir_writable on /etc/ in order to determine whether /etc/mtab
 is writeable, which is a bit of a daft way to do it.

 the patch version, iirc, attempts to touch /etc/mtab instead
 (if it's not a symlink).

 afaik, this is the only reason for allowing debian init
 scripts to write to /etc and it's not a very good one!

 l.
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
