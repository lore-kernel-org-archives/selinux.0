Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1855BC1B0D9
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 11:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E625623340
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 11:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgLGLnw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Dec 2020 06:43:52 -0500
Received: from mailomta6-sa.btinternet.com ([213.120.69.12]:33966 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726254AbgLGLnw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Dec 2020 06:43:52 -0500
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20200902131747.DGWH19995.sa-prd-fep-041.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 2 Sep 2020 14:17:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599052667; 
        bh=za9FuHt0NlwXmDC39YdY/XeXg1bmc5I+Rp2nRv8pYq0=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=NYWVQ0IDGmox3G/m9MIhqYtRALIZOqn+u0RGfMCpZo3BQblDWtwgGQRoLOjwcTpsNrqMx5fN19sMg5IE6ubDihiU9C3jxx/m/H8YzDUM+O8j+K+eQLpbVxJv/V3/mK1J0Ns1aOSXZDtvsLitQh25+CGFL0T8iAZfybGTKUmaamndNWXFVyf5mwwLDh8EbA5V1JmyipR7IMX/CwtkDlfeLiNqemp6ogf5FpnILl/Atw/rRELNds8mrzGjij3Y0Ol+sAPY+2Yib2kf1gNcKa3JayAkfF5di7e5NLH1Iow6zsM1qm1NzXAg9rs9fzlDZXF6A6s8pXmrVWhY5C/bk2meWA==
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
        id 5ED9AFBE0EF36BCB; Wed, 2 Sep 2020 14:17:47 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 07/13] pam_login: Convert to markdown
Date:   Wed,  2 Sep 2020 14:17:32 +0100
Message-Id: <20200902131738.18425-8-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902131738.18425-1-richard_c_haines@btinternet.com>
References: <20200902131738.18425-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert to markdown.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/pam_login.md | 107 +++++++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 51 deletions(-)

diff --git a/src/pam_login.md b/src/pam_login.md
index 08e1599..2b30bff 100644
--- a/src/pam_login.md
+++ b/src/pam_login.md
@@ -4,21 +4,18 @@ Applications used to provide login services (such as ***ssh**(1)*) in
 Fedora use the PAM (Pluggable Authentication Modules) infrastructure to
 provide the following services:
 
--   **Account Management** - This manages services such as password expiry,
-service entitlement (i.e. what services the login process is allowed to
-access).
-
--   **Authentication Management** - Authenticate the user or subject and set
-up the credentials. PAM can handle a variety of devices including
-smart-cards and biometric devices.
-
--   **Password Management** - Manages password updates as needed by the
-specific authentication mechanism being used and the password policy.
-
--   **Session Management** - Manages any services that must be invoked
-before the login process completes and / or when the login process
-terminates. For SELinux this is where hooks are used to manage the
-domains the subject may enter.
+- **Account Management** - This manages services such as password expiry,
+  service entitlement (i.e. what services the login process is allowed to
+  access).
+- **Authentication Management** - Authenticate the user or subject and set
+  up the credentials. PAM can handle a variety of devices including
+  smart-cards and biometric devices.
+- **Password Management** - Manages password updates as needed by the
+  specific authentication mechanism being used and the password policy.
+- **Session Management** - Manages any services that must be invoked
+  before the login process completes and / or when the login process
+  terminates. For SELinux this is where hooks are used to manage the
+  domains the subject may enter.
 
 The ***pam**(8)* and ***pam.conf**(5)* *man* pages describe the services and
 configuration in detail and only a summary is provided here covering the
@@ -43,32 +40,40 @@ service type control module-path arguments
 
 **Where:**
 
-<table>
-<tbody>
-<tr>
-<td>service</td>
-<td>The service name such as <em>gdm</em> and <em>login</em> reflecting the login application. If there is a <em>/etc/pam.d</em> directory, then this is the name of a configuration file name under this directory. Alternatively, a configuration file called <em>/etc/pam.conf</em> can be used. Fedora uses the <em>/etc/pam.d</em> configuration.</td>
-</tr>
-<tr>
-<td>type</td>
-<td>These are the management groups used by PAM with valid entries being: <em>account</em>, <em>auth</em>, <em>password</em> and <em>session</em> that correspond to the descriptions given above. Where there are multiple entries of the same '<em>type</em>', the order they appear could be significant.</td>
-</tr>
-<tr>
-<td>control</td>
-<td><p>This entry states how the module should behave when the requested task fails. There can be two formats: a single keyword such as <em>required</em>, <em>optional</em>, and <em>include</em>; or multiple space separated entries enclosed in square brackets consisting of :</p>
-<p>  [value1=action1 value2=action2 ..]</p>
-<p>Both formats are shown in the example file below, however see the <em><strong>pam.conf</strong>(5)</em> man pages for the gory details. </p></td>
-</tr>
-<tr>
-<td>module-path</td>
-<td>Either the full path name of the module or its location relative to <em>/lib/security</em> (but does depend on the system architecture).</td>
-</tr>
-<tr>
-<td>arguments</td>
-<td>A space separated list of the arguments that are defined for the module.</td>
-</tr>
-</tbody>
-</table>
+*service*
+
+- The service name such as *gdm* and *login* reflecting the login application.
+  If there is a */etc/pam.d* directory, then this is the name of a
+  configuration file name under this directory. Alternatively, a
+  configuration file called */etc/pam.conf* can be used. Fedora uses the
+  */etc/pam.d* configuration.
+
+*type*
+
+- These are the management groups used by PAM with valid entries being:
+  *account*, *auth*, *password* and *session* that correspond to the
+  descriptions given above. Where there are multiple entries of the same
+   '*type*', the order they appear could be significant.
+
+*control*
+
+- This entry states how the module should behave when the requested task
+  fails. There can be two formats: a single keyword such as *required*,
+  *optional*, and *include*; or multiple space separated entries enclosed in
+  square brackets consisting of (see the ***pam.conf**(5)* man pages):
+
+```
+[value1=action1 value2=action2 ..]
+```
+
+*module-path*
+
+- Either the full path name of the module or its location relative to
+  */lib/security* (but does depend on the system architecture).
+
+*arguments*
+
+- A space separated list of the arguments that are defined for the module.
 
 The */etc/pam.d/sshd* PAM configuration file for the OpenSSH
 service is as follows:
@@ -99,17 +104,17 @@ the *libselinux* API to obtain its configuration information and the
 three SELinux PAM entries highlighted in the above configuration file
 perform the following functions:
 
--   ***pam_sepermit.so*** - Allows pre-defined users the ability to
-    logon provided that SELinux is in enforcing mode (see the
-    [*/etc/security/sepermit.conf*](global_config_files.md#etcsecuritysepermit.conf)
-    section).
--   ***pam_selinux.so open*** - Allows a security context to be set up for
-    the user at initial logon (as all programs exec'ed from here will use
-    this context). How the context is retrieved is described in the
-    [***Policy Configuration Files** - seusers*](policy_config_files.md#seusers)
-    section.
+- ***pam_sepermit.so*** - Allows pre-defined users the ability to
+  logon provided that SELinux is in enforcing mode (see the
+  [*/etc/security/sepermit.conf*](global_config_files.md#etcsecuritysepermit.conf)
+  section).
+- ***pam_selinux.so open*** - Allows a security context to be set up for
+  the user at initial logon (as all programs exec'ed from here will use
+  this context). How the context is retrieved is described in the
+  [***Policy Configuration Files** - seusers*](policy_config_files.md#seusers)
+  section.
 -   ***pam_selinux.so close*** - This will reset the login programs context
-    to the context defined in the policy.
+  to the context defined in the policy.
 
 <!-- %CUTHERE% -->
 
-- 
2.26.2

