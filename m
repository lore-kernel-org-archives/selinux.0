Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6CBGrrT000939
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 07:16:53 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6CBGmPJ005398
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 11:16:50 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: Bug#258725: Location of net.agent
Date: Mon, 12 Jul 2004 21:16:36 +1000
Cc: Thomas Hood <jdthood@aglu.demon.nl>, 258725@bugs.debian.org,
   "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
   SE-Linux <selinux@tycho.nsa.gov>
References: <20040711145538.GA15954@wonderland.linux.it> <1089615747.2520.213.camel@localhost.localdomain> <20040712083309.GU4677@lkcl.net>
In-Reply-To: <20040712083309.GU4677@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407122116.36896.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 12 Jul 2004 18:33, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
>  by recommending a subdirectory, it is possible to do the
>  selinux-equivalent of setgid, such that any file in that
>  subdirectory will be made writeable to the hotplug scripts.

There are two advantages of a subdirectory for writable files, one is that we 
don't have to keep changing the file_contexts file every time a change is 
made to hotplug, the other is that on systems with a read-only root only one 
sym-link is needed to get those files written to a writable file system.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
