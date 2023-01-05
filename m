Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2769C54EBD
	for <selinux@archiver.kernel.org>; Thu,  5 Jan 2023 17:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjAERVk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Jan 2023 12:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjAERVD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Jan 2023 12:21:03 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10F5564CC
        for <selinux@vger.kernel.org>; Thu,  5 Jan 2023 09:13:48 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qk9so91364812ejc.3
        for <selinux@vger.kernel.org>; Thu, 05 Jan 2023 09:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Agz5gCn9j4yyqOjfETzpJ3M/PpGVgpQ3czZumZXo7dM=;
        b=m0tHO8IkiZOEobR7C5DfiPZ/OZx43GxQL5jXKD1f7EEzg0DaOSTBTfQWDP2PbmED5E
         tXcc/0pnXdN07pyZXPR/N7x3VQOmuuES5pP5DEc/1JFgRjeWbtVTpBQcq9aD+QJdOXlX
         O50TEPzgZRk9SEIkLhXToYhmOC7xAwfrwVzMgAenIJxYbKPRDlqAh9+JxBNrEtiewhqX
         vgIHfKRLTEps2Bygdis8HrXuaXCNs+4g8B/So3yHIfsUc4IftSHrQRNPMdCFZdYGe1Ok
         MbTX0GA9iHa/1O4+3BIn9l/p179Npl7ymmtYuOMMuam7HxAG/61tj96v0Iyuz6Xy/oFP
         qAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Agz5gCn9j4yyqOjfETzpJ3M/PpGVgpQ3czZumZXo7dM=;
        b=cnHQtqbxi5O0ga92VdTHxMPYPaQ8Mc7p02RWRBS29SkmTjyKnF79Joj5XfD77/enKM
         hbxumK223A/JU1R+bJ1OfwVkeD4pIw7oBu2hwJmU7Y562U9JIIhKadYHNmtkfbk25119
         ahGvVUbJ0GQUKbkfFKiQH9wH5vCvWjwqqhLvpB5T3jNnTX8tlNiOyuQ3zK4rk2CzfdQt
         7u3Gk/VcWZd3Kv73Gvn7zJFFpOW6hbZTb8k4VQf4Hl7AKHeOUAYvWU46GoQ7oKFBNuhG
         3eB9gTsQxXglSF38qdlOfUEQNTxZInWAOT05RRVpNue0ueT3iEXJ1FDCnzxG07n+l/lr
         vafg==
X-Gm-Message-State: AFqh2kokHg/JmqmRvz7pnv/1d6NCRMUxRQgenml62WmnOfiV3e/VbMyk
        48hWItTJwLWhXBPWc43BxYmF6/teHpOvGg==
X-Google-Smtp-Source: AMrXdXsZYSmLdYFHELe6b7NLnOhFR0Pp7ISoL+eFZr9wNLGOO4bmUDOS/fRoMXkf753rp/NTV/PWtw==
X-Received: by 2002:a17:906:85d9:b0:842:1627:77b4 with SMTP id i25-20020a17090685d900b00842162777b4mr45543227ejy.3.1672938827488;
        Thu, 05 Jan 2023 09:13:47 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-153-041.77.10.pool.telefonica.de. [77.10.153.41])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906292100b0073c10031dc9sm16585182ejd.80.2023.01.05.09.13.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:13:47 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] checkpolicy: add simple round-trip test
Date:   Thu,  5 Jan 2023 18:13:40 +0100
Message-Id: <20230105171340.18444-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105171340.18444-1-cgzones@googlemail.com>
References: <20230105171340.18444-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add simple round-trip tests on a minimal standard and MLS policy.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/.gitignore              |  2 +
 checkpolicy/Makefile                |  6 +-
 checkpolicy/tests/polmin.conf       | 81 +++++++++++++++++++++++++++
 checkpolicy/tests/polmin.mls.conf   | 85 +++++++++++++++++++++++++++++
 checkpolicy/tests/test_roundtrip.sh | 33 +++++++++++
 5 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 checkpolicy/tests/polmin.conf
 create mode 100644 checkpolicy/tests/polmin.mls.conf
 create mode 100755 checkpolicy/tests/test_roundtrip.sh

diff --git a/checkpolicy/.gitignore b/checkpolicy/.gitignore
index a7bd076d..01a694d4 100644
--- a/checkpolicy/.gitignore
+++ b/checkpolicy/.gitignore
@@ -3,3 +3,5 @@ checkpolicy
 lex.yy.c
 y.tab.c
 y.tab.h
+tests/testpol.bin
+tests/testpol.conf
diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index f9e1fc7c..86c4a197 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -50,6 +50,10 @@ y.tab.c: policy_parse.y
 lex.yy.c: policy_scan.l y.tab.c
 	$(LEX) policy_scan.l
 
+.PHONY: test
+test: checkpolicy
+	./tests/test_roundtrip.sh
+
 install: all
 	-mkdir -p $(DESTDIR)$(BINDIR)
 	-mkdir -p $(DESTDIR)$(MANDIR)/man8
@@ -68,7 +72,7 @@ relabel: install
 	/sbin/restorecon $(DESTDIR)$(BINDIR)/checkmodule
 
 clean:
-	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c
+	-rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h lex.yy.c tests/testpol.conf tests/testpol.bin
 	$(MAKE) -C test clean
 
 indent:
diff --git a/checkpolicy/tests/polmin.conf b/checkpolicy/tests/polmin.conf
new file mode 100644
index 00000000..7a652de8
--- /dev/null
+++ b/checkpolicy/tests/polmin.conf
@@ -0,0 +1,81 @@
+# handle_unknown deny
+class process
+class blk_file
+class chr_file
+class dir
+class fifo_file
+class file
+class lnk_file
+class sock_file
+sid kernel
+sid security
+sid unlabeled
+sid fs
+sid file
+sid file_labels
+sid init
+sid any_socket
+sid port
+sid netif
+sid netmsg
+sid node
+sid igmp_packet
+sid icmp_socket
+sid tcp_socket
+sid sysctl_modprobe
+sid sysctl
+sid sysctl_fs
+sid sysctl_kernel
+sid sysctl_net
+sid sysctl_net_unix
+sid sysctl_vm
+sid sysctl_dev
+sid kmod
+sid policy
+sid scmp_packet
+sid devnull
+class process { dyntransition transition }
+default_role { blk_file } source;
+default_role { chr_file } source;
+default_role { dir } source;
+default_role { fifo_file } source;
+default_role { file } source;
+default_role { lnk_file } source;
+default_role { sock_file } source;
+type sys_isid;
+typealias sys_isid alias dpkg_script_t;
+typealias sys_isid alias rpm_script_t;
+allow sys_isid self:process { dyntransition transition };
+role sys_role;
+role sys_role types { sys_isid };
+user sys_user roles sys_role;
+constrain process { transition } u1 == u2;
+sid kernel sys_user:sys_role:sys_isid
+sid security sys_user:sys_role:sys_isid
+sid unlabeled sys_user:sys_role:sys_isid
+sid fs sys_user:sys_role:sys_isid
+sid file sys_user:sys_role:sys_isid
+sid file_labels sys_user:sys_role:sys_isid
+sid init sys_user:sys_role:sys_isid
+sid any_socket sys_user:sys_role:sys_isid
+sid port sys_user:sys_role:sys_isid
+sid netif sys_user:sys_role:sys_isid
+sid netmsg sys_user:sys_role:sys_isid
+sid node sys_user:sys_role:sys_isid
+sid igmp_packet sys_user:sys_role:sys_isid
+sid icmp_socket sys_user:sys_role:sys_isid
+sid tcp_socket sys_user:sys_role:sys_isid
+sid sysctl_modprobe sys_user:sys_role:sys_isid
+sid sysctl sys_user:sys_role:sys_isid
+sid sysctl_fs sys_user:sys_role:sys_isid
+sid sysctl_kernel sys_user:sys_role:sys_isid
+sid sysctl_net sys_user:sys_role:sys_isid
+sid sysctl_net_unix sys_user:sys_role:sys_isid
+sid sysctl_vm sys_user:sys_role:sys_isid
+sid sysctl_dev sys_user:sys_role:sys_isid
+sid kmod sys_user:sys_role:sys_isid
+sid policy sys_user:sys_role:sys_isid
+sid scmp_packet sys_user:sys_role:sys_isid
+sid devnull sys_user:sys_role:sys_isid
+fs_use_trans devpts sys_user:sys_role:sys_isid;
+fs_use_trans devtmpfs sys_user:sys_role:sys_isid;
diff --git a/checkpolicy/tests/polmin.mls.conf b/checkpolicy/tests/polmin.mls.conf
new file mode 100644
index 00000000..b045a60f
--- /dev/null
+++ b/checkpolicy/tests/polmin.mls.conf
@@ -0,0 +1,85 @@
+# handle_unknown deny
+class process
+class blk_file
+class chr_file
+class dir
+class fifo_file
+class file
+class lnk_file
+class sock_file
+sid kernel
+sid security
+sid unlabeled
+sid fs
+sid file
+sid file_labels
+sid init
+sid any_socket
+sid port
+sid netif
+sid netmsg
+sid node
+sid igmp_packet
+sid icmp_socket
+sid tcp_socket
+sid sysctl_modprobe
+sid sysctl
+sid sysctl_fs
+sid sysctl_kernel
+sid sysctl_net
+sid sysctl_net_unix
+sid sysctl_vm
+sid sysctl_dev
+sid kmod
+sid policy
+sid scmp_packet
+sid devnull
+class process { dyntransition transition }
+default_role { blk_file } source;
+default_role { chr_file } source;
+default_role { dir } source;
+default_role { fifo_file } source;
+default_role { file } source;
+default_role { lnk_file } source;
+default_role { sock_file } source;
+sensitivity s0;
+dominance { s0 }
+category c0;
+level s0:c0;
+mlsconstrain process { transition } l1 == l2;
+type sys_isid;
+typealias sys_isid alias dpkg_script_t;
+typealias sys_isid alias rpm_script_t;
+allow sys_isid self:process { dyntransition transition };
+role sys_role;
+role sys_role types { sys_isid };
+user sys_user roles sys_role level s0 range s0 - s0:c0;
+sid kernel sys_user:sys_role:sys_isid:s0 - s0
+sid security sys_user:sys_role:sys_isid:s0 - s0
+sid unlabeled sys_user:sys_role:sys_isid:s0 - s0
+sid fs sys_user:sys_role:sys_isid:s0 - s0
+sid file sys_user:sys_role:sys_isid:s0 - s0
+sid file_labels sys_user:sys_role:sys_isid:s0 - s0
+sid init sys_user:sys_role:sys_isid:s0 - s0
+sid any_socket sys_user:sys_role:sys_isid:s0 - s0
+sid port sys_user:sys_role:sys_isid:s0 - s0
+sid netif sys_user:sys_role:sys_isid:s0 - s0
+sid netmsg sys_user:sys_role:sys_isid:s0 - s0
+sid node sys_user:sys_role:sys_isid:s0 - s0
+sid igmp_packet sys_user:sys_role:sys_isid:s0 - s0
+sid icmp_socket sys_user:sys_role:sys_isid:s0 - s0
+sid tcp_socket sys_user:sys_role:sys_isid:s0 - s0
+sid sysctl_modprobe sys_user:sys_role:sys_isid:s0 - s0
+sid sysctl sys_user:sys_role:sys_isid:s0 - s0
+sid sysctl_fs sys_user:sys_role:sys_isid:s0 - s0
+sid sysctl_kernel sys_user:sys_role:sys_isid:s0 - s0
+sid sysctl_net sys_user:sys_role:sys_isid:s0 - s0
+sid sysctl_net_unix sys_user:sys_role:sys_isid:s0 - s0
+sid sysctl_vm sys_user:sys_role:sys_isid:s0 - s0
+sid sysctl_dev sys_user:sys_role:sys_isid:s0 - s0
+sid kmod sys_user:sys_role:sys_isid:s0 - s0
+sid policy sys_user:sys_role:sys_isid:s0 - s0
+sid scmp_packet sys_user:sys_role:sys_isid:s0 - s0
+sid devnull sys_user:sys_role:sys_isid:s0 - s0
+fs_use_trans devpts sys_user:sys_role:sys_isid:s0 - s0;
+fs_use_trans devtmpfs sys_user:sys_role:sys_isid:s0 - s0;
diff --git a/checkpolicy/tests/test_roundtrip.sh b/checkpolicy/tests/test_roundtrip.sh
new file mode 100755
index 00000000..15b1b3bc
--- /dev/null
+++ b/checkpolicy/tests/test_roundtrip.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+set -eu
+
+BASEDIR=$(dirname "$0")
+CHECKPOLICY="${BASEDIR}/../checkpolicy"
+
+check_policy() {
+	POLICY=$1
+	MLS=$2
+
+	if [ "$MLS" = 'mls' ]; then
+		OPT='-M'
+	else
+		OPT=
+	fi
+
+	echo "==== Testing ${1}"
+
+	${CHECKPOLICY} ${OPT} -E "${BASEDIR}/${POLICY}" -o "${BASEDIR}/testpol.bin"
+	${CHECKPOLICY} ${OPT} -E -b -F "${BASEDIR}/testpol.bin" -o "${BASEDIR}/testpol.conf"
+	diff -u "${BASEDIR}/${POLICY}" "${BASEDIR}/testpol.conf"
+
+	${CHECKPOLICY} ${OPT} -S -O -E "${BASEDIR}/${POLICY}" -o "${BASEDIR}/testpol.bin"
+	${CHECKPOLICY} ${OPT} -S -O -E -b -F "${BASEDIR}/testpol.bin" -o "${BASEDIR}/testpol.conf"
+	diff -u "${BASEDIR}/${POLICY}" "${BASEDIR}/testpol.conf"
+
+	echo "==== ${1} success"
+}
+
+
+check_policy polmin.conf std
+check_policy polmin.mls.conf mls
-- 
2.39.0

