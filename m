Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989769;
	b=Jiu7S0GM6gFnp9LJmQ+20VMUkiIBfQuUBjODz2J5t4GOMV/+QwZDkrDB4jlZA5d4DYNU
	 2axtfss/q/7rqpUXvh/0hCbpHU2DivR9d3Jf/We6rD3Tt5TW9vNA+P1iqejITyjbY+Gxq
	 YDJVjlko+QFvq9W0j2BfRUkf1UjRW9gOYfipgGzbXTXrbVSzJIxW+U9g7Xe08spR14GDN
	 0VL8Il1jVcvYvjy0p7HwEq9tR67NnThRqiBgKUwSN5cwPQR4ZJDl/oYjgnbbmJg8y3s7O
	 NeZ8DuAW+4ZH3IiyqlWUim3DM6WSaWG4o7R3KG2l/1BxcZhsNdAU2DizIWyw3JWx6ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0Pu+iDIKja7R6NUQBxF+4Rvs7r1cZY2LSjP/7KxiC3I=;
	b=dvIFHup0Dtb0ZSyJ+2M8kHRfvK1aVmHYR+FcBEK+fTT/kf1ObiMVCLWNj/XSlXcyzsYk
	 /Ut8NVuU+3T+USUfnK5sJzcgaro2DDWtUSQHmRTbxrqEDTM4Sgdrh/++SLKtDxH/3pV/d
	 DPQZRbiEZB+4jvKDWdbmiEzs9baX2cXcX1946cmnIABdpNssuZopS4SLGU3DZQ61XcoXf
	 gMYhTX6fwAj2IoW43XXWD4Lpb29QmLWYr4zPnUHMjD0Q1ng+cHJAncL9aunBB8DsMIiGs
	 h5rIaPWq+Oh4jEMy/ksUflHAvGpFPorv+Wgf+KyunI9DLWb84vh+HVuvQXljse7V6lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jisnXlJ/";
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68A606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 18:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE68A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jisnXlJ/
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53381e53b80so10380861cf.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 10:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989768; x=1794594568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Pu+iDIKja7R6NUQBxF+4Rvs7r1cZY2LSjP/7KxiC3I=;
        b=jisnXlJ/8f/7vPaFUo8VLhoQ4FynFCmruUFafsezu4oPRasSnTdi+WhEqiQgensSOh
         s0fcfGoTFUbc8QsjwfPqSyyFQwlw6pV3YvtcWJacf+jmvTzO1dHUnGeLnAltuBmDfP+e
         L3HUXb9knbUkZU0Y5GeXjraNCiAcxKiwLVmhMwj8nUmvlnXYVngk440Z7IzGiC7VB8Ga
         DRyDz8GzYexpWn7/1L9LmSrSQh5yyYX/wXuDFyLq59Mlra67rJ8+9ALkZFhDtN/KG7VL
         D2afiM9F5a5ETC9SqrHQKCSWBuCDeclwKusch8csF1f6RIDJs0Vsj7FLaVZ/54R0FqW8
         3JQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989768; x=1794594568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Pu+iDIKja7R6NUQBxF+4Rvs7r1cZY2LSjP/7KxiC3I=;
        b=rWC0rPxIpwsHlmo1n5qeTSR3UI2hRKByt7IpOdruXkl99QMjdtmjM9ICVyQsZTmaf3
         NubJ6x+IDrLjRPp+siz4khhwf99q6BF0Y1rXQ5tcyy4eh75NyFIpbRUEFCdziPVi8El7
         XFIXcRxjltMxlrIo3gSRgZpbOBkvvmQwN1ml4ck1iugua89UFsXac1rKziNx7/5kK9jn
         bjAh161QhkOjDscPPbmXB1FPwKqalVUHQpI6k6StuD+ZHD8XFzEmCSfdyEjQcmaYuNGo
         i4nKe8jj3NigFKdfU0wowmDrzXzzpVuxxYp1Bb5l3R66jN6jfMxRXZdbAHXBul8fIv91
         xGTA==
X-Gm-Message-State: APuU4Z8seXnUPF7G3o6ccWu9pLisPzdblc4LdOcNA+gFczUxscP3iqNd
	gXbeL5F6LsY7HsoQ6QOx/bDcj3h+HS/BHk68IMAVdN48utMFEApoi1K4lCdKyKmi
X-Gm-Gg: AYBFou2RKTaCI2lDzuHNparQRAhg+Dsi2mz7piaWVBylcKOTfgb4jU6RHZekPl6gwy/
	H/wRgdLxoSLp4CdEPS0LRVBYeiwEeKD3Qi9lyyJGNTmAkBXhjsPiL29qhLA7Gr52hodcvGsSq4D
	OEeKZilp5ZtoZ3NzezIwiPR6T8AP7E0UPMDOgcoiVLYjctrz+nnzDSVyAKIfyVYbq3VxT8bArVu
	L8IgcfTWmA7INeL+lXsyDit6WtohT4c2W98o3ID+XUshDaQCZ4yR1k5YTwbAzUO6cf6dBHMs9yJ
	o8Aj/oYbdmcuzQxOmmxBM2zwhgNeCplyQ3iv1e7nxRWrbOYQwfnIwu/gu4h1iLZh9y9L50i5Fjn
	j8JbxAxb9mXpOcJPgseCEFOtNreS4U/Z0dwH0CpxaYqWSJVHTZPc5bpcx5o6mTPB+DSuVGi9noF
	0eN4Z+9mzuVp9zAnUTqmex3rf+AvrHE0XIasgUVNS/Q4lNyWlird7OCvB4fqf6YKMrczlATuTzd
	X/B65+amYx4OUx0lbJS/fO6123mMrehXESR4mqonxWU+dLBAxlyBWr15livNu06aekpVi/nX8Sf
	SPP57AQs4H9n6KBwhoxWaG3iuv1QrzLyV+FGKd/z0isucNNcOxau1q7dcHLjaXqHawDrJeKWbG+
	9Fnz+c7xBkeVDjkvS/SwGFSKcUUH868XBxnMazCim8w9R00tb+qNVZNZi+/lWXk/kjqvIVhPu6Q
	RP/G9yQboGCd0IjMQN485bPFwNYx32SSjH1wGoZsV7GQ1Kmw==
X-Received: by 2002:a05:620a:4510:b0:939:f978:c1aa with SMTP id af79cd13be357-945f33aa7b6mr496408885a.11.1793989767620;
        Fri, 06 Nov 2026 10:29:27 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f599baa2sm202020185a.15.2026.11.06.10.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:29:27 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnacek@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: check MAP_SHARED_VALIDATE mappings as shared
Date: Fri,  6 Nov 2026 13:29:13 -0500
Message-ID: <20261106182913.15233-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selinux_mmap_file() only recognizes MAP_SHARED as a shared mapping,
but MAP_SHARED_VALIDATE is also a shared mapping type. The mmap flags
reach this hook before the mm code processes the mapping type.

Consequently, a writable MAP_SHARED_VALIDATE mapping was failing to
check the file write permission at mmap time, and a writable
executable file mapping was wrongly checking process execmem
permission as if it were private.

Link: https://github.com/SELinuxProject/selinux-kernel/issues/78
Fixes: 1c9725974074 ("mm: introduce MAP_SHARED_VALIDATE, a mechanism to safely define new mmap flags")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6168dd5f91c2..ce92632e7db6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4180,8 +4180,11 @@ static int selinux_mmap_file(struct file *file,
 			     unsigned long reqprot __always_unused,
 			     unsigned long prot, unsigned long flags)
 {
+	const unsigned long map_type = (flags & MAP_TYPE);
+
 	return selinux_mmap_file_common(file, prot,
-					(flags & MAP_TYPE) == MAP_SHARED,
+					(map_type == MAP_SHARED ||
+					 map_type == MAP_SHARED_VALIDATE),
 					false);
 }
 
-- 
2.56.0

