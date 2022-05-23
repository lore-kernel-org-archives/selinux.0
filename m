Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEC7C4332F
	for <selinux@archiver.kernel.org>; Mon, 23 May 2022 07:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiEWHXz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 May 2022 03:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiEWHXg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 May 2022 03:23:36 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AAA32EDB
        for <selinux@vger.kernel.org>; Mon, 23 May 2022 00:15:13 -0700 (PDT)
Received: from brutus.. (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id 4D805FC06CC;
        Mon, 23 May 2022 09:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1653289627;
        bh=N3rYA3cjj6biVXhgKuEKOnP2q5mRmrz3kIVF+n0UNNU=;
        h=From:To:Cc:Subject:Date:From;
        b=ccs2DSfudB32bv8eRjfMjzJs/XDwLx75QCyPMRjOsUEU3EimwtunOa2CXiuiFfQSP
         smOKNygVyAyi1dCQ/hpkvKs8i+dPI3ccs66gbrA+wps2l1NPElI8JZr0yW2WL0kWby
         z8hdOq9LL9giGfLmWUz5PBo+dlgjcW8w868iAYvU=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH] network_support.md: clarify local port range and name_bind
Date:   Mon, 23 May 2022 09:06:52 +0200
Message-Id: <20220523070652.81984-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 src/network_support.md | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/network_support.md b/src/network_support.md
index bec725e..05ec0e8 100644
--- a/src/network_support.md
+++ b/src/network_support.md
@@ -668,6 +668,17 @@ statements):
 semanage port -a -t my_server_port_t -p tcp -r s0 12345
 ```
 
+Ports in the local port range can be auto-assigned by the kernel to
+unbound sockets on first use. Controlling binding to ports is only
+useful when the port number is a "name" (i.e. a well-defined value that
+is expected to correspond to a specific service).
+
+The *name_bind* operation is not controlled on sockets associated
+with ports in the local port range:
+```
+sysctl net.ipv4.ip_local_port_range
+```
+
 ## Labeled Network FileSystem (NFS)
 
 Version 4.2 of NFS supports labeling between client/server and requires
-- 
2.36.1

