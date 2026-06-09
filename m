Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC33EB0EB
	for <selinux@vger.kernel.org>; Tue,  9 Jun 2026 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027310; cv=none; b=JWkr8sGT9H5q/tuk1hmSne9ko6ft+YdhMUFHMpHMysh9fVYhFhtNFhockRJajMJ174Wqd40SPho4mGjZuRpxbzxARfw58IFEW3oC6EyGppOZMQuffT/QzG8YUjRfSWRBpC6dc8uazY3SIg8lIwRJye00ZodmhvYqDSSYAmy5E2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027310; c=relaxed/simple;
	bh=YZPTINHpUSIL5lQyGuLTMg2K5uyWq2nE92TmhfxgHhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xcdy40T7tiNQ5iU+OYFo4T3gnI2BiEboyKxSGF33hHAyr0vgmuomr3YpErgYB8+CdY+lhtC6bhBDN9yY/+FEX6QAGN8nBP75rUWChL8ILaTyRTDvUuQAVDPFN5o975QvjiOzU4fujo12fZgB4AeJ1mI7wppZhNzT2ssdvcNkhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kr8eL9yi; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kr8eL9yi"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91588056619so405399185a.2
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2026 10:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781027308; x=1781632108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YhpE46Gms/1yVJxaJPNwck7tZAFMtJ0VdpNCoM24Eh8=;
        b=Kr8eL9yiYJel50GDMVTzLJKg2Uzx0mUtSahq8Eyi0wlJcml790rZkdsnkSO0cjWstK
         MjxYfYAPSr0DQYa8iEpZKSgVwgGUDk71Yu0WEBnKjnjhAQ98C0JltaLSpcd9Ta5O3JIK
         2siyv4yQ37z607JxEJjlDzCceHm9WxG90gLSK6G/4EEysntQ9s+NfzUjv3jDCoRYyBU5
         pbEuqgRoQ/f5sBBLm3DcwCkZWEY4d9mWtsfSD+LFN/kCQd+wbjwkCv7C5pmft9Geuotj
         vLFAh6lKJriGUEKa2msIVaXhrPl/CPANarNaeJaVu8lfiAH6d5OXUcXjCNVrU25UEXly
         9XGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781027308; x=1781632108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhpE46Gms/1yVJxaJPNwck7tZAFMtJ0VdpNCoM24Eh8=;
        b=eFxYIp2hBGFt413VgwsIYDJ43uSKE/T5gBwkQP9jbtxpTdSd7saC4j1kguxh1YYWu1
         9ZXI4kRhqco+VtAH1RPUUOQYF+zwPojVag8DUMxkOd4iYfoQYb4h9orPn0IcnVXJ1Dzb
         TK9GaZvNg+VrbpmRLmghFFK36nB5jGkHc0dhauSpfXdH/cU86DISBqlSlGFRy5URRL3H
         j3KU0ycCGnaIHmRXF5WwO39d3umQX1IaNaytQF+cYrIKbLfW53Fim/aouLr0/OqxlKVA
         Ytdv1b1OMyWdJq+JYFS0VHLKmQLSEO+uDknYdKc2vCEIJBjOqBJNOFgU/WnzetVJ53DS
         qYlw==
X-Gm-Message-State: AOJu0YykXNjjJFEyWOs2aBazNrAgnnor1Qg5NyXlPqyHf4AeX9W5WO0F
	mq1McEgeH3eUn3WnuMYurPxYPwVkmEivLnTMQ5DxM9pKRLyEU8FUUqHacjyRNg==
X-Gm-Gg: Acq92OG5VQjGvWhpKfwmMU4DgmPyfcTQ4/JTFOxOoXEta6IucUqP8q31xgEZmBv1nla
	ZGaY2i8ESqbxaXXBT7hAOFtfCK0JzDAyLY6wGDCqZAi75z76qRVK4+xTvPWdWX1zVt8a2U9iMrQ
	WYMP0dSUennN/yj34IBike2DM5PPe3jxW2kpYFB29q8+H3IadTijO3wzSgr9G423Yay4+bH+Tjp
	Q6zZbgfn3h6Eke+ScvGTXDUUwxxi63qzrkt6Ncalgp4b0yg3vy9nVFN0sxCS5w73BKc1RhQlKBt
	PiKH9DVdZXWwPtuNhxn7qr8HEx2dXGm+3emoORSF6TM2G+fs0mIoXUHiFHV0bjY6roSBNod0CJF
	brOt2U8J+82To5d0J8rJQKX/NMf8BZ+pe1jqWM99hAtnojAN+7n5TxoNMTe0zlpdgNd0HSaEwNK
	KJY0uS9U8Jna/pFxzea+Tf4tTKyS1t2bodn1yaCQTXm1fyST/JFMNhTR8YZrrOW6KUXWRhCxS09
	smvxgO2nvYGivG2bnSdffat+Cqmbct2fEyWpQ==
X-Received: by 2002:a05:620a:6ccd:b0:915:d322:c482 with SMTP id af79cd13be357-915d322c757mr1697045685a.2.1781027307507;
        Tue, 09 Jun 2026 10:48:27 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a21d2c1sm2373849585a.11.2026.06.09.10.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:48:27 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	=?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <cristian@rodriguez.im>
Subject: [PATCH v3] libselinux: Do not clobber errno of the world
Date: Tue,  9 Jun 2026 13:48:01 -0400
Message-ID: <20260609174800.6715-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cristian Rodríguez <cristian@rodriguez.im>

libselinux clobbers errno of all consumers (systemd, sshd you name it)
because its constructors do not properly save and restore errno.
The following program demonstrates it.

int main(void)
{
        assert(errno == 0);
	/* Just a test, it doesn't matter already clobbered */
        if(is_selinux_enabled() < 0) {
                perror("not enabled");
                return 1;
        }
}

if any function sets errno, it is not switched back to the original
value and standards DO NOT require errno to the set to zero before
entering main

Signed-off-by: Cristian Rodríguez <cristian@rodriguez.im>
---

v3 applies make format.

 libselinux/src/init.c             | 1 +
 libselinux/src/selinux_internal.h | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index 499e4e44..abed3088 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -145,6 +145,7 @@ void set_selinuxmnt(const char *mnt)
 static void init_lib(void) __attribute__((constructor));
 static void init_lib(void)
 {
+	SELINUX_PROTECT_ERRNO;
 	selinux_page_size = sysconf(_SC_PAGE_SIZE);
 	init_selinuxmnt();
 #ifndef ANDROID
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 6089463d..ce04b128 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -147,4 +147,13 @@ static inline void fclose_errno_safe(FILE *stream)
 
 #define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
 
+static inline void selinux_reset_errno(int *saved_errno)
+{
+	errno = *saved_errno;
+}
+
+#define SELINUX_PROTECT_ERRNO                             \
+	__attribute__((__cleanup__(selinux_reset_errno))) \
+	__attribute__((__unused__)) int _saved_errno = errno
+
 #endif /* SELINUX_INTERNAL_H_ */
-- 
2.54.0

