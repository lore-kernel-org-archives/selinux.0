Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24688C46460
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26D42794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oSUjUGUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfFBQyp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:54:45 -0400
Received: from sonic302-8.consmr.mail.bf2.yahoo.com ([74.6.135.47]:36694 "EHLO
        sonic302-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727113AbfFBQyp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494483; bh=5GP2CrxJNDp2BFUDQ+U49VHnhWLXKi0Sb6zMHU3zI00=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=oSUjUGUa9qc/285CNQC4qy6J7sGmdTyhX6ktJZjKn9eP5O4RJKex2acqkrYPKtJvAtIj3sJQaAJNoJC3map6xb0f1AsrpzI1KQa3i/XY4gQcyV7bk6GmkB0iW3PIdDkZRn5l8spBvn2ui/RE5bpW+kbJbqXoQvOlf+ymWg6M/kNOeNw4QOcM6PMdYVC1mkvLyghK9fA1ifJCxwHtW27TzoHv40ukh35j60XvPnTWdPs0Jv352/RXeKJBgOFsxAx2X6G5drOwejxMUxytnsCU7w0FlePT6BFGSLE26gNZ9q6jQdTRGme9JpG5ol702WvZVfJ+5nvI0mQGj9GMjDxSVw==
X-YMail-OSG: qaLcqz8VM1kQ3jaJJbkDj2ADw.VVFRtHkcR9qlzWgrgpLo6gd.sCf.Z7Y9tl7hY
 _8Mo0h.MUBYYTQj3vGxyObONz.0HpsAkjUmKZApj2Zo8y.vH_7jgHQe3TQHibJumKmpmyblqbOGp
 thh7so5RZLh1L7X2Fx1M3_x4FeOG7dPTjkq_F4RwkFptrmsEtdTyoUU8nem6B09f0YQmYg5jpLBg
 4f0WJv8F1vppS3V8ty8HmxDdfAbjh8dr4Bb_eS8ivkaOGq6BRrl9MVvcbIfOCzjUOGxFY.sLDaEh
 4_Fgm_3JdQF.I3FADsv1sVAEGPR3aGfIrY64CHDuT_x_Xa.qu4RQu9QtmLZ8onawDIqzuUh9h79s
 W3KN8pmpB0LFU.5RjxonavCyjGwC828vPx.r7YwUOheLKVitkKkKjdLE2Vri1XUDXtxQ6ASLge20
 RIoLC3RNWpphvolT36DBGYyyO0WuBm.qb5ww5zx9hZR0.ae6lUy2xat1ezydbLEf0yasSbbfW3BN
 IEqUXcU_DCcda7dnkrB3E7_A7BMl4vAIYVt3_8cNzGY9sahqnGzcInFWs7SZ88ZK6wyDBV7X0EOI
 BYuTzUhVvPD3o4f6zmj_Q_atxmC8g3SLOgTFrgE4KD0aUhdifB.Z9DIdw8RZ8O8YptH34AZX_jjn
 fXkqIvq__HLAXcSOegwP7zWBVLF3dngEFoJQUbZMU7lg4tpMSu5HQg6kLDigLTWvo7kL2VM_DsjS
 KBJda_VgTPCnfGdAtNs_1OC9SJdPRzIjvuY_U6vaWD1XOBkkHv8_wObUJPaNvisGHj7.fa2F.FUh
 r6RHbXI8AWBygQ.HJnNTS58CAiw5jW4ITSGQnAcG0UQpB7jYKxuah1XNSJ9eATUvvCCztvnJEh78
 .vC_vPeUgjr5V7Q0HPvofvnDLUN84xkkhpvGKu3D_LZovMZWqfGAvX6Y4v6o.YhIB1b1dY.opIlZ
 bBDJ.Q74K4fOs1CrDRHAS7a1oD3fNLb6PBAXggs80kETZHB.kmHNMgx4Dlp6t.5HSuBeRzUyiQkL
 bPaRv5c_Bb6UyRywcSCVRLIjkCVowNU2daY8jpy.8hsfauQdf_k2qcMLXUe1NK3SlcJ.A0o7Dlqt
 nsalNdmg4s9_MCSYNjyKND5wr_6Ppi9VCIYKuwP2gBJ2qqmmpyKU6t8N1NKBk.2ipQA0ubqU7ZYG
 Lz2pUKrsT2BbZHMX5dYEDrxS7ERbUV2AmYFI2uR8Y7Sx2BPTEBhNFyLbsepTLVJ3fHM9FWBAHXf.
 3q7TBMpNmDVa84Qn3drcO_Wi1feMa3nsj2.z.PsYuk2ijEKO.NrL9AY.b2Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:54:43 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4f202846722f9a871dab498da8fe7ef4;
          Sun, 02 Jun 2019 16:54:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 57/58] LSM: Specify which LSM to display
Date:   Sun,  2 Jun 2019 09:51:00 -0700
Message-Id: <20190602165101.25079-58-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a new entry "display" in /proc/.../attr for controlling
which LSM security information is displayed for a process.
The name of an active LSM that supplies hooks for human readable
data may be written to "display" to set the value. The name of
the LSM currently in use can be read from "display".

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/proc/base.c      |   1 +
 security/security.c | 110 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ddef482f1334..7bf70e041315 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2618,6 +2618,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "fscreate",		0666),
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
+	ATTR(NULL, "display",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/security/security.c b/security/security.c
index b05265ec24f0..4af99077572d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -46,7 +46,9 @@ static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
+	.lbs_task = sizeof(struct lsm_one_hooks),
+};
 
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
@@ -577,6 +579,7 @@ static int lsm_task_alloc(struct task_struct *task)
 	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
 	if (task->security == NULL)
 		return -ENOMEM;
+
 	return 0;
 }
 
@@ -736,7 +739,10 @@ int lsm_superblock_alloc(struct super_block *sb)
 
 #define call_one_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
-	if (lsm_base_one.FUNC.FUNC)				\
+	struct lsm_one_hooks *LOH = current->security;		\
+	if (LOH->FUNC.FUNC)					\
+		RC = LOH->FUNC.FUNC(__VA_ARGS__);		\
+	else if (LOH->lsm == NULL && lsm_base_one.FUNC.FUNC)	\
 		RC = lsm_base_one.FUNC.FUNC(__VA_ARGS__);	\
 	RC;							\
 })
@@ -1569,13 +1575,22 @@ int security_file_open(struct file *file)
 
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
+	struct lsm_one_hooks *odisplay = current->security;
+	struct lsm_one_hooks *ndisplay;
 	int rc = lsm_task_alloc(task);
 
 	if (rc)
 		return rc;
+
 	rc = call_int_hook(task_alloc, 0, task, clone_flags);
 	if (unlikely(rc))
 		security_task_free(task);
+	else if (odisplay) {
+		ndisplay = task->security;
+		if (ndisplay)
+			*ndisplay = *odisplay;
+	}
+
 	return rc;
 }
 
@@ -1945,10 +1960,28 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	struct lsm_one_hooks *loh = current->security;
+	char *s;
+
+	if (!strcmp(name, "display")) {
+		if (loh->lsm)
+			s = loh->lsm;
+		else if (lsm_base_one.lsm)
+			s = lsm_base_one.lsm;
+		else
+			return -EINVAL;
+
+		*value = kstrdup(s, GFP_KERNEL);
+		if (*value)
+			return strlen(s);
+		return -ENOMEM;
+	}
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsm))
 			continue;
+		if (lsm == NULL && loh->lsm && strcmp(loh->lsm, hp->lsm))
+			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
 	return -EINVAL;
@@ -1958,10 +1991,83 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
 	struct security_hook_list *hp;
+	struct lsm_one_hooks *loh = current->security;
+	bool found = false;
+	char *s;
+
+	/*
+	 * End the passed name at a newline.
+	 */
+	s = strnchr(value, size, '\n');
+	if (s)
+		*s = '\0';
+
+	if (!strcmp(name, "display")) {
+		union security_list_options secid_to_secctx;
+		union security_list_options secctx_to_secid;
+		union security_list_options socket_getpeersec_stream;
+
+		if (size == 0 || size >= 100)
+			return -EINVAL;
+
+		secid_to_secctx.secid_to_secctx = NULL;
+		hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,
+				     list) {
+			if (size >= strlen(hp->lsm) &&
+			    !strncmp(value, hp->lsm, size)) {
+				secid_to_secctx = hp->hook;
+				found = true;
+				break;
+			}
+		}
+		secctx_to_secid.secctx_to_secid = NULL;
+		hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid,
+				     list) {
+			if (size >= strlen(hp->lsm) &&
+			    !strncmp(value, hp->lsm, size)) {
+				secctx_to_secid = hp->hook;
+				found = true;
+				break;
+			}
+		}
+		socket_getpeersec_stream.socket_getpeersec_stream = NULL;
+		hlist_for_each_entry(hp,
+				&security_hook_heads.socket_getpeersec_stream,
+				     list) {
+			if (size >= strlen(hp->lsm) &&
+			    !strncmp(value, hp->lsm, size)) {
+				socket_getpeersec_stream = hp->hook;
+				found = true;
+				break;
+			}
+		}
+		if (!found)
+			return -EINVAL;
+
+		/*
+		 * The named lsm is active and supplies one or more
+		 * of the relevant hooks. Switch to it.
+		 */
+		s = kmemdup(value, size + 1, GFP_KERNEL);
+		if (s == NULL)
+			return -ENOMEM;
+		s[size] = '\0';
+
+		if (loh->lsm)
+			kfree(loh->lsm);
+		loh->lsm = s;
+		loh->secid_to_secctx = secid_to_secctx;
+		loh->secctx_to_secid = secctx_to_secid;
+		loh->socket_getpeersec_stream = socket_getpeersec_stream;
+
+		return size;
+	}
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsm))
 			continue;
+		if (lsm == NULL && loh->lsm && strcmp(loh->lsm, hp->lsm))
+			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
 	return -EINVAL;
-- 
2.19.1

