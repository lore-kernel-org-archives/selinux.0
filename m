Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C1AC432C0
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 14:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E26620659
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 14:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9wbu47x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfKROwq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:52:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40612 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727140AbfKROwq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 09:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574088764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YA77x+4PA0qaAsOTR4t/Bl4as0UKWpCesCnEV6xwFR0=;
        b=N9wbu47xNwdg9nnHrQHBeP3a1rXeGYWSXf1KmCHb+oOH/eZGMwx7N3JmtFQ+qGghQbV7LZ
        hGyj4/88HdtsHr0lduSZQN/mbNvvsGVbFhBjtYrou7z8Y5+ttfXRGKhOI4xNnXIHvAzxMy
        z7SpCqmb13r7WnIZK412MG3jof8hl1U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-K_bDYUsMO96ofL3FVYtMaw-1; Mon, 18 Nov 2019 09:52:41 -0500
Received: by mail-wr1-f71.google.com with SMTP id e10so15362928wrt.16
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2019 06:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdrqQyBgjLnoJVNufGA0KbMbzvfP1CLHphimIOO60r4=;
        b=Teml4fYprnfFxguwXYYkvkMU3Dan5nUYvw39e41xtq1gBATo5BlELW1+8Ip1DNjUO+
         vk2gr97Alsbg9YT3REcR2IgnCfeZ90D6BllhvD4bxrtz6Njjb+F81ZuRdgnd+nBZS5Ab
         FZY0BeHj7qDEX8S6Z7uzXp2S7gR4draccg0+hDhb4fxOmdSMgD6fTIgrht7Gc5ll/Dzj
         87eit4VhzUC0zBcOahBpz/GKXm2iHbiaSUffi53nwcBbGIKbzfF5KAxskCcFbIddoPYm
         U2fgFeAOASi6kKZBq4cr1DGKbXwaeFm3CO4BVC0ODfpF5IwDcw1xyzsc7NIYr/lm1ers
         aSzg==
X-Gm-Message-State: APjAAAXK8GyENvMoXZeO/W4gPp075Yr3NglIUwmwByYrG/6d6f66c/3P
        GZAzemqurRYOcM0YQaKYFULiFfQN2GCkH7jIpfOO//h0b/DAFnSd9+54kn1QsoW8X0yeWC7x/Qk
        zJRuTUixvOiEKcD5SMg==
X-Received: by 2002:a1c:6641:: with SMTP id a62mr28836424wmc.54.1574088760039;
        Mon, 18 Nov 2019 06:52:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqzm2USSaAqX1tnWKJ3JeBYVEfQbsfuhq4RIa4doEhCDnPJ7ex30wN6ZgEku/GUroII7h01hrQ==
X-Received: by 2002:a1c:6641:: with SMTP id a62mr28836404wmc.54.1574088759790;
        Mon, 18 Nov 2019 06:52:39 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o5sm23044658wrx.15.2019.11.18.06.52.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 06:52:39 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v4 1/3] policy: drop the unneeded userdom_search_generic_user_home_dirs()
Date:   Mon, 18 Nov 2019 15:52:36 +0100
Message-Id: <20191118145238.408124-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118145238.408124-1-omosnace@redhat.com>
References: <20191118145238.408124-1-omosnace@redhat.com>
MIME-Version: 1.0
X-MC-Unique: K_bDYUsMO96ofL3FVYtMaw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

userdom_search_generic_user_home_dirs() is not defined in neither Fedora
policy nor refpolicy. userdom_search_user_home_dirs() is already defined
in both, so just use that directly.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_ipc.te    | 2 +-
 policy/test_policy.if | 6 ------
 policy/test_ptrace.te | 2 +-
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/policy/test_ipc.te b/policy/test_ipc.te
index baa7bda..324b690 100644
--- a/policy/test_ipc.te
+++ b/policy/test_ipc.te
@@ -83,4 +83,4 @@ sysadm_bin_spec_domtrans_to(ipcdomain)
 allow test_ipc_base_t self:sem create_sem_perms;
 allow test_ipc_base_t self:shm create_shm_perms;
 # ipcrm needs this...=20
-userdom_search_generic_user_home_dirs(test_ipc_base_t)
+userdom_search_user_home_dirs(test_ipc_base_t)
diff --git a/policy/test_policy.if b/policy/test_policy.if
index 5f4000f..939cd7e 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -60,9 +60,3 @@ interface(`userdom_sysadm_entry_spec_domtrans_to',`
         allow $1 sysadm_t:process sigchld;
 ')
 ')
-
-ifdef(`userdom_search_generic_user_home_dirs', `', ` dnl
-interface(`userdom_search_generic_user_home_dirs', `
-    userdom_search_user_home_dirs($1)
-')
-')
diff --git a/policy/test_ptrace.te b/policy/test_ptrace.te
index 0d10e85..b5f9995 100644
--- a/policy/test_ptrace.te
+++ b/policy/test_ptrace.te
@@ -34,7 +34,7 @@ allow test_ptrace_traced_t test_file_t:fifo_file rw_file_=
perms;
=20
 # Allow the tracer domain to trace the traced domain.
 allow test_ptrace_tracer_t test_ptrace_traced_t:process ptrace;
-userdom_search_generic_user_home_dirs(test_ptrace_traced_t)
+userdom_search_user_home_dirs(test_ptrace_traced_t)
=20
 # Let the tracer wait on the traced domain.
 allow test_ptrace_traced_t test_ptrace_tracer_t:process sigchld;
--=20
2.23.0

