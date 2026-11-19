Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093460;
	b=1Q9fN/Rf6qJkNk9HoNTS9/Du+pRwpV+lJbbnuynG42EAkJ3uxngQX2VCQQk3Pxx0c1Qr
	 ZdDVm/etflEWj3Xs6+igHDmBqjsvsHPMqoS5fkD38F7EfV2S7144DZd9tFIgkDZhCZoSP
	 +wIwmLMQAHY/zkFItFwtw/jX9VxQg00LKah2RsFpORrzeLmL6Xky2EUENUnlbrvcbbSGg
	 8NDvzw6dEwgAeOoke2WyiFvaYNqyMPLz4tnhQT8mTCM0hHctq7vG43kYXFluKY+noTqUG
	 jmjQpASJORBrBU14ge81FmPsn1DXIh2noFAxVIaMdJDPMAFhKv1H87k4RNXuTc6BkwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bIRQTcDLVn9MTr3/MFGsacalhJQbU2b6v2hdGeBduzE=;
	b=NNgcIjMJ7V0NZILBYAYRylgaFs1mSuCnPaoG8vsxdW444GkM2ZaNeKPn/Jjaa9smgYlA
	 q3kXxWM0lv0bzEfUzBXnmd3FPABfurAapM6uEXoBIYny9qAvt5qBkSg2YmQhbKCt+zYQ6
	 8fWkHF53C4Z0rU768wK68Bx/97v6i6tjJdAFjGovZCo0ystV5LOtDZRIFmX7wk5fKrtz5
	 qzCwTXreHipvbG6sNsnFpGkiHc32mCXiRMAI6Q9gXaY0lkxdfaTUADxQEMcgjggWWc/ap
	 M7DrNCZoY/YwWfjELJH35w3rELrplqJi7DdRpR/N8bRq6UuDLXxzl4lRg23ZtuEfzhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zfHt8orL;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DDB606A32F
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0DDB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zfHt8orL
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f22a8515eso207808085a.2
        for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 05:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795093459; x=1795698259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bIRQTcDLVn9MTr3/MFGsacalhJQbU2b6v2hdGeBduzE=;
        b=zfHt8orLL5n1QSFYKhVxiBw+PER56xPJKJwmvgszWS/BWfG5jgd0ECmBntP8su0HH7
         F401/PTw7kmwDnD9GP0AiMB0jdk4bf+ifD4QUp5F6ZDRFNunaCVNXr1JFZ7mtHE9S1mG
         /qIxlvxLE+0r5NVi2A/Vsob5YC+M0+2N3TO0DmtpbUEL6a4qCTvAqKszTJYOE3+mzbg0
         eRHSPJ5PwelNokVSE3cck7w+Bg8hJtMcq3HKLM5ObitdsyBJfQD8yK3tjQh4Hy0pa+b8
         DuYHIl95okdtapbGd4llRqXZfcQVvzGZQnOEIew9smNAO4Vpy25bJWujW77471w46Xz9
         6uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795093459; x=1795698259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bIRQTcDLVn9MTr3/MFGsacalhJQbU2b6v2hdGeBduzE=;
        b=nDtptk66bjaWjxlcsi7hYjgD7Lq6iNEBdYCNsrHPHo5KkE/zL990HrKxAAX3JKDx0W
         C+nm+X/3WpnI6BZmZjsLdmPcax9Fq12T+9ixev+0cwZUFxmt2ojjwPpdh+rI3IOp0r4a
         kK9gftMf1CINPZeEJlYeJ1G4VMqOif8JjiuG5na6Nck7G3NX6CvtJbP6k3p0ENwLX8WX
         SAHNpETTdyQklJIWRkvBupCc4eP8YIwHW5Kbem8LajWzQj78CAjULfcpMASpoDejTx+h
         W3kERm8OC3HYJI9Lhkf+tXZVbf6YeI+fhswuDClneSYVnNcUG8ePWYjI88Z3uNW6eoUF
         yLYQ==
X-Gm-Message-State: APuU4Z9M16KnPvLX8rj1hiXEkbrqofu/baybN13jrIGL5tyGuCjsXWRG
	E+37aCmPkoT/eQlvGdLqqzPNDa5xRyfwVALL+Hrq/JPtt/uat3OMfiSO6Xeh2w==
X-Gm-Gg: AYBFou1Ggr+Q0Z+1i+lPJelg5H3HpXvjAqfkJMXXxrhtiS+URcFcbycbcYM/LBP3PMQ
	txUPZAM0/MpA7EudQkcUosG36dyYHrT02dqk6s+aFGaQzZxXOyn6YaVivJa344m01bkrck8SdM6
	NawlGGltXV/EE7vOYuIgZn6oRq+vsH1NEOlsS6H5YS/ipd/p6tRQpJDaujTuiPnecf1XduQRIYy
	uhFq6DYnqQgr0caREwPM7L/h8LwPfJ5gj/V56BLAsLKugBJ1bw8rdsw28lknmyigaoHRRC4M9kB
	C1Uxw9o/+Gv6rVBOWZz1RkzCJFN3jcZGYfvgxsyCOZgOewaQlP0CRqcjQ2dSWi9Q5MvMDdaF3wz
	CP0zn+y2D94EDPl49NHMrKydntx3zuuLuuKKFUEF0gderHDDlofx5QBomFMglQFQANaOfaexaGC
	zAjDAtL/UO4umjcmJJy2kbNOyvZkKUPssCU1o9eU96GaNsNyf9RGa0iosg92l0PR2qd7+nKYifq
	3fTTW1JlqFsDFIXADfW18BYb3bbHcdeDO+bLLFtphEaPoR/aOUm3A3dRU3fSctott2qOTRn5fwB
	q36ZiqWmToyb4Lu1fW7bA/iM0GPp4iGEkNPLODs3QAd8vxlC52Flf83LgKgumftChz7zIEAe5Gp
	P+UgHJIrv1Kwj8PIuofwXqmY6PgCUST2Ztw/6m2PSwAeg6ut8B1EoHzg049xWAPHy0eQgvgW7Xv
	d4ACIS0Zh+UnezEtFEU97YCxDwgMihH7IK
X-Received: by 2002:a05:620a:2585:b0:93f:2aa8:c555 with SMTP id af79cd13be357-949995e7f02mr1021204085a.57.1795093458636;
        Thu, 19 Nov 2026 05:04:18 -0800 (PST)
Received: from debian.. (pool-96-244-147-163.bltmmd.fios.verizon.net. [96.244.147.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b7c7c46sm437154385a.33.2026.11.19.05.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:04:18 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jwcart2@gmail.com,
	paul@paul-moore.com,
	jason@perfinion.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/3] sandbox/sandbox: do not follow symlinks when shredding sandbox directories
Date: Thu, 19 Nov 2026 13:03:53 +0000
Message-ID: <20261119130355.707-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.47.3
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

sandbox --shred walks the sandbox home/tmp/runuser directories after
the sandboxed process has exited and passes each file to
/usr/bin/shred.  os.walk() reports symbolic links to files in its
"files" list, and shred opens its operand following symlinks and
overwrites the target file in place.

The walk runs in the invoking user's domain, not in the sandbox
domain, so a symlink planted by the sandboxed process lets it destroy
files it could not otherwise reach. Further, a child of the sandboxed
process can survive and race with the walk to swap a file with a
symlink to a file it could not otherwise reach.

Fix by replacing the use of /usr/bin/shred with an inline fd-based
walk using os.fwalk(follow_symlinks=False) that pins each directory by
fd and rejects a directory that was replaced by a symlink after lstat
and open; open each leaf O_WRONLY|O_NOFOLLOW|O_NONBLOCK so that we do
not follow symlinks and cannot be blocked by a planted fifo; refuse to
act on anything that is not a regular file after open; then zero and
fsync.

Fixing seunshare to ensure that no sandbox descendant survives is left
to a future change but is not necessary to close this issue.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/sandbox | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/sandbox/sandbox b/sandbox/sandbox
index 6a18b660..cfcc0b61 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -540,10 +540,26 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
                 shutil.rmtree(self.__runuserdir)
 
     def shred(self, path):
-        for root, dirs, files in os.walk(path):
+        for root, dirs, files, dirfd in os.fwalk(path, follow_symlinks=False):
             for f in files:
-                dest = root + "/" + f
-                subprocess.Popen(["/usr/bin/shred", dest]).wait()
+                try:
+                    fd = os.open(f, os.O_WRONLY | os.O_NOFOLLOW | os.O_NONBLOCK,
+                                 dir_fd=dirfd)
+                except OSError:
+                    continue
+                try:
+                    st = os.fstat(fd)
+                    if not stat.S_ISREG(st.st_mode):
+                        continue
+                    remaining = st.st_size
+                    while remaining > 0:
+                        chunk = b"\x00" * min(remaining, 1 << 20)
+                        remaining -= os.write(fd, chunk)
+                    os.fsync(fd)
+                except OSError:
+                    pass
+                finally:
+                    os.close(fd)
 
     def main(self):
         try:
-- 
2.47.3

