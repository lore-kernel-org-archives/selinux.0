Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16B8C433EF
	for <selinux@archiver.kernel.org>; Tue, 10 May 2022 17:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiEJRt7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 May 2022 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241692AbiEJRt6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 May 2022 13:49:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9BD2182B
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 10:45:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i19so34420192eja.11
        for <selinux@vger.kernel.org>; Tue, 10 May 2022 10:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qu7fy7PaTokYttSdBE6poFXCBoE4uw4w2Icc82LA5Go=;
        b=KuoSk1gMqThxUHQtavV6UhgIjSVkQ5Zv+LxWaaiPJ9BT9fMMt+X1D/B93D6mWvLQdI
         OD83pu/aRU1TRzqFOJssE20VirGdjPFLVQlblhRJgR23H1GSRtGTjXCajcSqBYcXW8/Y
         rEoV6/OqZDiIJ1xlY1cOwm/bicRP2OZ4tQ3mWGcOXFf5DJGrLgZusfMR4ZE/wb+neNq/
         XCYpDX/rTH4spVv7M2DaAGmbTA+1Wp72J7TaxR2nVTyWJDVRcw54ttMJy9I06dG7jU+H
         6BAdO2fpHGHuszhaRS7bbpchSLpaksoLuikJAORmzqs+WPCOYujS90N+kh+qCVpIV+ps
         kVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qu7fy7PaTokYttSdBE6poFXCBoE4uw4w2Icc82LA5Go=;
        b=qB5RC02uzl3+hozi9WCoRh0HuY1RKz2d2PEt9piDxKlJCBGpH69Vo/7JPAsnhyLGy4
         EKLWfTBp8/LcWYZfoZ4xeCLHzR1iZMmmA3qjhkOoHf8Zede6nMsHqE4DkLAkkdkRFA2I
         vvhKj4zBLxqr/XWldtdmGmNrIW3pKza02cWym2RuQBS1Fwp4hKx0M/nNINja3MO10S+W
         gxlWYcAruII+rHJd1XLP/qbpHQu8od6/7zRCjQCdRsPtNHoQHM5Vl0au/ad7plWpAXoB
         7nl53Rr17qT62CAZrHqexpjhyt62F2ppxgunMaMhbCGIZnrMVNqOSvgAfXnnDjuZSCHs
         xu8A==
X-Gm-Message-State: AOAM531xpQQU/ukDK6+hy7B5Sdt4wkEMyeDbU8w+ttc7BeCnIbkle9og
        tgX2SN3TC++zTj476N26kVUBoqUfW9g=
X-Google-Smtp-Source: ABdhPJyb4q7oBM/KOpNyRH13Ah5y/9NA2zuQXzuL/uIo6c2wpLKKtcSx7gZy307vRXTKG35WJx8sYw==
X-Received: by 2002:a17:906:3087:b0:6f4:2901:608a with SMTP id 7-20020a170906308700b006f42901608amr21711431ejv.646.1652204757862;
        Tue, 10 May 2022 10:45:57 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-078-050-241-079.78.50.pool.telefonica.de. [78.50.241.79])
        by smtp.gmail.com with ESMTPSA id w12-20020a50f10c000000b0042617ba63c4sm8054054edl.78.2022.05.10.10.45.56
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:45:56 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: free memory in error branch
Date:   Tue, 10 May 2022 19:45:51 +0200
Message-Id: <20220510174551.24679-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In case the allocation for the filename fails, free the memory of the context.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index e6192912..e160c06e 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -489,13 +489,15 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
 		goto oom_freefl;
 	fl->file = strdup(file);
 	if (!fl->file)
-		goto oom_freefl;
+		goto oom_freeflcon;
 	fl->next = prevfl->next;
 	prevfl->next = fl;
 
 	__pthread_mutex_unlock(&fl_mutex);
 	return 0;
 
+oom_freeflcon:
+	free(fl->con);
 oom_freefl:
 	free(fl);
 oom:
-- 
2.36.1

