Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9I95dWt013348
	for <selinux@tycho.nsa.gov>; Sat, 18 Oct 2003 05:05:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9I95cmR019085
	for <selinux@tycho.nsa.gov>; Sat, 18 Oct 2003 09:05:38 GMT
Received: from extern.mail.waldi.eu.org (nat.moeglingen.waldi.eu.org [82.139.201.30] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id h9I95bjp019082 for <selinux@tycho.nsa.gov>; Sat, 18 Oct 2003 09:05:38 GMT
Date: Sat, 18 Oct 2003 11:05:24 +0200
From: Bastian Blank <bastian+selinux=tycho.nsa.gov@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: checkpolicy patch
Message-ID: <20031018090524.GA17313@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi folks

this patch fixes the following issues in checkpolicy (files: symtab.c,
policydb.{c,h}:
- size_t vs. int, unsigned int, __u32
- use struct policy_file instead of opaque void pointer
- mark some attributes as unused

it applies and builds cleanly with current sf cvs version

bastian

-- 
The heart is not a logical organ.
		-- Dr. Janet Wallace, "The Deadly Years", stardate 3479.4

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
