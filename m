Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA01545
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 06:39:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA20640
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 10:39:50 GMT
Received: from unicorn.lemuria.org (b067017.adsl.hansenet.de [62.109.67.17])
	by jazzswing.ncsc.mil  with ESMTP id KAA20636
	for <selinux@tycho.nsa.gov>; Sun, 26 May 2002 10:39:49 GMT
Date: Sun, 26 May 2002 12:36:32 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: can_tcp_connect_to() macro
Message-ID: <20020526123632.A28379@lemuria.org>
References: <20020526095926.5C1852657@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020526095926.5C1852657@lyta.coker.com.au>; from russell@coker.com.au on Sun, May 26, 2002 at 11:59:25AM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, May 26, 2002 at 11:59:25AM +0200, Russell Coker wrote:
> What do you think about the following?

yes, please! also, a restriction on target ports may be very, very
useful (e.g. "this user can surf the web or use telnet, but can't
telnet to arbitrary ports")


-- 
New GPG Key issued (old key expired):
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
