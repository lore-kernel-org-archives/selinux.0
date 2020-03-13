Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03312C10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 14:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEADC206FA
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 14:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch8YhBtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgCMO1a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:27:30 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39172 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCMO1a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 10:27:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id e16so12739513qkl.6
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E2dq4+6FCPXm1aRUTZgwwHc4m+lMsYDSxiMrZfuuwtQ=;
        b=ch8YhBtESyDZLU7o8F7o6nFi4CUYaKIWo9w34TiB5YZDHRkqZKzjEZVHig0jrwyPsQ
         URhPVcMOmKR2Vo2Hv0yxym/rqDosG6nx5H2rPBpMgwjEUUGNN+CU7YcUmLq7ufg15B1g
         0zEyM6uS+jBQZaQtnjlBIuDCZCrh2wPvoRuKRXpabGUwQno8Fn/8ip4XEl3ChufjjlSh
         fpPgHNj87NQO/YhRv4nH+b0sESKobmb94zLjDjbwwK028BuTxMr0q4BAFNr3D4E6AEYb
         EMl6Xx+K74mEE0CLe/9biK9MSXE8rRnRzomsVXg29/PAsaKED24hC9dhqcXZJecKn4fN
         HNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E2dq4+6FCPXm1aRUTZgwwHc4m+lMsYDSxiMrZfuuwtQ=;
        b=gaEA+dTybsfOclE5ow/uDWdrdi6aeLwYiDNKfexG1McD4g6gI8xHlE+TLI3Kk4EDIM
         Vrm2Nqa0AO80E/ZlHjPGZ7BXX/eeFVfjfIPPw2I/0z9zDxU+/l2ld5WN/u/sqKQ0PZcE
         JLMRbvibfPwx5erOs+PLUfXo54yiaRzV6KxWXuLTchjZj+WN2MorxBwsxj72lQbEyydj
         Eern5bOYu0h3r0sRc3S895wVB+RRlKlr3JRbdwTGliApU8cwfby9LnQGsO3TZ8yOVJAp
         Y8BATwe7d/EaOwGdoKqJ+deOArg514aDXlZNArNtHYFMmSAy0W/VsViuZ1eA7G7dP30l
         /EBA==
X-Gm-Message-State: ANhLgQ2ShlwiMfBrjoYg3AVxWb+64aX7UiAfnHsom8QR0gHBZpx7cJDu
        JuX24js31Q2nBaFOk370RbQ=
X-Google-Smtp-Source: ADFU+vvaTnjxlirkd3p3MQS1tQ51kFg5+IaY82IQwRBPtONyFy8u1XkmCZ9947AGww4p8X4ADuwECA==
X-Received: by 2002:a37:a208:: with SMTP id l8mr11848111qke.302.1584109648149;
        Fri, 13 Mar 2020 07:27:28 -0700 (PDT)
Received: from r21-ubuntu-01.ltsnet.net ([65.127.220.137])
        by smtp.gmail.com with ESMTPSA id a15sm2906139qko.122.2020.03.13.07.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 07:27:27 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH 5/5] selinux-testsuite: add testing for unprivileged sandboxing capability
Date:   Fri, 13 Mar 2020 10:26:55 -0400
Message-Id: <20200313142655.29424-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313142655.29424-1-stephen.smalley.work@gmail.com>
References: <20200313142655.29424-1-stephen.smalley.work@gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Stephen Smalley <sds@tycho.nsa.gov>

This patch provides tests for the unprivileged sandboxing capability
introduced by the preceding kernel and userspace patches. In order for
these tests to work, the patched kernel and selinux userspace need to be
compiled and installed on the system.  This is an RFC only, see the
kernel patch description for a full description of the new capability.

To run these tests, in addition to installing the patched kernel
and userspace, you will need to modify your base policy as follows:

$ sudo semodule -cE base
$ sudo vi base.cil
<add "sandbox" to (class security (....))>
$ sudo semodule -i base.cil

$ cat ./definesandboxclass.cil
(class sandbox (load_policy unload_policy))
(classorder (unordered sandbox))
$ sudo semodule -i definesandboxclass.cil

$ sudo vi /usr/share/selinux/devel/include/support/all_perms.spt
<add "sandbox" to all_security_perms definition, and add the following
within the all_kernel_class_perms definition:
class sandbox { load_policy unload_policy };

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/Makefile                 |   4 +
 policy/test_sandbox.te          |  48 +++++++
 tests/Makefile                  |   2 +-
 tests/sandbox/Makefile          |   2 +
 tests/sandbox/nodir_no_deny.cil |  29 +++++
 tests/sandbox/nodir_rx_deny.cil |  27 ++++
 tests/sandbox/rxdir_no_deny.cil |  29 +++++
 tests/sandbox/rxdir_rx_deny.cil |  27 ++++
 tests/sandbox/test              | 215 ++++++++++++++++++++++++++++++++
 9 files changed, 382 insertions(+), 1 deletion(-)
 create mode 100644 policy/test_sandbox.te
 create mode 100644 tests/sandbox/Makefile
 create mode 100644 tests/sandbox/nodir_no_deny.cil
 create mode 100644 tests/sandbox/nodir_rx_deny.cil
 create mode 100644 tests/sandbox/rxdir_no_deny.cil
 create mode 100644 tests/sandbox/rxdir_rx_deny.cil
 create mode 100755 tests/sandbox/test

diff --git a/policy/Makefile b/policy/Makefile
index cf8d431..4ae65f4 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -114,6 +114,10 @@ TARGETS += test_lockdown.te
 export M4PARAM += -Dlockdown_defined
 endif
 
+ifeq ($(shell grep -q sandbox $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS += test_sandbox.te
+endif
+
 ifeq ($(shell grep -q filesystem $(POLDEV)/include/support/all_perms.spt && echo true),true)
 TARGETS += test_filesystem.te
 ifeq ($(shell [ $(MOD_POL_VERS) -ge 11 -a $(POL_VERS) -ge 25 ] && echo true),true)
diff --git a/policy/test_sandbox.te b/policy/test_sandbox.te
new file mode 100644
index 0000000..22a212e
--- /dev/null
+++ b/policy/test_sandbox.te
@@ -0,0 +1,48 @@
+attribute test_sandbox_domain;
+
+type test_sandbox_file_t;
+files_type(test_sandbox_file_t)
+
+type test_sandbox_dir_t;
+files_type(test_sandbox_dir_t);
+
+type test_sandbox_nodir_t;
+domain_type(test_sandbox_nodir_t)
+unconfined_runs_test(test_sandbox_nodir_t)
+typeattribute test_sandbox_nodir_t test_sandbox_domain;
+typeattribute test_sandbox_nodir_t testdomain;
+allow test_sandbox_nodir_t test_sandbox_dir_t:file { getattr };
+
+type test_sandbox_rxdir_t;
+domain_type(test_sandbox_rxdir_t)
+unconfined_runs_test(test_sandbox_rxdir_t)
+typeattribute test_sandbox_rxdir_t test_sandbox_domain;
+typeattribute test_sandbox_rxdir_t testdomain;
+allow test_sandbox_rxdir_t test_sandbox_dir_t:dir { getattr read open };
+allow test_sandbox_rxdir_t test_sandbox_dir_t:dir search_dir_perms;
+allow test_sandbox_rxdir_t test_sandbox_dir_t:file { getattr };
+
+require {
+    type ls_exec_t;
+}
+domain_entry_file(test_sandbox_domain, ls_exec_t)
+domain_transition_pattern(sysadm_t, ls_exec_t, test_sandbox_domain)
+
+type test_sandbox_noop;
+domain_type(test_sandbox_noop)
+unconfined_runs_test(test_sandbox_noop)
+typeattribute test_sandbox_noop test_sandbox_domain;
+typeattribute test_sandbox_noop testdomain;
+allow test_sandbox_noop test_sandbox_file_t:file { getattr read open };
+allow test_sandbox_noop test_sandbox_nodir_t:sandbox { load_policy unload_policy };
+allow test_sandbox_noop test_sandbox_rxdir_t:sandbox { load_policy unload_policy };
+
+type test_sandbox_op;
+domain_type(test_sandbox_op)
+unconfined_runs_test(test_sandbox_op)
+typeattribute test_sandbox_op test_sandbox_domain;
+typeattribute test_sandbox_op testdomain;
+allow test_sandbox_op test_sandbox_file_t:file { getattr read open };
+allow test_sandbox_op test_sandbox_op:security { sandbox };
+allow test_sandbox_op test_sandbox_nodir_t:sandbox { load_policy unload_policy };
+allow test_sandbox_op test_sandbox_rxdir_t:sandbox { load_policy unload_policy };
diff --git a/tests/Makefile b/tests/Makefile
index 46a1641..d72286b 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -6,7 +6,7 @@ export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
 
 DISTRO=$(shell ./os_detect)
 
-SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
+SUBDIRS:=sandbox domain_trans entrypoint execshare exectrace execute_no_trans \
 	fdreceive inherit link mkdir msg open ptrace readlink relabel rename \
 	rxdir sem setattr setnice shm sigkill stat sysctl task_create \
 	task_setnice task_setscheduler task_getscheduler task_getsid \
diff --git a/tests/sandbox/Makefile b/tests/sandbox/Makefile
new file mode 100644
index 0000000..e7c006f
--- /dev/null
+++ b/tests/sandbox/Makefile
@@ -0,0 +1,2 @@
+all:
+clean:
diff --git a/tests/sandbox/nodir_no_deny.cil b/tests/sandbox/nodir_no_deny.cil
new file mode 100644
index 0000000..ae45ac5
--- /dev/null
+++ b/tests/sandbox/nodir_no_deny.cil
@@ -0,0 +1,29 @@
+; This information is NOT compiled into a sandbox policy, it is here just to
+; make the cil compiler happy. For now, we leave it here with dummy information.
+(sid SID)
+(sidorder (SID))
+(user USER)
+(role ROLE)
+(category CAT)
+(categoryorder (CAT))
+(sensitivity SENS)
+(sensitivityorder (SENS))
+(sensitivitycategory SENS (CAT))
+(roletype ROLE test_sandbox_dir_t)
+(userrole USER ROLE)
+(userlevel USER (SENS))
+(userrange USER ((SENS)(SENS (CAT))))
+(sidcontext SID (USER ROLE test_sandbox_dir_t ((SENS)(SENS))))
+
+; type: test_sandbox_nodir_t
+; perms: no
+; mode: deny
+
+(class dir (read getattr open search rmdir))
+(class file (getattr))
+(classorder (dir file))
+(type test_sandbox_nodir_t)
+(type test_sandbox_dir_t)
+(deny test_sandbox_nodir_t test_sandbox_dir_t (dir (read getattr open)))
+(deny test_sandbox_nodir_t test_sandbox_dir_t (dir (getattr search open)))
+(deny test_sandbox_nodir_t test_sandbox_dir_t (file (getattr)))
diff --git a/tests/sandbox/nodir_rx_deny.cil b/tests/sandbox/nodir_rx_deny.cil
new file mode 100644
index 0000000..dedd992
--- /dev/null
+++ b/tests/sandbox/nodir_rx_deny.cil
@@ -0,0 +1,27 @@
+; This information is NOT compiled into a sandbox policy, it is here just to
+; make the cil compiler happy. For now, we leave it here with dummy information.
+(sid SID)
+(sidorder (SID))
+(user USER)
+(role ROLE)
+(category CAT)
+(categoryorder (CAT))
+(sensitivity SENS)
+(sensitivityorder (SENS))
+(sensitivitycategory SENS (CAT))
+(roletype ROLE test_sandbox_dir_t)
+(userrole USER ROLE)
+(userlevel USER (SENS))
+(userrange USER ((SENS)(SENS (CAT))))
+(sidcontext SID (USER ROLE test_sandbox_dir_t ((SENS)(SENS))))
+
+; type: test_sandbox_nodir_t
+; perms: rx
+; mode: deny
+
+(class dir (read getattr open search rmdir))
+(class file (getattr))
+(classorder (dir file))
+(type test_sandbox_nodir_t)
+(type test_sandbox_dir_t)
+(deny test_sandbox_nodir_t test_sandbox_dir_t (dir (rmdir)))
diff --git a/tests/sandbox/rxdir_no_deny.cil b/tests/sandbox/rxdir_no_deny.cil
new file mode 100644
index 0000000..57d13f5
--- /dev/null
+++ b/tests/sandbox/rxdir_no_deny.cil
@@ -0,0 +1,29 @@
+; This information is NOT compiled into a sandbox policy, it is here just to
+; make the cil compiler happy. For now, we leave it here with dummy information.
+(sid SID)
+(sidorder (SID))
+(user USER)
+(role ROLE)
+(category CAT)
+(categoryorder (CAT))
+(sensitivity SENS)
+(sensitivityorder (SENS))
+(sensitivitycategory SENS (CAT))
+(roletype ROLE test_sandbox_dir_t)
+(userrole USER ROLE)
+(userlevel USER (SENS))
+(userrange USER ((SENS)(SENS (CAT))))
+(sidcontext SID (USER ROLE test_sandbox_dir_t ((SENS)(SENS))))
+
+; type: test_sandbox_rxdir_t
+; perms: no
+; mode: deny
+
+(class dir (read getattr open search rmdir))
+(class file (getattr))
+(classorder (dir file))
+(type test_sandbox_rxdir_t)
+(type test_sandbox_dir_t)
+(deny test_sandbox_rxdir_t test_sandbox_dir_t (dir (read getattr open)))
+(deny test_sandbox_rxdir_t test_sandbox_dir_t (dir (getattr search open)))
+(deny test_sandbox_rxdir_t test_sandbox_dir_t (file (getattr)))
diff --git a/tests/sandbox/rxdir_rx_deny.cil b/tests/sandbox/rxdir_rx_deny.cil
new file mode 100644
index 0000000..5142e7d
--- /dev/null
+++ b/tests/sandbox/rxdir_rx_deny.cil
@@ -0,0 +1,27 @@
+; This information is NOT compiled into a sandbox policy, it is here just to
+; make the cil compiler happy. For now, we leave it here with dummy information.
+(sid SID)
+(sidorder (SID))
+(user USER)
+(role ROLE)
+(category CAT)
+(categoryorder (CAT))
+(sensitivity SENS)
+(sensitivityorder (SENS))
+(sensitivitycategory SENS (CAT))
+(roletype ROLE test_sandbox_dir_t)
+(userrole USER ROLE)
+(userlevel USER (SENS))
+(userrange USER ((SENS)(SENS (CAT))))
+(sidcontext SID (USER ROLE test_sandbox_dir_t ((SENS)(SENS))))
+
+; type: test_sandbox_rxdir_t
+; perms: rx
+; mode: deny
+
+(class dir (read getattr open search rmdir))
+(class file (getattr))
+(classorder (dir file))
+(type test_sandbox_rxdir_t)
+(type test_sandbox_dir_t)
+(deny test_sandbox_rxdir_t test_sandbox_dir_t (dir (rmdir)))
diff --git a/tests/sandbox/test b/tests/sandbox/test
new file mode 100755
index 0000000..eed6724
--- /dev/null
+++ b/tests/sandbox/test
@@ -0,0 +1,215 @@
+#!/usr/bin/perl
+
+use Test;
+BEGIN { plan tests => 68 }
+
+$basedir = $0;
+$basedir =~ s|(.*)/[^/]*|$1|;
+
+# The test_sandbox.te policy sets the base policy permissions for these tests.
+# We use sandbox policies to further restrict the base policy. Some sandbox
+# policies attempt to grant themselves extra permissions so that we can test
+# that those permissions are NOT actually granted. All sandbox tests check for
+# permissions to read and search directories.
+#
+# The following tests are performed
+#
+#                       | base   | sandbox | expected result | expected result
+#  type                 | policy | policy  | without sandbox | WITH sandbox
+# ----------------------|------------------------------------------------------
+#  test_sandbox_nodir_t | deny   | deny    | deny            | deny
+#  test_sandbox_nodir_t | deny   | allow   | deny            | deny
+#  test_sandbox_rxdir_t | allow  | deny    | allow           | deny
+#  test_sandbox_rxdir_t | allow  | allow   | allow           | allow
+#
+# To test both loading and unloading of policies, each test occurs in the
+# following sequence:
+#  1. test read/search operations (without sandbox)
+#  2. load sandbox
+#  3. test read/search operations (WITH sandbox)
+#  4. unload sandbox
+#  5. test read/search operations (without sandbox)
+#
+# Finally, each test is performed twice. Once with sandboxes written in ALLOW
+# mode and a second time with sandboxes written in DENY mode. The same results
+# are expected in each mode.
+#
+# The sandbox policy files are named using the following scheme:
+#  <type>_<perms>_<mode>.cil
+# Where:
+#  <type> is either 'nodir' or 'rxdir' -- indicates type sandbox is applied to
+#  <perms> is either 'no' or 'rx' -- indicates permissions granted by sandbox
+#  <mode> is either 'allow' or 'deny' -- indicates mode sandbox is written in
+#
+
+# setup test directory and file
+system("rm -rf $basedir/test_dir");
+system("mkdir $basedir/test_dir");
+system("chcon -t test_sandbox_dir_t $basedir/test_dir");
+system("touch $basedir/test_dir/test_file");
+
+# compile sandboxes
+$allow_mode=0;
+$deny_mode=1;
+&compile( "test_sandbox_nodir_t", "nodir_no_allow.cil", $allow_mode);
+&compile( "test_sandbox_nodir_t", "nodir_rx_allow.cil", $allow_mode);
+&compile( "test_sandbox_rxdir_t", "rxdir_no_allow.cil", $allow_mode);
+&compile( "test_sandbox_rxdir_t", "rxdir_rx_allow.cil", $allow_mode);
+&compile( "test_sandbox_nodir_t", "nodir_no_deny.cil", $deny_mode);
+&compile( "test_sandbox_nodir_t", "nodir_rx_deny.cil", $deny_mode);
+&compile( "test_sandbox_rxdir_t", "rxdir_no_deny.cil", $deny_mode);
+&compile( "test_sandbox_rxdir_t", "rxdir_rx_deny.cil", $deny_mode);
+
+# For the compiled sandbox files to be readable by test_sandbox_op and
+# test_sandbox_noop, we must change the files security contexts.
+system("chcon -t test_sandbox_file_t $basedir/*.sandbox");
+
+# confirm op/noop types can read .sandbox files
+$result = system("runcon -t test_sandbox_op -- cat $basedir/rxdir_rx_allow.sandbox > /dev/null");
+ok( $result, 0 );
+$result = system("runcon -t test_sandbox_noop -- cat $basedir/rxdir_rx_allow.sandbox > /dev/null");
+ok( $result, 0 );
+
+# First, we want to make sure that types without the sandbox operate permission
+# (specifically the test_sandbox_noop type) are denied from loading and
+# unloading a sandbox policy.
+
+$sandbox="$basedir/rxdir_rx_allow.sandbox";
+$result = system("runcon -t test_sandbox_noop -- sebox --load $sandbox > /dev/null 2>&1");
+ok( $result );
+$result = system("runcon -t test_sandbox_noop -- sebox --unload $sandbox > /dev/null 2>&1");
+ok( $result );
+
+# ================================================================= #
+#  deny, deny (ALLOW MODE)                                          #
+# ================================================================= #
+&test_rx( "test_sandbox_nodir_t", -1 );
+&load_sandbox( "test_sandbox_op", "nodir_no_allow.sandbox" );
+&test_rx( "test_sandbox_nodir_t", -1 );
+&unload_sandbox( "test_sandbox_op", "nodir_no_allow.sandbox" );
+&test_rx( "test_sandbox_nodir_t", -1 );
+
+# ================================================================= #
+#  deny, allow (ALLOW MODE)                                         #
+# ================================================================= #
+&test_rx( "test_sandbox_nodir_t", -1 );
+&load_sandbox( "test_sandbox_op", "nodir_rx_allow.sandbox" );
+&test_rx( "test_sandbox_nodir_t", -1 );
+&unload_sandbox( "test_sandbox_op", "nodir_rx_allow.sandbox" );
+&test_rx( "test_sandbox_nodir_t", -1 );
+
+# ================================================================= #
+#  allow, deny (ALLOW MODE)                                         #
+# ================================================================= #
+&test_rx( "test_sandbox_rxdir_t", 0 );
+&load_sandbox( "test_sandbox_op", "rxdir_no_allow.sandbox" );
+&test_rx( "test_sandbox_rxdir_t", -1 );
+&unload_sandbox( "test_sandbox_op", "rxdir_no_allow.sandbox" );
+&test_rx( "test_sandbox_rxdir_t", 0 );
+
+# ================================================================= #
+#  allow, allow (ALLOW MODE)                                        #
+# ================================================================= #
+&test_rx( "test_sandbox_rxdir_t", 0 );
+&load_sandbox( "test_sandbox_op", "rxdir_rx_allow.sandbox" );
+&test_rx( "test_sandbox_rxdir_t", 0 );
+&unload_sandbox( "test_sandbox_op", "rxdir_rx_allow.sandbox" );
+&test_rx( "test_sandbox_rxdir_t", 0 );
+
+# ================================================================= #
+#  deny, deny (DENY MODE)                                        #
+# ================================================================= #
+&test_rx( "test_sandbox_nodir_t", -1 );
+&load_sandbox( "test_sandbox_op", "nodir_no_deny.sandbox" );
+&test_rx( "test_sandbox_nodir_t", -1 );
+&unload_sandbox( "test_sandbox_op", "nodir_no_deny.sandbox" );
+&test_rx( "test_sandbox_nodir_t", -1 );
+
+# ================================================================= #
+#  deny, allow (DENY MODE)                                        #
+# ================================================================= #
+&test_rx( "test_sandbox_nodir_t", -1 );
+&load_sandbox( "test_sandbox_op", "nodir_rx_deny.sandbox" );
+&test_rx( "test_sandbox_nodir_t", -1 );
+&unload_sandbox( "test_sandbox_op", "nodir_rx_deny.sandbox" );
+&test_rx( "test_sandbox_nodir_t", -1 );
+
+# ================================================================= #
+#  allow, deny (DENY MODE)                                        #
+# ================================================================= #
+&test_rx( "test_sandbox_rxdir_t", 0 );
+&load_sandbox( "test_sandbox_op", "rxdir_no_deny.sandbox" );
+&test_rx( "test_sandbox_rxdir_t", -1 );
+&unload_sandbox( "test_sandbox_op", "rxdir_no_deny.sandbox" );
+&test_rx( "test_sandbox_rxdir_t", 0 );
+
+# ================================================================= #
+#  allow, allow (DENY MODE)                                        #
+# ================================================================= #
+&test_rx( "test_sandbox_rxdir_t", 0 );
+&load_sandbox( "test_sandbox_op", "rxdir_rx_deny.sandbox" );
+&test_rx( "test_sandbox_rxdir_t", 0 );
+&unload_sandbox( "test_sandbox_op", "rxdir_rx_deny.sandbox" );
+&test_rx( "test_sandbox_rxdir_t", 0 );
+
+# clean up
+system("rm -rf $basedir/test_dir");
+system("rm $basedir/*.sandbox");
+
+sub compile {
+    $type     = shift;
+    $filename = shift;
+    $mode     = shift;
+
+    $input="$basedir/$filename";
+    $output="$basedir/$filename";
+    $output=~s/\.cil/\.sandbox/ig;
+
+    # generate context
+    $context=`runcon -t $type -- id -Z`;
+    chomp($context);
+
+    # compile
+    if ($mode == 0) {
+        system("secilc --sandbox=\"$context\" --sandbox-allow -o $output $input");
+    } else {
+        system("secilc --sandbox=\"$context\" --sandbox-deny -o $output $input");
+    }
+}
+
+sub test_rx {
+    $type     = shift;
+    $expected = shift;
+
+    $result = system("runcon -t $type -- ls $basedir/test_dir 2>&1");
+    if ($expected == 0) {
+        ok( $result, 0 );
+    } else {
+        ok( $result );
+    }
+
+    $result = system("runcon -t $type -- ls $basedir/test_dir/test_file 2>&1");
+    if ($expected == 0) {
+        ok( $result, 0 );
+    } else {
+        ok( $result );
+    }
+}
+
+sub load_sandbox {
+    $type     = shift;
+    $filename = shift;
+
+    $sandbox="$basedir/$filename";
+    $result = system("runcon -t $type -- sebox --load $sandbox > /dev/null 2>&1");
+    ok( $result, 0 );
+}
+
+sub unload_sandbox {
+    $type     = shift;
+    $filename = shift;
+
+    $sandbox="$basedir/$filename";
+    $result = system("runcon -t $type -- sebox --unload $sandbox > /dev/null 2>&1");
+    ok( $result, 0 );
+}
-- 
2.17.1

