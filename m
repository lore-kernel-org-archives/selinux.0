Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D17247299;
	Tue, 10 Jun 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576193; cv=none; b=bgP3x24SvpqIvagC2B+vul5bY9SkIywRlLEVXmVhpMPuMXlVDn8rlNf3JnrNpRy7czVi/K/VPctnPx+KLL3N+s0ljX0TP6GygmXXCdsVseChw9TeuLUwyB+50sciWFjnjYZg088+uo63V55Tm0pw/zYhawcFNtXAZKhWAHj0XcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576193; c=relaxed/simple;
	bh=CnKXNeKCQ8h4znfW6TpxngYRN1Q7iYbqkOJWjYiXTTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJbEI/dvcsc8rzgSdotVyeynNWsDnrweJVFEpi2Q1+hbMIQREPvjssbpBDXvuISysdVZDwZdjBYZdqpEBJpGHoPHaXmA5PjdYeS8jb9vTYA/0Hi2FLIHn/qp8h0quyhQMq4gHoez4U8xZ4HD5p+7KEyi16ik4VNUyq7qN95W9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4z2h4+/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4z2h4+/"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d09a032914so466113285a.3;
        Tue, 10 Jun 2025 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576191; x=1750180991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP5lh9j/l5vSYlWD5usgkMOWJgrl8SSIcs6xTtn1NBE=;
        b=E4z2h4+/f6uxbKxw8mqVSGylPBxt+tSysN/V98yMFTpKL6L3mmR+nsxmRW3R4CyexT
         gbtmJRGn82Iapc+s79SA6d8Zro1gz8WABF45TQB9rIWxt1hRLTRcDyjZSqw/0SxBbrQs
         kQ93eTMVYMqwiDsmTAVAz7JbrAJkiPlmb3nHJvFytjEH8Ga83D2XBqvYM+Q7OsAlp77W
         9it0h2nIT+Dp6Fi/gHmx0mQLeiJoEiVCSTXIj8iuyAN+k86NEU+WOsrtt1H+bUMkOrVJ
         raPVBs3i9/FANb+a2/GWPBlXC/JUGzMloKTDCc81WgeEmRzZ3j8V1Sua/Xl9e5RsbugG
         6Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576191; x=1750180991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FP5lh9j/l5vSYlWD5usgkMOWJgrl8SSIcs6xTtn1NBE=;
        b=EVkPomgeFvMEaaV5MZ0Uig/F92zNJVlbX7BP/Jj+lB31whRGY1G3oZMwp/qQoEF2Hk
         rdSPTZyNM/ufyixyQVwponnJnmsi5CDe6mLiKh6kOWgIny6v6+HTdrhbUhLRRfFh7bm/
         lGn2G0kv1cfzPKAU+sEzSvc2uSCZQwKYiWIWNRWbq6oNuCI7/AbL8StxIZ0n+GAgFC2u
         wAjM2lnKZwUiokcO8iNMG/g1nR6EltFr5s+kSe5Re4LsJiUDuvONAh8V531SuJQqSCo9
         stZibzW+Z6+7qow6qz5RHOo5WY3xYUJ1dGNPmxDuurJT9+Xhpxc9pXcfB0kNJRiIEeYj
         6LGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsssMW1rD/LlGSZeVquU3Z3lAPNvoXy2UOZvp4p2+dnz0WLiEcPMrnL1s/YzYmgYnbCsvzpM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz2VUwhEdyftXsQ1AWfpLLpt/PEOuh7wanHSPYbdfbBbkA/o2i
	fPoc5oirwIcXFtZbPuND4BJxx3b4FinIU8NkthnW8V6mrX5CA57oZYTp13gLfQ==
X-Gm-Gg: ASbGncu1+B2H9LR7HGtIkbyFE7pd5iu0ZxfeHis4V2tPbTQuZm/tP/qUPsr05kY8V5Y
	89MTFrhRyXY6UO5pj8w9JCkut2iGv80vUgayZflpY1nhlRDw0Gg0Lmx9jc6zHoZBjIxBqFqEZOf
	e1EJtm9BNsLS88Nad4pVjPet5TcUJ2vL6PHfu28z7npkEQCklz+CFV/BiNvgjzQdehsDm5+nGG3
	D6BZ1//5GJM5wXXieWvIAEspZwHEYhSeEyU8MG0Ifpv9fW+3dSJpsmo/jJ6XwjFJpfpy6O/QyvM
	y/hvpYdc+/uMPE3cM7O7FjRUGoty4JQSGbH9Gj2eJsuUFn6axRHSiSmp00pmWDTePRGB9rNdUb9
	UQZawlA1c/KUR6y8zJin+t1H3IO84A1SNU3KnVf8wcEOSn36SI1OgMYWyEfxi2QcXAw==
X-Google-Smtp-Source: AGHT+IESHcReKvv9osYvQIYB4I/TTYmE1ih8b1tnZQAAhiXNFMUI7HFkfdzEfjj126oCdAurLG+Djg==
X-Received: by 2002:a05:620a:3185:b0:7ce:c47e:7877 with SMTP id af79cd13be357-7d3a8929e6fmr24755985a.39.1749576191021;
        Tue, 10 Jun 2025 10:23:11 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:10 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 12/42] selinux: exempt creation of init SELinux namespace from limits
Date: Tue, 10 Jun 2025 13:21:43 -0400
Message-ID: <20250610172226.1470741-13-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
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
index eaac0ed9fcd2..dcdc8c23590e 100644
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

