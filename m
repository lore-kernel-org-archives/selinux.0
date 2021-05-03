Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DA4C433B4
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992906121D
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhECRzD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhECRy5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117A5C06134A
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:54:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u13so4616284edd.3
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MDAhyImfxXfHrVqJSjeGJs6q7MSayY6jD5V7i6hIELE=;
        b=uby0xI4d2puC0D0pXUPz73kfxDXYzKV4QNqNJVkfhK9abrJw+urLVmFL2qvekh+wtn
         lR7w76LREACJ+ynLQUIBPhv99b/ReHm9onjKL0etT3PGnYzuTR4iFVcJtCQLDuy7X4Kg
         qg64Nc90+uUoRc1KGWMFkHQLntLIt0sjTwBu78g35czt1mW0onoJfkBRpMITOpRXgXVr
         /zHg9s13UzTBSV0WgzIJ+v1anaOa2XQGth9pqFhg2neTpxV4cyhXS1X/D6oGPQx3OgkS
         /ak1+qyRmIJeNgGSpS+migKYSCM1KF8diEwWFd/72SiUQ2I3UQWbo4PbEoU7c/UUMo9L
         vkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MDAhyImfxXfHrVqJSjeGJs6q7MSayY6jD5V7i6hIELE=;
        b=Dm4ZBUJvloAENtJvtdJV0lmEm5R/CgaWxieaZDwyWb3kacWwgzFtyi5i0ZQkQlbyOd
         rRHZcgtKY2hB8mFprdZTXWSLiU+ATum4mYikSPcOtkRbzK63KJUIKhBng4yZdyY2pDKS
         PQMwgFLPsl358Zur4ANxUrXHg+cTz4CwmhVUE//GcmTblr/tAAaQcjQXZS+2kc2Tm6ih
         ya76mpE1kUD4c/EMFf5lfShNdaCPS+t8YkQetDFsr9Z3PkoAfQha299PDyeVlxfOeh7M
         X6K93zxaILLcUuyuum3tbACUWQrQYOaLaeYVWKZcfiwNHISWtf7/wVjeHhvN9swg2A56
         MYSw==
X-Gm-Message-State: AOAM5322oiDoaGkYJoHInT+m/PcIQJ8XBt7djk4bd5sSulDe6y/i4zlv
        qIP6W/Hna4Xb/Zxeg2WYAmq7QGFjmBdxdw==
X-Google-Smtp-Source: ABdhPJyIXj0gmYDKHFfqMOBS7iDdFT5ANCdj4nL4yZ3oPh3iv9Y1bVCLdukEa7ifJGABJ+laOFI1XA==
X-Received: by 2002:a50:fc0b:: with SMTP id i11mr22086046edr.259.1620064440863;
        Mon, 03 May 2021 10:54:00 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.54.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:54:00 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 17/25] libselinux: matchmediacon(): close file on error
Date:   Mon,  3 May 2021 19:53:42 +0200
Message-Id: <20210503175350.55954-18-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Found by Infer.

matchmediacon.c:25: error: Resource Leak
  resource of type `_IO_FILE` acquired to `return` by call to `fopen()` at line 21, column 16 is not released after line 25, column 4.
  23. 	while (!feof_unlocked(infile)) {
  24. 		if (!fgets_unlocked(current_line, sizeof(current_line), infile)) {
  25. 			return -1;
         ^
  26. 		}
  27. 		if (current_line[strlen(current_line) - 1])

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/matchmediacon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libselinux/src/matchmediacon.c b/libselinux/src/matchmediacon.c
index 23d01af4..d3d95043 100644
--- a/libselinux/src/matchmediacon.c
+++ b/libselinux/src/matchmediacon.c
@@ -22,6 +22,7 @@ int matchmediacon(const char *media, char ** con)
 		return -1;
 	while (!feof_unlocked(infile)) {
 		if (!fgets_unlocked(current_line, sizeof(current_line), infile)) {
+			fclose(infile);
 			return -1;
 		}
 		if (current_line[strlen(current_line) - 1])
-- 
2.31.1

