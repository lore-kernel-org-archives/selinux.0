Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B82F7EE4
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307816; cv=none; b=bK2HVJRM4Bhy+lq4FDYu3HVOwqJya3CHo+LVX+z5QSXBTiysRO6iRpLv97FL/RBMii4V+pHvBYazvQRk1bxUE157Iu3LxdvyXujv7Ojwk5NItsNwyeYCLP9lytqfsDpt+ER2cg2dRf5v8pOCMvXG6UsD5lshNOwm14jF+uYlwhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307816; c=relaxed/simple;
	bh=4IyVDEjTbHrMhKT+H+6dyluqRj6+971TcLj7HnMvksQ=;
	h=Date:Message-ID:From:To:Cc:Subject; b=tADVAZUK0JPpFd4dyZECrI07ivu6Uat7GmBhG/syF10Srqa51Nru8FPFt3CiE+U8VrAf1OCA68YYCLhamSskOs0Ob2T8NHjjESc7C5y5PBI/EF1cjqAIJJPC3IKOYB3Fw0ZHgk+Id+o5XypnI8ybgH1/vZ4fzI4LNiQfrQdpBGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=V/5lBr/O; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="V/5lBr/O"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e533aacf2so268235885a.2
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784307813; x=1784912613; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZBj8o+qzHfyvCCselvW/9XCn3UKf7PzkVoXV3QNsub0=;
        b=V/5lBr/O3VRUvSBqwm6ku2OFMchm3+ykXMbba2g2EuYtQFWN0RmG4QvbjCwF1P17Fx
         XvkR2ejQPcB1StQ5c6n0X1jlg46wtumhjEqKEitT4c7nvnsjo7yUrbw1BhSoYbnC3Bq4
         SXKSA8bh+vB6cy4xy+TuQg94CKJ4aerdaXFwOOwhY1lhIBoiJk1Ul2zPq9LTp5RajYm4
         vHx4Sl0fQlUk0BRuwpSKj1bUmTmGTBUZLlTiom0JxWBUrYfqdPK2ojVBm8TS8upyDJ8M
         /UNt/mDVr4SAk91xANyt9CCU5JkcP134GZL1otDmjLVJmTou6x+VlkkC9lic9mTHN2LI
         Xfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784307813; x=1784912613;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZBj8o+qzHfyvCCselvW/9XCn3UKf7PzkVoXV3QNsub0=;
        b=emFaVHl69txHyLlyczeMAclguRmLPKpnuByp7Ei2hEWCOB+5HHh8MOjutoj6oIsUq/
         dxzwy9eY1nGPYBUhqD2yolms12jI9UUbc6mhUoMYXYFEObhj/0d0vk1HQfYM9t+D7av2
         0pEVaQWQlX1kWJky8q++iA6PcxyglESrEv99ZP6R9l7jM8h7bJIe1YmKAyHJtD4KuYvt
         MQwqlnCbqSpml8k4Mzc5bw6iIYmSHb/cRL62c82KC8eplgRcEx4nP0exNWjCVHqm5Bp9
         zPjctntv0Di4vMamAHZx/pml8dkfrY0+MF+s3jY4zuxgd5KRLDJnUpzJl4KwDZ49F0VM
         MPQA==
X-Gm-Message-State: AOJu0YyFbUbb5BCYONeQm/vKVkqHyFi1Fa/T6ejvSZCFUu9SAyDmT3PA
	Ze+6yyEJPu9DPeyswwy5ZCGDEJ5p8xMt4hw+F8Fxiq4xPUBucEEc/iJ5DnIqKwfNPlIvrKHVr+S
	9N9FXqQ==
X-Gm-Gg: AfdE7cngdlRJoTuG0+rNLADBLk1OZlysSWB8RXKOtSvIjcZN7XjinoO+4Tj/NcLdYoX
	yYPzN33sex/N2W4oGuceChoWyR2j27nT0w5qpCf1oLp6T7f6UcXOMEJTS9eMQtwhXT0MNVD4ezJ
	mb2ebeq+TrCAyi94U6mBmBZd9FP35qdVm9obEJWzYsZN9B+RLgmWIJSDaKaef5YAYIT4Ng4mJrV
	JoW4qzMQQuof8WNUJ5wCkfKw6PNAxIfd+XAYm1UzRol3DAqOwMEL4XsCc7zasOof4hS6jN7pThm
	U9krr6IP5HGmZz4RA3wpP2PlpT+WfH2vp157Bqp0jRIdoi8KQ/Rfte9kZiSO7tpRQrYOZKYITC0
	VknsPjBFNs5rVL4b4t+yjWt4Wl3TsnAdesPXaSID7abfJ2MAoGhDGG8mbtJ5TlrfZSMs14X3keQ
	lxuBJAPOj88TLg40XbY/axiiOwHSyeBNlTEwFLZfVzqOuMGgc=
X-Received: by 2002:a05:620a:2585:b0:92e:de49:64a5 with SMTP id af79cd13be357-930b416d8c7mr389590585a.56.1784307812602;
        Fri, 17 Jul 2026 10:03:32 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52e0f87sm196745985a.7.2026.07.17.10.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:03:31 -0700 (PDT)
Date: Fri, 17 Jul 2026 13:03:30 -0400
Message-ID: <fa44478822ef189fb7a5ce16135dadd8@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260717
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

A single SELinux patch to correct a problem with the overlayfs mmap()
and mprotect() fixes from earlier this year where we inadvertenly
included an additional SELinux execmem permission check on some
operations.  Please merge for an upcoming v7.2-rcX release.

Paul

--
The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260717

for you to fetch changes up to 9fe595fad54d4ac6a402edb3f60bec859d52cea6:

  selinux: fix incorrect execmem checks on overlayfs
    (2026-07-14 18:10:20 -0400)

----------------------------------------------------------------
selinux/stable-7.2 PR 20260717
----------------------------------------------------------------

Ondrej Mosnacek (1):
      selinux: fix incorrect execmem checks on overlayfs

 security/selinux/hooks.c |   42 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

--
paul-moore.com
