Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3903815CE
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580999; cv=none; b=XBCbmxBnh87Snnd+alFyKU8u/sceOw+EEWimzPgLOwB07sSww0mMj+oo1hfVtXrdqJZF5aKAEKToWucUkDqeImA3vDmKysiS+L9eZhHlxhYSj7Zrc7Cjga4JiP09v+2rpI1jxweZTj+gS6fNFW3091p5EYexAfRlmNWpJBqopXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580999; c=relaxed/simple;
	bh=tujn2He8BukX2kfMYwlTnYF7pQAxflYBLyxbJHycHSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GuHHUQKYifhLBaEXipkKw+NYg39zbojaBPTyH2m8xEfZIaCHIsGsSXj/JvHBp0toV63nS9fQQXM5gEV4k1UudlrMSd/iOZilB2MsIz35IylYoi1zoJd/+7C3vCDgCL9zBvSn8ZOmLSMERbYme5Pkb5ow4vrjoJ81LE23iXOqzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pGurAmcK; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGurAmcK"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5177b9a02bdso11757671cf.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780580997; x=1781185797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1KLvR1jv7pxYKHWCuKZEwkl3/cnXjI9qrmLeAEjEZmg=;
        b=pGurAmcKVA7UKs1DerUxRB43NS1IkebVCyRA8VWLAEatdgE25iKcfs2z8m2uP+z0ET
         QagdZxeNaYOSg9V2YdED3zrXGb45NTwJtR1jQTzQKOYwrJjB+VfCLZDJS2vK7LxOiBrP
         DkE+XQFCSZJPT3D6jrrjIPiVbI8PHaOTeGlrQEJdiOu5Mi+nZqL9X7hmuyvsrUuRfMsD
         qea278ei7xTwZVQuJ4fDM4X1BHwSJTUz3xRvw2LeTteCwyDkF8XLi13ApaO/uT3nuJi1
         0TdTzCqtoYwDUuOUE9MAZIXp/aI2w4IPAIQyYVlozBpYf6T9EOXgyRQAU5YaHS3N7DH4
         HPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580997; x=1781185797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KLvR1jv7pxYKHWCuKZEwkl3/cnXjI9qrmLeAEjEZmg=;
        b=LffrAt7D+gU5ftfsC9/60zrYt6FwubbPV3BWqpZhzguYfkD3Z65JZLWcOuMkiKdTQw
         gmQbHBeKDQtgh7HKeyrQlNtM//bmEakrXu5o37Gnk7bwNO1s8YuNGK5xp5JejwN5COBB
         y/tb4yGO/2Jgy+3gYC/q9vuzkajY+Fcub4Wq2O3mPDFIs/BRqdMaEW+c4zqr1t0799q9
         iBMN33cuSCZOaf0FEmwGHIt4me9sXsv/tGxg19bfSRmB3IK+NJocIhLqKiQ+hOM6zWcU
         pIQ6PHxpYC+07JcR6iZImvVcAF94nVU1HMcseO/othfLQzAbcM9AgbUWeZXT+q354ZPN
         frYw==
X-Gm-Message-State: AOJu0YxrknpVaoR+9EzV/brPonvnOhhcuPjXhevZAGlnoD3ujR7GUxot
	6VLjPz5zkY6kf+gJta6JVhhdpoUJ7IJh+pJh2v7NSIxS+XK2jOoK5IBAy2uD4w==
X-Gm-Gg: Acq92OGtI4/ldy3ZnvJtTTcV7TZmI338l0IfUNHb9uaND6feoGs3J5+CY3XEoeHov+4
	Ug5KRqSK04IQVuHnw/4V6ERU9le8oq2Ujtug706ZiIC/VDl3jzTq/jQchvequw5BKfSbjcdWXmg
	7nh4wntm2bcftt7NG0VLFdjAFswfLAqbCJ57tXWdwhUxu9c535YzJnWxBC18OkIRoE7fXCuiOdE
	Ed5R/3sXGDGKNnl75xo1XxM3EU3XMitNAQR47suMgYzMegpaLsS90I042u279T069Kc+GHfikKy
	hQ/Boxmbd7eHb72f2YwTZxPkS2WqQF2SRfB3MPI9dfbtrKRF6drDSrr3B3NrWNaP0PlaHuEUVFk
	yegXeiyiM68UhaAjL7J89U/d0YNArXtcv7U8rikeMG5o45SbEVswnkahEOvyjHKwAd0u63MoKOM
	yg55p5vHnHwNHcai4w91MnOh4q43rjE8xvXngN7eTGJ9eh+9Q9CtxUOEymMreL8jx3rUQ=
X-Received: by 2002:a05:622a:581a:b0:517:736b:e0c2 with SMTP id d75a77b69052e-517786aa792mr110215191cf.27.1780580997343;
        Thu, 04 Jun 2026 06:49:57 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07e91sm52916251cf.4.2026.06.04.06.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:49:56 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] secilc/secilcheck: Exit with an error for an assertion violation
Date: Thu,  4 Jun 2026 09:49:48 -0400
Message-ID: <20260604134948.6312-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

secilcheck was exiting with SEPOL_OK upon an assertion violation
because the "goto exit" was missing.

Added the "goto exit" and now secilcheck will exit with an error
for an assertion violation.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 secilc/secilcheck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
index bf12a812..e8e030ee 100644
--- a/secilc/secilcheck.c
+++ b/secilc/secilcheck.c
@@ -298,6 +298,7 @@ int main(int argc, char *argv[])
 	if (violation == 1) {
 		fprintf(stderr, "There was a neverallow violation\n");
 		rc = SEPOL_ERR;
+		goto exit;
 	}
 
 	rc = SEPOL_OK;
-- 
2.54.0

