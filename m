Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491DDC43470
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A4F61278
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhECRy7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhECRyz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48792C06138D
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:53:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u13so4616068edd.3
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/8YTM1x8f18VNrTJdlKur6vh0lfbOCklkMl5jzvLQ+c=;
        b=WF8vzFxfqyDvoDayyBBVdGnymY9yZSIBYwwa4wmkKdOT5u3hhCb6XJEo9F8876pOWV
         HiBqp2qsqxr8cAejKNwA/9sKiMgeaM5K6VA2euEMw/vorHSd+mhszx9kr99ukYWjpeHo
         /mqLXxj06iWs74G3qyaajFWk2gbGMXbucauERkLcKOe/mJcNglUzepas68fxuifZRRvn
         NbwQpdu6kgANBet4WmoZ9yL5o4AHbia7PI3xu1DAlwEQ/3Y4SdAQig4zboUwFDjlH57g
         h+YPfU61eVYwu/CnoqbR08Sx2Mt0lc+TxLrc2I1ge+l0Gf1tXfK8z/FQPiWRh2ckNK0w
         9SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8YTM1x8f18VNrTJdlKur6vh0lfbOCklkMl5jzvLQ+c=;
        b=Cy0JA55xuwg7GqY7SQTSqxEQLSlHP4ydczJkja8BQqFpi0b60ydxrnhHjvIWoGMAk5
         FunC5o1Gy56vT865CQ6j8sSbji7Q1ONPCynjP6xe4yTOMl6ynSBvlD5+UQViWRoMLFhG
         +8L9IolIC2/PNtF7X8E58MbpLZ1HKZuAkCWayVh3V7Df6DTIu53m6ZDXv6e6RvG7uxif
         +pIGqagROmnMHTcXdUxgvl60EhNlrugCQktVFSdza/1IvpFDu0cHJVxiw3wlkdFbcBCu
         Cb0e6za1s4szTvcOY3ghKrHpFuTz7amG48oXghnO8St9+884BzKPT9HSWWCVaRm/wxau
         XJFg==
X-Gm-Message-State: AOAM532s4QWXw6nq3LY15NdZmqD1rIoWhYAeeiPyDXbERiDWJoHGlh2R
        5DTMNhogJJuCcvHxPGhDcmHrarAPimnD0w==
X-Google-Smtp-Source: ABdhPJyUjgnxY/DBSMkN0Sh7xpyjazBBaeXvCzQaozOWD+2iDJXx11WvfzMjTx+Q/JXwgRBTDRQWcw==
X-Received: by 2002:a05:6402:3553:: with SMTP id f19mr12415866edd.167.1620064437863;
        Mon, 03 May 2021 10:53:57 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:53:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 07/25] libselinux: selinux_restorecon: mark local variable static
Date:   Mon,  3 May 2021 19:53:32 +0200
Message-Id: <20210503175350.55954-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The variable `dir_xattr_list` is only used inside `selinux_restorecon.c`.

selinux_restorecon.c:65:19: warning: no previous extern declaration for non-static variable 'dir_xattr_list' [-Wmissing-variable-declarations]
struct dir_xattr *dir_xattr_list;
                  ^
selinux_restorecon.c:65:1: note: declare 'static' if the variable is not intended to be used outside of this translation unit
struct dir_xattr *dir_xattr_list;
^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 63fb8dc5..249c361f 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -62,7 +62,7 @@ static uint64_t fc_count = 0;	/* Number of files processed so far */
 static uint64_t efile_count;	/* Estimated total number of files */
 
 /* Store information on directories with xattr's. */
-struct dir_xattr *dir_xattr_list;
+static struct dir_xattr *dir_xattr_list;
 static struct dir_xattr *dir_xattr_last;
 
 /* restorecon_flags for passing to restorecon_sb() */
-- 
2.31.1

