Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E284CC169C4
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B0A218AC
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfAaVIN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:08:13 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:49259 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfAaVIN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Jan 2019 16:08:13 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9834B5646AB
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 22:08:10 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 0/3] Support flake8 version 3.7
Date:   Thu, 31 Jan 2019 22:07:50 +0100
Message-Id: <20190131210753.11221-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jan 31 22:08:10 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

flake8 3.7.0, 3.7.1, 3.7.2 and 3.7.3 were released on 2019-01-29 and
2019-01-30 (cf. http://flake8.pycqa.org/en/latest/release-notes/3.7.0.html).
These releases introduced new warnings, which broke building with
Travis-CI (cf. https://travis-ci.org/fishilico/selinux/builds/487098420).

Fix Travis-CI's builds by fixing the warnings that are now reported.
The first two commits are related to coding style and the third one is
a fix for an actual bug.


Nicolas Iooss (3):
  python: reindent lines that were over-indented
  python: use == or != when comparing a variable with a string or a
    integer
  python/sepolicy: fix variable name

 python/semanage/semanage                  | 118 ++++++------
 python/sepolgen/src/sepolgen/output.py    |   6 +-
 python/sepolgen/src/sepolgen/refparser.py |   2 +-
 python/sepolgen/src/sepolgen/yacc.py      | 214 +++++++++++-----------
 python/sepolicy/sepolicy/generate.py      |   4 +-
 python/sepolicy/sepolicy/gui.py           |   2 +-
 python/sepolicy/sepolicy/interface.py     |   8 +-
 python/sepolicy/sepolicy/manpage.py       |   4 +-
 8 files changed, 179 insertions(+), 179 deletions(-)

-- 
2.20.1

