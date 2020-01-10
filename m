Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB69FC33CA4
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CE12072E
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AV0wlDWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgAJOPT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:15:19 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:37017 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgAJOPT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 09:15:19 -0500
Received: by mail-wm1-f46.google.com with SMTP id f129so2144575wmf.2
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 06:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2JG9NX0EC9XC3rMLzHwrBdh/WPh/VQSZfa9i3BUpv+Q=;
        b=AV0wlDWVcxWgtmHUOyxvcJ8H4kcqqQeJCjFy3Izw/Gsi8wXiCI+M9Anh+Im1imS/1Z
         n++p5DnqHudGIUGhkAYjl6HvTnq4XDA5BU26oP3m8uYFXbacHJ+rNdDQ/3ybzu9cfB1s
         AUoCE6ordHlRtm01Z8JMhtr6rGaycvhSvl5O6SFhdHdS7Cnm8JDBMkkJ4l3Xq/GEVAZv
         3vfsYo/b6zHOLMapXPTV+oVVMWDXv0NpsBaoxrSQgr1ZQhaCbzJB9oNWOfF9frqmEMNd
         Jk4pMIko8SiCR025wIv57JQqMmnR7IWupi4TWSUf5l/NRnEt/sQvYgKGLCjQQuy13YzB
         sAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2JG9NX0EC9XC3rMLzHwrBdh/WPh/VQSZfa9i3BUpv+Q=;
        b=G7WACBJQ0b44ZrTIFogd2sKgrZRJXTVuZkaW4JbU3PJEeby+mdujCy9lGiGu/0mWG8
         N8m+EIqtX72tLrY9HS5yf73VlkxcDRT/kQs4mPMHJ8KYqq9BkqddPl5Ma7666asSHPZY
         sk4OefqKLY9cfSb29htqkRB3WRYj2tMHxNFNHhthGJqxF7TpJB1YhX2lGrC+wg3ouSU2
         3d0z3lOI+6c3fY2G5HRsuF7VdQT4iATbitBKYNxW8JRQGhfWpY30I6MJJWJ5H7fuhfaW
         Yk72af5AT3BSiLlhCxqJcDpRiktSigMpBK62Cli1rgujSfW6gHRAmZxlMNFAccCCSmhs
         0yJw==
X-Gm-Message-State: APjAAAVN1CA+7bGlNd2XKe5qSdmPOui088rT153sXqgn9nkDiB4tFeua
        769D/Fe+XfpcKqi7jU+6GlzVx7xv
X-Google-Smtp-Source: APXvYqxRZbGW7X9u61jtVssKY0f5HlYdi6ydOd9kqzCa/PStiw3PsntuxsOYi4C+wImKI4jIC3GfDA==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr4824939wmc.54.1578665716385;
        Fri, 10 Jan 2020 06:15:16 -0800 (PST)
Received: from desktopdebian.localdomain (x4d03413a.dyn.telefonica.de. [77.3.65.58])
        by smtp.gmail.com with ESMTPSA id q15sm2369509wrr.11.2020.01.10.06.15.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 06:15:15 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 1/3] libsepol: add policy capability for systemd overhaul
Date:   Fri, 10 Jan 2020 15:15:07 +0100
Message-Id: <20200110141509.21098-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.25.0.rc2
In-Reply-To: <20200110141509.21098-1-cgzones@googlemail.com>
References: <20200110141509.21098-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

---
 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index dc9356a6..8cecb80b 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -13,6 +13,7 @@ enum {
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
+	POLICYDB_CAPABILITY_SYSTEMD_OVERHAUL,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index b9dc3526..38f9b85d 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -12,6 +12,7 @@ static const char *polcap_names[] = {
 	"always_check_network",		/* POLICYDB_CAPABILITY_ALWAYSNETWORK */
 	"cgroup_seclabel",		/* POLICYDB_CAPABILITY_SECLABEL */
 	"nnp_nosuid_transition",	/* POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION */
+	"systemd_overhaul",		/* POLICYDB_CAPABILITY_SYSTEMD_OVERHAUL */
 	NULL
 };
 
-- 
2.25.0.rc2

