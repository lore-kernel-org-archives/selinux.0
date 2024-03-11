Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3D44C69
	for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169044; cv=none; b=V9uNG8jJgDu6bcEoCgX1i5Y45UheteeTaGpfTF1BxIXrLgQ+J028x/AxDqyZYeP1m+2zlRDZtN5TrPyupCOqRwgcIFE2STLBgdAD+0y8CoLtled9vuM+iiz17Tjb+dZ3YAM6cfYFNcz8jGLBYaPTEPvQTPhQUoy7wsamOd+F8p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169044; c=relaxed/simple;
	bh=TXd3U/zrejxgCu5aU3wl3fPG3/0gYTKtVw/7H4WFed8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWh86pyupqMsipKl/64XRpmNcNWjfbLNDx+964BrCqvAoj/DTnfbuigo2Q7fpCl/Ofss/gwlKyG/LzQ3znAqnQ28Gj6kKHssraTSnrVJBECDYHanXmFdA90691+iQZKl0zwIQ6xsQQ+suEcyaYxYp8WxJj0/dPOB6CSqZt/YI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gt6v7xQM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gt6v7xQM"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a45bb2a9c20so539305366b.0
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2024 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710169041; x=1710773841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4I5KhzfmHFGGuAR/lQY6X3o8j0qn+/rtGl35Juu1UDQ=;
        b=gt6v7xQMHeDk3FSfud7CDPyx++tHBS7Z6RTlPIAO7z3y/ZVW50EW9rQrm7UltdRYqt
         6iXakPMelUiTTgkg89PbtKN1Muwws+ZttCp1vLqYS5cdEP2oXJ/6MaMUypIveyNuV+I1
         kNP89FBYv7etRctB7FjbxOj1QI5dvHKZvK4GU3mJBzUj5Np/D3f97pXyibaDMkvPV90g
         U8tMhxB4kXtspr992HYV9jcZ7tkvv0YBbM+6BwRsNgiZ5pVFnRVi04BW6+1Wx3XgLLfL
         QzJnuU/waD97wuTjKgvU9M0KeBjq8GZRty8TlBD32ctrk1+iugrHbgqch5YQTGbTa/bb
         us3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710169041; x=1710773841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4I5KhzfmHFGGuAR/lQY6X3o8j0qn+/rtGl35Juu1UDQ=;
        b=OgADlzHynF6HGrjUQE5hTYgjf/OK7Vl8eat1QIMu5nEVSlSwTstbEcHlCzrW+g8SCp
         KA5QotNFU/R4V4BlHVmyDmylgi3HlPNILX8XSteloTMNKeDCn+AtZL2Py2x6yUkvPhE1
         AbSgws0yUqiAFQAEHMMmJxE8kPPzV3lEUH4dWdf5YT4yD/sDDcnHnH4VYYYYjXUDh9Z8
         ElN2YD0XN1uoOEOHzke4fGKoTrg9/+gry93f7hRA6i7Bxuj9bnhUSbsqtBLBN7eyXIgu
         Dk/lMj0qC+203tra60ula3sQ1zTcyHeZ96iMLm5NN9Huwj8sFQXaD/Jg/MxVQADEgr8k
         E+uA==
X-Gm-Message-State: AOJu0YzFcEvuot82mdArdJtuOA1vFXcUxCtwng+1e7ENzoaj8ICAXWBx
	jIJnEtPp2cqeXQlqth7OtMUh7adPlTd8+alC/4KknctSygm1vkeELB4PFzJZCeA=
X-Google-Smtp-Source: AGHT+IGyRNoGAImU852bZFCc4iPijEGgIIGT6Z5fY6cOtYugOhYjvv+43P+DlKjAY0VxzGP5JbY/rA==
X-Received: by 2002:a17:906:2e86:b0:a45:4416:1fbd with SMTP id o6-20020a1709062e8600b00a4544161fbdmr410304eji.39.1710169041057;
        Mon, 11 Mar 2024 07:57:21 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-112-075-004.95.112.pool.telefonica.de. [95.112.75.4])
        by smtp.gmail.com with ESMTPSA id r24-20020a170906549800b00a45a62e0ed0sm2945240ejo.98.2024.03.11.07.57.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 07:57:20 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 3/5] checkpolicy: return YYerror on invalid character
Date: Mon, 11 Mar 2024 15:57:04 +0100
Message-ID: <20240311145706.34885-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311145706.34885-1-cgzones@googlemail.com>
References: <20240311145706.34885-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Inform bison about an invalid character by returning YYerror, so the
parser can cleanup internal state and return the failure via yyparse().
Currently the error is only observable via the global variable
policydb_errors, which needs to be checked separately.

Reported-by: oss-fuzz (issue #67270)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Should also fix issue #67327 (leak) due to the now performed cleanup.
Also fixes issue #67272 for me, but this one might resurface.
---
 checkpolicy/policy_scan.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 19c05a58..1926129c 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -308,7 +308,7 @@ GLBLUB				{ return(GLBLUB); }
 "]" |
 "~" |
 "*"				{ return(yytext[0]); } 
-.                               { yyerror("unrecognized character");}
+.                               { yyerror("unrecognized character"); return YYerror; }
 %%
 int yyerror(const char *msg)
 {
-- 
2.43.0

