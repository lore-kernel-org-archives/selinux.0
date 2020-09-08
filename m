Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE68C43461
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 07:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B6E21D42
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 07:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="OhN+h0aC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgIHHkW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:40:22 -0400
Received: from mailomta18-sa.btinternet.com ([213.120.69.24]:34033 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729257AbgIHHkT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Sep 2020 03:40:19 -0400
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200908074015.DHLP4139.sa-prd-fep-048.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 8 Sep 2020 08:40:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599550815; 
        bh=5fYXjsYT19r9/jzkLYJ+QtLqqIJ7JXLRqXmumdMWtVg=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=OhN+h0aCoa9Oyq55iuTc5RsSvFFjwDGxYaXFzf9ys1y+soLSoRMgawJEc3hzJHWl6ddcek8n3zbSgPHPXYw6IAIQvEILtvTEFpqsY+AEmMkGS20jLp5YFkzBoQoPTg7ah9CRNlTe09uvJ/j5IbBfze2sPewN8Ku/Z9y19vQ1SydMgoUDfmnaJcL5PCFTtjMqX4zNXGyhbuk8UqjhubkrXVZFTXZDgPcNZg57jFhsUcSq0gT/i4vTr44XNTMLmv0N1+o3DCDmG5slcKVbUGZd8EJaj7iS0uI8lChgCLOC7DVzqbAr2n984m9WZ8LRTD8JEg6PhIV2xgC2NrXXgFMOWQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.184.36.199]
X-OWM-Source-IP: 86.184.36.199 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehuddguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleeijeduudeuveevgfeltdehueekkeefvdettdffiefhlefhveejveehleefgeevnecuffhomhgrihhnpehivghtfhdrohhrghenucfkphepkeeirddukeegrdefiedrudelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddukeegrdefiedrudelledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgv
        lhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.184.36.199) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9AFBE0FDE702D; Tue, 8 Sep 2020 08:40:15 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2] network_support: Update LibreSwan configuration
Date:   Tue,  8 Sep 2020 08:40:03 +0100
Message-Id: <20200908074003.3526-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update ipsec.conf file that describes the labeled ipsec entries.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Change: Update encryption algorithms and add note as suggested by
Topi Miettinen.

 src/network_support.md | 45 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/src/network_support.md b/src/network_support.md
index 36af1f4..1103c70 100644
--- a/src/network_support.md
+++ b/src/network_support.md
@@ -452,11 +452,52 @@ Context type identifier has never been defined in any standard. Pluto is
 configurable and defaults to '*32001*', this is the IPSEC Security
 Association Attribute identifier reserved for private use. Racoon is
 hard coded to a value of '*10*', therefore the pluto ***ipsec.conf**(5)*
-file must be configured as follows:
+configuration file *secctx-attr-type* entry must be set as shown in the
+following example:
 
 ```
 config setup
-        secctx-attr-type=10
+	protostack=netkey
+	plutodebug=all
+	logfile=/var/log/pluto/pluto.log
+	logappend=no
+	# A "secctx-attr-type" MUST be present:
+	secctx-attr-type=10
+	# Labeled IPSEC only supports the following values:
+	#   10 = ECN_TUNNEL - Used by racoon(8)
+	#   32001 = Default - Reserved for private use (see RFC 2407)
+	# These are the "IPSEC Security Association Attributes"
+
+conn selinux_labeled_ipsec_test
+	# ikev2 MUST be "no" as labeled ipsec is not yet supported by IKEV2
+	# There is a draft IKEV2 labeled ipsec document (July '20) at:
+	#   https://tools.ietf.org/html/draft-ietf-ipsecme-labeled-ipsec-03
+	ikev2=no
+	auto=start
+	rekey=no
+	authby=secret	# set in '/etc/ipsec.secrets'. See NOTE
+	type=transport
+	left=192.168.1.198
+	right=192.168.1.148
+	ike=aes256-sha2		# See NOTE
+	phase2=esp
+	phase2alg=aes256	# See NOTE
+	# The 'policy-label' entry is used to determine whether SELinux will
+	# allow or deny the request using the labels from:
+	#   connection policy label from the applicable SAD entry
+	#   connection flow label from the applicable SPD entry (this is taken
+	#   from the 'conn <name> policy-label' entry).
+	# selinux_check_access(SAD, SPD, "association", "polmatch", NULL);
+	policy-label=system_u:object_r:ipsec_spd_t:s0
+	leftprotoport=tcp
+	rightprotoport=tcp
+
+# NOTE:
+#   The authentication methods and encryption algorithms should be chosen
+#   with care and within the constraints of those available for
+    interoperability.
+#   Racoon is no longer actively supported and has a limited choice of
+#   algorithms compared to LibreSwan.
 ```
 
 The Fedora version of racoon has added functionality to support
-- 
2.26.2

