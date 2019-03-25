Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0A0C43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 23:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03392080F
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 23:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YVEgQ4rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfCYXVe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:21:34 -0400
Received: from sonic316-20.consmr.mail.bf2.yahoo.com ([74.6.130.194]:34924
        "EHLO sonic316-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729169AbfCYXVe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 19:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1553556092; bh=OPa6BzwieAd3ck7F5PXhSVVl8GFNJdNNg68Exnp8qHg=; h=From:To:Cc:Subject:Date:From:Subject; b=YVEgQ4rWw5O9ZA811JSnft9Li5RV4BgcXr4BoGGs3+Xeumg5h1d9b2mOYqA+hPi2GPwHLndaXCxgwubeZWLlPN3yllFGu2B/7IaAWcH0RpP4+4Vrm6siJClVcoKWOfGiXp0CBYu8+nS9QkfNh8cG27jr5rJbvJZZqhzBPZTJv/FRwsbxi1ugkyc5sV9itvrWx6V27qDxoL38bvLyMMaTg5gz/vE5xKwIeTJhr8r0yKYaurDrdzBLQH1oVJSf3Ns1laQ2Tg0eMjnpdh+GyNuUaoMLdueBUrcxvyEt7alQrpd2OR0JycV3DsJs5p+1dn0bGk2t16DjYsLUb/IfaPewKw==
X-YMail-OSG: aMGv_csVM1kZQ8P9REHObUv6agHER.i2de_e1RseCdwJ07nVZ5gwHmI0Um5aESL
 1MwTBnxqAuwleECNlqZiVcwAcveSc1KY.cGVSuCcws9_faa6ufJ1whnXzXde1bukIi0YE1gHAd3n
 V_H2gDImMX7o3zOYeN7tfJNxirY7Gyup9qR6UGD6PmPE4EkONAREI7GyRgdMPl4zSFSOKa4FGK4y
 tnyqsutI1ISQMrHkavVeSWivDBeoo1xsccghqWvYzLHYYA0xmF.Mmiqy4GyaCfzwFHVO.feHze1r
 0Z7c.4MFbys4oJDPfqzQHGMnwGtfUOwpKc9yhMoSlfpqg1NiTpx1iKVofFk..qxpWvnT8hwKFH.2
 5dGfU_RzzDsVfR827EZOg3rQomm7FtNuxVml6r6cPPdAUHY6IkNKCtC96tTiYSXQeH44YPrywBjr
 iDRO_FLc_ZUkx56eZwkC85AnmA_w29xfMMVwnn6VM69ibHb_arPGVIHEIu7AREPz1.mPj0N7vYuc
 ysmOeiPnzC2JMEW9QqVjFYD.J44GCc_XMJSBYYh15QPiyG4YXi0AlaXBax0Y0EIzb6KdB4ytwIJS
 D9ALRWWZB_Nhla9zV_lhK.AmmQ_R3K_ZOtm3PUITmA6sv21c6fD_0clj9AK1uXs3cJtwC8hjhwb5
 SIL0FS9B81djry6QL5NDNDvxHX.pEmWOymEDAU0GOHA0DgV0VWoTLerIpKusDRVkUQBYi7r8DnTZ
 ayH7xQpEzQhJaMA5_Q70D5Y358b1y8dp8pgAqFg82f5r6MukGkCTJItuTz4dA3o7m3ejczUusqrv
 1DHsfknk57yBmO4f3FjvkSfWYf0xbcV7hByYkTJI4EziQ2B3wYqF.sZhOeBUHdqEd8pMNKLbMuyY
 2KNMWpal6FFKRH1T8iOJR5e8496UVRN2rTymJjTwPKsif9tK3X4k5jgqWe5qELoSUvTIsiM3M7vC
 PerkYCHf4jn6rIgnwa.IQujh4GOKIOCNuLuYQDvbDls_e2RZR8lcPgNOpj_9ISCk9Iou8oZ2Oyrx
 seO8Qh0GPK3g54F6I_28K2rWuYD3MZzJFZZqGrPkAhLRgSGTI5vIR1iicCirKpLLQZ6XYXM0WkoB
 THg.hgkyRaSjuUkQeuXMNUrDYv4u0R1AQed1emagLkEFODGbmI.oWYEdQ55Rvanqhz5C_qSWrbwc
 PpKrcyueZfjs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Mon, 25 Mar 2019 23:21:32 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp409.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e26c4d0f6d26ceb6b75f9dad13ba1718;
          Mon, 25 Mar 2019 23:21:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     joe@perches.com, linux-kernel@vger.kernel.org
Cc:     casey@schaufler-ca.com, paul@paul-moore.com, sds@tycho.nsa.gov,
        eparis@parisplace.org, selinux@vger.kernel.org,
        keescook@chromium.org
Subject: [PATCH] Bad file pattern in 'SELINUX SECURITY MODULE'
Date:   Mon, 25 Mar 2019 16:21:25 -0700
Message-Id: <20190325232125.1781-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The include/linux/selinux.h file has been removed.
Remove the entry from the MAINTAINERS file.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..1039c34dff3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13947,7 +13947,6 @@ W:	https://selinuxproject.org
 W:	https://github.com/SELinuxProject
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 S:	Supported
-F:	include/linux/selinux*
 F:	security/selinux/
 F:	scripts/selinux/
 F:	Documentation/admin-guide/LSM/SELinux.rst
