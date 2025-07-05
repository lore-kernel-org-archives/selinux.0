Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07B2E370A
	for <selinux@vger.kernel.org>; Sat,  5 Jul 2025 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751717673; cv=none; b=rgre4MVYalbWgvtpOy89bfSE5i6CJYE/J2UFQzeCusJCIC2IuMS8PD/mW8RdB0YgehV2HfzO+Y/wPNR4gjt7qfDJldl25t8ObMqcpz6TecfDq/gQ4QSBrMd3V8NTIRhzlqGa7zT4qZTLSnl8w55NZd4WmL68jNLsUkc0TcYU8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751717673; c=relaxed/simple;
	bh=fAwqLGjTqSFMnIqai5kwPb/hXBso0o3u1eYJAJYmkeQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nJ1InKk8phPdvjbWNq9Xta3Hm4jBXP7imNskzc/2SBIPazQD1Z8/1rtf459C9p89VJyo2RsBuSizXZHAnldOt3vow5i+y7FtBe3NjUwCQiNHBRT09ZvDDl2/v7a7ivaJs++pnYl51/ABAZaP8kr7hsmQcYwIHH+It+4o7ef1Rt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7sTRJtd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7sTRJtd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751717670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D/juvJVvJrQ1GItz7YlwWQtRc4p3v1GNzUosICZrBiA=;
	b=A7sTRJtdfNkfKxLze7e8qQAshh7EU0JUug5yTExpMCxJAj7dv/ZrHSVlvF/qUGc2j+iAEu
	21IeUTx5JYzVFQgQO9NDr1FPuBw96nbPw2z9D+663yLHulO6p8jAr0SZXOJpBEMelX+BGx
	l91HHSwKsxTZ+nj6x3lMAAtmvl4Bt6I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-LL06i9IcOtCQg0hJxDSobg-1; Sat, 05 Jul 2025 08:14:29 -0400
X-MC-Unique: LL06i9IcOtCQg0hJxDSobg-1
X-Mimecast-MFC-AGG-ID: LL06i9IcOtCQg0hJxDSobg_1751717668
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso1049827f8f.2
        for <selinux@vger.kernel.org>; Sat, 05 Jul 2025 05:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751717667; x=1752322467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/juvJVvJrQ1GItz7YlwWQtRc4p3v1GNzUosICZrBiA=;
        b=oE4kNWlVRIh/CChEFA0Xp2ST5/yZ7TRYNgNSa0PuiR1kowG8UAxR6wluDNpafJEbiY
         1jZUySjf5Nuvf4pj5gkO3ZTv9s+aArXlh/cmLCKpRWygPX0fRt/N+5DBkYZ9aRDTPqHr
         HErFzr5igSAvO07NKpKQWXndGG/N59cYPeGk60qmiIQ5pNTrdm9lkWtrKp9L2kCR21R8
         L5zsdyAY1TArDDR7IihFR9dXbqbXS7B1AzLiFHvISVxHeTaM4vLRxXtt+jljw1dQqxSe
         nNEIYfdvn5RjjtayT7bXc+exyJBtz+uuMfZbI3zcAjIkG1v8CoqzlvqTe8KPw+CpphLl
         K2Bw==
X-Gm-Message-State: AOJu0YyN7zw1PVwKsbJQMZlE/EhJApnV8RrXcNuVBTk5+TE4eapTmqpe
	xxbhmAf7iSBY+4b8htADtG/7axvWgr0KqDx+ewcysOKO+V/TvKRlswBQCKQ2ZkAa7pT00lMHLov
	GdDQ9BvbmKGHhgOF28m8UoM86Lwhk3uwnK9UyoNSCY1z8W53H23nPU/mLC6AIwur1dIUr7usXyH
	GIU9W35WbVRN1ve7Aabjjg7xI+28dP4liQpsf6hZPopUY=
X-Gm-Gg: ASbGncsVocYFahcQ8WuTqL4OsG32Ra5BUtayUtMOJJMMahg+BNA3KIw8BPNJ83PFT9o
	AiQuxdPLG2Xqteh2H4OO+c/ij+nqPhJFDPHbzQnFbqw34GisdFUcpdlVqNrbj2Qk4HYpD2bZRLR
	jaOXrxd060cEYsxVQp6yTSUS9RTh+TfP6UmyyW+zFokw3H4nbJGQKUk+uebi92ggZirivDxOiCx
	1ZByilOXP71eb08+rskA9OGOKxx9NvN0V5ZtWkJZSfRCgb/v1GKzMmEj0gQpTYq3i+SJN0Xc0Es
	U5KeYjngrrIx4uNneA==
X-Received: by 2002:a05:6000:26ce:b0:3a4:f9e7:2796 with SMTP id ffacd0b85a97d-3b49aa743bfmr1676838f8f.35.1751717667424;
        Sat, 05 Jul 2025 05:14:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt5XnMbr64b4Kb+vtn0c915bqtEsSffqiZF58jpc53s0orty5tEP+qTHTsfo/4mrv1cEKq4w==
X-Received: by 2002:a05:6000:26ce:b0:3a4:f9e7:2796 with SMTP id ffacd0b85a97d-3b49aa743bfmr1676818f8f.35.1751717666926;
        Sat, 05 Jul 2025 05:14:26 -0700 (PDT)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47040161bsm4863832f8f.4.2025.07.05.05.14.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 05:14:26 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 0/6] Make more tests run in the CI
Date: Sat,  5 Jul 2025 14:14:18 +0200
Message-ID: <20250705121424.1221268-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adjusts the TMT setup scripts so that some permissions that
are currently not supported in the Fedora policy can be tested. It also
cleans up and fixes the module_load test so that it passes on both
x86_64 and aarch64.

Ondrej Mosnacek (6):
  policy/test_file_load.te: remove excess semicolons
  policy/test_file_load.te: use testsuite_domain_type()
  policy/test_file_load.te: adjust to kexec behavior on aarch64
  tests/module_load: run sh instead of bash
  tests/module_load: fix the location of "2>&1"
  tmt: add some missing permissions to policy before running the tests

 policy/test_file_load.te | 84 ++++++++++++++++++++++------------------
 tests/module_load/test   |  4 +-
 tmt/tests.fmf            | 28 ++++++++++++++
 3 files changed, 76 insertions(+), 40 deletions(-)

-- 
2.50.0

