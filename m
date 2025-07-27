Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0A1EA91
	for <selinux@vger.kernel.org>; Sun, 27 Jul 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753631077; cv=none; b=KAPHCuihooBu+Rluqq9JEmTODCRccyNXvhSANKMIKMqR3mI7OlXS4NJ/bfw7MlBhuNYWqG5oTx3bwdJsxVfUI/BnOBLVsvrvPpJo1gQ6P02v285yIHNzjjTu+E8tbxRq7PUwYZEJPLcXAlzR4+aRwUswMRar+l5zk3Ic3lU4OdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753631077; c=relaxed/simple;
	bh=Bfg1GSEcCUl/noNvbn1cJFNhadvI6PBKATP1Wd92QBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J55bkcJ579JMqhML7mk9VSh0lzpX7IDcahI4jhPJORT19Jtk3NgQUyVJ3+f56rTzyQywD9H4ArvQ79ENa0ZKcWKbf3N6+0pxmjr9WebF3p41863UE/MxMVcIEXFf4OPoGvmnpr7cMIR9ixNA9MRJ3Iyq/1hRgUT24qYimNljjYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwkvUfw+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwkvUfw+"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b78310b296so389626f8f.2
        for <selinux@vger.kernel.org>; Sun, 27 Jul 2025 08:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753631073; x=1754235873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0IjUJ5wAjpUzkA0cdlTJa7c8hbXgtuP2dl4G7UP2L5U=;
        b=CwkvUfw+Lq3NlWWIaFBmEfLbOXySLuEbVKNkI1RNnE+Fhf/Jn67x0Xm3RlvYpNWNxf
         YnvWdL/2cSfODP9Dqsyrup5dHkeoKiz2IxVAiROp4WoJ1MyehgSrpprFfXLDD4nwzHmp
         gR93bh+c7I5HWAcb3ZLxH7IYIBUnGRvo1oJw/pDDj8Iz8SvNhelpMnB9d6v4zzixV7ks
         jvi4ADna7UxQAeBdIlKKPnlJjeqWyihj/wIjMjdOU4iNs20D7UPtEXQY7vDOwNTIg5ir
         dYbjVAxLfRkj+7B25w28rg6OmEklg6f2Mir8YvTNedXsHC0ct7NVa7GhWdfjmaip74mJ
         bkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753631073; x=1754235873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0IjUJ5wAjpUzkA0cdlTJa7c8hbXgtuP2dl4G7UP2L5U=;
        b=koiTIxUPOZ1jT/MMM7sQXELwLTkNKE0WkgI+W1M6W3CYFI0BHICmzel3pLjtmQP+TZ
         fX8kJbF9wIU29LAFIgUUrVPo2a8acI/Hc3bOy+H+kxky6k6/zsc0+KLgJQ0170TlklSI
         Ig7cYJ6Fw5NU0rpCXFk+WlNM35RySMbs8XOnJharRoqCIOC6mCc5toYbuPB7cykqGfCH
         5sYNrjpG64mKHDbaFfTd0rU8dpc0xoQaz0UB8hpvwvqXBShcK9WWEKgSkvsWX3rKKKCZ
         Rsns3kXry5MTTm+/k3yGOq3B7XZa+EkNkQrIp15rCwPyTfiga4hg57WLe6Q3f8nQ9Qtn
         5ZrA==
X-Gm-Message-State: AOJu0YxlPiPU8OWKWG0ryo1NeDBUKkarEcrstgY5Dm3PnvC7apa2Vaxv
	srsyB7WeJ9a31b+P6bdh4J7/37Coda6X+/6KF4HYYcbwYd0Qmhyz0ja4FF8NhQ==
X-Gm-Gg: ASbGncuCGfBQdPxnlLGzBnPdbmPOVpMAwV/AtBUgRBgdWZ27Sz3BjHTA0hakUNeTt7o
	5URV61AGCOZbm3m88s/wOkkezscpiZpbj4+nJXEPjNimF/nyUKHxbXGesFzaj9eYYeFxojUiU4G
	5i2HAGtjuP7bSLI28RidNqLc0tq1eoopbS/owp18OtrRH2udMYiXwlPumbWhDWSyJczUCU7sH/t
	giwUHbOb1NrAlpil1b8e6JF/YVsrFIXwwP90Mnq1Iq96UInTWva7DaJbwRKo5ns7nOGZO3ce4Kt
	nEI0ovdooV8ZX6PMEUFBphnTcSRL83L7Gaxufe4XjwAtxYtpKCSdWsOvmHVg6nDnDii0YO/nevt
	3AGSxh68/rNn2
X-Google-Smtp-Source: AGHT+IF2BLh5ThRhx08oHdo6rl08tenskjr1j035UckFrq1Zi3I22D8Fehon/9EVXIYOgXXkZPL3EA==
X-Received: by 2002:a05:6000:178c:b0:3b5:dd38:3523 with SMTP id ffacd0b85a97d-3b77671d378mr6405731f8f.8.1753631073040;
        Sun, 27 Jul 2025 08:44:33 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587abc13besm65168985e9.2.2025.07.27.08.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 08:44:32 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] libselinux: selinux_getenforcemode: remove out2 label
Date: Sun, 27 Jul 2025 16:44:22 +0100
Message-ID: <20250727154422.732647-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The out2 label previously only existed such that free(buf) isn't called
if malloc(3) fails to allocate buf. However, posix says[1] that calling
free(3) with a nullptr is valid:

> If ptr is a null pointer, no action shall occur.

Hence, remove the extra label to simplify the logic.

[1] https://pubs.opengroup.org/onlinepubs/009604499/functions/free.html

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libselinux/src/compute_create.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_create.c
index ff8553bc..b0c6ea34 100644
--- a/libselinux/src/compute_create.c
+++ b/libselinux/src/compute_create.c
@@ -81,34 +81,33 @@ int security_compute_create_name_raw(const char * scon,
 	if (len < 0 || (size_t)len >= size) {
 		errno = EOVERFLOW;
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 
 	if (objname &&
 	    object_name_encode(objname, buf + len, size - len) < 0) {
 		errno = ENAMETOOLONG;
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	memset(buf, 0, size);
 	ret = read(fd, buf, size - 1);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	*newcon = strdup(buf);
 	if (!(*newcon)) {
 		ret = -1;
-		goto out2;
+		goto out;
 	}
 	ret = 0;
-      out2:
-	free(buf);
       out:
+	free(buf);
 	close(fd);
 	return ret;
 }
-- 
2.50.1

