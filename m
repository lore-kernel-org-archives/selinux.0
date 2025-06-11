Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9628FD
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625378; cv=none; b=Errv5TjCL0Jv392JraJsLmzNhm/OulS1yqo2AvWaOPMXR84PJAmVlxIeorO2sNWfNtz7UtMV7kGCi8roAAJBbLpYJy9DzNvtV0di7V3hyET9OjRB0ocWjiaUhzUTPRAaA2ydsHC3j4Tjn4x+wR6lEx60uHZsnMhCQgHmgZW5dXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625378; c=relaxed/simple;
	bh=lWjD62b6MJJXJI52t2XsRQLOvguuZAypI3EaI0rYSK4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rhsBdG6lGJHnFzxxbOGSqjVpcOlX5CkCbxVnZZST2TEei6DQl1BPBwsUhXNxK0QbO58GTGkc60iI6EdjR5i6fhHF4y2bUEpCLD31OHpRtRzln887Yb6GfRw9oky4MTCy+7e8F+/IC0P6kYdweAeRYThwaoie3OF2WWb0qBNXnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qPcgpxyZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPcgpxyZ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313b0a63c41so728408a91.0
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 00:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749625375; x=1750230175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lWjD62b6MJJXJI52t2XsRQLOvguuZAypI3EaI0rYSK4=;
        b=qPcgpxyZAYue5kLb80WhkcyOJfrX6tQdQzlgGiJt+STGLiRhjEL+vVhVcFnJF1rWhM
         hX94xNUru9C6eKmeoJZ7SmGPI9ni/zviPQC8oqFfBBxFqR781Mns0aUw59qodzHIZPMl
         rNMk6ndMm3qH4hz+mlYZQAckEa/yHIatMX3KRqAoRuP8cE0QL5LESeVjPBnjTmbxxoxI
         DYh8ICIGa9MCNQ9r7cCRcrwGJ7Cj+HcmAtbtdZ9wohv3pfB6CpHCz5+kcAD61+VGyipn
         vkeuuWG2Mh8Ltx0iLwBour9z5dsLgWU70kVcnd3h9yrB20DIAHJZl8Xr1qNJoFE6Z6Ft
         +cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749625375; x=1750230175;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWjD62b6MJJXJI52t2XsRQLOvguuZAypI3EaI0rYSK4=;
        b=UhmvKPgpwp55gqcpxI9elhSE5C0Q/+YjPamukWgvefdc0TJF3pgBlA21nR7MYKlZ5y
         9UsWkFFLBHsrOKY7OO8fW4NIn2gikZZF2OLCDS/fq7wuvvRZhBGME+zk0IyNGCPqw02P
         TP+ALZAIyKwnmj+dh+BUEfnfbDNEIk9bnAYThnqjXUVMoKEaoFMU01JtFquV+qzfWMvR
         jnObZBm4qMuf/H5q/5Ytnm/+Ak5j6FPZOwol3J0OFigz2gccbsL+x13JEzin5dFmtfSH
         qZQEkhucbYJBa0laY2lrjk7FGsptNMDXufmWmreUbdjJAFQ2FNuUmFlakncbRE4NLsbO
         mdqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWciRYDfKrFutJNiMrSfHld+KLKK9cu3QGOkDg6pC1ZiO/sjNOBnhjc69AMSvA/yoBI+KmwUIbz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxor346KxQ0VX6/qcvr4Akc0sNK/UdGfO5YkLf/CGNst73OAWz
	eKXN36C4tsh5q/ZQ4DY0o58ninp3X1Q/OIP7f6Qz1Y4fClm8p7i9Djk51SfW0eF85qKaskaBS7u
	C4A==
X-Google-Smtp-Source: AGHT+IFsVM8o9mvv/zxvYeQ3bvdaK09MLZFJ8q9fk9rauNu4Z6lT0WO/9n1lJp2j3n48gQ3XHs1exeDeAA==
X-Received: from pjbqi5.prod.google.com ([2002:a17:90b:2745:b0:311:9b9e:5384])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3950:b0:311:bdea:dca0
 with SMTP id 98e67ed59e1d1-313af23396emr3569570a91.33.1749625374812; Wed, 11
 Jun 2025 00:02:54 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:02:48 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611070248.2669186-1-tweek@google.com>
Subject: [PATCH] libselinux: Document thread caveat for security_compute_av.3
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Seth Moore <sethmo@google.com>, selinux@vger.kernel.org, 
	Jeffrey Vander Stoep <jeffv@google.com>, 
	"=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Move a similar paragraph for selinux_status_open.3 to a CAVEATS section.

See discussion at https://github.com/SELinuxProject/selinux/issues/287

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libselinux/man/man3/security_compute_av.3 | 5 +++++
 libselinux/man/man3/selinux_status_open.3 | 9 +++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man=
3/security_compute_av.3
index 6c82eca5..af8797b5 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -181,6 +181,11 @@ function.
 .SH "RETURN VALUE"
 Returns zero on success or \-1 on error.
 .
+.SH "CAVEATS"
+.sp
+These functions are not thread-safe, you have to protect them from
+concurrent calls using exclusive locks when multiple threads are executing=
.
+.
 .SH "SEE ALSO"
 .BR string_to_security_class (3),
 .BR string_to_av_perm (3),
diff --git a/libselinux/man/man3/selinux_status_open.3 b/libselinux/man/man=
3/selinux_status_open.3
index 5c9da2f6..5592487f 100644
--- a/libselinux/man/man3/selinux_status_open.3
+++ b/libselinux/man/man3/selinux_status_open.3
@@ -82,10 +82,6 @@ Thus, don't use this value to know actual times of polic=
y reloaded.
 .BR selinux_status_deny_unknown ()
 returns 0 if SELinux treats policy queries on undefined object classes or
 permissions as being allowed, 1 if such queries are denied, or \-1 on erro=
r.
-.sp
-Also note that these interfaces are not thread-safe, so you have to protec=
t
-them from concurrent calls using exclusive locks when multiple threads are
-performing.
 .
 .SH "RETURN VALUE"
 .BR selinux_status_open ()
@@ -96,6 +92,11 @@ On error, \-1 shall be returned.
 Any other functions with a return value shall return its characteristic
 value as described above, or \-1 on errors.
 .
+.SH "CAVEATS"
+.sp
+These functions are not thread-safe, you have to protect them from
+concurrent calls using exclusive locks when multiple threads are executing=
.
+.
 .SH "SEE ALSO"
 .ad l
 .nh
--=20
2.50.0.rc0.642.g800a2b2222-goog

