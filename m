Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50039C35E13
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2482921744
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPGeq4zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbgBYUCo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:02:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44493 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730961AbgBYUCn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:02:43 -0500
Received: by mail-pf1-f194.google.com with SMTP id y5so104616pfb.11
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zHxmTPEui+mxUxYinqadrYA5tGM9Ed/b3Ly4CRgFNRo=;
        b=lPGeq4zf/AB2rrXxwW02GVMMqHjisV1w30nRS12xm0+qFIzxcArW9IRMwjeoA65Anc
         8dFCLNffXytHayGIpbMErgmPwEFCxhJgHTXaG+ahWhqCy4LgHvEYgtFLAOHHXn8XqeQ1
         jwgJhR7JLzvPthLPxlYsH+q0uyt+K4hPApb81tXCv67iSgo3EnMHNERmPlXwTPbGT05C
         jNal8MIIAESPdQYMf/o2P+JZUz5nhh83E5I4IxxMNtUo1qt7azCV5Wu8wB65RkpGRmnT
         oFx2PZI3ghxtBlAMO6Dk64P4J0nc9QQtiY3t8+vtOwsiRNy0+/upzlHpyCergMy/M9hp
         CZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zHxmTPEui+mxUxYinqadrYA5tGM9Ed/b3Ly4CRgFNRo=;
        b=SFhtY6ET6bK+RTcNOthdMKZD2hrvHPEtvyOtnBvJyf/sWSOpyYrPtI3F0qF0wkGRtJ
         sB9RRPwCDaeRJ8oC/VX3yUKJhy+keFQYFmlqK9iq3w9uPuHKX+sBXFiUT/O5cmkS/SnV
         aYvkBvSAY9bjwdA+6xnxbB012CrW4Q+WlNSARokcKf/gyD2srJcchwN4YfLwZtc9kiXB
         weELedR6MDT9pPELg8Qc62drlx1/lIJdLa9eSOao0sZBB6QicYKVY9ggWeTa06eyLbw3
         GFGgp5RrOfEbKPVAyg0GUY3eVG+789yUG0yNrhLRKMmFHtDa36H/aHG5BhbjUc5AgN7L
         srhg==
X-Gm-Message-State: APjAAAUkc+SnpXoT1jtIE3+vkSvLWayNfUsLQSghjFZAXoxW2lGMIVXr
        Sghs1f/1jXYhpAL+ltPWW80=
X-Google-Smtp-Source: APXvYqxwFoOqCw7RPCZDlYttQlQy/a7pvTPVUQZB4xihwM3ucq3tC9ox36WZhxcBZlg2N/u+KThaNg==
X-Received: by 2002:aa7:9304:: with SMTP id 4mr411282pfj.76.1582660962991;
        Tue, 25 Feb 2020 12:02:42 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:02:42 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 03/17] selinux_booleans_path: annotate deprecated
Date:   Tue, 25 Feb 2020 14:02:05 -0600
Message-Id: <20200225200219.6163-4-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225200219.6163-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 97834cc842dd..0f77debaa06c 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -571,7 +571,7 @@ extern const char *selinux_contexts_path(void);
 extern const char *selinux_securetty_types_path(void);
 extern const char *selinux_booleans_subs_path(void);
 /* Deprecated as local policy booleans no longer supported. */
-extern const char *selinux_booleans_path(void);
+extern const char *selinux_booleans_path(void) __attribute__ ((deprecated));
 extern const char *selinux_customizable_types_path(void);
 /* Deprecated as policy ./users no longer supported. */
 extern const char *selinux_users_path(void);
-- 
2.17.1

