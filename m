Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BFF2EBBA1
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580809; cv=none; b=VSBAgVHlFpgKnCRcBbwVw2+G19A87xCjLuE43vhMYpOwq0WRWajBNSXuRJvJaWEBEOyDidRwDL9OF/SkYyCkAI+hxuR0whfZD7Dx4A/7snWM2kMgvjBAwBP89V1j1VZzmqsEg7N3Wkii1P0kjpvDkVUgtQGc3vfqOFQXKTyGiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580809; c=relaxed/simple;
	bh=5se711kePA411xaoz5RodsO+PLdGel9RlS6q8G/sC4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bFkuQFW6m8fBH6Fvt82mpeQNoLph/w0aU1rAuVoAe9q1I22KEL8JgmBlchOx3VBmUbccJTqcRiAE9ktapC4Lcb/83BfJz3COEmWFW/ZdhDbmNcnObKAdvSizk5OKnCkPmPF1gw0vWOgTgNbGpZkgYj2j3h3PeQ4UgyBytDwKx5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLPeZ39k; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLPeZ39k"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484ba00601so1971609b3a.1
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 17:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786580807; x=1787185607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qkjz+h+zNCGoWltKJetL2Y2JT1Z7HAkSp1FmTaM3CtU=;
        b=PLPeZ39kIdPQ9wekhs0NzjRWi0g5wU9Prl+htO8xBcFkU3JCSA1SE+liU26MJMGsE5
         ByhTiXnyRWgD59RcAct4IrEAjcZoPU7NR2PqLOLU8tlCk4OOIG/1EBit6OoqTy1GFSFm
         H2OcpN+BH4NmrPKnvdV88+SKddhxHQkku6jYjGkny99+NX2knla7Q0mmxyARdUr6oBM6
         E7jWGqVo7QBmfMo3FBp+I8LOM8XjJG3eIN8tFwTNCc1CD95G1GYCIEbsxN0gzpF3kS20
         9ippzqsPZ2zOFqmAs8+5bVijVypsJbv8Vhx7af4d049+yxa3orpHGPpG0zuUakufFLSD
         CHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786580807; x=1787185607;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qkjz+h+zNCGoWltKJetL2Y2JT1Z7HAkSp1FmTaM3CtU=;
        b=sjcoea9t5n0SJiNAqtjx6kOkJqdxY02kWnu9RXWo6sYvDKdtOXvg6GmS7MCb68K22A
         CCFbUe9zZ3TTNJTgVoADHroXZ4nMbJK1w2clKC1d+7WUota1z3oT8WWUoMIuJDq+VZRo
         M1z0SfnwJLWzapT0sDkKuLYIuhfICyst2pMCmLe9OZnMRm1BarjGoJRjtt8TWK/pNeOa
         KnmuC7IUdF8ZRbUBbwNwrkOFZIxF8aDDVr7z0hufcTKwBKIWBZQ5fVWTPtVOKhXiSKlk
         Bf0wabSN8Zg7dt4ArdUGjW6AXo2P0MhhMFGuizcedXB6rHC90olenMmk0hkXXMUCmwHV
         O9SQ==
X-Forwarded-Encrypted: i=1; AHgh+RpZW0SwaWwWGG3k6kc7tagay/ZjB3o9qrrJU8Pgew4Qif5y+TOtQzk5UgkX0vnuBTm+hhT1lWL3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp4g2DVpVcieXZl1V/hy/JJx4C/Y1uTPcmLwzWO3KuMykMwUsB
	Z0gwEKfPUBMPWn62LWyJasNYgoHw1Q+EDP7Ch+DnWidzZ0+rK2qpqr4urMBJKL6NNfVZtVHFwUg
	iUg==
X-Received: from pfx22.prod.google.com ([2002:a05:6a00:a456:b0:84b:50b5:d431])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:44cb:b0:848:4080:afe8
 with SMTP id d2e1a72fcca58-84fc751547fmr1831794b3a.22.1786580807349; Wed, 12
 Aug 2026 17:26:47 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:26:16 +1000
In-Reply-To: <20260813002618.3755631-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813002618.3755631-1-tweek@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813002618.3755631-4-tweek@google.com>
Subject: [PATCH bpf-next 3/5] selinux: use kernel sid in security_bpf_*
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jeffrey Vander Stoep <jeffv@google.com>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Eric Suen <ericsu@linux.microsoft.com>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Sid Nayyar <sidnayyar@google.com>, 
	Neill Kapron <nkapron@google.com>, Eric Biggers <ebiggers@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The security_bpf hooks provides a boolean to indicate if the call is
coming from within the kernel or not. If true, use the kernel SID
instead of relying on the current process SID.

For the token-aware functions, the kernel sid is used to decide on the
access, but the caller remains owner of the object (program or map).

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 security/selinux/hooks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f197cf476190..e7c5993f6954 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7181,7 +7181,7 @@ static int selinux_ib_alloc_security(void *ib_sec)
 static int selinux_bpf(int cmd, union bpf_attr *attr,
 		       unsigned int size, bool kernel)
 {
-	u32 sid =3D current_sid();
+	u32 sid =3D kernel ? SECINITSID_KERNEL : current_sid();
 	int ret;
=20
 	if (selinux_policycap_bpf_token_perms())
@@ -7296,7 +7296,7 @@ static int selinux_bpf_map_create(struct bpf_map *map=
, union bpf_attr *attr,
 	bpfsec->sid =3D current_sid();
=20
 	if (!token)
-		ssid =3D bpfsec->sid;
+		ssid =3D kernel ? SECINITSID_KERNEL : bpfsec->sid;
 	else
 		ssid =3D selinux_bpffs_creator_sid(attr->map_token_fd);
=20
@@ -7314,7 +7314,7 @@ static int selinux_bpf_prog_load(struct bpf_prog *pro=
g, union bpf_attr *attr,
 	bpfsec->sid =3D current_sid();
=20
 	if (!token)
-		ssid =3D bpfsec->sid;
+		ssid =3D kernel ? SECINITSID_KERNEL : bpfsec->sid;
 	else
 		ssid =3D selinux_bpffs_creator_sid(attr->prog_token_fd);
=20
--=20
2.55.0.691.gc56d675ccc-goog

