Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468E37BE8D
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195052; cv=none; b=olOdZAQk1xN90zTuItd0CNxNB6GGH1POjW1K42oaBxJec+vvEgYPQdwZgxC+aXrajTZ4F1cHlLToz0aiie1luZ6t2wiEw9AeTSfkBfweBmfS3D6zVM1MCo870s+o0Iine//FtvpiQho8Y/LBm0sBfIHoOEBuElKdEjh2Xj1PUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195052; c=relaxed/simple;
	bh=PqRaPrXSwWA175D0ryd6i5hSWH5tUaAvGCDB82+LQzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJ+rVo6GpBQ7CKgcRSUOgAO/DRVtxYNRQOIeyHNKvfef+lRsp0019jmBSEb8sObCglH8Z1IqC26P3BKqgxdBpZBuwpLa63nWKti9SCfc28LKmXyUMznODuJFPZQaqlZf2giouI1yIhRK2sheLw94ZRAh79bsvjZ2bMVeo2Kip98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjOz4oZ3; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjOz4oZ3"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52fa223df07so30711451cf.3
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788195050; x=1788799850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BVmxRKFjyz8/FhMR8lQigg8HuCBZII99k+VSLwnMGus=;
        b=HjOz4oZ3Vy0YWDK0Btc6G6u5k3cLbTt1c1KJz3t0HYUKa7hv8zB1E5gZK1znKGylzC
         Drnfdk+phRWcHTg4DYUcgGSIu/pKR9XwAoUeqI7dIumV4py4uETQh2G/iynnvis7JAhJ
         dTKZ81oL34XziMOaw8YlrVVSohAVKw0SmXdodKcGnqPJk/dtZrKFEjQwuFhzYD+8IC5o
         7t1Oundg5+/jBo1NGdGJ6/y+hkYsqp71sTrIIoiVtEC50srwNfrTyf1cCgI1pFiSWUPf
         Dyd3wQIVcHMzSLgLtOe1Q3CH4BPtYWrnFjQawinrQaA7wrVT/Bgs5rj1Fd6C5/af2RZ3
         PhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788195050; x=1788799850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BVmxRKFjyz8/FhMR8lQigg8HuCBZII99k+VSLwnMGus=;
        b=Jg2XKrh5NFxE2m00jCTNSLVoBmnXHkt/uvPd9e8P+TFc5Gij+/LLxTxyYGcr2hLRuz
         C0j5vfABsZ3hRBG6sOkN/1Cj8EaAUjRK5CFNya95PdNb8fjNciynVc9Mbeypn8uAXG+f
         bik+h0YytCLY0DXoRoPSQJLdDf6a8xzNYuKzpIjMc3yGldSHmrBvLBfpl/QYr+V2XxQH
         ukZc0ricruG6KNQMjfdYjEMg9Cij0zPqqRcCv51hyYmqMZuxGL2ZDy4y9QkxaaX/93pW
         lgrT1phzptCXQbmmC2tYEmms1YdboBszf5iB3UZz6oC/tckNrNNMPGRKpVvKEx6DgqiK
         L0gw==
X-Gm-Message-State: AFuF++kuxT61X34csjLThvf51IfAc7GY+ygNFLN3oua5bZ5lpSsE3QYt
	sRnCA0HAA9Qefzapbdt808uOobFgpLG7JgKn9EWkArT0sLm6RtIbubNfcksokQ==
X-Gm-Gg: AR+sD10ye5z8gayLFCWcboh2IMSa3ASWMHDGZDJI5b+FRTjK6WICiTa0npP6vF6tryI
	6ZehhxYvcbI3T9f0UmumFh3PANU6zFUr/m4b+r38svNbz2nKWpPLIdvvwSzM/niOQcFE8C5NHol
	EkNKXxSgt9q7gIOvcyJ4/VYj4JRUpbrdogk7tbZHKkMObC6qPGsKISXONyur3DlwrIxEWCmrWF3
	1J/KG5fSWgJdELaQcOVbLQ/Ep56Gq+jRK58LEZ2FvAVNcsSwEVGw7SFJoZv0ZM4y6qn3xg6vw8M
	BMwS1xadI/FNAfNY9L9wjUmqN8UIKYRHTQJRzZFVAFCIWKqhggsoZBgkAn9BMyEk1AOVR0Tw3NE
	9OEqEv+H7Tf7zwYCyhO6g8xAWcwA1t9RE1b8jieJGNjkOoJ+pVFZSZkn30OytMZr42WETRr0nP8
	AVinJA397LfOvrDosKHL+jZn9dsOhgwwC0lyZDqZWmXgt2/ASb5+W4QcBWGuWeFmbC7m+pwLzfQ
	FQNWSYcViYDDtF5e5I0LyZvfQk/XxgQhe8pEC8CqijGsLxRVu2HrsNYbDZrJjsR
X-Received: by 2002:a05:622a:1f19:b0:52d:742b:aa58 with SMTP id d75a77b69052e-53021b7e052mr28953631cf.6.1788195049874;
        Mon, 31 Aug 2026 09:50:49 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce415902dsm91883956d6.0.2026.08.31.09.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:50:49 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	pebenito@ieee.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] .github/workflows/run_tests.yml: use a modern refpolicy release
Date: Mon, 31 Aug 2026 12:50:34 -0400
Message-ID: <20260831165034.80872-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The run_tests.yml workflow tries to download an ancient refpolicy
release for the sepolgen tests. Update to the latest release.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .github/workflows/run_tests.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index 8e9afa10..8ff1092f 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -51,7 +51,7 @@ jobs:
 
     - name: Download and install refpolicy headers for sepolgen tests
       run: |
-        curl --location --retry 10 -o refpolicy.tar.bz2 https://github.com/SELinuxProject/refpolicy/releases/download/RELEASE_2_20220520/refpolicy-2.20220520.tar.bz2
+        curl --location --retry 10 -o refpolicy.tar.bz2 https://github.com/SELinuxProject/refpolicy/releases/download/RELEASE_2_20260616/refpolicy-2.20260616.tar.bz2
         tar -xvjf refpolicy.tar.bz2
         sed -e "s,^PREFIX :=.*,PREFIX := $DESTDIR/usr," -i refpolicy/support/Makefile.devel
         sudo make -C refpolicy install-headers bare
-- 
2.55.0

