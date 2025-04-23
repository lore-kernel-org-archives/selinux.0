Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF211C1F21
	for <selinux@vger.kernel.org>; Wed, 23 Apr 2025 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431229; cv=none; b=r7JBX+cktFcfFCPXOJX1xwUtGJPUwnobS8Gk/iJQ1R+LYUG6d83itURxZq+eJED7ExktRt8CCv0p+AtZe/lkHq9AOlJSPs3xjOLi2KVMt8z+BmH/rXfzZiorSK5qIzDbWUlI2y0rUaZPvVDWRBljUTKmzYc+IMK8E9fzBxtw/0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431229; c=relaxed/simple;
	bh=l+04LF/xOOSukIh3IWGBYYK7rtkCxzYA4+AiGF8MF1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m5ocP6ZATb2lVU9yoYL+EVsTp72JNQO7qYzd3+uZS+tS9IgYK13rP2gVJL92fzG8zdhaZ1S5HVFs0T+GRNFZVbUOV9r3oTv45dNMaDF6oZkxM2Xvs3SOVgaIwCPSUx3I1cgcf5nPURhU0uokVh7faXlqIpj2VyeLshj+ZAHokRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imJYoeWR; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imJYoeWR"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5568355ffso10194285a.0
        for <selinux@vger.kernel.org>; Wed, 23 Apr 2025 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745431226; x=1746036026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EY8MOySgXvaCALY8I5lBkE61avSQcMrum3qMJ+9Ayys=;
        b=imJYoeWRxHABcnlLrdKjEttorlRj6aUv576U+4FUhBHPh7S3R2roy8CEcHkX7ra3c7
         WY3AVUXUm0ZS+ToIGpl9fbwhOZJbh6tN1jqYt1y4+MW8L6YVvvSKxPElqeLv7174ZABf
         ru2/ntR50UQd5cjp+X+nh7MVYxMdpDdpCemgTL7K2NtozJZ5V/ayr6Vv6+ExXOljluMQ
         P+LSZEpENNBWemNQNyUXETu+A+etOjC+tJJ2JnIKoPtAs4WG2BdXNPXPDuBCEW60TqD/
         LuSF9aJrGM9xfT9rRtY3vVxqHFRm6uatuD2rtt/Z4vFVugoEJJreNr/F1V1OcdulTmJw
         O79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431226; x=1746036026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EY8MOySgXvaCALY8I5lBkE61avSQcMrum3qMJ+9Ayys=;
        b=G623ro+cBubntWwvlJYXq10YlWihEYswrf3On8OnSo331Hm5j39CyMJor2xZEDAcKs
         CwLnTvsB1O1i9P2h5r7ckgVsJ30acJ5N0htvW9fVN+emT1VGrZO7ai/Ap6DxwyDzBHw/
         HsBS+TNWI3BKhUVZS7y5WtV+QpAuxNhALf9M6zfY4dNAsIlVjsWN6rpsZ+1Mpvr8HblL
         twiv2ueXNKBxOg1DJ/h7Uk3dl1kw0GCWTNP0JFA09A7ySc7MheqnUi+023zqo95sSiSt
         MYgb9ySnacvisqtm5rftY+cPEO/2bK3ARbCo/t1SQyYJ+UPzyAvqJGF+o3oVfDlFCv5D
         CmwQ==
X-Gm-Message-State: AOJu0YxSeB298QKQ+xZKMMBL3ca8JvxSz02gWjhV8u2cVc2s9L1pjxOM
	n7hqiNjsNFjJOZbyKx0Re6PKusSXD/qIE4+B6siYU+j1XplnweCsh+ZAn6Uo
X-Gm-Gg: ASbGncsXbvHNqBW5zD0FRy3csSTqxfGsz++1RwhAuh2fGktop238fZIeY5XqtQBbXIp
	fgxAW/SWVZ6DU1H0T8q1k04M+giVU4VOHqxu5O/QOP8l5MhCwCz9O7ajluvlV1PzJNea5+01CCj
	iuEfqxyA/opDVvAqUT/CX7gaElxce7hgNU1fLgHWIm15jrPMQVwE0gE/zNE/21bZSC3kmmxVaef
	6GUDPkJpCSx5VDAoiyZ/dJBengMKh33rVWQo4tbpvbQy1Q4owPpCPtMxXWYZw7NB+Do/vbgQ9L0
	OER0eyq7xrCAfTIxMP2AcF7wkZX05El0hDSpJurrYBJ7v3MsRJS0477lDnEXrI83xIq8B87oqLK
	HDua8REr0VUDs5jaJ6VhtwINtgFWAGN/BbFwbAS/dQnqD6sAM67HYmw==
X-Google-Smtp-Source: AGHT+IGjohQ9d4GpFzK5Ix7yF0V1Y8rx3byA1AmghhNFPbeM0SPkdjh7J24Xm0cDAiB6ySko9MkcIw==
X-Received: by 2002:a05:620a:3707:b0:7c9:443e:7026 with SMTP id af79cd13be357-7c955d9f5camr112738885a.8.1745431226315;
        Wed, 23 Apr 2025 11:00:26 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a6e97asm704154585a.13.2025.04.23.11.00.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2025 11:00:25 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	nvraxn@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH] shmem: fix listxattr to include security.* xattrs
Date: Wed, 23 Apr 2025 13:57:29 -0400
Message-ID: <20250423175728.3185-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vfs has a fallback to obtain the security.* xattrs from the
LSM when the filesystem does not implement its own listxattr, but
shmem/tmpfs has its own handlers. Consequently, it fails to include
the security.* xattr unless explicitly set by userspace, which confuses
ls from coreutils.

Before:
$ getfattr -m.* /run/initramfs
<no output>

After:
$ getfattr -m.* /run/initramfs
security.selinux

Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=iOawX4y77ph0EcfcqcUUj+T87FKyA@mail.gmail.com/
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
NB This only handles shmem/tmpfs inodes, not sysfs or others.
It also doesn't handle the case where some xattrs are set on the inode
but not the security.* xattrs. Not sure if that's possible currently.
It would be problematic not to mention ugly to check for the presence
of a security.* in the buffer after the simple_xattr_list() call
since the buffer/size can be NULL/0 to just query for the buffer size.

 mm/shmem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 99327c30507c4..49256ca11400c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4372,7 +4372,11 @@ static const struct xattr_handler * const shmem_xattr_handlers[] = {
 static ssize_t shmem_listxattr(struct dentry *dentry, char *buffer, size_t size)
 {
 	struct shmem_inode_info *info = SHMEM_I(d_inode(dentry));
-	return simple_xattr_list(d_inode(dentry), &info->xattrs, buffer, size);
+	ssize_t sz = simple_xattr_list(d_inode(dentry), &info->xattrs, buffer,
+				size);
+	if (sz == 0)
+		sz = security_inode_listsecurity(d_inode(dentry), buffer, size);
+	return sz;
 }
 #endif /* CONFIG_TMPFS_XATTR */
 
-- 
2.47.1

