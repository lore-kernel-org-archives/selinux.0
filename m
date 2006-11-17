Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHMhMUJ013868
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 17:43:22 -0500
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAHMgdKG025829
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 22:42:39 GMT
Message-Id: <20061117224334.423545000@hp.com>
References: <20061117223842.399078000@hp.com>
Date: Fri, 17 Nov 2006 17:38:48 -0500
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 06/13] NetLabel: add tag verification when adding new CIPSOv4 DOI definitions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

Currently the CIPSOv4 engine does not do any sort of checking when a new DOI
definition is added.  The tags are still verified but only as a side effect of
normal NetLabel operation (packet processing, socket labeling, etc.) which
would cause application errors due to the faulty configuration.  This patch
adds tag checking when new DOI definition are added allowing us to catch these
configuration problems when they happen.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 net/ipv4/cipso_ipv4.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

Index: net-2.6.20_netlabel-base-work/net/ipv4/cipso_ipv4.c
===================================================================
--- net-2.6.20_netlabel-base-work.orig/net/ipv4/cipso_ipv4.c
+++ net-2.6.20_netlabel-base-work/net/ipv4/cipso_ipv4.c
@@ -448,8 +448,22 @@ static struct cipso_v4_doi *cipso_v4_doi
  */
 int cipso_v4_doi_add(struct cipso_v4_doi *doi_def)
 {
+	u32 iter;
+
 	if (doi_def == NULL || doi_def->doi == CIPSO_V4_DOI_UNKNOWN)
 		return -EINVAL;
+	for (iter = 0; iter < CIPSO_V4_TAG_MAXCNT; iter++) {
+		switch (doi_def->tags[iter]) {
+		case CIPSO_V4_TAG_RBITMAP:
+			break;
+		case CIPSO_V4_TAG_INVALID:
+			if (iter == 0)
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
 
 	doi_def->valid = 1;
 	INIT_RCU_HEAD(&doi_def->rcu);

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
