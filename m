Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA10296
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 06:55:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA05565
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 11:54:06 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id LAA05561
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 11:54:05 GMT
Date: Mon, 28 Oct 2002 12:55:55 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: dontaudit
Message-ID: <20021028125555.A3585@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there a way to globally turn off dontaudit ?

I have a very weird problem I don't understand which doesn't give any
error messages, so I assume that some dontaudit rule suppresses them.
However, I don't want to go through three or four policy files, disable
all of them, recompile, find out that it must be somewhere else and
repeat until I'm crazy.

so what is the best way to globally turn off dontaudit? grep -v
dontaudit policy.conf  ?


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
