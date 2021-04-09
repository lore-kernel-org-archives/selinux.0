Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93709C433ED
	for <selinux@archiver.kernel.org>; Fri,  9 Apr 2021 11:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5CF6100A
	for <selinux@archiver.kernel.org>; Fri,  9 Apr 2021 11:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhDILNV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233619AbhDILNR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Apr 2021 07:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617966784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9DLwVwuEa/TUYn9CBVZYDMdn9III6hdDzVPKN/l5PE=;
        b=OQ8G7opl3Ja78HGKN+7JOg1ItMgDLC5y3nu90Tiqv0pNJAIoaaopdHwdcUyyzczCycnyjR
        zfPGbtAyRSNzAefAIE1cmZWbOt0BkbmeHvVN3NFFjINNyVQNagXD2sEqgbVPdSxrWNZNen
        akLYfYEi+nEotAwqSDhoWF9myk3FrRA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-UNJKfcFNP3WtRtm3Zk3Exg-1; Fri, 09 Apr 2021 07:13:02 -0400
X-MC-Unique: UNJKfcFNP3WtRtm3Zk3Exg-1
Received: by mail-ej1-f71.google.com with SMTP id bg7so2059472ejb.12
        for <selinux@vger.kernel.org>; Fri, 09 Apr 2021 04:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m9DLwVwuEa/TUYn9CBVZYDMdn9III6hdDzVPKN/l5PE=;
        b=FIhozUChKkVRa+RL7SUV7Vo9PrYPc7B3SgP2aRqk0Jt8NxaJYuBpcVAb3DWdjDSuJ2
         9mncGktw2+3i8XSaM+wgRSX6B1PZMi+8cwyXYvLge1Sq/ZIdeyCi4/gS91NbSKiXhNdi
         cX9P/9kFgrUyQfH6FBzATTfVxevKQv32UYmn6PWhEOzqwGVR0yalwDYp8cct6oFmSW6s
         Jd5YLZL/IHOhx5g/fYQQHzxPURyRQmHjKUmirR7Kaji8lNxhnQ4aUdn+GX4mIdOeDyVD
         FzVVjooQ3AT8IYxPGyhVREdJdFMdozgGXCQJWtmZ2nQNb1s5AuVuB6/tCYL2c4UvUA2o
         x0MA==
X-Gm-Message-State: AOAM532S738wF95ckAOBrUe41ZXgGMM8kFpg/R6gWKpylHAz9atyDnmq
        H76c/pjlKONtQ+PQZGPbGnfVLCYAJjC5JCbsmVgIfdd0akP1LOB1eYRdoogC/C1dDk2ab6r+w/1
        +CpnLg+I3oj843y74jQ==
X-Received: by 2002:a17:906:fcc4:: with SMTP id qx4mr6751954ejb.42.1617966781263;
        Fri, 09 Apr 2021 04:13:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN01aC0ArployKcFNzWC+455t509jtFprEos2SXUsaUxRWFCvmE9PBB5j0Mfpph1bCkHvNIw==
X-Received: by 2002:a17:906:fcc4:: with SMTP id qx4mr6751940ejb.42.1617966781061;
        Fri, 09 Apr 2021 04:13:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id w18sm1046854ejq.58.2021.04.09.04.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:13:00 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] selinux: fix SECURITY_LSM_NATIVE_LABELS flag handling on double mount
Date:   Fri,  9 Apr 2021 13:12:54 +0200
Message-Id: <20210409111254.271800-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210409111254.271800-1-omosnace@redhat.com>
References: <20210409111254.271800-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When mounting an NFS export that is a mountpoint on the host, doing the
same mount a second time leads to a security_sb_set_mnt_opts() call on
an already intialized superblock, which leaves the
SECURITY_LSM_NATIVE_LABELS flag unset even if it's provided by the FS.
NFS then obediently clears NFS_CAP_SECURITY_LABEL from its server
capability set, leading to any newly created inodes for this superblock
to end up without labels.

To fix this, make sure to return the SECURITY_LSM_NATIVE_LABELS flag
when security_sb_set_mnt_opts() is called on an already initialized
superblock with matching security options.

While there, also do a sanity check to ensure that
SECURITY_LSM_NATIVE_LABELS is set in kflags if and only if
sbsec->behavior == SECURITY_FS_USE_NATIVE.

Minimal reproducer:
    # systemctl start nfs-server
    # exportfs -o rw,no_root_squash,security_label localhost:/
    # mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
    # mount -t nfs -o "nfsvers=4.2" localhost:/etc /mnt
    # ls -lZ /mnt
    [all labels are system_u:object_r:unlabeled_t:s0]

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1daf7bec4bb0..b8efb14a1d1a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -741,7 +741,24 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		/* previously mounted with options, but not on this attempt? */
 		if ((sbsec->flags & SE_MNTMASK) && !opts)
 			goto out_double_mount;
+
+		/*
+		 * If we are checking an already initialized mount and the
+		 * options match, make sure to return back the
+		 * SECURITY_LSM_NATIVE_LABELS flag if applicable. If the
+		 * superblock has the NATIVE behavior set and the FS is not
+		 * signaling its support (or vice versa), then it is a
+		 * programmer error, so emit a WARNING and return -EINVAL.
+		 */
 		rc = 0;
+		if (sbsec->behavior == SECURITY_FS_USE_NATIVE) {
+			if (WARN_ON(!(kern_flags & SECURITY_LSM_NATIVE_LABELS)))
+				rc = -EINVAL;
+			else
+				*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
+		} else if (WARN_ON(kern_flags & SECURITY_LSM_NATIVE_LABELS)) {
+			rc = -EINVAL;
+		}
 		goto out;
 	}
 
-- 
2.30.2

