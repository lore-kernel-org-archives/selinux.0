Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D537187F
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409730; cv=none; b=rv9HbsZymoiwlLItNcIB4yPwyczf1xAuRLy5kLhUpDVQRkdpjvN4nDOgfsZNm+1gMjRNoAy3/Y30/RI9CWDfoxfIPTzkDlidgC+hllTUYJ1yiYLD3JbOQ+wwQSbjI8vQ09xS+ow79y08Vz94NsGCGLqrZmD3Vo2WFpJ02tyK9qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409730; c=relaxed/simple;
	bh=d6xfkFETMaFHzeJXVQq0H0hOpemBeQhwOvwLUoXBzxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fioaS+upaEqHWpnm/+r82ExbUzO0ZcaTthEa67AetgL9tNM8n6FkWy92pbXCSCzYDHxwKpulV7S308ULdDEKsBi9JZfM+7F249U7zqxsH468AGvXbOJE/YBoYjUNpOEs2ZQFUT6nJ196bAIB3MK+Jw/A6d0PnAaKGuk9LTYTdxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDng3GVl; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDng3GVl"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c62dde2so744909241.2
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 11:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789409728; x=1790014528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ewZGhzPSrILSPPgSY2jbQfxgfxXWgImUmpj9EU8jeqA=;
        b=lDng3GVlWjjPj7liZWvYN9IUq495rK1dvUn9ygpGX+cNzkecwj7h6gOtHlZONbx7CM
         uyODYQKTZTcyLKG26pTvjiA4of8+IMwf2ZJBFVqkJYixt2y0azgJOubu5ynd0kiYshkt
         CXikWKlevUh/HB3WkBnUqXfaaAejeWFVJw7dz1XffD8Zp1BDdkY1peG0UIHdW75f+lSq
         xvFRhIGUFVk9+9aMDP7ubU87Zm8xgEczi0GzWkH8l8ZjVh3MGcPr7E9Nv4W5Bd/JFpVR
         dvK4Gywny0tDRp+8DAdxJPx3VXzRm3h7vJvQddpWldK6xrG1xQ8ZYwwmbJNXafe2/+sY
         p/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789409728; x=1790014528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ewZGhzPSrILSPPgSY2jbQfxgfxXWgImUmpj9EU8jeqA=;
        b=mRjpPodtas/lgL0pXyHwNDh2nXOV7GAfJXBeRv1bSYKMur1SrfTJxJqYF0ycJuAjEC
         CVjMXYZalp2FVkJNRkvsgFspIbj3TR4GTdszm6jrBZRO/AmKdpV1Av/DUvucpFK0LcPE
         WMOQsIDqs0bjaPy5g1OnxCCyB4Q5LYIGsQMBqbKpa4GQmQImvfQUYrJb3y0YpjerER/9
         iGT7Yxb5X6evi3+qUcWkVr146kpJ8hOIzavp4uECUS8oXKcSEzK2qnBKwaLB1+oQQckX
         VsokF4knv+SEU/kkZtQsg0BxnrFiZoKsYekXEBM4NjBZjoZuRjteGHxMXCAGmCAT4qAX
         iO8Q==
X-Gm-Message-State: AFuF++lYDrbNdQ9Iq1kaIkNDSUApWm/NtZ9rz/ky1hwQaQFYDA5itPst
	c4O2NIFvs4AiLy0PIwOII80JkawmiqKC4i+/ZWCsHVC5XtC84fHo5yCmFrqPQA==
X-Gm-Gg: AYBFou15aW3QzYLBxGgTFt7S0bPn2C7aFoQPSanWVaPDOwr1okjBp3LOlo+eumaIfY+
	bUZ9wSl7sItYZclunIw3LUJahC71RhV84fR1glxwOeSC/FR+CwWI1u4KXCM99yq+BGninahePxh
	Fd7VS6q9HIsSH2/iTAuxvKYg1hJeubGs7Hc2KVsTMO77zuBd/VVMZW4xnMda8FUcY2lXvKVmRte
	ntczaSIpNvPdGMMkENQesh9H6+7Jl1AdzUzHdFlCDQ4mzFgjaPlOD43epN1iupLSao8FzcgRuLY
	xN1q85WEDeDhB2XbY/5JeDWtKqjDbXvVVVW8Raf7XdBxV7NXKcej7kyVWO4YULR5iqal1C/ryup
	jgr/GwAQsZgm+CHknLgn3Zpi2f6mYWby3gslAw4XHfybwG2cFTNFepWRVLfaREXScW7txjfttfy
	/0RMJOjDpFtnd2vp08YEODmBy/oeBd1SZmdJ8FUt2IgXPEdYXUoErmtdpyGxF0wjS5dB1xP6sLb
	9tYPzHql/c3IdPgrXXoCeyoks1kw1mWhGP1riDEiCxVLXJp6tuCBQeRkZfEk6Ze6j15KJ+tQKg=
X-Received: by 2002:a05:6102:a209:20b0:79d:192d:30db with SMTP id ada2fe7eead31-79d192d3445mr1360540137.6.1789409727675;
        Mon, 14 Sep 2026 11:15:27 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d3a50sm101105696d6.40.2026.09.14.11.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 11:15:27 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] libselinux/Makefile: use $(MAKE) instead of a bare make for fuzz clean
Date: Mon, 14 Sep 2026 14:15:10 -0400
Message-ID: <20260914181511.31960-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All other make invocations are done using $(MAKE); we should do
likewise here.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index aa8d053e..00b52aa7 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -63,7 +63,7 @@ clean distclean:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
 	done
-	make -C fuzz clean
+	$(MAKE) -C fuzz clean
 
 .PHONY: fuzz
 fuzz: all
-- 
2.55.0

