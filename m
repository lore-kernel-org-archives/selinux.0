Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9U0EBWt010393
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2003 19:14:11 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9U0E2XK004287
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 00:14:02 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9U09Vj4004186 for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 00:13:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Carsten P. Gehrke" <Carsten@rollinghorse.com>,
   "SE Linux" <selinux@tycho.nsa.gov>
Subject: Re: When to use SEL kernel
Date: Mon, 27 Oct 2003 10:13:07 +1100
References: <5.2.1.1.2.20031024155304.0c94a990@Shire>
In-Reply-To: <5.2.1.1.2.20031024155304.0c94a990@Shire>
MIME-Version: 1.0
Message-Id: <200310271010.40888.russell@coker.com.au>
Content-Type: text/plain;
  charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 25 Oct 2003 08:58, Carsten P. Gehrke wrote:
> to this system (notably iptables).  My question is:  Does it matter if I
> install additional packages before or after I install (and use) the SE
> Linux kernel?

When you install a new package (or upgrade an existing package) on a live SE 
Linux system then after installing the package you must relabel all files in 
it.  Discovering which files were installed from the source will be a 
challenge for you on a source-based distribution, so relabeling the root file 
system might be easier.

If you do all your package installation before going live on SE Linux then it 
may be easier.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
