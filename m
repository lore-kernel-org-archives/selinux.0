Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA00426
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 14:13:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA04001
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 18:11:26 GMT
Received: from unicorn.lemuria.org (b067173.adsl.hansenet.de [62.109.67.173])
        by jazzband.ncsc.mil  with ESMTP id SAA03997 for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 18:11:25 GMT
Date: Thu, 12 Sep 2002 20:12:40 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: uml policy
Message-ID: <20020912201240.B2594@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

During Linux Kongress, I had a little chat with Russell about uml
(user-mode-linux) on top of SELinux (for now, I'll leave the
mindboggling involved with SE-UML-Linux to someone else :) ).

I've found out that uml runs fine as a standard userspace process (i.e.
as it was intendend) with the default policy. So getting it simply to
run is already done.

I plan to spend some time on running uml in it's own domain, with
minimal rights and auto-trans into it when you fire it up. I'm
announcing this so anyone else working on something similiar can yell
and we don't need to do redundant work.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
