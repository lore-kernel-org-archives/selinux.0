Return-Path: <SRS0=m98w=3S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ECCC2D0DB
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 16:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017F8207FD
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 16:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="XzmXgntC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgA2Qmd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:42:33 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:40705 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgA2Qmd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jan 2020 11:42:33 -0500
X-EEMSG-check-017: 50759359|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="50759359"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Jan 2020 16:42:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580316136; x=1611852136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=12NqyfOhC9fJk0YWY7fI7H/XGFiSyXIuUdaJyvAaUZ0=;
  b=XzmXgntCYYr/kJxpzW+psKJD3pk4E49rz5yBV0+Z/lDuT/k7KGfZllBQ
   N6krwQel1eW/7k90wsXFhJPjHxtucAP1Xsy51KxN1zcRfAoVjHmP8cEwb
   wbGhtOqrSW+5QnBofIxALRNaWFN2YvuCrX4ewwtPd3MxTMT9Iqe5uFwo/
   rRkI9T/kNxSTqeYu/86j/xrfG75nyRLaz7OUiKrDHqX+xQoaRx7Vkt33I
   NkJaVcJQKlWXmvRrwE8G8is1J5vtLbUBREDrpkCnelUW+BjWSMXcMGeG7
   SUlQb16F/tpIAuz+EcqdmePaEAPkTueJZ0ak1fPoQo8GchYHogJfEbGWZ
   A==;
X-IronPort-AV: E=Sophos;i="5.70,378,1574121600"; 
   d="scan'208";a="38412305"
IronPort-PHdr: =?us-ascii?q?9a23=3AhAWP/xHeQRoAnJrbP746gp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yo8ywAkXT6L1XgUPTWs2DsrQY0raQ6P6rCTxIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrw/xx?=
 =?us-ascii?q?bIrXdFeOdbzn5sKV6Pghrw/Mi98INt/ihKp/4t68tMWrjmcqolSrBVEC4oOH?=
 =?us-ascii?q?0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi?=
 =?us-ascii?q?+i4LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHS2?=
 =?us-ascii?q?VBRMJRXDFfDI26YYUEEu4NMf9WooT5olcDqwa1CwuxC+P10jJGhmH407A03e?=
 =?us-ascii?q?oiFg/J0wMuEskSvHnXttj5KL0fXfypwKTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqHpxQtySAOIt3RMMvW25ouCcmyr0GpJ?=
 =?us-ascii?q?60ZzIGx4ggxx7abfGMbouG4gr7WeqMLjp1i2hpdbKiixqo70StxfPwWtOp3F?=
 =?us-ascii?q?tMsyFLiMPDtmoX2BzW8sWHT/x98Vq/1juXzADT7/1EIVgzlarGN54t2r4wmY?=
 =?us-ascii?q?QXsUTEBiL2hF/5jLWXdkU54eik8eXnYrPopp+bLI97lB3xPr4yms2/Hes4Mg?=
 =?us-ascii?q?8OU3Kd+eugz73s4Vf1QLBLjv0yiqXZsZbaKtoHpqOhHgNY3Yku5wy/Aju7yt?=
 =?us-ascii?q?gUg3YKIExfdB6al4TpPkvBIPH8DfexmVSslzJryujdPrL8GZXANWTDkbf9cr?=
 =?us-ascii?q?Z97E5Q0gwzzctF6J5OBbEBJ+zzVlfrtNPEFh85LxC0w+H/BdV604MeXnmPAq?=
 =?us-ascii?q?mDP6zOr1CF/fgvLPeRa48Vojn9N+Ip6OLpjX88gVUdZ7Wm3YMLaHCkGfRrO1?=
 =?us-ascii?q?6ZbmTogtcAF2cKowU/Qff0iF2NTzFTfWy+X6Ei6TEhDoKpE4PDSpqqgLyb0y?=
 =?us-ascii?q?exBodWaXxeClCQDXfocJ2JW+8WZyKPJs9siSQEWqK8S48lzB2usQj6y719Lu?=
 =?us-ascii?q?XK4CEXqZXj1N0mr9HUwAk76DhcF82A1ySISGZukyUDQDpl8rp4pBlG1lqb0a?=
 =?us-ascii?q?V+y8ddHNhX6uIBBhw2LrbA3ud6DJb0QQuHcdCXHgX1Cu66CC08G4pii+QFZF?=
 =?us-ascii?q?xwTpD53x0=3D?=
X-IPAS-Result: =?us-ascii?q?A2B3AACTtDFe/wHyM5BmHQEBAQkBEQUFAYFpBgELAYF3B?=
 =?us-ascii?q?YEYVAEgEiqNF4ZaBosmj06BewkBAQEBAQEBAQEbEAwBAYRAglA2Bw4CEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshTcMgjspgygLAUaBUYJnPwGCViUPrj4zhUqDKIE4BoE4A?=
 =?us-ascii?q?YdBhHh5gQeBETaDG4JkAodRBI1YBIh3gSeXXoJDgkyEdo5pDBuCSJg3kCqHG?=
 =?us-ascii?q?pQqBC6BWCsIAhgIIQ87gmxQGA2OKReDUIpxIwMwjAYtgTVfAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 29 Jan 2020 16:42:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00TGfTOa143605;
        Wed, 29 Jan 2020 11:41:29 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] selinux: remove unused initial SIDs and improve handling
Date:   Wed, 29 Jan 2020 11:42:56 -0500
Message-Id: <20200129164256.3190-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove initial SIDs that have never been used or are no longer
used by the kernel from its string table, which is also used
to generate the SECINITSID_* symbols referenced in code.
Update the code to gracefully handle the fact that these can
now be NULL. Stop treating it as an error if a policy defines
additional initial SIDs unknown to the kernel.  Do not
load unused initial SID contexts into the sidtab.
Fix the incorrect usage of the name from the ocontext in error
messages when loading initial SIDs since these are not presently
written to the kernel policy and are therefore always NULL.

This is a first step toward enabling future evolution of
initial SIDs. Further changes are required to both userspace
and the kernel to fully address
https://github.com/SELinuxProject/selinux-kernel/issues/12
but this takes a small step toward that end.

Fully decoupling the policy and kernel initial SID values will
require introducing a mapping between them and dyhamically
mapping them at load time.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v2 avoids loading all unused initial SID contexts into the sidtab,
not just ones beyond SECINITSID_NUM.  It also drops the unnecessary
check for an undefined context because all contexts in the OCON_ISID
list were already validated at load time via context_read_and_validate().

 scripts/selinux/genheaders/genheaders.c       | 11 +++-
 .../selinux/include/initial_sid_to_string.h   | 57 +++++++++----------
 security/selinux/selinuxfs.c                  |  6 +-
 security/selinux/ss/policydb.c                | 25 ++++----
 security/selinux/ss/services.c                | 26 ++++-----
 5 files changed, 66 insertions(+), 59 deletions(-)

diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
index 544ca126a8a8..f355b3e0e968 100644
--- a/scripts/selinux/genheaders/genheaders.c
+++ b/scripts/selinux/genheaders/genheaders.c
@@ -67,8 +67,12 @@ int main(int argc, char *argv[])
 	}
 
 	isids_len = sizeof(initial_sid_to_string) / sizeof (char *);
-	for (i = 1; i < isids_len; i++)
-		initial_sid_to_string[i] = stoupperx(initial_sid_to_string[i]);
+	for (i = 1; i < isids_len; i++) {
+		const char *s = initial_sid_to_string[i];
+
+		if (s)
+			initial_sid_to_string[i] = stoupperx(s);
+	}
 
 	fprintf(fout, "/* This file is automatically generated.  Do not edit. */\n");
 	fprintf(fout, "#ifndef _SELINUX_FLASK_H_\n#define _SELINUX_FLASK_H_\n\n");
@@ -82,7 +86,8 @@ int main(int argc, char *argv[])
 
 	for (i = 1; i < isids_len; i++) {
 		const char *s = initial_sid_to_string[i];
-		fprintf(fout, "#define SECINITSID_%-39s %2d\n", s, i);
+		if (s)
+			fprintf(fout, "#define SECINITSID_%-39s %2d\n", s, i);
 	}
 	fprintf(fout, "\n#define SECINITSID_NUM %d\n", i-1);
 	fprintf(fout, "\nstatic inline bool security_is_socket_class(u16 kern_tclass)\n");
diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
index 4f93f697f71c..5d332aeb8b6c 100644
--- a/security/selinux/include/initial_sid_to_string.h
+++ b/security/selinux/include/initial_sid_to_string.h
@@ -1,34 +1,33 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* This file is automatically generated.  Do not edit. */
 static const char *initial_sid_to_string[] =
 {
-    "null",
-    "kernel",
-    "security",
-    "unlabeled",
-    "fs",
-    "file",
-    "file_labels",
-    "init",
-    "any_socket",
-    "port",
-    "netif",
-    "netmsg",
-    "node",
-    "igmp_packet",
-    "icmp_socket",
-    "tcp_socket",
-    "sysctl_modprobe",
-    "sysctl",
-    "sysctl_fs",
-    "sysctl_kernel",
-    "sysctl_net",
-    "sysctl_net_unix",
-    "sysctl_vm",
-    "sysctl_dev",
-    "kmod",
-    "policy",
-    "scmp_packet",
-    "devnull",
+	NULL,
+	"kernel",
+	"security",
+	"unlabeled",
+	NULL,
+	"file",
+	NULL,
+	NULL,
+	"any_socket",
+	"port",
+	"netif",
+	"netmsg",
+	"node",
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	"devnull",
 };
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 79c710911a3c..daddc880ebfc 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1692,7 +1692,11 @@ static int sel_make_initcon_files(struct dentry *dir)
 	for (i = 1; i <= SECINITSID_NUM; i++) {
 		struct inode *inode;
 		struct dentry *dentry;
-		dentry = d_alloc_name(dir, security_get_initial_sid_context(i));
+		const char *s = security_get_initial_sid_context(i);
+
+		if (!s)
+			continue;
+		dentry = d_alloc_name(dir, s);
 		if (!dentry)
 			return -ENOMEM;
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 2aa7f2e1a8e7..768a9d4e0b86 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -865,29 +865,28 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 
 	head = p->ocontexts[OCON_ISID];
 	for (c = head; c; c = c->next) {
-		rc = -EINVAL;
-		if (!c->context[0].user) {
-			pr_err("SELinux:  SID %s was never defined.\n",
-				c->u.name);
-			sidtab_destroy(s);
-			goto out;
-		}
-		if (c->sid[0] == SECSID_NULL || c->sid[0] > SECINITSID_NUM) {
-			pr_err("SELinux:  Initial SID %s out of range.\n",
-				c->u.name);
+		u32 sid = c->sid[0];
+		const char *name = security_get_initial_sid_context(sid);
+
+		if (sid == SECSID_NULL) {
+			pr_err("SELinux:  SID null was assigned a context.\n");
 			sidtab_destroy(s);
 			goto out;
 		}
+
+		/* Ignore initial SIDs unused by this kernel. */
+		if (!name)
+			continue;
+
 		rc = context_add_hash(p, &c->context[0]);
 		if (rc) {
 			sidtab_destroy(s);
 			goto out;
 		}
-
-		rc = sidtab_set_initial(s, c->sid[0], &c->context[0]);
+		rc = sidtab_set_initial(s, sid, &c->context[0]);
 		if (rc) {
 			pr_err("SELinux:  unable to load initial SID %s.\n",
-				c->u.name);
+			       name);
 			sidtab_destroy(s);
 			goto out;
 		}
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 216ce602a2b5..bd924a9a6388 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1323,23 +1323,22 @@ static int security_sid_to_context_core(struct selinux_state *state,
 	if (!selinux_initialized(state)) {
 		if (sid <= SECINITSID_NUM) {
 			char *scontextp;
+			const char *s = initial_sid_to_string[sid];
 
-			*scontext_len = strlen(initial_sid_to_string[sid]) + 1;
+			if (!s)
+				return -EINVAL;
+			*scontext_len = strlen(s) + 1;
 			if (!scontext)
-				goto out;
-			scontextp = kmemdup(initial_sid_to_string[sid],
-					    *scontext_len, GFP_ATOMIC);
-			if (!scontextp) {
-				rc = -ENOMEM;
-				goto out;
-			}
+				return 0;
+			scontextp = kmemdup(s, *scontext_len, GFP_ATOMIC);
+			if (!scontextp)
+				return -ENOMEM;
 			*scontext = scontextp;
-			goto out;
+			return 0;
 		}
 		pr_err("SELinux: %s:  called before initial "
 		       "load_policy on unknown SID %d\n", __func__, sid);
-		rc = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 	read_lock(&state->ss->policy_rwlock);
 	policydb = &state->ss->policydb;
@@ -1363,7 +1362,6 @@ static int security_sid_to_context_core(struct selinux_state *state,
 
 out_unlock:
 	read_unlock(&state->ss->policy_rwlock);
-out:
 	return rc;
 
 }
@@ -1553,7 +1551,9 @@ static int security_context_to_sid_core(struct selinux_state *state,
 		int i;
 
 		for (i = 1; i < SECINITSID_NUM; i++) {
-			if (!strcmp(initial_sid_to_string[i], scontext2)) {
+			const char *s = initial_sid_to_string[i];
+
+			if (s && !strcmp(s, scontext2)) {
 				*sid = i;
 				goto out;
 			}
-- 
2.24.1

