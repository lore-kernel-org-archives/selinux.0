Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA18297
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 02:47:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id HAA01922
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 07:45:27 GMT
Received: from unicorn.lemuria.org (b069232.adsl.hansenet.de [62.109.69.232])
        by jazzband.ncsc.mil  with ESMTP id HAA01915 for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 07:45:26 GMT
Date: Wed, 20 Nov 2002 08:45:12 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: allow a_domain_t fs_t:filesystem getattr;
Message-ID: <20021120084512.D25117@lemuria.org>
References: <200211200124.05531.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200211200124.05531.russell@coker.com.au>; from russell@coker.com.au on Wed, Nov 20, 2002 at 01:24:05AM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 20, 2002 at 01:24:05AM +0100, Russell Coker wrote:
> It seems that almost everything wants to check for free space on file systems 
> occasionally.
> 
> Is there any reason for not changing macros such as daemon_base_domain() and 
> general_domain_access() to include it instead?

Only thing I can think of is that it allows information gathering,
which may be an issue in some cases. (example: Learning about system
activity by checking on the growth patterns of the database, a kind of
traffic analysis.)

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
