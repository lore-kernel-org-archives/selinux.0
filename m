Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59684140391
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646395; cv=none; b=H4+i990lQwN/kejJek39JAsF5HuGmPetBF6VfXKVfJDVK9y4FpK3Xu23qcu6nBSkOn3FuKADZyA7ijJjH62tGVcMUY8XS52oL7guLssJnOkPHHJyk1RPGbbm0CwhWttLsKUlcZA4IMC/dYHOhACBvwP5cnGsogcWmHyGZH4YrAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646395; c=relaxed/simple;
	bh=LpzIB/M5kt0pFeg/y3NZb7iFfRhgd2jWTZ82m5ZCYvg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfwsOBVXH8RpGHKJU9GUBP0kWIu928nYhKBC5CcQMuhiRjKRfWfaX1BQCnTQyKDH/RNuw1gBq0HIAZEEpuCVz8d2aopogH0/30yDxRWZKaKTq4CzJydBm3vqSJeLvXbe09M6dyKnTCJzWC7y3HC50C9mMrYMq3eD8gI8RSRuLCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aLTAXoQ6; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aLTAXoQ6"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68facd7ea4aso3688556d6.0
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646393; x=1709251193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+zoxJPBMxVwgusi5+ZOktMYTJ2nyVr2QNu59xKV8ow=;
        b=aLTAXoQ6lSjx4UzbYALLwJ2HGnmXtXkDycfNgX9fOp1OEfFZY+8cZmPQ75A+7JaQjP
         BkkjJ/sH5RNFxxHAV7KvB5n/romc4BurV4SJktMkjvYKaCsCvtzRIz25tcmbhFST6QRk
         SYqrP0jZxaTqmg7edpz9DpZJhbNd7JM8wd1A38mLj+TzCT1HtVp4n+G+93YJQlFZFUE5
         3b5pcix8iEREUFgtlsvc4g70FYGGJXxGttRpt83USS/AbdNaLpu5VRtIYbwqddIy3kq4
         1cuN5ZIqmxC4i7Wym0dZXECQiaFAlBNA90Nuy36U4Qq14t9nREosuiYgL25qfU+fnLF0
         asxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646393; x=1709251193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+zoxJPBMxVwgusi5+ZOktMYTJ2nyVr2QNu59xKV8ow=;
        b=RiISoP1+a86nhAvGBn3h4mWg2/9YN2wFYU8B1jf9fgpSnURoQDaFHQKS5TjqkCw0vp
         kHUer0psJq9l6j1l6bkTwWUJqSeL3QC3I9tfSQwW+Cnqgn6Dyp+5sjk/8fPChHSfPZlb
         h9dzjP3BMyCjeBz+wSpcbz5GNFcelDfTQfJkz7rG04vETEvCAF3553vEjWa2J93zVPS5
         0ct44P+1cKV29UsSIvWiaynhMaBxCdDlXlePbjJ0FB7Q0MmhH33EFtcb04OWTF2rKzqO
         eI4D8TrLvbNMhOvmpW/apNHqdYlAbV7VAoxo8vwjo/yww5sxX98LtRQilyt3GETSsd0S
         1erw==
X-Gm-Message-State: AOJu0YxiSKPtp/UfnEQ5P7BfMphOQiNLUm/HMVULWL2xaXXsYbtHcbEO
	jjT4aF+Vp67Cua/Oc1KIvY4tK3i4daalTZ1GsIZI7oUDF2mGipb1rrFLI5ZfRgGYM3a3Dm0en2o
	=
X-Google-Smtp-Source: AGHT+IE/R4HKaLpAzBzbx/wea8NrYnUJNwMYJNwqq3blCCTt32rv9+jsGJ2+WtvEQzz2CAOt3yD3BQ==
X-Received: by 2002:a05:6214:d82:b0:68f:42b8:5fb2 with SMTP id e2-20020a0562140d8200b0068f42b85fb2mr971433qve.21.1708646393031;
        Thu, 22 Feb 2024 15:59:53 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id og15-20020a056214428f00b0068f8a21a065sm4293178qvb.13.2024.02.22.15.59.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:52 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 21/21] selinux: fix style issues in security/selinux/ss/symtab.c
Date: Thu, 22 Feb 2024 18:52:39 -0500
Message-ID: <20240222235708.386652-44-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=paul@paul-moore.com; h=from:subject; bh=LpzIB/M5kt0pFeg/y3NZb7iFfRhgd2jWTZ82m5ZCYvg=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl19/WCIAStW31SqmgSzhfahX+JWMqZ1EJSEH5f 0DhaW54SpaJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdff1gAKCRDqIPLalzeJ cyW2D/9Mtj0ETvxeu5nCtZ3JI+e8uRvPpQBEK0rnRH7pt9ORbWHxTSjkF3nhTU7m9Lk47il7iyu +4M7Jnig8iDairG7EC93sQYUZYGeHZZbWjkTR9TwKUtTQqnaxe0UWlctCKr07Vvez2A3S9l7vKV kjvjEUTfHflzUnjCyPLxddYHFmN71nZsNzNateabvgVynW29rMmccLuWgseRd6Z1nCgW22sK/E7 f7gef/BSVksE7Qpy/yVkrSX7zEO7z8s1VMIhc2c3AtPqaEMURJNL20BCuAQbQqpZysQPRangLrj dCI29/+dKRQBo/HuTZa4507B7mj+u73/8tWR7J1B/d8MZPIcMpChNKUPz5X2f9Vpb3muTSjbduW q/65q5S89mUmStiFewArDpK3lrU5uVUC8XlXWDFZvyGEnQhLUl/S8nxcNCun/B2XgpelxffJPlD obI49rwRN9hP93Fn7q5VXw43AVyp+9GVBtftff5hip7r2RGpHTqkkQCYKOVxYrzoUdddsFcrJia hXax/fnVw+evFs05GIuKx014QjYuhbLAAeHtGdaEzFYdwNcw8bsruYObnc2cV36RL9MC9hlQI5C QlbxfrQAhAyVsfBvz8FdkrAlLKfJ6LvsiZBHP1J6ltnT5VvVWP6hK0KjrUaGxF5JlcDx2Ilx+zA IR4s/qNE38aJ+rA==
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
 security/selinux/ss/symtab.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index 43d7f0319ccd..c04f8d447873 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -4,6 +4,7 @@
  *
  * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
+
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
@@ -19,7 +20,8 @@ static unsigned int symhash(const void *key)
 	keyp = key;
 	size = strlen(keyp);
 	for (p = keyp; (p - keyp) < size; p++)
-		val = (val << 4 | (val >> (8*sizeof(unsigned int)-4))) ^ (*p);
+		val = (val << 4 | (val >> (8 * sizeof(unsigned int) - 4))) ^
+		      (*p);
 	return val;
 }
 
-- 
2.43.2

