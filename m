Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA53C433F5
	for <selinux@archiver.kernel.org>; Fri, 27 May 2022 18:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343499AbiE0SF2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 May 2022 14:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiE0SF1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 May 2022 14:05:27 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019ADEC334
        for <selinux@vger.kernel.org>; Fri, 27 May 2022 11:05:26 -0700 (PDT)
Received: from brutus.. (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id 14FF0FC04B7;
        Fri, 27 May 2022 20:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1653674725;
        bh=HSH0PGkOoHmK1PswKsuttgJ/BnMHamU/i8AGACIHkrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBXD7vt9tG8RSqcNdfUXkuRfJLWzFrFGswW7mMUbt0dvHjopCVXfkl+mbALG0Lfk+
         Qw4XPRP4kCkbUgfznq7xBw4VkoykUNlt+V5qlP/3aXHal+xrTRl7tkIOooGEnkr3ha
         9K8MPReAYgXV5NSPaJb/8B4/1qXJip+63lA3LqNM=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Dominick Grift <dominick.grift@defensec.nl>
Subject: [PATCH v2] network_support.md: clarify local port range and name_bind
Date:   Fri, 27 May 2022 20:04:51 +0200
Message-Id: <20220527180451.302448-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAHC9VhSJUmLmeNQBc5-ornFqtB1v1ogjmwfVBN+VKg4qK7PSuA@mail.gmail.com>
References: <CAHC9VhSJUmLmeNQBc5-ornFqtB1v1ogjmwfVBN+VKg4qK7PSuA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
v2: rephrases the whole things

 src/network_support.md | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/network_support.md b/src/network_support.md
index bec725e..a8fe234 100644
--- a/src/network_support.md
+++ b/src/network_support.md
@@ -668,6 +668,14 @@ statements):
 semanage port -a -t my_server_port_t -p tcp -r s0 12345
 ```
 
+Only ports that fall outside the local, or ephemeral, port range are
+subject to the additional *name_bind* access check. You can see the
+current ephemeral port range on your system by checking the
+*net.ipv4.ip_local_port_range* sysctl:
+```
+sysctl net.ipv4.ip_local_port_range
+```
+
 ## Labeled Network FileSystem (NFS)
 
 Version 4.2 of NFS supports labeling between client/server and requires
-- 
2.36.1

