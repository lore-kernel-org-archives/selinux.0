Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA24589
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 07:27:38 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA17232
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 12:25:40 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA17228 for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 12:25:39 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1403A92713
	for <selinux@tycho.nsa.gov>; Mon,  4 Nov 2002 23:27:34 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B8F863530
	for <selinux@tycho.nsa.gov>; Mon,  4 Nov 2002 13:27:26 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: can_network()
Date: Mon, 4 Nov 2002 13:27:26 +0100
MIME-Version: 1.0
Message-Id: <200211041327.26273.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It's difficult to imagine a program that needs can_network() access but which 
does not need to read /etc/resolv.conf.

Currently every time we write policy for such programs we have separate config 
lines for resolv_conf_t and can_network.  This makes policy files longer and 
more difficult to read, and when requirements change and entries are to be 
removed from a policy file then it's more likely that something will be 
missed.

I think that we should either include a statement granting access to 
resolv_conf_t in the can_network() macro, or we should have a separate macro 
which calls can_network() and also grants access to resolv_conf_t.

I also suspect that access to etc_t files will be necessary for such a macro 
too, but in the few minutes I've been thinking about this I haven't 
determined a suitable case to prove this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
