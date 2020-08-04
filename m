Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AACCC433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E96D20786
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="v29EOfJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgHDBfM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBfL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:35:11 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8DCC06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:35:11 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id o22so29553583qtt.13
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=5dWgmW70+/Vqbdm69y5q3AHiArm+HIn4KdvjPt7tW/k=;
        b=v29EOfJrPsfsKl9j3tQV01I6nxHJmXTucIN7Z/Uu+FOuyHfP/cUEgWrp4OlJXBLfEX
         Gd92YF/SENX0JTZSaznRqGM7KC01OHRWLe247OPDqQwDdOG+YUx4fvtCmy9G2ypQ/Ygg
         nnX5G27sVENw4ems/7MBA3asMRMLm65CVUwcD2U94Am1iCJ8WQB7peeygVSEcpMiw+zO
         C27JuDc63WoPDXrVr5y0VYq97M2CvoP7Dsn0zADHRI57BOIdis4RMjT5FyuQUvuevyJb
         ejuRMWqKcczqP7yFdTFSkq8Is2FhrK5XuddLhH9Y4vnc7K1Q/ij96LSnvORanQDZrkqD
         GbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5dWgmW70+/Vqbdm69y5q3AHiArm+HIn4KdvjPt7tW/k=;
        b=Cjsghz7C30uV8Slld2GtNKGpXv+v/zZ7Lwetq8NWkQbxUPxE7fttFUY9GZYUYfhATE
         ZVzNYwvpqw4wHR7mAPX8r8DqXMoi/RXJpsRnvZ8/cLPsqb77oE9/mXU3Q2kbH1P7XsqT
         PoZPapwoor3uvzbB2ak040Y/J30ySOOpT7XEYHxBk2AY48bESy+H2kMnUDBlSk+sJMUu
         72eGdIGTgkBvju6k+N5WCZqXSMAySXf836HJN/Fz3FxcQbO6XzLGj/Ciq5r7eE2OAYBr
         KzaRNUAs/URwe+Ik2p1SK38ep0ekkiWSvIm0A+u6WR/Zx1PWdRVXNGoGXcm19ePXicce
         xtrQ==
X-Gm-Message-State: AOAM533H0nw20+FsGw1TPKT0laNo+2aA/1uwG1eUF2wk6P0i6cH+0yJz
        Drs9Ja4BViXGGZM5S4VGTjdwDDV3jjKS
X-Google-Smtp-Source: ABdhPJyjNsc/O9qMvqn+y4P/bSUbk+JMcQKORJIzd4JyA69E9pm180fwc6HgfDEMd0BBH1ycI6rlJw==
X-Received: by 2002:ac8:b01:: with SMTP id e1mr18697262qti.98.1596504910407;
        Mon, 03 Aug 2020 18:35:10 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id n127sm22596257qke.29.2020.08.03.18.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:35:09 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 17/18] title: assorted updates
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:35:09 -0400
Message-ID: <159650490901.8961.770608607313355868.stgit@sifl>
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

Several small updates to the title page(s), in no particular order:

- Add my name to the copyright list
- Add an acknowledgment to Richard thanking him for donating the
  notebook's source material
- Updated the link for Máirín Duffy
- Provide a link to the GitHub repo so people can find the most
  recent release

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/title.md |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/title.md b/src/title.md
index b218559..5c98d9d 100644
--- a/src/title.md
+++ b/src/title.md
@@ -20,7 +20,9 @@
 
 ## Copyright Information
 
-Copyright © 2020 [*Richard Haines*](mailto:richard_c_haines@btinternet.com).
+Copyright (c) 2020 [*Richard Haines*](mailto:richard_c_haines@btinternet.com)
+
+Copyright (c) 2020 [*Paul Moore*](mailto:paul@paul-moore.com)
 
 Permission is granted to copy, distribute and/or modify this document
 under the terms of the GNU Free Documentation License, Version 1.3 or
@@ -30,7 +32,10 @@ See: **<http://www.gnu.org/licenses/fdl-1.3.html>**
 
 ## Acknowledgements
 
-Logo designed by [*Máirín Duffy*](http://pookstar.deviantart.com/)
+The Notebook was originally created by *Richard Haines* who graciously donated
+the source material to the SELinux project.
+
+The SELinux logo was designed by [*Máirín Duffy*](https://blog.linuxgrrl.com).
 
 <!-- %PAGEBREAK% -->
 
@@ -80,6 +85,13 @@ Android.
 **Object Classes and Permissions** - Describes the SELinux object
 classes and permissions.
 
+### Updated Editions
+
+The SELinux Notebook is being maintained as part of the SELinux project, more
+recent editions may be available.
+
+See: **<https://github.com/SELinuxProject/selinux-notebook>**
+
 <!-- %CUTHERE% -->
 
 ---

