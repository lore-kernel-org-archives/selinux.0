Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6Q2AerT022023
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 22:10:40 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6Q2A4VH022256
	for <selinux@tycho.nsa.gov>; Mon, 26 Jul 2004 02:10:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Colin Walters <walters@verbum.org>
Subject: Re: [patch] openvpn policy
Date: Mon, 26 Jul 2004 12:10:19 +1000
Cc: selinux@tycho.nsa.gov
References: <1090799087.13627.14.camel@nexus.verbum.private>
In-Reply-To: <1090799087.13627.14.camel@nexus.verbum.private>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407261210.19069.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 26 Jul 2004 09:50, Colin Walters <walters@verbum.org> wrote:
> Attached is a policy for OpenVPN (http://openvpn.sf.net).  The last two
> parts of openvpn.te seem just slightly unclean; if anyone sees a better
> way, let me know.

That seems OK to me.  It is good to minimise the access that initrc_t gets to 
daemon configuration files, but it's not a big deal IMHO (it seems a fairly 
standard thing to do).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
