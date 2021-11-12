Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26778C4332F
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A26660EE5
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhKLPpC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbhKLPpB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Nov 2021 10:45:01 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0ADC061766
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:10 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b15so39081159edd.7
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oybfTQcGxTp5JmZWJtOuu35y0uDEqluqSortKYNJkwU=;
        b=RdVtgBSMrDJaiAdKeTdw/0eHkz8sY0mULWm30kkKtk7G267cih5GVdg+r92HAGk2DJ
         BfYChV6kA52CfRgDm2M8jZ9X4BdIytbSKbsXIu2hHHhZwI+Zmq4+FIWaGsAflWylPz/H
         h8fSGhCEcXQ47ZTPHGgnYxAKkI8UIINGIbv6MeJ/tHuWaJ2VElRx1uMfxbTjMKTTB5wy
         V7S9KDSKNSIfK2QwqKu8tRAShBh45NOG+uv7BmY/BOsIVshDtXOhyVVXTuvLORK5xTmZ
         bvuyMoVwqe6GCFnGzX0h96QLQlZ1FLpWwfuvf7BwdddZouYXhN5Kt4zhYAbSoS0DXqwx
         Lw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oybfTQcGxTp5JmZWJtOuu35y0uDEqluqSortKYNJkwU=;
        b=C1iF8RA9/aycYQrzaNRUFI36Am/pmeiQLT1gPlJz784Yad5AexB+RuelMR/An9ftCv
         6JYyF+M0eMb5Va4HgC7SbjwwUf1h2fb+aHCF20IY7ATu5FEa/Jvh8oU+Bc6bgWIGu238
         raYY7X68BoLPJnmf9Omc+tscVBs6Tbowk63ytPx01S/+DCnYqBVlzVRbCJpiIH9qbjNw
         QccLdNi6hhu70H7uQzZQWrUdaA1Pbpy1TlBX5/0r9kwJZr7+VrC0kT/EZaIFGCdJreAH
         nyUaHG1U3szXl4mGHX6i+OIy2RwU6z6z8c8pNhaZayOprCuke2JQ+BgKZEEfiIwFfK+Z
         dKxg==
X-Gm-Message-State: AOAM5320TTMWF41TDRv0h3crpY1mbjx0QFRIBpCBaXJU11vI1VCwSvuV
        RqjY37QJn9IG6x+q8W2pQnOvma/C3NY=
X-Google-Smtp-Source: ABdhPJzExozhfTwaq1wXDvmnCnJ2yjRtt97DtFM6AdX1r4qzc6gsldgwfvguNbnCV7HQ22td8zdxLQ==
X-Received: by 2002:a17:906:919:: with SMTP id i25mr20043440ejd.171.1636731729072;
        Fri, 12 Nov 2021 07:42:09 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-195-130.77.0.pool.telefonica.de. [77.0.195.130])
        by smtp.gmail.com with ESMTPSA id m9sm2628914eje.102.2021.11.12.07.42.08
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:42:08 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 05/12] checkpolicy: ignore possible string truncation
Date:   Fri, 12 Nov 2021 16:41:54 +0100
Message-Id: <20211112154201.78217-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112154201.78217-1-cgzones@googlemail.com>
References: <20211112154201.78217-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The source code line content, saved to improve error reporting, might
get truncated, as the current Bison source buffer is 8192 bytes long and
only 254 bytes (plus NUL-terminator) are reserved.
As the saved string is only used for improving error reports and source
lines longer than 254 character are quite uncommon, simply silence the
GCC warning.

    In file included from /usr/include/string.h:519,
                     from lex.yy.c:20:
    In function ‘strncpy’,
        inlined from ‘yylex’ at policy_scan.l:63:7:
    /usr/include/x86_64-linux-gnu/bits/string_fortified.h:91:10: warning: ‘__builtin_strncpy’ output may be truncated copying 255 bytes from a string of length 8190 [-Wstringop-truncation]
       91 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_scan.l | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index ef9f1899..9fefea7b 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -60,7 +60,14 @@ hexval	[0-9A-Fa-f]
 
 %%
 \n.*				{
+#if defined(__GNUC__) && __GNUC__ >= 8
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wstringop-truncation"
+#endif
 				  strncpy(linebuf[lno], yytext+1, 255);
+#if defined(__GNUC__) && __GNUC__ >= 8
+#pragma GCC diagnostic pop
+#endif
 				  linebuf[lno][254] = 0;
 				  lno = 1 - lno;
 				  policydb_lineno++;
-- 
2.33.1

