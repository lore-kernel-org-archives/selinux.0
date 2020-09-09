Return-Path: <SRS0=qhvK=DJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1E0C4363D
	for <selinux@archiver.kernel.org>; Fri,  2 Oct 2020 09:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6937520678
	for <selinux@archiver.kernel.org>; Fri,  2 Oct 2020 09:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="snVVvD7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJBJbv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Oct 2020 05:31:51 -0400
Received: from mailomta4-re.btinternet.com ([213.120.69.97]:41491 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725993AbgJBJbu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Oct 2020 05:31:50 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200909133051.DGXD4701.re-prd-fep-048.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658251; 
        bh=3DJycm+BKNpbo2ifqCmiHO2+UqnuODvDDgXTgh8Ae4g=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=snVVvD7JOE1JeupD9pk2nE3YBfGuTvKxAmIj7MwYC9xO5/Zb4xe/EjE2UvZaYmRrAP9BF80gOH06GgQq4JSjEiNh18pzwCS6GDayCUa8Bi4zXucvEiZ5qTX28CzAUqphvLXyN3eDi+2MgwkvoXbrEt+MeS48xswG9N3qzvHGNjpyAezcaLCRMXqRr1hdnQsNJ6mQUYaYLN2UdQ1tTOYNKd20nRfUzM0aSSlEHd2ZztppcxpIlpqyaNwXIOW9pOtSo6ZXQ1XzU+DXkFlWbhzNdbxPVL5J9DKX8rdhBFuHBN58ubgAHnHs8Fhokc7v6fvddIMZleoJTyQxsTL5Z1YeOA==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirdduheegrdduheegrddufeefnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehgedrudehgedrudeffedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134E79; Wed, 9 Sep 2020 14:30:51 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 20/22] x_windows: Tidy up formatting
Date:   Wed,  9 Sep 2020 14:30:37 +0100
Message-Id: <20200909133039.44498-21-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/x_windows.md | 52 ++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/src/x_windows.md b/src/x_windows.md
index 74edc62..86d93f9 100644
--- a/src/x_windows.md
+++ b/src/x_windows.md
@@ -1,13 +1,13 @@
 # X-Windows SELinux Support
 
--   [**Infrastructure Overview**](#infrastructure-overview)
--   [**Polyinstantiation**](#polyinstantiation)
--   [**Configuration Information**](#configuration-information)
-    -    [**Enable/Disable the OM from Policy Decisions**](#enabledisable-the-om-from-policy-decisions)
-    -    [**Configure OM Enforcement Mode**](#configure-om-enforcement-mode)
-    -    [**Determine OM X-extension Opcode**](#determine-om-x-extension-opcode)
-    -    [**The *x_contexts* File**](#the-x_contexts-file)
--   [**SELinux Extension Functions**](#selinux-extension-functions)
+- [Infrastructure Overview](#infrastructure-overview)
+- [Polyinstantiation](#polyinstantiation)
+- [Configuration Information](#configuration-information)
+  - [Enable/Disable the OM from Policy Decisions](#enabledisable-the-om-from-policy-decisions)
+  - [Configure OM Enforcement Mode](#configure-om-enforcement-mode)
+  - [Determine OM X-extension Opcode](#determine-om-x-extension-opcode)
+  - [The *x_contexts* File](#the-x_contexts-file)
+- [SELinux Extension Functions](#selinux-extension-functions)
 
 The SELinux X-Windows (XSELinux) implementation provides fine grained
 access control over the majority of the X-server objects (known as
@@ -116,10 +116,10 @@ of properties and selections.
 
 This section covers:
 
--   How to enable/disable the OM X-extension.
--   How to determine the OM X-extension opcode.
--   How to configure the OM in a specific SELinux enforcement mode.
--   The *x-contexts* configuration file.
+- How to enable/disable the OM X-extension.
+- How to determine the OM X-extension opcode.
+- How to configure the OM in a specific SELinux enforcement mode.
+- The *x-contexts* configuration file.
 
 ### Enable/Disable the OM from Policy Decisions
 
@@ -148,9 +148,9 @@ If the X-server object manager needs to be run in a specific SELinux
 enforcement mode, then the option may be added to the *xorg.conf* file
 (normally in */etc/X11/xorg.conf.d*). The option entries are as follows:
 
--   SELinux mode disabled
--   SELinux mode permissive
--   SELinux mode enforcing
+- SELinux mode disabled
+- SELinux mode permissive
+- SELinux mode enforcing
 
 Note that the entry must be exact otherwise it will be ignored. An
 example entry is:
@@ -222,17 +222,17 @@ the Xlib libraries (e.g. *XInternAtom*).
 
 **Notes:**
 
-1.  The way the XSELinux extension code works (see
-    *xselinux_label.c* - SELinuxAtomToSIDLookup()) is that non-poly
-    entries are searched for first, if an entry is not found then it
-    searches for a matching poly entry. The reason for this behavior is
-    that when operating in a secure environment all objects would be
-    polyinstantiated unless there are specific exemptions made for
-    individual objects to make them non-polyinstantiated. There would
-    then be a 'poly_selection' or 'poly_property' at the end of the section.
-2.  For systems using the Reference Policy all X-clients connecting
-    remotely will be allocated a security context from the *x_contexts*
-    file of:
+1. The way the XSELinux extension code works (see
+   *xselinux_label.c* - SELinuxAtomToSIDLookup()) is that non-poly
+   entries are searched for first, if an entry is not found then it
+   searches for a matching poly entry. The reason for this behavior is
+   that when operating in a secure environment all objects would be
+   polyinstantiated unless there are specific exemptions made for
+   individual objects to make them non-polyinstantiated. There would
+   then be a 'poly_selection' or 'poly_property' at the end of the section.
+2. For systems using the Reference Policy all X-clients connecting
+   remotely will be allocated a security context from the *x_contexts*
+   file of:
 
 ```
 # object_type object_name context
-- 
2.26.2

