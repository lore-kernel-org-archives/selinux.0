Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hASBfGRb026951
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 06:41:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hASBfFqY029094
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 11:41:16 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hASBfE0o029086 for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 11:41:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Carlos =?iso-8859-1?q?An=EDsio=20Monteiro?= <monteiro@ipen.br>,
   selinux <selinux@tycho.nsa.gov>
Subject: Re: Information about packages
Date: Fri, 28 Nov 2003 22:41:05 +1100
References: <3FC72C83.8050309@ipen.br>
In-Reply-To: <3FC72C83.8050309@ipen.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311282241.05097.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 28 Nov 2003 22:07, Carlos Anísio Monteiro <monteiro@ipen.br> wrote:
> Please, I would like to know what are the packages for SELinux more
> appropriate and more "up-to-date" (in this moment) to install in a
> *Debian/testing* with  *kernel 2.6.0* ?

deb http://www.coker.com.au/newselinux/ ./
If you add the above to your /etc/apt/sources.list file then you'll get 
everything you need.  Kernel 2.6.0 doesn't need any patches, but you'll have 
to compile it yourself.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
