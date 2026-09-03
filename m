Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B17E509EEC
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467737; cv=none; b=RA8ywft71Znf3j/HCKrnQSCkuVzuHsUHhy7T1PRDgxbD/KJEl2fjX9ambEUzMr6iMMHpIInCUSTU/hjxLMEWopEed/HiDKvPujtgSD3ftFYwZTFLFwz1/Vb6ouEu98gZ1kb6w0CE1DTzWO2EQUwToJ11cnIWuuIRQGrFsPF+yWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467737; c=relaxed/simple;
	bh=9uWd0iWTHtgoOPQrB8sodf7NrxSHcMYqSafeXFsJ/Mg=;
	h=Date:Message-ID:From:To:Cc:Subject; b=aJsMbmqddvw/2Tw5DMZdDtMpSagW053/xmpvJGJWH/zFKNUC5Z1WndNNzzzwjJuEptZmH4XtAIjHAAb0i++X8+NDb4BD0VpSLEwTLMRKZiT53nAuZ5ofBzP/XgwMObRjA+tjfAK8iNboNG8pek4XkAEPriDnUwtwuney08bNifY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RHQF0cjB; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RHQF0cjB"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92ed19f4d60so28889585a.0
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788467729; x=1789072529; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BgZOKPlak6pP0U7KmyWbsU79GCeGbr4ZhDTeyjd+peY=;
        b=RHQF0cjBtrfmsK62fMliV4TZPzmAVUhmbKA1iOju8Cp7W+ECT152FENTL6yKbQ5Mqm
         ANOJnsaEn5ihqrsFfDdNDbKzsYNDuFn+5/hIp+SPxMZfCauOmvxtq956CQrD3mdqh7qy
         4R+3GTIjFpQnnS9kIcJTq+iizD4IK6riW/LV3wIVeGFh3OlzYnTBwF4Q9GdOd7eat2V5
         3dCUmlN2GfrLvUF9daY+yA6eiTK4E4jXj+0NkdWakob9xHz5H62012NbKdRxIDdILSiN
         pHay5oBoC5/0lNC3uihAVkmnenH3KUZ9FP85bg3TPmBXlpyRhfFW9NedQNhYW9krIYHd
         GgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788467729; x=1789072529;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BgZOKPlak6pP0U7KmyWbsU79GCeGbr4ZhDTeyjd+peY=;
        b=psKP490t5xf7ndDPS+spZCLnodKCjyXxS1xgjwxX4LrsAelR23/vuGm7NHuJFdYfPt
         mqVkL/IT7dNpeBZ9yJ/imRfaJfH1tqAB4M6UpysLgiUHvqnIQk5d3T6sxCp5J1GwlkPk
         e6xi+n2pwFwBspWaq993HkT8Q3dk0QV3O16rxRqtrIBIh8JwSWY83bJsSFIowWWgj7+q
         7LRhpkN03/SjIuE1wDBm6AXq5s1EGs6yT+o8/H3hvU+jAeB2ahAfxKV6xmtgFfybx8aA
         c2Yvvt2MgF5R63AnbpEKRUv7ICc8BQHuBGSueF6agTBEWlS3wJkyci8ougMlIoamOlKF
         gqag==
X-Gm-Message-State: AFuF++kwZ0SaAViQ6hHL3/N6TNbEZSn6Ba0T3IClcaMjhsyulEWGWuTN
	qSN2f0lNg05y7b/E0tlXeOtNoeRtUgZ4W1plg4Q6/KG3I6mMkA7LOFL/mzFPsKUEMw==
X-Gm-Gg: AYBFou2VsGUX/fg/JS2IYH5dF6V9B5K9xSDuPXn8xHVd0j9z3t49G9sTwPF1LaBWtCY
	2EfWnlfwL8qH/BmGa1bjeSqbfL06UrTliBlz3+3ss8jGyDycjyLCx5EWxGyrGgHNVsNMJAY0kkI
	eRnDDTynwzPkzi1u154+OxpdsObPEG76fGMtuqlUK5Zi8529hpzEKFh6XCb5PD1FA6uM4h9+cEd
	J6KrQSDPkrrPZBzEMz8qGogn/lfECt8/WdPztL7zJojBgeCzy7deReRZz87eGH863ocgLwxLUbC
	hbHNek4gUrWqXK6fdkeLdmN2WR6HXusCPJcGORztG7ShB9LkRqnzKQIBKjukePqqOph+NG2LHEd
	n0vpSOdu8WAbjKyWTnt+p0QGPMHMWvuynV0TvbTqO2ZRriVkOgiLYvXh1xVMqJU10EGmce1pKiF
	MncaOLs3DsW/NSFQiMs5Bad39oEyreCVYbubTu+gM20IQCPFgtag5guzj708WxbGnynM5FFY4oz
	Uwske7SC+Rd6kgUsHWuNNVMW3D8LB2SqjfTRuLI2giCYDs8rapTlooL
X-Received: by 2002:a05:620a:2856:b0:939:cda:46ac with SMTP id af79cd13be357-93981737ffamr29121885a.17.1788467728670;
        Thu, 03 Sep 2026 13:35:28 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb70fbdsm50115485a.32.2026.09.03.13.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:35:27 -0700 (PDT)
Date: Thu, 03 Sep 2026 16:35:27 -0400
Message-ID: <8c72adc9e5a9d3ce854fab61ec5f66df@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260903
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

Two SELinux fixes for the next Linux v7.3-rcX release: one to fix how we
lookup a BPF token's creator label to prevent a possible TOCTOU, and one
to update Ondrej's email address.

Paul

--
The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260903

for you to fetch changes up to 4299767d772d4e498998e32157e45841178ab192:

  MAINTAINERS, mailmap: update email address for Ondrej Mosnáček
    (2026-09-03 16:24:05 -0400)

----------------------------------------------------------------
selinux/stable-7.3 PR 20260903
----------------------------------------------------------------

Ondrej Mosnáček (1):
      MAINTAINERS, mailmap: update email address for Ondrej Mosnáček

Paul Moore (1):
      selinux: fix BPF token permission checks

 .mailmap                 |    1 +
 MAINTAINERS              |    2 +-
 security/selinux/hooks.c |   36 ++++++++++--------------------------
 3 files changed, 12 insertions(+), 27 deletions(-)

--
paul-moore.com
