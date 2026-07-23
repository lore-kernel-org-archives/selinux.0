Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4597D242D7B
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787847; cv=none; b=txy8pMIIt1v/lx9/u7SifK35l2+i4L+P4r0wf9GspVPBfnHSPtu6cdwfAvIGeDuW/wCxvZkGmudW8IXZ+uTp50ZsftoUPqRI/GGrQTcDedloq9Y4U6tFsTxUf+uX0+97JJvECOT2eX6rvd3VHj58eW8KaPWxzYhDaLieB0zRWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787847; c=relaxed/simple;
	bh=Vk58mGpuqGJLJazJUwTBWY06P8DC3uOisQe+6wxosnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bf+Z79BxXMFDvRzLJYcXNgiG0aRUOshDcYiIL4bnMRmsILos0oKjhW4thf8akwYSFIuTq4pu9NO32tH8OmLZP5OrNWIjOBdJQm8yl6lOBpaO30cT11860eS1RcD2h6pra/BxRBiv7671cb+lcPg0QWl8Ihxb4ZZaoGZEe8Um4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com; spf=none smtp.mailfrom=perfinion.com; dkim=pass (2048-bit key) header.d=perfinion-com.20251104.gappssmtp.com header.i=@perfinion-com.20251104.gappssmtp.com header.b=yImMF9+b; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=perfinion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20251104.gappssmtp.com header.i=@perfinion-com.20251104.gappssmtp.com header.b="yImMF9+b"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so3113705ad.1
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2026 23:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20251104.gappssmtp.com; s=20251104; t=1784787844; x=1785392644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5OvQEf8gVnlaBCCOOAIOwAO1p8C6qxULDuRb7Z2BVYI=;
        b=yImMF9+bOYSiQSPdSgFCxVwnVPeOHdtXlXINqW0iyy4BfEsn5RicFPZ3G7AHzfB5sB
         DzFTQ2CcrTt7lIT4Q6X+Bd58p8tcBYpkpTUjl44EauOogF9R4kuBGv/N5JvI5pSoL8Ss
         pWie82EGy+/Agg/L2pI67Xk5nx2EVVOr0I5t9kVVwogGgBdpiDnG6SV7fN6pOwRLuIA3
         0HUrZTkFJ0YDviyVK1rnCMIejjYeFjyC28b9YslJDp62dxOd6zz7jH7XDalT0G94pN1J
         XNN2kjG3AIbQNk8JZTPfoO8JE0/QrbqQttCP4zvV0Yb8MLKiMUmhcFK11jJnBQrahpvV
         accA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784787844; x=1785392644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5OvQEf8gVnlaBCCOOAIOwAO1p8C6qxULDuRb7Z2BVYI=;
        b=PoL0HJ8E7V23xSkUdsmwjNf7X3iLsLq6E1n7XZbMZ70GuvY+tqIAWqOKXKdWvW+Jig
         2lx6189vjBqvX62zrQQZG2tpnJ4hpygmnO77KS3enUMa99ZVSrX8OQHa4dpjZ/Hq92zP
         zXr31BOZ/L0xE1fWv5MfIzpuXgemlYie25QzfWEtbZ9CJK9rEbqm88ZA/Jr0VmVKkIre
         4TU7Z4iF0+825YfEkOBEpynT+4X43ligfSMizD2QUp3XlOor2Y/+80jU3AOJxx4wttXr
         G+hrs7StARHKeO6kPHb0a3AQOlxSScxF8BzhclaE/e86QpJtExE+tSt+OSq6T7YcLMxv
         9I9Q==
X-Gm-Message-State: AOJu0YzPNXV8creTxhSDMZ5xQizWaHJFL66PI1BCyzKaU09ENsNwOWZo
	PZjVrWwb6UFj3qqdv17qTp+BnTjusMThuTTdC39Z9oLasTIvQpNPiip3vKoxTwfKcnAFhivXkUd
	q3i4R
X-Gm-Gg: AR+sD12sWQ4KAbJabsKy80Mirjx7QcLECSOQ9kFjoWRh8O/SKhkiHX50joQZn1688U3
	tL1U+d/puLlpBp/zQ1d3f0PX1lwNdoa9wpqzNTBnx171BV4yUJz6B7M+2ma7NPkb8kNmA+cVP8f
	t1iNvDG1HMxtxQxqpftBqXP6giCJHdALJD343BoowC7Ox+9GzeRkGFurMBADtszab1U7t3/YWlu
	bafKyUu19e2UQm4CNbORVyPDFiB6Admin8mImXYrzP9nxQsI5HO2Ec8jrRRy38Vw726o1grNxi8
	OMDMHbAmRCWBWFlNd3AaY+kXcBKwnu8NM+YHiOnwoGenMZevwopljS9Vcv2B5bO+rx0KhmnoQWo
	m3B6o31qp4RDpn7CtHXPCesNYNw93QJ37P0ChqcGhPgNcq0j88isdeNzDF6J7bjvMuYDFQG8bdy
	a4vJ3SWEI3w7rZLzqEq2u5oerLg1/kxj7Z33reBxk=
X-Received: by 2002:a17:902:cf42:b0:2c9:d298:6c06 with SMTP id d9443c01a7336-2cfa7091618mr23837345ad.25.1784787843685;
        Wed, 22 Jul 2026 23:24:03 -0700 (PDT)
Received: from localhost (142-254-17-81.fiber.dynamic.sonic.net. [142.254.17.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e088d3fsm16494643eec.25.2026.07.22.23.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:24:03 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@vger.kernel.org
Cc: Jason Zaman <jason@perfinion.com>
Subject: [PATCH 2/3] ci: Drop circleci config
Date: Wed, 22 Jul 2026 23:23:54 -0700
Message-ID: <20260723062355.3096648-2-jason@perfinion.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723062355.3096648-1-jason@perfinion.com>
References: <20260723062355.3096648-1-jason@perfinion.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have not used circleci in many years, the configs are very out of
date compared to the github actions so need to get cleaned up.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 .circleci/config.yml | 41 -----------------------------------------
 1 file changed, 41 deletions(-)
 delete mode 100644 .circleci/config.yml

diff --git a/.circleci/config.yml b/.circleci/config.yml
deleted file mode 100644
index a75d34c2..00000000
--- a/.circleci/config.yml
+++ /dev/null
@@ -1,41 +0,0 @@
-# Configuration file for https://circleci.com/
-
-version: 2
-
-jobs:
-  build:
-    docker:
-      # Use a Python image from https://hub.docker.com/r/circleci/python/tags/
-      - image: circleci/python:3.6
-
-    steps:
-    - checkout
-
-    # Install dependencies
-    - run: sudo apt-get update -qq
-    - run: sudo apt-get install -qq bison clang clang-tools flex gawk gettext libaudit-dev libcap-dev libcap-ng-dev libcunit1-dev libdbus-glib-1-dev libpcre2-dev python3-dev python-dev ruby-dev swig xmlto
-
-    - run:
-        name: Setup environment variables
-        command: |
-          echo 'export DESTDIR=$HOME/destdir' >> "$BASH_ENV"
-          echo 'export IS_CIRCLE_CI=1' >> "$BASH_ENV"
-
-    # Download and install refpolicy headers for sepolgen tests
-    - run:
-        name: Download refpolicy Makefile
-        command: |
-          curl --location --retry 10 -o refpolicy.tar.bz2 https://github.com/SELinuxProject/refpolicy/releases/download/RELEASE_2_20180701/refpolicy-2.20180701.tar.bz2
-          tar -xvjf refpolicy.tar.bz2
-          sed -e "s,^PREFIX :=.*,PREFIX := $DESTDIR/usr," -i refpolicy/support/Makefile.devel
-          sudo make -C refpolicy install-headers
-          sudo mkdir -p /etc/selinux
-          echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
-          echo 'SELINUX_DEVEL_PATH = /usr/share/selinux/refpolicy' | sudo tee /etc/selinux/sepolgen.conf
-          sed -e "s,\"\(/usr/bin/[cs]\),\"$DESTDIR\1," -i python/sepolgen/src/sepolgen/module.py
-
-    # Run clang's scan-build and store the result as artifacts
-    - run: ./scripts/run-scan-build
-    - store_artifacts:
-        path: scripts/output-scan-build
-        destination: output-scan-build
-- 
2.54.0

