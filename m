Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9IEZHWt013958
	for <selinux@tycho.nsa.gov>; Sat, 18 Oct 2003 10:35:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9IEZAmR023267
	for <selinux@tycho.nsa.gov>; Sat, 18 Oct 2003 14:35:10 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9IEZ9jp023264 for <selinux@tycho.nsa.gov>; Sat, 18 Oct 2003 14:35:09 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bastian Blank <bastian+selinux=tycho.nsa.gov@waldi.eu.org>,
   selinux@tycho.nsa.gov
Subject: Re: libselinux.so.1 and some utils shouldn't be in /usr
Date: Sun, 19 Oct 2003 00:35:06 +1000
References: <20031018113455.GA22140@wavehammer.waldi.eu.org>
In-Reply-To: <20031018113455.GA22140@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310190035.06420.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 18 Oct 2003 21:34, Bastian Blank wrote:
> libselinux.so.1 and some of the utils shouldn't be in /usr.
> this applies to anything which is needed to restore a broken system
> because /usr may on an extra partition.

This has already been discussed and a patch has already been posted to the 
list.  I expect that the next release will have this fixed.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
