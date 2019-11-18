Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC610C432C3
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 12:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A403420895
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 12:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wq2jxbTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKRMbH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:31:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49077 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbfKRMbH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 07:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574080265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmfmcVgleq4XojmESt2YDfC/zy2jlK4moL+EHl6ZwqA=;
        b=Wq2jxbTf9ks/QU/0LlZtio9Srl1SofHWq8LNJvtf8Wa/cDBm3YbS2HV69J57oYewiXDUCG
        nijBdm8ImrmlVEq8TrdbISHa5Lga3z1oJ3kz6rf3BP1qSWZZOCi3coL+NO4Gm0gUsTxUjx
        Ewo6spp6t9zLM+k4DpTo5xYhIydNuz4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-Ii_Qv8_8MeufWM0NkNRnZQ-1; Mon, 18 Nov 2019 07:31:04 -0500
Received: by mail-wm1-f72.google.com with SMTP id y14so13046182wmi.4
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2019 04:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/XKvt+mhWO02aFoWBkyMxCZKoizE4AwSsalWQCFgMo=;
        b=VfRUoU5TVpEpKdwFCVTBN2+oExAdDA7uL6YgRfG/M/MVQsusdnL3n7T0p/x462qPxd
         GmJyEBXTF5sKKUaJR1eUr2xtC0VqqMIbPZyekeg2++N3SLHEVN1Owd+qacwbMBNabAGc
         XjJkx15Zjg5IMTPFx6kBJNa02MgHZGK7YCG6ZuBIzh9bFsp4egDm0D64yUtIpkMXfnIP
         7x6wEq5pxA2Z20OGr9/B1wfKwUeJZwnuXT9G8Kt4EIGrtqRYMm4LSA5sm5+k0jNnqV82
         YLsSrdwmIISLKqddmQNcOmova+FQboCI+lOfITZUmrKXB4h/vG9q8EyhbvWgsvuuK0MW
         HVTA==
X-Gm-Message-State: APjAAAW8dCAb7bvVUyvPfQF5Kkl+8YTPm1e/aIQ5reVmIOT2cGBhXTDL
        QNO7Y6qUqmvIQ7DETk9xL8tAa522fhrTPkTx+b++auKUCFFbth349xdeaI9sbfuLd7QUkAtA3Ct
        VDmjMYXlvu5gOWi31Dg==
X-Received: by 2002:a5d:4609:: with SMTP id t9mr30663376wrq.178.1574080263037;
        Mon, 18 Nov 2019 04:31:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqw88f6c5oO4xi9CdTbHTk9oSkJVB5Rj7kzXW31Z+j7O/MfFHn4eClybjGpuCrwuhIJ25O936A==
X-Received: by 2002:a5d:4609:: with SMTP id t9mr30663362wrq.178.1574080262809;
        Mon, 18 Nov 2019 04:31:02 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h205sm21815802wmf.35.2019.11.18.04.31.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 04:31:01 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v3 2/3] policy: add fallbacks for Fedora-specific macros
Date:   Mon, 18 Nov 2019 13:30:55 +0100
Message-Id: <20191118123056.338496-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118123056.338496-1-omosnace@redhat.com>
References: <20191118123056.338496-1-omosnace@redhat.com>
MIME-Version: 1.0
X-MC-Unique: Ii_Qv8_8MeufWM0NkNRnZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

dev_rw_infiniband_dev() and mount_rw_pid_files() are not defined in
refpolicy. Fall back to dev_rw_generic_files() and
mount_rw_runtime_files() if they are not defined.

Also, userdom_search_admin_dir() is not defined in refpolicy because it
doesn't have admin_home_t. Fall back to
userdom_search_user_home_content(), which should apply for root's home
directory under refpolicy.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_policy.if | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/policy/test_policy.if b/policy/test_policy.if
index 939cd7e..38214a9 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -60,3 +60,24 @@ interface(`userdom_sysadm_entry_spec_domtrans_to',`
         allow $1 sysadm_t:process sigchld;
 ')
 ')
+
+# Workarounds for refpolicy:
+
+ifdef(`dev_rw_infiniband_dev', `', ` dnl
+interface(`dev_rw_infiniband_dev', `
+    dev_rw_generic_files($1)
+')
+')
+
+ifdef(`mount_rw_pid_files', `', ` dnl
+interface(`mount_rw_pid_files', `
+    mount_rw_runtime_files($1)
+')
+')
+
+# Refpolicy doesn't have admin_home_t - assume /root will be user_home_dir=
_t.
+ifdef(`userdom_search_admin_dir', `', ` dnl
+interface(`userdom_search_admin_dir', `
+    userdom_search_user_home_content($1)
+')
+')
--=20
2.23.0

