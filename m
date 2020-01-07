Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5838C33C8C
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 13:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873EC208C4
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 13:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3j+QV+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgAGNcC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:32:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46659 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728006AbgAGNcB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 08:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578403920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fp/293HNLFU91xHrQJ1y/97VQrAq2eqT3bmbSklivP8=;
        b=K3j+QV+1dLrRxYwopEu+U8Dn3OWSxhSzgjMIB9ak3y0Hnr2mzLd6ya/8gdoT/5Oj6TmaIb
        o2eR/48x6GmGl0zXZWejp8fivNiOZnpVtW1KRizMYuuSufzoVQDixbplnlApLzllO6+TDS
        DkYdJapQsmDiBJpml83ao/5UDavw45Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-2olPaBTMM62GxAD2xRESrw-1; Tue, 07 Jan 2020 08:31:58 -0500
X-MC-Unique: 2olPaBTMM62GxAD2xRESrw-1
Received: by mail-wr1-f71.google.com with SMTP id f17so14625583wrt.19
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2020 05:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fp/293HNLFU91xHrQJ1y/97VQrAq2eqT3bmbSklivP8=;
        b=igUYOMr8WQgEakrCQBZGWddc3f/MbyJfS6RjxKOozP4ugbCa/u9Y+CsZzH9tkCZycA
         xSSmbr3Q5nlXUrUXWm/rJo5v7/lY6t5QAOqrenEwu6X/VoLbiIDsvFrIdQPULXQ5scq9
         qKO16t3WIBeovrZlrMzt5pZfdCNqSJpkB5eq1BgYvmAsO2Fui/Ch1bPq/SfWUrk6ci9D
         OcNWHy+19V7zgIpo14TXHDUImDvRYpiE7gZgZeO8J5xTlLrCg9JreGFqiRRHvPEU4MtZ
         /Mf/AuxSXMEsbdH9hiUK5mWBChUKnhdmgSPHNs7h2Me5KonQDu0mZOW5L1wQ3LL9RMv9
         3VBQ==
X-Gm-Message-State: APjAAAWl+W+nc2Z6oAN5lurk7VXUrugvZaBYYy9Qiq7yFjMEXJj6cdlC
        TSFe50VJDgKjRk4oXQNZwDWhf4bONJ+xI9Ff3O9fsbOHCnG07O24aoUOaXU5fKn9/Y43SeXekbG
        Guf1GXD73uf00RYMkrg==
X-Received: by 2002:a7b:c10f:: with SMTP id w15mr38777685wmi.69.1578403917531;
        Tue, 07 Jan 2020 05:31:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqyWr8PxD9y++s6Ts14ifZfLAxpvtO6tz7TxGJsMnX4PCfK/TO+BcTKsa0YwnYejkCP9htBAZw==
X-Received: by 2002:a7b:c10f:: with SMTP id w15mr38777658wmi.69.1578403917289;
        Tue, 07 Jan 2020 05:31:57 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f207sm29097127wme.9.2020.01.07.05.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:31:56 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 0/2] LSM: Drop security_delete_hooks()
Date:   Tue,  7 Jan 2020 14:31:52 +0100
Message-Id: <20200107133154.588958-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a third iteration of the attempt to fix a race condition in
SELinux runtime disable. [1] [2]

This version takes the approach of removing the security_delete_hooks()
function (and CONFIG_SECURITY_WRITABLE_HOOKS) and just returning from
the hooks early when SELinux has been disabled on runtime. Note that the
runtime disable functionality is being deprecated and this is only a
temporary solution.

The first patch is an SMP semantics cleanup in SELinux; the second one
builds on top of it and does the actual conversion.

Tested on Fedora Rawhide by running selinux-testsuite with SELinux
enabled + boot tested with SELINUX=disabled. Also compile-tested with
all LSMs enabled in config.

[1] https://lore.kernel.org/selinux/20191211140833.939845-1-omosnace@redhat.com/T/
[2] https://lore.kernel.org/selinux/20191209075756.123157-1-omosnace@redhat.com/T/

Ondrej Mosnacek (2):
  selinux: treat atomic flags more carefully
  security,selinux: get rid of security_delete_hooks()

 include/linux/lsm_hooks.h           |  31 --
 security/Kconfig                    |   5 -
 security/apparmor/lsm.c             |   6 +-
 security/commoncap.c                |   2 +-
 security/loadpin/loadpin.c          |   2 +-
 security/lockdown/lockdown.c        |   2 +-
 security/security.c                 |   5 +-
 security/selinux/Kconfig            |   6 -
 security/selinux/hooks.c            | 763 ++++++++++++++++++++++++----
 security/selinux/include/security.h |  33 +-
 security/selinux/ss/services.c      |  38 +-
 security/smack/smack_lsm.c          |   4 +-
 security/tomoyo/tomoyo.c            |   6 +-
 security/yama/yama_lsm.c            |   2 +-
 14 files changed, 715 insertions(+), 190 deletions(-)

-- 
2.24.1

