Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF0C52F88
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723149247; cv=none; b=fBjYIn7ZmOaZIU3mGhlRJaStCIuI4jcfiuAHHFbFvBO7xwNzIPdTikz6ULsBp8I+6CpBh01XHXzTfr9LyjRArn5Jl7y5iP8E69baVfOIvMLl9BR2ARI2E3AHPCJ3rPGARSTzkBbST7vDw+KYmVUBFwz19TpsyU3PAvvtAyJyTqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723149247; c=relaxed/simple;
	bh=stOOJSh17dOKBQnnWfpfsdsRGrbVe/4QZuW0m8rM+nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8+Va9p0fIy989uRzrUGdsHWGaFSzLs3XnxYVy2m4ZHJl7shmwJKbbq3fATtLLeEzDMnwyfleoFv0sbrsFvQDs20mq/8FUSlYJOnIzJonNtzjRmMNvhaaUP/SCUjSPyOb8pQNSegcWaQUXtTxLaGtSmO07jjcEZMp6D+c91RRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U3rAZKpv; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U3rAZKpv"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b97097f7fdso9053586d6.0
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2024 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723149244; x=1723754044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7POHmmVt8LjyWSO5cXuvCZzJXbMvpS3JwJIE8AcRQD8=;
        b=U3rAZKpv1Q9v1nrePQ8b2PMjWt/2kxoB+hkX8GXRGIJyQztz/FFZi8tdzkIE6tXW+7
         o7LStIiRWs97+EAKI5ySGusMYDDGuPWjayVk+XotOzrNlOV0OfEeuwJfKaSx8MkM9uQf
         h/oUotYNyIoqovID/+HV5uETrsba7EIIf8F3TNXVJ837I/X4fePdz4Co8fklXk/UVxaU
         niNbXKNuh7AFSFR/iXulGBTEiALkZYW1b+rc+fK5F0sADIHG5s21nloy3RB6syo2+ZPm
         irIaktLOQNx0RD51Fm4a6RiDy80IX7frAZnSAnd2rlcum+XMiCHEpiNHt8dDUL7THz0m
         +D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723149244; x=1723754044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7POHmmVt8LjyWSO5cXuvCZzJXbMvpS3JwJIE8AcRQD8=;
        b=nogSTveO0IfO9xKE5bWpyFDlLtcSESq16L6L4NcMdgCsoxohQaVvHRjcpv+Ww2RfHg
         iRUBNHERoW7fjtUTlHSWrwuChNW1Tb5MGQ5H+oNxTi2VqcqgQfqoN/7aq9Rx5QL9hVtI
         7cxiJR6ddOvOm5YUfgLnzmqKjlCo5lm5EjKrut8f3v6pfHq6iB16z5hK5/3OWfNHLUID
         QSQIvx1rsg+1pXC4IqdfTJmVT2JO0YPm/cZ/HxLlK2cIcQtqPN1yd+Vmi8zgyWyLyew3
         Tdp4Uv2HwpVgvXeYdQ4Fik5XmKBsTv/XWvXo+wNV6AkSq+Cyfcqmtp6bvJOZp9+MrA3r
         /cRg==
X-Gm-Message-State: AOJu0YyyWLGCxDIt+YYrPsjDzkSsIhxSDCGsArQVLlbgMFk5VewxSJNY
	aEzddCPh48u2eqOB/fa+4vAkl/Y3NihRqVJWKfJLjPf3oPfQf8f3b3bVyXagZ8ur1V75dZzLl9s
	=
X-Google-Smtp-Source: AGHT+IF2+kdtphjsLEZ9pCkL/G9YsKQH70eq6zNUMUMNM/9QInUfbfZMyZw9WKaVsT75zw5YhGO5wg==
X-Received: by 2002:a05:6214:5911:b0:6bb:bcfd:1905 with SMTP id 6a1803df08f44-6bd6bd783bfmr54683256d6.39.1723149244243;
        Thu, 08 Aug 2024 13:34:04 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c86772bsm70157586d6.124.2024.08.08.13.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 13:34:03 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Cc: Marc Reisner <reisner.marc@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] selinux: revert our use of vma_is_initial_heap()
Date: Thu,  8 Aug 2024 16:33:54 -0400
Message-ID: <20240808203353.202352-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423; i=paul@paul-moore.com; h=from:subject; bh=stOOJSh17dOKBQnnWfpfsdsRGrbVe/4QZuW0m8rM+nk=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBmtSuxY/TX5S6EbgcrBWFN3gTDI3hgBL7dztBu+ uC8DjfHIt6JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZrUrsQAKCRDqIPLalzeJ c+zuEACpc9P5sVfKo6uA5cgmeGxiBHz+hEe4Ycs/uIXynVGzTRywb6MIG9mlYEAFQeeyPLMMT1U uV9uOy9j7nc1KAFg7irkQfjkIWryo7vjJLXzevdf6T2HSwWrNC0LB5Aqk8ekX4kJFRw0DENLszo LO6hbeFN0TAKA6ilvGN4gfCtZ6MK4EgLnfivAaFmd6r2NugGkExm3BjzKL35hYUbxvWWBMP0lw2 3Y0cphDONOCjOLSX58oGMBjp1HTt6COThBxUqOSihmqNWlcyPnuL0ww47EkRheQ7wVP45SzqCvR XiByiTRikeemPgSk5YPq+3bcGJ2YZJcxQkUNcJfy1VSWFGPmoj6F2Gs7AiiJDZfnW1mhXYxv4x2 BuX+p8w15uhTI09qL4bMyn+Nf6fR084S1wKalhzYpZB0bbL4wVifowuqj5+ovhmkTjCwH7BX6bv fa/MaLwi1yThXoohvqKPUvDPy5nR8EuWAnhP3F4rwEz/d7Szg9H1OWPIfyINHmumQLZlFYzvW2g yA2KHtCg30hjIxdvZZvNgN0osCpt3uNzIFf+EXW8D1T7Tf5AWm+4ySCOLC9zg0jsE1GQiIql6MF Dq0jIfZhXdye9E+Y6Y43e5Y+Rt8KJxJIYcELCAgnhHsJ8Dy08m2IDOJvihrD9xfdlwoWMca22S2 8TMBI7aB+hjSK3Q==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Unfortunately it appears that vma_is_initial_heap() is currently broken
for applications that do not currently have any heap allocated, e.g.
brk == start_brk.  The breakage is such that it will cause SELinux to
check for the process/execheap permission on memory regions that cross
brk/start_brk even when there is no heap.

The proper fix would be to correct vma_is_initial_heap(), but as there
are multiple callers I am hesitant to unilaterally modify the helper
out of concern that I would end up breaking some other subsystem.  The
mm developers have been made aware of the situation and hopefully they
will have a fix at some point in the future, but we need a fix soon so
we are simply going to revert our use of vma_is_initial_heap() in favor
of our old logic/code which works as expected, even in the face of a
zero size heap.  We can return to using vma_is_initial_heap() at some
point in the future when it is fixed.

Cc: stable@vger.kernel.org
Reported-by: Marc Reisner <reisner.marc@gmail.com>
Closes: https://lore.kernel.org/all/ZrPmoLKJEf1wiFmM@marcreisner.com
Fixes: 68df1baf158f ("selinux: use vma_is_initial_stack() and vma_is_initial_heap()")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 55c78c318ccd..bfa61e005aac 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3852,7 +3852,17 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 	if (default_noexec &&
 	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
 		int rc = 0;
-		if (vma_is_initial_heap(vma)) {
+		/*
+		 * We don't use the vma_is_initial_heap() helper as it has
+		 * a history of problems and is currently broken on systems
+		 * where there is no heap, e.g. brk == start_brk.  Before
+		 * replacing the conditional below with vma_is_initial_heap(),
+		 * or something similar, please ensure that the logic is the
+		 * same as what we have below or you have tested every possible
+		 * corner case you can think to test.
+		 */
+		if (vma->vm_start >= vma->vm_mm->start_brk &&
+		    vma->vm_end <= vma->vm_mm->brk) {
 			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECHEAP, NULL);
 		} else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
-- 
2.46.0

