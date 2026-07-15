Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182063A9632
	for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132459; cv=none; b=QnZJ3lnc3qNRM6s3WwXcZKEv0MnbvzUUOUz2f9nCDN8gpb8H3lVYU/3qu2h9baz6KN9Dm4c/yNr2RB2UxeuXd/rvsF98nCcBM0EU5yQaySquz3Ab1an+rU128bOY+E8ixgWDFp4kF4i4nkhfoN4FQOeLkrAR5/KzQIiCNSJ1cKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132459; c=relaxed/simple;
	bh=X5+HpdrrXY9QXv8rmyHTYVlgGa/aP11nTAxel3cbTIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJcPVWG7UwRmB0XBmNn2J/5xOnEPRaPz5cQ2CKusr96sKG2dASFpsfuWALDcbTxnO2fN0h9qRdoTORRsSm4EDxXYL4cevXJ+Fc8hkQnnUXtcqUMvQ/iBaRdd4Juaq3fPA1/0WziHWZQ5bYbc/3bq0aJOgk9m7vYxFgaH2iSFJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXJvX1R/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXJvX1R/"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e53581361so403842985a.1
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2026 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784132457; x=1784737257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qA6oaCy8Tz41iPfUy99igJSwxpHJGjqw3Knjnhhh6ds=;
        b=OXJvX1R/GxIhBkDoubdfmqDJzn2MzcW+rwdVp/8f7MhPlMsA2duUQnMgz05qJvOKFW
         Dy2fpNBL8ZYVXhsyPvn4PohT4SlI0IZeDD9cHkxNW8maiLFxInIU3TTWF8Lu455xIwqK
         hBqFqEM56q2/EZ6r5eWOUdJqezNrc8sRCghZQruwzyAE96MO1/5n3u7zyEn2Gff3x9nH
         jo8U081Z+VZOkdjNH2iuX65L/GG0Y4RjSpM3b2msYnwYgLmN2xucpEEn4Lxu3AHo7FXZ
         iN25fJKG8KTRE3PhHrLSb0VXia6M0RZ0HkJR4RBn/JrxmNaMHb3BktsYMMTDSzWHzxZ8
         D8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784132457; x=1784737257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qA6oaCy8Tz41iPfUy99igJSwxpHJGjqw3Knjnhhh6ds=;
        b=nuPv0EDeTuyHpnnwGKK6wz9PerEia1XvvWWYdFfWOZrULDKlzrY31CAT67s6/GL/mA
         R+wT/ixdKCLdrGsA3hJdV52cLMncrZAVpNp0E306UJYcdWSUwzNDYdshD57jgHCPw1r7
         p0p4bOrXl72T/+3EGaXsqRj0uZWPeNhgc2ny2IhJAHtLFOz/H0aotmhZxygMdx6Gc2rH
         O8kd7jvrrGuS1zHSJYkzAksulwj8HKVeIlggIS0n5/9XWGNN4vIyfkevMBJ8zga4sxoH
         OjUvmA+MjnhCXF8RAzJ8JAiIfYTg/el757g6vuzbLsFVoDrUbzBD8MgBKlSkjFTSu1ej
         99mw==
X-Gm-Message-State: AOJu0YzU+uSU8HJ73mE2lX5Hhv3fqJ8h7rqV9Y7WvovJJ5NQxdRrvQWC
	jDReizvDaBJeLHo/OmrKLw01ZhW8s2JQitWHJhPxfG9KXH71BciSUc5Pvwt/qA==
X-Gm-Gg: AfdE7cm9QVNb2JhE7tnEF1UXvck+jGXhnmSE1DAP4C0KmTQXGdL9l8HpG48rBV7GUoa
	9vobksW0Urdh4m7cwdesSiUShA1jw31zqBKn75ECK0MpBJG2NOmVLW6oE3pGogUa4vClLXCnWbZ
	RKTBBoRleACby9Duy8tQphoMnvs7VvXGntCxSYtZjZL54rXNju8ZSPrnqBVa4/g6boWy1melCXG
	xO65uMjsYfpqqePo9EoJbGyzyPxFoHOQ7SZiP3adDC5kz2BizKwfahbjA0vhB/3hpAC0jOeK4Iz
	K4R+7UCmV+EpXtigWv8wooJLloIdcPxhVPDa6qLFR/PdZuxPfEEFvrKCplYgB+EDOE424a9RHcM
	bKx806RO3sHCFUfFt/nXuy/jGUumLFj5l62/jz9WQjStDQxHWB3N/k7nHP1ihfLw8hJaODniqKK
	s+JjuJn4z5CI3U5JfDskmGmWJG0003E13znHqhpOqc2zaSgaveibYyOJ/vNysdVFjIKbrqx5DTQ
	/fyVVqdHrZU/1IXLbemX2OLcZM=
X-Received: by 2002:a05:620a:3708:b0:92c:3086:6d50 with SMTP id af79cd13be357-930961c3c3fmr348776185a.2.1784132456867;
        Wed, 15 Jul 2026 09:20:56 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm1694855485a.30.2026.07.15.09.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:20:56 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 08/10] sandbox/sandbox: shred the correct directory
Date: Wed, 15 Jul 2026 12:20:34 -0400
Message-ID: <20260715162037.42329-8-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
References: <20260715162037.42329-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The shred tmpdir branch had a cut-and-paste from the homedir
branch; fix it to shred the tmpdir as expected.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/sandbox | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sandbox/sandbox b/sandbox/sandbox
index 3368a95b..8c15d659 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -530,7 +530,7 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
                 shutil.rmtree(self.__homedir)
             if self.__tmpdir and not self.__options.tmpdir:
                 if self.__options.shred:
-                    self.shred(self.__homedir)
+                    self.shred(self.__tmpdir)
                 shutil.rmtree(self.__tmpdir)
 
     def shred(self, path):
-- 
2.55.0

