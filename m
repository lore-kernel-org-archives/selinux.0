Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEDDC433E2
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2B02078D
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 19:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="fbPP+jOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgIOTxc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 15:53:32 -0400
Received: from mailomta8-sa.btinternet.com ([213.120.69.14]:28609 "EHLO
        sa-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727751AbgIOTxT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 15:53:19 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20200902131748.LIKW5290.sa-prd-fep-040.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 2 Sep 2020 14:17:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599052668; 
        bh=f9Xgk0jtnpb0PpwmGxZahurw7+LZbZCh8FkknZxjWOE=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=fbPP+jOHDk4wtgbO/843QzqPvmPsulAEKlzn3uEtyu7rGMepk8lXx+croaDSfpXWEFd8TfNrwen4iPQDHEp2KGNjIU6Aei887DXdLbwi+pU34McacZazpcZ8gF8l95DRz+GywAmZDXIX4obBrmQjW+uB284BWt0Wl1obqpJH4LTTnQZnoRUwL/yZgjlU5AnbuyiIKDan8CTQoyqopPNMqwD+jR7BxISC3QB4xFVVc2RAoHrVvQyIw0u0ZvI7IAAbE69/nM8vkKWXIFoSBOYfQxtBaXBLj7nB98KVoQ6ROFV1/8dUu3bL8wRAq8sXohL+gueiDm3DuLPB72m+dDrh7g==
Authentication-Results: btinternet.com; none
X-Originating-IP: [109.155.32.197]
X-OWM-Source-IP: 109.155.32.197 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepuddtledrudehhedrfedvrdduleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheehrdefvddrudeljedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.32.197) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE0EF36BF4; Wed, 2 Sep 2020 14:17:48 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 11/13] polyinstantiation: Convert to markdown
Date:   Wed,  2 Sep 2020 14:17:36 +0100
Message-Id: <20200902131738.18425-12-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902131738.18425-1-richard_c_haines@btinternet.com>
References: <20200902131738.18425-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a TOC to aid navigation and convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/polyinstantiation.md | 108 ++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 48 deletions(-)

diff --git a/src/polyinstantiation.md b/src/polyinstantiation.md
index 3a64918..16a13c2 100644
--- a/src/polyinstantiation.md
+++ b/src/polyinstantiation.md
@@ -1,5 +1,12 @@
 # Polyinstantiation Support
 
+- [Polyinstantiated Objects](#polyinstantiated-objects)
+- [Polyinstantiation support in PAM](#polyinstantiation-support-in-pam)
+  - [*namespace.conf* Configuration File](#namespace.conf-configuration-file)
+    - [Example Configurations](#example-configurations)
+- [Polyinstantiation support in X-Windows](#polyinstantiation-support-in-x-windows)
+- [Polyinstantiation support in the Reference Policy](#polyinstantiation-support-in-the-reference-policy)
+
 GNU / Linux supports the polyinstantiation of directories that can be
 utilised by SELinux via the Pluggable Authentication Module (PAM) as explained
 in the next section. The
@@ -12,16 +19,16 @@ sockets are not yet supported.
 
 To clarify polyinstantiation support:
 
-1.  SELinux has *libselinux* functions and a policy rule to support
-    polyinstantiation.
-2.  The polyinstantiation of directories is a function of GNU / Linux
-    not SELinux (as more correctly, the GNU / Linux services such as PAM
-    have been modified to support polyinstantiation of directories and
-    have also been made SELinux-aware. Therefore their services can be
-    controlled via policy).
-3.  The polyinstantiation of X-windows selections and properties is a
-    function of the XSELinux Object Manager and the supporting XACE
-    service.
+1. SELinux has *libselinux* functions and a policy rule to support
+   polyinstantiation.
+2. The polyinstantiation of directories is a function of GNU / Linux
+   not SELinux (as more correctly, the GNU / Linux services such as PAM
+   have been modified to support polyinstantiation of directories and
+   have also been made SELinux-aware. Therefore their services can be
+   controlled via policy).
+3. The polyinstantiation of X-windows selections and properties is a
+   function of the XSELinux Object Manager and the supporting XACE
+   service.
 
 ## Polyinstantiated Objects
 
@@ -46,10 +53,11 @@ to enable the feature and some [**examples**](#example-configurations).
 To implement polyinstantiated directories PAM requires the following
 files to be configured:
 
-1.  A **pam_namespace** module entry added to the appropriate */etc/pam.d/*
-    login configuration file (e.g. login, sshd, gdm etc.). Fedora
-    already has these entries configured, with an example
-    */etc/pam.d/gdm-password* file being:
+- A **pam_namespace** module entry added to the appropriate */etc/pam.d/*
+  login configuration file (e.g. login, sshd, gdm etc.). Fedora
+  already has these entries configured, with an example
+  */etc/pam.d/gdm-password* file being:
+
 ```
 auth     [success=done ignore=ignore default=bad] pam_selinux_permit.so
 auth        substack      password-auth
@@ -73,13 +81,13 @@ session     optional      pam_gnome_keyring.so auto_start
 session     include       postlogin
 ```
 
-2.  Entries added to the */etc/security/namespace.conf* file that defines
-    the directories to be polyinstantiated by PAM (and other services
-    that may need to use the namespace service). The entries are
-    explained in the
-    [*namespace.conf*](#namespace.conf-configuration-file) section,
-    with the default entries in Fedora being (note that the entries are
-    commented out in the distribution):
+- Entries added to the */etc/security/namespace.conf* file that defines
+  the directories to be polyinstantiated by PAM (and other services
+  that may need to use the namespace service). The entries are
+  explained in the
+  [*namespace.conf*](#namespace.conf-configuration-file) section,
+  with the default entries in Fedora being (note that the entries are
+  commented out in the distribution):
 
 ```
 # polydir  instance-prefix     method  list_of_uids
@@ -108,33 +116,37 @@ Each line in the namespace.conf file is formatted as follows:
 polydir instance_prefix method list_of_uids
 ```
 
-Where:
-
-<table>
-<tbody>
-<tr>
-<td>polydir</td>
-<td>The absolute path name of the directory to polyinstantiate. The optional strings $USER and $HOME will be replaced by the user name and home directory respectively.</td>
-</tr>
-<tr>
-<td>instance_prefix</td>
-<td>A string prefix used to build the pathname for the polyinstantiated directory. The optional strings $USER and $HOME will be replaced by the user name and home directory respectively.</td>
-</tr>
-<tr>
-<td>method</td>
-<td><p>This is used to determine the method of polyinstantiation with valid entries being:</p>
-<p>user - Polyinstantiation is based on user name.</p>
-<p>level - Polyinstantiation is based on the user name and MLS level.</p>
-<p>context - Polyinstantiation is based on the user name and security context.</p>
-<p>Note that level and context are only valid for SELinux enabled systems.</p></td>
-</tr>
-<tr>
-<td>list_of_uids</td>
-<td><p>A comma separated list of user names that will not have polyinstantiated directories. If blank, then all users are polyinstantiated. If the list is preceded with an '~' character, then only the users in the list will have polyinstantiated directories.</p>
-<p>There are a number of optional flags available that are described in the <strong>namespace.conf</strong>(5) man page.</p></td>
-</tr>
-</tbody>
-</table>
+**Where:**
+
+*polydir*
+
+- The absolute path name of the directory to polyinstantiate. The optional
+  strings *\$USER* and *\$HOME* will be replaced by the user name and home
+  directory respectively.
+
+*instance_prefix*
+
+- A string prefix used to build the pathname for the polyinstantiated
+  directory. The optional strings *\$USER* and *\$HOME* will be replaced by
+  the user name and home directory respectively.
+
+*method*
+
+- This is used to determine the method of polyinstantiation with valid
+  entries being:
+  - *user*    - Polyinstantiation is based on user name.
+  - *level*   - Polyinstantiation is based on user name and MLS level.
+  - *context* - Polyinstantiation is based on user name and security context.
+- Note that *level* and *context* are only valid for SELinux enabled systems.
+
+*list_of_uids*
+
+- A comma separated list of user names that will not have polyinstantiated
+  directories. If blank, then all users are polyinstantiated. If the list is
+  preceded with an '~' character, then only the users in the list will have
+  polyinstantiated directories.
+  There are a number of optional flags available that are described in the
+  ***namespace.conf**(5)* man page.
 
 ### Example Configurations
 
-- 
2.26.2

