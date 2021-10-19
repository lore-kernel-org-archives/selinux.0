Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1211FC433F5
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEFFE60FDA
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhJSPPX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhJSPPU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 11:15:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4788C061746
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 08:13:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y12so15330039eda.4
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QpfettWfFQZF58lGAZ3/zCs+Ebg6KiXfHxTU9iuPn+k=;
        b=THEHolA5PcJTMkrchG81tueNolXsnUWX71BWKqdKe0NmaOWYRcQctRzF3sDX4ZUfBh
         pvZoMT8dyau+X2TjQ6LoMYubYtIRWSCp1ZXvc+92Yyx1rK3kjAujmHNlonHM2yI6lo1I
         Ya9fNAnnMgPgS25EBVghW3xi1wRBWnTSnZAuzCcXSdNZe+V4sX2Ig1GopV5L3XovYH9X
         oroYSAgo+Kq1VOTNlCy0G9L/QCJbK31N/d9OplC2URD5X1z3H6UEsFXU5GOX1MsZrzg5
         y7uIhekRhAQ1QmbLuONXN/OMd0FLoNZLNN807AtmIrwV9gNgpK/xO9BfJ67xX1W0e5GC
         3e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QpfettWfFQZF58lGAZ3/zCs+Ebg6KiXfHxTU9iuPn+k=;
        b=e8d/UuBQadG9Ls8RjZLK0ojm2gmmuXztRZba3UC7hmQ1u9C5IOQQwQgcu+H1si269u
         veLC0ulwQL0pfOYNwjcv7xy/XE/sxR53Qb68192+hZyoinBIHQ/72mlkMSMXweSxwM5H
         CpLpShrW/ZT/z7/9ielsPpfckNUQnb/qJeGU4B7qJHy42zKvEl0Ft8smCYTw0CxMZQBf
         cWd9DevMXem/WI4RgtslNk5eI8xyGxUxp6RAzYF//3TsCpzwo74gsG15XDBkTUApjXpb
         2JCSrPv1QfwgS2trJwK6AwpGsHnmJwDDluX4SlSG3nBC+xsVVUJD/7HuksKCOAj3lS6Q
         f6DQ==
X-Gm-Message-State: AOAM533R0LqcUiV23+BgqX4r4W0WZBZxL2fYKmC7SkbBD9/fgdyxF/6O
        STTDPEJ4R+ncaMBgCFtt6GvZdVSxdb8=
X-Google-Smtp-Source: ABdhPJzVgW81+a07M/biYeRZme6WXtQ5gfgnKGAy4JvUpEsjZFDXDUpWdBFCGmt1/k3CM+WG96oEqQ==
X-Received: by 2002:a17:906:8397:: with SMTP id p23mr40055627ejx.43.1634656291152;
        Tue, 19 Oct 2021 08:11:31 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-035-102.77.0.pool.telefonica.de. [77.0.35.102])
        by smtp.gmail.com with ESMTPSA id t6sm11724801edj.27.2021.10.19.08.11.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:11:30 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 1/3] libsepol: do not pass NULL to memcpy
Date:   Tue, 19 Oct 2021 17:11:21 +0200
Message-Id: <20211019151123.10335-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013125358.15534-1-cgzones@googlemail.com>
References: <20211013125358.15534-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For the first iteration `mod->perm_map[sclassi]` is NULL, thus do not
use it as source of a memcpy(3), even with a size of 0.  memcpy(3) might
be annotated with the function attribute nonnull and UBSan then
complains:

    link.c:193:3: runtime error: null pointer passed as argument 2, which is declared to never be null

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2:
   drop realloc rewrite, just check for 0 size
---
 libsepol/src/link.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 7512a4d9..b14240d5 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -190,8 +190,9 @@ static int permission_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			ERR(state->handle, "Out of memory!");
 			return -1;
 		}
-		memcpy(newmap, mod->perm_map[sclassi],
-		       mod->perm_map_len[sclassi] * sizeof(*newmap));
+		if (mod->perm_map_len[sclassi] > 0) {
+			memcpy(newmap, mod->perm_map[sclassi], mod->perm_map_len[sclassi] * sizeof(*newmap));
+		}
 		free(mod->perm_map[sclassi]);
 		mod->perm_map[sclassi] = newmap;
 		mod->perm_map_len[sclassi] = perm->s.value;
-- 
2.33.0

