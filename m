Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1P1eg4a032550
	for <selinux@tycho.nsa.gov>; Fri, 24 Feb 2012 20:40:42 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q1P1eAAl013362
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <selinux@tycho.nsa.gov>; Fri, 24 Feb 2012 17:40:10 -0800 (PST)
From: Harry Ciao <qingtao.cao@windriver.com>
To: <selinux@tycho.nsa.gov>
Subject: [v1 PATCH 1/1] role_fix_callback skips out-of-scope roles during expansion.
Date: Sat, 25 Feb 2012 09:40:08 +0800
Message-ID: <1330134008-3259-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If a role identifier is out of scope it would be skipped over during
expansion, accordingly, be it a role attribute, it should be skipped
over as well when role_fix_callback tries to propagate its capability
to all its sub-roles.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/expand.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 493e478..befb720 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -688,6 +688,11 @@ static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
 		return 0;
 	}
 
+	if (!is_id_enabled(id, state->base, SYM_ROLES)) {
+		/* identifier's scope is not enabled */
+		return 0;
+	}
+
 	if (role->flavor != ROLE_ATTRIB)
 		return 0;
 
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
