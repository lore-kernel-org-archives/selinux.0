Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C191F76AB
	for <selinux@vger.kernel.org>; Tue,  3 Dec 2024 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264870; cv=none; b=cdcOK2ptey09FKI8kZ8D1bCiHL5JF54TYEQmM9A5Xbh8bUAcFx9u0+gdvLNKO6/FD+tlMLtSvTDWhZQsGL5Aj7RrAS7lQeHPkDerrZjPDzIRu1ao0hQedddYUwOMjCk2Z6feBYmgTWyAVHwxXnuRVGAdN1jpxtk+3aVXRUshleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264870; c=relaxed/simple;
	bh=WNYe1o1E+sKTVbP6Ybjq1VDhGh2GpC/P2mbOJzZZqPU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NEcJHrJURU4mV22m5VjDurhl3Hf9wmni5V7RoUBOTQ67UyYPb39SxcV40fhuLMHUfFkIkDW5fJCdZqRuGHwxLHPwVagWsf1tKexhaelM0qaHUAqJ/YLOvVFQhJQpWhkbMzm4NfkLjmGWcPMrPLrKvMul1BnIepfgiLMyfhIoB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0l3qHT4Y; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0l3qHT4Y"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7f72112de23so4433992a12.1
        for <selinux@vger.kernel.org>; Tue, 03 Dec 2024 14:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733264868; x=1733869668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fvqSApl58CYFy0UhTS9HgevMdMxy/zQMiCldsU69za4=;
        b=0l3qHT4YCdXOJ+uSQuhuIFzlUyFljYEOi7NJuqg5sp9Npi9FmjtGfbJrhGnaVehhnO
         M1jmL9kusIuxMgoGFxZATHuh9ZWz09FEkB2SOS8Iw84H0oqASq7qMliHYmw+Ss1iUb/j
         g681A1EQHM3vZeNTYcHcARPw5Zlh2PY6drRHVIjdezrc/YB1QIzyEXCpT4N0xRVUvk63
         HC7kV62RmmOVajqKRej409q3+5p0M30aFNAa+Ovg14dnD9OOSOlyPg1AMnKpyjNiA0rY
         jm2JM0IsDTW7fHl94RPpNPFEkIl0J15Q+gjRjvsAwus3sdL+4oivFuXoC+Ygxd2pyxIo
         7m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733264868; x=1733869668;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvqSApl58CYFy0UhTS9HgevMdMxy/zQMiCldsU69za4=;
        b=OPf/7Zs+oCWEoNEuVljaVXKP2Lnfv2q2JIdOBn053D3qf7RW/JdXzl5ghoETdPfGZo
         QEhcIMhcB5A8khEnXJwUK6OLeJeGjTlUELW6tU4Y0o6yWuHV1GD1cohKxHOAFAWP/DTT
         PSvu74ePp3ZXc4hblB9Q9iN19m9C0p208AkKZgMqaS8BS8dINAPBsPe0jp5Z/kI/Knb3
         DLYRLtDeQQAIFOj9fmHRHR0RIPUzAHInWFQheNf1AUo8MUCFd2dVBsOeB8zYLHpxjgW5
         NPBKr9Iu1WDRbR0vLO16dq7o+9AxxtffciCJ0IiPPiUxjre3g/Utv22ckJ3odIBFMu90
         cj6w==
X-Forwarded-Encrypted: i=1; AJvYcCXrz3Sdds4DJ7/GyGVsOvnHCJsWox8aGghGPS0cE7GcJiBgpEOu2SeQvOxZYAsu3gHHHkFmE54i@vger.kernel.org
X-Gm-Message-State: AOJu0YxHnLrQy5TexnlA4X5v4AEi+zR5l0NEaPLd1JajBRG/HhTV9R/A
	K8zcIPZi1Ve+O45uGy13QcdOZvHkfSiH+OQ4PG1hF44e/ThGGI8w6p1Flqdz5cqfE6KbGwRwbQ=
	=
X-Google-Smtp-Source: AGHT+IFmeN3P+Vylk2gC4lu4YM2dsQ/SnGCyQUe1nX4+5lJDrCUCxHnsjQodefPMSy+q41o9EjTjTXP7nQ==
X-Received: from pjf15.prod.google.com ([2002:a17:90b:3f0f:b0:2eb:12c1:bf8f])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:390e:b0:2ee:c4f2:a77d
 with SMTP id 98e67ed59e1d1-2ef0121557emr4759165a91.21.1733264868061; Tue, 03
 Dec 2024 14:27:48 -0800 (PST)
Date: Wed,  4 Dec 2024 09:27:41 +1100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203222741.1739916-1-tweek@google.com>
Subject: [PATCH] selinux: ignore unknown extended permissions
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?Bram=20Bonn=C3=A9?=" <brambonne@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When evaluating extended permissions, ignore unknown permissions instead
of calling BUG(). This commit ensures that future permissions can be
added without interfering with older kernels.

Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
Cc: stable@vger.kernel.org
Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 security/selinux/ss/services.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.=
c
index 971c45d576ba..2fa8aebcb2e5 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -979,7 +979,8 @@ void services_compute_xperms_decision(struct extended_p=
erms_decision *xpermd,
 			return;
 		break;
 	default:
-		BUG();
+		// An unknown extended permission has been found. Ignore it.
+		return;
 	}
=20
 	if (node->key.specified =3D=3D AVTAB_XPERMS_ALLOWED) {
--=20
2.47.0.338.g60cca15819-goog

