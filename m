Return-Path: <SRS0=HCsx=62=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F70CA90AF
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 19:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3773B20731
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 19:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgELTaL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 15:30:11 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:46526 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELTaK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 May 2020 15:30:10 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 4821C565C54
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 21:30:08 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/sepolicy: silence new flake8 warnings
Date:   Tue, 12 May 2020 21:29:57 +0200
Message-Id: <20200512192957.112866-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue May 12 21:30:08 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

pyflakes 2.2.0 improved the way format strings are analyzed, which
triggers new warnings in flake8:

    python/sepolicy/sepolicy/manpage.py:1046:23: F999 '...' % ... has
    unused named argument(s): type

    python/sepolicy/sepolicy/manpage.py:1225:23: F999 '...' % ... has
    unused named argument(s): user

Remove the unused arguments in order to silence these warnings.

This fixes failures in Travis-CI such as
https://travis-ci.org/github/SELinuxProject/selinux/jobs/686230518#L5153

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/manpage.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 442608191cc8..3e8a3be907e3 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -1074,7 +1074,7 @@ If you wanted to change the default user mapping to use the %(user)s_u user, you
 
 .B semanage login -m -s %(user)s_u __default__
 
-""" % {'desc': self.desc, 'type': self.type, 'user': self.domainname, 'range': self._get_users_range()})
+""" % {'desc': self.desc, 'user': self.domainname, 'range': self._get_users_range()})
 
         if "login_userdomain" in self.attributes and "login_userdomain" in self.all_attributes:
             self.fd.write("""
@@ -1245,7 +1245,7 @@ Execute the following to see the types that the SELinux user %(type)s can execut
 
 .B $ sesearch -A -s %(type)s -c process -p transition
 
-""" % {'user': self.domainname, 'type': self.type})
+""" % {'type': self.type})
 
     def _role_header(self):
         self.fd.write('.TH  "%(user)s_selinux"  "8"  "%(user)s" "mgrepl@redhat.com" "%(user)s SELinux Policy documentation"'
-- 
2.26.2

