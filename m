Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC373AD527
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356761; cv=none; b=eUdVCpRFvM18G28OAcQRjW40LwQTECqWErF2Oznz73mt4pDXtlLZFnQlImka5K04yf0y3WPsFvj0ihCNvOuEh02ZpcMPsWROpRKhng/BeJpgchsdyvXfRZhDE1hlAF5fySZ5VVc686pC9t0gRIVIoZAHdgWepezV/xMG7mOii6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356761; c=relaxed/simple;
	bh=jGJsUW6AVCHT0/6iGw/Q+hPZ7cWa4isIZ3BQwPFrp24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9xYp6LYyk+/WmmkA3Mk1PHxdmPiClU1BPFmiu/zUqnUcUUfnI0ovq+UBHFtCsbFkuHygzpwbodGvNLO9eFFe1ocS3PI4Ya6ctW/mHbV7UlK+RBstIKmZDeqWwrjNkaz/EoAFwLggZ+vHLemLgjbNKGwikI6qzKBZs5+QTdPc14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fj4zzrbf; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj4zzrbf"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51bfe810293so8794371cf.1
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 06:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356759; x=1788961559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7mAHVk3RRLEQ8YFSe7j6fRyScAQnVUsvzOFULezuuAw=;
        b=fj4zzrbfYwPdfD/5Pol5Ps5W3KdNYqcE8BbXzNcsmyauCW5GCxR2AT0TaqOyOqcZ67
         cWii8m7SX6XqEEd/WNECWPQ4DAb5YNCHelnUbK8APjFo8mfYo9K4HiHuORKDGuc3yzxt
         okomsX1IiRD8zzc9pwyxbP0lEyM7IZDuTLqA42rglDjbF/7zXXF1W/chOfc0xXBMcTue
         S1UM/oKbcjG5mpfgcWD/lQxGU8HR6f/vwfDHtlsvvZ0Pb9+SYMqJF94wxKnpHK1m5dFQ
         Il1/8AaIn0I2axkrFJwPJVA5mSgNymICk93ulJHtqp9WtZYGz/Q4ZynjcxIgr4DEwS0c
         Wuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356759; x=1788961559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7mAHVk3RRLEQ8YFSe7j6fRyScAQnVUsvzOFULezuuAw=;
        b=DUxbW3POsG126n6v9cT7zYKBL+C6siw9E5ixab5TVQ1LZ/9Z7V9Q8x1SKMkduiHcJN
         HODIjMcvzcQXYQ9urKTapg3N2MX6b9T4PNCUUvI11AxESJNoVAbcwnb92/rML5aUy1uL
         KahhYjv5qN47N4yRWJfx6HIIwzjVm8N0Xx8zbm9be/YNT4zP+DXSQEsm9RZAczfYl6eV
         nIAvOJwyOtMSFgsnW8ZnZXSQZ7jfWCAZS6MtSpImAZ4QsX2lEgPgOKZIEqip3dEl6fvb
         Pa3G05dGoFIkDyLeZFbll0zouBl0CJDWD23JFQSh7qDsFtDVDQ279VNG6BcwcbkDM3CN
         n8SQ==
X-Gm-Message-State: AFuF++mmQJftmky6JxV4iFsaADkzwVNFcaodBpzjXfcGSxbobvF3BuOk
	f165XnQ/ZnXlH1nuQTd0p9VHQd7HCT/UEa9hyuzYQV0hD9MhJV+8pSzGBWzf4w==
X-Gm-Gg: AR+sD10GlK8HnVbXOhwJ4Jj1WhCmHM4K5u4CCIgxHbEvCBpJ3lxqbdEu74QZVhlpR9n
	wfXeVfNhYPnyOKHebcauVuGxAuBlbfrVoUNn3yUpNnoFhFGyQDMwF0KOKHuwh+z2+lC+y+zrkp8
	rtk0hhKNcfBXi0bJr11xxZZOQDGwLmZ/GI/ILHQDj6q2+ilKfSjOy1eXkQtbKGl+NM6jUYychrM
	A7yHxHinePrS0mMjKRDOR23OCbTAL4Zu4nFbM3o3T02OqVYpz965c9m4pGOShpx+iHDwEQfT1Qa
	ZjZ/bRPcainUAOqkLx52UqcJ77zAsMl3HIOHY+9oSgbhyPMWEbdDjgp+qjWAE3+yztMJVK5yrXP
	Sb2lIL/idM2sLsRQD/39erPuO9wVpq4a5XFRUCvFz2ah7QK9uDY0VfmlRSRUf/WsrZYZRTtuWT+
	pA0MmgzsE1afTQfQP8SUuY9DY/ql/rqwh5hIbWhNfb3uM5EOwO3Cm/R/2eHPeQt2O6C/O5nrFsh
	6vzx/4dG2L7v3d7leb7sPVa3spQGfhZNpejHAWsCdFUE4Ov7ubD8S7CseHtSjpQ3w==
X-Received: by 2002:a05:622a:992:b0:52f:babc:df1a with SMTP id d75a77b69052e-53036c2416amr54962861cf.10.1788356758770;
        Wed, 02 Sep 2026 06:45:58 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5303325af1esm18686011cf.29.2026.09.02.06.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:45:58 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 0/9] libsemanage: add ro-store-root and configuration-root search list
Date: Wed,  2 Sep 2026 09:33:08 -0400
Message-ID: <20260902133316.51981-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

