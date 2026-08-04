Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B062C0296
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846356; cv=none; b=ZoM9m0MKhtsw1U5D4o2qvO4+NPDQSyLUcORdCU6G7BIGVoCsyEj0FzYzZjMsbL2ZVHo+g87LFPDCA1oOOj2oDFnGzenimj6nQm9g2te8vz3ZcMQkjBW7pdxtDBfS/j1Z4V6JbqR+7sqs7EoAbki/KsSm26torwK+1QmWv/+4xtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846356; c=relaxed/simple;
	bh=nZF5/UDTIoK6uxGP0iCPCUm0YBOi44AN2idGKTA4Haw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5jJvRckMaT1IXeJ40MZpCn228y5Fy7FOv9cKTx09ZL8sR3yi/nI+kbOv36bGk5lvpY66BjqpBIpkDIIyaYcqFeaxg1pWNs7OnY3xirUywDoD8NXTUBN+OJroY0mkYN6TpBrccgiDWRtqRuV1GlobCjpbBPDmce+rrtGafXuVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFWGu/t6; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFWGu/t6"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f18d92172aso46205006d6.2
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785846354; x=1786451154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jU4xcYXuyMQF+TKYk2SDvXm6lqjMO3aNS6W77ak9VS4=;
        b=EFWGu/t6Sc5pJbwAFmuU5VQc/CHN6mc0wrvtDreOJY4xkMRioQaPlTH8FkC6Io4IqC
         2gFDVq5Q//OLGsvsF15g0oPtt87HqId2OMdXkA7HbPmKZq/slZ9B1FIBTf5nMcJa2qLJ
         PaQo9FIrOxMdmVfFCSKX/fynslqlgjl7k0/VOBcE9JuCvGWo9FtkCPbMYxJRo31DBZig
         ULh41c2Z2dgGaImYxe7+Vrm5IBNDzw97HRFcadGyTIAnFj+9FzE0Nkkl1ukg9omcpxsS
         ZZmqFHD29L+SUB2UXZnvu4C5I4hZZmOgxG1D+Sd9ezkrOOvq0RsiFBJR5HTAL7X7LIor
         ctoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785846354; x=1786451154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jU4xcYXuyMQF+TKYk2SDvXm6lqjMO3aNS6W77ak9VS4=;
        b=AiRxqzJ3ncje9HUGzDazCQVaq7/sxs0FA+35hk2l3gvzAMItFjAhmW3w1Am/7u5HXG
         qbASzw6Dydr8ChK7CV4npFNRZNj+4IgJ8UIjDJrPVgLq6I+MkjGQjYRsOPwhz4zzmXbb
         EzC+dYwyjiLkKzTX+H99KfwAClRl2E1n9AyRQGCkOSVzP7p0Lsv/EhsZkanCHFsekcve
         M41kX04kx6TnxjfyeTE0+6bgx+mVETNmDQQVx2a0jU+QBgn1XHBrY/voFhC3mqbuZrun
         HuB981tMDwUR84MKs3o6Es3jT/Z23J7iL7ZVdN6n+PzNSL/UpDQySkhyA/YSvFSgkUZ9
         gzIA==
X-Gm-Message-State: AOJu0Yx8vRHMK2TIQvUQHfmIZJvS6mSw+3ll1Fid2sVEQ6+DK30gyJ3t
	24S26XBv7F1PmfQBm6ncf13P3ewKYkDXky4CvcYmlwhg7PzB1wlDDdR/KlEqHw==
X-Gm-Gg: AR+sD11ojDzbNHJGWLrvprHSDDzz6kh+EcW967UFcmdM17U3E4Ioc8q9g8ZBfIHzYUB
	nsMlz/bqumnj29zwnlgo3+J43mCcOnACSW2nCRyt+hZvLsRX1G+uvbRMDPlMQD5tKHksWoY5Elf
	aXbaI6xWnxsnwsslLgt/30AoRUtjACNRMxeQhuguvCrdoVcXvxhjDqRQbsJh8zDZcK9Z2MlC+ql
	OfiZYrdHJO24ObVmVoSQ9TfIm2lv0LIsYyQCV39kIRtw4TgBVvZXn0k9LZa4folgT4rX64cd32k
	h7SbVI2JwA0W19PuKC/1L1bAjKAks7M008I3N7TKLTZihyEePmwF7tzMO3MBrsT6YlzWNbjctGz
	+UYTzUTv0UdxOT8wahEJV1MD5Y0as/ceGFAlZnZo8rqxrtomYeYRzio++FNb5vykbeenBYrg/7w
	BG6vVKClQHgUDK8SdFps6QJDfOyYqcyL0JsKubbs3L68/tqdGk4e6Y60BsITDrkq3kFGwT8aWbA
	I0Uhckfrry0/6c/KB8QpfTtVi//xA07zc2iM+ud6r2P9SwwCNKznlcdrkVyZsOG
X-Received: by 2002:a05:6214:130b:b0:8ef:1fc9:935b with SMTP id 6a1803df08f44-908495c4e38mr297909066d6.12.1785846353955;
        Tue, 04 Aug 2026 05:25:53 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435b6adesm97610006d6.24.2026.08.04.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:25:53 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] .github/workflows/cifuzz.yml: update branch and upload-artifact
Date: Tue,  4 Aug 2026 08:25:06 -0400
Message-ID: <20260804122505.54855-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cifuzz workflow was still using the old master branch,
which was recently deleted. Switch it to the main branch.
It was also using upload-artifactv3 which is no longer
supported. Update to v4.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 updates the upload-artifact action version too.

 .github/workflows/cifuzz.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/cifuzz.yml b/.github/workflows/cifuzz.yml
index c4e592c5..c3b57e27 100644
--- a/.github/workflows/cifuzz.yml
+++ b/.github/workflows/cifuzz.yml
@@ -3,10 +3,10 @@ name: CIFuzz
 on:
   push:
     branches:
-      - master
+      - main
   pull_request:
     branches:
-      - master
+      - main
 jobs:
   Fuzzing:
     runs-on: ubuntu-latest
@@ -33,7 +33,7 @@ jobs:
           report-unreproducible-crashes: true
           sanitizer: ${{ matrix.sanitizer }}
       - name: Upload Crash
-        uses: actions/upload-artifact@v3
+        uses: actions/upload-artifact@v4
         if: failure() && steps.build.outcome == 'success'
         with:
           name: ${{ matrix.sanitizer }}-artifacts
-- 
2.55.0

