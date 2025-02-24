Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A768F25B667
	for <selinux@vger.kernel.org>; Mon, 24 Feb 2025 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412123; cv=none; b=FIwy9O/mXrPj18Kpzbc1AULqPhQ8lHjB6iG4ouz2ESkclVmQH8YgD1vyWKQxaEwv+M6KW0Vb9zFdduhBRrLj9haIm41eRctF4SkFICV7O2fikjkFFazmRL1+nCC2DJ68qUc1uVMbmoZ142ziOQQu8ihT8Oq8HkdRYba7qp5enMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412123; c=relaxed/simple;
	bh=Yoe+1Q/wd9KnY0rECwMRuQsaRIV7NNTtgYXl3H+TA1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfIKe/oY7cw2w6DnmYCDUtOJLuVMh3Zh3Y/RRMXXRrsSwI+u8f4p2BXlS2q9bsIiS/XOhB+Vb8En2RQ2T1lDlGuaZC91nhNKN1wFuWj9/QmtPkGuCxWcp5etvkJCj1f3CqR684m1PdTNZcbRkmwiVq82I644LvfhTBsSQeQHmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D407c1VU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D407c1VU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740412120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VZ6BYY6WM+ve8w+hCFhsoiQPqDoYIprknITffKagk4A=;
	b=D407c1VUmd77MsTWgupOFWDm/xHWWnlKT5I7h0TCe10n9G51NgJZxvddB8SvwmV26hHq52
	L8PTMXoC8wg1yaQSSXQWLaYBToUvP6XjY/11K3Y0Y/Q2CMfqZP6gAQ8DUTFDmHvZ//qMua
	fFwx7TLnAMYwndMxd4Z+NN4vJeRudDg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-Nu--6kNjNSOjAILw4bXF3g-1; Mon, 24 Feb 2025 10:48:39 -0500
X-MC-Unique: Nu--6kNjNSOjAILw4bXF3g-1
X-Mimecast-MFC-AGG-ID: Nu--6kNjNSOjAILw4bXF3g_1740412118
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4399c32efb4so23195625e9.1
        for <selinux@vger.kernel.org>; Mon, 24 Feb 2025 07:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740412118; x=1741016918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZ6BYY6WM+ve8w+hCFhsoiQPqDoYIprknITffKagk4A=;
        b=ki+ZTC0aSkreqSGkoIm3ZezkX9chnGfYG9Cywt3CHhbOFZjyuhk7fkI10LET5SB6va
         bQ64u+xQxK+AGzeKWJArEb5bP8L6PqKDMUj/eE4EcM+7fMF6jq7lhu+qcBqHkXJ4b0sV
         3LNYK2hlEQwTRoSHTeNaI6s8jr0eeDTBf4mbzA6A8rcuDUwqzSt9HepcvG4jrWA9UX3w
         vB3iwZDpfu7jXI72ukbxhFi0YtxCbNCBXQpINXgA6ypeNRkGEIW+n4c8f3pGzZ1gGh1I
         q3x3/inYBYey0HeCRKPG6qObEIoRo2ITWY4G4GjilPLLZyZFxjEhMUTVFS+4ktMmBoK0
         urHQ==
X-Gm-Message-State: AOJu0Yx650do4bN2QIea3DHxAQDoV1Ly+FQ4nEBfoKpA/Z3/cRjqqZUK
	PvNnVpSkjizgAAE7nHONCQGnK0U6fzqk+q97XS0rvxdnFecFCmgvaN3KmRX4U6JYjv3sUbUOu/j
	orUV/Q6yeueJb4N0wkkJckfJRFj7qsIRTS6X1fqIYNLROGJ0aH7QrBNGGKQ0kcCPY4mS+h9dWcJ
	jeqCCgtjBjvmCXrURBGD4V8Q1rZLRXX9EvoUGBrbnihg==
X-Gm-Gg: ASbGncvqyOeyPhZbCZWkGv9kkJIGGncvAzYPY41kvE1FM2cQqdgCbBTE/FbZ5uy4EsC
	I8aevt9R8QnuFUnRMbANDX1VQYwLx32zn3dDcyHMe54dHWJw2EmFhghcP6Uw4GBGjwZ6cBuSlzX
	JqvY2g//AapLIHL97DLXQE7uXsVu0ndiRWqeOHXrQk/PtUAAaaAQRmhTJeoTtdzhqZWdtsgI/mk
	r+Tfd/G9UGsRV6Z0dekwo4QLpfyXAhwHUQ5lNCkGeFdSiWnDBHIVvYp5P1CiQ/+1SNf+NoZjjiU
	8I9QlN0efyMmQMa/HNM2XS8frHuhGCfWBjcI6IkPoSwWDzKp4z3ekMUobEso/mmeH28x8nRY
X-Received: by 2002:a05:600c:4ec7:b0:439:95b9:99f1 with SMTP id 5b1f17b1804b1-439ae2e1d53mr110480855e9.4.1740412117999;
        Mon, 24 Feb 2025 07:48:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6TrZ14Kh1RvspHl0cC4TVOhV53fmM42M70m1mCqCLCXtOJB/rbhrvWdei//Y3u75VLLDQ1g==
X-Received: by 2002:a05:600c:4ec7:b0:439:95b9:99f1 with SMTP id 5b1f17b1804b1-439ae2e1d53mr110480595e9.4.1740412117540;
        Mon, 24 Feb 2025 07:48:37 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (89-148-117-232.pool.digikabel.hu. [89.148.117.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b0371cfcsm108736435e9.36.2025.02.24.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:48:37 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: selinux@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH] selinux: add FILE__WATCH_MOUNTNS
Date: Mon, 24 Feb 2025 16:48:36 +0100
Message-ID: <20250224154836.958915-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Watching mount namespaces for changes (mount, umount, move mount) was added
by previous patches.

This patch adds the file/watch_mountns permission that can be applied to
nsfs files (/proc/$$/ns/mnt), making it possible to allow or deny watching
a particular namespace for changes.

Suggested-by: Paul Moore <paul@paul-moore.com>
Link: https://lore.kernel.org/all/CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com/
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 security/selinux/hooks.c            | 3 +++
 security/selinux/include/classmap.h | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88b..212cdead2b52 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3395,6 +3395,9 @@ static int selinux_path_notify(const struct path *path, u64 mask,
 	case FSNOTIFY_OBJ_TYPE_INODE:
 		perm = FILE__WATCH;
 		break;
+	case FSNOTIFY_OBJ_TYPE_MNTNS:
+		perm = FILE__WATCH_MOUNTNS;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 03e82477dce9..f9b5ca92a825 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -8,7 +8,7 @@
 	COMMON_FILE_SOCK_PERMS, "unlink", "link", "rename", "execute",   \
 		"quotaon", "mounton", "audit_access", "open", "execmod", \
 		"watch", "watch_mount", "watch_sb", "watch_with_perm",   \
-		"watch_reads"
+		"watch_reads", "watch_mountns"
 
 #define COMMON_SOCK_PERMS                                              \
 	COMMON_FILE_SOCK_PERMS, "bind", "connect", "listen", "accept", \
-- 
2.48.1

