Return-Path: <SRS0=i/ur=NR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D565C32789
	for <selinux@archiver.kernel.org>; Tue,  6 Nov 2018 19:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ABD20827
	for <selinux@archiver.kernel.org>; Tue,  6 Nov 2018 19:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41ABD20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388240AbeKGEos (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:44:48 -0500
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:7515 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388320AbeKGEos (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Nov 2018 23:44:48 -0500
X-EEMSG-check-008: 610624588|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,472,1534809600"; 
   d="scan'208";a="610624588"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Nov 2018 19:18:03 +0000
X-IronPort-AV: E=Sophos;i="5.54,472,1534809600"; 
   d="scan'208";a="20344244"
IronPort-PHdr: =?us-ascii?q?9a23=3AGQ1b8xDBc2pDsmaBtiD8UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPv8osbcNUDSrc9gkEXOFd2Cra4c1KyO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhjexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs7Vy?=
 =?us-ascii?q?6i76N2QxH2jikJOSMy/GXOhsBtkK5XpRSsrAF9zYHJeoGYLPpwcL3Ac90URm?=
 =?us-ascii?q?RPWcleWSNaD4+gbIYCFfYNMPxEo4XhoVYFsBuwBROrBOPq0jJGm2P20rMi0+?=
 =?us-ascii?q?QhDw7G2hErEc8LsHvOqNX1MLkdUOCox6TP1jXMcuhW1Czh6InIbh8hofaMUa?=
 =?us-ascii?q?h2ccrK00YjDQzFjlKOqYH8OT6ey+oDs2+e7+V6VOKvjXYqqw5wojizxscsl5?=
 =?us-ascii?q?LGipgJxVDD8CV0xps+K96gSENjfNKpH5RduzuaOodrWM8uXW5ltDggxrEbv5?=
 =?us-ascii?q?OwYTIEx449xxHFbvyKa42I4hX+W+mPOTp4n3dleK6nhxa17Eig1vXwVsmq31?=
 =?us-ascii?q?ZOqSpIisXMuWoX1xzS98iHUeFx/luh2DmT1wDT7ftIIUYomqrAN5Et2Lswlp?=
 =?us-ascii?q?sXsUjbHy/2nlv5jLOOe0k59eWl5P7rb7X7qpOGKYN5hR/yPr4zlsCnBOQ3KA?=
 =?us-ascii?q?kOX2yV+eSm073j+FX0QK5Xgf0tiaTZrJDbKtgbpq6+GQNV1J0j5AylAzep19?=
 =?us-ascii?q?QYg2ELLEhZdxKfk4jpJ1bOLejjDfihh1SskTFrx+3JP7D6HJXNIWbMkK37cb?=
 =?us-ascii?q?Z+9UFc0gwzws5b555ODbEBOv3zCQfNs4nDAxs4NRGk6/joBc871Y4EX2+LRK?=
 =?us-ascii?q?iDP/D8q1iNs9kzLvGMaYldgzP0L/wo9ra6lnMisUMMdqmum50MYTa3GeowcB?=
 =?us-ascii?q?bRWmblntpUSTRChQE5VuG/zQTaXA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2B6AACv5+Fb/wHyM5BkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VopZk8zJ4wOjBhMAQEBAQEBBopGjh+BeiAQCAGDekaDWiI0DQ0BAwEBAQEBA?=
 =?us-ascii?q?QIBbBwMgjYkgw4LAUaBUYJiPwGBdA0PqiIzhC0BgQ6EZQWHUIQoF3mBB4ERh?=
 =?us-ascii?q?GaBRwKBKoEEhQ4CiQeGZ49JCYZvihgLGJBjAY0MjAI4gVUrCAIYCCEPgyeCJ?=
 =?us-ascii?q?xeDSopwIQMwgQUBAYofgk0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Nov 2018 19:18:03 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wA6JI3AB004116;
        Tue, 6 Nov 2018 14:18:03 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsemanage: set selinux policy root to match semanage root or storename
Date:   Tue,  6 Nov 2018 14:20:21 -0500
Message-Id: <20181106192021.17556-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As reported in #109, semodule -p /path/to/policyroot -s minimum -n -B
tries to use /etc/selinux/targeted/booleans.subs_dist.  This is because
it invokes the libselinux selinux_boolean_sub() interface, which uses
the active/installed policy files rather than the libsemanage ones.

To fix, we need to set the selinux policy root when either the semanage
root or the semanage storename is set.  When setting the semanage root,
we need to prepend the semanage root to the selinux policy root.  When
setting the semanage storename, we need to replace the last component
of the selinux policy root with the new storename.

Test:
strace semodule -p ~/policy-root -s minimum -n -B

Before:
openat(AT_FDCWD, "/etc/selinux/targeted/booleans.subs_dist", O_RDONLY|O_CLOEXEC) = 5

After:
openat(AT_FDCWD, "/home/sds/policy-root/etc/selinux/minimum/booleans.subs_dist", O_RDONLY|O_CLOEXEC) = 5

Fixes https://github.com/SELinuxProject/selinux/issues/109

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsemanage/src/handle.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index a6567bd4..c163e553 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -43,8 +43,21 @@ static char *private_semanage_root = NULL;
 
 int semanage_set_root(const char *root)
 {
+	char *new_selinux_root = NULL;
+
+	asprintf(&new_selinux_root, "%s%s", root, selinux_policy_root());
+	if (!new_selinux_root)
+		return -1;
+	if (selinux_set_policy_root(new_selinux_root) < 0) {
+		free(new_selinux_root);
+		return -1;
+	}
+	free(new_selinux_root);
+
 	free(private_semanage_root);
 	private_semanage_root = strdup(root);
+	if (!private_semanage_root)
+		return -1;
 	return 0;
 }
 
@@ -273,9 +286,23 @@ int semanage_is_connected(semanage_handle_t * sh)
 void semanage_select_store(semanage_handle_t * sh, char *storename,
 			   enum semanage_connect_type storetype)
 {
-
 	assert(sh != NULL);
 
+	char *root = strdup(selinux_policy_root());
+	assert(root);
+	char *end = strrchr(root, '/');
+	assert(end);
+	end++;
+	*end = '\0';
+
+	char *newroot = NULL;
+	asprintf(&newroot, "%s%s", root, storename);
+	assert(newroot);
+	free(root);
+	int rc = selinux_set_policy_root(newroot);
+	assert(rc == 0);
+	free(newroot);
+
 	/* This just sets the storename to what the user requests, no 
 	   verification of existance will be done until connect */
 	free(sh->conf->store_path);
-- 
2.19.1

