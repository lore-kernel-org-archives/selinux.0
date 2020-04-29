Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CD4C83003
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 11:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4722073E
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 11:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+Sd0S3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgD2Lxd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD2Lxc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 07:53:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86591C03C1AD
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 04:53:32 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l19so2251045lje.10
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 04:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zanJ48XWx6afXcaPBWy/lKMTaJRgJmlSPIxFMmX4B34=;
        b=J+Sd0S3ewTzUBOKHhpws/6hATUT9mzaD5wiPXvcUTMFadJav0ykLhc+CgUadmHs5IM
         CJM9fV7uDH2HB0DSerkoetl6ANv6lj6oDiuNv4e/vV9QFX7ptmnzrIee4XPES/i/xGXA
         ClDDoeRebLneIux2mm5GQwwYTJWuGOnL22Z31vynrh6mWM3aloKuOJDrjZmUSBOPDbhY
         SzbjnAewIIqs+yDIbQjvbmTbumWusNy4pUaDP75z1RJqqCFJSSaoP/NdC02aagiquqkN
         JGMG69deJ+/Cb+KIRVIZmaLRtk/kpyd+hEqA/2m45Te/XN+3tv8dO24vDEdzaAOpuf5U
         NGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zanJ48XWx6afXcaPBWy/lKMTaJRgJmlSPIxFMmX4B34=;
        b=QiQOalx28jUDjXcsGHdihsOZWvMaN4iJLoqv/rTLOnaTOXpN7BlSK8qBhcicio8C3b
         nE7lUm2oJ3ZlcbvEM+GcluejRmUS0iTFKnfgdxmNVcYLuofbB3wMQLApsH7NrErmgN4Y
         uEP8IgrznOvA92z5IPgeL1/E4rO8CPlx607z3LoPr0s833Hfy4WVrxmC6EwTUJFT/uwt
         4RZ9WfDf7fdSlyVQlMVPfGcAC370afR/b63m2rOsE0ANyO3X6yZRIhsPhWnfYkyX0AhE
         rnREi18sh3xZJ3zJSumed4cE+Bc88VRSDctGj6JHjrFR0qdoBR3Iimiu7r3sVh+wfuMo
         A7lQ==
X-Gm-Message-State: AGi0PuZH1bpJdHWY9/lMTunK7m23a0q0i3udKqY3O4ul89DJmG7SKQR+
        fWOh6l9K48kiAHmb2ZVA3ULZac+M
X-Google-Smtp-Source: APiQypIFn+UPgMh8oTDcOjttBXywu5pHAH3kf5AudD1oTqzpi/U+tejaDkzfUpZEqOtNySAapkEOkg==
X-Received: by 2002:a2e:b5b9:: with SMTP id f25mr20346715ljn.11.1588161210689;
        Wed, 29 Apr 2020 04:53:30 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id e4sm1262409lfn.37.2020.04.29.04.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 04:53:29 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] sepolicy: fix some typos and port definitions #230
Date:   Wed, 29 Apr 2020 14:53:21 +0300
Message-Id: <20200429115321.21541-1-toiwoton@gmail.com>
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
index ff308fad..add837b6 100755
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
+                d[(src, protocol, perm)].append((i, ["all ports > 1023"]))
             elif i == "reserved_port_type":
                 d[(src, protocol, perm)].append((i, ["all ports < 1024"]))
             elif i == "rpc_port_type":
-                d[(src, protocol, perm)].append((i, ["all ports > 500 and  < 1024"]))
+                d[(src, protocol, perm)].append((i, ["all ports > 511 and < 1024"]))
             else:
                 try:
                     d[(src, protocol, perm)].append((i, portrecs[(i, protocol)]))
-- 
2.26.2

