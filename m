Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA22228
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 11:09:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA09704
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 15:07:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA09700
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 15:07:52 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: patch for home_root_t
Date: Mon, 30 Sep 2002 17:09:14 +0200
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0209300732490.15004-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0209300732490.15004-100000@raven>
MIME-Version: 1.0
Message-Id: <200209301709.14893.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 30 Sep 2002 13:33, Stephen Smalley wrote:
> On Sat, 28 Sep 2002, Russell Coker wrote:
> > The attached patch makes home_root_t work.
>
> Most of this should already be covered by the rule in
> base_file_read_access.

I've gone back and removed some duplicate references to home_root_t from my 
tree.

After you've merged those of my current patches that you like I'll send you 
another patch for any further changes.

NB  Many of the home_root_t (and almost all of them in .te files I wrote) are 
actually needed.  Most things broke when I initially changed the type of 
/home...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
