Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE849B211
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357816; cv=none; b=rYwzcipMl+qI/mpDV4ORR0CGDz7eErKaW2OjiiIy4QnrFTXCLEJkTijDFabsGsGKiNkXvESDswoXWKyu+XXc5DNLrrfB735SFnJLABpvHKO5cpKbGv3zCKm2MAULnp2bFZpSWdLk1Wzw2WpH8nJTQnaDmW+rHHt+zeeRhKDCey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357816; c=relaxed/simple;
	bh=uchaws4Bdv9pICbLrWiuFhghaWgAa74C2J6+USiNgwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dPeLKBCeIjAyWOhJIfDnB5M4odBOrx27FtUrsiBzwj/VcqWkBBV36uKpSYHcsR6tfyadHaQ54BQazZg/VxXRcRW3K5FJJt10y1W/p8YNkvf+HKR7yM+uCBdQ0pqz894IxxUX9MiY6sQyuM8LCjghygaxSdlEuNrrK3XSt5rhCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp0XCAQM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp0XCAQM"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90e7bde5596so11523066d6.1
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788357814; x=1788962614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hP/tsudH2WChACZQDk/1SwLw7PxkOy+hwGsustsJzpY=;
        b=Mp0XCAQMoGEODROJYzLFgQVb7ChwgXX5p8l13ltBFvYtpIdUnHnwBrXhBdocgcIUKz
         Kiqef/f3Frz/wo+LMExSCjm1BtYSOZV8UGPxOdQlalqB883s8q4rjb/0LyXkGJDZGbsx
         CUmEmtxnhm8n3hUeHiGJM/xH+Evs6cqdt1IXGHFdBO2sy7PF5dAslEaF5KWbGjLHOsS5
         KvbhyKHZA1gqVQ397CuyVBVaYk6/k2M13+5ZrZcRxl6NOi1GGKBjnLkBNo3QD3KxvmTS
         5xOLAENqgiGfu11i4AWWNIVkP+248eIVrsczvOiG6/UW2mfkqoch2fQa0fGvdXpItwYw
         tclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357814; x=1788962614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hP/tsudH2WChACZQDk/1SwLw7PxkOy+hwGsustsJzpY=;
        b=X6fkFyb8r4PLAhfR/R/nWy7R0PGM/FjCTMi4YRKsRTpf45vaEZyR8OyPw+W0B0uiwY
         ajfvsTWfPsKbqGbfV09uG3YuRiODTfsNXVTXiBjoVeY2eNZ7E80It1LMmW1ik9o1qy5D
         uyuR+/by2t+hIWTLInNJ10LpeNcfDyC6BBuLkINahkj+4lAHop4GatalODYC9zNqeAiC
         Z4OipnI22wL4jXJTG9Glp6/mQ82SPRjsYnTWHTYxkuYszqVe+feHbkT3T0t0+hceKVhM
         PDIktz9zektPMafdv9RWNodnxGH2JlK3ur+G/OH5v2DsbPGyvVMl+nj+Y0joeadGoxBF
         MNGw==
X-Gm-Message-State: AFuF++n+M/Wh4pTaDQkuaDmsxOS8PRmlubVN7xwM/kddnMP8D1CzoK16
	vHY6DVlvOFMCUBRHx8mlsjXIqFztpQwbgDVr9JmdlyaGgUh8/kKnvTp0tSSuIQ==
X-Gm-Gg: AYBFou1bM/lL+8JcKy8YsUP/F4PA5qCrKiz5hVdI2VsODE9j4QvJq2/lg+DQWu6o3m7
	1Tob9mimZaXFWHS+qC6t59SNhqm0RncOEHFQIDi38agZ0RpetR7EXHGxibY+B7wGx5f8kcF+7rd
	P5Ybemiwa/siTd71bK+aKxAdD3ZmJkkFVGO3q2Ds3qDjO344mkQANSBfpgU9e3PFgdUYvmaQju1
	Ue/Y8lLmGVgc0+ufQ9+UAhL4poSkq3laDkbAqEssKDhkq00QbjYBwgI5rNAMbwhu7eSD6M4dONY
	eQMYhLfq1My8I/Y8UVvgpEP3B1tfDqjMcNUWhXgUT4xm8Yepr8F7v60SR5jOwdGMjK939XoQ8/V
	3BTmG9ZCWSDTp7sJrS6wKJ7htQN/VnpCxwsaA5KqgNuIYwEMZOYDzXdYtRQJuvveDoMUAGymaMJ
	Z2wSGxde3BFebln7jE+13assJMi7NxCI5egfJ4W4G7LRM3dXq6ArpJUEsELqWdFAwY7gAP3ue05
	SIFLkELNSRZ2alfDjBjx5S7tVPDv31byNUGfqoiTGd4QIU05A4Y8Mm8zRMltgqP
X-Received: by 2002:ad4:5f4a:0:b0:90c:e57f:e32f with SMTP id 6a1803df08f44-90ed497c9a5mr58177786d6.26.1788357809084;
        Wed, 02 Sep 2026 07:03:29 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee316f7sm18790446d6.19.2026.09.02.07.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 07:03:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 0/9] libsemanage: add ro-store-root and configuration-root search list
Date: Wed,  2 Sep 2026 10:02:02 -0400
Message-ID: <20260902140211.53084-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Stephen Smalley <stephen.smalley.work@gmail.com>
9:45 AM (16 minutes ago)
to selinux, jwcart2, plautrba, omosnace, jason, me

This series is the second half of addressing:
https://github.com/SELinuxProject/selinux/issues/33

The first half can be found at
https://lore.kernel.org/selinux/20260901163513.43186-1-stephen.smalley.work@gmail.com/

This series adds a ro-store-root option to semanage.conf for defining
a search list of one or more read-only store roots that are then
searched for all read operations when there is no corresponding file
under the writable store-root. By default there is no change in
behavior.

This series adds a configuration-root search list to libsemanage so
that it searches an ordered list of configuration roots for
semanage.conf.  This list can be overridden at build time via
-DSEMANAGE_CONF_DIRS=. There is no change in behavior as long as
semanage.conf is found in its default location under /etc/selinux; the
fallbacks are only used when it is missing.

Stephen Smalley (9):
  libsemanage: accept a list of read-only fallback store roots
  libsemanage: add semanage_module_find_path() and use it for reads
  libsemanage: list modules across every store root
  libsemanage: read the active store through the fallback list
  libsemanage: create the writable store skeleton on first transaction
  libsemanage: create the store root when taking a lock
  libsemanage: refuse to remove or enable a module owned by a RO store
  libsemanage: search /run and /usr/lib for semanage.conf
  libsemanage: document semanage.conf search path and ro-store-root

 libsemanage/man/man5/semanage.conf.5 |  36 ++-
 libsemanage/src/conf-parse.y         |  57 +++-
 libsemanage/src/conf-scan.l          |   1 +
 libsemanage/src/direct_api.c         | 458 +++++++++++++++++----------
 libsemanage/src/modules.c            |  63 +++-
 libsemanage/src/modules.h            |  10 +
 libsemanage/src/semanage_conf.h      |   2 +
 libsemanage/src/semanage_store.c     | 185 +++++++++--
 libsemanage/src/semanage_store.h     |   6 +
 9 files changed, 611 insertions(+), 207 deletions(-)

-- 
2.55.0

