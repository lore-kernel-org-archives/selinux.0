Return-Path: <SRS0=PMFh=WB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8D9C0650F
	for <selinux@archiver.kernel.org>; Mon,  5 Aug 2019 20:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6058420665
	for <selinux@archiver.kernel.org>; Mon,  5 Aug 2019 20:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfHEUFT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:05:19 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:59486 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfHEUFS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Aug 2019 16:05:18 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 948985646E4
        for <selinux@vger.kernel.org>; Mon,  5 Aug 2019 22:05:12 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] libsemanage: include internal header to use the hidden function prototypes
Date:   Mon,  5 Aug 2019 22:04:34 +0200
Message-Id: <20190805200434.26911-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Aug  5 22:05:15 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When functions from libsemanage calls other functions that are exported,
these functions need to be "wrapped" using hidden_proto() macro. This is
done in headers such as "user_internal.h". Several functions in
genhomedircon.c are not doing this, which makes building with -flto
fail with errors such as:

    /usr/bin/ld: /tmp/libsemanage.so.1.KebOLC.ltrans1.ltrans.o: in
    function `user_sort_func':
    /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:758:
    undefined reference to `semanage_user_get_name'
    /usr/bin/ld:
    /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:758:
    undefined reference to `semanage_user_get_name'
    /usr/bin/ld: /tmp/libsemanage.so.1.KebOLC.ltrans1.ltrans.o: in
    function `fcontext_matches':
    /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:240:
    undefined reference to `semanage_fcontext_get_expr'
    /usr/bin/ld:
    /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:248:
    undefined reference to `semanage_fcontext_get_type'
    /usr/bin/ld: /tmp/libsemanage.so.1.KebOLC.ltrans1.ltrans.o: in
    function `add_user.isra.0':
    /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:992:
    undefined reference to `semanage_user_get_mlslevel'
    /usr/bin/ld: /tmp/libsemanage.so.1.KebOLC.ltrans1.ltrans.o: in
    function `write_context_file':
    /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:892:
    undefined reference to `semanage_user_key_create'
    /usr/bin/ld:
    /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:764:
    undefined reference to `semanage_user_get_name'
    /usr/bin/ld:
    /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:897:
    undefined reference to `semanage_user_query'
    /usr/bin/ld:
    /home/tkloczko/rpmbuild/BUILD/libsemanage-2.9-rc1/src/genhomedircon.c:905:
    undefined reference to `semanage_user_get_mlslevel'

Include the missing headers.

Fixes: https://github.com/SELinuxProject/selinux/issues/169

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/genhomedircon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index e5f8d3710e8a..d08c88de99a7 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -28,8 +28,10 @@
 #include <semanage/fcontexts_policy.h>
 #include <sepol/context.h>
 #include <sepol/context_record.h>
+#include "fcontext_internal.h"
 #include "semanage_store.h"
 #include "seuser_internal.h"
+#include "user_internal.h"
 #include "debug.h"
 
 #include "utilities.h"
-- 
2.22.0

