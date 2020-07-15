Return-Path: <SRS0=JLv6=A2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC2FC433E6
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 14:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7F1206D5
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 14:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCNM5aYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgGOOxH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:53:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55667 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726858AbgGOOxD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jul 2020 10:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594824782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YrIQ7usHt/ICUIVG/4Zzx10RZSX03Ne/OGNOYc1RqJU=;
        b=KCNM5aYqJ/1VQbSvnu1+TFwUE5vGLQRflnY/U8zdu7Wzr8K7EN2GwFz+/uGaBmoS/SLOIz
        BV6Gf7Ml1UttQugxItEhIEDQknDx7fk4m47k4HCbjfZuol8ZBwSGYHOpGiLrAxLzp85HDV
        dp0iI3f5LnOBQLloxgp/1fUyMvId1SM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-OOnXwcsxNimB7eMBtWwEKw-1; Wed, 15 Jul 2020 10:51:49 -0400
X-MC-Unique: OOnXwcsxNimB7eMBtWwEKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEEDE18A1DE7;
        Wed, 15 Jul 2020 14:51:45 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03C7E60BF1;
        Wed, 15 Jul 2020 14:51:32 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?q?Micha=C5=82=20C=C5=82api=C5=84ski?= 
        <mclapinski@google.com>, Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 4/6] proc: allow access in init userns for map_files with CAP_CHECKPOINT_RESTORE
Date:   Wed, 15 Jul 2020 16:49:52 +0200
Message-Id: <20200715144954.1387760-5-areber@redhat.com>
In-Reply-To: <20200715144954.1387760-1-areber@redhat.com>
References: <20200715144954.1387760-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Opening files in /proc/pid/map_files when the current user is
CAP_CHECKPOINT_RESTORE capable in the root namespace is useful for
checkpointing and restoring to recover files that are unreachable via
the file system such as deleted files, or memfd files.

Signed-off-by: Adrian Reber <areber@redhat.com>
Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
---
 fs/proc/base.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 65893686d1f1..cada783f229e 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2194,16 +2194,16 @@ struct map_files_info {
 };
 
 /*
- * Only allow CAP_SYS_ADMIN to follow the links, due to concerns about how the
- * symlinks may be used to bypass permissions on ancestor directories in the
- * path to the file in question.
+ * Only allow CAP_SYS_ADMIN and CAP_CHECKPOINT_RESTORE to follow the links, due
+ * to concerns about how the symlinks may be used to bypass permissions on
+ * ancestor directories in the path to the file in question.
  */
 static const char *
 proc_map_files_get_link(struct dentry *dentry,
 			struct inode *inode,
 		        struct delayed_call *done)
 {
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_CHECKPOINT_RESTORE))
 		return ERR_PTR(-EPERM);
 
 	return proc_pid_get_link(dentry, inode, done);
-- 
2.26.2

