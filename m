Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA23997
	for <selinux@tycho.nsa.gov>; Sat, 1 Mar 2003 04:15:49 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h219FmI15701
	for <selinux@tycho.nsa.gov>; Sat, 1 Mar 2003 09:15:48 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h219Fkf15697 for <selinux@tycho.nsa.gov>; Sat, 1 Mar 2003 09:15:47 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Sherman Boyd" <ShermanB@clh.com>, <selinux@tycho.nsa.gov>
Subject: Re: SELinux and ReiserFS
Date: Sat, 1 Mar 2003 10:15:35 +0100
References: <D17BA970DE186447AD8A5A2A117C2C1503E00E@bulbasaur.internal.clh.com>
In-Reply-To: <D17BA970DE186447AD8A5A2A117C2C1503E00E@bulbasaur.internal.clh.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303011015.35871.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 28 Feb 2003 23:40, Sherman Boyd wrote:
> > Is SELinux compatable with ReiserFS?

It is working fine for me on many machines.  The default SE Linux policy has 
the following file system support for persistant labelling:
fs_use_psid ext2;
fs_use_psid ext3;
fs_use_psid reiserfs;

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
