Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8767FC25B08
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 17:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbiHHRhI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Aug 2022 13:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242984AbiHHRhE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Aug 2022 13:37:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90B213E8B
        for <selinux@vger.kernel.org>; Mon,  8 Aug 2022 10:37:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gb36so17847569ejc.10
        for <selinux@vger.kernel.org>; Mon, 08 Aug 2022 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=+SQLaRXNkRgvTh8+/lJgnMERAvNcJs9FJBTusKHFKZA=;
        b=b2e8ML4djVTHb6Em8flHNKi1uS5+Go2QX34i/0GIC0wfkzqZ6JUrI1NAVlvcpM24fh
         2255PDgzbdKa0mCWjZxUJMgFjxPQZarCL0MTBlyvlHlMckk5HjniLW64RI2lIGL0RGoy
         SbJsYYSw6DVS3fkdNr4cn59aSOdyNMjNAJipNGaYxhFtQdQeTuqaWQQkfrOl4didzD7A
         Qud7NWadf7CcSiBOQHCh8r2+4O1y/jA90WkQXqwiz4zAljwAumT4KQ8M42MPPw7ph34P
         N+sG3hrtnrRECVAoEZeYmyn/aZc7hBuhdh8fh5KwEtM5IRXA47hxmyGzyNTQyRE+54aq
         VBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=+SQLaRXNkRgvTh8+/lJgnMERAvNcJs9FJBTusKHFKZA=;
        b=3M4/RaEI4dK2p6pvWD3FhBi1BxfzxLrpBqGG9TcLSsEDlgrHLCWzqSt1A5mKuzysjp
         mVhY1fKXGfYGlHArrrVWp7I6hFyiENAn3fH8DpqkgiBcpyXbBR6fYNoRVTkh5tq4CvP+
         VTz/hVfNxYm1MoQ/A2960CzHSHuHD2N8h3uC4yCvsTvZCiQKPwfPS5lLfhjYku8y1C/Z
         TuKW9G+7aKQD6A0D1ibPh2qBWqbkyqLNFHQnofH0hruS5/4euDq0hcu4+c445XwQSOL0
         c/FA1+a2kLRUKvWBaPNJeu+os9US5cr4IeDMYWhyYpc+LGBMcCKZ45/tGTtHGouEbdxu
         oqeA==
X-Gm-Message-State: ACgBeo333SOqWqu28pdNJN+zbZRCAoS72gK89JH6ybLVpDEnzFw8tScO
        LYWL8m+AHlxApzAvd1Pr2AxH/GaLV34=
X-Google-Smtp-Source: AA6agR6lz2RUMkDIGvmn3IIGdq4kuO8kTc7FxDmtROASyFTRdVnYq105CS2eXBTzAS9Lf4MOt4pvWw==
X-Received: by 2002:a17:906:9749:b0:730:aaee:30e2 with SMTP id o9-20020a170906974900b00730aaee30e2mr13894282ejy.248.1659980221489;
        Mon, 08 Aug 2022 10:37:01 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-248-038.77.0.pool.telefonica.de. [77.0.248.38])
        by smtp.gmail.com with ESMTPSA id es25-20020a056402381900b0043a61f6c389sm4851900edb.4.2022.08.08.10.37.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:37:00 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/4] scripts: ignore Flake8 tag E275
Date:   Mon,  8 Aug 2022 19:36:54 +0200
Message-Id: <20220808173655.16867-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808173655.16867-1-cgzones@googlemail.com>
References: <20220808173655.16867-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    ./gui/polgengui.py:484:18: E275 missing whitespace after keyword
    ./gui/polgengui.py:530:18: E275 missing whitespace after keyword
    ./python/sepolgen/src/sepolgen/policygen.py:327:19: E275 missing whitespace after keyword
    ./python/sepolgen/src/sepolgen/policygen.py:329:11: E275 missing whitespace after keyword
    ./python/sepolicy/build/lib/sepolicy/__init__.py:453:15: E275 missing whitespace after keyword
    ./python/sepolicy/build/lib/sepolicy/generate.py:1349:28: E275 missing whitespace after keyword
    ./python/sepolicy/build/lib/sepolicy/generate.py:1351:28: E275 missing whitespace after keyword
    ./python/sepolicy/build/lib/sepolicy/gui.py:638:24: E275 missing whitespace after keyword
    ./python/sepolicy/build/lib/sepolicy/gui.py:863:23: E275 missing whitespace after keyword
    ./python/sepolicy/build/lib/sepolicy/gui.py:2177:16: E275 missing whitespace after keyword
    ./python/sepolicy/sepolicy/__init__.py:453:15: E275 missing whitespace after keyword
    ./python/sepolicy/sepolicy/generate.py:1349:28: E275 missing whitespace after keyword
    ./python/sepolicy/sepolicy/generate.py:1351:28: E275 missing whitespace after keyword
    ./python/sepolicy/sepolicy/gui.py:638:24: E275 missing whitespace after keyword
    ./python/sepolicy/sepolicy/gui.py:863:23: E275 missing whitespace after keyword
    ./python/sepolicy/sepolicy/gui.py:2177:16: E275 missing whitespace after keyword
    ./sandbox/sandbox:114:7: E275 missing whitespace after keyword
    ./sandbox/sandbox:134:11: E275 missing whitespace after keyword
    ./sandbox/sandbox:136:7: E275 missing whitespace after keyword

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 scripts/run-flake8 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/run-flake8 b/scripts/run-flake8
index 67cccfe9..ad15f3d4 100755
--- a/scripts/run-flake8
+++ b/scripts/run-flake8
@@ -58,6 +58,7 @@ IGNORE_LIST="$IGNORE_LIST,E261" # at least two spaces before inline comment
 IGNORE_LIST="$IGNORE_LIST,E265" # block comment should start with '# '
 IGNORE_LIST="$IGNORE_LIST,E266" # too many leading '#' for block comment
 IGNORE_LIST="$IGNORE_LIST,E272" # multiple spaces before keyword
+IGNORE_LIST="$IGNORE_LIST,E275" # missing whitespace after keyword
 IGNORE_LIST="$IGNORE_LIST,E301" # expected 1 blank line, found 0
 IGNORE_LIST="$IGNORE_LIST,E302" # expected 2 blank lines, found 1
 IGNORE_LIST="$IGNORE_LIST,E303" # too many blank lines
-- 
2.36.1

