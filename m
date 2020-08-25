Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1456C433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970AC20706
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 08:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="t4/uS71N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgHYIiN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:38:13 -0400
Received: from mailomta9-sa.btinternet.com ([213.120.69.15]:39616 "EHLO
        sa-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbgHYIiJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 04:38:09 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20200825083806.VUFD4609.sa-prd-fep-047.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 25 Aug 2020 09:38:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598344686; 
        bh=ncoeVwrXq2mHkIdaguRE7za4z1JQFp+3/7BqGaF4lRc=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=t4/uS71NIDfz0Z9+OyPNWCNb90qYtiAy2Ch/3ODGx8uz4NnfZC0/iFXAI5UajMK0Prq7afcoGRdf+JAi8W39UxXdLEVqUAPS0q1qod4ehK23wO6lP5jL1klOP6Pyfk9Na80IKgJ9PrdUu2OZ9VDmKfsUNRSoqJYRdib0UPslJrNS7xfngB50uNF8jqhSXEusuhGZyXo1eCyItOLCHFCjyKlZfHs2t3dHcLUZeNAlgK2snnl8CeweAslHnn1ZXjsJB3GD0oZ0WVah/AX/4XlJDy3L6u7NZg2AS1zPKpxhGKSnTO0zXXU+ATDHCIvlNdNSBz7+9jGCUQvg2EAWWvtB+g==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [109.155.130.160]
X-OWM-Source-IP: 109.155.130.160 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeelteffgeevveejheevhfetgfeuveduteetuddtffdvjeekieetgeehveefjedtfeenucfkphepuddtledrudehhedrudeftddrudeitdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehhedrudeftddrudeitddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.155.130.160) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9B8A70D599D67; Tue, 25 Aug 2020 09:38:06 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 00/18] SELinux Notebook: Convert batch 1 to markdown
Date:   Tue, 25 Aug 2020 09:37:25 +0100
Message-Id: <20200825083743.6508-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Converted to Markdown. Added TOC to aid navigation where required.
No text changes.

Richard Haines (18):
  apache_support: Convert to markdown
  auditing: Convert to markdown
  avc_rules: Convert to markdown
  bounds_rules: Convert to markdown
  cil_overview: Convert to markdown
  class_permission_statements: Convert to markdown
  computing_access_decisions: Convert to markdown
  computing_security_contexts: Convert to markdown
  conditional_statements: Convert to markdown
  configuration_files: Convert to markdown
  constraint_statements: Convert to markdown
  core_components: Convert to markdown
  default_rules: Convert to markdown
  domain_object_transitions: Convert to markdown
  file_labeling_statements: Convert to markdown
  global_config_files: Convert to markdown
  implementing_seaware_apps: Convert to markdown
  infiniband_statements: Convert to markdown

 src/apache_support.md              |  79 ++--
 src/auditing.md                    | 300 ++++++-------
 src/avc_rules.md                   | 115 +++--
 src/bounds_rules.md                |  65 ++-
 src/cil_overview.md                |  63 ++-
 src/class_permission_statements.md | 231 ++++------
 src/computing_access_decisions.md  |  82 ++--
 src/computing_security_contexts.md | 662 +++++++++++++++--------------
 src/conditional_statements.md      | 159 +++----
 src/configuration_files.md         |  74 ++--
 src/constraint_statements.md       | 562 +++++++++++-------------
 src/core_components.md             | 211 +++++----
 src/default_rules.md               | 293 ++++++-------
 src/domain_object_transitions.md   | 121 +++---
 src/file_labeling_statements.md    | 260 +++++------
 src/global_config_files.md         | 389 +++++++++--------
 src/implementing_seaware_apps.md   | 218 +++++-----
 src/infiniband_statements.md       | 155 +++----
 18 files changed, 1876 insertions(+), 2163 deletions(-)

-- 
2.26.2

