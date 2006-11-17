Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHMhQn0013955
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 17:43:26 -0500
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAHMfiUg029642
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 22:41:45 GMT
Message-Id: <20061117224336.711076000@hp.com>
References: <20061117223842.399078000@hp.com>
Date: Fri, 17 Nov 2006 17:38:52 -0500
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org
Subject: [PATCH 10/13] NetLabel: use cipso_v4_doi_search() for local CIPSOv4 functions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

The cipso_v4_doi_search() function behaves the same as cipso_v4_doi_getdef()
but is a local, static function so use it whenever possibile in the CIPSOv4
code base.

Signed-of-by: Paul Moore <paul.moore@hp.com>
---
 net/ipv4/cipso_ipv4.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: net-2.6.20_netlabel-base-work/net/ipv4/cipso_ipv4.c
===================================================================
--- net-2.6.20_netlabel-base-work.orig/net/ipv4/cipso_ipv4.c
+++ net-2.6.20_netlabel-base-work/net/ipv4/cipso_ipv4.c
@@ -1136,7 +1136,7 @@ int cipso_v4_validate(unsigned char **op
 	}
 
 	rcu_read_lock();
-	doi_def = cipso_v4_doi_getdef(ntohl(*((__be32 *)&opt[2])));
+	doi_def = cipso_v4_doi_search(ntohl(*((u32 *)&opt[2])));
 	if (doi_def == NULL) {
 		err_offset = 2;
 		goto validate_return_locked;
@@ -1381,7 +1381,7 @@ int cipso_v4_sock_getattr(struct sock *s
 
 	doi = ntohl(*(__be32 *)&cipso_ptr[2]);
 	rcu_read_lock();
-	doi_def = cipso_v4_doi_getdef(doi);
+	doi_def = cipso_v4_doi_search(doi);
 	if (doi_def == NULL) {
 		rcu_read_unlock();
 		return -ENOMSG;
@@ -1449,7 +1449,7 @@ int cipso_v4_skbuff_getattr(const struct
 
 	doi = ntohl(*(__be32 *)&cipso_ptr[2]);
 	rcu_read_lock();
-	doi_def = cipso_v4_doi_getdef(doi);
+	doi_def = cipso_v4_doi_search(doi);
 	if (doi_def == NULL)
 		goto skbuff_getattr_return;
 

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
