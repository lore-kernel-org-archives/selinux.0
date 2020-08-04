Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811D0C433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853BE20781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1a70cOVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgHDBeL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgHDBeK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:34:10 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05BBC06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:34:10 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 2so32950555qkf.10
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=/XWmo/lWlCmhtwDZShb3Uw1UiWkXVtk0h6qT7w7htcM=;
        b=1a70cOVWbFxKyIgUrDhyWMipvrtV8Q5CCjlfzz5JRbuJwxlRX5YTEQwNwhExxa30qn
         jpuWOSUyyLMXdPkX1NvWO51dFLE12mTWVcsUDEYE8d2h/xUliKeZfse0sxK+kL8sKoEF
         ApGu+2y+mfoQMykJ7azapk5rLYlhp3X9ahqSTTlPmcJ75XKse7IbYi/+coNu5feMubHd
         ZqJt46R3BoBllhkmWiMvHZwkGtw/+pPmXeW6jclbMJGBow+enOYODGCMjsz00l9yq5A9
         zPAGQxdNqsoIZYoY1LbMV8mrW7hqarzNZgmhviY49nrnwSFOQxP+Dasna1CCZC7EeWKQ
         p80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/XWmo/lWlCmhtwDZShb3Uw1UiWkXVtk0h6qT7w7htcM=;
        b=Yr9+9dUPEfTBHZlYuSXFFINeK9bgkKeWwejejFi6/cCiyi/6uOe8qqtm3ybWjvy/tP
         Y+/GKIePtJpxrMcfUwq9IpDC/OzxBQ8p/E3584sFEpSl608LdjhL5HmFEcTDIAw7ljJq
         qZIh+pAiHAjSG5YVK8gXfq0jQ97MG+tE3HIZx2guSyIBgw94JGEkWGEVJso9NyqyqRas
         9uhw87LJTUkLJ1LGUqxdZo5fe/4FBA4W+0zHRmYYZ6iyFStjd0nHL9Pm/16BPt3qIQlu
         swZ9PV2M+tG20AUHZ27WVKapV6vyYGbb7kITqpPt7PhyYQWuH8Oy2efIz2XQjP2PN7Qb
         7B3g==
X-Gm-Message-State: AOAM532PgLTuW6kN2c3QySod4wrOmFJSMn7gClHSrGYm8Drjip1S13Yj
        iLfCh/nEWHjWdSz+nkXJq8G6NdBxYNS1
X-Google-Smtp-Source: ABdhPJyvEcjvUUVZ6g05hg2O77fem6pEFo5Avm0Hecdq+U3LN2vSVJuUu89UFpwKf0075OKfRl2O/A==
X-Received: by 2002:a37:9f13:: with SMTP id i19mr18131376qke.316.1596504849374;
        Mon, 03 Aug 2020 18:34:09 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id s33sm24886357qtk.11.2020.08.03.18.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:34:08 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 08/18] user_statements: fully convert to
 markdown
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:34:08 -0400
Message-ID: <159650484817.8961.3234655942477723956.stgit@sifl>
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
 src/user_statements.md |  113 ++++++++++++++++++++----------------------------
 1 file changed, 48 insertions(+), 65 deletions(-)

diff --git a/src/user_statements.md b/src/user_statements.md
index cac6181..46f2846 100644
--- a/src/user_statements.md
+++ b/src/user_statements.md
@@ -1,6 +1,6 @@
 # User Statements
 
-## `user`
+## *user*
 
 The user statement declares an SELinux user identifier within the policy
 and associates it to one or more roles. The statement also allows an
@@ -17,73 +17,58 @@ Or for MCS/MLS Policy:
 
 `user seuser_id roles role_id level mls_level range mls_range;`
 
-
 Where:
 
-<table>
-<tbody>
-<tr>
-<td><code>user</code></td>
-<td>The <code>user</code> keyword.</td>
-</tr>
-<tr>
-<td><code>seuser_id</code></td>
-<td>The SELinux user identifier.</td>
-</tr>
-<tr>
-<td><code>roles</code></td>
-<td>The <code>roles</code> keyword.</td>
-</tr>
-<tr>
-<td><code>role_id</code></td>
-<td>One or more previously declared <code>role</code> or <code>attribute_role<code> identifiers. Multiple <code>role</code> identifiers consist of a space separated list enclosed in braces '{}'.</td>
-</tr>
-<tr>
-<td><code>level</code></td>
-<td>If MLS is configured, the MLS <code>level</code> keyword.</td>
-</tr>
-<tr>
-<td><code>mls_level</code></td>
-<td><p>The users default MLS security level that has been previously declared with a <code>level</code> statement</em></em>.</p>
-<p>Note that the compiler only accepts the <code>sensitivity</code> component of the <code>level</code> (e.g. s0).</p></td>
-</tr>
-<tr>
-<td><code>range</code></td>
-<td>If MLS is configured, the MLS <code>range</code> keyword.</td>
-</tr>
-<tr>
-<td><code>mls_range</code></td>
-<td>The range of security levels that the user can run. The format is described in the <a href="mls_statements.md#mls-range-definition">"MLS <code>range</code> Definition"</a> section.</td>
-</tr>
-</tbody>
-</table>
+*user*
+
+The *user* keyword.
+
+*seuser_id*
+
+The SELinux user identifier.
+
+*roles*
+
+The *roles* keyword.
+
+*role_id*
+
+One or more previously declared *role* or *attribute_role* identifiers.
+Multiple *role* identifiers consist of a space separated list enclosed in
+braces '{}'.
+
+*level*
+
+If MLS is configured, the MLS *level* keyword.
+
+*mls_level*
+
+The users default MLS security level that has been previously declared with a
+*level* statement. Note that the compiler only accepts the *sensitivity*
+component of the *level* (e.g. s0).
+
+*range*
+
+If MLS is configured, the MLS *range* keyword.
+
+*mls_range*
+
+The range of security levels that the user can run. The format is described in
+the ["MLS *range* Definition"](mls_statements.md#mls-range-definition) section.
 
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
 
@@ -156,8 +141,6 @@ user mque_u prefix user;
 user mque_u prefix user;
 ```
 
-<br>
-
 <!-- %CUTHERE% -->
 
 ---

