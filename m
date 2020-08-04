Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BAEC433E1
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF41720781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="15BT/TZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgHDBfF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBfF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:35:05 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28732C06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:35:05 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 77so4765263qkm.5
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=ivAGTN7etltds3ch7v/VpVgRVbT8MzGpjp7NnjPwaMY=;
        b=15BT/TZ7fnVSYUFQEoIXxbNiLu+hdic8/A19lLYFEv7OOpj3GAFiMKGDDR6CpF3Sl+
         sAv27P4zSvIPkCjlDU2haPHTc9byApBsCEBfJnc7nNhiDKLokm/be/z5KvxV5Vbyy92G
         08JS0Jrd8rXvU7H4rvdGHg0aOtpKjq9enYh6Qrsb3/vj3JYK2LTtFZSE8QLBedRxagmy
         9/Pn9f4X1UKBRf7whb/OIW3/NSJZRMKAWPYNAc9v7gJPjvLUjZoEM7fBcwB7qeFNL3Jl
         TK3CpYnopTXPqW0Lw3OSrhx/DSGBTEkYXZvJKZPUHI1g2KZXbLuFFylqiAxTO5gfSqhx
         BiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ivAGTN7etltds3ch7v/VpVgRVbT8MzGpjp7NnjPwaMY=;
        b=itpdRiTZ8XHbWpZgSDwSkFKkhvhynI71ZX7sQDxbfZXBf/+h7sDwFy7nCmNjupUG5U
         Ujv3hEipYIcbBO12keLsjOz9xQubhryjijKYF25R8wWI08ZaS+T2V9y9fIQt6qyGu3pZ
         2Zo/fqJhI92/wE95E0o5Q4TVEfSijuizOnoxyHW6xZZg22R9eQVZq/9k8QwYD0C2qKCN
         FbUMKkZ6QG3tusKaKlFb+9LRW2Vv1IbrigcWTJttYxOzYFn6SctoRu19th1Ek5JUiMKa
         ykm/5zX86T7HsJM4tOKm0Ik3gGTV6HWrWa5uDGVZNrBBnle/o+Y69GUeMwhvmSFHavPK
         bskA==
X-Gm-Message-State: AOAM533VB6GwE4Bqw8U/lErbKmvuDKLYgEU/UF6yrn5ixHxUpbn1uDtZ
        FW9iLCT2B3QJIMbzRMVZFZSQBnJ8H+ye
X-Google-Smtp-Source: ABdhPJwT4pw8wMpc6F/KWYSTmHx8TPr/hFLLsWHAVf0meMoKATr3eOTuYB9Tkl39x5GFV66pOBS2TA==
X-Received: by 2002:a37:4c84:: with SMTP id z126mr19467777qka.130.1596504903854;
        Mon, 03 Aug 2020 18:35:03 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id 65sm19285921qkn.103.2020.08.03.18.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:35:03 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 16/18] kernel_policy_language: convert
 the footnotes to markdown
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:35:02 -0400
Message-ID: <159650490255.8961.4142736519349867696.stgit@sifl>
In-Reply-To: <159650470076.8961.12721446818345626943.stgit@sifl>
References: <159650470076.8961.12721446818345626943.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There are still more footnotes that need to be converted, and the
kernel_policy_language.md file still needs to be fully converted to
markdown, but this resolved a problem seen while building the PDF.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/kernel_policy_language.md |   38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/src/kernel_policy_language.md b/src/kernel_policy_language.md
index eba0564..a4118f9 100644
--- a/src/kernel_policy_language.md
+++ b/src/kernel_policy_language.md
@@ -6,9 +6,9 @@ then has links to each section within this document.
 
 ## Policy Source Files
 
-There are three basic types of policy source file<strong><a href="#fn1" class="footnote-ref" id="fnker1"><sup>1</sup></a></strong> that can contain language statements
-and rules. The three types of policy
-source file<strong><a href="#fn2" class="footnote-ref" id="fnker2"><sup>2</sup></a></strong> are:
+There are three basic types of policy source file[^fn_kpl_1] that can contain
+language statements and rules. The three types of policy source file[^fn_kpl_2]
+are:
 
 **Monolithic Policy** - This is a single policy source file that
 contains all statements. By convention this file is called policy.conf
@@ -739,7 +739,7 @@ within an *if/else* construct, *optional {rule_list}*, or
 <td>neverallow</td>
 <td>Yes</td>
 <td>Yes</td>
-<td><strong>Yes</strong><sup><strong><a href="#fnk3" class="footnote-ref" id="fnker3"><sup>3</sup></a></strong></sup></td>
+<td><strong>Yes</strong>[^fn_kpl_3]</td>
 <td>No</td>
 <td>Yes</td>
 <td>No</td>
@@ -801,9 +801,9 @@ within an *if/else* construct, *optional {rule_list}*, or
 <tr>
 <td>require</td>
 <td>No</td>
-<td><strong>Yes</strong><sup><strong><a href="#fnk4" class="footnote-ref" id="fnker4"><sup>4</sup></a></strong></sup></td>
+<td><strong>Yes</strong>[^fn_kpl_4]</td>
 <td>Yes</td>
-<td><strong>Yes</strong><sup><strong><a href="#fnk5" class="footnote-ref" id="fnker5"><sup>5</sup></a></strong></sup></td>
+<td><strong>Yes</strong>[^fn_kpl_5]</td>
 <td>Yes</td>
 <td>No</td>
 </tr>
@@ -969,15 +969,23 @@ Note these are not kernel policy statements, but used by the Reference Policy
 to assist policy build:
 -   [Modular Policy Support Statements](modular_policy_statements.md#modular-policy-support-statements)
 
-<section class="footnotes">
-<ol>
-<li id="fn1"><p>It is important to note that the <strong>Reference Policy</strong> builds policy using makefiles and m4 support macros within its own source file structure. However, the end result of the make process is that there can be three possible types of source file built (depending on the <strong>MONOLITHIC=Y/N</strong> build option). These files contain the policy language statements and rules that are finally complied into a binary policy.<a href="#fnker1" class="footnote-back">↩</a></p></li>
-<li id="fn2"><p>This does not include the <em>file_contexts</em> file as it does not contain policy statements, only default security contexts (labels) that will be used to label files and directories.<a href="#fnker2" class="footnote-back">↩</a></p></li>
-<li id="fnk3"><p><code>neverallow</code> statements are allowed in modules, however to detect these the <em>semanage.conf</em> file must have the <code>expand-check=1</code> entry present.<a href="#fnker3" class="footnote-back">↩</a></p></li>
-<li id="fnk4"><p>Only if preceded by the <code>optional</code> statement.<a href="#fnker4" class="footnote-back">↩</a></p></li>
-<li id="fnk5"><p>Only if preceded by the <code>optional</code> statement.<a href="#fnker5" class="footnote-back">↩</a></p></li>
-</ol>
-</section>
+[^fn_kpl_1]: It is important to note that the Reference Policy builds policy
+using makefiles and m4 support macros within its own source file structure.
+However, the end result of the make process is that there can be three possible
+types of source file built (depending on the *MONOLITHIC=Y/N* build option).
+These files contain the policy language statements and rules that are finally
+complied into a binary policy.
+
+[^fn_kpl_2]: This does not include the *file_contexts* file as it does not
+contain policy statements, only default security contexts (labels) that will be
+used to label files and directories.
+
+[^fn_kpl_3]: *neverallow* statements are allowed in modules, however to detect
+these the *semanage.conf* file must have the *expand-check=1* entry present.
+
+[^fn_kpl_4]: Only if preceded by the *optional* statement.
+
+[^fn_kpl_5]: Only if preceded by the *optional* statement.
 
 <!-- %CUTHERE% -->
 

