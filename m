Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02142F0055
	for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263464; cv=none; b=h2/tnw/8f8LD4AoHHox9ZdApnV6fiREhMAA7YPFOsz2sge0aIa3691UiceGmBIwbA4GMNtt6FIiBm/2HqGamYX3FKhcbhFGpBVAo7jfimEsLjEgGk8OJ6LgwK6+XW72k0aiemINqvxmWA2K4FGQTKA+cBniQzOyILnSQVM7ovrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263464; c=relaxed/simple;
	bh=3+BcJDbFUlTzpVWpJpkXhBZDfrO0Nv7Bpm6ASMaHkjM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jHHx0nx9gQ/DH8HK3ctrZ8ZOLwIzaErLzhAh7xE3B4oThb3qou1rEoPRLMrNC5MFlWGKOvIqIIti1c1xsXHrnKIROXvM6rJyntGryEiGmEuDb+k8y6U1TGjYoCKhMbeJ/qrwL7Aew8KJPmL/RvQlloAfk2ghDDB1URCuBR34oM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PP77yU5d; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PP77yU5d"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a6f6d52af7so76789951cf.1
        for <selinux@vger.kernel.org>; Wed, 18 Jun 2025 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750263461; x=1750868261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/7gmaWiXHdYsfhah6UjUbyJnAEks1MRYCoExlQFi7g=;
        b=PP77yU5dbpUkz9l2BLpcs7Pm3YLDrFUpX/7nurIG6pCTRR8DQMa3Op5hLTLP34YLM8
         6LVRwdHrpgNEa1dRNJHrguJdMabxGvUPM769kpSNoUcbk/kwW7PdvjPkxdESITbb5/ZL
         2j4R5uTT6Fc+7HM1geDbJjsughQMZ/YnbmE7VqT5IuUGrXH53dm8hO7g0yL3/LOz0aNV
         s8K2yncVQRjUhilODoa1UAVXo0szkfaqCKqNXR90Fa3AKOjSwNrmuLm+OZKo7fkb/Fqs
         dC9VTGtWU/COwBRxyYBW1cr7b2sagAzW7FRzBoXBLsbchCXemnKr6DYKqAQgzVU8NlBm
         YTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263461; x=1750868261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/7gmaWiXHdYsfhah6UjUbyJnAEks1MRYCoExlQFi7g=;
        b=G0zLjvmaz9EgyTDUaACQe86C7L+FI5Gr6rs4M4VSs6qR0VMn7TY1nWaqIoBcsSwMsA
         wbBNNVaF+HiNt8QttkBXfCdHLSe4loScdCTs9me368ETJIWBnJpBIOHAUOBwDgw5E80h
         6nQmlq2SDHofheA3oBZqVhe5g7I5EDnSdVSTE/rFVJcRPCQJQecVxNfDX1qlOO0SBsyj
         g9m0gHvRlzAHN9pvM3CL7n7LeeYATWgMRphd8pcuP0BTI1uYXSGoQTP84nlHGkStXwx8
         K/fhGy4MvI6cq0cKxVZYyFf27CNYdRTbe3oItZtwmN96ojnYB2c6NZL3Y0bpvm0b+Qmo
         RJhg==
X-Gm-Message-State: AOJu0Yw4lZBG+n01Z+t8f5KdtIMRwzhNJKUaADzfztuI/o1HNYYJNLSo
	mQgizt+jqhdUry/fFeRe0r8Zbj4U3yAL0KbBFc3D77sO6ZH2GBDcKqvm3Y01xx7F0brURG/faEX
	e8xU=
X-Gm-Gg: ASbGncsvNApYdGH7U1xmN5g+kXNQX8zgMB6J293UzFkdATc/vk96QSoC/PSsd0577lb
	cBU7idAalKE8x0od9Ct9m7C4ThyfX05bPGbc33I15mI4d0cqUWTkKudGSFOlzTqn4KpqMdlgnVz
	gQzt/oIRwDlxgGFWizhDlAvt21lzRSWvbE34yGQ7wV96Ijb1pfefyH+g7LrUEi/AWlFW34Vakzr
	kk1WWP/fL2dCZJhe+Pi4bUngB9cCnJcl2YxgcWXdhXT0b+scixDCM/PyuuXqR1E7mDFPJWiRrwV
	8OBn7uf+46LXw47WB8dHtOcOlt8Vm7WbA3R7ZEd4bjCIxBDV1xYqSsq496BkWu4xSNBq8pULRmI
	7dKAEPyvU3hUUq9dhBfwfvRosEpKYYFg2wGuTQRfYBQ==
X-Google-Smtp-Source: AGHT+IE5ishEo7HTTLLy1Y6xuz8t67fh2kSyUH9R1xGJVBOr9NUeO90sBk9riVfpKKDoP3KOzUgaXQ==
X-Received: by 2002:a05:622a:1a9d:b0:494:75f7:b0fa with SMTP id d75a77b69052e-4a73c61709amr302660201cf.41.1750263461424;
        Wed, 18 Jun 2025 09:17:41 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a72a4b13cesm72720631cf.51.2025.06.18.09.17.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:17:41 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: add __GFP_NOWARN to hashtab_init() allocations
Date: Wed, 18 Jun 2025 12:17:33 -0400
Message-ID: <20250618161732.140904-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=paul@paul-moore.com; h=from:subject; bh=3+BcJDbFUlTzpVWpJpkXhBZDfrO0Nv7Bpm6ASMaHkjM=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoUuacsD4R+RBNH0iJjr1RRBh1fU2lLn8yA9WD/ uP7tuTZUUKJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaFLmnAAKCRDqIPLalzeJ c0+QEADZukzSuIEY6HJLaU8E36bIOLq0XQoXi4w5Ir3tlYGeXfJMMZ0a09Y0Rv91ShdAW/iqMb/ GM006qUtgluqVsjUOSJ9S+0eQoIwkhAPe9XqHde/KTzUmFVev0toyCCip5l0ZfJP4sUQtvfsexU HK9U0VR2J/GvuMh8ZnvLpejiRY+V68qVcH/0ZFwlcGE9qG0FwY0r94mbkjgcmvoNkp3ssPFBegw FTl4tzwka970X9FvwoYCsXJW8pyAXd7Tfs3gdOaDm9fImryec9SE0Tm6DBazShJ+K8lhSt2u799 9ET4SzfyLgocvaxe/FdMFp8xTiA4y1OHkA4D/j5LJgO9J/JSDBi+ym8YHqe0kDXEHZ0KqFT3u2G II14TEz+VbarMwsFXSc+EDlTn0IeHuSbG0vVOYUwymxCTjQ7no7HBVKmx962lvKG6IxtWTf73yB Vp8Nl+F2vr07M2Xf6oGlVD+Cn/kQ8r7zBqz26WKeRWql3tW45jEgsJKk09kkTthNkB04hT/VZIh 8ie0k/5fDBC+7B/FLy/8+2E2AeT6wyZ5eXoKiT8xL5shlaUJVGwZS+ojRnNlNQMWKvwgUV+I+Vq S4E2Rqnib7Hec6r9zXh2dfMQp+93vZd+Q357RIFN822szLAQCL2skfYnhR+YesTpJTOhIfJIIai IY/2yQzLg5OOHiQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As reported by syzbot, hashtab_init() can be affected by abnormally
large policy loads which would cause the kernel's allocator to emit
a warning in some configurations.  Since the SELinux hashtab_init()
code handles the case where the allocation fails, due to a large
request or some other reason, we can safely add the __GFP_NOWARN flag
to squelch these abnormally large allocation warnings.

Reported-by: syzbot+bc2c99c2929c3d219fb3@syzkaller.appspotmail.com
Tested-by: syzbot+bc2c99c2929c3d219fb3@syzkaller.appspotmail.com
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/hashtab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 383fd2d70878..1382eb3bfde1 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -40,7 +40,8 @@ int hashtab_init(struct hashtab *h, u32 nel_hint)
 	h->htable = NULL;
 
 	if (size) {
-		h->htable = kcalloc(size, sizeof(*h->htable), GFP_KERNEL);
+		h->htable = kcalloc(size, sizeof(*h->htable),
+				    GFP_KERNEL | __GFP_NOWARN);
 		if (!h->htable)
 			return -ENOMEM;
 		h->size = size;
-- 
2.50.0

