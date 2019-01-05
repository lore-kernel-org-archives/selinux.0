Return-Path: <SRS0=MvMz=PN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BF7C43387
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 19:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6CF222FE
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 19:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfAETiL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:38:11 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:36273 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAETiL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Jan 2019 14:38:11 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 721A45647F6
        for <selinux@vger.kernel.org>; Sat,  5 Jan 2019 20:38:08 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 0/5] Run tests in python/ with "make test"
Date:   Sat,  5 Jan 2019 20:37:54 +0100
Message-Id: <20190105193759.3333-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  5 20:38:09 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset follows 4 patches that I sent in December,
https://lore.kernel.org/selinux/20181221204333.27445-1-nicolas.iooss@m4x.org/T/
and makes changes to python/audit2allow/ testsuite in order to make
"make test" work for a non-root user on a non-SELinux system in all
directories. The main addition from this patchset is a dummy SELinux
policy that has been written in order to be able to run audit2allow
on python/audit2allow/test.log.

Each patch describes what it modifies. The full patch series in available on
https://github.com/SELinuxProject/selinux/pull/126

Nicolas Iooss (5):
  Travis-CI: download refpolicy and install headers
  python/audit2allow: make the tests useful again
  python/audit2allow: use local sepolgen-ifgen-attr-helper for tests
  python/sepolgen: refpolicy installs its Makefile in include/Makefile
  python: run all the tests with "make test"

 .travis.yml                              | 14 +++--
 python/Makefile                          |  4 +-
 python/audit2allow/.gitignore            |  1 +
 python/audit2allow/Makefile              |  8 ++-
 python/audit2allow/sepolgen-ifgen        |  8 ++-
 python/audit2allow/test_audit2allow.py   | 19 ++++--
 python/audit2allow/test_dummy_policy.cil | 75 ++++++++++++++++++++++++
 python/chcat/Makefile                    |  2 +
 python/sepolgen/src/sepolgen/defaults.py |  5 +-
 9 files changed, 116 insertions(+), 20 deletions(-)
 create mode 100644 python/audit2allow/test_dummy_policy.cil

-- 
2.20.1

