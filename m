Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B93C636CC
	for <selinux@archiver.kernel.org>; Wed, 15 Feb 2023 14:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBOOSE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Feb 2023 09:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBOOSC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Feb 2023 09:18:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3953646B
        for <selinux@vger.kernel.org>; Wed, 15 Feb 2023 06:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676470634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e4+5ujqVXLmHOaNWoYpfISgZYhVMCw5jCrQFMX+L9xU=;
        b=EXgdG2dISwhFj+RdqFU7iYwmo8elPgY2neQlPWDFkA2aShswcI1jddi9TuYUCn8qVqS3fw
        mgqXCuDJwqFLD9o4eKhLlyhU57MgqOVdzahICtuW/WySNuwWi+7kbI+j0va7dpUBES3Yzu
        CzWSsOdctgvs0vf+rzUK/4TheCNmDPA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-WhgQrBWZPaigixK149s5Iw-1; Wed, 15 Feb 2023 09:17:13 -0500
X-MC-Unique: WhgQrBWZPaigixK149s5Iw-1
Received: by mail-ej1-f70.google.com with SMTP id ga33-20020a1709070c2100b008b11f37b9c6so5509277ejc.14
        for <selinux@vger.kernel.org>; Wed, 15 Feb 2023 06:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4+5ujqVXLmHOaNWoYpfISgZYhVMCw5jCrQFMX+L9xU=;
        b=fP7OoyscMI7y9mGH5z+PwWdhDIrdEIw8243dRxZ/u9lRYEqhVUFB7QNx2f48dZ9uuv
         TZ9ziKWYXejD6hLz9V7+GnIuWP9kBP743TrMu369FENX5GOJP1p7a5pXzdu4MofsFSgB
         SHU6u79eET8onyCys01GhEw9bzsCS/2L4aXEScBukr5WjiJz3b5xUWDMHZoz4RMOZjhc
         HKa0MI4q3//ShRV6CQNSRRs/QiEv2mqRCGSaWZMwL1/2dLKbjjV8YYZbwQMsYHJk459b
         iCV4/YDDj58DXoHvivc7I0tpuDJ04NDrfOjPk0LhCIj91WDQC3g32HtJSe1Tilbl8N5B
         VziA==
X-Gm-Message-State: AO0yUKVQehaZ4jA3eprxyvA8xZBuUD9DJ4n7v2AeYspNYQDILbSOo9mu
        smmNsOYZOXUzI0Iv1DgEy2TBiJ+JFs79kYUdBlU0iTMoXGPqupO7A/SVaQ58363o8IhKJa7wFzR
        txea3c1rGPw7ph9VEoS+ecQGcyA==
X-Received: by 2002:aa7:d686:0:b0:499:b672:ee30 with SMTP id d6-20020aa7d686000000b00499b672ee30mr2175572edr.11.1676470631681;
        Wed, 15 Feb 2023 06:17:11 -0800 (PST)
X-Google-Smtp-Source: AK7set8B5VzPLHsTTRP9Sx7T5bRr7DQ1sF1DAmyHc8lNvl+Vb9EtjJxV75QCtvc6x+5eLkE8d+mNbQ==
X-Received: by 2002:aa7:d686:0:b0:499:b672:ee30 with SMTP id d6-20020aa7d686000000b00499b672ee30mr2175560edr.11.1676470631418;
        Wed, 15 Feb 2023 06:17:11 -0800 (PST)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e5-20020a50d4c5000000b004873927780bsm9586782edj.20.2023.02.15.06.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:17:10 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Subject: [PATCH] selinux: allow to opt-out from skipping kernel sockets in sock_has_perm()
Date:   Wed, 15 Feb 2023 15:17:09 +0100
Message-Id: <20230215141709.305399-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There is currently a very suspicious condition in sock_has_perm() that
basically skips any permission checking in sock_has_perm() if the target
socket is labeled with SECINITSID_KERNEL. This seems bad for several
reasons:
1. If a user-space process somehow gets its hands on such a socket, it
   will be able to don any socket operation on it without any SELinux
   restriction, even if it is not allowed to do such operations by the
   policy.
2. The exception is inconsistent, since one can e.g. write to a stream
   socket not only via send(2)/sendto(2)/..., but also via write(2),
   which doesn't go through sock_has_perm() and isn't subject to the
   SECINITSID_KERNEL exception.
3. The exception also allows operations on sockets that were created
   before the SELinux policy was loaded (even by user space), since
   these will always inherit the SECINITSID_KERNEL label.

Additionally, it's unclear what is the rationale behind this exception.
For sockets created by the kernel that are expected to be passed to
user space, it seems better to let them undergo normal access checks to
avoid misuse. A possible rationale is to skip checking on operations on
sockets created with kern=1 passed to __sock_create(), which can happen
under user-space credentials even thogh executed internally by the
kernel - notice that such sockets are always labeled with
SECINITSID_KERNEL. However, the operations on these sockets already
normally bypass LSM checks entirely, so arguably this not necessary. On
the contrary, it's better if actual user-space operations on these
sockets go through SELinux checks, since there may be a possibility that
such a socket accidentally leaks into user space and we definitely want
SELinux to detect that and prevent privilege escalation.

Since removing this condition could lead to regressions (notably due to
bullet point (3.) above), add a new policy capability that allows the
policy to opt-out from the condition. This allows policy writers or
distributors to test for impact, add any missing rules, and then enable
the capability.

I tested a kernel with the condition removed on my Fedora workstation
and noted only one new denial, related to a user-space socket created by
systemd-journald before the policy is loaded, which is then continued to
be used by systemd-journald while the system is running.

Also selinux-testsuite is passing without new denials when the check is
removed.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c                   | 4 +++-
 security/selinux/include/policycap.h       | 1 +
 security/selinux/include/policycap_names.h | 3 ++-
 security/selinux/include/security.h        | 7 +++++++
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3c5be76a91991..cf7418df3d4c0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4561,7 +4561,9 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 
-	if (sksec->sid == SECINITSID_KERNEL)
+	/* legacy behavior was to not perform checks on kernel sockets */
+	if (!selinux_policycap_check_kernel_sockets() &&
+	    sksec->sid == SECINITSID_KERNEL)
 		return 0;
 
 	ad.type = LSM_AUDIT_DATA_NET;
diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index f35d3458e71de..814db520b9d8b 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -12,6 +12,7 @@ enum {
 	POLICYDB_CAP_NNP_NOSUID_TRANSITION,
 	POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
 	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
+	POLICYDB_CAP_CHECK_KERNEL_SOCKETS,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index 2a87fc3702b81..62de8262f90fe 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -13,7 +13,8 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"cgroup_seclabel",
 	"nnp_nosuid_transition",
 	"genfs_seclabel_symlinks",
-	"ioctl_skip_cloexec"
+	"ioctl_skip_cloexec",
+	"check_kernel_sockets",
 };
 
 #endif /* _SELINUX_POLICYCAP_NAMES_H_ */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 393aff41d3ef8..1e57c71d067fb 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -230,6 +230,13 @@ static inline bool selinux_policycap_ioctl_skip_cloexec(void)
 	return READ_ONCE(state->policycap[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]);
 }
 
+static inline bool selinux_policycap_check_kernel_sockets(void)
+{
+	struct selinux_state *state = &selinux_state;
+
+	return READ_ONCE(state->policycap[POLICYDB_CAP_CHECK_KERNEL_SOCKETS]);
+}
+
 struct selinux_policy_convert_data;
 
 struct selinux_load_state {
-- 
2.39.1

