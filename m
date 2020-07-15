Return-Path: <SRS0=JLv6=A2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DF6C433E1
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 14:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22544206D5
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 14:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVZs4NzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgGOOvJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:51:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45323 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725917AbgGOOvJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jul 2020 10:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594824668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1fvLIJmOwRL614IRTzUzRvcpKzmvu8HEJzgWfAQOOkY=;
        b=fVZs4NzD0/nBlnXJ5nUj3UP0A5KJVL+7L92eQK5O5kiryslDj5QZX6nPnpGO3VufUN7zEQ
        3PxpSDDvcCGod3fEq+1bykvq1TidvkTtD9iGC+ABbk6IWPz8100exfbEZm7HXFFx1IUzaX
        /jlA2DmO6WM5its6KJeDHyoKezSEMiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-kLxQ-1JiOTihBG6m4jD4VA-1; Wed, 15 Jul 2020 10:51:06 -0400
X-MC-Unique: kLxQ-1JiOTihBG6m4jD4VA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DA74107ACCA;
        Wed, 15 Jul 2020 14:51:02 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8603860BF1;
        Wed, 15 Jul 2020 14:50:51 +0000 (UTC)
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
Subject: [PATCH v5 0/6] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Date:   Wed, 15 Jul 2020 16:49:48 +0200
Message-Id: <20200715144954.1387760-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is v5 of the 'Introduce CAP_CHECKPOINT_RESTORE' patchset. The
changes to v4 are:

 * split into more patches to have the introduction of
   CAP_CHECKPOINT_RESTORE and the actual usage in different
   patches
 * reduce the /proc/self/exe patch to only be about
   CAP_CHECKPOINT_RESTORE

Adrian Reber (5):
  capabilities: Introduce CAP_CHECKPOINT_RESTORE
  pid: use checkpoint_restore_ns_capable() for set_tid
  pid_namespace: use checkpoint_restore_ns_capable() for ns_last_pid
  proc: allow access in init userns for map_files with CAP_CHECKPOINT_RESTORE
  selftests: add clone3() CAP_CHECKPOINT_RESTORE test

Nicolas Viennot (1):
  prctl: Allow checkpoint/restore capable processes to change exe link

 fs/proc/base.c                                |   8 +-
 include/linux/capability.h                    |   6 +
 include/uapi/linux/capability.h               |   9 +-
 kernel/pid.c                                  |   2 +-
 kernel/pid_namespace.c                        |   2 +-
 kernel/sys.c                                  |  12 +-
 security/selinux/include/classmap.h           |   5 +-
 tools/testing/selftests/clone3/Makefile       |   4 +-
 .../clone3/clone3_cap_checkpoint_restore.c    | 203 ++++++++++++++++++
 9 files changed, 236 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c


base-commit: d31958b30ea3b7b6e522d6bf449427748ad45822
-- 
2.26.2

