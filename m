Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA13643
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 08:56:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA22627
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 12:55:03 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id MAA22623
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 12:55:02 GMT
Date: Wed, 28 Aug 2002 14:56:06 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: success story
Message-ID: <20020828145606.A4758@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

thanks to the incredible work done by everyone involved, especially
russel coker, I've been able to run avc_toggle for the first time ever
without making the system come to a screetching halt. even better, sshd
and apache continued to run just fine (postfix and proftpd didn't, but
hey, I need something to do tomorrow, too :) ).

I've had a bunch of cron errors, and a few other messages, so I've
rebooted back into permissive mode to fix this first. should I post the
audit messages I received here, or somewhere else? this is a woody
system with russel's packages and policy, but maybe other people are
interested in the results, too?


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
