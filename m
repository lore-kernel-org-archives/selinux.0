Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3329A1
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 05:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792234; cv=none; b=TKBA4sYcYN5eeVbrc3LVz7oNdX2tDvd4uVyNu62Qmljp/0HNuisAVRSXV92dFD3VJTDUiJao1KXXGBjxwiKeU5jIv8nvHwHHv73LCNPpP0eIvxkb+hbdqr3OUWbJ/VeorsWPOUMlMoGv08q5de6+i98d5go/1XWwSDZatUFJ66M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792234; c=relaxed/simple;
	bh=qoQQUwEZ8kVzO/AmvcsV79mms4618/jP2+/E5IWwpcI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o89gjSwNs63j7GE4TrGBXZp+aXoGrjo81DmcQXgG+8NtatZUVRbKbt84F4MHn7jEL3IlHzPhZOPecOwyamO1bHStMpUdYiolxRvC1X1Qyw9kDMj8LzzGLm47COmhjFuUhdCWSDqbZy/WkLf5LFA3OMNB4Z8wfoDgRthd0QPduwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y5ixhH51; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y5ixhH51"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4d48818a04so2789910a12.1
        for <selinux@vger.kernel.org>; Mon, 01 Sep 2025 22:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756792232; x=1757397032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0puSWmhAzwv0llpZiwEpwT7qNhsPc/I80IWMJGdEhc=;
        b=y5ixhH51FIQAQA6VeLaJZdRjAPERUQ4hvJzby0AdYjJztwj6PdkZluR7GyCPqb5GmO
         7JzLLciMU/yRQEBymiu4LE76xWAg4+8+3h1eFelQJ9bLgQWODTHHHXk6TYwwG4BzL1pw
         I+xbkTz0MRfOxiWbXgVSztfbd3RaPFbfrBQxm/Flo1mNIuor8jlTiCsQKsVigZU+pjMZ
         y8BWPNS0t1FB09lvjCD+gSTS8GdNmbYp2AyKuxGMQRCkW3keTUBntcjZKj/D3XFkh0Go
         rrBF8bybjhoKWl4rI7co/4DkzByP7d/FLE7H7V3VTL+r8fJAH2XvLnfQAr3sqSHhQbZr
         EMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756792232; x=1757397032;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0puSWmhAzwv0llpZiwEpwT7qNhsPc/I80IWMJGdEhc=;
        b=ABnfo4yvlQwO3UUvxAlTiCmwYhwu7ZF8HNOIXgjXZuZXyC2+owMCpFFchgRhbaVljA
         RbLGg9FG1LBs2sK2a2YIbO3mkoyLFQD5B0Cpv12AIDisYGMWqAN658FwPPF7NYfOyrjL
         KbRTShAm3vm/ALaFJmy8quOZgYLnhjICQ57xQ8e5iwj/KvS8v1i/K2FrMV1xrBRnE0Ci
         7ojqokTCoA9iGyDiH9qZrzxHDNSg+PoUtIGMkiQwx8wSw0GkfoJtZiISM039hFuRJFb9
         vpMDjCJ5yX9FJTgSyAa4DQ9ex2qYafQwJqj3Xq4nCUkdTxBRRCrPjnNdKxiEwQEtlHcH
         Wk5A==
X-Forwarded-Encrypted: i=1; AJvYcCWMGL+WWaZnZ/Alkfq06FnYOzl/vvxEhnej7xrQeTC371SxWkUbvkIpXSqpgQtv5qjH+W4EegHZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyszJD+IMiZUoJTVWnIysXk5NOfb3g+GhfG3DczRwr+qytkfoV6
	IYcEc5MkhdJxFpt8B768iABtTBC9jcr3scGut73TIXonyOXuxoPaTHZ1bwxZaRD4HM13f+CNmbB
	KIQ==
X-Google-Smtp-Source: AGHT+IEicAH7vTUt8tlHyqUD4mQH77sKwr+0Oy6K0ITSLp1EYQwVwslnOCRGBqixSTMx9m79ZcwbUisrSA==
X-Received: from pjj7.prod.google.com ([2002:a17:90b:5547:b0:327:dc98:a03b])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:5483:b0:243:aca2:e4ee
 with SMTP id adf61e73a8af0-243d6e01973mr13591156637.22.1756792232253; Mon, 01
 Sep 2025 22:50:32 -0700 (PDT)
Date: Tue,  2 Sep 2025 15:50:26 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250902055026.617170-1-tweek@google.com>
Subject: [PATCH] libsepol: add memfd_class capability
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Vander Stoep <jeffv@google.com>, 
	Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

memfd_class was declared upstream in [1]. Add it to the list of known
capabilities.

[1] https://lore.kernel.org/selinux/20250826031824.1227551-1-tweek@google.c=
om/

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/s=
epol/policydb/polcaps.h
index 0835ea21..1f8e8bdb 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -19,6 +19,7 @@ enum {
 	POLICYDB_CAP_NETLINK_XPERM,
 	POLICYDB_CAP_NETIF_WILDCARD,
 	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
+	POLICYDB_CAP_MEMFD_CLASS,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 7ac0ae7c..22f0905f 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -18,6 +18,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX +=
 1] =3D {
 	[POLICYDB_CAP_NETLINK_XPERM]			=3D "netlink_xperm",
 	[POLICYDB_CAP_NETIF_WILDCARD]			=3D "netif_wildcard",
 	[POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]		=3D "genfs_seclabel_wildcard",
+	[POLICYDB_CAP_MEMFD_CLASS]			=3D "memfd_class",
 };
=20
 int sepol_polcap_getnum(const char *name)
--=20
2.51.0.338.gd7d06c2dae-goog

