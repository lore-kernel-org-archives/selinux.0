Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B341CC00523
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 01:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D342072C
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 01:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji/Uri2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgAFB4Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:56:25 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55254 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbgAFB4Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 5 Jan 2020 20:56:24 -0500
Received: by mail-pj1-f66.google.com with SMTP id kx11so6907009pjb.4;
        Sun, 05 Jan 2020 17:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bwykfnh9I+HBTex5KIv5flUDMZzUB+KXgYZaVTuNTVw=;
        b=Ji/Uri2phyquI7tB8XXhe1WF/Q/QRG9LVCeX5W+cBP9IjDAeGBcb1e6BGAQw9tbTmo
         1+5gUpRdr0mwzShSPcROxJl71xDR4R57tQezoQPsvZw93yUZCnlv7qYICAA1ca0W9yUC
         NnhMGHxzOXPB0lsI214wqc1MSkaB/arMYEXBkeB2zmCGtX7m50ME2DJuFQkdsRzvYLRj
         6d7tIf92A6XWNbrLe8ovm4Kn3LlFP+8r1qXXQb3VExQvcN5netq1WY0uueZakvojQ77w
         fdxqGrJaHaiHC2FqYk5klZuPLIk/36/SuwPieoMdecy+iM+0NW89Cm72F75QIzEjw7fy
         eBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bwykfnh9I+HBTex5KIv5flUDMZzUB+KXgYZaVTuNTVw=;
        b=mg3F/7Yo7L1v0jeBrxyYCR6iPtOiavtRPPjgmleC48hcQlK1+vbD0UDp2Vgka3OePB
         CWSE8XpvEifglm7cYPxTpE/TPi9ceKNySd2K8LOC2c2s7ns/OSVG3GZlxyjmBWRFUzHz
         1sM1u9t7GJyZUyn+W8XJ39LjtQQSGlohHA2vWb1iofSyB/6AzQOHV/1lnejvgjId1LVU
         //2V/+hZwWGX7fZhJtknVNHR4YqsLR10JmomNbCseJDv0YIAMocyq2mYRoV/BipN3dPm
         +qvU8yep9HC8yBl1BTk3P3L51LTRC5DuLCBlQDCTEgWBbw4wPQTqprCSquZHTB4VUDB7
         sxQw==
X-Gm-Message-State: APjAAAWCj1IlPt9BEyHwjumt7HpeDmBORcEcPxrBCdEOhQ4JmjH9RIuD
        n4xOoBTho4VRYUA41NVkA2U=
X-Google-Smtp-Source: APXvYqwprWNudrZCAIdy2jEAfpLuiljLwlXloJdJDl3DL5bBJ0mppBmTwbVXm2ltIwpCH+09OxqEOw==
X-Received: by 2002:a17:90b:1243:: with SMTP id gx3mr40570711pjb.117.1578275784141;
        Sun, 05 Jan 2020 17:56:24 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id e16sm68495846pgk.77.2020.01.05.17.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jan 2020 17:56:23 -0800 (PST)
From:   liuyang34 <yangliuxm34@gmail.com>
X-Google-Original-From: liuyang34 <liuyang34@xiaomi.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liuyang34 <liuyang34@xiaomi.com>
Subject: [PATCH] selinuxfs: use scnprinft to get real length in sel_read_class
Date:   Mon,  6 Jan 2020 09:56:18 +0800
Message-Id: <ba3290e18f9867e110b77d058c3f8c7015bd868b.1578274288.git.liuyang34@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1578274288.git.liuyang34@xiaomi.com>
References: <cover.1578274288.git.liuyang34@xiaomi.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

as the return value of snprintf maybe over the size of TMPBUFLEN, 
use scnprintf to instead of it

Signed-off-by: liuyang34 <liuyang34@xiaomi.com>
---
 security/selinux/selinuxfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ee94fa4..977c32d 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1672,7 +1672,7 @@ static ssize_t sel_read_class(struct file *file, char __user *buf,
 {
 	unsigned long ino = file_inode(file)->i_ino;
 	char res[TMPBUFLEN];
-	ssize_t len = snprintf(res, sizeof(res), "%d", sel_ino_to_class(ino));
+	ssize_t len = scnprintf(res, sizeof(res), "%d", sel_ino_to_class(ino));
 	return simple_read_from_buffer(buf, count, ppos, res, len);
 }
 
-- 
2.7.4

