Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14837302742;
	Thu, 14 Aug 2025 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178039; cv=none; b=D2R0GXUWTcn5l3vbVssoE9ZLdMY+4iHizGKfgkJdzKSvN6lS9+KH2qgUUzY3KBfxizXwDPWS4ZG9C0KOxWPMxCu9H+6LnL6g/FTP3wqEBH+52bMkfiXQ7Qu60XyUW3UuBO7Wd6+6ZlskuN30ux7zgGQhV1I+h3DFiz1Vf7eqIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178039; c=relaxed/simple;
	bh=voA4mwh4CL+EV52br0Ys1FkPRF5f765PB20ZdNip5Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7ubRseG0VnmG9fAO9ndsspXIkUfd4am77EtA5dywz8hK8HdH5vJXjhIuoK/f9gi2TaZZ9uityYdMRmno0gPHNYTgyXc3QlMRtg9VolmaTi5Ckgxpd7SN6qZ//AVunjAMqve5NcSlIE1FkcKrjENVA8COgLsHy9d27dHYF6k2lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUZuw658; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUZuw658"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b109acc6c7so8468501cf.1;
        Thu, 14 Aug 2025 06:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178036; x=1755782836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9z2kv474/FP0NjnfiFGuyLAX5zkSZ0J4iXcDx4EFIU=;
        b=XUZuw658+UzQBbUr4FqC+/58pZW2UFt3Sz9jL+H9LKzHdDZl6cg1PfKh6Ghg520Ppr
         Au3CZOTU9eWzZ720I3zsQHFGD8Xy1cNjEkSHMXzj3GfTWatLPRoZgUk8WiyTWez65LFQ
         WmByixTzVB7bpL+h0/WC7d47EhsQ5AfvFmVPglP9+oYxXZer2CA0jfVUiRkUgIDPuOMO
         GbsQMNwIBc/taUSrPnoMvif8PKzeZvysiBm2RJxD9c5adVSkXsMxc2GTHG0senUiaSFJ
         s9pQsf+tA5pQD9l9fl+/pkxmmZl0iS+bAZJ25+wqzhFcc050Nhl4FeZi/oyNCHFO9I+R
         XXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178036; x=1755782836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9z2kv474/FP0NjnfiFGuyLAX5zkSZ0J4iXcDx4EFIU=;
        b=LomB/+s+leA9iJYk1fXw7zK67dpxWkOqlHSHPbxVyVi0fVe3cirP9UFKYZBBwv5K6q
         FoRIZ7vRfkLB97+Ot34squWXa5tfJZ8M0IDIO3Kb/HNuoP58t9hYwQsiyeb5oGdinziw
         Q9c2BJ6dyfJmErLziEe4SSVCVvh81939nHbSNgL8IFCksdrSxuzrX4M1RG/eF/trdd2t
         r5Lga8N1010efnGzuIkAyUBvHEqIQEwjBg0VAB1ThhMhCK+MybRstBcckLwuR6wdbcXT
         HfvKbIrNeSQIrS7eRDlTYgvhAhKzNYivKCShSBHwt34V/UX2t/gfag/DPspmefDcAziN
         +YwA==
X-Forwarded-Encrypted: i=1; AJvYcCV3F3OjJhHcgXwyYqE6MPx3JKgFFB6c9viAAOeFKx3rh0Ve5gtHuNCPCDVf6iS69rO7EzjbvP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFZVNJxxVveMfidUOgegvJqzz6PafTnfygtFI54t2wGjmWQWj
	bOy352oiIHuCTByegNcpPRggUD4YtWohJCwSoCX57iJaLC/ByY/wf16G1vuP1Q==
X-Gm-Gg: ASbGncsF1IhBFG+VQHQ+zRWARPvjwBveDhhylycltNUBJReMNk7cfmM9Y3TsBi8+rg7
	hsvRrajtbNDon/K5voJ0FYp1Ycl1QFev37IHPcgl5sJBcEM4AL/WqwJCHIKuhfWT6CKuc/cVwY+
	V4EaG6rpEjUiS5OAPYKYqq3F4041MK5ot4K8H7y0dY/gNr+fP79+b/dFkLjtvkAIn4994dlaB+c
	ACfop8EO2RTjRa2+hBJRkqHv/+c8/UHBK+pcTkmCe41PZONMzH/Tszn9FW/hVWgCaX+VuRBhBOQ
	gYePqI7T/PtsxpsFhLI37F/pJ9kMlK/RQX2gnoZ3eyINo8kRn5r3KO7E4At1Guxj+lRDvJdDHUL
	3k6pgH1M99qmBvpWUMfNeSDr6EXjTsk8CjLtqb5yAySUzT6sjP6vIODAF3krUdqlP9oTJw95nmH
	tEGRc21N8k8pZvaiwmyewBTxi5AQ==
X-Google-Smtp-Source: AGHT+IHcVq/4k3/fZ64aSL/hxFKFpf6Gl238PSUAr8+jhekdt+ZFRSceVxL5A+cn04sgZwIkfId75g==
X-Received: by 2002:a05:622a:5913:b0:4b0:86b4:251a with SMTP id d75a77b69052e-4b10a98f271mr44264471cf.25.1755178035624;
        Thu, 14 Aug 2025 06:27:15 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:14 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 12/42] selinux: exempt creation of init SELinux namespace from limits
Date: Thu, 14 Aug 2025 09:26:03 -0400
Message-ID: <20250814132637.1659-13-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
index 739f58b134ed..bb053445a086 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7813,7 +7813,7 @@ int selinux_state_create(struct selinux_state *parent,
 	struct selinux_state *newstate;
 	int rc;
 
-	if (atomic_read(&selinux_nsnum) >= selinux_maxns)
+	if (parent && atomic_read(&selinux_nsnum) >= selinux_maxns)
 		return -ENOSPC;
 
 	if (parent && parent->depth >= selinux_maxnsdepth)
-- 
2.50.1

