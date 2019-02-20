Return-Path: <SRS0=OyWE=Q3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5779CC43381
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 12:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2310D20C01
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 12:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfBTMnU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:43:20 -0500
Received: from dgrift.xs4all.space ([80.100.19.56]:49932 "EHLO
        agnus.defensec.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfBTMnU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Feb 2019 07:43:20 -0500
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Feb 2019 07:43:19 EST
Received: from localhost (localhost [127.0.0.1])
        by agnus.defensec.nl (Postfix) with ESMTP id B68872E0566;
        Wed, 20 Feb 2019 13:34:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at defensec.nl
Received: from agnus.defensec.nl ([127.0.0.1])
        by localhost (agnus.defensec.nl [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hBQYemNEqiup; Wed, 20 Feb 2019 13:34:00 +0100 (CET)
Received: from localhost.localdomain (myguest.lan [IPv6:2001:985:d55d::ef8])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 21E0A2E0165;
        Wed, 20 Feb 2019 13:34:00 +0100 (CET)
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH] scripts/selinux: modernize mdp
Date:   Wed, 20 Feb 2019 13:33:54 +0100
Message-Id: <20190220123354.1589-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.21.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The MDP example no longer works on modern systems.

Add support for devtmpfs. This is required by login programs to relabel terminals.
Compile the policy with deny_unknown allow status to anticipate user space object managers in core components such as systemd.
Add default seusers mapping and failsafe context for the SELinux PAM module.

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 scripts/selinux/install_policy.sh | 6 +++++-
 scripts/selinux/mdp/mdp.c         | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
index 0b86c47baf7d..334fcf8903d5 100755
--- a/scripts/selinux/install_policy.sh
+++ b/scripts/selinux/install_policy.sh
@@ -20,14 +20,18 @@ CP=`which checkpolicy`
 VERS=`$CP -V | awk '{print $1}'`
 
 ./mdp policy.conf file_contexts
-$CP -o policy.$VERS policy.conf
+$CP -U allow -o policy.$VERS policy.conf
 
 mkdir -p /etc/selinux/dummy/policy
 mkdir -p /etc/selinux/dummy/contexts/files
 
+echo "__default__:user_u" > /etc/selinux/dummy/seusers
+echo "base_r:base_t" > /etc/selinux/dummy/contexts/failsafe_context
+
 cp file_contexts /etc/selinux/dummy/contexts/files
 cp dbus_contexts /etc/selinux/dummy/contexts
 cp policy.$VERS /etc/selinux/dummy/policy
+
 FC_FILE=/etc/selinux/dummy/contexts/files/file_contexts
 
 if [ ! -d /etc/selinux ]; then
diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
index 073fe7537f6c..cf06d5694cbc 100644
--- a/scripts/selinux/mdp/mdp.c
+++ b/scripts/selinux/mdp/mdp.c
@@ -131,6 +131,7 @@ int main(int argc, char *argv[])
 
 	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
 	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
+	fprintf(fout, "fs_use_trans devtmpfs user_u:base_r:base_t;\n");
 	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
 	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
 	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
-- 
2.21.0.rc1

