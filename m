Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA00967
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 10:32:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA03146
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 14:30:59 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id OAA03142 for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 14:30:57 GMT
Date: Tue, 8 Oct 2002 16:32:46 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: /proc woes
Message-ID: <20021008163245.A5508@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Forget my last posting. I noticed a few seconds after pressing send
that of course all that is no good because /proc is not a supported
filesystem.

So instead of having a patch, I have a question: My /proc is file_t:

dr-xr-xr-x  root     root     system_u:object_r:file_t         proc

Doing a chcon manually fails:

# chcon system_u:object_r:proc_t /proc
chcon: /proc: Permission denied


So, what went wrong and what can I do to fix it?


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
