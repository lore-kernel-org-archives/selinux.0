Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F730B51D
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681630; cv=none; b=OJpH6cmA/N0YLZ42zAUDp5z3DgEfXvPJ/w/4wzwBBIC70cW3tyl26FJtnNK+iGvA6j6mhT3e8RkGC7S74Nu5t+tnIgleIne+8yUAPK3GQ5QjI9q6D3su2g5fBVmb5EbFOFYs65J0TU0SqzFwW0wefkM22u9HWgLfG0UelEik6AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681630; c=relaxed/simple;
	bh=d8FymFbLoqJtECEtm8inqZ5FqvQ1l8onF+Y1LxK0lPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYVwx+ta1U2XZ92t4DD/4VFZNzXFrN7wIQn6pTgmjCcIwrjFYiL/GTGmt2OP3JFP7gzuOKb9oVZU5haBkpGyFLY2aUISS/HiViFQLd5u4sma3FKEciIHmIcA16gVfqJ2CFiYlqD1+OmL5QBYgOADu/GdpNQrS+7vHOQw+z8H2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjZulnJC; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjZulnJC"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8eb5ad01402so684599185a.2
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778681628; x=1779286428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KIxUeW+f3oIsB+GGWCvzSAbO7Fe0iWO/cU7lqJacNTw=;
        b=TjZulnJCDgJGop638U/S4cJ+FHTeUmu3vODj1fjEcQqbxDKhgYfEeL0lmRrbzc/Ejl
         zx5Anc/zXAn6jq3ES7gxd2ZMkbYF6dXmi6MDZzGxQ6DiX5gOXssqqf4OX2Jfy/1IHugU
         Z5lAsTDDG9B/F2UvNBTQMlTN8c3LK34ukKf3+GCbtfAXYQNewIAU9LjfNkzrWOIJ7hzO
         ZR2DvgEZdRpFcT6PB3aAc0NdgNs2hiQYxG+wrYuYsj8ffc1QSNk2d0QGDifCKdVaaMrT
         +CfBs5tUa5uTw7TXJ+SP6U7u5gWHKEPn+/m7asbm0PxBOn6jEecnasyfkQrJeTw6s6eR
         jyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778681628; x=1779286428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIxUeW+f3oIsB+GGWCvzSAbO7Fe0iWO/cU7lqJacNTw=;
        b=ZDjtrm3hm37EQ/+OTFFGCh1o3rCUzWiTJWJSFzkaJ9ZqLYJhgWrJb/JToHufx9TcF1
         i1cLIMlpke33IndD8o8mnks+CZPrpUc5AuHN2/D4rpyelcF/kahKd4Bb6IBqD5G0s5Vd
         kshQ16dteDUQDNPy/ZeNvI1byNZUKwhKA/MA9Vzlufx9dxDu/d5zwcBjvS6pmRCOJjyC
         UUOnWjf9qzy5IMpBSCJU42wkBlZdtHTkcQnQedduNZULFGSBKW4P4rh+hrH6820Ta10J
         V7xTSQe8EdzgBiKo1cNH3TBpsJFrV9t012pZnETLk6KR+bABkG03Tw634P++p2PwaBGT
         P80A==
X-Gm-Message-State: AOJu0YwY6dVIQpg3WUnHQ3qQ3yUTF9PpyAKaAwYPefCdw3xvniaBEBqg
	Wp+wRzBmXI1TUvd9s6vs2blhhvSNO0S49kUB65TcUyhsgeb+RzXA8ARUd8UtXA==
X-Gm-Gg: Acq92OHGiB4wN4xISD92izKCPapSDpsvhIDpxtDsu4iYy48Mpb2vR93cbGIIHGxbhsX
	JuqOQmQSL6FGx3rHJjQw4CTkNFcTMdKjlHduXDZ2ZYy/6rx7aR5aoGq+rK5l7Qkpe39aEY8OI/r
	1uobGFvEhNxMAhfyqwL4SWIOQIHOJjdo8euNI3/RKctqPUjzAqy6hbm3iBaao30KYEPn+QuTUcX
	tvvdJB2m8UdA7x9gd/Pj+VZpxNbu4rkG/NcrTC/NyZGorSt6yqjtcjFvxrdzKJCGY8+VyH3HXSG
	6ZerJUjcVjIQI86l80FgSMjXtZpiLjqGCey2VXDGLxu1C9PXZrMLqxjMROp0M/bJ0fno2nZacrr
	yMfh4VFRX89OcPAZlSK56YVf0L8orGZPGNPfDl9kX9g9pjEiHt1cwpYH/88rk5S2VBgJr+hDJJV
	IiRCOT0Rmxny3hAmpUI6+OOTlyALFEI0v3jhdUBpQdEtQ0qAq7kbbnxXjsdJHey7c6XNkmWaJ56
	rDANJlR22h9LolAmHldaoHEAF8=
X-Received: by 2002:a05:620a:4492:b0:8cf:f12c:f040 with SMTP id af79cd13be357-90f8a25af8amr563707485a.35.1778681627594;
        Wed, 13 May 2026 07:13:47 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91c813sm3720058685a.33.2026.05.13.07.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:13:47 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: prevent path traversal via -W/-P
Date: Wed, 13 May 2026 10:13:17 -0400
Message-ID: <20260513141316.38335-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -W/-P options specify the wayland or pipewire socket name respectively.
The option argument is then concatenated with the runuserdir to create
a pathname. We don't want to allow it to be used to construct arbitrary
paths outside of the runuserdir. Also, check and handle
errors when bind mounting the pipewire socket file.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 0dfc5cb2..945a3b21 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -849,6 +849,12 @@ int main(int argc, char **argv) {
 		}
 	}
 
+	if ((wayland_display && (strchr(wayland_display, '/') || strstr(wayland_display, ".."))) ||
+		(pipewire_socket && (strchr(pipewire_socket, '/') || strstr(pipewire_socket, "..")))) {
+		fprintf(stderr, _("Error: -W/-P must be a socket name, not a path\n"));
+		return -1;
+	}
+
 	if (! homedir_s && ! tmpdir_s) {
 		fprintf(stderr, _("Error: tmpdir and/or homedir required\n %s\n"), USAGE_STRING);
 		return -1;
@@ -990,7 +996,8 @@ int main(int argc, char **argv) {
 					perror(_("Out of memory"));
 					goto childerr;
 				}
-				seunshare_mount_file(pipewire_path, pipewire_path_s);
+				if (seunshare_mount_file(pipewire_path, pipewire_path_s) == -1)
+					goto childerr;
 			}
 		}
 
-- 
2.53.0

