Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94A1741C0
	for <selinux@vger.kernel.org>; Mon, 26 Aug 2024 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676453; cv=none; b=E7KzgeigDeetoTbaUXEDrk5STUKczrRe3j/Iw2wb7xPemuZXSTguxLldf6TsJWLzfoK19WHopvHH+IgEreviqZtZ5bCAbr5pxB8WTI5gAX1K3q/SKXfluz3nzxt3noAvQHG/N1bpqlBmk+/AFI1M8HMyjKNdQKr26EkZnpgbPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676453; c=relaxed/simple;
	bh=S91zEmNZHymd5AGqOnNTj9zZHYoOBjbZP5pxAsraP6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZuKRJGBIeVYBPiF8KBeaxrLZuzvODDV1DtKER/jGTA+EsNBZdkxqHKAZnViCSza/X95tzRTsHljQAtMuO9dC9QpYKiH9Y0Jtf3eRs6xZgTt9z0l50ALTwIUE8IKsMd1Q15hXGSSTUKIOd/AcBgBWi5eM8I/rDqjHrdGsYM8ZJGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOWAW8kE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOWAW8kE"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d6f4714bso423976185a.1
        for <selinux@vger.kernel.org>; Mon, 26 Aug 2024 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724676451; x=1725281251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YkEcfw6GC3JrVEhyYL/AUt1kdaNV3/VUbVLc4lEVYs4=;
        b=NOWAW8kEE+YPm8Rv+D0ntthvFM7kcZPE6Lazhd1VART28N5AQ+Q7s6CJev5l/qIui8
         kbhwICU1Zl81W+8A4p/7aJgCI5eg0p613kOSPyVySaO6pN3pFKvdinKzii3oHE1ifid5
         iAY0SKG1Vu6fkk3l8iXLqGHEo9w/37iRgWOUgFDK2oVkErWmS4J2lZ6njzKwWrUnJN4S
         0LLHl0WSPJUEvNG12/0UV52DyxkTyfskP+XFa/GjtyHNhv+SSrZkfQmwMe5R3ZvE9QnA
         +75XmpyEeQGNr28wWTCh5qdLFoheQKFAZ1vaAuCs77LuH9Qw9Mwf7MffmSi6SSXw8fJp
         ukGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724676451; x=1725281251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YkEcfw6GC3JrVEhyYL/AUt1kdaNV3/VUbVLc4lEVYs4=;
        b=PCrUKs/ILq4uKxs4ndruvaX3ln9n6tluHeKHSOh3dF9nJe/r/ofdkcOHDo12U3fItV
         Ppnd4Pw+t0Y3/mqA1pk6txTeziC2CmI9Fuh6oVZnpbNEoDoHwmDwu87xiQX8cRZ+RYLc
         8Cv1mGi+zDCxxe63j1+gfjBb/FF+9APr6rO2dkviiXnBXIp+4bcpAWemzRKAQP0vDk8k
         HCs4FXIjaanshPLXjHMZsXv3tsP5rbdtAf4n7Pmpk04fm2rsctD6YJ3qHVzgpPlH+5CS
         wD07CxMoT3pGlp9DwwFZ7DAw6Q78pUXXWAZjpKckaUjHpWFPjdgE4MihoA9r5wG63bwX
         1jlQ==
X-Gm-Message-State: AOJu0YzLeE9otT1ntt3OamySjzBeeo/pepFBeHvElcZUaYYbIDxLZEAn
	RmxwJWcXdrlfBpnarD5iOkr4IsyndD0zQHiBUgJP05M5jUITMPsxjM/orQ==
X-Google-Smtp-Source: AGHT+IEnKc7VN3VA9J7+bM1Tlx3LfIpmBd6Yk7xPjXusmcoyu9u+6cwsy34djN29XlxkU8zQOA0/ZA==
X-Received: by 2002:a05:620a:248b:b0:79f:bd7:d24b with SMTP id af79cd13be357-7a67d3e2bbcmr2349785685a.7.1724676450552;
        Mon, 26 Aug 2024 05:47:30 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d6db58sm45547406d6.65.2024.08.26.05.47.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2024 05:47:30 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	syzbot+319ed1769c0078257262@syzkaller.appspotmail.com
Subject: [PATCH] selinux: annotate false positive data race to avoid KCSAN warnings
Date: Mon, 26 Aug 2024 08:47:09 -0400
Message-Id: <20240826124709.23530-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCSAN flags the check of isec->initialized by
__inode_security_revalidate() as a data race. This is indeed a racy
check, but inode_doinit_with_dentry() will recheck with isec->lock held.
Annotate the check with the data_race() macro to silence the KCSAN false
positive.

Reported-by: syzbot+319ed1769c0078257262@syzkaller.appspotmail.com
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 55c78c318ccd..70c335846336 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -282,8 +282,13 @@ static int __inode_security_revalidate(struct inode *inode,
 
 	might_sleep_if(may_sleep);
 
+	/*
+	 * The check of isec->initialized below is racy but
+	 * inode_doinit_with_dentry() will recheck with
+	 * isec->lock held.
+	 */
 	if (selinux_initialized() &&
-	    isec->initialized != LABEL_INITIALIZED) {
+	    data_race(isec->initialized != LABEL_INITIALIZED)) {
 		if (!may_sleep)
 			return -ECHILD;
 
-- 
2.40.1

