Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296E3C433F5
	for <selinux@archiver.kernel.org>; Wed, 27 Oct 2021 18:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BE06109F
	for <selinux@archiver.kernel.org>; Wed, 27 Oct 2021 18:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbhJ0SPS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhJ0SPS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Oct 2021 14:15:18 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81393C061570
        for <selinux@vger.kernel.org>; Wed, 27 Oct 2021 11:12:52 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id f1so3294614qto.9
        for <selinux@vger.kernel.org>; Wed, 27 Oct 2021 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K1B9JHLq9PWLP/zHWyJ6cnJpdltyQSgV6M1zrRnwDJg=;
        b=ax54oA0cDoFEkb/tpte93WVd9lKkDOxHpl102g+BtgVJbxsh2rknDfd065AY7rztgw
         kH/0ZFRc8Pu8J1oVGMMBZ4UPLIEOnS0LoTgg64O9scLbjCHT+DkGqEXUe3Uo5hR0jQx3
         xima8ieH0UlbGqDZwSLFySvLQRklDyFeBEgi4hl4bCDBsa6g3Ugnhjfelvh5V6itr3Go
         Ue9xPB/RRby+azPlw9vuvYMTBGiZgkTzYUua+mmptbj94sLfwtv4Vb969cSKHSKMntm2
         RXGGwUw012ds84qZZjyT4KtFXnVwame9Gr5V6TGQ0M19FsTQArGu5RvBps51iCVX99iJ
         3q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K1B9JHLq9PWLP/zHWyJ6cnJpdltyQSgV6M1zrRnwDJg=;
        b=XXLUythjdrwb5INDpukmcoZP0lf7/ZvSN3/kTvE86yNxbqAacDI8IHd+JkMDLnORBx
         0pBGpwEtz+2mnR7MxRRf9jRiysJZzzt8s56HCe7PyweHLMwV71Sae7cGPBCfpeoy+xoQ
         bfKnIFvv5N4o54Xd/j7GB1q/c22c+aq9BUB/bZJ4wKliFn5Xkl39+2O4FB5D7mTIHFkj
         6YFxu9ShDcxk11RFle+CyaAwdgBpv8MJczzBtvCnxAF7so/FZGNNN+y//MU4/eDNZPV3
         cOddbP4xxbgmQ1/MHH7Fjlzlf7KcWq16bSr8z/XQb476CyNwU9a24lPF0VYYEFqbatZ3
         cItg==
X-Gm-Message-State: AOAM5313m0FUQ/JBmBAPzFsiJ7uJHeyNonm5543vaIw5d70TKjZV0ueX
        H4D6I41bMTUIA7/gk/jM9YXjpYEDosY=
X-Google-Smtp-Source: ABdhPJziyIdPVBBMSwqCbO3sKhkeWFTiaByk2l8+xM/ASQeiemzWE+MivdJox2Kvok0PCHVwndWV0w==
X-Received: by 2002:ac8:594b:: with SMTP id 11mr34166425qtz.191.1635358371551;
        Wed, 27 Oct 2021 11:12:51 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id l15sm440561qtk.41.2021.10.27.11.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:12:50 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/4] secilc/docs: Document the optional file type for genfscon rules
Date:   Wed, 27 Oct 2021 14:12:09 -0400
Message-Id: <20211027181210.1019597-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027181210.1019597-1-jwcart2@gmail.com>
References: <20211027181210.1019597-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update the CIL documentation to include the optional file type for
genfscon rules.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/docs/cil_file_labeling_statements.md | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/secilc/docs/cil_file_labeling_statements.md b/secilc/docs/cil_file_labeling_statements.md
index ed7b7bf9..73f73885 100644
--- a/secilc/docs/cil_file_labeling_statements.md
+++ b/secilc/docs/cil_file_labeling_statements.md
@@ -36,11 +36,13 @@ Define entries for labeling files. The compiler will produce these entries in a
 <col width="44%" />
 <col width="55%" />
 </colgroup>
-<tbody>
+<thead>
 <tr class="odd">
 <td align="left"><p><strong>keyword</strong></p></td>
 <td align="left"><p><strong>file_contexts entry</strong></p></td>
 </tr>
+</thead>
+<tbody>
 <tr class="even">
 <td align="left"><p><code>file</code></p></td>
 <td align="left"><p><code>--</code></p></td>
@@ -185,7 +187,7 @@ Used to allocate a security context to filesystems that cannot support any of th
 **Statement definition:**
 
 ```secil
-    (genfscon fsname path context_id)
+    (genfscon fsname path [file_type] context_id)
 ```
 
 **Where:**
@@ -209,6 +211,10 @@ Used to allocate a security context to filesystems that cannot support any of th
 <td align="left"><p>If <code>fsname</code> is <code>proc</code>, then the partial path (see examples). For all other types this must be ‘<code>/</code>’.</p></td>
 </tr>
 <tr class="even">
+<td align="left"><p><code>file_type</code></p></td>
+<td align="left"><p>Optional keyword representing a file type. Valid values are the same as in [`filecon`](cil_file_labeling_statements.md#filecon) rules.</p></td>
+</tr>
+<tr class="odd">
 <td align="left"><p><code>context_id</code></p></td>
 <td align="left"><p>A previously declared <code>context</code> identifier or an anonymous security context (<code>user role type levelrange</code>), the range MUST be defined whether the policy is MLS/MCS enabled or not.</p></td>
 </tr>
-- 
2.31.1

