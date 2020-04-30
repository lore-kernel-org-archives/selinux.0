Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FC5C47247
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 18:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C339520787
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 18:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rk4KGQPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD3Sar (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 14:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725844AbgD3Sar (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 14:30:47 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60CAC035494
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 11:30:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u15so403719ljd.3
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FThacwZESnW8PxAyKrIlfGEW6ORR4qJrP1hL6KaU1eU=;
        b=rk4KGQPhOp/s3MfY3Pglnwwh2Absitr1l889HDHOSsifX4Q44gM//9mdhGk3MfhES+
         MhqPZpYFwcYt4c5I3b63Ki2Lx9fRVfJxlRsqVgVtZ956h8mdc40EUjaGN7hO1snsygqq
         ahv6oPILCJZDxd2d1ANHgyxqA6oAxln4iofFOYz0VM2RBoLvAWif6H4CcnSi3nMxe8lG
         P5R7IEoaFmP2zMkunQbIYrq5eIOt7BmrKBuKxUtlXwV+6YRE66e18VDnA0iB5u1qPUjF
         3tuQO/VgTiCOaV4s/sNdQF/8xKfYCZn9034FqQyj7ah0y7jnbX8Hx5vKdYy51YgSyTdL
         X+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FThacwZESnW8PxAyKrIlfGEW6ORR4qJrP1hL6KaU1eU=;
        b=ci+PafVtFqzkAjEtUrsjsZsz94xlVFJo7XoLJcuqyRPE5Y+pBlYUxvQGHGIJjlkmvY
         fZBySqcO2zjMDHGcEbJCMidh0HPMFBx8dJ+4M9Z2Nzsqr9CJYTKR9r/KZRCUbckCirKX
         +sN528MceDyjZxHBGU7XpT0HXKvV92Dm9zC0hasYV7bDCh21stHSrGxfpzZ5UC2XAq3l
         0SNR2PuNSlrHkr/V3npbmeFAs2MzgpW1DbQKbeG529Etp10EdpBEW6Q5au1UFiwPPlNQ
         NecZ08m+jf++C6xJHSLHOsRw4rXe0bZADlXVPI/Vp6NHvTojSjCn9KVcpiYf8wYpBOp3
         qhoQ==
X-Gm-Message-State: AGi0PuZ5z/uPaJwRgy/MpP/Q0yNjpVLKS4a3DI3BZpk1ezcmCGyC3XKo
        aF2hY1ZrU03dvnkX1xUyhCJa4UuQ
X-Google-Smtp-Source: APiQypLTh1276G7niHD5WhWgOwvmo5+tUTQFeE/W9A06vAMd/aOjWgpqaZiyfzP0aaFjJK37nwWGpw==
X-Received: by 2002:a2e:8645:: with SMTP id i5mr133967ljj.56.1588271442037;
        Thu, 30 Apr 2020 11:30:42 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id 14sm331565lfz.8.2020.04.30.11.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 11:30:41 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH v2] sepolicy: fix some typos and port definitions
Date:   Thu, 30 Apr 2020 21:30:35 +0300
Message-Id: <20200430183035.9976-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The range of unreserved ports starts from 1024 and ends to
65535 (inclusive). (Secure) RPC ports can be between 512 and
1023 (inclusive).

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 python/sepolicy/sepolicy/generate.py  | 4 ++--
 python/sepolicy/sepolicy/interface.py | 2 +-
 python/sepolicy/sepolicy/network.py   | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index e8d07e7d..4e1ed4e9 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -340,7 +340,7 @@ class policy:
             (self.generate_root_user_types, self.generate_root_user_rules),
             (self.generate_new_types, self.generate_new_rules))
         if not re.match(r"^[a-zA-Z0-9-_]+$", name):
-            raise ValueError(_("Name must be alpha numeric with no spaces. Consider using option \"-n MODULENAME\""))
+            raise ValueError(_("Name must be alphanumeric with no spaces. Consider using option \"-n MODULENAME\""))
 
         if type == CGI:
             self.name = "httpd_%s_script" % name
@@ -438,7 +438,7 @@ class policy:
 
     def set_init_script(self, initscript):
         if self.type != DAEMON:
-            raise ValueError(_("Only Daemon apps can use an init script.."))
+            raise ValueError(_("Only Daemon apps can use an init script."))
 
         self.initscript = initscript
 
diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
index 187419fa..7d4ebd7e 100644
--- a/python/sepolicy/sepolicy/interface.py
+++ b/python/sepolicy/sepolicy/interface.py
@@ -198,7 +198,7 @@ def get_xml_file(if_file):
     filename = os.path.basename(if_file).split(".")[0]
     rc, output = getstatusoutput("/usr/bin/python3 /usr/share/selinux/devel/include/support/segenxml.py -w -m %s" % (basedir + filename))
     if rc != 0:
-        sys.stderr.write("\n Could not proceed selected interface file.\n")
+        sys.stderr.write("\n Could not process selected interface file.\n")
         sys.stderr.write("\n%s" % output)
         sys.exit(1)
     else:
diff --git a/python/sepolicy/sepolicy/network.py b/python/sepolicy/sepolicy/network.py
index ff308fad..d26a7ce6 100755
--- a/python/sepolicy/sepolicy/network.py
+++ b/python/sepolicy/sepolicy/network.py
@@ -49,15 +49,15 @@ def get_network_connect(src, protocol, perm, check_bools=False):
                 if "port_t" in tlist:
                     continue
             if i == "port_t":
-                d[(src, protocol, perm)].append((i, ["all ports with out defined types"]))
+                d[(src, protocol, perm)].append((i, ["all ports without defined types"]))
             if i == "port_type":
                 d[(src, protocol, perm)].append((i, ["all ports"]))
             elif i == "unreserved_port_type":
-                d[(src, protocol, perm)].append((i, ["all ports > 1024"]))
+                d[(src, protocol, perm)].append((i, ["all ports >= 1024"]))
             elif i == "reserved_port_type":
                 d[(src, protocol, perm)].append((i, ["all ports < 1024"]))
             elif i == "rpc_port_type":
-                d[(src, protocol, perm)].append((i, ["all ports > 500 and  < 1024"]))
+                d[(src, protocol, perm)].append((i, ["all ports >= 512 and < 1024"]))
             else:
                 try:
                     d[(src, protocol, perm)].append((i, portrecs[(i, protocol)]))
-- 
2.26.2

