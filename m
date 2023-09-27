Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBD1E82CCA
	for <selinux@archiver.kernel.org>; Wed, 27 Sep 2023 19:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjI0TAk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjI0TAh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Sep 2023 15:00:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4820B196
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:34 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7757523362fso116349985a.0
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695841233; x=1696446033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+D0b3iXAnGe3X932HlRl3VN0zbk6OnmdgSCddcWVJ5E=;
        b=F/7fGASi9D4I6IgDp9+nmekftlX6POpDG/DruCqCN8ltzBf6trhSwfp6LpVDHX2knI
         SUyTTeW+rzT6aPqJgryk5ki/nBIoYOU9hlNncov8JZtcZSVTY2MWWoO0zurT0TqU/1gZ
         Hq3rKyMSCYOL/UTnGrCeQ2haYfe5ogfNOntEwhNok/2Pxhtumi7WVoYMAdZvEfYDcWQk
         LY7xeiibMdr27VPVvaXqmAqBi6F8f88VUo79V8tZaR4o2ZlyS7XyLIYcsY2qOMiCyKci
         Bd+mHO+8JA9yL0nl3HmEyEgeGj1AnAEaSHOKkZNCvYlpbZz2U1Wymb08sK3xJd7x/9Su
         Vr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695841233; x=1696446033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+D0b3iXAnGe3X932HlRl3VN0zbk6OnmdgSCddcWVJ5E=;
        b=ViEcCzrDZuqQb70VJ2sKJJFKkwfFU150sfZzAvZyMkC7LImkjMy4/gaMtjQR6cE8u0
         Oku42A3WiDvexmlkgvjhjxlYpIwWQKHq1p/bUaCYw/NEi/Ax2+5ord/ERb0eZxXm8Za7
         A1rX33pWj6Q3jXzKGUqReW4+vfIpidjaJdQdlwc6w+sGW6Rd8JwlL1CXSQOXKKGivPua
         ui4TKaVBmn9NqejcbPEdmh6MeQEIHP/Cxr8ZxqiL/R67STnxadR/eWE+9MS2UQjo2a/w
         eCwFG690el4Ul9aV+05zkLtXxWoUCuR4Xh/6pPht/Xe3emHsZlvLZxXcwRNM/v6M8/pn
         Vvxw==
X-Gm-Message-State: AOJu0YwwBRmBcfHhLVo0Vz/oIoCGkEnenlxql0ZmoVWyaV4LBWcFD5cW
        rtAjSgywF8m4oujOHXLSvEzmb+ezjdY=
X-Google-Smtp-Source: AGHT+IHWYaYDR5APnQv0oat2CvvzPSwmljph10yb/XOvhTnzlhwA1b8gDE8JxuxqF7IhvPd2/YuS5w==
X-Received: by 2002:a05:622a:1111:b0:417:b901:91a7 with SMTP id e17-20020a05622a111100b00417b90191a7mr3256322qty.24.1695841232605;
        Wed, 27 Sep 2023 12:00:32 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b004181aa90b46sm2415167qtb.89.2023.09.27.12.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:00:32 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 7/9] secilc/docs: Fix and update the documentation for macro parameters
Date:   Wed, 27 Sep 2023 15:00:19 -0400
Message-ID: <20230927190021.1164278-8-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927190021.1164278-1-jwcart2@gmail.com>
References: <20230927190021.1164278-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove references to "typealias", "categoryalias", and
sensitivityalias" as valid parameter kinds, because they are not.

Add "string" as a valid parameter kind.

Add a note that "categoryset", "level", "levelrange",
"classpermission", and "ipaddr" can be named or anonymous.

Add a note that "type", "role", and "user" can be used for attributes.

Add a note that "type", "sensitivity" and "category" can be used for
aliases.

Add a note that "string" and "name" can be used for filenames in
typetransition rules and paths in filecon rules.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/docs/cil_call_macro_statements.md | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/secilc/docs/cil_call_macro_statements.md b/secilc/docs/cil_call_macro_statements.md
index dcc6139f..adbfef4b 100644
--- a/secilc/docs/cil_call_macro_statements.md
+++ b/secilc/docs/cil_call_macro_statements.md
@@ -90,7 +90,11 @@ Duplicate [`macro`](cil_call_macro_statements.md#macro) declarations in the same
 <tr class="odd">
 <td align="left"><p><code>param_type</code></p></td>
 <td align="left"><p>Zero or more parameters that are passed to the macro. The <code>param_type</code> is a keyword used to determine the declaration type (e.g. <code>type</code>, <code>class</code>, <code>categoryset</code>).</p>
-<p>The list of valid <code>param_type</code> entries are: <code>type</code>, <code>typealias</code>, <code>role</code>, <code>user</code>, <code>sensitivity</code>, <code>sensitivityalias</code>, <code>category</code>, <code>categoryalias</code>, <code>categoryset</code> (named or anonymous), <code>level</code> (named or anonymous), <code>levelrange</code> (named or anonymous), <code>class</code>, <code>classpermission</code> (named or anonymous), <code>ipaddr</code> (named or anonymous), <code>name</code> (a string), <code>classmap</code></p></td>
+<p>The list of valid <code>param_type</code> entries are: <code>string</code>, <code>name</code>, <code>type</code>, <code>role</code>, <code>user</code>, <code>sensitivity</code>, <code>category</code>, <code>bool</code>, <code>categoryset</code>, <code>level</code>, <code>levelrange</code>, <code>ipaddr</code>, <code>class</code>, <code>classmap</code>, and <code>classpermission</code>.
+<p>The <code>param_types</code> <code>categoryset</code>, <code>level</code>, <code>levelrange</code>, <code>classpermission</code>, and <code>ipaddr</code> can by named or anonymous.</p>
+<p>The <code>param_types</code> <code>type</code>, <code>role</code>, and <code>user</code> can be used for attributes.</p>
+<p>The <code>param_types</code> <code>type</code>, <code>sensitivity</code> and <code>category</code> can be used for aliases.</p>
+<p>The <code>param_types</code> <code>name</code> and <code>string</node> can be used interchangeably for an <code>object_name</code> in [`typetransition`](cil_type_statements.md#typetransition) and the <code>path</code> in [`filecon`](cil_file_labeling_statements.md#filecon) statements.</p></td>
 </tr>
 <tr class="even">
 <td align="left"><p><code>param_id</code></p></td>
-- 
2.41.0

