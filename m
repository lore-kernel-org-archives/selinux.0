Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C081EC433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14D320781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WkIeTdup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgHDBd6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBd6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:33:58 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F396BC06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:33:57 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w9so29781507qts.6
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=v9ZvmYBz7eaoO+uUvfFP1o/P6cXhuawctpQc4C+Sm9g=;
        b=WkIeTdupPriUDlNc1ey0pk5AR1cZFpauX2+/O+IrENzNWFrM0eyKSUzYzVMKY/EcOv
         uUv8st9CnZpqFeJvR1LSVmbseC0mULpodHahNlSaaWqOUN0Z+pgbtsGPpNJksPoXffXO
         3t8nd8QCPsphbuRbf0Cm9WoMUqm4fkmPSnage/SLlDMoyOmGh5aLUCRGIWm4/eijIt9w
         Po8m0ZZOukAwCitgmGa572gxumf/X70DBQG2dOXXC73Yyisw2WybPTuZgXHY33zON11h
         HvPe4tfpnR+PoHoP0QAP2Tujy3jESIFM9Mp96OuIv17EaXHngIwGA2U+7wdLiNhR4QfY
         xYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=v9ZvmYBz7eaoO+uUvfFP1o/P6cXhuawctpQc4C+Sm9g=;
        b=WzlOE1YbCwwRmBceAWOPiljqQrq5MTysbSWn10c+TkhwTltt4PBsVoqY5C6xoJP2Pi
         RmLRpsYhY7l9wf3t7urTB+FQ7goF1NeOftRL8/GgJ5Oa/1VoFGtkpWpSB8IJk/jPas1w
         rxVMW++mMqCmhxcIuai5WfvRvyUUvp8KF+2ZxKFDI0B28KYl3qQBphyFyi5sYk1Pw24W
         BFY0Frw53QG1J4YV0tdMIWZPhCKWHEwHYQmh4pMDjHVxqFgKOuATeIQ0YC3afyO3QXgB
         IT3GNJ/XTNaQmynlENUewj/NoQ/+uCxIbQHbuGwEOm0fBR771YftmjCGJPRn3p+B/WiE
         bPvA==
X-Gm-Message-State: AOAM5320hJA+IKNvinEITqXtLv0JiBadsXZglfkYNA0X8vWa0Q+slMo9
        wo24oGNJ9+yijAERjmDRUntZ3LGmF9V2
X-Google-Smtp-Source: ABdhPJzHRNZd5EhZSnbcQtXKR/APGGTIuoWFxvAnS4JS26qf1ecJcj/ivbvmXQwQhBUKnAOrRikqSg==
X-Received: by 2002:ac8:729a:: with SMTP id v26mr19712883qto.362.1596504836522;
        Mon, 03 Aug 2020 18:33:56 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id y7sm24381975qta.36.2020.08.03.18.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:33:55 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 06/18] xen_statements: fully convert to
 markdown
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:33:55 -0400
Message-ID: <159650483517.8961.12011786927723219806.stgit@sifl>
In-Reply-To: <159650470076.8961.12721446818345626943.stgit@sifl>
References: <159650470076.8961.12721446818345626943.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/xen_statements.md |  340 +++++++++++++++++--------------------------------
 1 file changed, 119 insertions(+), 221 deletions(-)

diff --git a/src/xen_statements.md b/src/xen_statements.md
index ce968de..5688893 100644
--- a/src/xen_statements.md
+++ b/src/xen_statements.md
@@ -1,12 +1,12 @@
 # Xen Statements
 
-Xen policy supports additional policy language statements: `iomemcon`,
-`ioportcon`, `pcidevicecon`, `pirqcon` and `devicetreecon` that are
+Xen policy supports additional policy language statements: *iomemcon*,
+*ioportcon*, *pcidevicecon*, *pirqcon* and *devicetreecon* that are
 discussed in the sections that follow, also the
 [**XSM/FLASK Configuration**](http://xenbits.xen.org/docs/4.2-testing/misc/xsm-flask.txt)
 document contains further information.
 
-Policy version 30 introduced the `devicetreecon` statement and also
+Policy version 30 introduced the *devicetreecon* statement and also
 expanded the existing I/O memory range to 64 bits in order to support
 hardware with more than 44 bits of physical address space (32-bit count
 of 4K pages).
@@ -14,9 +14,7 @@ of 4K pages).
 To compile these additional statements using ***semodule**(8)*, ensure
 that the ***semanage.conf**(5)* file has the *policy-target=xen* entry.
 
-<br>
-
-## `iomemcon`
+## *iomemcon*
 
 Label i/o memory. This may be a single memory location or a range.
 
@@ -26,50 +24,32 @@ Label i/o memory. This may be a single memory location or a range.
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>iomemcon</code></td>
-<td>The <code>iomemcon</code> keyword.</td>
-</tr>
-<tr>
-<td><code>addr</code></td>
-<td>The memory address to apply the context. This may also be a range that consists of a start and end address separated by a hypen '-'.</td>
-</tr>
-<tr>
-<td><code>context</code></td>
-<td>The security context to be applied.</td>
-</tr>
-</tbody>
-</table>
+*iomemcon*
+
+The *iomemcon* keyword.
+
+*addr*
 
+The memory address to apply the context. This may also be a range that consists
+of a start and end address separated by a hypen \'-\'.
+
+*context*
+
+The security context to be applied.
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
+
+Conditional Policy Statements
+
+| *if* statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | No                      | No                      |
 
 **Examples:**
 
@@ -78,9 +58,7 @@ iomemcon 0xfebd9 system_u:object_r:nicP_t
 iomemcon 0xfebe0-0xfebff system_u:object_r:nicP_t
 ```
 
-<br>
-
-## `ioportcon`
+## *ioportcon*
 
 Label i/o ports. This may be a single port or a range.
 
@@ -90,49 +68,32 @@ Label i/o ports. This may be a single port or a range.
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>ioportcon</code></td>
-<td>The <code>ioportcon</code> keyword.</td>
-</tr>
-<tr>
-<td><code>port</code></td>
-<td>The <code>port</code> to apply the context. This may also be a range that consists of a start and end port number separated by a hypen '-'.</td>
-</tr>
-<tr>
-<td><code>context</code></td>
-<td>The security context to be applied.</td>
-</tr>
-</tbody>
-</table>
+*ioportcon*
+
+The *ioportcon* keyword.
+
+*port*
+
+The *port* to apply the context. This may also be a range that consists of a
+start and end port number separated by a hypen \'-\'.
+
+*context*
+
+The security context to be applied.
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
+
+Conditional Policy Statements
+
+| *if* statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | No                      | No                      |
 
 **Examples:**
 
@@ -141,9 +102,7 @@ ioportcon 0xeac0 system_u:object_r:nicP_t
 ioportcon 0xecc0-0xecdf system_u:object_r:nicP_t
 ```
 
-<br>
-
-## `pcidevicecon`
+## *pcidevicecon*
 
 Label a PCI device.
 
@@ -153,57 +112,37 @@ Label a PCI device.
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>pcidevicecon</code></td>
-<td>The <code>pcidevicecon</code> keyword.</td>
-</tr>
-<tr>
-<td><code>pci_id</code></td>
-<td>The PCI indentifer.</td>
-</tr>
-<tr>
-<td><code>context</code></td>
-<td>The security context to be applied.</td>
-</tr>
-</tbody>
-</table>
+*pcidevicecon*
+
+The *pcidevicecon* keyword.
+
+*pci_id*
+
+The PCI indentifer.
+
+*context*
+
+The security context to be applied.
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
+
+Conditional Policy Statements
+
+| *if* statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | No                      | No                      |
 
 **Example:**
 
 `pcidevicecon 0xc800 system_u:object_r:nicP_t`
 
-<br>
-
-## `pirqcon`
+## *pirqcon*
 
 Label an interrupt level.
 
@@ -213,57 +152,37 @@ Label an interrupt level.
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>pirqcon</code></td>
-<td>The <code>pirqcon</code> keyword.</td>
-</tr>
-<tr>
-<td><code>irq</code></td>
-<td>The interrupt request number.</td>
-</tr>
-<tr>
-<td><code>context</code></td>
-<td>The security context to be applied.</td>
-</tr>
-</tbody>
-</table>
+*pirqcon*
+
+The *pirqcon* keyword.
+
+*irq*
+
+The interrupt request number.
+
+*context*
+
+The security context to be applied.
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
+
+Conditional Policy Statements
+
+| *if* statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | No                      | No                      |
 
 **Example:**
 
 `pirqcon 33 system_u:object_r:nicP_t`
 
-<br>
-
-## `devicetreecon`
+## *devicetreecon*
 
 Label device tree nodes.
 
@@ -273,57 +192,36 @@ Label device tree nodes.
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>devicetreecon</code></td>
-<td>The <code>devicetreecon</code> keyword.</td>
-</tr>
-<tr>
-<td><code>path</code></td>
-<td>The device tree path. If this contains spaces enclose within <em>""</em> as shown in the example.</td>
-</tr>
-<tr>
-<td><code>context</code></td>
-<td>The security context to be applied.</td>
-</tr>
-</tbody>
-</table>
+*devicetreecon*
+
+The *devicetreecon* keyword.
+
+*path*
+
+The device tree path. If this contains spaces enclose within *""* as shown in
+the example.
+
+*context*
+
+The security context to be applied.
 
 **The statement is valid in:**
 
-<table style="text-align:center">
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Monolithic Policy</strong></td>
-<td><strong>Base Policy</strong></td>
-<td><strong>Module Policy</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>No</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
 
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
 
-**Example:**
+Conditional Policy Statements
 
-`devicetreecon "/this is/a/path" system_u:object_r:arm_path`
+| *if* statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | No                      | No                      |
 
+**Example:**
 
-<br>
+`devicetreecon "/this is/a/path" system_u:object_r:arm_path`
 
 <!-- %CUTHERE% -->
 

