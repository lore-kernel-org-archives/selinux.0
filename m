Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SMO9rT014754
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 18:24:09 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6SMO3Xs017821
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 22:24:07 GMT
Subject: SSH needs to signal itself
From: Erich Schubert <erich@debian.org>
To: selinux@tycho.nsa.gov, russell@coker.com.au
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Jul 2004 00:23:53 +0200
Message-Id: <1091053433.30708.0.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I had stuck ssh processes (stuck in the pam phase) with wrong usernames.
Apparently ssh tried to signal itself to shut down the connection which
was blocked by SElinux until i added the rule
  allow sshd_t sshd_t:process signal;

Greetings,
Erich Schubert
-- 
      erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C     (o_
 A man doesn't know what he knows until he knows what he doesn't know. //\
     Es ist beschämender seinen Freunden zu mißtrauen als von ihnen    V_/_
         getäuscht zu werden. --- François de la Rochefoucauld




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
