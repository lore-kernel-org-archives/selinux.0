Return-Path: <SRS0=ZupP=PP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BD1C43387
	for <selinux@archiver.kernel.org>; Mon,  7 Jan 2019 16:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718CB2147C
	for <selinux@archiver.kernel.org>; Mon,  7 Jan 2019 16:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gggpcaPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfAGQ5U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:57:20 -0500
Received: from uphb19pa09.eemsg.mail.mil ([214.24.26.83]:61841 "EHLO
        USFB19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727002AbfAGQ5T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Jan 2019 11:57:19 -0500
X-EEMSG-check-017: 243198416|USFB19PA12_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Jan 2019 16:57:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1546880237; x=1578416237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zeAwHQYikpLAaMa5W/n/Z8i8bbld0e+1/Hy9AOVVlgw=;
  b=gggpcaPtYDLCRiYlmWPFBHcG7vrIUeSSXSuwnpb4mtWD3TUrUD9LLBgo
   i6Zf9ancI7sUyTRYZ9psD+twwx2p6eiE4UZlS2bH+FSA5DMco6FJmXwtI
   QpCugQc2SUKX3hVl1M4Fy5t2FGvUfdOQFTZaqNe1iG602XC5vzCKmG40p
   P7KqaIfC5uanDb/t7xtYNrj/PQ1HRlszxx95hGYAI4DQAgbTjq3jAL/E1
   NbLdEFIO2jag8fvOhxJtZyiEIqTlNVVISquyptEwI5fXfeiXI6KZe8VgG
   b5hvkoG6bDtaeodEUMQNlnFx0tN8sVgeMUqbkiRqO/oane/denBSKfB5J
   g==;
X-IronPort-AV: E=Sophos;i="5.56,451,1539648000"; 
   d="scan'208";a="22370164"
IronPort-PHdr: =?us-ascii?q?9a23=3Atz4seRW5yAsKGhCelzQnH/e9yUHV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYxOCt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KhlUh/ojDoMOSA//m/Zl8d8iLtXrA+9qxB6xYPffYObO+dkfq7Ffd0UW3?=
 =?us-ascii?q?dPUMhSWSJGDYyyYJACA/YCMOtCs4XwvUcCoQe4CAKxBO3v0DhIhnru0KMnz+?=
 =?us-ascii?q?QuDxnG3Aw+ENIIrX/asdD1O70WUeCx0qbJzSjIYvRN2Tjg84jFaQwhoPGQUr?=
 =?us-ascii?q?Jwdsrd008vFxjfgVmKpozlOC2V2/0LvmOG4eRgUuevhHQmqwF3ujWvycYsip?=
 =?us-ascii?q?XJhoII0V/I7zl2wIEwJdC+VUV1YsakHYNNuyyVOIZ6WMMvT3xytCokxbAKp4?=
 =?us-ascii?q?S3cDUMxZ863RDQceaHfJKN4h/7UeaRJip3i2x9dbKkghay7VCgyurhVsmoyF?=
 =?us-ascii?q?pKrjRKkt3Ltn0Vyxzc8NKHSvpg/ke6wzqPywDS5f1EIUAzj6bbLYIuwqUsmZ?=
 =?us-ascii?q?YJtETDHyv2lF33jK+QaEok5vCl5/nob7jpvJORN5J4hhvgPqkhhMCzG/k0Ph?=
 =?us-ascii?q?ALX2eB+OS80LPj/Vf+QLVPlvA2ibTWsIvBKMQHpq+2Hw9V0oE55xa5FDepys?=
 =?us-ascii?q?4UnXYALFJbYB6HlZTmO0nSIPDkCveym0+snylvx/DHOL3hH5rMI2PdkLfuY7?=
 =?us-ascii?q?l98VRQyAktwtBF4ZJbFLUBLOj0Wk/ru9yLRiM+Zhe5x+fhFcVVyIwTQySMD7?=
 =?us-ascii?q?WfPaeUtkWHtcw1JOzZX5MYoDbwLbAe4vfqiXIo0QsGcbKBwYocaHf+GO9vZU?=
 =?us-ascii?q?qefyy/0Z86DW4Ws19mH6TRg1qYXGsWPi6/?=
X-IPAS-Result: =?us-ascii?q?A2AWCgBBhDNc/wHyM5BkHQEBBQEHBQGBZYFbKWaBAieYA?=
 =?us-ascii?q?UwBAQEBAQEGimCJQoZ8IBAIAYN6RoIGIjgSAQMBAQEBAQECAWwcDII6KYMVC?=
 =?us-ascii?q?wFGgVGCYz8BgXQND6dEM4QtAYEThGAFh36EQRd4gQeBEYRmgUoCgi6FEgKJT?=
 =?us-ascii?q?oYbgQCQcwmHFIpRDBiRbgEtjjqNMyFCgRQrCAIYCCEPgyeGCYpxIQMwgQUBA?=
 =?us-ascii?q?Yl7AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 07 Jan 2019 16:57:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x07GvFuJ021345;
        Mon, 7 Jan 2019 11:57:15 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsemanage: set selinux policy root around calls to selinux_boolean_sub
Date:   Mon,  7 Jan 2019 11:59:19 -0500
Message-Id: <20190107165919.17681-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.20.1
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

Switch the selinux policy root around the selinux_boolean_sub() call
to incorporate the semanage root as a prefix and to use the specified
policy store as a suffix so that the correct booleans.subs_dist file
(if any) is used.

The underlying bug is that booleans.subs_dist is not itself managed
via libsemanage. If it was managed and therefore lived within the
policy store, then libsemanage could access the appropriate
booleans.subs_dist file without using the libselinux interface at all,
and thus would not need to modify the selinux policy root.  Moving
booleans.subs_dist to a managed file is deferred to a future change.

Test:
strace semodule -p ~/policy-root -s minimum -n -B

Before:
openat(AT_FDCWD, "/etc/selinux/targeted/booleans.subs_dist", O_RDONLY|O_CLOEXEC) = 5

After:
openat(AT_FDCWD, "/home/sds/policy-root/etc/selinux/minimum/booleans.subs_dist", O_RDONLY|O_CLOEXEC) = 5

Fixes https://github.com/SELinuxProject/selinux/issues/109

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsemanage/src/boolean_record.c | 44 ++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/boolean_record.c b/libsemanage/src/boolean_record.c
index 665c0223..6840901d 100644
--- a/libsemanage/src/boolean_record.c
+++ b/libsemanage/src/boolean_record.c
@@ -6,6 +6,7 @@
  * Implements: record_key_t (Database Record Key)
  */
 
+#include <string.h>
 #include <sepol/boolean_record.h>
 
 typedef sepol_bool_t semanage_bool_t;
@@ -84,10 +85,49 @@ hidden_def(semanage_bool_get_name)
 int semanage_bool_set_name(semanage_handle_t * handle,
 			   semanage_bool_t * boolean, const char *name)
 {
-	int rc;
-	char *subname = selinux_boolean_sub(name);
+	int rc = -1;
+	const char *prefix = semanage_root();
+	const char *storename = handle->conf->store_path;
+	char *oldroot;
+	char *olddir;
+	char *subname = NULL;
+	char *newroot = NULL;
+	char *end;
+
+	oldroot = strdup(selinux_policy_root());
+	if (!oldroot)
+		return -1;
+	olddir = strdup(oldroot);
+	if (!olddir)
+		goto out;
+	end = strrchr(olddir, '/');
+	if (!end)
+		goto out;
+	end++;
+	*end = '\0';
+	rc = asprintf(&newroot, "%s%s%s", prefix, olddir, storename);
+	if (rc < 0)
+		goto out;
+	rc = selinux_set_policy_root(newroot);
+	if (rc)
+		goto out;
+
+	subname = selinux_boolean_sub(name);
+	if (!subname) {
+		rc = -1;
+		goto out;
+	}
+
+	rc = selinux_set_policy_root(oldroot);
+	if (rc)
+		goto out;
+
 	rc = sepol_bool_set_name(handle->sepolh, boolean, subname);
+out:
 	free(subname);
+	free(oldroot);
+	free(olddir);
+	free(newroot);
 	return rc;
 }
 
-- 
2.20.1

