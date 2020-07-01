Return-Path: <SRS0=TSKA=AM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26206C433DF
	for <selinux@archiver.kernel.org>; Wed,  1 Jul 2020 06:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9EEE2074D
	for <selinux@archiver.kernel.org>; Wed,  1 Jul 2020 06:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEVIKlDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgGAGtj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:49:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39627 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgGAGtj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Jul 2020 02:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593586178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hToiU5LeJAAlC9l0X3eoMf5GmV669rRbGsOZZ5vcImA=;
        b=VEVIKlDxys8SCCyFjan3k4mJ0EUszUZgFz4Y9BvQPOtQucULbyeG9gWUQVXxQ/1mvfHyqr
        L/5FcHB1hemESjY7tY0fs3+w+ohRk+E851WBb3LW+DAHUsAS53ATOjIMFvKZH+ey0HYnGq
        /frIo3z4RKZNlrHrbYREc5tjD4mdGrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-E6P5FSFWO06ES6NUoi0Giw-1; Wed, 01 Jul 2020 02:49:34 -0400
X-MC-Unique: E6P5FSFWO06ES6NUoi0Giw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4ADFD80183C;
        Wed,  1 Jul 2020 06:49:31 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-113-12.ams2.redhat.com [10.36.113.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DB982B4AD;
        Wed,  1 Jul 2020 06:49:20 +0000 (UTC)
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
Subject: [PATCH v4 0/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Date:   Wed,  1 Jul 2020 08:49:03 +0200
Message-Id: <20200701064906.323185-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is v4 of the 'Introduce CAP_CHECKPOINT_RESTORE' patchset. There
is only one change from v3 to address Jann's comment on patch 3/3

 (That is not necessarily true in the presence of LSMs like SELinux:
 You'd have to be able to FILE__EXECUTE_NO_TRANS the target executable
 according to the system's security policy.)

Nicolas updated the last patch (3/3). The first two patches are
unchanged from v3.

Adrian Reber (2):
  capabilities: Introduce CAP_CHECKPOINT_RESTORE
  selftests: add clone3() CAP_CHECKPOINT_RESTORE test

Nicolas Viennot (1):
  prctl: Allow ptrace capable processes to change /proc/self/exe

 fs/proc/base.c                                |   8 +-
 include/linux/capability.h                    |   6 +
 include/linux/lsm_hook_defs.h                 |   1 +
 include/linux/security.h                      |   6 +
 include/uapi/linux/capability.h               |   9 +-
 kernel/pid.c                                  |   2 +-
 kernel/pid_namespace.c                        |   2 +-
 kernel/sys.c                                  |  12 +-
 security/commoncap.c                          |  26 +++
 security/security.c                           |   5 +
 security/selinux/hooks.c                      |  14 ++
 security/selinux/include/classmap.h           |   5 +-
 tools/testing/selftests/clone3/Makefile       |   4 +-
 .../clone3/clone3_cap_checkpoint_restore.c    | 203 ++++++++++++++++++
 14 files changed, 285 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c


base-commit: f2b92b14533e646e434523abdbafddb727c23898
-- 
2.26.2

