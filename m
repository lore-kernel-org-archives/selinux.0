Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A17C433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 11:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3C5206DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 11:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="H9ENEmM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgGILmI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:42:08 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:57558 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgGILmI (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 9 Jul 2020 07:42:08 -0400
Received: from localhost.localdomain (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 601462A0FFA;
        Thu,  9 Jul 2020 13:42:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 601462A0FFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1594294925;
        bh=zhU8mDuZwr94tBZjQ1k3s9fQsIqpwfb62seaBmKjJLI=;
        h=From:To:Cc:Subject:Date:From;
        b=H9ENEmM0gejoeFrkdLwr0Hd5fZoobyWsgBjdotH/N0s9saIrl1xAYUHGyMh7MUc7F
         4xqBUKtvxcsFK7ebLMPOePvzBNOR4jUFMNZ1LAVF5Zq+ovsLYodM+4hztFMCud0ScR
         yJCWIjzPybTp0/kiGWL0bQ3LO9VowaRPR4DqoYJk=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH] pam_login.md: pam_selinux_permit is known as pam_sepermit upstream
Date:   Thu,  9 Jul 2020 13:41:49 +0200
Message-Id: <20200709114149.1705657-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change references to pam_selinux_permit to pam_sepermit
Replace gdm-password with sshd PAM configuration (from Fedora 33) as
pam_sepermit in the existing example might not always work correctly
when called from the auth section:
https://bugzilla.redhat.com/show_bug.cgi?id=1492313
Reference the pam_selinux(8) and pam_sepermit(8) manuals

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 src/pam_login.md | 50 ++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/src/pam_login.md b/src/pam_login.md
index 0c5a256..213a9f3 100644
--- a/src/pam_login.md
+++ b/src/pam_login.md
@@ -68,41 +68,37 @@ consist of multiple lines of information that are formatted as follows:
 </tbody>
 </table>
 
-The */etc/pam.d/gdm-password* PAM configuration file for the Gnome login
+The */etc/pam.d/sshd* PAM configuration file for the OpenSSH
 service is as follows:
 
 ```
-auth     [success=done ignore=ignore default=bad] pam_selinux_permit.so
-auth        substack      password-auth
-auth        optional      pam_gnome_keyring.so
-auth        include       postlogin
-
-account     required      pam_nologin.so
-account     include       password-auth
-
-password    substack       password-auth
--password   optional       pam_gnome_keyring.so use_authtok
-
-session     required      pam_selinux.so close
-session     required      pam_loginuid.so
-session     optional      pam_console.so
-session     required      pam_selinux.so open
-session     optional      pam_keyinit.so force revoke
-session     required      pam_namespace.so
-session     include       password-auth
-session     optional      pam_gnome_keyring.so auto_start
-session     include       postlogin
+#%PAM-1.0
+
+auth       substack     password-auth
+auth       include      postlogin
+account    required     pam_sepermit.so
+account    required     pam_nologin.so
+account    include      password-auth
+password   include      password-auth
+session    required     pam_selinux.so close
+session    required     pam_loginuid.so
+session    required     pam_selinux.so open
+session    required     pam_namespace.so
+session    optional     pam_keyinit.so force revoke
+session    optional     pam_motd.so
+session    include      password-auth
+session    include      postlogin
 ```
 
 The core services are provided by PAM, however other library modules can
 be written to manage specific services such as support for SELinux. The
-SELinux PAM modules use the *libselinux* API to obtain its configuration
-information and the three SELinux PAM entries highlighted in the above
-configuration file perform the following functions:
+***pam_sepermit**(8)* and ***pam_selinux**(8)* SELinux PAM modules use
+the *libselinux* API to obtain its configuration information and the
+three SELinux PAM entries highlighted in the above configuration file
+perform the following functions:
 
--   ***pam_selinux_permit.so*** - Allows pre-defined users the ability to
-    logon without a password provided that SELinux is in enforcing mode (see
-    the
+-   ***pam_sepermit.so*** - Allows pre-defined users the ability to
+    logon provided that SELinux is in enforcing mode (see the
     [*/etc/security/sepermit.conf*](global_config_files.md#etcsecuritysepermit.conf)
     section).
 -   ***pam_selinux.so open*** - Allows a security context to be set up for
-- 
2.27.0

