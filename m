Return-Path: <SRS0=npki=DT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18DAC433E7
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 22:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2352078E
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 22:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="DMaI3BB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388307AbgJLWNv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Oct 2020 18:13:51 -0400
Received: from mailomta26-re.btinternet.com ([213.120.69.119]:20524 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387733AbgJLWNu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Oct 2020 18:13:50 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20200909133042.UPNA13627.re-prd-fep-042.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 9 Sep 2020 14:30:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1599658242; 
        bh=AKrFNfLYzS50hJcYOeS3La6OMyOU/4JQ7jmFutT7QrI=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=DMaI3BB+qjDzUVL4/hpqomIaggrX6//b010qXmhlrSayI7hndLcn6Mu8CgHKtWAdfc6c2B142yDN0xBB3+mDNrqgCY81sdXO6zCYdT9+sgDTvb9T6KtaeDi4vTb2I0gdZ+C8woEQapFtDGx3wWqKYMR8OLvZs+qJrvLh3pK7bkWWcdbVRaaz/ra3a+yo/n/As1g5w6rdhKmNoXXIWgRPeBpWQJAbbk1KLetzf7XFGYF8kZCPP6q2sgWRgj1vn3m7W0IgV/dbIdS2HMDhacjFw13hdxO4SN6uJwEYb6xKcHEI2LWBGcooaNWTBCFMJf+W8soMGfumcqMrgR9H8JPw1A==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.154.154.133]
X-OWM-Source-IP: 86.154.154.133 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeelteffgeevveejheevhfetgfeuveduteetuddtffdvjeekieetgeehveefjedtfeenucfkphepkeeirdduheegrdduheegrddufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudehgedrudehgedrudeffedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.154.154.133) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD10134D55; Wed, 9 Sep 2020 14:30:42 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 00/22] SELinux Notebook: Convert batch 3 to markdown/tidy up
Date:   Wed,  9 Sep 2020 14:30:17 +0100
Message-Id: <20200909133039.44498-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Converted to Markdown or just tidy up formatting. Added TOC to aid
navigation where required.
No text changes.

This is the final batch of basic changes that should bring the sections to
a standard markdown format. The reference_policy.md update to tidy up the
formatting is large so I'll send patch direct to Paul (no text changes).

The only two sections left are: lsm_selinux.md and mls_mcs.md - These
require moving and updating text to convert to markdown, will send
each separately.

Richard Haines (22):
  kernel_policy_language: Tidy up formatting
  mls_statements: Convert to markdown
  object_classes_permissions: : Tidy up formatting
  policy_config_files: Tidy up formatting
  policy_validation_example: Tidy up formatting
  postgresql: Tidy up formatting
  security_context: Convert to markdown
  selinux_cmds: Convert to markdown
  selinux_overview: Convert to markdown
  sid_statement: Convert to markdown
  subjects: Convert to markdown
  toc: Tidy up formatting
  type_enforcement: Convert to markdown
  type_statements: Convert to markdown
  types_of_policy: Convert to markdown
  user_statements:: Tidy up formatting
  users: Tidy up formatting
  userspace_libraries: Tidy up formatting, add toc
  vm_support: Tidy up formatting
  x_windows: Tidy up formatting
  xen_statements: Tidy up formatting
  xperm_rules: Tidy up formatting

 src/kernel_policy_language.md     | 106 +++----
 src/mls_statements.md             | 461 +++++++++++-------------------
 src/object_classes_permissions.md | 299 +++++++++----------
 src/policy_config_files.md        | 442 ++++++++++++++--------------
 src/policy_validation_example.md  |   3 +-
 src/postgresql.md                 |  19 +-
 src/security_context.md           |  83 +++---
 src/selinux_cmds.md               | 256 ++++++++---------
 src/selinux_overview.md           |  33 +--
 src/sid_statement.md              | 119 +++-----
 src/subjects.md                   |  21 +-
 src/toc.md                        | 120 ++++----
 src/type_enforcement.md           |   9 +-
 src/type_statements.md            |  33 ++-
 src/types_of_policy.md            | 359 +++++++++++------------
 src/user_statements.md            |  10 +-
 src/users.md                      |   2 +-
 src/userspace_libraries.md        |  58 ++--
 src/vm_support.md                 |  84 +++---
 src/x_windows.md                  |  52 ++--
 src/xen_statements.md             |  16 +-
 src/xperm_rules.md                |  28 +-
 22 files changed, 1223 insertions(+), 1390 deletions(-)

-- 
2.26.2

