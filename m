Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LDRKWt026554
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 09:27:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9LDR7IS021118
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 13:27:07 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h9LDR6Dc021101
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 13:27:06 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: chcon
Date: Tue, 21 Oct 2003 23:27:05 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310212327.05821.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve, chcon needs access to /selinux/context, is there any problem in putting 
in a macro such as the following and using it for all user domains?

define(`can_check_context', `
allow $1 security_t:dir search;
allow $1 security_t:file { read write };
allow $1 security_t:security { check_context };
')

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
