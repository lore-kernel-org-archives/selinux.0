Return-Path: <SRS0=VtUM=YX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B4DCA9EC5
	for <selinux@archiver.kernel.org>; Wed, 30 Oct 2019 13:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231E720663
	for <selinux@archiver.kernel.org>; Wed, 30 Oct 2019 13:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Pk3nPFY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfJ3NR4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Oct 2019 09:17:56 -0400
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:25885 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfJ3NR4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Oct 2019 09:17:56 -0400
X-EEMSG-check-017: 42786589|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,247,1569283200"; 
   d="scan'208";a="42786589"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Oct 2019 13:16:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572441411; x=1603977411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KY3nAYj4TYSJi2dkealMXckVq1FoqBOfUtK9UJ+W39Q=;
  b=Pk3nPFY1kEpx1TK29l0T/Xq5YugwlB4rvWommutcJL06/7Yng/8SNW8o
   aRQsHJVOepPB/a1gLgoju7zdHqsudUZm8VNPHCZWfld+RFR31A+/fARkn
   m5st3zQvSjFaRFijxvRkCLsCmLOnSA+6Qa+VP4S8vk3Kt4eY7xc4U6dX3
   iYquXnQsrgZKoaxMl1jsvVJpMhHeKcA51hlEDNvSAjd6QAk5icu58XoAm
   5bOA+2Oc8KddEc2H4DLZuE4QNyvxiQiYJ4wj41BRpfmW8fS8dqDO23ZKk
   rB2Wg8dUk42vNLISAIQY8qkgLbVXWZqQBZh30XOwiyLFH4v4D1bP+L3mo
   w==;
X-IronPort-AV: E=Sophos;i="5.68,247,1569283200"; 
   d="scan'208";a="34868487"
IronPort-PHdr: =?us-ascii?q?9a23=3AIzI2yxZBOncmrlH/EWAL6hP/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZr8y5bnLW6fgltlLVR4KTs6sC17ON9fm4Aidcvt6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txjdutUYjIdtJas8yA?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDE36mHXjtF7grxdrhyvuhdzx5fYbYGROfZ7eK7WYNEUSn?=
 =?us-ascii?q?dbXstJVyJPHJ6yYYUMAeQGMulWoJLwq0cNoBakGQWhHv/jxiNOi3Tr3aM6ye?=
 =?us-ascii?q?MhEQTe0QI9A9IBrmzUrNXrO6cUTOu70azIwi/Hb/NSxzj86JXDfxc6of6RRr?=
 =?us-ascii?q?J9atbRyEkzGAPFiVWcs4rlPyiP2egXvGib6PRgWPuphmU6qA9xuiCiytojh4?=
 =?us-ascii?q?TGnI4Yyk3I+T9nzIs6O9G0UlN3bNi5G5VKrS6aLZF5QsY6TmFtvyY116MJtI?=
 =?us-ascii?q?agfCgP1JQn3xnfa+Gbc4SQ4hLsSuKRITBgiXJ5Yr2/nRey8VW7yuHmSsm10E?=
 =?us-ascii?q?pFripCktXWsHACywfT5dSdRvt4/0eh3S6D1wHV6u5aPUA5jbfXJpEuz7Iqlp?=
 =?us-ascii?q?cfrF7PEjH5lUnolqOaa10o+u2y5OTmZrXmqIWcN4hxigzmKaQhh9e/DP8kMg?=
 =?us-ascii?q?kOQ2eb+eO82Kfl/U3iWrpGlPI2kq7HsJzCP8QUura5AxNJ0oYk8xu/Fy2p0M?=
 =?us-ascii?q?kcnXQcNFJKYg+Hj4zwN1HLJ/D4Cu2/jEq2nDh3wPDGO6XrAo/RIXjbjLfhYb?=
 =?us-ascii?q?F95lZHyAUtydBf5pRUCqwOIf/oRE/xu8LXDgUjPwy33ennEtN92Z0aWW6VBa?=
 =?us-ascii?q?+ZKqzS4he04bc0Lu2NYpIFkCjyJuJj5PP0i3I931gHcvqHx5wSPUukE+xmLk?=
 =?us-ascii?q?PRWn/lhtMMAC9epQYlZPD7g12FFzhIbjC9WLxqtWJzM56vEYqWHtPlu7eGxi?=
 =?us-ascii?q?ruW8AHaw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BuAADii7ld/wHyM5BkHQEBAQkBEQUFAYFpCAELAYFzL?=
 =?us-ascii?q?IFBMiqMS5JWjzaBewkBAQEBAQEBAQEbGQECAQGEQINoJDQJDgIMAQEBBAEBA?=
 =?us-ascii?q?QEBBQMBAWyFQ4I7KYMmAUaBUYJjP4JTJbURhU6DQoFIgTYBhzeEWRh4gQeBE?=
 =?us-ascii?q?YNQhRKFIQStboIugjOScgwbmV0Bqgg5gVgrCAIYCCEPgydQEBSDEhcVjiolA?=
 =?us-ascii?q?zCBBQEBjWUBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 30 Oct 2019 13:16:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9UDGoH9017311;
        Wed, 30 Oct 2019 09:16:50 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH] selinux: add SELinux hooks for lockdown integrity and confidentiality
Date:   Wed, 30 Oct 2019 09:16:33 -0400
Message-Id: <20191030131633.9356-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add SELinux access control hooks for lockdown integrity and
confidentiality. This effectively mimics the current implementation of
lockdown (caveat noted below). If lockdown is enabled alongside SELinux,
then the lockdown access control will take precedence over the SELinux
lockdown implementation.

Note that this SELinux implementation allows the integrity and
confidentiality reasons to be controlled independently from one another.
Thus, in an SELinux policy, one could allow integrity operations while
blocking confidentiality operations.

(original patch authored by an intern who wishes to remain anonymous;
I am signing off on his behalf)

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c            | 22 ++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 36e531b91df2..6722c6b4ae74 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -91,6 +91,7 @@
 #include <uapi/linux/mount.h>
 #include <linux/fsnotify.h>
 #include <linux/fanotify.h>
+#include <linux/security.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -6799,6 +6800,25 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 }
 #endif
 
+static int selinux_lockdown(enum lockdown_reason what)
+{
+	u32 sid = current_sid();
+
+	if (what <= LOCKDOWN_INTEGRITY_MAX)
+		return avc_has_perm(&selinux_state,
+				sid, sid,
+				SECCLASS_LOCKDOWN, LOCKDOWN__INTEGRITY, NULL);
+	else if (what <= LOCKDOWN_CONFIDENTIALITY_MAX)
+		return avc_has_perm(&selinux_state,
+				sid, sid,
+				SECCLASS_LOCKDOWN, LOCKDOWN__CONFIDENTIALITY,
+				NULL);
+
+	/* invalid reason */
+	pr_warn("SELinux: invalid lockdown reason\n");
+	return -EPERM;
+}
+
 struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct task_security_struct),
 	.lbs_file = sizeof(struct file_security_struct),
@@ -7042,6 +7062,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
 	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
 #endif
+
+	LSM_HOOK_INIT(locked_down, selinux_lockdown),
 };
 
 static __init int selinux_init(void)
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 32e9b03be3dd..594c32febcd8 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -244,6 +244,8 @@ struct security_class_mapping secclass_map[] = {
 	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },
 	{ "xdp_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
+	{ "lockdown",
+	  { "integrity", "confidentiality", NULL } },
 	{ NULL }
   };
 
-- 
2.23.0

