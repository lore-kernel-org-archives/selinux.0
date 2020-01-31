Return-Path: <SRS0=DB+f=3U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC0CC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 18:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AF720CC7
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 18:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LeG5zSXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgAaSjL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:39:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43551 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgAaSjL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jan 2020 13:39:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so9811698wre.10
        for <selinux@vger.kernel.org>; Fri, 31 Jan 2020 10:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fEMKzlr48inPIZB+vNTdB9EfN+1m7/IUirKEhTIgjwE=;
        b=LeG5zSXyB9ixr6Jt0c4dZYgbrVLjhjHrJH5bR/P3v+SUZq/SvydEzzKr0JPjPTFeQW
         QsXipo72Oh6Bi8rBwbX7XGq9O0rwEr0aBxBpoqVz+WfoZUs1vJIdytB6YYj0pmDIQ5rf
         11HIYCNmI/Sv3sCppJTiu7ZUvhSlShChcng5lznxz4a56pERukK3yoBq9eFqJUzZseFx
         rwg3Ey6WtfyDMmyw5tjvRHKCCw/ZKmXvULWDFtco0MC8YemQiGZXLRIppsy7lCLIYU5Y
         CZe2psiLTASPEJBU5oAM3vW7CDl4YNFgqwSb6xPHjajftPArN8uU7a5lTSpO5IGt47W3
         t6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fEMKzlr48inPIZB+vNTdB9EfN+1m7/IUirKEhTIgjwE=;
        b=SBx8+gM79r7qFC4m9yJp54F4Cz1zCwiyHuRndGroEiIGN9iZxUZnsVUEVnN6fgTYFS
         1aPVjlaOS7FBquIaKPOhVuwnwfqe/aN2yuUnhqsoR2CYW7Vw4n69YZgsjh7kLfTfGPV0
         lXtXmh9VyQczoqC+cQhJZXDywm6DJVoVdhUIDTEIx6RCJm1qfEBOs0u2u+jXOl11EtQa
         WQ+m6LLfyFEuswpJ8OMGTz45LtcBFeP0HNT+eMQM5ML6t0d6uN04+Ku3h9kF28Z84QRF
         upFAFQnMZdFU9AytHwVbMUdqIK4FJSftgFDhe4HvaKTXwhifplOl9rfNTHB1V8VYICnw
         3xRw==
X-Gm-Message-State: APjAAAUhaJF75876JYtjOFzHak00a4X7+4RThdjqBUdul2mNvQdwfiRV
        r94shpSk7I22vOtktLmwIyZoPcBf
X-Google-Smtp-Source: APXvYqw2oxlKQo8FXz/aUQpJRJOylKL24k6kVYZHX8D2pvdCTq6fwRMq2mxMKzxH5aV21kwIlPRB/g==
X-Received: by 2002:adf:a453:: with SMTP id e19mr12854292wra.305.1580495948129;
        Fri, 31 Jan 2020 10:39:08 -0800 (PST)
Received: from desktopdebian.localdomain (x5f702a91.dyn.telefonica.de. [95.112.42.145])
        by smtp.gmail.com with ESMTPSA id 133sm5072821wme.32.2020.01.31.10.39.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 10:39:07 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: add support for new polcap genfs_seclabel_symlinks
Date:   Fri, 31 Jan 2020 19:39:00 +0100
Message-Id: <20200131183900.3507-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add support for new SELinux policy capability genfs_seclabel_symlinks.
With this capability enabled symlinks on kernel filesystems will receive
contexts based on genfscon statements, like directories and files,
and not be restricted to the respective filesystem root sid.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index dc9356a6..40669fb5 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -13,6 +13,7 @@ enum {
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
+	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index b9dc3526..67ed5786 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -12,6 +12,7 @@ static const char *polcap_names[] = {
 	"always_check_network",		/* POLICYDB_CAPABILITY_ALWAYSNETWORK */
 	"cgroup_seclabel",		/* POLICYDB_CAPABILITY_SECLABEL */
 	"nnp_nosuid_transition",	/* POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION */
+	"genfs_seclabel_symlinks",	/* POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS */
 	NULL
 };
 
-- 
2.25.0

