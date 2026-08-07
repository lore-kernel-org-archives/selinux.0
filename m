Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD256379ECD
	for <selinux@vger.kernel.org>; Fri,  7 Aug 2026 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786131359; cv=none; b=Yn8iKYCCdODo90ny4Pwzkip6aoBbzNMLYXihzQm2jKwkhdjAGLmTwwUzyARuhjBGzBKV1n5V2r8Xh9B4cuQRApynhuebBfa4gAbqtbI+NOAjUZBOZa/Zk9x1B/B6I9VqcvP71/+9hAd/DNA30OBrL/0STE8sLhle+L1aiVT3S9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786131359; c=relaxed/simple;
	bh=FBOI4wDxIFwSCjG64AEI9I7qQSsXxZYU7TGqhR12Ais=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWms+7b1i65H167E1eCwh4eBn2+eDnjWUJ/tNqo6Va90bDW+wKdOqFZ9oAGa76cGorlg69xfsSPJipuSDkZMDyaoLNuinYJiRSIugjHqGQbOv/MjJDs93uTXA84W5KxHMYCuS7bviNvLY17JACpFcieJul/Uf2KxYIfF3k3cZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcYpxpVb; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcYpxpVb"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e6391b114so295767585a.3
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2026 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786131357; x=1786736157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v31um18NF55T8tnBrzbqmDZVOqYo6NHgZgUeII+E7ik=;
        b=hcYpxpVbT+z1UOshqRkGMi9ZgYjHSKSYTHRcD7iFLQruyFYYIbHTyAyymVxM/f1IjA
         NEcZ9a+kqrrMwbGcZoJv7iuDpv2hzEyQAFwKMxu1PvqQm6CS0j/wm2gv5N/BkXSXm1Wi
         dnFKKVA7xqtl9aObmEo0QVI5udn/QB3tNJfBrpYdpmIG8wdZeVpn+Ua5KSAXCIvSZzWM
         ND76UYO++Bs5aXt3MaJeVQoCOLYl2xgxe9gC4B5mW32lTfVZNOkEZEf0ofaWjQRh18dm
         rhn+Xx4sRXoBCK81nkbvx4JdIZrDUvxsDoYE7Ur9vYB8HwZQ34O/8c7m3w64URbS06uo
         k4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786131357; x=1786736157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v31um18NF55T8tnBrzbqmDZVOqYo6NHgZgUeII+E7ik=;
        b=IkmBa2rpOqefvwch4A3OCXQQBvO/q4e7zf7T3r5UImv8Rgs8V6M6KAPlpGt5Rj1y+F
         SJQgpruiLNSdA6k6Kc4z45PllY1BYKNiNcPMT1uciv00Su7m2HKa6m1+mFjLiHI2sWJ7
         9WUdvR+B0IlppHLKEotzuIVd1cUqjggZRnWqfqfYu1Z+2l/k1VoPDxFn2XI1VSX4ssXl
         WxvMD2L1rUivoMiFrC4FAwAtD7pcbANK5WbTtmq3mo4hcsx8RrGgJYXT9cwIpOzP35AH
         oqwD7jC6LkaUwmw1u5E6Q/O8HPfzmkgddAXFnon2AyypijajlUDqjLD4ji/JuQ3HDQVp
         mOuQ==
X-Gm-Message-State: AOJu0YzUBTGggc6lzq5WnWTO+tE1dBPodgtQjj/olgmky8hA6thFDs44
	dP9I6zV6IGtiRHCrMAouj1yN627iVUBVCMwdBILT1G3Gm3yolo7LOddXssB8lw==
X-Gm-Gg: AR+sD13NvsLV9B3k7tmUWb3ueA7UDgmPcm/NBIQ5eOwK7taqs2tC6rzarJFK+ElbI0l
	qz92y7zfL3ABPcNbsIAp/Lu9EIrzjjXby0RPlRUylFjDRMs1losTFQOgA7x7S9d6o04RCgBtJZm
	SU/3RtekKqgPcGFVj8Z+CxLtS33dfy0L2w8BZzNRXqCq9QgA446/I+GzwYMdPcdAX2+Ioq0PeR9
	IijnmVDU8xHHSQZAJqt8N07q6KRpOtRHtsrUKxNiGfqBmfI3AwFVNb8Evo2mMBHRp9r+bLvuaKo
	zeLOQ3EdjKstJ33mRd+ZfhUTSOBEZfcfG5a16WFH5uRRMTAuQ16P8X+WRCyVJJACYGmBzql5QDG
	uU0SJaov40s/zPO8fiMh+oI+U1s4PRGHU29gEO/EAPEGMYGurrnkjwRarsi5SVyr9649Fdmp8F3
	zS7uPVPv6/OHtYQ6AyRFXyz9VWZj3PGtpNKWutqe8DB1MQN0JCF8EleLT2l5t1RpJnqU8+NhLpm
	HqZRulL0LijSNG4p4zsxBf5YUAbO7aexo07q8+oevCQcsgWc11SnUfd3lOAMgFD
X-Received: by 2002:a05:620a:6882:b0:934:81ae:6d1b with SMTP id af79cd13be357-9366655a32amr1439533485a.22.1786131356723;
        Fri, 07 Aug 2026 12:35:56 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e22995fsm221996585a.29.2026.08.07.12.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 12:35:56 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] README.md: document the minimum kernel policy version
Date: Fri,  7 Aug 2026 15:35:42 -0400
Message-ID: <20260807193542.21108-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the minimum kernel policy version supported by libsepol. This
is independent of the minimum kernel version for libselinux and other
runtime components.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/README.md b/README.md
index fa135a22..f7e6f562 100644
--- a/README.md
+++ b/README.md
@@ -27,6 +27,13 @@ Minimum Supported Kernel Version
 --------------------------------
 Linux v3.0 (for /sys/fs/selinux mount point directory)
 
+Minimum Supported Policy Version
+--------------------------------
+Kernel policy version 24 (boundary) for the SELinux and Xen
+targets. Support for this policy version first shipped in Linux
+v2.6.28 and Xen 4.0.0. libsepol dropped support for policy versions
+older than 24 starting with libsepol 3.12.
+
 Installation
 ------------
 
-- 
2.55.0

