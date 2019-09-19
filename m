Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176E9C49ED7
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 08:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3491207FC
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 08:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5chkTxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbfISILH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 04:11:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57458 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728879AbfISILH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 04:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568880665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ipv4pPgTCoccl1SXinZvgLnrbSRwlWgZUsvj02PZ584=;
        b=f5chkTxf4zM5nkF80vMxopLxwFW9bRhI2Hl8hGBXUIrgKfwntzvtmHuRiz3fVXCA+h9Za4
        ipek0H/RBOH9LQBf1S8kPr+Povu+LvQGaV6/f2aR8PE60VMmSMTqPi6F37CUyLamhqm2y4
        S7MXFhMFFxFKltZ3SHojEwiWOS9C2uU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-CjpQVsXjOA6r-dgJieY6qQ-1; Thu, 19 Sep 2019 04:11:03 -0400
Received: by mail-wr1-f72.google.com with SMTP id l6so733920wrn.2
        for <selinux@vger.kernel.org>; Thu, 19 Sep 2019 01:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GAHJpLxyyRO+PEvBaoVpTQU2lEmPTxq9c3bGUTmotRc=;
        b=oeAy1TmxHbJKqrjykr9TpIXGSpNdZYnudbcpzOs8Xgyo6XOL1f2+c0ARMO7Zthg3qQ
         TCzYhJ9uSVvB+8uxb39f5psXbVbHfjS//QKExf8Wib9L3rN7gxc+JA5EVZof3NtJ4QmF
         AdaBw9b3myxlEsIiWtMr0VQkbx7wu3RFpo61tAWFeTL9lijnKYjfnwLoyFYoAcVyBNqh
         o38h4nm6n1hYoOMdCsAZr+AygVfgxopiUxrfwHzBMv5xUhkMhK9aQcWjy3iihpixDTVd
         22bhNozg3KzGuo+6Ajx6TQqD+vJqE056mx1C6jkfmOYW3DHC37jRguJuPs/mqsgGf1Q2
         gS2w==
X-Gm-Message-State: APjAAAWgKwgapew5AslbUd+kkz+k0jp1ib+1ZDzxxN5yY1rWf/d9mmPN
        Tu0tAxD5MfYijX+kNxEeG+/jCa6UuauCLqFMy6YY+cXmwyo6+UymkdM7c+JNVx4AOPyZzVLeEXU
        uMVDRP05ZB82WdncCgQ==
X-Received: by 2002:adf:fd10:: with SMTP id e16mr6414598wrr.17.1568880661618;
        Thu, 19 Sep 2019 01:11:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzHDzQQ4mlFKx3yuVOtDAeZHoENofiLh7L4TfSVELjBKIQfDBuGL3X3W5dW9xtnmWnaxbGbNQ==
X-Received: by 2002:adf:fd10:: with SMTP id e16mr6414581wrr.17.1568880661270;
        Thu, 19 Sep 2019 01:11:01 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o9sm12934760wrh.46.2019.09.19.01.11.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 01:11:00 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] policy: fix some build errors under refpolicy
Date:   Thu, 19 Sep 2019 10:10:58 +0200
Message-Id: <20190919081058.8860-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: CjpQVsXjOA6r-dgJieY6qQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace deprecated macros with new ones. Fedora's policy has both;
refpolicy just the new ones.

Partially addresses issue #57.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_atsecure.te    | 4 ++--
 policy/test_capable_net.te | 2 +-
 policy/test_file.te        | 4 ++--
 policy/test_inherit.te     | 4 ++--
 policy/test_readlink.te    | 2 +-
 policy/test_rxdir.te       | 2 +-
 policy/test_setnice.te     | 4 ++--
 policy/test_stat.te        | 2 +-
 policy/test_transition.te  | 2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/policy/test_atsecure.te b/policy/test_atsecure.te
index 7255553..486faf6 100644
--- a/policy/test_atsecure.te
+++ b/policy/test_atsecure.te
@@ -32,8 +32,8 @@ corecmd_bin_entry_type(atsecuredomain)
 corecmd_shell_entry_type(atsecuredomain)
 corecmd_exec_bin(atsecuredomain)
 domain_entry_file(test_atsecure_newdomain_t, test_file_t)
-domain_trans(test_atsecure_denied_t, test_file_t, test_atsecure_newdomain_=
t)
-domain_trans(test_atsecure_allowed_t, test_file_t, test_atsecure_newdomain=
_t)
+domain_transition_pattern(test_atsecure_denied_t, test_file_t, test_atsecu=
re_newdomain_t)
+domain_transition_pattern(test_atsecure_allowed_t, test_file_t, test_atsec=
ure_newdomain_t)
 allow test_atsecure_newdomain_t test_atsecure_denied_t:fd use;
 allow test_atsecure_newdomain_t test_atsecure_allowed_t:fd use;
 allow_map(atsecuredomain, test_file_t, file)
diff --git a/policy/test_capable_net.te b/policy/test_capable_net.te
index fab6650..80559f6 100644
--- a/policy/test_capable_net.te
+++ b/policy/test_capable_net.te
@@ -53,7 +53,7 @@ sysadm_bin_spec_domtrans_to(capabledomain)
 require {
 =09type ifconfig_exec_t;
 }
-domain_trans(sysadm_t, ifconfig_exec_t, capabledomain)
+domain_transition_pattern(sysadm_t, ifconfig_exec_t, capabledomain)
 domain_entry_file(capabledomain, ifconfig_exec_t)
=20
 # Permissions for the good domain
diff --git a/policy/test_file.te b/policy/test_file.te
index 1f1da3a..828c0f4 100644
--- a/policy/test_file.te
+++ b/policy/test_file.te
@@ -67,13 +67,13 @@ corecmd_bin_entry_type(fileopdomain)
 sysadm_bin_spec_domtrans_to(fileopdomain)
=20
 domain_entry_file(fileop_t, fileop_exec_t)
-domain_auto_trans(test_fileop_t, fileop_exec_t, fileop_t)
+domain_auto_transition_pattern(test_fileop_t, fileop_exec_t, fileop_t)
 allow test_fileop_t fileop_t:fd use;
 allow fileop_t test_fileop_t:fd use;
 allow fileop_t test_fileop_t:fifo_file rw_file_perms;
 allow fileop_t test_fileop_t:process sigchld;
=20
-domain_auto_trans(test_nofileop_t, fileop_exec_t, fileop_t)
+domain_auto_transition_pattern(test_nofileop_t, fileop_exec_t, fileop_t)
 allow test_nofileop_t fileop_t:fd use;
 allow fileop_t test_nofileop_t:fd use;
 allow fileop_t test_nofileop_t:fifo_file rw_file_perms;
diff --git a/policy/test_inherit.te b/policy/test_inherit.te
index 28bfd63..8303fc5 100644
--- a/policy/test_inherit.te
+++ b/policy/test_inherit.te
@@ -47,7 +47,7 @@ userdom_sysadm_entry_spec_domtrans_to(inheritdomain)
 allow test_inherit_parent_t test_inherit_file_t:file rw_file_perms;
=20
 # Grant the necessary permissions for the child domain.
-domain_trans(test_inherit_parent_t, test_file_t, test_inherit_child_t)
+domain_transition_pattern(test_inherit_parent_t, test_file_t, test_inherit=
_child_t)
 allow test_inherit_parent_t test_inherit_child_t:fd use;
 allow test_inherit_child_t test_inherit_parent_t:fd use;
 allow test_inherit_child_t test_inherit_parent_t:fifo_file rw_file_perms;
@@ -60,7 +60,7 @@ allow test_inherit_nouse_t test_file_t:file { read getatt=
r execute entrypoint };
 allow test_inherit_nouse_t test_inherit_file_t:file rw_file_perms;
=20
 # Grant the nowrite domain all of the same permissions except for file wri=
te.
-domain_trans(test_inherit_parent_t, test_file_t, test_inherit_nowrite_t)
+domain_transition_pattern(test_inherit_parent_t, test_file_t, test_inherit=
_nowrite_t)
 allow test_inherit_parent_t test_inherit_nowrite_t:fd use;
 allow test_inherit_nowrite_t test_inherit_parent_t:fd use;
 allow test_inherit_nowrite_t test_inherit_parent_t:fifo_file rw_file_perms=
;
diff --git a/policy/test_readlink.te b/policy/test_readlink.te
index 1126fd5..b0d8cd5 100644
--- a/policy/test_readlink.te
+++ b/policy/test_readlink.te
@@ -34,5 +34,5 @@ allow test_noreadlink_t test_readlink_link_t:lnk_file { g=
etattr };
 require {
 =09type ls_exec_t;
 }
-domain_trans(sysadm_t, ls_exec_t, test_readlink_domain)
+domain_transition_pattern(sysadm_t, ls_exec_t, test_readlink_domain)
 domain_entry_file(test_readlink_domain, ls_exec_t)
diff --git a/policy/test_rxdir.te b/policy/test_rxdir.te
index cbe1897..50d5ad1 100644
--- a/policy/test_rxdir.te
+++ b/policy/test_rxdir.te
@@ -33,4 +33,4 @@ require {
 =09type ls_exec_t;
 }
 domain_entry_file(test_rxdir_domain, ls_exec_t)
-domain_trans(sysadm_t, ls_exec_t, test_rxdir_domain)
+domain_transition_pattern(sysadm_t, ls_exec_t, test_rxdir_domain)
diff --git a/policy/test_setnice.te b/policy/test_setnice.te
index dac0dc5..d956598 100644
--- a/policy/test_setnice.te
+++ b/policy/test_setnice.te
@@ -38,8 +38,8 @@ libs_exec_lib_files(setnicedomain)
 # Allow all of these domains to be entered from sysadm domain
 # via a shell script in the test directory or by....
 miscfiles_domain_entry_test_files(setnicedomain)
-domain_trans(sysadm_t, test_file_t, setnicedomain)
-domain_trans(test_setnice_change_t, test_file_t, {test_setnice_set_t test_=
setnice_noset_t})
+domain_transition_pattern(sysadm_t, test_file_t, setnicedomain)
+domain_transition_pattern(test_setnice_change_t, test_file_t, {test_setnic=
e_set_t test_setnice_noset_t})
 allow test_setnice_change_t test_setnice_set_t:fd use;
 allow test_setnice_set_t test_setnice_change_t:fd use;
 allow test_setnice_set_t test_setnice_change_t:fifo_file rw_file_perms;
diff --git a/policy/test_stat.te b/policy/test_stat.te
index 2e068d1..0204e71 100644
--- a/policy/test_stat.te
+++ b/policy/test_stat.te
@@ -29,5 +29,5 @@ typeattribute test_nostat_t testdomain;
 require {
 =09type ls_exec_t;
 }
-domain_trans(sysadm_t, ls_exec_t, test_stat_domain)
+domain_transition_pattern(sysadm_t, ls_exec_t, test_stat_domain)
 domain_entry_file(test_stat_domain, ls_exec_t)
diff --git a/policy/test_transition.te b/policy/test_transition.te
index c487825..1eee2b4 100644
--- a/policy/test_transition.te
+++ b/policy/test_transition.te
@@ -28,7 +28,7 @@ typeattribute test_transition_todomain_t testdomain;
=20
 # Allow the fromdomain to transition to the new domain.
 corecmd_bin_entry_type(transitiondomain)
-domain_trans(test_transition_fromdomain_t,bin_t,test_transition_todomain_t=
)
+domain_transition_pattern(test_transition_fromdomain_t,bin_t,test_transiti=
on_todomain_t)
 allow test_transition_fromdomain_t test_transition_todomain_t:fd use;
 allow test_transition_todomain_t test_transition_fromdomain_t:fd use;
=20
--=20
2.21.0

