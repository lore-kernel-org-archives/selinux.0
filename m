Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5622E7179
	for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580800; cv=none; b=APUHhV7XhUkAvdIM9CctWnA99axweU4iqQLw1wiLCo0ybqzbQDFG2pjS2cApvPLkQOrUb2R6iEEA9kkh5aZbjWevs06lRyx/i9bzofFkz/TJTNxAAXQhWbpDTRQP+CAbASAbmFLXnOq6jPzbrv9arxl/IpRS9c0bUDdn4ZkowM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580800; c=relaxed/simple;
	bh=PagIVbs3JZ91gND3Jax5qRoqj4Kakth/whntQuD8tlM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qNVrtQfdveS8UVl1xV2OFqMOTBTP6DvGG/zLsps0tb2ff8KGtvRdBMv+qR9a/QSpXhtB5sh0ECHz03gnKDZkz84Koes0I2WGtLXZ+xFPWB8QRk7fqM2sprT0GzI4APtPruiIn0Abm0YIUX8YZt69c7k7xR+vsYnyjUNd9JBSiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mqYxPUNh; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mqYxPUNh"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84eee2147ffso235118b3a.0
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 17:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786580799; x=1787185599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wOBAJjPbhXDDuiSCf0eRkBabtYoc0jLQAAGdFQiclE4=;
        b=mqYxPUNh1iP+2LTxI1wT0N73eR4sTUTzEf63mlFyddy0IAxEsvfgzCcv6dVklkOxYR
         9jUZa5NrAVe4H0bfhPZRZMxEeLkdmY0uCAytnIEASgtn5u8/wEAIBXVA1C34Hrt8d1rk
         +24yNIL1hWh5vBnqy2wDdUcrlkh3NiT4Vej02g8ChhV+hvo8+FDbcKT4jR6V8m+6xD9O
         ZVdms+BVWfIBs9aZGrw/Y4jXHMQ0/TsdXuUdgC2RgIwvU+zmRfTPM8hdUe37h5pUileV
         4psQbPQbxVcwMWToFrtLWbm/YvUMHC0NFmKu1p6/KZNXVDFyXPai4+3CWOr8vwaxxnA5
         N20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786580799; x=1787185599;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOBAJjPbhXDDuiSCf0eRkBabtYoc0jLQAAGdFQiclE4=;
        b=dzKlJ9JE2cVaXBN4x//XAfcphxM/TBOiDw8hljZlkHHT7xzCC+Gu5rIwnIXv1QkZjR
         cWlTOluOq8pBpukXIYq5/c3NdLg6K9tIybkzNxUeOZlnTlLc3GC5kTIH0WMw4uBNzgtL
         pgpp4UuStbUXj95blWrBXb+HAjrs6jMUnbZKunTDKfkbxmpr7HFr5Xm/GA2ZrjPo8cyJ
         Bmz8mZKPeWW08NrrWGUcI9fP7u0lXyc2YLnibqDjRXkHnY6ZR4f2JFUgLMlBR9iLENQ9
         S7F2UaI21O/LDusFOdGHYe6bSQw+bpnMNkPat5AMx3m2WnUVL9xalQ6Dulo0RfupX74/
         vDSA==
X-Forwarded-Encrypted: i=1; AHgh+RrujAr6YBPsa9i6wMzBtgD4W8dR9pX0GqQ/sr+WyZ1U7RSvV/XAJLh14m/Jb4qu+NZFbK8Z+sGg@vger.kernel.org
X-Gm-Message-State: AOJu0YxG9+FuFQy+WHb3R4i8UniM9uSflK0NO7/VAb/FSocKu7LYd77E
	OOK5WQOcJgbrEo/34rgTMDmI6VwdJJRym5pDiAlVYAvpuI/EUvTS8XPN5FK4nP+EF8+/sUhunNS
	8vA==
X-Received: from pfd4.prod.google.com ([2002:a05:6a00:a804:b0:84f:b437:398d])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1151:b0:84f:a7bf:8fb9
 with SMTP id d2e1a72fcca58-84fc749372emr1758140b3a.3.1786580798413; Wed, 12
 Aug 2026 17:26:38 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:26:14 +1000
In-Reply-To: <20260813002618.3755631-1-tweek@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813002618.3755631-1-tweek@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813002618.3755631-2-tweek@google.com>
Subject: [PATCH bpf-next 1/5] fs/kernel_read_file,selinux: Add BPF_LOADER constant
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

Add a new constant for kernel_read_file when loading a BPF loader. Add
the matching SELinux policy for that constant.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 include/linux/kernel_read_file.h    |  1 +
 security/selinux/hooks.c            | 12 ++++++++++--
 security/selinux/include/classmap.h |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_f=
ile.h
index d613a7b4dd35..fbcaf41c1b73 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -15,6 +15,7 @@
 	id(POLICY, security-policy)		\
 	id(X509_CERTIFICATE, x509-certificate)	\
 	id(MODULE_COMPRESSED, kernel-module-compressed) \
+	id(BPF_LOADER, bpf-loader) \
 	id(MAX_ID, )
=20
 #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 18dd28b2bb13..f197cf476190 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4411,7 +4411,7 @@ static int selinux_kernel_read_file(struct file *file=
,
 {
 	int rc =3D 0;
=20
-	BUILD_BUG_ON_MSG(READING_MAX_ID > 8,
+	BUILD_BUG_ON_MSG(READING_MAX_ID > 9,
 			 "New kernel_read_file_id introduced; update SELinux!");
=20
 	switch (id) {
@@ -4437,6 +4437,10 @@ static int selinux_kernel_read_file(struct file *fil=
e,
 		rc =3D selinux_kernel_load_from_file(file,
 						SYSTEM__X509_CERTIFICATE_LOAD);
 		break;
+	case READING_BPF_LOADER:
+		rc =3D selinux_kernel_load_from_file(file,
+						SYSTEM__BPF_LOAD);
+		break;
 	default:
 		break;
 	}
@@ -4448,7 +4452,7 @@ static int selinux_kernel_load_data(enum kernel_load_=
data_id id, bool contents)
 {
 	int rc =3D 0;
=20
-	BUILD_BUG_ON_MSG(LOADING_MAX_ID > 8,
+	BUILD_BUG_ON_MSG(LOADING_MAX_ID > 9,
 			 "New kernel_load_data_id introduced; update SELinux!");
=20
 	switch (id) {
@@ -4474,6 +4478,10 @@ static int selinux_kernel_load_data(enum kernel_load=
_data_id id, bool contents)
 		rc =3D selinux_kernel_load_from_file(NULL,
 						SYSTEM__X509_CERTIFICATE_LOAD);
 		break;
+	case LOADING_BPF_LOADER:
+		rc =3D selinux_kernel_load_from_file(NULL,
+						SYSTEM__BPF_LOAD);
+		break;
 	default:
 		break;
 	}
diff --git a/security/selinux/include/classmap.h b/security/selinux/include=
/classmap.h
index 90cb61b16425..453522ca87df 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -65,7 +65,7 @@ const struct security_class_mapping secclass_map[] =3D {
 	  { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
 	    "module_request", "module_load", "firmware_load",
 	    "kexec_image_load", "kexec_initramfs_load", "policy_load",
-	    "x509_certificate_load", NULL } },
+	    "x509_certificate_load", "bpf_load", NULL } },
 	{ "capability", { COMMON_CAP_PERMS, NULL } },
 	{ "filesystem",
 	  { "mount", "remount", "unmount", "getattr", "relabelfrom",
--=20
2.55.0.691.gc56d675ccc-goog

