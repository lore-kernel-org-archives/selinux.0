Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7F44653F
	for <selinux@vger.kernel.org>; Wed, 20 Dec 2023 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dL8GpN0l"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42581f9c0e7so48106471cf.2
        for <selinux@vger.kernel.org>; Wed, 20 Dec 2023 08:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703091236; x=1703696036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OFlDl2dLuV6TFHUP8dIIqFirz4DRFMrs5DqDwxmeW5U=;
        b=dL8GpN0lYG+XXltDJmHuWFpD3gGy394i5VAftV7ucZA97sYYIn3/DhIxb431dqbUpr
         u1OAUhC9y6QyDHabZDB/eaXLYeTfsuE7FtJGQdFtWsFpd0DHVO48okg0mmqfmGSJtzCl
         rrZc77ir9ZsFkwGCpd/saJc5WgaGzGC1QpxDXm3ryzEluJm47yg8tF1n+dLZt6roWcfC
         XKlckvRg2RI9iPy8Gmia082pwX4ZUrYsr95aD1WbjSAaOYqW2j+a4wNmFD9mTxDN/Opi
         eOvqupoPPBfCeoZye3DBuGm7gP5GRwszAEF+ugPiBndGe2bmZRsRacg55SZ4Lhl6jWDm
         g98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703091236; x=1703696036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFlDl2dLuV6TFHUP8dIIqFirz4DRFMrs5DqDwxmeW5U=;
        b=AfenWaTOljjQLckFYq0YewerrJ3Jv/xVkcliosJKfO7zz+WExgjq5bLl33EhLXWjsj
         hCYNWv3JQyqWksl9s5mTd30Ab8sdTReJx+Z4YeEs2iabFz9hV/PPNswOBk1GvG+8k1Mi
         MQpx1yLDWqPzJC+hXTNEU+GEmH6xwwuBfq54YpnkCbKxKdj4QW4/RVrOtEg0AOoo2B75
         LEk11242PPYJ5YQRR9U5YMVbKo2pg0LkfClqMxoc6dwQ45M6K49+sITKmXp+cyPCv5dB
         9852IGAZdeTWk94o+yqIAMTEdt4VtAAxgqGutllmNhD9+NaAAPfonalBVUsbZlobfNEz
         f5ng==
X-Gm-Message-State: AOJu0YwFyEof7YqE9Olja7nVFFSmpgnaxrG3w/6kU4swtOTKb9+WaFki
	THhs3GsdpbR43R31Tcw+EKjOWx7wQGEuqZn2SQ==
X-Google-Smtp-Source: AGHT+IHOb6ZhFO5yVZASvjx44m230PRvv8qv3t32d881qhlW/4mkuCv9i8/zPiwh8N/gRBTp1wzjmQ==
X-Received: by 2002:ac8:57c5:0:b0:427:8fcf:52c3 with SMTP id w5-20020ac857c5000000b004278fcf52c3mr994928qta.86.1703091235741;
        Wed, 20 Dec 2023 08:53:55 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id k15-20020ac8478f000000b004240481cee0sm31055qtq.58.2023.12.20.08.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 08:53:55 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org,
	Eric Paris <eparis@parisplace.org>
Subject: [PATCH] MAINTAINERS: drop Eric Paris from his SELinux role
Date: Wed, 20 Dec 2023 11:53:49 -0500
Message-ID: <20231220165348.127587-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=paul@paul-moore.com; h=from:subject; bh=q9Yx6q3AG1dETavDX8XngV79uFVOOWDYMhqQ3sPJEAU=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlgxwcaiSFJGl2vkWLTE/sMgQ1/ThQNlXdkZl0l iVHayfOV+SJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYMcHAAKCRDqIPLalzeJ c95dEACqii90l+jS6lP5IsBAflST8xVMeoTWwfDVaI+mXxB+MIaSoLseLhmv5zLQ1falf9gPcsG 79q9OgMUcrVJLJRqsdLTGE8n1dwzjuxtIs2uwJ7HTBC+WExNKmaa0uXJi2Ec5+/VgkorqrmpPB9 hWAqkMmHZ32KtMUtbnvSGjaVd+nttrhwtXRjVPKplogkFFJtwmWCTlmqdjlAW6weXWr7/4mzrCb wMFn/ui+eZnJPU3P/PNYTOE+HnSrXcW3nVti92D8z//vW9n5g2fFsF02s4vx2LNCN+/7RuavkCT Y9cyMWpC2u1B+DAoGHz5sBGlFcrQGkemyYOq5ieSF9mmh7nO6P29NyhfqyfS5JvQKM00sU36zy7 cxjckAwFsHIp4DcUVJxj12eZlegMYZyRf3wwdGf2bj0Jf3Amqs5L8hyRMwE/mPcHIYeQGuJEgnR 0Q3MCBOD/JBrYRQnXcsC+/uIfOfbAupbPvlAkrW1m4LITmAswYatP2DEzxkVPagbmSiw5ou+XxW axiIhr05BsAlbpIiowS2/OOFpsDScEUFyuUAQy6dfJ5d59wNOoEmDNvKS9l5HPkpeQneLkSQZmp yKRGq2b3GDFgps/AucwjK4boQEd0i4OR6C7H79REfk12pBpCRZ65n1B8+0DVfFF/Z2RW7X3Xda+ GkIT8YFYzD6J1Xw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Eric Paris is an important part of SELinux history and we are all
thankful not only for his stint as maintainer, but his numerous
contributions over the years.  Unfortunately for us, Eric has moved
on to other things and hasn't contributed to the SELinux community in
several years (his last SELinux kernel commit was in 2013) so it's
time to officially drop Eric as a maintainer.

I also want to get ahead of any claims of impropriety and state that
this change has absolutely nothing to do with commit 2be4d74f2fd4 ;)

Thanks for all you've done Eric, you'll always be welcome back.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 295939417dc0..1901468c32d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19517,7 +19517,6 @@ X:	security/selinux/
 SELINUX SECURITY MODULE
 M:	Paul Moore <paul@paul-moore.com>
 M:	Stephen Smalley <stephen.smalley.work@gmail.com>
-M:	Eric Paris <eparis@parisplace.org>
 R:	Ondrej Mosnacek <omosnace@redhat.com>
 L:	selinux@vger.kernel.org
 S:	Supported
-- 
2.43.0

