Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9064C4724C
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 15:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB642082E
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 15:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WioF2owW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgD3PD0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726762AbgD3PDZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 11:03:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6288EC035494
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 08:03:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so7320662wrb.8
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 08:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PGp+fnSYNl7qIf57gKG2p//s8XOb5hl2/KkuAbTYZDg=;
        b=WioF2owWvg0KIDloQjCC60QTXTp1sZ5fw8QEQHAmzmPSVc6luQqgoKTP2/HHu3CrHd
         dFi6ImAxau3XdMgFdUYimSzUULAeh0WmE5YuxR+z1C32lk7nkEsoUHrUsnRTdVd1Pw4Y
         ooPddlt0Hw+ojrHlbnHufO4HhIBDSDeC6aalfnV4du6VFoIm4E+XH4tk2LgD2ASpJeKs
         9j0fmMQz/kSjjZ2Zi1TtFmHIpW8WB0E66TdiIbSHoP+/yFByyxU4JVvgsCjiqyvxnB5h
         kkD13tWZOx9csP2kUzzxHtcVhNUA2QHXnaYrquXE5MxR3tJnT+eWEb+GCxC2OtsUTjod
         zPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGp+fnSYNl7qIf57gKG2p//s8XOb5hl2/KkuAbTYZDg=;
        b=oUInqd3yIkIJC9JQ7S4GasGFCUWK2fjxLHNXWbxa8RtJ0TuKBlbx/fSp4h1CSmmohb
         aGi1XpAJlVcNjTvOe8VeYUIROxtL6F+FXfpOz3rqJtjkxIEE2+1xih0yrvAP+xzzN3He
         p5n+rv1mYeNCKnSmf9yXJzhq+40N7IMW52yxe+SmPPI+uapyVAp2O2OCy1dsxIzvq5OA
         /KMMyT4hQGn8EnQkdF2pSy7Uqy5T0qis/z5zE1yvxkDNhLs/TP5ozsPn4VLNTdkAVNS5
         4WARsNOCEjaEMllIrrIW/MGu+d3DM//qJNnbI/6JoX2xaH2ezoNu3Kfg4gpO1UKMoA3/
         uM/g==
X-Gm-Message-State: AGi0PubCxGmRv+08/yBYY/wUD5EEOBorh0eAay0W7/1EFzZaZDkC7fIy
        sTbypyvbFJJmRRrRvzlV3ofkq+xl
X-Google-Smtp-Source: APiQypLhyzevzlTc2dn+BQdZp82nUd5jvXBto+xw1PNJ37CKsuBSMjkz0sH+QACvldEGztjG3+a+Ow==
X-Received: by 2002:adf:dcca:: with SMTP id x10mr3606668wrm.212.1588259003326;
        Thu, 30 Apr 2020 08:03:23 -0700 (PDT)
Received: from debianHome.localdomain (x4d065388.dyn.telefonica.de. [77.6.83.136])
        by smtp.gmail.com with ESMTPSA id l19sm12834497wmj.14.2020.04.30.08.03.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 08:03:22 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] libselinux: mark security_context_t typedef as deprecated
Date:   Thu, 30 Apr 2020 17:03:18 +0200
Message-Id: <20200430150318.6406-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200420114650.19093-1-cgzones@googlemail.com>
References: <20200420114650.19093-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Follow-up of: 9eb9c9327563014ad6a807814e7975424642d5b9 ("Get rid of security_context_t and fix const declarations.")

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: use the common deprecation style

 libselinux/include/selinux/selinux.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index aaf28ffd..c22834e5 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -14,7 +14,11 @@ extern int is_selinux_enabled(void);
 extern int is_selinux_mls_enabled(void);
 
 /* No longer used; here for compatibility with legacy callers. */
-typedef char *security_context_t;
+typedef char *security_context_t
+#ifdef __GNUC__
+__attribute__ ((deprecated))
+#endif
+;
 
 /* Free the memory allocated for a context by any of the below get* calls. */
 extern void freecon(char * con);
-- 
2.26.2

