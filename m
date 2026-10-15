Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32928231A23
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 05:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043385; cv=none; b=HXLVrbg/z2LjNmdYzlJrSNV2e8860/wI0DLtu8M8MO8o82BLzFJWBq9j/SJWXIWc330E358FNIBKNVXStAMg5A+57WzuIlvHGkPXBly9zqK3a0rZf3iOP+5Sd1a7oIwl5clX+8kVuYDlWjgeOnQqrsnWRsSJsWt5urjIVkAeP4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043385; c=relaxed/simple;
	bh=0pjXUwO+KMLVEaUIxtTMhctpAlqqq8gZCjbw8kmKRQo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FyPGX9/eQN4q9OzuV498VWG3/o6+KZ86iWLM2tf7fc0D1qj2Hz7dp3EWWjaWRKMJinZE+tU33wyme+gv6JPLRZQK+dHdnmIN+pzJlBXf3i6gs+Lt0hL462PmSZM7nvNMQqCnKwwYGo/H/Jqc6XJAW3ZBwEGtFJsYU6fKNZpaL7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amgJozWs; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amgJozWs"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so35591f8f.1
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 22:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043382; x=1792648182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZToUedNxhh9aWR1+3eve/YREqzKQP3A6cR3Un1gFpWk=;
        b=amgJozWsjBcGhp+eaUt1O2x/nWlmZvtUlkEMcrilwmd1czpDacTkv7TSIprbUBI5D8
         riSLuoOMQM1wyWh0v4DZhsqlI7zLO/BZ0SWXeNtYOVlijlH+gLKrhjBJlZL+uatT6vwV
         pImgpJDzYpt4rIunG1/1J9AnhnTw4P/SnF3p0HDwjHDuicfayzstJpOjHN/7h21gFT23
         9XWRyE5FSeXtUg2l9GdkX3ScYPwvGvxoxVMGSPCEq4QsTslyO3vlSuBl8SD0XoIk0Ay7
         5QWDtu8im6gYnlLqlPCZKdiRbzv6tLOTOruAoEPs6nOJFsrf0sriF0S8AkweRO7swTns
         FeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043382; x=1792648182;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZToUedNxhh9aWR1+3eve/YREqzKQP3A6cR3Un1gFpWk=;
        b=otVNxaiQvFSTvlBDx7YImMHONg51T1yi26eYXk9af6aG4Fx1hvF6wuJgy6PhIs9LMe
         4HyZOmNmuMD4eGkWlPfXbU0kQeM8gVE4bPKDq6nTigrnPd646Y6O1ikPZQ+x/aN1Hm0t
         uvqOy6pK+LVaYyLjWCF0Txpy+FtDPOfeG+7NDHlOt/FEScN/5ueMA+ng1DhJOeWidtu0
         V6Xki2cvDSSk38BD3DDD0R5w5UBTFZ9vhxigcXAkdlydvoC1UShZvA3t01XRmUsU+OPS
         AI4gLlSroh0h+VR+ffW0RY53XQljeOKlzi2Wn9+c9615ZPSVP2n9MelSUMxs8st9FF5c
         eRdg==
X-Gm-Message-State: AFq9FYImoz2eG5mX44f3iWbOd9tdHE1YCs8+RLMt7hnAFd7Frxmrp4Yz
	FqpccYLrNj/Vlef73WdLrf8WJJfDbdwhrKkKdlCykLerxKvzal6lKPVpGlExZw==
X-Gm-Gg: AYBFou178Iawwlno5DFc/9b6T3A5k9YHlCDPU18+/4WuPWYP7yNgL4R/tXEmcuhzGY3
	pNCKOCZTtDVa8MKYyfupbJNppNAFdBEhmMBojZxfASDL3zfhEu0JKvheWo6bzEqeoaGUJOiPMNa
	jiU0JHHKMfOaQUO6+BksWENcirV0sB7XUAKdmdhyPJyKOnpr2Hqu5nZMLcFEJPUJOaSZXLJaDrE
	b9FUOdBaBEeuoOn0JJ4Cl8qOn7IXjx2ZIbXBqVWAcG6crjFxDHQYi0Erv3AfO+b6WVVrj9vJ1uh
	IExE1tVgssi/xYAl93E4uLJdHfByK0cKFfW1GQ89W9v6uEkxiEc5V6+gel2Ff4W1SXQ+OFnHiiR
	Xw4uRzaQNFXjxD/xhHIHvRc4QI5/P4FoOVlQpvKggWhz0+IOD4B5ReNCR8soW/yBPzmDCDeEvmY
	4IsEAk0v3+TUEIIPNhoTxFi0n3dJ0KXA5YtrSpIBbo4WsMzMdFR6KcUQwmf1g1bNJ4OKjgUFCU+
	h33cu1ZM4Ydk4Ba84e/KWASeQ==
X-Received: by 2002:adf:f549:0:b0:487:489:7af0 with SMTP id ffacd0b85a97d-48dbaadde34mr26894966f8f.17.1792043382157;
        Wed, 14 Oct 2026 22:49:42 -0700 (PDT)
Received: from omos-acer ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48deeadc0b5sm6901587f8f.6.2026.10.14.22.49.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:49:41 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 0/4] Fix build warnings on ppc64le and s390x
Date: Thu, 15 Oct 2026 07:49:28 +0200
Message-ID: <20261015054932.845406-1-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes build warnings on some architectures that became fatal
after -Werror was added to build flags. It also adds a simple compile
test to the CI that runs `make all` on all architectures supported by
Fedora, so that they can be discovered earlier in the future.

Ondrej Mosnáček (4):
  tests/binder: fix compiler warnings on ppc64le
  tests/perf_event: fix compiler warnings on ppc64le
  tests/filesystem/statfs_test.c: fix a compiler warning on s390x
  tmt,ci: add a mutli-arch compile test

 .github/workflows/checks.yml    | 13 ++++++++
 tests/binder/binder_common.c    | 36 +++++++++++-----------
 tests/binder/check_binder.c     |  8 ++---
 tests/binder/check_binderfs.c   | 10 +++---
 tests/binder/client.c           | 36 +++++++++++-----------
 tests/binder/manager.c          | 37 +++++++++++-----------
 tests/binder/service_provider.c | 22 +++++++-------
 tests/filesystem/statfs_test.c  |  2 +-
 tests/perf_event/perf_event.c   |  2 +-
 tmt/README.md                   |  2 +-
 tmt/plans.fmf                   | 11 ++++++-
 tmt/tests.fmf                   | 54 +++++++++++++++++++++++++++++++++
 12 files changed, 155 insertions(+), 78 deletions(-)

-- 
2.54.0

