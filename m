Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA11715
	for <selinux@tycho.nsa.gov>; Sun, 19 Jan 2003 12:10:24 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0JHAOI07665
	for <selinux@tycho.nsa.gov>; Sun, 19 Jan 2003 17:10:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0JHANf07661 for <selinux@tycho.nsa.gov>; Sun, 19 Jan 2003 17:10:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov,
        tom@lemuria.org
Subject: Re: KDM login trouble
Date: Sun, 19 Jan 2003 18:10:15 +0100
References: <200301171418.JAA00475@moss-shockers.ncsc.mil>
In-Reply-To: <200301171418.JAA00475@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301191810.15992.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 17 Jan 2003 15:18, Stephen D. Smalley wrote:
> Offhand, I would guess that the SELinux patch for kdm was never updated
> for the newer libsecure functions and default_contexts configuration,

I have not made such an update, and I guess that Brian hasn't either.

I've been waiting for KDE 3.1 to enter Debian.  KDE 2.2 is still the latest 
supported version in Debian.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
