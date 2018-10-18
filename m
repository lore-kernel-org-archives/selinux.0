Return-Path: <SRS0=DaVr=M6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C496C5ACCC
	for <selinux@archiver.kernel.org>; Thu, 18 Oct 2018 07:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7922145D
	for <selinux@archiver.kernel.org>; Thu, 18 Oct 2018 07:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7922145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeJRPq4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:46:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56075 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbeJRPq4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Oct 2018 11:46:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id 206-v6so4380855wmb.5
        for <selinux@vger.kernel.org>; Thu, 18 Oct 2018 00:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U2g3rk5tmPxXcT+eH9fki/4PrkfpyMaf5GScjZU0sOU=;
        b=fhUMs2yujhLWLIGI1E/SWzcKX+Prkbz7qU9VXQjML29uWPlZT7tmszEgxXlLfd1Q1N
         hYiyI9GXTsL7V4cKP0DT+UG+8sZ0P4PlptXItAnwNrF1YM0+vvyaQYH+iiTH32uatdzo
         mu382+FkjwamahmTGJmu3QumajcLD7OFH1SHruSUU7ExBOhAZuFMwC3aF2VwoN7LAMX6
         Q+3paBbf5ItnnbCvP4R+ICdgxLaiPaayGQJoWkjrS82Qaqq1hRqY6h04bF8Hm4GEStcR
         PzlNMSvsfq+nyGPzU6/LwGs6BYEO1/mlrpA3tMEvCFsq9TpAuLY8i3uD7dw97atnXd6a
         nhvg==
X-Gm-Message-State: ABuFfoiDuXKgEpNqiwx70VYel72w6Fnfg2q8ZJaYRf3S0LNnNPuR7ny8
        w53ijOJI3VVqXvFvf5oLcQX/I8fU/D/ShQ==
X-Google-Smtp-Source: ACcGV60Tv187st0SG2YQNRqzttqnfl2Hek3GQQ7glCBKdWNRuF4VVwk7ZmQjTflHqz8AswoT2FQsLw==
X-Received: by 2002:a1c:e0d7:: with SMTP id x206-v6mr6050130wmg.93.1539848829920;
        Thu, 18 Oct 2018 00:47:09 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h78-v6sm6085394wmd.4.2018.10.18.00.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 00:47:08 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, James Morris <jmorris@namei.org>,
        Doug Ledford <dledford@redhat.com>, stable@vger.kernel.org
Subject: [PATCH v4] selinux: policydb - fix byte order and alignment issues
Date:   Thu, 18 Oct 2018 09:47:04 +0200
Message-Id: <20181018074704.23835-1-omosnace@redhat.com>
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
 security/selinux/ss/policydb.c | 46 +++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 14 deletions(-)

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
index f4eadd3f7350..d50668006a52 100644
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
@@ -2239,6 +2249,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 				if (rc)
 					goto out;
 				break;
+			}
 			case OCON_IBENDPORT:
 				rc = next_entry(buf, fp, sizeof(u32) * 2);
 				if (rc)
@@ -2249,13 +2260,14 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 				if (rc)
 					goto out;
 
-				if (buf[1] > 0xff || buf[1] == 0) {
+				c->u.ibendport.port = le32_to_cpu(buf[1]);
+
+				if (c->u.ibendport.port > 0xff ||
+				    c->u.ibendport.port == 0) {
 					rc = -EINVAL;
 					goto out;
 				}
 
-				c->u.ibendport.port = le32_to_cpu(buf[1]);
-
 				rc = context_read_and_validate(&c->context[0],
 							       p,
 							       fp);
@@ -3105,6 +3117,7 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
 {
 	unsigned int i, j, rc;
 	size_t nel, len;
+	__be64 prefixbuf[1];
 	__le32 buf[3];
 	u32 nodebuf[8];
 	struct ocontext *c;
@@ -3192,12 +3205,17 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
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
 
-				rc = put_entry(nodebuf, sizeof(u32), 4, fp);
+				buf[0] = cpu_to_le32(c->u.ibpkey.low_pkey);
+				buf[1] = cpu_to_le32(c->u.ibpkey.high_pkey);
+
+				rc = put_entry(buf, sizeof(u32), 2, fp);
 				if (rc)
 					return rc;
 				rc = context_write(p, &c->context[0], fp);
-- 
2.17.2

