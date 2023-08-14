Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DF0C10F19
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjHNNVX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjHNNVI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:21:08 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3D8198E
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bcfe28909so559422166b.3
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019253; x=1692624053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzmzIwMgatNVIeymrQgy5mQmH/Xqnbixd3+E3NBHUAI=;
        b=o693HdvSriL8ohPOF8fpaVcjzHiHYUzR8SigslKyyDVQwea/Lupfx/aAwKVUXorbeh
         XrfjIOk/vhb3nLAnJiwyfy+IrYfnwBqccadOtqUG5LeyhAnR5JstdVidxHdC5AWfr8al
         opxr4F4ZMq6SipfK4cZze90Ea4tfhpX3ZV4qk/sfykBUJB35jn45I317Wb4IPjN0G0c3
         Fynl1kO4MkgvnKBDCtr+//aVdpptbcPj01q6MAFHQvxiqX4rj489+B1AoX3MBp70m3XK
         NDfBI/eAx/n0XbB+1L+cGwi6yxIEZdhH6z2K+DrnrwZjR1xiRTXUhlg08Di/Zb2agr4b
         11tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019253; x=1692624053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzmzIwMgatNVIeymrQgy5mQmH/Xqnbixd3+E3NBHUAI=;
        b=GZYQQx7eh1sBxg0JT//HFJbDn+hWc9LPEwn9sve+NK5jGPx4K4NpYjLDQWSgYXxiyL
         7pnjs/kKDiXRIXPfrtHacQ2HbZy+gFzuPDu0e0eGkdr/RIZg3hr6+wKIzZKkQ0T+g8ca
         DTsEeHSLvBAIfzgy3Z+vdj5b3K2pqlxJ8Ox8HYG7GAEzU05UbSIruWF4ZF2V5PRCg0ir
         c+a2tFhK6UZUy2JXqxRhevcmQo4GEUaK2c5vt7T9QIp1wOMNCMVpdYRM6idTDfnjYXN+
         Y6ZMrQgjoQxNq6NBFgHZZTbIeroUywQbumbg7Fg/PegutZAFC8EOybJUmH1PDHVIvwZo
         e1rQ==
X-Gm-Message-State: AOJu0YyCKqT2XCJkrPtff/P+mFeR2dSMLNaBcL13mJDvj0DyFCbBqPy5
        Q78qzTwc9xjL9Y2oE7eo1847xJrjBu7lkXjUvpk=
X-Google-Smtp-Source: AGHT+IH8tQck06xUvsNsn/jjFYEFiMJVochAA2Iw0nYU+NdZLnTKD984wsS5Vnzs3CIUGwLz/xQyNg==
X-Received: by 2002:a17:906:3016:b0:99b:eb9c:4fb9 with SMTP id 22-20020a170906301600b0099beb9c4fb9mr6958239ejz.69.1692019253470;
        Mon, 14 Aug 2023 06:20:53 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 23/27] libselinux: free elements on read_spec_entries() failure
Date:   Mon, 14 Aug 2023 15:20:21 +0200
Message-Id: <20230814132025.45364-24-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Some entries might have been already parsed and allocated.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: add patch
---
 libselinux/src/label_file.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 56439e2d..3827b5c0 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -446,6 +446,9 @@ static inline int process_line(struct selabel_handle *rec,
 				    "%s:  line %u error due to: %m\n", path,
 				    lineno);
 		}
+		free(regex);
+		free(type);
+		free(context);
 		return -1;
 	}
 
-- 
2.40.1

