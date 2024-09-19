Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94616190049
	for <selinux@vger.kernel.org>; Thu, 19 Sep 2024 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733357; cv=none; b=BQfwSZ5VSwmJgpwQJELI8PnN20zZfPeIO+UodLuJhO8bZCQCToyrAaEyAg/fJsCmDHNV5c10zljPgCd/TcDCCZGrwHBNIMjMEW1sW8jFgMK2cm3440NYxv0Jq3g9lIyuaJZyunmYGsuXvrrf9YVzNlO+ZrOtjs1SSd1Fs9yhf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733357; c=relaxed/simple;
	bh=BB5Go42BHdfU715wfs+bQ6X3J1Ymq9udCXTu9oHL6Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dAGUzRG1vJv4s03Jw8PiCykU31aBmhj8jqPL66u8hzJNnP7kveltbnRRS44AIUTdCxAM1hyn5n5fXaM7+s5cqOOz59wiVZoXpm9cZ6rNe18Z1AjNVSLVddcpJlo9N5c03OuA9aIfdewZsmw+jap6bCyYH9aMT09gk8GlFCGL5ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YY2H6xq8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YY2H6xq8"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso67150866b.3
        for <selinux@vger.kernel.org>; Thu, 19 Sep 2024 01:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726733354; x=1727338154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAPL0EnLn2sU8hfK5IjCYmts+TpFNl8+U3EIfwL8xNM=;
        b=YY2H6xq8WjuJ9h9BRmBJk4G6Ocv/t0B8/1m0IIJBxT20QlGh8y1jJGOnImEJsM/Tnj
         ZVDv4YLCDQglGddzMih+T2+jCWGktdcHys0zgjzSPfEJdxDPPg5+k20ZasIx4Lx8X3Qt
         PYoKr7+RoPzR6YDOkJY11ERP++4eqMgYotud/UrJOlhpj4GuQsps++coGVbD9JeYfDZb
         ANM9xnJFcZn502gRxiCT/2xlUzPuNnRJsQTxIVytgmJGNMOEpbrOpNGRqdrBb0XJK5b5
         0Z7YfTca7rv69Mfvj+62VoamVx40S14qBc/R245Da8V2zMYJ1CXKMzhpZOQBJmxzHfuM
         /RUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726733354; x=1727338154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAPL0EnLn2sU8hfK5IjCYmts+TpFNl8+U3EIfwL8xNM=;
        b=hd58+/cAK78mxSq+bvQp2YRS6SVEiDmUMUS5xR2Etpa4d2T+pDC9z7aAMCLI9R72+B
         wylBQbc8LJZow5Q9IAkl22SQtfWUVGZ7fobeL6Qr3l2TbDRKuYPgFdqJ/xd5an7YHtVR
         ufR6svLiVxzV9IHR6FmhquV8gbeIoVqPjRd3aGy+ftHRhyD6YFSlE/YU2PA39CBGahvd
         TUzMHyVL25MPSUZCUj5RHAAJAvVcjIb+NdMNbK3Bmn21V0CFEJScnJaZCGFuFvl92T0Z
         IlhAgZKN/4vuD2pyydn4JZeULRfUw4zcDxkqzc/sZdwnMvO951JM6KtCnWfiVFe1Vbzi
         9Ofg==
X-Forwarded-Encrypted: i=1; AJvYcCW+B9SNsAvOntLdt0DxwrplgnSDtVVPyvhK/Wu5rDA0SVY+DgvjuLmUgefU5pSXKjwVYV92jvDN@vger.kernel.org
X-Gm-Message-State: AOJu0YxoCLeR/fa+6Ws65bl296i242OsdXjRERjJGdjxClggtMzLc66d
	kUiZbtpgL32TaCNo4UKWmlQjo9pjzji8JSnW85V0VDba83ac7InbhVEGlIX5hPXIYQSLkcF+wcr
	wAA==
X-Google-Smtp-Source: AGHT+IEgj4iYIgM8Bt6zG1rzYd8WV58PCBDkNIN0boAWnMtT07/5QKs9wxAFZjzNXqiQDisFfCPmsQ==
X-Received: by 2002:a17:907:e6e5:b0:a8a:926a:d002 with SMTP id a640c23a62f3a-a90293dfce4mr2370606866b.12.1726733353613;
        Thu, 19 Sep 2024 01:09:13 -0700 (PDT)
Received: from localhost ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096aa2sm688094766b.35.2024.09.19.01.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 01:09:13 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-mm@kvack.org,
	selinux@vger.kernel.org
Cc: ebpqwerty472123@gmail.com
Subject: [PATCH] mm: call the security_mmap_file() LSM hook in remap_file_pages()
Date: Thu, 19 Sep 2024 04:09:06 -0400
Message-ID: <20240919080905.4506-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2331; i=paul@paul-moore.com; h=from:subject; bh=HNkO/SgCMlBwb15VU48zTD8lUQTWlQzSQgM5TY2SxcQ=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBm69whUno75Ay2U9SP4lWVTm6XBW4IDMeZcbj9C O1BIZviFyiJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZuvcIQAKCRDqIPLalzeJ c/qRD/44C54e1r4DmgU21y6GHpoQORs2k6kMxd1cIe+LMENx5g3X9LUuUpfwfH8x7b8lMRoAbqp ek3jjOoxN+pDMvWbM6zHUjDUr6agn88BC0s5eF/QSYnIcZmCuRArMR0ilPamxsOmytrZYIx5hFN 3SiXcGpZ/Fhg3Kq0QjK8FCAcXzSh/6M2qJbSSwcGa5cv/JsNQvBnIXP9Mzxz1QGn7paqTLVDwSq JjTuhSRLOq06G9rZncaRPLJExvvGpGrjfcS2yYyHQUPR8fZ3uD7cb8r1e9Y1uZGIXGi63nM+Lvu dmR5yNlFviicKXrxxEZsEdfY4Bby0hcvaMVtzdbrcGjVJWtTHLRfspLxz7JCbI+dvctFoNjGHjK 5NQpnDNB7/hLL+NAKLy0qTMm3QG38C2Lu1YG58mtq6EVXjuPHDxwM1XGDK/o65rnb/bruWKeAko 2wgZuSuYG4XZvKu5MRQ9NMTkRWKa7rw+GQioysQ5NwUnURZFfoKQuCFAfMOdiNO1v742z76Y4h5 6jz3E+xDsA4hh0LYae+TBG794Uw8p8EMniPcGkuFM9BEQ4Gt/ZDXP/kUC9JHvRgUi6GtAiWjLEY oPI5PIR/UNEwTv4VfyuppQrzpr5qkHMEJq2b68tR9lN0La6Qw3aznTKB+Ar9wNYXaVNJtFI9Pe0 fpMobc1Rq4CSybQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

From: Shu Han <ebpqwerty472123@gmail.com>

The remap_file_pages syscall handler calls do_mmap() directly, which
doesn't contain the LSM security check. And if the process has called
personality(READ_IMPLIES_EXEC) before and remap_file_pages() is called for
RW pages, this will actually result in remapping the pages to RWX,
bypassing a W^X policy enforced by SELinux.

So we should check prot by security_mmap_file LSM hook in the
remap_file_pages syscall handler before do_mmap() is called. Otherwise, it
potentially permits an attacker to bypass a W^X policy enforced by
SELinux.

The bypass is similar to CVE-2016-10044, which bypass the same thing via
AIO and can be found in [1].

The PoC:

$ cat > test.c

int main(void) {
	size_t pagesz = sysconf(_SC_PAGE_SIZE);
	int mfd = syscall(SYS_memfd_create, "test", 0);
	const char *buf = mmap(NULL, 4 * pagesz, PROT_READ | PROT_WRITE,
		MAP_SHARED, mfd, 0);
	unsigned int old = syscall(SYS_personality, 0xffffffff);
	syscall(SYS_personality, READ_IMPLIES_EXEC | old);
	syscall(SYS_remap_file_pages, buf, pagesz, 0, 2, 0);
	syscall(SYS_personality, old);
	// show the RWX page exists even if W^X policy is enforced
	int fd = open("/proc/self/maps", O_RDONLY);
	unsigned char buf2[1024];
	while (1) {
		int ret = read(fd, buf2, 1024);
		if (ret <= 0) break;
		write(1, buf2, ret);
	}
	close(fd);
}

$ gcc test.c -o test
$ ./test | grep rwx
7f1836c34000-7f1836c35000 rwxs 00002000 00:01 2050 /memfd:test (deleted)

Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
Cc: stable@vger.kernel.org
Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
[PM: subject line tweaks]
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 mm/mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6ddb278a5ee8..0df568afe99d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3198,8 +3198,12 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 		flags |= MAP_LOCKED;
 
 	file = get_file(vma->vm_file);
+	ret = security_mmap_file(vma->vm_file, prot, flags);
+	if (ret)
+		goto out_fput;
 	ret = do_mmap(vma->vm_file, start, size,
 			prot, flags, 0, pgoff, &populate, NULL);
+out_fput:
 	fput(file);
 out:
 	mmap_write_unlock(mm);
-- 
2.46.1

