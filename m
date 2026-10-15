Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7AD367B99
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 05:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043151; cv=none; b=WYenBqu01N08IG+aqmP2iDIBZkk/eyeWfB79tyYbGluAuDqRSouGLOTScy/dAtHRJ7p0IzS524Gp0fDBroFwun6O8OHmLTwxhf6XTkswo3f8Fl5aNe6CD5s7haRx9UT++MoDSMkuzPvsEV0XgI2E60zntxC1GG0XVFkCBt2Sk9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043151; c=relaxed/simple;
	bh=FRMwYXfvRdtdWdT0Nj/ojmWN1lbpiM6lqLWXxk0SDMo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ui/zVsVTPpuF5I1PZtU4yE43Ook2vIQibWVkfMKgnXMA4h5IVf0X53P3JNo/UJolDQqqItV/zRvdOoYLBzIyXh1nEiw+DWMfSXlcC0EzVTm7dh+5HDgJoj5qeNrjpg0ThU0IE018uFMY+p1mTd5Us3MXNxFZ3YuqCainn6TSBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipjRM43i; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipjRM43i"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so39165715e9.0
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 22:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043148; x=1792647948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C4CbtEh8DiFE2nC4rJhgTO2zB/j+2itw3xGy52mbhfs=;
        b=ipjRM43iBXwLkXqfFiCCrhssWMLgb9KEnIdBT92aUBTX9Fn1poswpH4kacAgY7aEI9
         bRP1muFNrLv87wkCuE02mRPEMXKMZLwIYiSk1JubpT83KufjFQxYzlnplsTFDeS7gyR8
         Pmo1m7O7d9OvvPunlBx5krF65P8UH87mXi2QoZI7Xc2Rq68LRZpfZp12OqWLz6CRs4BH
         3aN1QsARZ+o59GzKNeoqbzRlQVbEYtxgZnfhJUoDUzrfhmLuz4TLA4Pne9qq3zZZBiKH
         JTc0pWV7eYJm4rowEcNe9cu2UKYENfzPw1YlDrVIveL8fNLC6qiAaiz/e/11Fto5AjX+
         6T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043148; x=1792647948;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4CbtEh8DiFE2nC4rJhgTO2zB/j+2itw3xGy52mbhfs=;
        b=T3usQvERpjgJHi3TTCwKKerGEKPSgcvMUNaXQNi7qV/aqQtTCIS/orDAyT7K7lgu6Q
         IMtiJpBEzK7tGqPhXsERs8JUhf7Oq16rt5FXuDrOpp7l9ektfNMwzUFawWHr4lR4mWJP
         LJmLQDyyZt583I7S6z5UvL9/dhMTtBJmYWkr7zfS+wvDdQfqOMBcFHICa+bCjgwN5k80
         GZenCqXF9/3f8WACM1OpfeQ8zNxIVSH0LRdyraiJ/gHHgW0GrXD+3/FDgrwyIoivE/nW
         ffJuFdzgn4I7NBQPcxjZui+b2PkipPmDh+nJYoj+1/cwIVwYiRoXyqmzU/cwQ51zXUYo
         XFCA==
X-Gm-Message-State: AFq9FYKZhmBLrpia9vX7aTuQPwXgJCJWIe3B2vZ2w4aIYkzBRXsfVGFQ
	2Tu9X8H3uHjFPScTPu1NMgnQvplKeCgmUq9dE/cYnY2X4XJ/WEg90wmlXgfuyQ==
X-Gm-Gg: AYBFou33YwKBclRC2mqj3BYWBpKM/05hdRTKbjUPJzrv4YOgWJAr5zEl8C/FFewY7mB
	LwmV13eJkI83w2p2LApkukrVWrIGijwO6FNBPTXLOU3fsnh+UBAq4SUZToN2gK9QBk8oNn4aPQI
	6VBVvOXEVuAQ6VsvrwxLWuDdVDpL/1dYtVGUHDpufS5bN9NkzaNClZ/xSZsaGELMln6t9gFOkgh
	62BSm0WNVgtffdYIentJx3ySl0RHCTeF2KrACTNCmLGhFHuSEEfEM1QygmrJxJEotYH/Nn3xjzc
	rZg65FMiNiNerDihshMkzJXoMs5gYoZc7VGnQc2Husqe2Skq8vONkOP5qvznG0/igTfshRFzqF0
	2msYEvsEAGs5Fp68VxfXqV+UxPRZGYtWshm4kBwm4f8+LDWUyKeLYHs09PJzhs7IH+1Y3tMeH6j
	1gHhwGKSYtPhsSieSXkj/xbQLoXbtrJ7yq/WHKszAs44lPTTxd3L0WvchN6vtUBt4waF4C7uQYE
	NaFr8Z/dht1Vl0=
X-Received: by 2002:a05:600c:6749:b0:4a0:1a7f:2abf with SMTP id 5b1f17b1804b1-4a18e49d633mr349856665e9.7.1792043148576;
        Wed, 14 Oct 2026 22:45:48 -0700 (PDT)
Received: from omos-acer ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdbb4a30sm41982805e9.15.2026.10.14.22.45.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:45:47 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 1/5] tmt: raise duration of the prepare-system test to 10 minutes
Date: Thu, 15 Oct 2026 07:45:31 +0200
Message-ID: <20261015054535.844874-2-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015054535.844874-1-omosnacek@gmail.com>
References: <20261015054535.844874-1-omosnacek@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is some issue with cloud-init on Rawhide Amazon VMs that causes
every boot to hang for 5 minutes. Work around it by raising the duration
limit for the test that reboots the machine.

Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---
 tmt/tests.fmf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tmt/tests.fmf b/tmt/tests.fmf
index 08bd129..814b65d 100644
--- a/tmt/tests.fmf
+++ b/tmt/tests.fmf
@@ -3,6 +3,7 @@
 /prepare-system:
   summary: Prepare the system for testing
   order: 1
+  duration: 10m
   require: policycoreutils-python-utils
   test: |
     set -ex
-- 
2.54.0

