Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7SEmWLa019421
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 10:48:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7SEmUet023113
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 14:48:30 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h7SEmUlq023110 for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 14:48:30 GMT
Date: Thu, 28 Aug 2003 15:48:25 +0100
From: Dale Amon <amon@vnl.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: Package install probs
Message-ID: <20030828144825.GA6898@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Colin, at the end of the install of the default policy
I'm getting this error message:

 an error on line 39260 "Unknown type klogd_t at token ';'"
"neverallow ~klogd_t proc_kmsg_t:file ~{ getattr }"
while parsing /usr/bin/checkpolicy configuration make
/etc/security/selinux/policy.15 error 1

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
