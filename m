Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v37LdtiE021906
 for <selinux@tycho.nsa.gov>; Fri, 7 Apr 2017 17:40:00 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 50C8D564678
 for <selinux@tycho.nsa.gov>; Fri,  7 Apr 2017 22:44:59 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/6] libsepol: refuse to load policies with no block
Date: Fri,  7 Apr 2017 22:44:30 +0200
Message-Id: <20170407204431.8572-5-nicolas.iooss@m4x.org>
In-Reply-To: <20170407204431.8572-1-nicolas.iooss@m4x.org>
References: <20170407204431.8572-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Some functions assumes that p->global is not NULL. For example
range_read() contains:

    p->global->enabled->range_tr_rules = rtr;

However p->global may currently be NULL when loading a policy module
with no avrule block. Avoid a NULL pointer dereference by making such a
policy invalid.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/policydb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 3cff6d276d68..7093b29833bf 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -4044,6 +4044,10 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 		if (avrule_block_read(p, &p->global, info->sym_num, fp) == -1) {
 			goto bad;
 		}
+		if (p->global == NULL) {
+			ERR(fp->handle, "no avrule block in policy");
+			goto bad;
+		}
 		for (i = 0; i < info->sym_num; i++) {
 			if ((rc = next_entry(buf, fp, sizeof(uint32_t))) < 0) {
 				goto bad;
-- 
2.12.0
