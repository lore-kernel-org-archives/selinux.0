Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4076F18049
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646382; cv=none; b=ZPZdH5B992BsokdmM9KUya2BaxqTak7WMdH0PgctvVIs9BisGyKo1HPjVLvsL2fefWGfKZ5O4MsUGTkjhejKzLUKBIG8EWSDja0s3qYRwptCVB0rJHPvahnUc6Eyvx7RvJVAWUHYLtUFhpCl8XN8V+Q2GPemQxHsUf5xGLVDOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646382; c=relaxed/simple;
	bh=X6GvxoH9upAtZZCKBtoNzCj/Cj+wYIc8saKdJBgRo48=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRUMgB5PVIsNSsNiXFy9VqGJpMY/DP32HpIr30toFcddpElYbGTu8HKvd0hs1cAQl78jdlFPCqCEIyMIUqMssu6LyrgWBKPY27lHNY900Uw4OwH9osN8xHNLmqysaTrFn6HDK/mGK7r+deFLCsebOxYZ2ohhZz36IfQxkiO4xgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IFEJwwxX; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IFEJwwxX"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68facd7ea4aso3687546d6.0
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646380; x=1709251180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SvuoRk8B655yhxkpxtSUFejc6HdgaEv+APTwGrMM7c=;
        b=IFEJwwxXCTnL03MJqt5xFiUsL0VpYZJiemQi9YnOzcHfEHOSWF8FihKpB5oN+2AugP
         unyWg1ZnNNMF+vZuIBlc/PFyCraNBI4zq84lHMXnp/PDwkGmDxhzQs5WW1inKLM4dM8c
         b50I8mMS5IFhPCdABS67JCJQJum+4fCN7seV4hZ0yE6gbXLcpOVrAQiMn+l6g31gmQvG
         +JBF+dX1FjPMWZdGFTT1zCB6qS7rC9G5wPpSsR+Xu739ED/2tyWkQZsJI2mh/++zuxll
         A9YA2MDUSZ/gBPFJ5EmhR+1JxcG9K4lIl922HI8jSaEserc0onSFPHJpqSeBOy/H/VMX
         I/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646380; x=1709251180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SvuoRk8B655yhxkpxtSUFejc6HdgaEv+APTwGrMM7c=;
        b=pkVEi34X4oYp87sM8hUfErUJ0IwbOKJGDQ/ktXhnaZLdgMHDYCnot+eEOzM9bYs7Qm
         01F6l4vKVm6ipIp+MAi4OEc/sqs0KNhNkEOQD0uR1TLMrVy2L9M8fFrfH5BhqhZ2ly1a
         46r8ciOQqOZvzcUA1YlRBNiLioqwHhydZ5ZOlXxZB6Xli9EYEV4jHUnZ9Tf0AzALnc+5
         +dk/WEqyNtAUBIz7tLSJdzaWXC4hZbCDOdEHUn7jlm57XiWL5pZ/0hWai3WeCOMtPnPg
         odWQf1KMxoaZ8tHiXno6S8RyitJynPhmASAoOsSvu91NMrtn8FMdg++cySnUHzAWcl9L
         6pzQ==
X-Gm-Message-State: AOJu0YzUmEm90M5VbmIio78Dja2nb0azugJDKiuVEdkiMIXoeakwGadi
	eoPX88jiXwLzdScwdVoak+A8yj/xt9nAr/vcALQ9jiL6VQLqxiiRmVCRkLUp/N5JVa2dILLdfTw
	=
X-Google-Smtp-Source: AGHT+IFcDAbW0M2d6xhqk6e93O0izsklps/YVECiPVH99iW5UeWqTE9AO3slXW2inmEwqzJdj19pMQ==
X-Received: by 2002:a0c:f3c4:0:b0:68f:a7ff:1106 with SMTP id f4-20020a0cf3c4000000b0068fa7ff1106mr908487qvm.13.1708646380086;
        Thu, 22 Feb 2024 15:59:40 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ly10-20020a0562145c0a00b0068f4520e42dsm2115572qvb.16.2024.02.22.15.59.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:39 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 07/21] selinux: fix style issues in security/selinux/ss/context.h
Date: Thu, 22 Feb 2024 18:52:25 -0500
Message-ID: <20240222235708.386652-30-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=paul@paul-moore.com; h=from:subject; bh=X6GvxoH9upAtZZCKBtoNzCj/Cj+wYIc8saKdJBgRo48=; b=kA0DAAgB6iDy2pc3iXMByyZiAGXX33qgXiKs52iOO7n6pVXNtVRfI2LqesyAzIG4LQPFSQrQg YkCMwQAAQgAHRYhBEtCqM8H8pnVVJd+7+og8tqXN4lzBQJl1996AAoJEOog8tqXN4lzcgcP/RA9 yncbudnYTuI5fcR9XKLiKeF/AgXPHMuLJ13F5IEjj8Fwpt0S6UF/QLCEQWav3/m0T4BkGcY4WmA LmL0wlkmwtXhrlP+wx8aL4/OYub2A3Ch8RoEmhnMsr5Sjs2GLSSidAnspuDNP9ZofgKcf/v/2nq /cO9cc6TWuE5wX450gDuKFBhKrxMfSz0sr16vCq2OHb+MimO+bJNc+zI88Wns0XJb/HdDzfjtoy mIVbG5Ymmi9+h58mlppLVEzP3O3vM9ikhcMwvnOoVeyPfkWRHfHrAeyW5m4glRGuVsdfpkECuTM n372NxwhQYgqGWpKAbKRJku2+iil1dPSEHNb4j7CdIU8sHK8u4GBbA+BMR429s5qfVoZK68Hfa3 RoYwq8aQPTzA6ZzOF2Zzr1f3hLmFcnf8M3XyxgYRPeeac9djTgRx2ZbEZ5XheXrh5wXvmouViwk Ro+BxnurYavFTk6UTIoHGnl+EfQForaD/6PifME0MQhiL5u+hEMHKbZeorziRZb2cxXYl4QiE4a hwvGk4OFPpuObyFaqqUVS+dnDba8LtZCXzYujpW+30zmW6rRRIDpyonBgynQzabA44370eNmA8B jp7Sh9L9cnhnkIzBNTEiX2IchAe6eJSESBl+Br98iB9Em2yAPchWkz6aO6i9kKZsMzSiaKgkdGF A4HPv
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/context.c b/security/selinux/ss/context.c
index 38bc0aa524a6..e39990f494dd 100644
--- a/security/selinux/ss/context.c
+++ b/security/selinux/ss/context.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Implementations of the security context functions.
  *
-- 
2.43.2

