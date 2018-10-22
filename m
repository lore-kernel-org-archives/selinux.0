Return-Path: <SRS0=10e4=NC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32124C67863
	for <selinux@archiver.kernel.org>; Mon, 22 Oct 2018 08:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B96205F4
	for <selinux@archiver.kernel.org>; Mon, 22 Oct 2018 08:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B96205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeJVQaN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:30:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40689 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbeJVQaN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Oct 2018 12:30:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id z204-v6so9320848wmc.5
        for <selinux@vger.kernel.org>; Mon, 22 Oct 2018 01:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bj2EzXAEVVSmm30Pb0cUu0jNeSvmNZJ2tX6M24ltluk=;
        b=dV5EKvRTVP8bsJ/2uewAjDsMuCSAFsWvaeIvZEz5fUBya+q8Ywe+FEdvooVlt4wAnk
         gBfUQVP1q1uWYUyTWAILKK3m+txdXrIwdSOLkmXr9m+ARbYN2Hg8YBPCu+YYG1hdnlQE
         YUz03dL9GpDN/4xeaGAdf/G0U4vCMYnkFc/rlE/unkBviIbNkSxi/1bFWfsADP2CvpOb
         p+cLb4DAOLgr4EfOm74RdSIJoflVxz4mFzEVoz+yQji+U8OjeuroVHLuW1+z5UNqCNUT
         Xgi8Ul1k+ooamkg6F1ua5cBNbQOjJsSJMFIFhEu7JMqfr9RdamOscTedH4zLymFjPshC
         g48Q==
X-Gm-Message-State: ABuFfoh8qQdIxopP1uIte1lwpkVQzqn43enXnQb727yWRR0QUjjDmdDY
        BjwrX7vWzltt1aFceL43t+dzqrGBgih9EDCd
X-Google-Smtp-Source: ACcGV61MCl4IAn5Ket2hfvm+KhnirIS3El0MCBplYHUi7MsaxDb1Jq7ZdT5h6wfuslmYj02dUzl9Vw==
X-Received: by 2002:a1c:ed07:: with SMTP id l7-v6mr14738895wmh.47.1540195962537;
        Mon, 22 Oct 2018 01:12:42 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s10-v6sm7471121wmf.15.2018.10.22.01.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 01:12:41 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, James Morris <jmorris@namei.org>,
        Doug Ledford <dledford@redhat.com>, stable@vger.kernel.org
Subject: [PATCH v5] selinux: policydb - fix byte order and alignment issues
Date:   Mon, 22 Oct 2018 10:12:35 +0200
Message-Id: <20181022081235.4743-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do the LE conversions before doing the Infiniband-related range checks.
The incorrect checks are otherwise causing a failure to load any policy
with an ibendportcon rule on BE systems. This can be reproduced by
running (on e.g. ppc64):

cat >my_module.cil <<EOF
(type test_ibendport_t)
(roletype object_r test_ibendport_t)
(ibendportcon mlx4_0 1 (system_u object_r test_ibendport_t ((s0) (s0))))
EOF
semodule -i my_module.cil

Also, fix loading/storing the 64-bit subnet prefix for OCON_IBPKEY to
use a correctly aligned buffer.

Finally, do not use the 'nodebuf' (u32) buffer where 'buf' (__le32)
should be used instead.

Tested internally on a ppc64 machine with a RHEL 7 kernel with this
patch applied.

Cc: Daniel Jurgens <danielj@mellanox.com>
Cc: Eli Cohen <eli@mellanox.com>
Cc: James Morris <jmorris@namei.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: <stable@vger.kernel.org> # 4.13+
Fixes: a806f7a1616f ("selinux: Create policydb version for Infiniband support")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 51 ++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 15 deletions(-)

Changes in v5:
 - defer also assignment to 8-bit ibendport.port

Changes in v4:
 - defer assignment to 16-bit struct fields to after the range check

Changes in v3:
 - use separate buffer for the 64-bit subnet_prefix
 - add comments on the byte ordering of subnet_prefix
 - deduplicate the le32_to_cpu() calls from checks

Changes in v2:
 - add reproducer to commit message
 - update e-mail address of James Morris
 - better Cc also the old SELinux ML

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index f4eadd3f7350..d7e8126f32dc 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2108,6 +2108,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 {
 	int i, j, rc;
 	u32 nel, len;
+	__be64 prefixbuf[1];
 	__le32 buf[3];
 	struct ocontext *l, *c;
 	u32 nodebuf[8];
@@ -2217,21 +2218,30 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 					goto out;
 				break;
 			}
-			case OCON_IBPKEY:
-				rc = next_entry(nodebuf, fp, sizeof(u32) * 4);
+			case OCON_IBPKEY: {
+				u32 pkey_lo, pkey_hi;
+
+				rc = next_entry(prefixbuf, fp, sizeof(u64));
+				if (rc)
+					goto out;
+
+				/* we need to have subnet_prefix in CPU order */
+				c->u.ibpkey.subnet_prefix = be64_to_cpu(prefixbuf[0]);
+
+				rc = next_entry(buf, fp, sizeof(u32) * 2);
 				if (rc)
 					goto out;
 
-				c->u.ibpkey.subnet_prefix = be64_to_cpu(*((__be64 *)nodebuf));
+				pkey_lo = le32_to_cpu(buf[0]);
+				pkey_hi = le32_to_cpu(buf[1]);
 
-				if (nodebuf[2] > 0xffff ||
-				    nodebuf[3] > 0xffff) {
+				if (pkey_lo > U16_MAX || pkey_hi > U16_MAX) {
 					rc = -EINVAL;
 					goto out;
 				}
 
-				c->u.ibpkey.low_pkey = le32_to_cpu(nodebuf[2]);
-				c->u.ibpkey.high_pkey = le32_to_cpu(nodebuf[3]);
+				c->u.ibpkey.low_pkey  = pkey_lo;
+				c->u.ibpkey.high_pkey = pkey_hi;
 
 				rc = context_read_and_validate(&c->context[0],
 							       p,
@@ -2239,7 +2249,10 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 				if (rc)
 					goto out;
 				break;
-			case OCON_IBENDPORT:
+			}
+			case OCON_IBENDPORT: {
+				u32 port;
+
 				rc = next_entry(buf, fp, sizeof(u32) * 2);
 				if (rc)
 					goto out;
@@ -2249,12 +2262,13 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 				if (rc)
 					goto out;
 
-				if (buf[1] > 0xff || buf[1] == 0) {
+				port = le32_to_cpu(buf[1]);
+				if (port > 0xff || port == 0) {
 					rc = -EINVAL;
 					goto out;
 				}
 
-				c->u.ibendport.port = le32_to_cpu(buf[1]);
+				c->u.ibendport.port = port;
 
 				rc = context_read_and_validate(&c->context[0],
 							       p,
@@ -2262,7 +2276,8 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 				if (rc)
 					goto out;
 				break;
-			}
+			} /* end case */
+			} /* end switch */
 		}
 	}
 	rc = 0;
@@ -3105,6 +3120,7 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
 {
 	unsigned int i, j, rc;
 	size_t nel, len;
+	__be64 prefixbuf[1];
 	__le32 buf[3];
 	u32 nodebuf[8];
 	struct ocontext *c;
@@ -3192,12 +3208,17 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
 					return rc;
 				break;
 			case OCON_IBPKEY:
-				*((__be64 *)nodebuf) = cpu_to_be64(c->u.ibpkey.subnet_prefix);
+				/* subnet_prefix is in CPU order */
+				prefixbuf[0] = cpu_to_be64(c->u.ibpkey.subnet_prefix);
 
-				nodebuf[2] = cpu_to_le32(c->u.ibpkey.low_pkey);
-				nodebuf[3] = cpu_to_le32(c->u.ibpkey.high_pkey);
+				rc = put_entry(prefixbuf, sizeof(u64), 1, fp);
+				if (rc)
+					return rc;
+
+				buf[0] = cpu_to_le32(c->u.ibpkey.low_pkey);
+				buf[1] = cpu_to_le32(c->u.ibpkey.high_pkey);
 
-				rc = put_entry(nodebuf, sizeof(u32), 4, fp);
+				rc = put_entry(buf, sizeof(u32), 2, fp);
 				if (rc)
 					return rc;
 				rc = context_write(p, &c->context[0], fp);
-- 
2.17.2

