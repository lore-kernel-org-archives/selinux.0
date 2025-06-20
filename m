Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049C2F273E;
	Fri, 20 Jun 2025 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441554; cv=none; b=c4pApPnC7hlQKyDK4/SUhj8Amgc/aF+tsE44ZGJkKZhGBg9b87LWt386erTrjCTBg6doYoWsRd/cLU+pg8HbLHprgdVU+qhCR6NwO5q5ZbBrx+lIJb0evT2Kau1OnjKF4XzhP3GBwinCBzrzQgLPKQiDan4QuXTSfLHEMjZRhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441554; c=relaxed/simple;
	bh=mOGDX97J7oPydwa9mkxx5aqzgviCKBjwnGibx9EpZBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoVo+3G3A3VzhrsQ5OGFD7JxhBy3mVQZ+HEDQ05z2FrJL5s1Sjfn1W/KoL9xTi2AcXNB9SZ6KZ7SpkNo/gUNWlSTGCHGhK3+8GRCV0mg14KsOD3K/VChl/v2tOin6qqwKmequubxMKO9Tb31rUq9agU2MKLV+MgpB6w+oxQhtZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQ3Wn6Xb; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ3Wn6Xb"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6faff792f9bso19493106d6.1;
        Fri, 20 Jun 2025 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441552; x=1751046352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7wrybr/Y1YisaCMiTrrVEfWzHGSHRhP8j7GfbuEVjM=;
        b=SQ3Wn6XbDORvNd0kDEADubmuc//Ij4KiUTpnj95au1tePycK0I2GmY8Gt6WfC9xOOn
         tf9T0fznBXlKeW20MiHC6ooFmiBFtzapbVGAvU1XtL46f6s2v3LncWIBLsSNjcPkXt4k
         j8Sk5GZjb/USh5awM3DOFY7r3uORFW+GtFKnXU4ysD/ZWliSW+ZEL0aHbZqLK17cWhTP
         mNjHRyWz7pvH2ACMTtTRj2f9qLZ3O3S/+e30M6xAYx4GlGtKcEV8/0Vvi3tvhjVBCfcA
         8r11Lky7wHmQ9AdDgtc4S67KSR0OmP8t8ebkNm90NZNQOhUXkrNbA5FhfMdbXYZT8V29
         HXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441552; x=1751046352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7wrybr/Y1YisaCMiTrrVEfWzHGSHRhP8j7GfbuEVjM=;
        b=DiT7VyKtF+WhFJXROcYR1QUIr7dqFpbwOnIAaHiw+f+RBml0Qc92AmISqsFCstP77Y
         izhEoG1bniOSmp1mbSpyKdjWOll8abjDwlJ16RsSFYWYiDDu+cKM49l9sp80jxjy0VG1
         i5NFIJ547Tav9Z9ZtJKxDbtatLrldUsmqHpISEdUc1tlbuqvbr+I4Uzo6xjXChtbvJaC
         5/ZbEDSQMFWnHHW4m6VT7li+XgA0UYpjdZ266Wye8kXN+3b/NQejxpc1NxO+Lp24VWOG
         GMVdFlOVqHdjnGddKigz1E/Yw2t/8Mh9s0O5P855+/4f7f4UCDsyDObix/eW/Or9Omet
         7/gg==
X-Forwarded-Encrypted: i=1; AJvYcCUHpn96xQGeuPV2Rv87bhmyTTfqMdmz/XU2KWH4lMBhhmEQ6WdOyokdBlYGf7fwwYhEtevNsDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDjHrt1EaO+gOzKk+8nBjn9+JRx3jicjAhiDe+EPuYMp3hj/7/
	rdiesfkPopLFNDHN47HuqhbUfzcZRmb+sY81WIk/Yrm2gNG2ZORFgTDUEtGK5w==
X-Gm-Gg: ASbGncuGDnmtSNunqKl27bZKZKWTjtXv91P7O8cPzs6KayJXMJ+uXRrD5MW5fGR1O96
	HW5i8D+BoSZ8XWizEBwr7eRamIHkfB3yvSR6Ekfm1+N5uAE9rDMrA3xnmHfgweYhvM8lDDYouWF
	lHnfZBU6zAMw0UmG7HzOSxNxvnqjWshlsOWFoE19ZCdLmSuuXwqGGyuwtHR1k2sbdHpq+6xC8zY
	zFb332PsalSrPhzKp/fHEbXVjS22W3dO3vSQ6a3X6ZydkWh00tVeiRWMyLJSReaAL+PWG4PUCQn
	Nw5JZOqt/kR9QQSyinohOH/s+Hiw3GUw4l8SpGLqw35i4sM0j6AqYGjY0QKB3OgCjdV+vifLpAD
	0Wyb5xC+6TqtJSCmyJWtIp3hhoIWDl+Z65nXBEBmzZhCK1V8DNwIQvIJD0yTozLCMKQ==
X-Google-Smtp-Source: AGHT+IEi8eD3gYKqqgW+Ca0ra3IpoNdamaNWvf2HzKjnq+4Q1kFqlJbcxlzx8qXtBVykn/UYOlon+g==
X-Received: by 2002:a05:6214:540c:b0:6fb:4e46:7f3a with SMTP id 6a1803df08f44-6fd0a4d68f5mr73293946d6.16.1750441552081;
        Fri, 20 Jun 2025 10:45:52 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:51 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 42/42] selinux: disallow writes to /sys/fs/selinux/user in non-init namespaces
Date: Fri, 20 Jun 2025 13:44:54 -0400
Message-ID: <20250620174502.1838-43-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disallow writes to /sys/fs/selinux/user in non-init SELinux namespaces.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c7825db4e06f..7450ab7c92d0 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1371,10 +1371,20 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	int rc;
 	u32 i, len, nsids;
 
-	pr_warn_ratelimited("SELinux: %s (%d) wrote to /sys/fs/selinux/user!"
-		" This will not be supported in the future; please update your"
-		" userspace.\n", current->comm, current->pid);
-	ssleep(5);
+	if (state == init_selinux_state) {
+		pr_warn_ratelimited("SELinux: %s (%d) wrote to"
+				" /sys/fs/selinux/user! This will not be"
+				" supported in the future; please update your"
+				" userspace.\n", current->comm, current->pid);
+		ssleep(5);
+	} else {
+		pr_warn_ratelimited("SELinux: %s (%d) tried to write to"
+				" /sys/fs/selinux/user! This is not supported"
+				" in non-init SELinux namespaces; please"
+				" update your userspace.\n", current->comm,
+				current->pid);
+		return -EPERM;
+	}
 
 	/*
 	 * Only check against the current namespace because
-- 
2.49.0

