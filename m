Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAKB5lRb022897
	for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2003 06:05:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAKB5kqY017712
	for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2003 11:05:46 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hAKB5j0o017709 for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2003 11:05:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Carlos =?iso-8859-1?q?An=EDsio=20Monteiro?= <monteiro@ipen.br>,
   selinux <selinux@tycho.nsa.gov>
Subject: Re: initrd image
Date: Thu, 20 Nov 2003 22:05:40 +1100
References: <3FBC9B4A.30504@ipen.br>
In-Reply-To: <3FBC9B4A.30504@ipen.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311202205.41000.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 Nov 2003 21:45, Carlos Anísio Monteiro <monteiro@ipen.br> wrote:
> You sent a email to selinux list saying that ceased the use of the initrd.
> Please, I'd like to know, how you are loading first policy to running
> before the init process. Because, if I load policy after the init
> process one inconsistency is verified and, in my case, I not succeeded
> in login to the system, due selinux not acknowledge the context default
> for the users.

In his repository Dan Walsh has an rpm of SysVinit which is patched to do 
this.  It will mount /selinux, load the policy, and then re-exec itself to 
get the right context.

Check the list archives for the discussion that led up to this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
