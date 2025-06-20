Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BC2F2730;
	Fri, 20 Jun 2025 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441554; cv=none; b=fSJ3WZI6espexAVWISc4vs+bJICoYc7WUN8wa+DtlqeXbUKWZB7KoDzu83up7FyJzlGXM7RbbUI1RLPQ488suoQmGfBn8Al6gPkQ86ovFgq1GzmPbxaDBy/anNyIMxlXbeL7wqsc8U+e4asKIm9UoDmAR0iIolvLNPVUogc0gWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441554; c=relaxed/simple;
	bh=jiJSfpgUJI1e/mGWYaTLGqmYjs2cQVg8NWAQvubziiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xat2tKAVWUOPyH913dEVFl9xeMFZBww6qG+pj4slz5BcR9QC3zrQalrn5S2iCq4vgsYvTg9cGO85ye47Yxq+JHcvsP4n2Z6Xho4SXYtcWB70liW6rMMF7T1BaPjdY5/dAH9JtYd2YSnF06YFnNasAeNHdhRYc8d5P9vSuShhtuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYCXl62q; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYCXl62q"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6faf66905adso12559956d6.2;
        Fri, 20 Jun 2025 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441551; x=1751046351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6QZJcqfAHB8JhKA3fKKxCirbfw5esrqOS1yQ824zEo=;
        b=HYCXl62qeiClYjBFC+PiUeFRHGI3rNz97i4DghuWj02KVbPPhtWM4WawlKUjV1DkRi
         ZqwjtCDFi6omdGCdnkVCdCM/WtSEiXe/nXqIq05k3ARosdlOpkbV4epOTc07uP9c6urg
         2Z/ndQ868xZiXEwJ6phJygCZbL93w+KEtf4iRtVgMhYxsfQ9NgRjlyM1BEP8mvcD3Lra
         4W7cR6NF0rfIehGeLBeuD3m2Mo5KgkBO/NoTogP9fSlkFSw+5OAZgSGvyPZTaoFqhRKo
         bsvp09faYJBmTxTxIXBVMrdSblGfjJGeA4PxWDziuWlODDvFv7/C30CKfA3I5Dxf3/J0
         0ziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441551; x=1751046351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6QZJcqfAHB8JhKA3fKKxCirbfw5esrqOS1yQ824zEo=;
        b=g7OoO8v4iT5fuY1hrYqWnxQ1U8Tu5rRiSJtUyM6jyapBRoqKrqe0C37dFISw24mjkG
         rnpNbudmUpd90uPFF+Kg/tCUxvI44PiiOqeGnAd4h7w9SxYd9zHMhnhz7AKvROFEoIxI
         ontGzniuqXK0MwK9zHklzcrPNl6x/wBcaXlYXU7m4Vi2W0jDmOVwKhQ7sb241E6kQkpW
         uhLNcuXw4iiP7LftjYcVmxsrBBoXS9YhPbieJrjmh0AuITEv28RaFDXQjNdFuCkCINzd
         EbGkyxf/97gemQmrl3unhTrF7k0cwjAgE2dUQ9nby732N1s0BkFowuaD07jcdQGRPGqG
         9chw==
X-Forwarded-Encrypted: i=1; AJvYcCX2C2oVAtvNR18nccjIiTxSj7Kuwz2LQw1x+9R+VXZW4sM1OPXC8szydy0njvL7vdHvrC4Ey8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFU3EXueZP8WXREA3gN81hIwyuBVLuI4mcjm5w0BqYn+dpa/x7
	RlFWTkErt3VhpbNKMO3H0RY7dAJC8RR0IX0t6yMPtcUcck43y0A57Gb40cKOLg==
X-Gm-Gg: ASbGncsLrS3zvA1/tUnpxMkkZynk6gN+/m4F9TEF1S/yJzElKVjbkbZxmjONMJULqjR
	eSUC+QPgFEeZ+M93PQxiVF3hqMjhIFAeS4x0bGcji9xB/2/k+IUH2ArYFDz1lnepeQUHrVfDeZg
	xBhFPKC+dWZkxVkuh+3KmPYlUHUuTDBvhGLDlpUOR54dZOEHsQVZBGaYuV+XsO2YIto4u1HMOXZ
	Bw5w3eGf8oka1xZHEz6Yh+FwTgzv8tLCUVHKz732qNSNdp8wsOHV0SdjiFxRgDsIKP/o8MExGTu
	QY8fb30VMKCZvVIAWuAU6+lYebD0+ENTC+yk14lIvo2FNvYmFtmSJHzj1+RtNEwFaQgBqPZcoTq
	YyGFf5D581q/vrFcxPL4JR80KOOFP3cwpM1ip/+QIufrXHzEyALobyakdS+Qcz+cI1A==
X-Google-Smtp-Source: AGHT+IGFiBsKyA41oYWFsJY5bLt5X6rbsUOJKD8DAh1kp6vHxdl2ZrceGEFuJGxu00wkQKn75cfE7g==
X-Received: by 2002:ad4:5f4a:0:b0:6fb:4954:846a with SMTP id 6a1803df08f44-6fd0a46964dmr54890216d6.3.1750441551250;
        Fri, 20 Jun 2025 10:45:51 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 41/42] selinux: convert nlmsg_sock_has_extended_perms() to namespace-aware
Date: Fri, 20 Jun 2025 13:44:53 -0400
Message-ID: <20250620174502.1838-42-stephen.smalley.work@gmail.com>
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

Convert nlmsg_sock_has_extended_perms() to use the
cred_has_extended_perms() helper for namespace-aware checking.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 92d756cfd0bd..ca7e4b859604 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6285,9 +6285,9 @@ static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_t
 	driver = nlmsg_type >> 8;
 	xperm = nlmsg_type & 0xff;
 
-	return avc_has_extended_perms(current_selinux_state, current_sid(),
-				      sksec->sid, sksec->sclass, perms,
-				      driver, AVC_EXT_NLMSG, xperm, &ad);
+	return cred_has_extended_perms(current_cred(), sksec->sid,
+				       sksec->sclass, perms, driver,
+				       AVC_EXT_NLMSG, xperm, &ad);
 }
 
 static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
-- 
2.49.0

