Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA11695
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 12:57:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA01326
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 16:56:02 GMT
Received: from mail.lemuria.org ([213.191.74.130])
	by jazzswing.ncsc.mil  with ESMTP id QAA01322
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 16:56:01 GMT
Received: from unicorn.lemuria.org (b067114.adsl.hansenet.de [62.109.67.114])
	by mail.lemuria.org (Postfix) with ESMTP id DF539BB8B
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 18:51:19 +0200 (CEST)
Date: Fri, 19 Apr 2002 18:55:07 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy "bloat" ?
Message-ID: <20020419185507.B11916@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One question for understanding: There are tons of files and rules in
the example policy that are unnecessary for my install. So I've started
to remove them, mostly in order to reduce the complexity and make
everything easier to understand.

Is there any risk or noticeable performance impact from having
unnecessary rules, e.g. dhcp stuff on a system that has neither client
nor server installed?

If so, would it make sense to include a 2nd, "minimal" example policy?

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
