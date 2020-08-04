Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BC0C433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 07:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E3B22B45
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 07:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="GTKId4k0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgHDHd1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgHDHd1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Aug 2020 03:33:27 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3221BC06174A
        for <selinux@vger.kernel.org>; Tue,  4 Aug 2020 00:33:27 -0700 (PDT)
Received: from localhost.localdomain (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id EA3892A0FFC;
        Tue,  4 Aug 2020 09:33:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl EA3892A0FFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1596526406;
        bh=ypXZChHnTxk82amdU7XfWKAiaZlRNVcJ1ZeXEtNLv10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTKId4k0EQJllaaXnvAYd31rYMQ13cc+tOR8eE7yajn3itbEmdfG+VZYnTu0zwKkB
         rCLgqgsbUdvgYkqphIJjb7a7MrhfBKgFgj9+T5nutCmVEc7Cr/K9fr8AtYKLWtS1KK
         sJii/edQZcRMsQR8p/dXXCnnxGROxw3MZOKnG1c8=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH v5] type_statements: document expandattribute
Date:   Tue,  4 Aug 2020 09:33:10 +0200
Message-Id: <20200804073310.195204-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CAP+JOzTwCBB=_Ssd5=dTWcPcPX40LWBk1bn6c4gnc=4YgMvYTQ@mail.gmail.com>
References: <CAP+JOzTwCBB=_Ssd5=dTWcPcPX40LWBk1bn6c4gnc=4YgMvYTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This functionality was added for Androids Treble in 2017.

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
v2: change expandtypeattribute to expandattribute
v3: overriden is overridden
v4: convert to markdown
v5: copied and pasted description from James Carter and changed default_value to expand_value

 src/type_statements.md | 690 ++++++++++++++++++-----------------------
 1 file changed, 299 insertions(+), 391 deletions(-)

diff --git a/src/type_statements.md b/src/type_statements.md
index 61c7191..779e22a 100644
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
 
@@ -199,11 +164,65 @@ attribute file_type;
 attribute non_security_file_type;
 ```
 
-<br>
+## *expandattribute*
+
+The *expandattribute* statement gives more control over type attribute
+expansion and removal. When the value is true, all rules involving the
+type attribute will be expanded and the type attribute will be removed
+from the policy. When the value is false, the type attribute will not be
+removed from the policy, even if the default expand rules cause the
+rules involving the type attribute to be expanded.
+
+**The statement definition is:**
+
+`expandattribute attribute_id expand_value;`
+
+**Where:**
+
+*expandattribute*
+
+The *expandattribute* keyword.
 
-## `typeattribute`
+*attribute_id*
 
-The `typeattribute` statement allows the association of previously
+One or more *attribute* identifiers that have been previously declared by the
+[*attribute*](#attribute) statement. Multiple entries consist of a space
+separated list enclosed in braces '{}'.
+
+*expand_value*
+
+Either true or false.
+
+**The statement is valid in:**
+
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
+
+**Examples:**
+
+```
+# Using the expandattribute statement to forcibly expand a
+# previously declared domain attribute.
+
+# The previously declared attribute:
+attribute domain;
+
+# The attribute stripping using the expandattribute statement:
+expandattribute domain true;
+```
+
+## *typeattribute*
+
+The *typeattribute* statement allows the association of previously
 declared types to one or more previously declared attributes.
 
 **The statement definition is:**
@@ -212,49 +231,32 @@ declared types to one or more previously declared attributes.
 
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
 
@@ -289,13 +291,11 @@ type setroubleshootd_exec_t;
 typeattribute setroubleshootd_exec_t file_type, non_security_file_type;
 ```
 
-<br>
+## *typealias*
 
-## `typealias`
-
-The `typealias` statement allows the association of a previously declared
-`type` to one or more `alias` identifiers (an alternative way is to use the
-`type` statement.
+The *typealias* statement allows the association of a previously declared
+*type* to one or more *alias* identifiers (an alternative way is to use the
+*type* statement.
 
 **The statement definition is:**
 
@@ -303,53 +303,36 @@ The `typealias` statement allows the association of a previously declared
 
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
 
@@ -374,14 +357,12 @@ type netif_t;
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
@@ -390,45 +371,27 @@ policy denial.
 
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
 
@@ -463,16 +426,13 @@ require {
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
@@ -486,59 +446,46 @@ however, this is only appropriate for the file classes:
 
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
 
@@ -607,14 +554,12 @@ type_transition unconfined_t etc_t : file system_conf_t eric;
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
@@ -625,55 +570,38 @@ section for more details.
 
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
 
@@ -694,15 +622,13 @@ type_change auditadm_t sysadm_devpts_t:chr_file auditadm_devpts_t;
 type_change staff_t server_ptynode:chr_file staff_devpts_t;
 ```
 
-<br>
+## *type_member*
 
-## `type_member`
-
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
@@ -713,55 +639,40 @@ section for more details.
 
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
 
@@ -774,9 +685,6 @@ section for more details.
 type_member sysadm_t user_home_dir_t:dir user_home_dir_t;
 ```
 
-
-<br>
-
 <!-- %CUTHERE% -->
 
 ---
-- 
2.28.0

