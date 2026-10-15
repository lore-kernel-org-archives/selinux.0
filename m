Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94713DA7F1
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043387; cv=none; b=it11ozk25ERIq0NxCnoT5Z+zF5o07yYDCo7f5PZsxs61aOe8G0w7zESeCwpbbVZvwB5VtkzCPEz/MG3lCQZ4yjJ9KTURkfMeDLQ3T/a3zlaMIRdcpilNEVL/RBuxaYsVj6KTkX6kWF8M8UaUmXVGs46WxjYad15Yu9qg+8drFLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043387; c=relaxed/simple;
	bh=hlwrmUbF0lKMW/ArvGFNG051iogCXlWyGKgkp2OosZQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ItAEQJci0B8eld3V+2mmYtoABeNzR8Rs411ooAQPaD29ijhTPcCmJgylEKb2SL/FYfrNOhEF4EX7mHLpRWaBHA6VEZYpw+0hTuDjs8F+HUmki7EBoYkczfhUHFxcJYn8WnaiW2MQO/wCbWKXC/RJ7JrBDkjDZSSEaWhdWht5ccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=innKMZ8c; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="innKMZ8c"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4be28b82so1213216f8f.2
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 22:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043384; x=1792648184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4p+5EQhHIkEhoLifIPKgy3b1mLBI2XvwIKCd9LwIOY=;
        b=innKMZ8ceoVTUkSkumMju4QTHsO2vLjNHY80qKzTeTNFwlhZ3UJBiNixXqMRlcBJ7D
         nG89SVvyei9quGcwyBmFEyC4I1szXFkcXiuaCQrLyA60xkMAdvoEwCYVmoNKCqu+Xxg6
         4HQW/tUJ24E+5Yws/GmK6Cp6ayEBxlQ2d3Rvux8pIF2skCOECq5NtPsOJM6JB1IQeB4V
         QCI0X/5mgudX8H+TsbhjPYoXL+xUsPcS0aSoPFYUKe7s3jm0o1a9hi2T9wj0j6mUg/76
         DBAv/bcVtzLF6UE20+M/uOFdMTps1nORqc/JXDZr3+ULe0X9GZhUPxXTorp633R83Vwm
         3vSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043384; x=1792648184;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q4p+5EQhHIkEhoLifIPKgy3b1mLBI2XvwIKCd9LwIOY=;
        b=cRfAAfUTQJvwxhbzfnefBiWse5XpRpmSBGNSaXPb/64w448HVEssAu2vjqK04hzxQx
         YU8iAq1BqsY7/EeFGkvU1TeR/isBPz427SfMoUhlxjJHpIiXIRVDKlcQuoDMGMQCqyXe
         VzSwMziXFYyi+6GEercpYV970xGfJ82eqmKbbSvjhKrySrSMAsrwnVijp770mQczHztQ
         hc4F+rpUunY+Rx9Z1Crko+DYjgZl6lglxZQj45FBHG5ZOVgmm7lcOYlRmcT434ja9ekI
         STjbFYBiSsQicT00lHHaapbE4ecjjwLwfRawWX5BPmJCsGnetojgdQY8PYUuhXSON/3R
         9JIA==
X-Gm-Message-State: AFq9FYJ1SRiCY5XtowC7sUJXY8xyMpLpSgWtDRVerq4mby9DzsBPVg8u
	/CyOHn1UxltCOGNk8HDCpCAXeJ8CikvY4TzWDAFp2vgp2FIaAyFDUJ61FvAqjQ==
X-Gm-Gg: AYBFou1o3jfaZkFUYLhRxd6xXoRQDPS4oLyrjU/N9xGUdzWZx9/ucbyW9VmBC1MaiZl
	cVoDPUZxkI4YD3W36D0h49NVg7BjzwOltQ3UDoN43J0StYD1D1kKRANphebLGax0xa3fTjs44L0
	bhZ13XyAlQTvgC2rDBmYc945GyiP9+pKC16HcX+PBmlov77Qq4ANb+Qe/sZ2d6w+AGJwei3LCaW
	K3rWIy1QJokTP+nGzOElFtgwTaDW1eiNzC2JGe66sazKniP7iOgYa4DyBxP2pQOzdE/wA/Zz9BZ
	y+VAmyiRPDygzjRz9uBkHoQ7i9byXPV5wQQ0CrsswamQZM5N2MgjI+KgaYyr7mX5i/FkSBSu3IW
	d1IWn+lfzc+FnFRU3Qy/d20fz4qRKUZG4LiG/ooHCEmFBkyv7YnbqsRCSeewFltvumldhjEqQcn
	aBnn/cKZFKqMVxFiUsFh18Mo7G+/MRmVeTCbO8T/cezWQcm+T24Rew4Q6UqwBcm/u6onUmmAeVP
	WVid32wcP2gl5E=
X-Received: by 2002:a05:6000:298e:10b0:48c:7f53:9603 with SMTP id ffacd0b85a97d-48dba77d033mr27131966f8f.7.1792043384180;
        Wed, 14 Oct 2026 22:49:44 -0700 (PDT)
Received: from omos-acer ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48deeadc0b5sm6901587f8f.6.2026.10.14.22.49.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:49:43 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 2/4] tests/perf_event: fix compiler warnings on ppc64le
Date: Thu, 15 Oct 2026 07:49:30 +0200
Message-ID: <20261015054932.845406-3-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015054932.845406-1-omosnacek@gmail.com>
References: <20261015054932.845406-1-omosnacek@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the correct format specifiers and casts to make sure that the code
compiles and works correctly on all architectures. This particularly
fixes a compiler warning on ppc64le, which is now treated as an error.

Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---
 tests/perf_event/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/perf_event/perf_event.c b/tests/perf_event/perf_event.c
index 0e8bdce..97e1e63 100644
--- a/tests/perf_event/perf_event.c
+++ b/tests/perf_event/perf_event.c
@@ -161,7 +161,7 @@ int main(int argc, char **argv)
 		if (verbose) {
 			pe_page = base;
 			printf("perf mmap(2) return value: %lld\n",
-			       pe_page->offset);
+			       (long long)pe_page->offset);
 		}
 
 		munmap(base, mmap_size);
-- 
2.54.0

