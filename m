Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC1DC433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F1C20781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="cNuCFYbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgHDBeZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBeY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:34:24 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965B0C06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:34:24 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id e5so15769288qth.5
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=4cQtGvsT8Go6Zn/weMpUhNjSrl8eTd6dCwY1+RJZW+I=;
        b=cNuCFYbVfCWCF6sGCa04FDnl2Q6dw8KGJU2z75wznkcCeIesJGl2LxP1g8RMuTJrek
         LzeOZuNxN536Gjb2cKHLSp0050V1BqbL00ZRmrQhXLi8gNq57B0V6rJl8eOH7yM358NN
         fPSO9dejHLth4eKRjUNGH18e1bPM5TLXbLd1plx0uKt4ib5yGzjpl/qE1hENDfrqhvZh
         GeA2aKQ9tW35iTuXwNj7RENxgaT+BNHy7MyDrANwnWzN0OPNZDayLNODh+zqy8UXCHVY
         ZOb/YalGXZ2IgXX11iRtoy3c1U8pbJbLc1oDTNsMjmbCDECXjrnzIVCpMgIidQmnPkAt
         3GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4cQtGvsT8Go6Zn/weMpUhNjSrl8eTd6dCwY1+RJZW+I=;
        b=hlg0BxxvneX+bQAWJ/wUtfh908tr1lPoZCvxrPBkBN2oW/ZJYoit322q1dl/IqyLqm
         832j6XwlHkYkL6+FPDKapPcY64gbiPoy6xTz7QVXfGdFarWWzrKJBrTXHKfuyT7JUiPf
         B0pv0PKxavuM0wd23fLnP2//FWIlK8lMO0MZKT85dx+edJaRsai89UfPrE33lRnfo/2Q
         7roR8eNdrXWSgRScYyRLgU+V+qte/tN3WqBBw5SkiRVIKs1K1wwWpr1wOspI2+k5qJ4i
         h0JFSSgP8WMxeKp64iGAAefvVtRt7uDRYXg4z/4MeHxTinIMmoHSSp7sYp2e7TcHX8px
         JixQ==
X-Gm-Message-State: AOAM533WseeKeHBXl5tz9J095SLhoF4sXz1D5fOLsMQkbfcNHTxG4Pel
        +Syj4fgqUECPGYBGjfW+u9LQ2zHlejJ2
X-Google-Smtp-Source: ABdhPJzIR5LnmG61hOk/JPS7uDt59wswEsThj3RK4XJZyhnNZ7tOrRfyTpqaEzAfaxHv3+HMPCmTAg==
X-Received: by 2002:ac8:5254:: with SMTP id y20mr19376796qtn.170.1596504862581;
        Mon, 03 Aug 2020 18:34:22 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id 141sm16272005qke.41.2020.08.03.18.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:34:21 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 10/18] type_statements: fully convert to
 markdown
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:34:21 -0400
Message-ID: <159650486128.8961.860004757295092365.stgit@sifl>
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
 src/type_statements.md |  636 ++++++++++++++++++------------------------------
 1 file changed, 244 insertions(+), 392 deletions(-)

diff --git a/src/type_statements.md b/src/type_statements.md
index 61c7191..76dedab 100644
--- a/src/type_statements.md
+++ b/src/type_statements.md
@@ -1,7 +1,7 @@
 # Type Statements
 
 These statements share the same namespace, therefore the general
-convention is to use `_t` as the final two characters of a type
+convention is to use *_t* as the final two characters of a type
 identifier to differentiate it from an attribute identifier as shown in
 the following examples:
 
@@ -13,12 +13,10 @@ type bin_t;              # A type identifier generally ends with _t
 attribute file_type;     # An attribute identifier generally ends with _type
 ```
 
-<br>
+## *type*
 
-## `type`
-
-The `type` statement declares the type identifier and any optional
-associated `alias` or `attribute` identifiers. Type identifiers are a
+The *type* statement declares the type identifier and any optional
+associated *alias* or *attribute* identifiers. Type identifiers are a
 component of the [**Security Context**](security_context.md#security-context).
 
 **The statement definition is:**
@@ -27,57 +25,44 @@ component of the [**Security Context**](security_context.md#security-context).
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>type</code></td>
-<td>The <code>type</code> keyword.</td>
-</tr>
-<tr>
-<td><code>type_id</code></td>
-<td>The <code>type</code> identifier.</td>
-</tr>
-<tr>
-<td><code>alias</code></td>
-<td>Optional <code>alias</code> keyword that signifies alternate identifiers for the <code>type_id</code> that are declared in the <code>alias_id</code> list.</td>
-</tr>
-<tr>
-<td><code>alias_id</code></td>
-<td>One or more <code>alias</code> identifiers that have been previously declared by the <a href="#typealias"><code>typealias</code></a> statement. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td><code>attribute_id</code></td>
-<td>One or more optional <code>attribute</code> identifiers that have been previously declared by the <a href="#attribute"><code>attribute</code></a> statement. Multiple entries consist of a comma ',' separated list, also note the lead comma.</td>
-</tr>
-</tbody>
-</table>
+*type*
+
+The *type* keyword.
+
+*type_id*
+
+The *type* identifier.
+
+*alias*
+
+Optional *alias* keyword that signifies alternate identifiers for the *type_id*
+that are declared in the *alias_id* list.
+
+*alias_id*
+
+One or more *alias* identifiers that have been previously declared by the
+[*typealias*](#typealias) statement. Multiple entries consist of a space
+separated list enclosed in braces '{}'.
+
+*attribute_id*
+
+One or more optional *attribute* identifiers that have been previously declared
+by the [*attribute*](#attribute) statement. Multiple entries consist of a comma
+',' separated list, also note the lead comma.
 
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
-<td>Yes</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>Yes</td>
-<td>Yes</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | Yes                     |
+
+Conditional Policy Statements
+
+| *if* statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | Yes                     | Yes                     |
 
 **Examples:**
 
@@ -134,12 +119,10 @@ attribute server_packet_type; # declare attribute 2
 type ssh_server_packet_t, packet_type, server_packet_type;
 ```
 
-<br>
-
-## `attribute`
+## *attribute*
 
-An `attribute` statement declares an identifier that can then be used to
-refer to a group of `type` identifiers.
+An *attribute* statement declares an identifier that can then be used to
+refer to a group of *type* identifiers.
 
 **The statement definition is:**
 
@@ -147,45 +130,27 @@ refer to a group of `type` identifiers.
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>attribute</code></td>
-<td>The <code>attribute</code> keyword.</td>
-</tr>
-<tr>
-<td><code>attribute_id</code></td>
-<td>The <code>attribute</code> identifier.</td>
-</tr>
-</tbody>
-</table>
+*attribute*
+
+The *attribute* keyword.
+
+*attribute_id*
+
+The *attribute* identifier.
 
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
-<td>Yes</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>Yes</td>
-<td>Yes</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | Yes                     |
+
+Conditional Policy Statements
+
+| *if* statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | Yes                     | Yes                     |
 
 **Examples:**
 
@@ -199,11 +164,9 @@ attribute file_type;
 attribute non_security_file_type;
 ```
 
-<br>
-
-## `typeattribute`
+## *typeattribute*
 
-The `typeattribute` statement allows the association of previously
+The *typeattribute* statement allows the association of previously
 declared types to one or more previously declared attributes.
 
 **The statement definition is:**
@@ -212,49 +175,32 @@ declared types to one or more previously declared attributes.
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>typeattribute</code></td>
-<td>The <code>typeattribute</code> keyword.</td>
-</tr>
-<tr>
-<td><code>type_id</code></td>
-<td>The identifier of a previously declared <code>type</code>.</td>
-</tr>
-<tr>
-<td><code>attribute_id</code></td>
-<td>One or more previously declared <code>attribute</code> identifiers. Multiple entries consist of a comma ',' separated list.</td>
-</tr>
-</tbody>
-</table>
+*typeattribute*
+
+The *typeattribute* keyword.
+
+*type_id*
+
+The identifier of a previously declared *type*.
+
+*attribute_id*
+
+One or more previously declared *attribute* identifiers. Multiple entries
+consist of a comma ',' separated list.
 
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
-<td>Yes</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | Yes                     |
+
+Conditional Policy Statements
+
+| *if* statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | Yes                     | No                      |
 
 **Examples:**
 
@@ -289,13 +235,11 @@ type setroubleshootd_exec_t;
 typeattribute setroubleshootd_exec_t file_type, non_security_file_type;
 ```
 
-<br>
-
-## `typealias`
+## *typealias*
 
-The `typealias` statement allows the association of a previously declared
-`type` to one or more `alias` identifiers (an alternative way is to use the
-`type` statement.
+The *typealias* statement allows the association of a previously declared
+*type* to one or more *alias* identifiers (an alternative way is to use the
+*type* statement.
 
 **The statement definition is:**
 
@@ -303,53 +247,36 @@ The `typealias` statement allows the association of a previously declared
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>typealias</code></td>
-<td>The <code>typealias</code> keyword.</td>
-</tr>
-<tr>
-<td><code>type_id</code></td>
-<td>The identifier of a previously declared <code>type</code>.</td>
-</tr>
-<tr>
-<td><code>alias</code></td>
-<td>The <code>alias</code> keyword.</td>
-</tr>
-<tr>
-<td><code>alias_id</code></td>
-<td>One or more <code>alias</code> identifiers. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-</tbody>
-</table>
+*typealias*
+
+The *typealias* keyword.
+
+*type_id*
+
+The identifier of a previously declared *type*.
+
+*alias*
+
+The *alias* keyword.
+
+*alias_id*
+
+One or more *alias* identifiers. Multiple entries consist of a space separated
+list enclosed in braces '{}'.
 
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
-<td>Yes</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | Yes                     |
+
+Conditional Policy Statements
+
+| *if* statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | Yes                     | No                      |
 
 **Examples:**
 
@@ -374,14 +301,12 @@ type netif_t;
 typealias netif_t alias { lo_netif_t netif_lo_t };
 ```
 
-<br>
+## *permissive*
 
-## `permissive`
-
-Policy version 23 introduced the `permissive` statement to allow the named
+Policy version 23 introduced the *permissive* statement to allow the named
 domain to run in permissive mode instead of running all SELinux domains
 in permissive mode (that was the only option prior to version 23). Note
-that the `permissive` statement only tests the source context for any
+that the *permissive* statement only tests the source context for any
 policy denial.
 
 **The statement definition is:**
@@ -390,45 +315,27 @@ policy denial.
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>permissive</code></td>
-<td>The <code>permissive</code> keyword.</td>
-</tr>
-<tr>
-<td><code>type_id</code></td>
-<td>The <code>type</code> identifier of the domain that will be run in permissive mode.</td>
-</tr>
-</tbody>
-</table>
+*permissive*
+
+The *permissive* keyword.
+
+*type_id*
+
+The *type* identifier of the domain that will be run in permissive mode.
 
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
-<td>Yes</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>No</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | Yes                     |
+
+Conditional Policy Statements
+
+| *if* statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| No                      | Yes                     | No                      |
 
 **Examples:**
 
@@ -463,16 +370,13 @@ require {
 permissive unconfined_t;
 ```
 
-<br>
-
-
-## `type_transition`
+## *type_transition*
 
 The type_transition rule specifies the default type to be used for
 domain transistion or object creation. Kernels from 2.6.39 with Policy
 versions from 25 also support the 'name transition rule' extension. See the
 [**Computing Security Contexts**](computing_security_contexts.md#computing-security-contexts)
-section for more details. Note than an `allow` rule must be used to authorise
+section for more details. Note than an *allow* rule must be used to authorise
 the transition.
 
 **The statement definitions are:**
@@ -486,59 +390,46 @@ however, this is only appropriate for the file classes:
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>type_transition</code></td>
-<td>The <code>type_transition</code> rule keyword.</td>
-</tr>
-<tr>
-<td><p><code>source_type</code></p>
-<p><code>target_type</code></p></td>
-<td><p>One or more source / target <code>type</code>, <code>typealias</code> or <code>attribute</code> identifiers. Multiple entries consist of a space separated list enclosed in braces '{}'. </p>
-<p>Entries can be excluded from the list by using the negative operator '-'.</p></td>
-</tr>
-<tr>
-<td><code>class</code></td>
-<td>One or more object classes. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td><code>default_type</code></td>
-<td>A single <code>type</code> or <code>typealias</code> identifier that will become the default process <code>type</code> for a domain transition or the <code>type</code> for object transitions.</td>
-</tr>
-<tr>
-<td><code>object_name<code></td>
-<td>For the 'name transition' rule this is matched against the objects name (i.e. the last component of a path). If <code>object_name</code> exactly matches the object name, then use <code>default_type</code> for the <code>type</code>.</td>
-</tr>
-</tbody>
-</table>
+*type_transition*
+
+The *type_transition* rule keyword.
+
+*source_type*
+*target_type*
+
+One or more source / target *type*, *typealias* or *attribute* identifiers.
+Multiple entries consist of a space separated list enclosed in braces '{}'.
+Entries can be excluded from the list by using the negative operator '-'.
+
+*class*
+
+One or more object classes. Multiple entries consist of a space separated list
+enclosed in braces '{}'.
+
+*default_type*
+
+A single *type* or *typealias* identifier that will become the default process
+*type* for a domain transition or the *type* for object transitions.
+
+*object_name*
+
+For the 'name transition' rule this is matched against the objects name
+(i.e. the last component of a path). If *object_name* exactly matches the
+object name, then use *default_type* for the *type*.
 
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
-<td>Yes</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | Yes                     |
+
+Conditional Policy Statements
+
+| *if* statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
 
 **Example - Domain Transition:**
 
@@ -607,14 +498,12 @@ type_transition unconfined_t etc_t : file system_conf_t eric;
 # an exact strcmp) it should be labeled system_conf_t.
 ```
 
-<br>
+## *type_change*
 
-## `type_change`
-
-The `type_change` rule specifies a default `type` when relabeling an
+The *type_change* rule specifies a default *type* when relabeling an
 existing object. For example userspace SELinux-aware applications would
-use ***security_compute_relabel**(3)* and `type_change` rules in
-policy to determine the new context to be applied. Note that an `allow`
+use ***security_compute_relabel**(3)* and *type_change* rules in
+policy to determine the new context to be applied. Note that an *allow*
 rule must be used to authorise access. See the
 [**Computing Security Contexts**](computing_security_contexts.md#computing-security-contexts)
 section for more details.
@@ -625,55 +514,38 @@ section for more details.
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>type_change</code></td>
-<td>The <code>type_change</code> rule keyword.</td>
-</tr>
-<tr>
-<td><p><code>source_type</code></p>
-<p><code>target_type</code></p></td>
-<td><p>One or more source / target <code>type</code>, <code>typealias</code> or <code>attribute</code> identifiers. Multiple entries consist of a space separated list enclosed in braces '{}'. </p>
-<p>Entries can be excluded from the list by using the negative operator '-'.</p></td>
-</tr>
-<tr>
-<td><code>class</code></td>
-<td>One or more object classes. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td><code>change_type</code></td>
-<td>A single <code>type</code> or <code>typealias</code> identifier that will become the new <code>type</code>. </td>
-</tr>
-</tbody>
-</table>
+*type_change*
+
+The *type_change* rule keyword.
+
+*source_type*
+*target_type*
+
+One or more source / target *type*, *typealias* or *attribute* identifiers.
+Multiple entries consist of a space separated list enclosed in braces '{}'.
+Entries can be excluded from the list by using the negative operator '-'.
+
+*class*
+
+One or more object classes. Multiple entries consist of a space separated list
+enclosed in braces '{}'.
+
+*change_type*
+A single *type* or *typealias* identifier that will become the new *type*. 
 
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
-<td>Yes</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | Yes                     |
+
+Conditional Policy Statements
+
+| *if* statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
 
 **Examples:**
 
@@ -694,15 +566,13 @@ type_change auditadm_t sysadm_devpts_t:chr_file auditadm_devpts_t;
 type_change staff_t server_ptynode:chr_file staff_devpts_t;
 ```
 
-<br>
-
-## `type_member`
+## *type_member*
 
-The `type_member` rule specifies a default type when creating a
+The *type_member* rule specifies a default type when creating a
 polyinstantiated object. For example a userspace SELinux-aware
 application would use ***avc_compute_member**(3)* or
-***security_compute_member**(3)* with `type_member` rules in policy
-to determine the context to be applied. Note that an `allow` rule must
+***security_compute_member**(3)* with *type_member* rules in policy
+to determine the context to be applied. Note that an *allow* rule must
 be used to authorise access. See the
 [**Computing Security Contexts**](computing_security_contexts.md#computing-security-contexts)
 section for more details.
@@ -713,55 +583,40 @@ section for more details.
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td><code>type_member</code></td>
-<td>The <code>type_member</code> rule keyword.</td>
-</tr>
-<tr>
-<td><p><code>source_type</code></p>
-<p><code>target_type</code></p></td>
-<td><p>One or more source / target <code>type</code>, <code>typealias</code> or <code>attribute</code> identifiers. Multiple entries consist of a space separated list enclosed in braces '{}'. </p>
-<p>Entries can be excluded from the list by using the negative operator '-'.</p></td>
-</tr>
-<tr>
-<td><code>class</code></td>
-<td>One or more object classes. Multiple entries consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td><code>member_type</code></td>
-<td>A single <code>type</code> or <code>typealias</code> identifier that will become the polyinstantiated <code>type</code>. </td>
-</tr>
-</tbody>
-</table>
+*type_member*
+
+The *type_member* rule keyword.
+
+*source_type*
+*target_type*
+
+One or more source / target *type*, *typealias* or *attribute* identifiers.
+Multiple entries consist of a space separated list enclosed in braces '{}'. 
+Entries can be excluded from the list by using the negative operator '-'.
+
+*class*
+
+One or more object classes. Multiple entries consist of a space separated list
+enclosed in braces '{}'.
+
+*member_type*
+
+A single *type* or *typealias* identifier that will become the polyinstantiated
+*type*. 
 
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
-<td>Yes</td>
-</tr>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Conditional Policy <code>if</code> Statement</strong></td>
-<td><strong><code>optional</code> Statement</strong></td>
-<td><strong><code>require</code> Statement</strong></td>
-</tr>
-<tr>
-<td>Yes</td>
-<td>Yes</td>
-<td>No</td>
-</tr>
-</tbody>
-</table>
+Policy Type
+
+| Monolithic Policy       | Base Policy             | Module Policy           |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | Yes                     |
+
+Conditional Policy Statements
+
+| *if* statement          | *optional* Statement    | *require* Statement     |
+| ----------------------- | ----------------------- | ----------------------- |
+| Yes                     | Yes                     | No                      |
 
 **Example:**
 
@@ -774,9 +629,6 @@ section for more details.
 type_member sysadm_t user_home_dir_t:dir user_home_dir_t;
 ```
 
-
-<br>
-
 <!-- %CUTHERE% -->
 
 ---

