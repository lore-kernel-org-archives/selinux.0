Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FEA1FAF10
	for <selinux@vger.kernel.org>; Thu, 24 Oct 2024 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794271; cv=none; b=ks+h1K8UXpBu3hOq7qUNhRNt7c9CwwhfAc8PP9sOuNvwjZPRQcWTaoNolFmrmjEizTDzcgD/owgIRrmb7ETI/xueYUtJkRbAyIVkfS3O09EPj1B3nyDvyySHNeGiVN0oc8S8afbxstjg4JEcg0dDhW0h92Xh6xkmF47dNzh1Xmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794271; c=relaxed/simple;
	bh=M9QxGTV7VT6bHq601Eei0bwU4zdH1xECC7gaaWFRF8Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RGB+jfvPiD5721ea3wGBZjWIZpI2pBug44IvW7Yz9z/5596zzAaEdVjfs1CcCVwOYgoyK2RW5rhBzOdIy4Pq06/CnekTt+3ho1haUn3mBQNmPyjf92cXdzX3OSuntT386rfFBeX89yWn21AH1NgnYOu41yEKXC9KJTra4wGecU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ESFJvZTJ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ESFJvZTJ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b153047b29so80740085a.3
        for <selinux@vger.kernel.org>; Thu, 24 Oct 2024 11:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729794266; x=1730399066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qP9TPe1+2v/YXjw/8ZCJNYcN5tXynTk98mC/yDx5Ot0=;
        b=ESFJvZTJQcGYN88YJJhyAhU4Mh5IZwBnUt/fSsiKOjPOeUfG0h/UgC0hVG0lVyFQsu
         bwSRNxrG92HiPmHygYNKa/rSnyq/WQXgkfGkx7D9oeezDVHHQgb8/anfmADM/3ea6zA1
         PRJ3zc2V1y3AjcTejbiWU2Oenc8FtrzomuarCoW4vBL1J1aZU0B55hQR4rrKtP1Ysds2
         S6jjj+eiuBdn+LDrdfDB4lfQ0iSMuVail4hFrrpy4fQn1z1UFHYkFn5JTK2DCN9QUfpg
         ksRkChXQQ9VRGG/S2P4cGf9F2wwaNB51rAMy4sbP0LcvoZPeqALm5J1V1J8elYfi3J3O
         +vUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794266; x=1730399066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qP9TPe1+2v/YXjw/8ZCJNYcN5tXynTk98mC/yDx5Ot0=;
        b=qTxT9COdhHVOAtQ46mnP62BuVtOuDxVgaepc/Od3IH+1t7HqnPOKh7gCMwKXutN0Ym
         lcw+Le6mDqBGmCB5RmcF5Oys7od8XeWzut32E0zTt4cfs7+gX1IxxC8l5JB90/dtIM3z
         L5JLyhNRGBRIO/CbD5nRP/a0OSApH6TCSvI7xScMUrpPVscqn8zE2bsNL5K+Kx4jLrCO
         9+aVlc8gpj+uv9Y0RQu+8tsipf7qi/rtm0lGfahDEOkwHiaeQ/frme2TzcXb79o89/UV
         sNDUHofDpZ8HoRerbmlHSmMZTayE48gxhHri5+48sNmINxDMNnHAAYOvQETGd+w5qngK
         LqUQ==
X-Gm-Message-State: AOJu0YyloCHZ/s2XqYuA/9kWtJYLqi+Eh6ElW5eXpWdHOpP4werid3Yo
	J5ecLIT70nxiC7CxEe/dEkUO/8pTmeTTHI9oWgN09R/fTkBGne3GoFz2TA2hTWJnf1TbGTGVhmM
	=
X-Google-Smtp-Source: AGHT+IEgOcUbHLJLQfjZQC5E/9xZU09GoNrjmOwabRY9xWSkNeuhwQL0knI3rdmHlGpA7MjnRQSP6Q==
X-Received: by 2002:a05:6214:390c:b0:6cb:2456:537 with SMTP id 6a1803df08f44-6d08f7827d2mr28910876d6.29.1729794265691;
        Thu, 24 Oct 2024 11:24:25 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009ecb61sm52368186d6.127.2024.10.24.11.24.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:24:25 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/3] check-syntax: update arguments for astyle v3.2 (possibly earlier)
Date: Thu, 24 Oct 2024 14:24:22 -0400
Message-ID: <20241024182424.138616-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the astyle arguments in tools/check-syntax to work with modern
version of astyle.

It is worth mentioning that astyle v3.6.3 appears to have a problem
with aligning/indenting continuation lines, preferring blind
indentation over alignment.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tools/check-syntax | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/check-syntax b/tools/check-syntax
index 2115a7960dd5..2775eb46c6c4 100755
--- a/tools/check-syntax
+++ b/tools/check-syntax
@@ -57,10 +57,9 @@ function tool_c_style() {
 	astyle --options=none --lineend=linux --mode=c \
 		--style=linux \
 		--indent=force-tab=8 \
-		--indent-preprocessor \
 		--indent-col1-comments \
 		--min-conditional-indent=0 \
-		--max-instatement-indent=80 \
+		--max-continuation-indent=80 \
 		--pad-oper \
 		--align-pointer=name \
 		--align-reference=name \
-- 
2.47.0

