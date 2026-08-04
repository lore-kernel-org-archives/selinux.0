Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304F3EC811
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868769; cv=none; b=hw+u929uP/wCLLhnJyeH51JAbD0GIFMRyrX24eZ5seW3wd48eAm7TT0Le2ArIAsmu6vm/olonwHjuvKBbqeaQmKzlb3RNx9ahJR0Vavy3g5sKx421EIH1jREU3tOTO0okoulBWLbCUO7moklUa6H17U3PftD/7ttvagiBgwIP/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868769; c=relaxed/simple;
	bh=d/zHIvkHy1S15U0YTF0fbEEONZBgFr8Ribe9h6MSaO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQ5lCbTjY+0IStGrm7vJN177OaSoWA/dE0vVRKWw6bJ3/aKNhIJkVMEDKrawuT4DPsHhj9/GGbVyKT4tb46oMlFPYT+BZQyqIYrXgN8qJgMMH4RHI4GJe8aLhHVlKU9HjtOM0wCNlLBUiigucQg6U3A+eFfW93jSOZ7t/WHQlTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/KPa1fQ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/KPa1fQ"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-902fc790cd5so886246d6.1
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 11:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868767; x=1786473567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=66ZemN/OFrh5r/cxcF4sPmKB2fWy2nVTZrz5qDLKWtE=;
        b=H/KPa1fQ7H6dd1RGZcLZqizS+1LABHxHZFGHfjaOR2d9YJY9ZMfLt5Y8aiZE0rbRBK
         TST8u4eGC2XndbtlvFxeVTErxv1mZwWimR6TQ+gCdlkfzX6YJxVWF50R5xvT8XrcdG7T
         1milsnow/hRJxzU/dYsKu0cLitj8j3f7/SQXnVyBpGT4m6P/G0yFDSwBgbU0RQH310lK
         qVEN0X3axk5sstmZ8/uivjZ3ERaajItZRqT71VB47lcke7In664RNlXZFpOzP1xvAirI
         Pbhs2r5z2jvsmjr02v0wXs6RlHJNUHjc5iuTYaS5HfNtW6lSSY07QifjWuda0zkRsoUp
         ZQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868767; x=1786473567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=66ZemN/OFrh5r/cxcF4sPmKB2fWy2nVTZrz5qDLKWtE=;
        b=qgpd3oJand6dkF6QUGGLEOKk+CfFC3sr1OJ/ZasMsv838L+RmOntbQzj8KQjun8Fd5
         V9QYPPGj8gmCvtFtKp6Ebv4BvYTGk7m0KVSb3zLq3mOBew9h8dcz1Yfa/S/8uKN60z7f
         aaIL3tSXuPhR34/cXnk1SvUJQ3VoEDvZlnqro9ebS4gVlrMwv1SCbv08v0pEOqmzPWiY
         /qDStAbbWX7IRroHAdGojVhBnUZfFVuRZ4o+DmUErkSoUMbt/Ek8Ajk78nvfsBIdxVOv
         xiv4tBAOVVsg4iH+3ic2BoC7UF1/d6JxxlFY9kscfs8Q+/Mw8PqgILT18oOyo2Uuqa3p
         ewLw==
X-Gm-Message-State: AOJu0YxV3r2BrnQYElitYqv1xNzobXFgsXG7QiW8apA93OgaJ8zi4/iC
	2V0TLu2po8WJLqcAgHu9b7z5A97VqBqi6tyPJ2R6KeTBH6KdDsnTZ4wRQEpDng==
X-Gm-Gg: AR+sD13P4feRRx41SbvTbhcF/z2ltKjE397Uz+M4uV/lx+H2fI8y+TGdGR00CLxtrdV
	BgIRimWjEiVUPGfJuXh88+t7AfxvzG79HvXXO4PeGgyBoMV4B4wFfUJsnFKbRrvX9WgC0dtyhor
	Hco8/HI7BC8Khat+8tH5GmFx6p+il/LBIa+bqpdEg2gqx532PbkbYhVbC2vcC5Li4Ja+oSNaDdY
	EYYtKM2YFDjc7SFFcqizuJRraaEkvVQypaQuoNAen6wWLn4f8lGVJePfESRXoGnZi2VW3vENuhL
	5h4vZasdZEE9/0VTf4OHOqI1fin1NMTKvy1Ih0jyCcI4rqZmTcWfvmGZTZRqPExX01Ue9uGx2Po
	uLLC9oSmQKODSAwWM+D+gADRvxmvKRjpZSuFbmwHb2zvCpA+BeJUHpgWvoBUi60TXeB7qQsTm1S
	XOD+a5TfuEb6303lP+8PEDjyBesiyv9njIxRwfagnP4NP8P5Lgp9CE2ipnJXbvvdjZm+yOZgdaO
	vSKvKL7CAuRTUXWzOAJxGEf2R+xcqQw9Cg3ou2eYklbm1WDDLcnsYaz15iQbJ/3
X-Received: by 2002:a05:6214:4302:b0:8ef:cfdb:29ad with SMTP id 6a1803df08f44-908810845dcmr17457036d6.2.1785868766773;
        Tue, 04 Aug 2026 11:39:26 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ffbcce4sm7435186d6.13.2026.08.04.11.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:39:26 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] .github/workflows/tf_testsuite.yml: only run on SELinuxProject/selinux
Date: Tue,  4 Aug 2026 14:39:11 -0400
Message-ID: <20260804183911.23819-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only try to run the testfarm tests on SELinuxProject/selinux; anything
else will fail due to lacking access to the API key.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .github/workflows/tf_testsuite.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.github/workflows/tf_testsuite.yml b/.github/workflows/tf_testsuite.yml
index 7e3993d3..48484496 100644
--- a/.github/workflows/tf_testsuite.yml
+++ b/.github/workflows/tf_testsuite.yml
@@ -5,6 +5,7 @@ on: [push, pull_request]
 jobs:
   tf_testsuite:
     runs-on: ubuntu-latest
+    if: github.repository == 'SELinuxProject/selinux'
     strategy:
       fail-fast: false
       matrix:
-- 
2.55.0

