Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA00894
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 09:59:53 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA16295
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 14:57:51 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA16291 for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 14:57:49 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Subba Rao" <sailorn@attglobal.net>, selinux <selinux@tycho.nsa.gov>
Subject: Re: RH 8.1
Date: Sat, 30 Nov 2002 15:50:35 +0100
References: <200211301237.MAA18961@jazzswing.ncsc.mil>
In-Reply-To: <200211301237.MAA18961@jazzswing.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200211301550.35604.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 30 Nov 2002 13:36, Subba Rao wrote:
> Until I get a Debian distro I plan to try to install SELinux on RH 8.1.  A
> basic question I have, is SELinux distro version specific? In the LSM
> README files, the instructions do say RH 7.1 or RH 7.2.  Can I install
> SELinux on RH 8.1?

The only problem is that the patches the NSA distributes are against versions 
of the programs packaged in RH 7.x.  However I've ported some of the patches 
forward to newer versions of the utilities, and you could use them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
