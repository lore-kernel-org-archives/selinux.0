Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38088C433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 07:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9103820720
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 07:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="rD6Sc6dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgGIHvN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:51:13 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:57498 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgGIHvM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 9 Jul 2020 03:51:12 -0400
Received: from localhost.localdomain (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id C2DEC2A0EFE;
        Thu,  9 Jul 2020 09:51:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl C2DEC2A0EFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1594281067;
        bh=0qKqn6cac54FlOdkL2ebAxHJf9P9kp7ct/sQwwq7bhI=;
        h=From:To:Cc:Subject:Date:From;
        b=rD6Sc6dl9RlKFm+aLS8WE2gTEWxHtckm055cPaVwoFw4aEY/eH+6hQn5otPwLrBKX
         7Y5NXoqzlC3H1i4/NgSn/Vaa+gRNqRrQYTIireAjdKd6F4sVCpuwem3nsh3vuK9ByC
         2J6T+Y2Jay1ciR4Ikm07F2ICvel+TGFbl/8N5uCg=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH] auditing.md: describe avc record permissive keyword
Date:   Thu,  9 Jul 2020 09:50:56 +0200
Message-Id: <20200709075056.1670642-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This was added to Linux 4.17 via "selinux: Report permissive mode in avc: denied messages."

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 src/auditing.md | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/auditing.md b/src/auditing.md
index 19f8be6..295373a 100644
--- a/src/auditing.md
+++ b/src/auditing.md
@@ -161,6 +161,12 @@ section that follows.
 <td>tclass</td>
 <td>The object class of the target or object.</td>
 </tr>
+<tr>
+<td>permissive</td>
+<td>Keyword introduced in Linux 4.17 to indicate whether the event
+was denied or granted due to global or per-domain permissive
+mode.</td>
+</tr>
 </tbody>
 </table>
 
-- 
2.27.0

