Return-Path: <SRS0=pOJ2=A7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389F3C433E0
	for <selinux@archiver.kernel.org>; Mon, 20 Jul 2020 14:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD9720672
	for <selinux@archiver.kernel.org>; Mon, 20 Jul 2020 14:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="lKPxYPYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGTOuq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:50:46 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:55432 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgGTOuq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 20 Jul 2020 10:50:46 -0400
Received: from localhost.localdomain (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id A28902A06FB;
        Mon, 20 Jul 2020 16:50:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl A28902A06FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595256643;
        bh=DdQ4WZOJ5yeJOmjznKlgDe5s+xwbveq9TRkR4ytI9OU=;
        h=From:To:Cc:Subject:Date:From;
        b=lKPxYPYV80/yVBFBiwLDbm4h/JlAE3n6dHIhpeRCP4FypNH4YoEhDEYu0F4wb4dEM
         jDWu8+V5ASWaqiQPwJ9AGYnyUfcyRet2k17DqMkHOxUlzfTZ5+DMDYGGnzCRjl9XNz
         LpkVkE3CdDMwhv6/oFpxdFRjZnUNnUL+R48QfnOw=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH] lsm_selinux: document genfs_seclabel_symlinks policy capability
Date:   Mon, 20 Jul 2020 16:50:30 +0200
Message-Id: <20200720145030.1743325-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This was added with Linux 5.7 and SELinux 3.1

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 src/lsm_selinux.md | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/lsm_selinux.md b/src/lsm_selinux.md
index a400c36..8e6f3ad 100644
--- a/src/lsm_selinux.md
+++ b/src/lsm_selinux.md
@@ -676,6 +676,11 @@ interface, it is not recommended - use the **libselinux** or **libsepol** librar
 <td>Enables the use of separate socket security classes for all network address families rather than the generic socket class.</td>
 </tr>
 <tr>
+<td>genfs_seclabel_symlinks</td>
+<td>-r--r--r--</td>
+<td>Symlinks on kernel filesystems will receive contexts based on genfscon statements like directories and files.</td>
+</tr>
+<tr>
 <td>network_peer_controls</td>
 <td>-r--r--r--</td>
 <td><p>If true the following network_peer_controls are enabled:</p>
-- 
2.27.0

