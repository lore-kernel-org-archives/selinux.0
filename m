Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA3FRdWt000509
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 10:27:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA3FRIC7017438
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 15:27:18 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hA3FRHuw017435
	for <selinux@tycho.nsa.gov>; Mon, 3 Nov 2003 15:27:18 GMT
Date: Mon, 3 Nov 2003 15:27:31 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: default policy package
Message-ID: <20031103152731.GC29928@vnl.com>
References: <20031103114353.GC13273@vnl.com> <200311040115.57564.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200311040115.57564.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Nov 04, 2003 at 01:15:57AM +1100, Russell Coker wrote:
> > ERROR: unknown type sysadm_xserver_t' at token ':' on line 7525:
> > allow sysadm_xserver_t xserver_tmpfile:dir { read getattr lock search ioctl
> > add name remove_name write };
> 
> The policy needs some work in that area.
> 
> The root cause is that you included startx.te without xserver.te.  If you add 
> xserver.te or remove startx.te then it should compile.

Actually, the root case is the package script. It
runs through a list of domain/programs but doesn't
know to remove misc/startx.te. Going from that
to manually fiddling left me with a 'priming effect'.
I never even thought to look in misc.

Here's one that might interest Steve: load_policy can 
totally lock up a small memory machine if the binary 
policy is large.

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
