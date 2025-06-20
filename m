Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF422ECD28;
	Fri, 20 Jun 2025 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441532; cv=none; b=PBkHu7MIO2eW+HkAl9aZxLlg5/zx+fri4J9ofGFTdqbVEuXnj5+KwKWRIqygmaYWMU9QfZVwg4dqTIm/JlePeQMyeQjHZJ19zMuzcSLjM47mXw6EacKtU9uaabBsNvLS0onXM6iDt4k3zsJosqEGT29QnEpnbmsw3bZMC1BPNqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441532; c=relaxed/simple;
	bh=020/3mNLXQP8nXetCueW0IkAbkVdNUYFRMwqjpdU65c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X24mC7KkGisFjkyQlacnY600v7ACQN2VcxMCRp18UpoyRDXduhObTrEbWc91zsroAxFU41HSEmlO/2EBo99G4jGFqvhZD3Ao1dDTIY2tJ23/Js6KFMcJZrEeb2Mo8cHd8Iwm8Px0ntfMZqJ5xFu1hmMoOD+JW+mKOgyU+0t28CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTSRw66P; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTSRw66P"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fafdd322d3so23175206d6.3;
        Fri, 20 Jun 2025 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441530; x=1751046330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fROmbF8NeNS4NR11m6BmdXXOdQT/FMcCAoHoTR9gH7I=;
        b=TTSRw66Posx4iHXvQuXJi3XR+ory7UDcTReTSyhYsrOexZuqnaCYHuBAW9CPe3ZxVD
         b2aMMuxUQb6HbF7CTuL22F/qj9qs/1laZYpyoNuzpHWCBOytw7kGIlV4JS39ZMmhHIez
         CQZn5vH1qgb2MEUwrDGkV4oLCIzZbXTFqYdgOTeyJ7CWYfQcuHLeQ+GQdXqurUReZYw7
         rwHrhfea2HqC2m1AllKzjdGVKhQ2JM0CYvAWU86+wctPCykkFm0OMsnUfwvZxXsI6fZx
         sUcCvYLRnTD/xVoi7tMDdF9zv2E+gcn/NE5Z/K1XLenLvhlNA7LBxQWqvyBRlxlXxvxZ
         DEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441530; x=1751046330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fROmbF8NeNS4NR11m6BmdXXOdQT/FMcCAoHoTR9gH7I=;
        b=WPUcnxsDcJtviZh9xflTgM1fGKoEchdAMKy+XUT+o1oME8ETXG+5VEE5BVIJT0QRa7
         GXWZanfpDj8pfGj/bAGkZ/3pKMTTMKDM8EB+Rp9mR66lUGZo9kRnxeuuchWlS4Mw5JKt
         ls2Y48mBJCOVakXMG/YwvyTnnAHdE6bxua8SPkP4jf8J8rJEk7TNlS1DGI2x4OUhNJ/D
         +OCrvYpdPBBZD1UVpz5XsRY3c99MwLMnAiCKSptOXE1fsWwlSzFVz+UanR/WkFBEQI5m
         RdmVi9oL8oKcU922WB6ukTQLNnzPOXOGXCsEainF7829oLdBucsf1pTzo5m/gv57do/m
         qvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDgy55OKQ9QmqKxYAaHFNxkMUrGQUIrKIdzxOYWYEsAUepNg5DGSJ+9RDSQmXY8J0WyHhWmCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwulO34ZHVIr7SbJK1BBMp9BNmbcpwmpA3Hn/Z4HJQ/7EzzxE7A
	0vL+gvSehBv3gF8MyPyRlY4dWahuJl/ZVGma6QnS+uAFyQcqBiin6YnbBzUcyA==
X-Gm-Gg: ASbGncvGOsTd15uXWGTjvkhmOvx5w+rFIY72RYOIXfGYhxGOJ+IJjAMPVphiThgrjFM
	47cdKP7kbILynMHRuGB7xm8C0s3t//bKCIhsqLvVSkmUvBOSzULVORvM5RM1t5Ktez94we6qFDQ
	wl3wkMzTY2gdFqhddWGf8B9n8Umfx2h21D8YuLQeIWd7uxA2P9sNa4SppjKT/ATve70KU8Vb16w
	MBQAdvzuwIpBOkSL+EUjibwvvQS3yDoOsj3cl1xE6lGNHJbITUcmNUca3oT8/m1BkyKV2IFKDRt
	WnlZnQDfm4Qo4LxZs59K5E3ILDHZiwpNP/0eVjdnTBuv2PPdjkcG190CHekWv218J8HisjSWHnm
	syI+UjIpAHG/xjjfJMsyDxnCQTVK3CW/SUjSRFozNqIuMGuqO1Gzf2D7pcaEcWWrzRoyZaH4B8d
	D9
X-Google-Smtp-Source: AGHT+IGo41SRpZ6jAUoLPQfjRD6Sz7+hMI12EgOXnmGkOgRy/rLcCaem5wjskVlTnh2WXPRKwDLCzg==
X-Received: by 2002:a05:6214:328e:b0:6fa:fc22:52eb with SMTP id 6a1803df08f44-6fd0a5e3476mr58855126d6.37.1750441529641;
        Fri, 20 Jun 2025 10:45:29 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:29 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 12/42] selinux: exempt creation of init SELinux namespace from limits
Date: Fri, 20 Jun 2025 13:44:24 -0400
Message-ID: <20250620174502.1838-13-stephen.smalley.work@gmail.com>
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

Exempt the creation of the init SELinux namespace from the
maxns limit. It was already exempted from the maxnsdepth
limit by virtue of only applying that check when there
is a parent namespace. Otherwise, if one were to set
CONFIG_SECURITY_SELINUX_MAXNS to 0, the creation of the
init SELinux namespace would fail.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index bf75cabdc86f..2d08c0bd4eba 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7799,7 +7799,7 @@ int selinux_state_create(struct selinux_state *parent,
 	struct selinux_state *newstate;
 	int rc;
 
-	if (atomic_read(&selinux_nsnum) >= selinux_maxns)
+	if (parent && atomic_read(&selinux_nsnum) >= selinux_maxns)
 		return -ENOSPC;
 
 	if (parent && parent->depth >= selinux_maxnsdepth)
-- 
2.49.0

