Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192C2E7F0F;
	Tue, 17 Jun 2025 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169183; cv=none; b=X1RkhsonE4YJ2WQkeJCohCVUQgRzpSZEgHQndEULaoH1fM37pF4FwRcM64qGGTvW5TOBNWIIu8L7zlDqjiYB1c+sktboDU/VujbwnzdTBC69TUmGEqGI+2aObmke/ljkHZcVD0dW3va3FyJnEBu/b3Kqn1zFCGlarOvw33jDlLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169183; c=relaxed/simple;
	bh=gvP+0LQYAnmw8gg6j9Ox/09OF2tGRj3QmaKAbrnV+tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X05I76+xt8LlU8+ZmcnGM36sRGLsXLGtQSmwM0GlNDbMm6gMO4Rbqg27YiKzow3OItgDXufWsb1G08l1BCPMcb0R/rgA6PVBKg53ja74HUdiTpXxpQAHxpWcIQ4+MqGtNNOZJ/P9+2XCw4Akbat/GvHnugqXZn5EJNaE5yktqq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKWvI/8K; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKWvI/8K"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d38d562a55so752298585a.2;
        Tue, 17 Jun 2025 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169180; x=1750773980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGOTjLDWjs2XRrdpo6fCTCyu5B49/AiUwsb1J28HyxM=;
        b=SKWvI/8K+0RpfCCeEip6YNT0rlzaRtC9PLx4lhaK4vVlk8+tRl4fg1mSy+C6raN8SM
         4lwIrNxarF9/n5G1JnfdJsvpRwSjJ+KsLk3W82zXgLz+m6pbZlelYtb12IbtLROQ7ybv
         RnqPQrxUTNClZ9+GVlUl6Dxg5G+NW8od5q+q+2T0mfJkuVgldyB5sEiWp8Rm0wXRN6FX
         WVppjGJQKOeY3hSs3VovkRO9w34+if+s15TNqZPxIhxU23PLjh3vur55ZJMZDlOj3ZEL
         UBemyHvyZ27nKnxoKzfwy0E0Lt5eUUcXZlDeSdbnKz/TiB7djPzoqVHG0OH1hlFPKKTY
         7JPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169180; x=1750773980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGOTjLDWjs2XRrdpo6fCTCyu5B49/AiUwsb1J28HyxM=;
        b=Ud/xC6pjgHuqrs8AoGBNHCGAo97tYYZg+MVWkYVQJ72PmVV1ApXk9SwvcOGx2ZAhMA
         C4o0kcDbYmgl85pAkSrnkZH5AOhrY9lVS4D2551oCBApAQexMzeW+Tz441o28MV9K11F
         B/AQpGcOmwFRmEFCuxTExs8MQH/Bw/n9UhUbqpJusWoE2Qt7WYHhylkuxhMKH9uCJ9ur
         cr0uJUpXfST3fhYiMsx1q/R9C2DJtP4+xaCcV9Y5HSPuWD5N7e+2x4gfybY1/s1X/Jx+
         EebnCLU4bnjLTogR9keY1LFMs4MjqWdM/l7DFJ0T8THEwWyp9lCh8B0qjYnS1loqS8xn
         p6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLxlDWE3bKLk3lJmhO20uEgpde20onRMRmnoysQ7u6yBdgwVFrWAkbFfib6u9feXCcFv7SxPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNHyWJFF/6ZOI+I4A+dbLoUPnCUJ++uVwPHU3ndp27VBldVohI
	cgwVEPXxlmjK+XM45RvYEEVgfwsSoEkNIvfqlsdaRI6DeyApL7RSROYF4navDA==
X-Gm-Gg: ASbGncv3zyC6vqRVltxMhfNtyXWlFyb0Q0Q3pxXWpMPsp6v0UXS18ovOIFxvSSST/oE
	6NuJ7jR2miE6EQk/R2bSgGO2+MlexOz9w0VeL37b7r6OXJEdZdoZmJUazoqi1ow9CwlJTi8qbIh
	O9iGGN+w+T50cLwwOV0XnwM0nD1kl5sRNK1/fquiI271C5EDyp70DNj7Q9J9mgfsXXqL9/BDi/z
	1T/0pN/MP+tRqeMdj+f/AHTTmcFvqQjXS95/XgRdBrBaYCISzcVnblQ8uy2YWWDyx6dMf24+xZD
	mB7/2yUuHFYliU8zn+r2RRag3pxIzZd4mcr+So9skhiDWI3aShVetT23Tb7fxhGG8Su2mtuFLgp
	Dbw0L0KwbzfgsIEWQC4dfijYweV2VO061MEhLYWeA9UCAFoSEG3FUO7f9XJiEjB3wyg==
X-Google-Smtp-Source: AGHT+IFLItUf408QIRndPKmMZ0WDuj9UGb0g0Q75NLVUo7+3/wqLlcE9ELEplEFey7Fng+xQg72ALw==
X-Received: by 2002:a05:620a:1a85:b0:7d2:284f:e471 with SMTP id af79cd13be357-7d3c6cd797emr1833625485a.33.1750169179950;
        Tue, 17 Jun 2025 07:06:19 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:18 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 12/42] selinux: exempt creation of init SELinux namespace from limits
Date: Tue, 17 Jun 2025 10:04:59 -0400
Message-ID: <20250617140531.2036-13-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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
index d65107cc5cb2..746ef41b959c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7787,7 +7787,7 @@ int selinux_state_create(struct selinux_state *parent,
 	struct selinux_state *newstate;
 	int rc;
 
-	if (atomic_read(&selinux_nsnum) >= selinux_maxns)
+	if (parent && atomic_read(&selinux_nsnum) >= selinux_maxns)
 		return -ENOSPC;
 
 	if (parent && parent->depth >= selinux_maxnsdepth)
-- 
2.49.0

