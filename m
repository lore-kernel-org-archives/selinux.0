Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8RHdXsJ006388
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 13:39:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8RHbmZt005500
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 17:37:48 GMT
Received: from a141.shuttle.de (home.nightdaughter.de [194.95.224.141])
	by jazzswing.ncsc.mil  with ESMTP id h8RHbfM3005491
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 17:37:47 GMT
Received: from hydra.joerghoh.de (unknown [192.168.0.14])
	by a141.shuttle.de (Postfix) with SMTP id C5BB6170032
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 19:45:29 +0200 (CEST)
Date: Sat, 27 Sep 2003 19:39:09 +0200
From: Joerg Hoh <joerg@devone.org>
To: selinux@tycho.nsa.gov
Subject: selinux and 64 bit hardware
Message-ID: <20030927173909.GB3936@hydra.joerghoh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi 

I have an alpha machine (64bit) right next to me running linux 2.6.0test5. 
I'd like to do some tests with selinux on this machine, but selinux doesn't 
work correctly. 

I've done some research at the code and detected that, some parts are _not_
portable (conversions from pointer to int, which only works on 32 bit
architectures, and so on).

Is this intentional? Are some parts based on assumptions, which are only
true on 32bit architectures? Are patches welcome to achieve a better 64 bit
compatibility?

Joerg

-- 
...Wenn man sich bei NetBSD auf eines verlassen kann, dann: Egal, WAS[...]
man updated, mplayer hat mit Sicherheit dependencies drauf.
  Rene Schickbauer, news:2591532.ZKZXAUW3eG@gandalf.grumpfzotz.org

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
