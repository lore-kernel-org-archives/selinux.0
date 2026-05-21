Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2F524A06A
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378336; cv=none; b=c/B6+fPQXRGlo/qkaHyyUo0Vg3IsckjJTrTJHHtk3mTR9nVlb2F8c+7DVjlp2lhZhh2U0h4aB87+RYmFW7YWNBa7/PZSogsOsL2s0xUWVq89+57nMhQDICkzuyNesYxn9Ei1CHZ98Pv3cFlCEUqoMCBocOipscxQxMmU/r1/JAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378336; c=relaxed/simple;
	bh=F70DM0TRxTMJhPpKftcnxuVUtpvKN3h5LYCYuxd0VyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPKBX9tqort4478LUHaSVc6xINdnbdR3M1G/luU7kjW61w3AJTLLeBp/NKIn03T6b4ZMWejwtSaeqr7K4fFukEX/FaC2pwv1m8zUxuA0OMyd0sWJY9o/n1hcLieOW0xnTpU1F4gprsc3wV0DvKO8wWPoqqqTHEGwudfQQ2bygHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9eFmxdI; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9eFmxdI"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-911488599e3so715762385a.3
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 08:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779378334; x=1779983134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IXciUBa5TXUXL7g4iimG4BzxVZ3r0sKa/tKUAeNrybQ=;
        b=E9eFmxdI0k6CCGZO9bcXTfDpCO7z+B7AJ1ORZWAdTyhixTOq9cIF6R4nXlunAYrx60
         lrblVGMFCnobJtny7Vwzp6VxWYuQA/lvOytqakukMCs4jU2AWLLmeAi1gO0pqGTqjq+9
         GcHuS4Jzqh3NgDRqEG8PuDMSr5OmJ2Z3BTufVxVkWNkrEguAgEG02ElyxZlqRCL9750N
         OD9amLaQM8vtVToBIpT/gH+YTo5Ol8aaxy5LdeGPheNY/xCRMXVbze6XpRBeZGBjB+wf
         huOfzzCYE1VaAILfMRE3ImKMBKpg5cOsb3qr/7wbXEwl+JeH6iJUJf2ScwcSvsJyEVu/
         wQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779378334; x=1779983134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXciUBa5TXUXL7g4iimG4BzxVZ3r0sKa/tKUAeNrybQ=;
        b=qGNf5YywNA5Ggr0uNbbtrWuJaQLRKYNYtYFDJIA1V0Vd2VjmRIIXzoEFn19Mv5VB37
         taH3yl1Aoaf1jPLWTxwIBqLDakDvPfnrwtSY6wiy9pzXO29qn4XkTOtwmBG4GY7cGf/i
         HKxp85xUFRHRFo2z+Z3c4gRbbo64BRivUsX4i4+li8zbeI8s6fYrtkgrlOct2CtF/sB5
         iYt3Qr7w1HsoPbvT+vjB9CDIgfrryGdkIYisMAMkkzg0TIWpBRayLN/Z5FIcxMdU2HoH
         vHci7RTusSR17C4NQ0IfQZUa1G0/hR1KJgWL6iIFVH1RMsiFBIlIzQ1kX0KBAKDRvAPY
         oe5w==
X-Gm-Message-State: AOJu0YwpO4NHt9uZ7z2YKPnztsnpQX5JbHdoOgQIqMkHm7+yGvGITPDn
	zLfBluNk6HeyPo8MVtRm0gOpkub/EjN5/SpJBg3S1Tt1k2H93fr8gZIWr1JCrQ==
X-Gm-Gg: Acq92OEL7F0lU09ezPUF8g7FmdsL0rqCX71fsaNkni93O1bh5vevSULMgtoX0wZWvGw
	borIVF29JqaW7QvfUa+0hTFffg/ic3obRE78LPsqbuQPF6N2gCxRyOFcrRal1AR/BeufCHQ5Nan
	ty+lCSCze721CMrd9uVHZ4W7jU9v3JC3Za7NXi7YZugkqa5d6EYmlVsPZ4fS7Kmlmw973BO9Ip4
	W5vV2JPn4Ep9Q+PCgeFVYVABQLSb5pjszIG7b975uM+G+759JbEE6JVr0VdiLYuy45DXreprBLo
	xaso5KGmAP9b6Pi6hvR0YvnvnVsSj6uB8Lk0a7CGw7RDiYqIEpZ4m1DbE+OEitbw5yO5CTCDkV4
	jOYF+x3X5EpoTzkaAhKVKbzF9oevK4V0NPVpG2FzKD9ae5c2MnChb/9rIbDrOlrwPZu2WL5dGrB
	O9nkrulKbDOc8cZtmkewaHDf4kkebelouUnBFyH6jbdcXeOq/LTlngOt0BeKGAgQmOCsk3+Mr7q
	cbM97Bigyf3TbwUwEAj8scrvRRwj1F0dMeZgb++5bEAGFkSJKGU7sA=
X-Received: by 2002:a05:622a:211:b0:50d:a6a0:8f04 with SMTP id d75a77b69052e-516c558ccfemr42153261cf.42.1779378333511;
        Thu, 21 May 2026 08:45:33 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc768dfdf6sm8013036d6.19.2026.05.21.08.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:45:33 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: fix undefined behavior for child
Date: Thu, 21 May 2026 11:45:26 -0400
Message-ID: <20260521154526.12791-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global child variable is written in main() and read
by the SIGINT handler. To avoid undefined behavior,
declare child to be volatile sig_atomic_t so that it
is async-signal-safe.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 7a4233fb..1e4c1271 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -63,7 +63,7 @@
 	} while(0)
 
 static int verbose = 0;
-static int child = 0;
+static volatile sig_atomic_t child = 0;
 
 static capng_select_t cap_set = CAPNG_SELECT_CAPS;
 
@@ -98,7 +98,7 @@ static int drop_privs(uid_t uid)
  * If the user sends a siginto to seunshare, kill the child's session
  */
 static void handler(int sig) {
-	if (child > 0) kill(-child,sig);
+	if (child > 0) kill(-(pid_t)child,sig);
 }
 
 /**
-- 
2.54.0

