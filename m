Return-Path: <SRS0=FN9z=54=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44960C2BB85
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 08:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC382070A
	for <selinux@archiver.kernel.org>; Sun, 12 Apr 2020 08:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDLIKN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Apr 2020 04:10:13 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:37295 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgDLIKN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Apr 2020 04:10:13 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 291C95600AC
        for <selinux@vger.kernel.org>; Sun, 12 Apr 2020 10:10:12 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] libselinux: copy the reason why selinux_status_open() returns 1
Date:   Sun, 12 Apr 2020 10:10:00 +0200
Message-Id: <20200412081001.23246-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200412081001.23246-1-nicolas.iooss@m4x.org>
References: <20200412081001.23246-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Apr 12 10:10:12 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The function comment of selinux_status_open() states:

    It returns 0 on success, or -1 on error.

However the implementation of this function can also return 1. This is
documented in its manpage (libselinux/man/man3/selinux_status_open.3) as
intended. Copy the reason near the function definition in order to make
the code more auditable.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/sestatus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index ede5a28980bf..86267ff89646 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -250,7 +250,9 @@ static int fallback_cb_policyload(int policyload)
  * Since Linux 2.6.37 or later supports this feature, we may run
  * fallback routine using a netlink socket on older kernels, if
  * the supplied `fallback' is not zero.
- * It returns 0 on success, or -1 on error.
+ * It returns 0 on success, -1 on error or 1 when we are ready to
+ * use these interfaces, but netlink socket was opened as fallback
+ * instead of the kernel status page.
  */
 int selinux_status_open(int fallback)
 {
-- 
2.26.0

