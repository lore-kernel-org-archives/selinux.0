Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A734C8D
	for <selinux@vger.kernel.org>; Thu, 22 Aug 2024 00:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287159; cv=none; b=ehOHgkhA6eBOPDkJal8zb9uFPs9Yl4VrfBymZTqUXy57wasLZTeStB+KuZQD6/9HJ2toMhuT91HjecSj8XqYXZmf+LDkLleLd4BmM/exAda/rBbAShSdGn1k9xS44McBe9JghBEAKnDeIIhiHoTnI6ib3JhHqIUjPIg8D/lDEzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287159; c=relaxed/simple;
	bh=oVkOAEt44SPB+4p0wqPT/Mn4PiIl0Kw3mLocwQm04oQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C+ye7ZGrYf5QhaSX26E5V11BlnZHUQYrAnzK+vpZ2NfHy/S0d/zNLgihavoxEKylNjpjhZuo2hM4/J2mf7Kc11NQjzEfPD7PWO/FUcbKrHeDnk1viv3jKG3hNHOOEzzaMWtgRTpwaJEnP0/EfQzMeJ3eyvA8i7ZL75r0C9Hnp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSZv1Zuk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSZv1Zuk"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-69a0536b23aso6117477b3.3
        for <selinux@vger.kernel.org>; Wed, 21 Aug 2024 17:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724287156; x=1724891956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ke15B4oKXomvm2GlrT46AeYAwzBPFoBjFx6xgv0XDrI=;
        b=jSZv1Zuk3dM0H99QMi5LqMHLTuGsUwk35CCSBlZLdlhBKn1YGt6gvgPzeJW9LFQR6r
         ndDWG89Xfnl0rSrdSPB7/VAHawvjmcU3ucuxmWZf9Cmy8NnG8flRJfNw2neC5mwPlGeQ
         9fcD3o8LoEwx44WDEfiKxFQgAKJTXG9BXy+QD5Y2FhrSsOj9CmRMKEYqWWDIjU5nJdLX
         uEx2+rhBiW3tJXNPgU/9v/bShRkRD+xgNQgzGdHvrXkeo/e+chq41dfROrRb2k4X6rH0
         fs4jwAJz9QY+OEIMeJJ0+4anmCbhcuOsUGlm3vlFHcRikzw9bjyorNErMkinJyKhm05g
         0s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724287156; x=1724891956;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ke15B4oKXomvm2GlrT46AeYAwzBPFoBjFx6xgv0XDrI=;
        b=Lbkf7d4SDWWGQaVhXcWtmcbBJTNvITVzkUOY+NqqT9QJ517vDaDmiMH6Gt8W2H7WTN
         o1fc++mQvRvFJ0oprvMZKu2JD5/FVdQHLQibb1p72Z+/q6IviJyHxzWOsw37oKq1859P
         mqCRYg/3CMONbwoFeDL/ct14efXZzZpMvcQlCB+8sl6HOQXC3VTlXXbCaIeQGwCmNBKI
         t8nENx4EeLcnbmWMD4wxFz0PYZlPe94NpkZ/p8mnPwJL7MfO4V68C4lNv7CtssyjVCF3
         cGar+/p83dt0btHhyvJVjcXWctLNJpCst3bE//QTDDUEMIBjeSsP2O+FAmDNtIdlX0Ks
         jjcA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Ch7/+t/FLeVbPw3e8XCInAx5rhHQct4zuu7iW7Jf/fhP06gSeVMRr8/lGLsgcakosyZRtQMh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6bMmTYp3gmL+O0oDf9cGJ+gDYteO4F5t+N6DQ2Aaqp/wRE5+2
	E1FAG6i42nTvSekBCfbEfnu3450JkHgHcRuBykqTRRIiHv4KQ3UCp0BpupXIvs4Ip7QQhCDlGg=
	=
X-Google-Smtp-Source: AGHT+IHxYUlCvUSSRdXzU4xmyXIEdcGLsxmdCheml1w45FIzHvU+JPmKUO5pg8yVqRVaPPC6TP/v0KTs/A==
X-Received: from tweek-syd.c.googlers.com ([fda3:e722:ac3:cc00:b7:3870:c0a8:26])
 (user=tweek job=sendgmr) by 2002:a05:690c:4a0d:b0:6ad:4eda:ca25 with SMTP id
 00721157ae682-6c09b62c7acmr3312647b3.2.1724287156702; Wed, 21 Aug 2024
 17:39:16 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:37:57 +1000
In-Reply-To: <20240822003757.1998016-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240822003757.1998016-1-tweek@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240822003757.1998016-3-tweek@google.com>
Subject: [PATCH 3/3] libsepol: Add policy capability netlink_xperm
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: paul@paul-moore.com
Cc: brambonne@google.com, jeffv@google.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This capability can be enabled to change the kernel's behaviour and use
the extended permissions for netlink messages.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/s=
epol/policydb/polcaps.h
index 14bcc6cb..1aa9b30a 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -16,6 +16,7 @@ enum {
 	POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
 	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
 	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
+	POLICYDB_CAP_NETLINK_XPERM,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 8289443a..6b28c84e 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -15,6 +15,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX +=
 1] =3D {
 	[POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]		=3D "genfs_seclabel_symlinks",
 	[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]		=3D "ioctl_skip_cloexec",
 	[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]	=3D "userspace_initial_context",
+	[POLICYDB_CAP_NETLINK_XPERM]			=3D "netlink_xperm",
 };
=20
 int sepol_polcap_getnum(const char *name)
--=20
2.46.0.184.g6999bdac58-goog

