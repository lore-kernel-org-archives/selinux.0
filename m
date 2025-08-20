Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0000C287266
	for <selinux@vger.kernel.org>; Wed, 20 Aug 2025 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725009; cv=none; b=KUmnxxRyO5b5nn774NB7QcYphAintWr76EmkLoikmNCLuJUgFKDwnsu2uESPIonvZZ4wlnErbOR1ZWZ2FiekoJcx8lprfr89UpMerDB9lcaICR/fAaSi8X3s+r3z0ZELmduX1I67pPj5VZ1hrOu1rvBFRv9xOlR+KLWJOsUC4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725009; c=relaxed/simple;
	bh=MmgkxmR/RHD0gAuy+J/k1De83SPERK5OISiT4zyEcLI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FgeZ0MFc8VbnZLDKk9HX7btO+haZyV0hY4WwryhQhTQrqm7At/dsUqK2UnQTK/+gJLLQ2Ewk0yVzosBSQ9F8efr3P5iM3a3sUetotTec4ghx5Dfu5oxyD5pGYbVM5wIG9UxZTI3unWCC5G0bHrazrID8o3tjz/W68W95EBW1YT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVeZ13sr; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVeZ13sr"
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-74381fa08b6so543320a34.2
        for <selinux@vger.kernel.org>; Wed, 20 Aug 2025 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755725007; x=1756329807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=52NO8e8KBKouByykf50TxpA8fzaA+CANU9c8tLjIyos=;
        b=BVeZ13srzbSFnPuACl6Whd+S4BBI2qsVQQYT83HAyTd/hGTN8k5VuCnWJVmFIT/S5Y
         0R3Gq49YHL98OYYr5l8upVQPrwIO+V+Lsnl+nAvUJsWX+Ye1zRmOaMDBC15z+E+oqmA9
         8hZIWYXUO5frhxUvNs9/bAIj1iBZstMK1lrAMFAFDZoSfXFoYom1QHFva9epWHwA8HfY
         BLdl/ICfkmKr2lRW69nNPO7dKr4EyTfFDOFDik25EmlhyrqKLcgwWWxcZCxeDJqMZyO1
         UjUJeuBz2UYVmM6RxblljnhWAC3DcRDKu1Jiw+xDU/nvZeYFYecoXjz+YboJYVl2pOSz
         RMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755725007; x=1756329807;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52NO8e8KBKouByykf50TxpA8fzaA+CANU9c8tLjIyos=;
        b=nqV9zOJXcoWNoFCh06nRCNRc2sTq01UiqO0rXhBXH+wcpMhe8NrEXQq1QicYcMWxzI
         xNFDMf1KfVJM3NxasyLY0D0xwn4ZcGG2AQ++QlezRTikh93hEmfC06mTP8ExT6z73K5S
         xc5xj2AXhBOk4ycyK+S78Q6LxIj1o/kXuAUvSMTAsVF8RquHY7D+LFcbSnxDK25zdC49
         iEqKVvd9AqP6vboEEvSOh0xYlSBdgeCDNZ8jYuFOK/2Nv55OwE8YLOOtQAqbe6OI0zxk
         TTnJ8C+EJ4TL1KLqI3hKMUyo5C4ZlglmrPjdTpDv18vo+ZVkIQIr9z+fmk/skVKpIMkg
         Z2Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUGXXFqzJTO6MPnlnvfrjiwIK39AqygPiC0QXjCmUAsr2l9PrLzxY7MFfLCz3nKCnQHf+os+tq8@vger.kernel.org
X-Gm-Message-State: AOJu0YxgdmgzftlZXMr4mcT4xxNDMLGGNnYuuLCjKBepTXtQ89NJ4k3/
	yhHutkARi1HpGSUGyozV09VAljlp+WL9eO9JuHnSQQE3IojMLy8j/FillSbug3jBefjlyaYfPEl
	aXwtlAHpzbA==
X-Google-Smtp-Source: AGHT+IEWgVPot+3z7mWm/U5UY6IePVqWOvsPtMCX+ZTPEXirfgLAzmQbxaj6CSM1E/O77ukOhXQrhy36+LzF
X-Received: from otln10.prod.google.com ([2002:a9d:64ca:0:b0:742:f956:71c9])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:7002:b0:742:6d79:ed03
 with SMTP id 46e09a7af769-744f6b21d05mr222839a34.24.1755725007057; Wed, 20
 Aug 2025 14:23:27 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:23:01 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250820212302.2325779-1-nkapron@google.com>
Subject: [PATCH] selinux: enable per-file labeling for functionfs
From: Neill Kapron <nkapron@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: Neill Kapron <nkapron@google.com>, kernel-team@android.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch adds support for genfscon per-file labeling of functionfs
files as well as support for userspace to apply labels after new
functionfs endpoints are created.

This allows for separate labels and therefore access control on a
per-endpoint basis. An example use case would be for the default
endpoint EP0 used as a restricted control endpoint, and additional
usb endpoints to be used by other more permissive domains.

It should be noted that if there are multiple functionfs mounts on a
system, genfs file labels will apply to all mounts, and therefore will not
likely be as useful as the userspace relabeling portion of this patch -
the addition to selinux_is_genfs_special_handling().

Signed-off-by: Neill Kapron <nkapron@google.com>
---
 security/selinux/hooks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e474cd7398ef..54b82c814b4d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -474,6 +474,7 @@ static int selinux_is_genfs_special_handling(struct super_block *sb)
 		!strcmp(sb->s_type->name, "debugfs") ||
 		!strcmp(sb->s_type->name, "tracefs") ||
 		!strcmp(sb->s_type->name, "rootfs") ||
+		!strcmp(sb->s_type->name, "functionfs") ||
 		(selinux_policycap_cgroupseclabel() &&
 		 (!strcmp(sb->s_type->name, "cgroup") ||
 		  !strcmp(sb->s_type->name, "cgroup2")));
@@ -741,6 +742,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	    !strcmp(sb->s_type->name, "binder") ||
 	    !strcmp(sb->s_type->name, "bpf") ||
 	    !strcmp(sb->s_type->name, "pstore") ||
+	    !strcmp(sb->s_type->name, "functionfs") ||
 	    !strcmp(sb->s_type->name, "securityfs"))
 		sbsec->flags |= SE_SBGENFS;
 
-- 
2.51.0.261.g7ce5a0a67e-goog

