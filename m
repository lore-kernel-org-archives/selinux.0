Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081FAC433DF
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 19:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6791207BB
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 19:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="TBu3rOVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgGUT5i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:57:38 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:56056 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgGUT5i (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 21 Jul 2020 15:57:38 -0400
Received: from localhost.localdomain (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 896052A1007;
        Tue, 21 Jul 2020 21:57:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 896052A1007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595361456;
        bh=QMoO9h0/Pm5EEATrgP7dI6Oay0211vrxf4SgIshbUwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBu3rOVcnh/bVdSHPF65Qd9G2biX69sBU6oM4mcoyqzoiRSkDpyL7Sym9p/9MJeST
         nzY40y0a9BvPr75fgfqGxpkROovjHT99sRUtRkPFNQIa2ktfnS50Qi/NCLrkvnqq+e
         6FtfQHebVHPhKJ/GttDMYYpoPiz9km+huHjEdipU=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH v2] lsm_selinux: document genfs_seclabel_symlinks policy capability
Date:   Tue, 21 Jul 2020 21:57:26 +0200
Message-Id: <20200721195726.1975554-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAEjxPJ49qjVJi1m-bJkaBg2ufx9xx5hPa_HupXbm-6eqXc_j5Q@mail.gmail.com>
References: <CAEjxPJ49qjVJi1m-bJkaBg2ufx9xx5hPa_HupXbm-6eqXc_j5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This was added with Linux 5.7 and SELinux 3.1

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
v2: copied and pasted feedback from Stephen Smalley

 src/lsm_selinux.md | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/lsm_selinux.md b/src/lsm_selinux.md
index a400c36..f762614 100644
--- a/src/lsm_selinux.md
+++ b/src/lsm_selinux.md
@@ -676,6 +676,11 @@ interface, it is not recommended - use the **libselinux** or **libsepol** librar
 <td>Enables the use of separate socket security classes for all network address families rather than the generic socket class.</td>
 </tr>
 <tr>
+<td>genfs_seclabel_symlinks</td>
+<td>-r--r--r--</td>
+<td>Enables fine-grained labeling of symlinks in pseudo filesystems based on genfscon rules.</td>
+</tr>
+<tr>
 <td>network_peer_controls</td>
 <td>-r--r--r--</td>
 <td><p>If true the following network_peer_controls are enabled:</p>
-- 
2.27.0

