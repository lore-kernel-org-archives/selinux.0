Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBM2h7Rb020037
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 21:43:07 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBM2h6pn024074
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 02:43:06 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hBM2h5ab024065 for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 02:43:05 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris PeBenito <pebenito@gentoo.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: var_run_domain enhancement
Date: Mon, 22 Dec 2003 13:41:39 +1100
References: <1072053545.13701.7.camel@chris.pebenito.net>
In-Reply-To: <1072053545.13701.7.camel@chris.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312221341.39393.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 22 Dec 2003 11:39, Chris PeBenito <pebenito@gentoo.org> wrote:
> Attached is a patch to add an optional second argument to the
> var_run_domain macro.  It makes it possible to specify the classes to

OK, I've put that in my tree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
