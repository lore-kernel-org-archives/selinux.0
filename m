Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B23C33CB6
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 14:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63773214AF
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 14:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="PgfsA/tt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgAQOrc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:47:32 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:39116 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgAQOrc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 09:47:32 -0500
X-EEMSG-check-017: 46929317|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,330,1574121600"; 
   d="scan'208";a="46929317"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Jan 2020 14:47:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579272448; x=1610808448;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ozey3lcVCty0hjabkWVK4ZdK+bfJEKEDLO4WQlGbOTg=;
  b=PgfsA/ttYecH1sNC8PX970gNLl6C1Z7iDES/AbOYsmgEbpBHRPLBQvdE
   2Sstm7ymXskoKW9dxBBZmPCwIx+xWq9DbX0Iw02yCYYQNcCSInsZoYAUx
   17iWCFfTep/4BKwPObkYdei0KTr1Q66JdZ/0DHxEWTjUkZffd2MykAdQs
   SO441aqGbcZt5/DXeLXtOGbjaIRJ6FKriBsWc7vLO4AdqigCcwA0GjWpM
   VHuhvdqkWSPCZg5++bQxlpreycJ3x4G68acQtaeHSAMkQen1Jb6aiPHqd
   fAiC+cAME+61F/9/xcwuFcnZoiNcoFQ/FY1DJivD0tnonb0Z4HpJMEM3o
   g==;
X-IronPort-AV: E=Sophos;i="5.70,330,1574121600"; 
   d="scan'208";a="32074131"
IronPort-PHdr: =?us-ascii?q?9a23=3AJ8se+xxHtgn6LXfXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd1OMeIJqq85mqBkHD//Il1AaPAdyHraobwLSJ++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMnYdvKKk9xx?=
 =?us-ascii?q?rLr3BVf+ha2X5kKUickhrh6Mq85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y63SfckeRW?=
 =?us-ascii?q?FcQMhfUSJPCZ64Y4cWD+cMOeNUoo/grFUMsBS+HxGhCuPxxDFViHH43qo03O?=
 =?us-ascii?q?suHwzdwAAtHMgDvGjOodnpKKsfV/2+wqnSzTXEavNbwSrz6JTWfRA5ofGDQ7?=
 =?us-ascii?q?RwetfMx0kqDQzFilGQppLlPjiI0ekNqHWU7/F7WOKzi28otwFxoj+1yscqkY?=
 =?us-ascii?q?nGnJgZyl/D9SVn2Ys4I8CzRk1jYdO8DZdduC6XO5F2T88/WW1kpik3xqMctZ?=
 =?us-ascii?q?KmeiUB1Y4pyATFa/OddoiF+hfjVOGMLjhmnH9lY7e/hwqq8Uin1+38StG40F?=
 =?us-ascii?q?ZUoSpBldnBrmwN2AbJ6siGV/t95V2t2TeJ1wDd7eFEOl47mrbBJ549wr8/ip?=
 =?us-ascii?q?oTsUPZEi/whEr2l7OZel8h+uip7+TrerTmppmCOI9okgzyL6sjl8OlDek4Lw?=
 =?us-ascii?q?QCRXaX9Oui2LH54EH1WLBKgec3kqndvpDaP8MbpquhDg9Oz4kj8A2yDyum0d?=
 =?us-ascii?q?sEnXkHK0hJeBScj4fzIV3OL/f4Demnj1S2jDhr3+zGPqHmApjVNXjMjrPhfb?=
 =?us-ascii?q?d7605Bxws+1s5f551KBbEbOv7zWVH+tMbeDhAnNwy42eHnCM9y1tBWZWXaGa?=
 =?us-ascii?q?KdMaXPoXeW6e81ZeqBfokYvHD6Mfd2yeTpiCoChVIFfaSvlaASYXS8E+Uud1?=
 =?us-ascii?q?6VelLwk9wBFiEMpQN4Q+v03g7RGQVPbmq/CvpvrgowD5irWMKeF40=3D?=
X-IPAS-Result: =?us-ascii?q?A2CbAABkyCFe/wHyM5BlHQEBAQkBEQUFAYFpBgELAYF8g?=
 =?us-ascii?q?g0SKo0UhmEGiyWPToF7CQEBAQEBAQEBARscAQGEQIIwNgcOAhABAQEEAQEBA?=
 =?us-ascii?q?QEFAwEBbIVDgjspgzMBRoFRgmc/glclrVeFSoMsgT6BNgGHOoRzeYEHgUeCK?=
 =?us-ascii?q?HOEM4YEBJd2l1aCQ4JJk1sMG4JHmCoBkCWVRoV3BS1EgRQrCAIYCCEPgydQG?=
 =?us-ascii?q?A2WZSMDMI1nAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Jan 2020 14:47:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00HEkksn136658;
        Fri, 17 Jan 2020 09:46:48 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: update man pages for userspace policy enforcers
Date:   Fri, 17 Jan 2020 09:48:13 -0500
Message-Id: <20200117144813.55896-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Despite deprecating use of flask.h and av_permissions.h back in 2014,
the man pages for avc_has_perm(3) and security_compute_av(3) were not
updated to provide instructions on how to dynamically map class/permission
names nor to encourage use of selinux_check_access(3) instead of these
interfaces.  Also, while selinux_set_mapping(3) supports dynamic
class/perm mapping at initialization, it does not support changes to
the class/perm values at runtime upon a policy reload, and no
instructions were provided on how to set up a callback to support
this case.  Update the man pages accordingly.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/man/man3/avc_has_perm.3        | 37 +++++++++++++++++-
 libselinux/man/man3/security_compute_av.3 | 47 +++++++++++++++++++++--
 libselinux/man/man3/selinux_set_mapping.3 | 20 ++++++++--
 3 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/libselinux/man/man3/avc_has_perm.3 b/libselinux/man/man3/avc_has_perm.3
index 3e9fca8475f1..62809f9af47f 100644
--- a/libselinux/man/man3/avc_has_perm.3
+++ b/libselinux/man/man3/avc_has_perm.3
@@ -34,6 +34,36 @@ avc_has_perm, avc_has_perm_noaudit, avc_audit, avc_entry_ref_init \- obtain and
 .in
 .
 .SH "DESCRIPTION"
+
+Direct use of these functions is generally discouraged in favor of
+the higher level interface
+.BR selinux_check_access(3)
+since the latter automatically handles the dynamic mapping of class
+and permission names to their policy values and proper handling of
+allow_unknown.
+
+When using any of the functions that take policy integer values for
+classes or permissions as inputs, use
+.BR string_to_security_class(3)
+and
+.BR string_to_av_perm(3)
+to map the class and permission names to their policy values.
+These values may change across a policy reload, so they should be
+re-acquired on every use or using a
+.B SELINUX_CB_POLICYLOAD
+callback set via
+.BR selinux_set_callback(3).
+
+An alternative approach is to use
+.BR selinux_set_mapping(3)
+to create a mapping from class and permission index values
+used by the application to the policy values,
+thereby allowing the application to pass its own
+fixed constants for the classes and permissions to
+these functions and internally mapping them on demand.
+However, this also requires setting up a callback as above
+to address policy reloads.
+
 .BR avc_entry_ref_init ()
 initializes an
 .B avc_entry_ref
@@ -146,11 +176,16 @@ Make sure that userspace object managers are granted appropriate access to
 netlink by the policy.
 .
 .SH "AUTHOR"
-Eamon Walsh <ewalsh@tycho.nsa.gov>
+Originally Eamon Walsh.  Updated by Stephen Smalley <sds@tycho.nsa.gov>
 .
 .SH "SEE ALSO"
 .ad l
 .nh
+.BR selinux_check_access(3),
+.BR string_to_security_class(3),
+.BR string_to_av_perm(3),
+.BR selinux_set_callback(3),
+.BR selinux_set_mapping(3),
 .BR avc_init (3),
 .BR avc_context_to_sid (3),
 .BR avc_cache_stats (3),
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index cb1a9ba49f46..3de1b0fe7f1b 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -50,6 +50,39 @@ the SELinux policy database in the kernel
 .BI "int checkPasswdAccess(access_vector_t " requested );
 .
 .SH "DESCRIPTION"
+
+This family of functions is used to obtain policy decisions from the
+SELinux kernel security server (policy engine).  In general, direct use of
+.BR security_compute_av ()
+and its variant interfaces is discouraged in favor of using
+.BR selinux_check_access ()
+since the latter automatically handles the dynamic mapping of class
+and permission names to their policy values, initialization and use of
+the Access Vector Cache (AVC), and proper handling of per-domain and
+global permissive mode and allow_unknown.
+
+When using any of the functions that take policy integer values for
+classes or permissions as inputs, use
+.BR string_to_security_class(3)
+and
+.BR string_to_av_perm(3)
+to map the class and permission names to their policy values.
+These values may change across a policy reload, so they should be
+re-acquired on every use or using a
+.B SELINUX_CB_POLICYLOAD
+callback set via
+.BR selinux_set_callback(3).
+
+An alternative approach is to use
+.BR selinux_set_mapping(3)
+to create a mapping from class and permission index values
+used by the application to the policy values,
+thereby allowing the application to pass its own
+fixed constants for the classes and permissions to
+these functions and internally mapping them on demand.
+However, this also requires setting up a callback as above
+to address policy reloads.
+
 .BR security_compute_av ()
 queries whether the policy permits the source context
 .I scon
@@ -102,7 +135,7 @@ instance.
 .BR security_compute_user ()
 is used to determine the set of user contexts that can be reached from a
 source context. It is mainly used by
-.BR get_ordered_context_list ().
+.BR get_ordered_context_list (3).
 
 .BR security_validatetrans ()
 is used to determine if a transition from scon to newcon using tcon as the object
@@ -135,7 +168,9 @@ is used to check for a permission in the
 .I passwd
 class.
 .BR selinux_check_passwd_access ()
-uses getprevcon() for the source and target security contexts.
+uses
+.BR getprevcon(3)
+for the source and target security contexts.
 
 .BR checkPasswdAccess ()
 is a deprecated alias of the
@@ -146,4 +181,10 @@ function.
 Returns zero on success or \-1 on error.
 .
 .SH "SEE ALSO"
-.BR selinux "(8), " getcon "(3), " getfilecon "(3), " get_ordered_context_list "(3)"
+.BR string_to_security_class (3),
+.BR string_to_av_perm (3),
+.BR selinux_set_callback (3),
+.BR selinux_set_mapping (3),
+.BR getprevcon (3),
+.BR get_ordered_context_list (3),
+.BR selinux (8)
diff --git a/libselinux/man/man3/selinux_set_mapping.3 b/libselinux/man/man3/selinux_set_mapping.3
index a93f7b29497a..4624fbc7918a 100644
--- a/libselinux/man/man3/selinux_set_mapping.3
+++ b/libselinux/man/man3/selinux_set_mapping.3
@@ -19,7 +19,19 @@ struct security_class_mapping {
 .
 .SH "DESCRIPTION"
 .BR selinux_set_mapping ()
-establishes a mapping from a user-provided ordering of object classes and permissions to the numbers actually used by the loaded system policy.  Use of this function is highly preferred over the generated constants in the libselinux header files, as this method allows the policy's class and permission values to change over time.
+establishes a mapping from a user-provided ordering of object classes and permissions to the numbers actually used by the loaded system policy. If using this function, applications should also set a
+.B SELINUX_CB_POLICYLOAD
+callback via
+.BR selinux_set_callback(3)
+that calls this function again upon a policy reload to re-create the mapping
+in case the class or permission values change in the new policy.
+Generally it is preferred to instead use
+.BR selinux_check_access(3)
+instead of
+.BR avc_has_perm(3)
+or
+.BR security_compute_av(3)
+and not use this function at all.
 
 After the mapping is established, all libselinux functions that operate on class and permission values take the user-provided numbers, which are determined as follows:
 
@@ -81,8 +93,10 @@ and
 class) will be identified by 1, 2, 4, and 8 respectively.  Classes and permissions not listed in the mapping cannot be used.
 .
 .SH "AUTHOR"
-Eamon Walsh <ewalsh@tycho.nsa.gov>
+Originally Eamon Walsh.  Updated by Stephen Smalley <sds@tycho.nsa.gov>
 .
 .SH "SEE ALSO"
-.BR avc_open (8),
+.BR selinux_check_access (3),
+.BR selinux_set_callback (3),
+.BR avc_has_perm (3),
 .BR selinux (8)
-- 
2.24.1

