Return-Path: <SRS0=JJ8R=XP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A39C4CEC9
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 10:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23882208C3
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 10:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTmS7Ftz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438043AbfITKPT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:15:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46445 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438011AbfITKPT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Sep 2019 06:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568974517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LwB6maefn672GUyMgYzQQdd0MI6d9iW1rawnZMRG2sI=;
        b=JTmS7FtzZNX/jK/zp7/1NxUzxGPwmafTtW6S8nI37X0DMjT++6UwavRXV07okik+RSBi0Y
        Lk5xJoeWkm8n4xsH8714W1/Jo+QaZsoMQ96mAQ8500KLiLcHsJMxrSK6szeQKSlAM2x9n/
        Zhfw3yuJRf+Fvja23cdJBYJ7gItXAJw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-sDw9DAK2OUqYXH08J6pspg-1; Fri, 20 Sep 2019 06:15:15 -0400
Received: by mail-wr1-f70.google.com with SMTP id t11so2085820wrq.19
        for <selinux@vger.kernel.org>; Fri, 20 Sep 2019 03:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zq0pIGNU2OSlrAUiKlV/yH528qNn4PkLIupSR0xpjGE=;
        b=ZR5BwsnAKrU0XJT8W3izZ/TwrIYTIIgPYM/IO48BZuwlI8h4BUzpOf1m5Mfyif7Rve
         CFK4yEau+YXj4PfP8H4Fyxh/QFaX1NyjgDmr+GijUAs8NM2b35aQa8xEq7x46exWkOuw
         5a7fyQWRQIMgADvbrODH2ygntG72rLr786pTh5bJHynGA80rODdSDVNxNLfdE0Cbd4kU
         j7U/tG740lSD6PeuJnE/fMG++v4Mmrd5H9IHs9vGi7gWuR6hPCrvqSZANGGYLD3qk1qf
         dk+TnNwC1BB68Y96yR4HW7tNMuvYnFdsTG+NnDBdOi6ac6Pah0ff2m3IVYPF9ow/Q8Tm
         7QPQ==
X-Gm-Message-State: APjAAAWoCzyAyU29poEk8ghy6bIWRpiu2dGbUp/mUyCfLO22p+UmJ9S8
        0/7KzEcDGwayP+39/yzWYTUdd4LCLMAmMeE3nmRHIJJIvb/LIN/dwpDdNyqmqQUWabTd/Zv+Jeu
        vh8PR1gwaWK9BY3m3OQ==
X-Received: by 2002:a1c:a796:: with SMTP id q144mr2832304wme.15.1568974513687;
        Fri, 20 Sep 2019 03:15:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzP55GwKHcYKp5r2homB4SDfMKUsIAKIwGDZyzalAvqmtYt2VXrzfXCt9THCRJ7wVSI7lzCBw==
X-Received: by 2002:a1c:a796:: with SMTP id q144mr2832276wme.15.1568974513339;
        Fri, 20 Sep 2019 03:15:13 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y14sm2246059wrd.84.2019.09.20.03.15.12
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 03:15:12 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 0/2] RFE: remove special RHEL-5 and -4 policies
Date:   Fri, 20 Sep 2019 12:15:08 +0200
Message-Id: <20190920101510.13907-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: sDw9DAK2OUqYXH08J6pspg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The first patch fixes a minor issue from a recent commit that breaks
the task_setscheduler test on very old kernels (RHEL-5).

The second patch then removes the special policies for RHEL-5 nad RHEL-4
(see the log message for more details).

Verified that the testsuite still runs on Fedora Rawhide and a handful
of RHELs after this change (RHEL-5 needs some workarounds to be applied
to policy files - see the log message of patch 2).

Ondrej Mosnacek (2):
  tests/task_setscheduler: fix for old kernels
  policy: remove RHEL-5 and RHEL-4 special policies

 policy/Makefile                          |  55 ++++--------
 policy/redhat/4/Makefile                 |  23 -----
 policy/redhat/4/test_attrib.te           |  38 --------
 policy/redhat/4/test_capable_file.te     |  46 ----------
 policy/redhat/4/test_capable_net.te      |  30 -------
 policy/redhat/4/test_capable_sys.te      |  15 ----
 policy/redhat/4/test_dyntrace.te         |  35 --------
 policy/redhat/4/test_dyntrans.te         |  20 -----
 policy/redhat/4/test_entrypoint.te       |  17 ----
 policy/redhat/4/test_execshare.te        |  24 -----
 policy/redhat/4/test_exectrace.te        |  33 -------
 policy/redhat/4/test_execute_no_trans.te |  20 -----
 policy/redhat/4/test_fdreceive.te        |  52 -----------
 policy/redhat/4/test_file.te             |  60 -------------
 policy/redhat/4/test_global.te           |  77 ----------------
 policy/redhat/4/test_inherit.te          |  41 ---------
 policy/redhat/4/test_ioctl.te            |  25 ------
 policy/redhat/4/test_ipc.te              |  63 -------------
 policy/redhat/4/test_link.te             |  49 -----------
 policy/redhat/4/test_mkdir.te            |  38 --------
 policy/redhat/4/test_open.te             |  23 -----
 policy/redhat/4/test_ptrace.te           |  28 ------
 policy/redhat/4/test_readlink.te         |  22 -----
 policy/redhat/4/test_relabel.te          |  28 ------
 policy/redhat/4/test_rename.te           |  76 ----------------
 policy/redhat/4/test_rxdir.te            |  21 -----
 policy/redhat/4/test_setattr.te          |  21 -----
 policy/redhat/4/test_setnice.te          |  23 -----
 policy/redhat/4/test_sigkill.te          |  29 ------
 policy/redhat/4/test_socket.te           |  92 -------------------
 policy/redhat/4/test_stat.te             |  18 ----
 policy/redhat/4/test_sysctl.te           |  21 -----
 policy/redhat/4/test_task_create.te      |  39 ---------
 policy/redhat/4/test_task_getpgid.te     |  22 -----
 policy/redhat/4/test_task_getsched.te    |  22 -----
 policy/redhat/4/test_task_getsid.te      |  22 -----
 policy/redhat/4/test_task_setpgid.te     |  36 --------
 policy/redhat/4/test_task_setsched.te    |  29 ------
 policy/redhat/4/test_transition.te       |  20 -----
 policy/redhat/4/test_wait.te             |  27 ------
 policy/redhat/5/Makefile                 |  36 --------
 policy/redhat/5/test_capable_file.te     |  64 --------------
 policy/redhat/5/test_capable_net.te      |  61 -------------
 policy/redhat/5/test_capable_sys.te      |  20 -----
 policy/redhat/5/test_dyntrace.te         |  48 ----------
 policy/redhat/5/test_dyntrans.te         |  32 -------
 policy/redhat/5/test_entrypoint.te       |  21 -----
 policy/redhat/5/test_execshare.te        |  43 ---------
 policy/redhat/5/test_exectrace.te        |  51 -----------
 policy/redhat/5/test_execute_no_trans.te |  26 ------
 policy/redhat/5/test_fdreceive.te        |  65 --------------
 policy/redhat/5/test_file.te             |  98 ---------------------
 policy/redhat/5/test_global.te           |  85 ------------------
 policy/redhat/5/test_inherit.te          |  64 --------------
 policy/redhat/5/test_ioctl.te            |  44 ----------
 policy/redhat/5/test_ipc.te              |  82 -----------------
 policy/redhat/5/test_link.te             |  73 ----------------
 policy/redhat/5/test_mkdir.te            |  59 -------------
 policy/redhat/5/test_open.te             |  35 --------
 policy/redhat/5/test_ptrace.te           |  47 ----------
 policy/redhat/5/test_readlink.te         |  36 --------
 policy/redhat/5/test_relabel.te          |  44 ----------
 policy/redhat/5/test_rename.te           | 107 -----------------------
 policy/redhat/5/test_rxdir.te            |  34 -------
 policy/redhat/5/test_setattr.te          |  31 -------
 policy/redhat/5/test_setnice.te          |  52 -----------
 policy/redhat/5/test_sigkill.te          |  49 -----------
 policy/redhat/5/test_stat.te             |  31 -------
 policy/redhat/5/test_sysctl.te           |  29 ------
 policy/redhat/5/test_task_create.te      |  53 -----------
 policy/redhat/5/test_task_getpgid.te     |  31 -------
 policy/redhat/5/test_task_getsched.te    |  31 -------
 policy/redhat/5/test_task_getsid.te      |  31 -------
 policy/redhat/5/test_task_setpgid.te     |  44 ----------
 policy/redhat/5/test_task_setsched.te    |  38 --------
 policy/redhat/5/test_transition.te       |  33 -------
 policy/redhat/5/test_wait.te             |  41 ---------
 policy/test_task_setsched.te             |   1 +
 tests/task_setscheduler/test             |   2 +-
 79 files changed, 18 insertions(+), 3134 deletions(-)
 delete mode 100644 policy/redhat/4/Makefile
 delete mode 100644 policy/redhat/4/test_attrib.te
 delete mode 100644 policy/redhat/4/test_capable_file.te
 delete mode 100644 policy/redhat/4/test_capable_net.te
 delete mode 100644 policy/redhat/4/test_capable_sys.te
 delete mode 100644 policy/redhat/4/test_dyntrace.te
 delete mode 100644 policy/redhat/4/test_dyntrans.te
 delete mode 100644 policy/redhat/4/test_entrypoint.te
 delete mode 100644 policy/redhat/4/test_execshare.te
 delete mode 100644 policy/redhat/4/test_exectrace.te
 delete mode 100644 policy/redhat/4/test_execute_no_trans.te
 delete mode 100644 policy/redhat/4/test_fdreceive.te
 delete mode 100644 policy/redhat/4/test_file.te
 delete mode 100644 policy/redhat/4/test_global.te
 delete mode 100644 policy/redhat/4/test_inherit.te
 delete mode 100644 policy/redhat/4/test_ioctl.te
 delete mode 100644 policy/redhat/4/test_ipc.te
 delete mode 100644 policy/redhat/4/test_link.te
 delete mode 100644 policy/redhat/4/test_mkdir.te
 delete mode 100644 policy/redhat/4/test_open.te
 delete mode 100644 policy/redhat/4/test_ptrace.te
 delete mode 100644 policy/redhat/4/test_readlink.te
 delete mode 100644 policy/redhat/4/test_relabel.te
 delete mode 100644 policy/redhat/4/test_rename.te
 delete mode 100644 policy/redhat/4/test_rxdir.te
 delete mode 100644 policy/redhat/4/test_setattr.te
 delete mode 100644 policy/redhat/4/test_setnice.te
 delete mode 100644 policy/redhat/4/test_sigkill.te
 delete mode 100644 policy/redhat/4/test_socket.te
 delete mode 100644 policy/redhat/4/test_stat.te
 delete mode 100644 policy/redhat/4/test_sysctl.te
 delete mode 100644 policy/redhat/4/test_task_create.te
 delete mode 100644 policy/redhat/4/test_task_getpgid.te
 delete mode 100644 policy/redhat/4/test_task_getsched.te
 delete mode 100644 policy/redhat/4/test_task_getsid.te
 delete mode 100644 policy/redhat/4/test_task_setpgid.te
 delete mode 100644 policy/redhat/4/test_task_setsched.te
 delete mode 100644 policy/redhat/4/test_transition.te
 delete mode 100644 policy/redhat/4/test_wait.te
 delete mode 100644 policy/redhat/5/Makefile
 delete mode 100644 policy/redhat/5/test_capable_file.te
 delete mode 100644 policy/redhat/5/test_capable_net.te
 delete mode 100644 policy/redhat/5/test_capable_sys.te
 delete mode 100644 policy/redhat/5/test_dyntrace.te
 delete mode 100644 policy/redhat/5/test_dyntrans.te
 delete mode 100644 policy/redhat/5/test_entrypoint.te
 delete mode 100644 policy/redhat/5/test_execshare.te
 delete mode 100644 policy/redhat/5/test_exectrace.te
 delete mode 100644 policy/redhat/5/test_execute_no_trans.te
 delete mode 100644 policy/redhat/5/test_fdreceive.te
 delete mode 100644 policy/redhat/5/test_file.te
 delete mode 100644 policy/redhat/5/test_global.te
 delete mode 100644 policy/redhat/5/test_inherit.te
 delete mode 100644 policy/redhat/5/test_ioctl.te
 delete mode 100644 policy/redhat/5/test_ipc.te
 delete mode 100644 policy/redhat/5/test_link.te
 delete mode 100644 policy/redhat/5/test_mkdir.te
 delete mode 100644 policy/redhat/5/test_open.te
 delete mode 100644 policy/redhat/5/test_ptrace.te
 delete mode 100644 policy/redhat/5/test_readlink.te
 delete mode 100644 policy/redhat/5/test_relabel.te
 delete mode 100644 policy/redhat/5/test_rename.te
 delete mode 100644 policy/redhat/5/test_rxdir.te
 delete mode 100644 policy/redhat/5/test_setattr.te
 delete mode 100644 policy/redhat/5/test_setnice.te
 delete mode 100644 policy/redhat/5/test_sigkill.te
 delete mode 100644 policy/redhat/5/test_stat.te
 delete mode 100644 policy/redhat/5/test_sysctl.te
 delete mode 100644 policy/redhat/5/test_task_create.te
 delete mode 100644 policy/redhat/5/test_task_getpgid.te
 delete mode 100644 policy/redhat/5/test_task_getsched.te
 delete mode 100644 policy/redhat/5/test_task_getsid.te
 delete mode 100644 policy/redhat/5/test_task_setpgid.te
 delete mode 100644 policy/redhat/5/test_task_setsched.te
 delete mode 100644 policy/redhat/5/test_transition.te
 delete mode 100644 policy/redhat/5/test_wait.te

--=20
2.21.0

