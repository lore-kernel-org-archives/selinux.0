Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA14826
	for <selinux@tycho.nsa.gov>; Tue, 14 May 2002 11:52:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA23116
	for <selinux@tycho.nsa.gov>; Tue, 14 May 2002 15:51:06 GMT
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com [194.25.134.18])
        by jazzband.ncsc.mil  with ESMTP id PAA23106 for <selinux@tycho.nsa.gov>; Tue, 14 May 2002 15:51:04 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.dr-baldeweg.de (Postfix) with ESMTP id A8FE41BD93
	for <selinux@tycho.nsa.gov>; Tue, 14 May 2002 17:51:55 +0200 (CEST)
Message-ID: <3CE134C4.68A5B77A@dr-baldeweg.de>
Date: Tue, 14 May 2002 18:01:08 +0200
From: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
MIME-Version: 1.0
To: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: avtab: out of memory
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

Today the loading (make load) of my policy file failed with follow log
message

May 14 17:27:43 cvs kernel: ss:  loading policy configuration from
/etc/security/selinux/policy.9
May 14 17:27:43 cvs kernel: security: avtab: out of memory
....
May 14 17:37:47 cvs kernel: security:  5 users, 8 roles, 542 types
May 14 17:37:47 cvs kernel: security:  29 classes, 65787 rules

The load faild without the rules of cups und courier too. 
Now my policy file has only a size of 1.6 mb. I added only a few rules
for cvs and amanda and I think its not to great. 
MS-like: After the reboot it works fine without problems.

I don't know whats my misstake. Could anyone help me?

Thanks

  Carsten

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
