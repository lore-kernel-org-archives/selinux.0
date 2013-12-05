Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB594ZnT019282
	for <selinux@tycho.nsa.gov>; Thu, 5 Dec 2013 04:04:35 -0500
Received: from corbina.ru (violin.corbina.net [195.14.50.30])
	by contrabass.corbina.net (Postfix) with ESMTP id 5A035CA837
	for <selinux@tycho.nsa.gov>; Thu,  5 Dec 2013 13:04:32 +0400 (MSK)
Received: from [10.188.23.10] (HELO localhost.localdomain)
  by fe1-mc.corbina.ru (CommuniGate Pro SMTP 5.4.10)
  with ESMTP id 330642702 for selinux@tycho.nsa.gov; Thu, 05 Dec 2013 13:04:32 +0400
Date: Thu, 5 Dec 2013 13:04:31 +0400
From: Pavel Roschin <roshin@scriptumplus.ru>
To: selinux@tycho.nsa.gov
Subject: avtab dense hash table
Message-ID: <20131205130431.7fe3c727.roshin@scriptumplus.ru>
Reply-To: Pavel Roschin <roshin@scriptumplus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, I have some questions about hash tables in SELinux. As I see, all AV
rules are stored inside hash tables: I found them in kernel source and in
libsepol source. All types, domains, classes and so on also stored inside hash
tables.

Regarding source code of libsepol I see that all hash tables are fixed-size:
maximum avtab size is 2^13 - 8192 buckets. But in RHEL seinfo shows that there
are 250000+ allow rules and 170000+ dontaudit rules. Shouldn't that be a huge
performance kick?

In Linux kernel, avtab has size 2^11 - 2048 buckets for 256000+ av rules. Huge
hash table will be transformed into lists and linear search that should be slow
as hell, shouldn't?

>From kernel source:

#define MAX_AVTAB_HASH_BITS 11
#define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
#define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS-1)

What is the reason of such dense hash maps?

--
Best regards,
Pavel Roschin


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
