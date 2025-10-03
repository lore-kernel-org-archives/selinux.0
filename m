Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FBA1EE7B7
	for <selinux@vger.kernel.org>; Fri,  3 Oct 2025 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518700; cv=none; b=eo9vbB6oidNvrCtKFwjy1SDu9FugEp4381hTZJAgn4/dkvDXfnv+8ADeKeBacJimzp8zJUUKCk6IW3r4KHk8IErGgYavWWhZyNxMQxWON5mDNoI+CMMsy3HQQ873XL4UwJE7aCjmUOwsVafp7cZ4g++tMMnvrE8kLdx95syfQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518700; c=relaxed/simple;
	bh=qNhI4fozkv8fv/lAwki7sY08xD4XO8qRaqdADN66AB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VNq8Ug3KL1o2nXuM0t3b3YsemiQi7uq9nk9Ut8RgAZKegB30lk2OXUsIM5jyaedjDEak8av73osiKdj7b0XrB6ShR8nUNPA/tOiB8aepaci9sFzMAX6RlKHDiT9mzPc6cga7dS7cDLm2nf10wFQqksV62Eerr/ZslhGzUgxPCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXBoJdwy; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXBoJdwy"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e06163d9e9so25796911cf.3
        for <selinux@vger.kernel.org>; Fri, 03 Oct 2025 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759518698; x=1760123498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ReEFQvzA0ptpzhP/wKLfBOmz+qA+6kGtcka0Y6onfCY=;
        b=OXBoJdwyDlWMdK1a961ECoFByUwiUT/KLBKxv0ZtjHNl79yVg3pD52MVgzYGrFxHDW
         Z6JM79wCZOVBQiJzeyW51aEd0/TYrZrL9knu0Zd/JJ0DQsyh8ERYoA8BQMqEC3BLG6X3
         OA0LQbfq8VZTJz+xHi0Hxeq5049qSesodGqe0MafVHnvLe92A/Jldt+t01REwOib16Iw
         gsk21g6aBUUfDYoHvxmvuoIqNbjb+JntzIxnSqY5noxz5V4wAJxrdoD4BmsHo7QOU0SH
         cNamGwofGdUAwLx+GIQsSSbi1d+/CLRVTWpOlMeiDZ7kpBnfyuz3nzMs/xrKAkhYLSsc
         hheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759518698; x=1760123498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReEFQvzA0ptpzhP/wKLfBOmz+qA+6kGtcka0Y6onfCY=;
        b=sC57N/e3XUyfJjItWMLr5hFdA7oahVNrYDDPV1e6rp0IHtKdxr0C7z6xW17XW2xs6+
         irffB2+dKbbUozSA0s9V68BR896bCIr8MZHmtdg9IbvycSH9Nhv7ZFCNr4S75cpamnpC
         TL2E1QkKJ4zdU13+OWynPrI2DD1R6+erY20iTeVjUGjZMYH7Zim8hOWKQ8n3pN+4UsTu
         9zGAPYxX62S9QR7i+dxue6dvnafGNpNtjy3LqLBG/fd6H/wrPLeiXK5Zu38TA3C79VtR
         +fHngO8jhS2zSbv9Q/mUqN6QDWbruc3PuZ/EEFOfZz2aQBZ49QNXaNNFB+1EXvUmFysX
         WNew==
X-Forwarded-Encrypted: i=1; AJvYcCU89cCCyRk/UQwnYLiFLWrSZyKmCBqV3YRjAjxSNOAQPQWiIkRirkU8AJn6Tg7a/BlB0Dl20IOA@vger.kernel.org
X-Gm-Message-State: AOJu0YxnJogtiFzMpD26Na1zQjakLLWMZIzgZT4rNGgEgxCjd4kNFIrM
	BlMYAYXp1y4L24SOBimEPvku1x+uLibLyuy5Ze1d/WyxwYAoqy8SpjYB
X-Gm-Gg: ASbGncuZ1CFvv/pyE7QCrqEbSlVtj6l/qxtSWgy0+NQ2iRHrebRSLu9F5gkIiIVdNAE
	n83m5FbPZcZXDfACxHuUrhvjp9+WsxsVoEUv5jeLNsxO/7htvimIuxvCKt2/gZCAt61ZtYQjZfi
	WAqZN727aJGjB1GX3a1pqAacNrrjBR1I3suhMh+sTkjV+O3X5k6I2ou4nqOliIwb5dKzAkQX7iS
	8BcG6lMfv/Ub29tV+NqBjrnjySGL0+6M8ZUoFiRCgPKuY8+d5rudaYtLBrFZajDZb7TArFclwov
	OzAMZ9NrlMOQzUctN7qhq7tjrqIN5UqQ360PEvbpvuOK7rJLRos/SpuA73KFZ1VWbhqDItXb2UQ
	tlwr+/uRz8WvHfkeR4/4qce6mCc1sBRBIo2+D8a/Ss2nZFuXYC5srq4PQ+iD8p8QNsE2M79ubRG
	Lw+LFC4hs/la1my5nR/p/Fv8+9D0lGCkMjI1M4gf6TLe7Q/EyxBrPzrR0tr02L73rYzypvN+fal
	rg=
X-Google-Smtp-Source: AGHT+IEpaRGWG0AE0nbyt0iFzIe6GNXbyGNAl6pbmFlWyLhGrIG6sAvUMUV/AAhdpb0nTbdnc1CI9g==
X-Received: by 2002:a05:622a:4d0e:b0:4dc:cb40:7078 with SMTP id d75a77b69052e-4e576a3c704mr59562151cf.19.1759518697529;
        Fri, 03 Oct 2025 12:11:37 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55c9e79f1sm44631881cf.28.2025.10.03.12.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:11:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: paul@paul-moore.com
Cc: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	john.johansen@canonical.com,
	casey@schaufler-ca.com,
	serge@hallyn.com,
	corbet@lwn.net,
	jmorris@namei.org,
	linux-doc@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] lsm,uapi: introduce LSM_ATTR_UNSHARE
Date: Fri,  3 Oct 2025 15:10:00 -0400
Message-ID: <20251003190959.3288-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This defines a new LSM_ATTR_UNSHARE attribute for the
lsm_set_self_attr(2) and lsm_get_self_attr(2) system calls. When
passed to lsm_set_self_attr(2), the LSM-specific namespace for the
specified LSM id is immediately unshared in a similar manner to the
unshare(2) system call for other Linux namespaces. When passed to
lsm_get_self_attr(2), ctx->ctx_len is set to 1 and ctx->ctx[0] is set
to a boolean (0 or 1) that indicates whether the LSM-specific
namespace for the specified LSM id has been unshared and not yet fully
initialized (e.g. no policy yet loaded).

Link: https://lore.kernel.org/selinux/CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 Documentation/userspace-api/lsm.rst | 11 +++++++++++
 include/uapi/linux/lsm.h            |  1 +
 2 files changed, 12 insertions(+)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index a76da373841b..1134629863cf 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -48,6 +48,17 @@ creating socket objects.
 The proc filesystem provides this value in ``/proc/self/attr/sockcreate``.
 This is supported by the SELinux security module.
 
+``LSM_ATTR_UNSHARE`` is used to unshare the LSM-specific namespace for
+the process.
+When passed to ``lsm_set_self_attr(2)``, the LSM-specific namespace
+for the specified LSM id is immediately unshared in a similar manner
+to the ``unshare(2)`` system call for other Linux namespaces. When
+passed to ``lsm_get_self_attr(2)``, ``ctx->ctx_len`` is set to ``1``
+and ``ctx->ctx[0]`` is set to a boolean (``0`` or ``1``) that
+indicates whether the LSM-specific namespace for the specified LSM id
+has been unshared and not yet fully initialized (e.g. no policy yet
+loaded).
+
 Kernel interface
 ================
 
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 938593dfd5da..fb1b4a8aa639 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -83,6 +83,7 @@ struct lsm_ctx {
 #define LSM_ATTR_KEYCREATE	103
 #define LSM_ATTR_PREV		104
 #define LSM_ATTR_SOCKCREATE	105
+#define LSM_ATTR_UNSHARE	106
 
 /*
  * LSM_FLAG_XXX definitions identify special handling instructions
-- 
2.51.0

