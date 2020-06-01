Return-Path: <SRS0=O06S=7O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A22FC433E0
	for <selinux@archiver.kernel.org>; Mon,  1 Jun 2020 07:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656B02076B
	for <selinux@archiver.kernel.org>; Mon,  1 Jun 2020 07:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IOG72ibI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgFAH3X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAH3W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Jun 2020 03:29:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98A7C061A0E
        for <selinux@vger.kernel.org>; Mon,  1 Jun 2020 00:29:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fs4so4666298pjb.5
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2020 00:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bm3idoxMu9MDRe7TJ1Dqur/rE8cKqBm/B+rKxsJpIPY=;
        b=IOG72ibIB8U+6LVYu92CrJuODQ7coYx+WZV6pag1GDIZ5Yd1q8VpwbhKXPCoQzl9hq
         +tUz1dIcd8qqri/MgmJxsnMczlZuVAbkvsE7liSmMbGk/2iYR+vdoqmmOY3VjVTKmdSM
         DgKSla5QIb4xizBjb+EJ33MyWthnNOhqghSXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bm3idoxMu9MDRe7TJ1Dqur/rE8cKqBm/B+rKxsJpIPY=;
        b=Z9oxNlcvtzXUvyd9EbM6HBXSCbYfD88xJmYd18EQpqYLkNBqcPLBRPhkKrfWHcdGQ0
         DIsLCrBZeTla1cX4B1dimeQHxoEjmY0/L2yYlEqrIioftB3NoNaebUilQCVxKrioP0ss
         M1oSTSoWiPdpwi86f6RlTUZU2zqNWDWTFt4HrLl6yS76S+bMMF6eMZOM5IcE8LscAvif
         3y6ge3nAOqWDTssezaJq1PMnqrqay8xFw/DNqqYuXmHsfsBenJus2ECapLt1n+b++UDc
         LascDWKl5To6hisR9EUMojkxxqp9R4zCY9pOuFdq+NbUAV4XnlpZyuypI9fPiQzvMvao
         g7ag==
X-Gm-Message-State: AOAM533u+nxR6LUKJqOH0Ij4oroorvFclCV4+GJ2WES9wI8+ziP50aSo
        Imi35eheu8gsLQDvnZjkPwClfw==
X-Google-Smtp-Source: ABdhPJy9L178y3gG6+cfj0MySCZeINC66GknptlG7hUVDv2HZrGS5PIBcrYyej6L429vTr1fvZPfdA==
X-Received: by 2002:a17:902:8e88:: with SMTP id bg8mr18935855plb.92.1590996562267;
        Mon, 01 Jun 2020 00:29:22 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:2:1c5:cb1a:7c95:326])
        by smtp.gmail.com with ESMTPSA id w12sm7343210pjb.11.2020.06.01.00.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 00:29:21 -0700 (PDT)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        selinux@vger.kernel.org, Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH] selinux: Allow file owner to set "security.sehash"
Date:   Mon,  1 Jun 2020 16:29:16 +0900
Message-Id: <20200601072916.219197-1-chirantan@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Normally a process needs CAP_SYS_ADMIN in the namespace that mounted a
particular filesystem in order to set a security xattr. However, this
restriction is relaxed for the security.selinux xattr: the file owner
or a process with CAP_FOWNER in its namespace may set this attribute.

Apply this relaxed restriction to the security.sehash xattr as well.
Since this xattr is mainly a performance optimization when labeling
files recursively it shouldn't have stricter requirements than setting
the selinux xattr in the first place.

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
---
 include/uapi/linux/xattr.h | 3 +++
 security/selinux/hooks.c   | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index c1395b5bd432a..b700c8ffc3f1a 100644
--- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -53,6 +53,9 @@
 #define XATTR_SELINUX_SUFFIX "selinux"
 #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
 
+#define XATTR_SEHASH_SUFFIX "sehash"
+#define XATTR_NAME_SEHASH XATTR_SECURITY_PREFIX XATTR_SEHASH_SUFFIX
+
 #define XATTR_SMACK_SUFFIX "SMACK64"
 #define XATTR_SMACK_IPIN "SMACK64IPIN"
 #define XATTR_SMACK_IPOUT "SMACK64IPOUT"
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4c037c2545c16..776df2ec85a82 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3121,9 +3121,10 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	struct superblock_security_struct *sbsec;
 	struct common_audit_data ad;
 	u32 newsid, sid = current_sid();
+	const bool is_sehash = !strcmp(name, XATTR_NAME_SEHASH);
 	int rc = 0;
 
-	if (strcmp(name, XATTR_NAME_SELINUX)) {
+	if (strcmp(name, XATTR_NAME_SELINUX) && !is_sehash) {
 		rc = cap_inode_setxattr(dentry, name, value, size, flags);
 		if (rc)
 			return rc;
@@ -3143,6 +3144,10 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	if (!inode_owner_or_capable(inode))
 		return -EPERM;
 
+	/* No more checks needed for security.sehash. */
+	if (is_sehash)
+		return 0;
+
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
 
-- 
2.27.0.rc0.183.gde8f92d652-goog

