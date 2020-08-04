Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32560C433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3345D20781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="YdeAf4SF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgHDBeR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBeR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:34:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E7EC06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:34:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so37104994qka.3
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=lVx6mAURfTh2WbJI3ubOjiDwwCUM1ESb/nZaInqk12A=;
        b=YdeAf4SFdKOaaDN5ILJUQNlmYKrA+gypeCHz5aA5xPcvzfMShQJLJysPNLQotwjc+E
         eE39ySqF5VDtzvTS6gbZ5eMY/cCklRRcQOr7v520Wwm4JFvM4yVHumUXYCZ4JsFiE4rS
         hU7Ic/+szET5XSv2AKtDYIff/wM71cCMFopL+de6TFJU293B0+ztV8sZbvHuV1jb+TN6
         1tYg49gD1ok//UIo+uJ+qGKbB9i5mZhdTE625eiGF5o/6qVzpP8aI6sSnB3P2dlJcdR4
         mVJF/BVl+HhFLmKbI4G/4eCT2zKjgY7ku7jeljh5iKkaHX33K9Ec/DrNtBQAbh1XWsLR
         ePdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lVx6mAURfTh2WbJI3ubOjiDwwCUM1ESb/nZaInqk12A=;
        b=ZwPCbnZVQSk4EIoWMroKMz6/oS9uUMTx3BFptTbEQu5NlWXNyZfQ6JK4oX53dKWRUk
         n6ZrxJ1iF65FpSgTf8sWSRoSJcZs4ax/N36OJ24EGT1tUsj692zGve9Vq3cruKBH7qqL
         0MBBcnMfvgkH6f/s1fX3eIbl7lAC0VilUzY53iU983cQsWmE+w7IcSemh+Zo12FY3JDH
         fUONG+etHznlinrdc7Ieygf2OL8276x9m4qAZ5NFn1CQddCAKOGNEp8R7pRcMpY1+7ko
         7rnR4bSHtmdovFD9cIKhubOIEiok3rGodxZH+kH4q9SiX/fJ7igZ6x+y7HbsVGYpF/Be
         E4JQ==
X-Gm-Message-State: AOAM532CsF3YswdgP3g6/+EWvMuv80xzktqXo7WPKsUR5FwM/+1Hu/cz
        TWehjm4ngwjIyoaw4qeC2tZEMI+2EtyV
X-Google-Smtp-Source: ABdhPJxw+Rz2i6V8LxNpe8POYAAU42Iu4gqTveHJyUJYSf5HBG3KJGgwsHjGgcDWHH7iGl8/gtD/kQ==
X-Received: by 2002:a05:620a:152d:: with SMTP id n13mr18057163qkk.43.1596504856063;
        Mon, 03 Aug 2020 18:34:16 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id z72sm22314633qka.107.2020.08.03.18.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:34:15 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 09/18] userspace_libraries: fully convert
 to markdown
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:34:14 -0400
Message-ID: <159650485462.8961.1637559132596567367.stgit@sifl>
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
 src/userspace_libraries.md |  161 +++++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 92 deletions(-)

diff --git a/src/userspace_libraries.md b/src/userspace_libraries.md
index 26ed38d..6db6bb7 100644
--- a/src/userspace_libraries.md
+++ b/src/userspace_libraries.md
@@ -11,8 +11,6 @@ source code are available at:
 
 <https://github.com/SELinuxProject/selinux/wiki>
 
-<br>
-
 ## libselinux Library
 
 *libselinux* contains all the SELinux functions necessary to build
@@ -29,91 +27,77 @@ The library hides the low level functionality of (but not limited to):
     associated to files, sockets etc. - see ***attr**(5)*.
 -   The SELinux policy and its associated configuration files.
 
-The general category of functions available in *libselinux* are shown in
-**Table 1: libselinux function types**, with
-[**Appendix B - `libselinux` API Summary**](libselinux_functions.md#appendix-b---libselinux-api-summary)
+The general category of functions available in *libselinux* are shown below,
+with [**Appendix B - `libselinux` API Summary**](libselinux_functions.md#appendix-b---libselinux-api-summary)
 giving a complete list of functions.
 
-<table>
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Function Category</strong></td>
-<td><strong>Description</strong></td>
-</tr>
-<tr>
-<td>Access Vector Cache Services</td>
-<td>Allow access decisions to be cached and audited. </td>
-</tr>
-<tr>
-<td>Boolean Services</td>
-<td>Manage booleans.</td>
-</tr>
-<tr>
-<td>Class and Permission Management</td>
-<td>Class / permission string conversion and mapping.</td>
-</tr>
-<tr>
-<td>Compute Access Decisions</td>
-<td>Determine if access is allowed or denied.</td>
-</tr>
-<tr>
-<td>Compute Labeling</td>
-<td>Compute labels to be applied to new instances of on object.</td>
-</tr>
-<tr>
-<td>Default File Labeling</td>
-<td>Obtain default contexts for file operations.</td>
-</tr>
-<tr>
-<td>File Creation Labeling </td>
-<td>Get and set file creation contexts.</td>
-</tr>
-<tr>
-<td>File Labeling</td>
-<td>Get and set file and file descriptor extended attributes.</td>
-</tr>
-<tr>
-<td>General Context Management</td>
-<td>Check contexts are valid, get and set context components.</td>
-</tr>
-<tr>
-<td>Key Creation Labeling </td>
-<td>Get and set kernel key creation contexts.</td>
-</tr>
-<tr>
-<td>Label Translation Management </td>
-<td>Translate to/from, raw/readable contexts.</td>
-</tr>
-<tr>
-<td>Netlink Services</td>
-<td>Used to detect policy reloads and enforcement changes.</td>
-</tr>
-<tr>
-<td>Process Labeling </td>
-<td>Get and set process contexts.</td>
-</tr>
-<tr>
-<td>SELinux Management Services</td>
-<td>Load policy, set enforcement mode, obtain SELinux configuration information.</td>
-</tr>
-<tr>
-<td>SELinux-aware Application Labeling</td>
-<td>Retrieve default contexts for applications such as database and X-Windows. </td>
-</tr>
-<tr>
-<td>Socket Creation Labeling </td>
-<td>Get and set socket creation contexts.</td>
-</tr>
-<tr>
-<td>User Session Management</td>
-<td>Retrieve default contexts for user sessions.</td>
-</tr>
-</tbody>
-</table>
-
-**Table 1: libselinux function types**
-
-<br>
+**Access Vector Cache Services**
+
+Allow access decisions to be cached and audited.
+
+**Boolean Services**
+
+Manage booleans.
+
+**Class and Permission Management**
+
+Class / permission string conversion and mapping.
+
+**Compute Access Decisions**
+
+Determine if access is allowed or denied.
+
+**Compute Labeling**
+
+Compute labels to be applied to new instances of on object.
+
+**Default File Labeling**
+
+Obtain default contexts for file operations.
+
+**File Creation Labeling**
+
+Get and set file creation contexts.
+
+**File Labeling**
+
+Get and set file and file descriptor extended attributes.
+
+**General Context Management**
+
+Check contexts are valid, get and set context components.
+
+**Key Creation Labeling**
+
+Get and set kernel key creation contexts.
+
+**Label Translation Management**
+
+Translate to/from, raw/readable contexts.
+
+**Netlink Services**
+
+Used to detect policy reloads and enforcement changes.
+
+**Process Labeling**
+
+Get and set process contexts.
+
+**SELinux Management Services**
+
+Load policy, set enforcement mode, obtain SELinux configuration information.
+
+**SELinux-aware Application Labeling**
+
+Retrieve default contexts for applications such as database and X-Windows.
+
+**Socket Creation Labeling**
+
+Get and set socket creation contexts.
+
+**User Session Management**
+
+Retrieve default contexts for user sessions.
 
 The *libselinux* functions make use of a number of files within the
 SELinux sub-system:
@@ -141,8 +125,6 @@ There is a static version of the library that is not installed by default:
 
 `dnf install libselinux-static`
 
-<br>
-
 ## libsepol Library
 
 *libsepol* - To build and manipulate the contents of SELinux kernel
@@ -157,14 +139,9 @@ as they require access to functions that are not available in the dynamic
 library (such as sepol_compute_av(), sepol_compute_av_reason() and
 sepol_context_to_sid().
 
-<br>
-
 ## libsemanage Library
 *libsemanage* - To manage the policy infrastructure.
 
-
-<br>
-
 <!-- %CUTHERE% -->
 
 ---

