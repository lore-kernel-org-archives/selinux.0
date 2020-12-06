Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29DEC4167B
	for <selinux@archiver.kernel.org>; Sun,  6 Dec 2020 22:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FB3230FA
	for <selinux@archiver.kernel.org>; Sun,  6 Dec 2020 22:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgLFW52 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 6 Dec 2020 17:57:28 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:47190 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgLFW52 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 6 Dec 2020 17:57:28 -0500
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3C13E564E41
        for <selinux@vger.kernel.org>; Sun,  6 Dec 2020 23:56:46 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] GitHub Actions: drop Ruby 2.4 from matrix
Date:   Sun,  6 Dec 2020 23:56:25 +0100
Message-Id: <20201206225625.3077530-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206225625.3077530-1-nicolas.iooss@m4x.org>
References: <20201206225625.3077530-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Dec  6 23:56:46 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When migrating to Ubuntu 20.04, Ruby 2.4 is no longer available. As the
migration of "ubuntu-latest" to Ubuntu 20.04 is coming soon, according
to https://github.com/actions/virtual-environments/issues/1816, remove
it now.

Moreover the support of Ruby 2.4 ended a few months ago, so there is no
point at supporting bindings (and testing them) for this version:
https://www.ruby-lang.org/en/news/2020/04/05/support-of-ruby-2-4-has-ended/

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---

I hit this on https://github.com/fishilico/selinux/runs/1507627386?check_suite_focus=true
and the fix is simple.
I would like to keep using ubuntu-latest image in order to benefit from
automatic "LTS upgrade" when they become available. I find it better
than having to update the Ubuntu version by hand (like was done for the
Travis-CI configuration), because maintainers do not have to remember
to update the configuration file for GitHub Actions.

If you prefer using fixed Ubuntu versions (or even several Ubuntu
versions!), the configuration can be modified accordingly.

 .github/workflows/run_tests.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index d889b5d55604..ef4be8afc02f 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -24,7 +24,6 @@ jobs:
           # Test several Ruby versions with the latest Python version
           - {python: 3.9, ruby: 2.6}
           - {python: 3.9, ruby: 2.5}
-          - {python: 3.9, ruby: 2.4}
         exclude:
           - compiler: clang
             python-ruby-version: {python: 3.9, ruby: 2.7, other: linker-bfd}
-- 
2.29.2

