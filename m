Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3A0C432C0
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 12:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD6920730
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 12:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAMa7IN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKRMbJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:31:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48077 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726668AbfKRMbJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 07:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574080268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YA77x+4PA0qaAsOTR4t/Bl4as0UKWpCesCnEV6xwFR0=;
        b=KAMa7IN4OJN3cnmUq5vs/LdWXJ0O3FIt68hV+hES27I33anIs4lxK93EnyGDAWzmwA8B97
        w4ljlogLHxu7CDFMi911soYD3ISc1zoi6I3/K53GehVpz2VwcW2Ll70UJ3smfaTt/uCDL3
        eFBZzH+DEdWAg6URUb17YBuO7k4+33s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-Ozeo2dSxPYib0f0uHSfopg-1; Mon, 18 Nov 2019 07:31:02 -0500
Received: by mail-wr1-f72.google.com with SMTP id y3so15204156wrm.12
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2019 04:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdrqQyBgjLnoJVNufGA0KbMbzvfP1CLHphimIOO60r4=;
        b=W8GxAsZEP0LKtryYjEf7jEXBJVDI6hvnrMIYB6B2W0XVLgr9eHo3Dp8nlsHUTTywli
         6YOBZHb7CIkIT9i7ngWc3oGbSyA7ku4Z7Xi8DZSEDUmYVbIA4IoDulYL8mFTq00tk0SM
         1lHUnGdpwNxnd/8EE98WzsFxrtUr9HyOTWe+eLKNNwyZW9UT9FWMc4RFflbXEDp2CVhQ
         8sr4kVV1G0ujPz8G7hlDxH1fMrzUCgoqHjd4ph7nwNZ5O0VTLmu0j8lY+K9wYUo/Pyyf
         ugk/8uEyHwcL+u395aevYzc/7FRA2KW+hxuqXqYGbZgH0CNBGhkUG3N/mx1V3hFFCosv
         WhaQ==
X-Gm-Message-State: APjAAAW9kqEyukZQX/PhajyQ4Junz6QnsDkLci0WSpSzv7UnIOWa3DvN
        /1eQzwE+gnzjDk1iI3q/mZoa3Bpz95OmGe2KkVjOcvI81jZ+zLz+m6x7P9ug+oevQa5df44j5Hw
        utfsk9idS5hyo7n4a8Q==
X-Received: by 2002:a5d:5484:: with SMTP id h4mr9986556wrv.136.1574080261149;
        Mon, 18 Nov 2019 04:31:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqzWbar5fNYgeYjWr47DgFaQXxCcLhj0WUmuR4hTGEOBWNB7QY6kfies4IoCllv/q5/Yk2Nb9w==
X-Received: by 2002:a5d:5484:: with SMTP id h4mr9986530wrv.136.1574080260885;
        Mon, 18 Nov 2019 04:31:00 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h205sm21815802wmf.35.2019.11.18.04.30.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 04:31:00 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v3 1/3] policy: drop the unneeded userdom_search_generic_user_home_dirs()
Date:   Mon, 18 Nov 2019 13:30:54 +0100
Message-Id: <20191118123056.338496-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118123056.338496-1-omosnace@redhat.com>
References: <20191118123056.338496-1-omosnace@redhat.com>
MIME-Version: 1.0
X-MC-Unique: Ozeo2dSxPYib0f0uHSfopg-1
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

