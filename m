Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783309;
	b=Tv7i9/waSKic6L1yMS1l7NeGBKYz3q+paWLfXqa6iYht/1vdiSbkaZCBXCBZIQiq7T7l
	 XRO+LgH2uOP214WMt9YXgD0ip+eu3lyBmtXRTpvPi4R18j+zvhJvYgbgiFD6xRCe1xcTt
	 jD00S/fO5JzBjwfaj1tt+8oBk5ETU+PPn1wd+oLePa6aWVxN6UtCHlzAIa3ta+sRVTCxR
	 TceNQKFk+9SPIJ5nCqIY/aXvMQDMHxnjRt7Lgkq+k8usOa3kWVhBxEug56Iwc4I34hakW
	 A3AhvkODtpiPkUxfSYMUYZVw3JKqqIbTMWRsfYgB1F0oyjy++QputPxdzDLq9Xvx0Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=N7YJp3abwV8r3njD3g4kjZNsVtVMeM2ee8sHbPLq42g=;
	b=akEs9vj/ZsqtImmoIOHNEMmq8gHE1yhD+0xWY07TGLYciR+liHYCF15/kw0Kx/k59yC5
	 jmbDI3VNQMiq6vWqwPzcuAFbccETJwUDaXrp72tzy7TkAsZH0CVkh9balNGZ0cVDEcawH
	 PdP3v+ttJAhnZLvl2/uUIcXrMXnu+WbtUnlTHEYme+r+D3ICcCN4T6UNz4CjMbRIB5QGR
	 q3iSPBrJDCpJdkmFpFChr/zuJnHHEvQKr8qGNj7J6BZClX7nfoEnaCJvh6Mxa/FxZxQ0C
	 pFHWE2S3sMY+IOYb6rmnFsF4As89eLYxfE5gmnhXAJt9czi77Niwzpc7OHdaax5felA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ERucbhVi;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E556606A31A
	for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 19:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E556606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ERucbhVi
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e7ad9f78dso135610985a.1
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2026 12:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792783308; x=1793388108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N7YJp3abwV8r3njD3g4kjZNsVtVMeM2ee8sHbPLq42g=;
        b=ERucbhVii17xoe4WeNJpQXpP0k+5YSKZzlvScT0d/koES2Yd+MmiM3wzsYEN7eMFVJ
         9Z8mwIYDHEJHzh/vO35ZBSnya5VCnIT8r+jkfMar/tB0rwiP/c7BzxtaCEx8D9CbZsMH
         Amc5DhhUBTPa19cMtK+EzfVH3P/vHeMg2QBthSHoOfed+XefQXd65C4QyWEm75hL9j/R
         i/+gjGD97DKwl9cQoKQ5mMG/jmm8vKhTIhAYHBMY4HIFgZmIkNZRidTu7bzC6aAyMaP5
         Oilm4SE9ATOa499SysmenLuJrWIxG6MA96TspWQ3AyDuSNyD7TBW/u0P1dddgAH0PekP
         QP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792783308; x=1793388108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N7YJp3abwV8r3njD3g4kjZNsVtVMeM2ee8sHbPLq42g=;
        b=MMh6Km0Ps8PwHzo0D6cCY9kNNEQAP0DLEA8XpRM17oWIV6RAa5LgNq1tFPeM9LAj6Z
         jeZHfet3jyUTiaagGQxbv7a9qj2uWN7K+GkgXHpKxUy6NIZZSujXLl01RgjOrWSF5N7i
         kQHcCJ6bki5sJL88BCgJpumGTKqyiZn/TFXjlbok9CFnrigzNkpI3HMOvepefcB0g8RS
         lVBOn9Q7Ka8GxoEODVEmqyqZ/XfjSB/B7EfvLb+B7roqGAm2QyxoCkW2Xzl2bBdK3s/d
         XTLjq3g/1KRafxofuAehwHkhBgPqZqR9tIdXJbSamLSTuQF8ScsNMr4D/YXlusV2lXBA
         e4RA==
X-Gm-Message-State: AFq9FYLd1mN2T8ikgnkDneuTNjI9fNX2KbGaQLGyHxew4GYeHlEnGM4Q
	yQ2IoN9tGdxj2LWkxcD/tt82+ECVTQVGgGSWNTa9/yvZjYc0fIUKHTIcI/u399Mu
X-Gm-Gg: AYBFou0qQ8il9G1hfMNIoXXhq0zTVrnTF6v21u6ffBK1xjSBPOQ7ADC7CDmqNSTUgFm
	Dfmoo2aqAmt49MTA+DHQh0kfIC7ORQUikVqkIP0u4Ap+BklV0MBKbylhraGN45iBUTR4v1H0xVH
	7R8lBd1CJT8ykaNwegIno0BDGer5AoFEg9OmdkvXvjW2Dz/trHnLusXDD3r65yA663QvuMVY2P4
	tYEx/tbU6d25vfSAr48U5qBgW1MloY2jsx+8NRbC+E4uHlB/Hy5PARjPatHXqm8QKpADbt/knLv
	YJFURXc773iShbFXw3oQhlApC87LzjDGqTtaiGRPrx9UC/LkecLB++JuNS67VONKsA9wGbJPwTE
	7qcOQoMr9lZBtdVTVVnCZ2EV5IQAPqrqYhGFMOwe/AgTrto8l42vDrbjoA8+0S2cF8tN1StSwTi
	AdDsGZWXVp1KfHCHlqUoPeTau8AKcwtffKEVogeAOxe8bvpGh9o3Dzz1O3SfG4goPp56LNUDSYW
	GtDaH/tZCS5c1NDB1SHJkOWxyXeqz2psMSNGsp1T0M2oZEjlR81XaVgLq68HnIEcU3XeJSmmCUc
	l/UGzxqU8SeuO9/c5VVdNf9eGuaIdhqTFAkjGHHq8ZeWy2b6AG/BRVVZ5040pYmRayfcLbL148j
	P6AmPY7ZrupzTIOxy2v3stkTNJm01sy1BnpNQTqEbyg==
X-Received: by 2002:a05:620a:45ac:b0:93b:fde4:4923 with SMTP id af79cd13be357-940ef927d7dmr1159985a.63.1792783308376;
        Fri, 23 Oct 2026 12:21:48 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047b2d3b1sm93135985a.32.2026.10.23.12.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:21:48 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cathy.hu@suse.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: handle module writer close and cleanup errors
Date: Fri, 23 Oct 2026 15:21:33 -0400
Message-ID: <20261023192133.63279-1-stephen.smalley.work@gmail.com>
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

The plain module writer ignores fclose(), so a buffered write to a
full device can report success despite ENOSPC. Check final stream
closure in both plain and bzip modes and propagate errors to callers.

Also release bzip state when finalization fails. BZ2_bzWriteClose()
returns early on ferror(), even with abandon set, so clear the stream
error before abandon-close on both mid-write and finalization I/O
failures. Preserve errno and return failure after cleanup. Without
this, a failed compressed write leaks its compression allocations.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/compressed_file.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/compressed_file.c b/libsemanage/src/compressed_file.c
index 6032c1f3..367ad685 100644
--- a/libsemanage/src/compressed_file.c
+++ b/libsemanage/src/compressed_file.c
@@ -58,8 +58,7 @@ static int bzip(semanage_handle_t *sh, const char *filename, void *data,
 			fclose(f);
 			return -1;
 		}
-		fclose(f);
-		return 0;
+		return (fclose(f) == 0) ? 0 : -1;
 	}
 
 	b = BZ2_bzWriteOpen(&bzerror, f, sh->conf->bzip_blocksize, 0, 0);
@@ -77,19 +76,28 @@ static int bzip(semanage_handle_t *sh, const char *filename, void *data,
 		}
 		BZ2_bzWrite(&bzerror, b, (uint8_t *)data + total, len);
 		if (bzerror == BZ_IO_ERROR) {
+			int errsv = errno;
+
+			clearerr(f);
 			BZ2_bzWriteClose(&bzerror, b, 1, NULL, NULL);
 			fclose(f);
+			errno = errsv;
 			return -1;
 		}
 		total += len;
 	}
 
 	BZ2_bzWriteClose(&bzerror, b, 0, NULL, NULL);
-	fclose(f);
 	if (bzerror == BZ_IO_ERROR) {
+		int errsv = errno;
+
+		clearerr(f);
+		BZ2_bzWriteClose(&bzerror, b, 1, NULL, NULL);
+		fclose(f);
+		errno = errsv;
 		return -1;
 	}
-	return 0;
+	return (fclose(f) == 0) ? 0 : -1;
 }
 
 /* bunzip() a file to '*data', returning the total number of uncompressed bytes
-- 
2.56.0

