Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA25729
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 09:32:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA18027
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 14:30:51 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id OAA18023
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 14:30:49 GMT
Date: Mon, 4 Nov 2002 15:32:29 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: can_network()
Message-ID: <20021104153229.A6147@lemuria.org>
References: <200211041327.26273.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200211041327.26273.russell@coker.com.au>; from russell@coker.com.au on Mon, Nov 04, 2002 at 01:27:26PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 04, 2002 at 01:27:26PM +0100, Russell Coker wrote:
> It's difficult to imagine a program that needs can_network() access but which 
> does not need to read /etc/resolv.conf.

speaking of that, shouldn't there be an every_domain_except_network
domain? I'd love to use every_domain instead of all the lower macros,
but it includes can_network(), which I don't want.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
