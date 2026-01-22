Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAAA2D8DCF
	for <selinux@vger.kernel.org>; Thu, 22 Jan 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769091192; cv=none; b=FikDb/vyDKbdty5m0Yl2/rhtbyBTas4QS6bCtdqobaDk+2qIO8JvkQSsF0jxRS6s9LFpxBzOufucwxhs1nBwVWvsDt4HwUq/XnE+9cUAHwA5eBUTeCzplaWs3w68Lvu1VaH1ARMidvdVTKsY02iYcq4db6xd7IqgiYDj3UKmFGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769091192; c=relaxed/simple;
	bh=Mn21BPD3AuBamNBIQ/yf9Rn2jlT2v4WIxJAUKQ0U16g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pGKagyY4tB4WVB5BMncPB4AfjtDx4mdsf6k2yPkwG44uTcDS8ZWh/aOVck23YzNi4pbEl+XGDs29mwYUqNnd7OSGRCu/fulesL3WiQ/Qo9HArWMVZW0WfGFBe8IYgDU+OU+X0NXwxFhab9l1v1VJnUN0JArVUQfQjGG6O+xkebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqV5EoIy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmFIP7Yi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqV5EoIy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmFIP7Yi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769091187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5RQjD78hKqWJwoQ+yeMvpqjICnn41Udh857/CjWOTDc=;
	b=QqV5EoIy2+jLMmAdOZH2tviq/qVGvrmI6uG7k6w3W8sR8WoVXInuPfjaMlYmpjDDHTS/Hf
	TKd1t0SVm1xVu0bnGz5d++2+iQmS6qpor7BN/HyFX0i7lteZ+SpZZTxWiBG39NmligNLmg
	Hp+oGDEwO4fZPTE2LsuqLsGEAFMB97o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Icti3rJBO_Kfyjhb0V0ckQ-1; Thu, 22 Jan 2026 09:13:06 -0500
X-MC-Unique: Icti3rJBO_Kfyjhb0V0ckQ-1
X-Mimecast-MFC-AGG-ID: Icti3rJBO_Kfyjhb0V0ckQ_1769091185
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-432c05971c6so812625f8f.1
        for <selinux@vger.kernel.org>; Thu, 22 Jan 2026 06:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769091185; x=1769695985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5RQjD78hKqWJwoQ+yeMvpqjICnn41Udh857/CjWOTDc=;
        b=fmFIP7Yi7ikX9skVtqwbqr2c8en8VfPolayNiXIMd1NOFCIx30zA2jbx2ys2TFnpc/
         UFAoNduXyxm2/7QzTIozaEiE8T/JQnbJvVPA0BgcJ/IK9kt4mn5XUXYWV4YcJ+0x369s
         sX47RTKu/nwf/CCljiwiblIlXPQHdOxXNYWMhEGtehca5iD2tqm6LXj9Ti9gDpIT3zTz
         c5ozbe9pAQ0nI2w/ANanjUm+j+voCUBMQFS+QgMtMyj/3mNPtd0YP0mttwRli4nJrGY5
         /GeeDZ1DI6gGVgEtKy7+5boi1DwU/Zn79Ye0mJVUU0ZmGjj0HCyzUVTNb95XNLWrp//l
         Rkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769091185; x=1769695985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RQjD78hKqWJwoQ+yeMvpqjICnn41Udh857/CjWOTDc=;
        b=dYtmY9COv14wBK8YWJBlc2wDT0+eVuv92gKeWXbyiVd3O6dSGYNh7I3LSnNiTyrB/J
         5Nx/sKnrFKhR9hXUyZt8uu8t5E61u+Zp3oVQBGaz0vWoqhCADj2N8zg8gHvHECvYDRJH
         jL38bZL8notvPCjLimEmBKo7NFHLO5/ilB56D7Yn4KWDDy7sdR2zLXoXdq+MuDlXaRE8
         1r0SzPbWvCgLY70i17cxkr6CpYgl94/WPtfw5Z1USI4SCs59lCrHyX7egKUR4gPOrSav
         YBEZ04F8TNahZVU0l564wS2EWOAILj7EQX9jKWGf1uZ8tpS5e1qP1X1j+qiTI3PQvnRX
         1dZg==
X-Forwarded-Encrypted: i=1; AJvYcCWuAopC0tR2ofjBnijtaoakASzT7qIpQ85rP99hg0K8ny7wzFMNvkr0HLwjXoesAzz2+wk9H//K@vger.kernel.org
X-Gm-Message-State: AOJu0YyZoEM4V5vITGwja3NR5tuy3l+2KPk6EBpKIfC/nzR7oWONwhPc
	Bl5CbnVRsMP1eiL8u4kTFX09gpWfnAnB5QshcSKxzmmdo2zoh3p6BmNY7/TcM1TRkUqz8FfKJh1
	l397v4M7pzGMLrXiFqU4Arser5mwUeDpCaFmcUIxw6v7tHxMni5Fc7MVdW8k=
X-Gm-Gg: AZuq6aLM7TSX25XxQJtbE/VO9+w8IkIUubR+yCgI/hgcwmRYsFB+k/weM5TX7vM9huA
	xGEXBTroBWU0LkXBc+SZF3YsUe5qLNkswa+v1lzlynmjZ9W1kPJPI+V03aP1sSQvWw1ROU/2S9O
	d31w9aXWZCyS5HykvX/zRBvFGuSxxWgOU4xCEVyy0pgZOHbA3gfdLFMo2lzu8yYKdL3E64t0xte
	xNEdycoR0LkQIZm3Zp9eZnKsVodstbYeksdrPA0HNqNVWuzQp9GL4I44DTWi1/zR3ygo4IX32u7
	VvY5o9KUeOXzmA7fehxhZTUxnSO6XN9pQoJbLeRvZWU8RRfe0bAJffT/FKl8meZXBK0=
X-Received: by 2002:a05:6000:420d:b0:431:de5:93c7 with SMTP id ffacd0b85a97d-435a5f5ccfdmr6243331f8f.2.1769091184997;
        Thu, 22 Jan 2026 06:13:04 -0800 (PST)
X-Received: by 2002:a05:6000:420d:b0:431:de5:93c7 with SMTP id ffacd0b85a97d-435a5f5ccfdmr6243286f8f.2.1769091184544;
        Thu, 22 Jan 2026 06:13:04 -0800 (PST)
Received: from fedora ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43596090493sm17643302f8f.25.2026.01.22.06.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 06:13:04 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>
Cc: Alexey Gladkov <legion@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH] ipc: don't audit capability check in ipc_permissions()
Date: Thu, 22 Jan 2026 15:13:03 +0100
Message-ID: <20260122141303.241133-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPC sysctls implement the ctl_table_root::permissions hook and
they override the file access mode based on the CAP_CHECKPOINT_RESTORE
capability, which is being checked regardless of whether any access is
actually denied or not, so if an LSM denies the capability, an audit
record may be logged even when access is in fact granted.

It wouldn't be viable to restructure the sysctl permission logic to only
check the capability when the access would be actually denied if it's
not granted. Thus, do the same as in net_ctl_permissions()
(net/sysctl_net.c) - switch from ns_capable() to ns_capable_noaudit(),
so that the check never emits an audit record.

Fixes: 0889f44e2810 ("ipc: Check permissions for checkpoint_restart sysctls at open time")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/capability.h | 6 ++++++
 ipc/ipc_sysctl.c           | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 1fb08922552c7..37db92b3d6f89 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -203,6 +203,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 		ns_capable(ns, CAP_SYS_ADMIN);
 }
 
+static inline bool checkpoint_restore_ns_capable_noaudit(struct user_namespace *ns)
+{
+	return ns_capable_noaudit(ns, CAP_CHECKPOINT_RESTORE) ||
+		ns_capable_noaudit(ns, CAP_SYS_ADMIN);
+}
+
 /* audit system wants to get cap info from files as well */
 int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 			   const struct dentry *dentry,
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 15b17e86e198c..9b087ebeb643b 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -214,7 +214,7 @@ static int ipc_permissions(struct ctl_table_header *head, const struct ctl_table
 	if (((table->data == &ns->ids[IPC_SEM_IDS].next_id) ||
 	     (table->data == &ns->ids[IPC_MSG_IDS].next_id) ||
 	     (table->data == &ns->ids[IPC_SHM_IDS].next_id)) &&
-	    checkpoint_restore_ns_capable(ns->user_ns))
+	    checkpoint_restore_ns_capable_noaudit(ns->user_ns))
 		mode = 0666;
 	else
 #endif
-- 
2.52.0

