Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D4EC43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 11:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCF220720
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 11:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="HKuB5bot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbgIJLBn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 07:01:43 -0400
Received: from mailomta14-re.btinternet.com ([213.120.69.107]:63680 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730624AbgIJK7k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 06:59:40 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20200909133046.TZMU21348.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658246; 
        bh=k7BuApAyARLlOa3DhQvt3GzjE/Ow9jrXky/+d7T4vGY=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=HKuB5botd125p2JWUY94Gn/6ZIr21c8zQ1YEwxiK4ckP/GzDMak3FumG0AbAM0gkMJwMSJdYiGyqpskMZMwMK5T0q88RsHf8aMqh+QqT4p+LpqjTGzhzdtWDXedXUyeYNPqc8qC4dwSbM1EhlI60GmWxUz0zhueIMQi3NlIov7MF/u0BAnDRqbtIrxQ+w+j59/n7DJQiyU3Lkw8TwsJbV8N2Byv39oDklzKPxY7QP6MSbWkPTcqqtrWCz2yoKUK5gJjBqwYbVe7Z5EqR06K7oETaH8u6ttXz8bFAa8AuTfFJI7dNND+qtQt1ncB9Ty1vTkIdHjteXcO92SOlMZbEJA==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirdduheegrdduheegrddufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehgedrudehgedrudeffedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134DE2; Wed, 9 Sep 2020 14:30:46 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 09/22] selinux_overview: Convert to markdown
Date:   Wed,  9 Sep 2020 14:30:26 +0100
Message-Id: <20200909133039.44498-10-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909133039.44498-1-richard_c_haines@btinternet.com>
References: <20200909133039.44498-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/selinux_overview.md | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/src/selinux_overview.md b/src/selinux_overview.md
index a71b762..33f00eb 100644
--- a/src/selinux_overview.md
+++ b/src/selinux_overview.md
@@ -14,34 +14,11 @@ Note: When SELinux is installed, there are three well defined directory
 locations referenced. Two of these will change with the old and new
 locations as follows:
 
-<table>
-<tbody>
-<tr style="background-color:#D3D3D3;">
-<td><strong>Description</strong></td>
-<td><strong>Old Location</strong></td>
-<td><strong>New Location</strong></td>
-</tr>
-<tr>
-<td><p>The SELinux filesystem that interfaces with the kernel based security server.</p>
-<p>The new location has been available since Fedora 17.</p></td>
-<td><em>/selinux</em></td>
-<td><em>/sys/fs/selinux</em></td>
-</tr>
-<tr>
-<td>The SELinux configuration directory that holds the sub-system configuration files and policies.</td>
-<td><em>/etc/selinux</em></td>
-<td>No change</td>
-</tr>
-<tr>
-<td><p>The SELinux policy store that holds policy modules and configuration details.</p>
-<p>The new location has been available since Fedora 23.</p></td>
-<td><p><em>/etc/selinux/</em></p>
-<p><em>&lt;SELINUXTYPE&gt;/module</em></p></td>
-<td><p><em>/var/lib/selinux/</em></p>
-<p><em>&lt;SELINUXTYPE&gt;</em></p></td>
-</tr>
-</tbody>
-</table>
+| Description | Old Location | New Location |
+| :---------  | :----------- | :----------- |
+The SELinux filesystem that interfaces with the kernel based security server. The new location has been available since Fedora 17. | */selinux* | */sys/fs/selinux* |
+| The SELinux configuration directory that holds the sub-system configuration files and policies. | */etc/selinux* | No change |
+| The SELinux policy store that holds policy modules and configuration details. The new location has been available since Fedora 23. | */etc/selinux/\<SELINUXTYPE\>/module* | */var/lib/selinux/\<SELINUXTYPE\>* |
 
 ## Is SELinux useful
 
-- 
2.26.2

