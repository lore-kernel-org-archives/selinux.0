Return-Path: <SRS0=stgd=CP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A4AC433E2
	for <selinux@archiver.kernel.org>; Sun,  6 Sep 2020 15:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E37020838
	for <selinux@archiver.kernel.org>; Sun,  6 Sep 2020 15:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="MFrWRyxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgIFP1e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 6 Sep 2020 11:27:34 -0400
Received: from mailomta29-sa.btinternet.com ([213.120.69.35]:17658 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728873AbgIFP1d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 6 Sep 2020 11:27:33 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20200906152730.ISAM5290.sa-prd-fep-040.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Sun, 6 Sep 2020 16:27:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599406050; 
        bh=3xywQ0pjGcH+eaJhDndF0xxVCjFFTNwx8deeyY7QQAg=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=MFrWRyxC++zeOdP026pi+MaF4ZxOON03LjYAzLr2YuCJbagYrgYhwzDsO0epBMdzouHQbGPIRXI+Bw65rp1kkkxlQdhmPrCUxCb5dlrhkBAkOCbQinVSHFdPqy2BXAlOgJf1JtTRN4xm1dQmOrfJCIGYa/fcRH/he/nDKh0Tl0Z/O9W3mOErAdTuX2wA3FB4bi7UZuuV8xIuKKTSXpk5ju2To7XN0A2kRrKxhVLfLFpfV/3pxF6xEhOkm1EjWf9Vh7SWToRsW6sW/FtB8afFYHYAZC9kDmubUGoC43fYepjQKXpvLgOwK408R3rBqp73WImoQtVCmsSYgDmWFSqSvA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [109.155.130.182]
X-OWM-Source-IP: 109.155.130.182 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudegjedgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejffehvdetheeuteetieduieefffeuteegueffheetueevtdeufeeivdfgfeeileenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhivghtfhdrohhrghenucfkphepuddtledrudehhedrudeftddrudekvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehhedrudeftddrudekvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhi
        nhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.182) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70F98D125; Sun, 6 Sep 2020 16:27:30 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] network_support: Update LibreSwan configuration
Date:   Sun,  6 Sep 2020 16:27:21 +0100
Message-Id: <20200906152721.16448-1-richard_c_haines@btinternet.com>
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
This was used to test the updated LibreSwan that now supports
selinux_check_access(3) from https://github.com/libreswan/libreswan

 src/network_support.md | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/src/network_support.md b/src/network_support.md
index 36af1f4..4a3fd38 100644
--- a/src/network_support.md
+++ b/src/network_support.md
@@ -452,11 +452,45 @@ Context type identifier has never been defined in any standard. Pluto is
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
+	authby=secret # set in '/etc/ipsec.secrets'
+	type=transport
+	left=192.168.1.198
+	right=192.168.1.148
+	ike=3des-sha1
+	phase2=esp
+	phase2alg=3des-sha1
+	# The 'policy-label' entry is used to determine whether SELinux will
+	# allow or deny the request using the labels from:
+	#   connection policy label from the applicable SAD entry
+	#   connection flow label from the applicable SPD entry (this is taken
+	#   from the 'conn <name> policy-label' entry).
+	# selinux_check_access(SAD, SPD, "association", "polmatch", NULL);
+	policy-label=system_u:object_r:ipsec_spd_t:s0
+	leftprotoport=tcp
+	rightprotoport=tcp
 ```
 
 The Fedora version of racoon has added functionality to support
-- 
2.26.2

