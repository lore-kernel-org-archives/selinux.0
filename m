Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA03598
	for <selinux@tycho.nsa.gov>; Sun, 22 Sep 2002 20:14:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA02700
	for <selinux@tycho.nsa.gov>; Mon, 23 Sep 2002 00:12:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id AAA02696 for <selinux@tycho.nsa.gov>; Mon, 23 Sep 2002 00:12:44 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 88BC892467
	for <selinux@tycho.nsa.gov>; Mon, 23 Sep 2002 10:14:27 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 6D69C4603
	for <selinux@tycho.nsa.gov>; Mon, 23 Sep 2002 02:14:12 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: setuid/setgid capability
Date: Mon, 23 Sep 2002 02:00:40 +0200
MIME-Version: 1.0
Message-Id: <200209230145.45134.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why does user_t need setuid and setgid capabilities?

So far in a quick examination of my system it seems that the man-db package 
wants setuid capability, but works OK without it except as root (as root it 
calls setuid() repeatedly trying in vain to change it's UID and puts lots of 
entries in the syslog).  Of the things I use gpg, su, passwd, etc also need 
root, but they all have different domains which allow setuid capability.

For setgid the games want it, so I could remove that access at the cost of 
losing access to high scores.  But there's probably less reason to deny 
setgid and more potential benefits.


Perhaps the default policy should be changed to deny setuid access to user_t 
and to have a comment suggesting that setgid is a candidate for removal?

If we remove setuid then we can also probably remove dac_override and 
net_bind_service as neither of them even apply if you are not root, and if 
you are root but not sysadm_r then you probably don't deserve them.

Steve was talking about removing sys_tty_config.  So we might have only { 
setgid chown fowner } as the capabilities for user_t then.


Russell Coker


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
