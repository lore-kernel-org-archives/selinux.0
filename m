Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9FE1DF992
	for <selinux@vger.kernel.org>; Wed, 29 Jan 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169892; cv=none; b=uILgsQb2jlVqt+CGJ0AcKrUkYSGdxgvstKZVh52YQokVv1kfEMM4SZAesd6xzgNpns14KMKcOugTOXctn3vkjg6XU3NaH41ZgLJiyrU83ocLT7Jgn4KttcqiIylHP7hxPNQq7HAwAQnG7QJHwrNew401gke4xl41tu4lyR4bUH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169892; c=relaxed/simple;
	bh=JIWQ1QO7BCksiEGMetoA9lKc3PKsttFlXXgneRTjly4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdsHtsN6OJAK1SJi03jHkabv01bUIaZJkhqKIxnAoYUyocEJLgdgQric8BaKqElC5oucB4mQPfchSpc7269TAxC6HzYg0luaYh+KarpCXBMB8ItMH0CbhoDSm/4jooypm8FcW4D8z1ZQmnjd6KbWj7a1/wXmC0ulO/GTVbJ+H9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbJODTjQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbJODTjQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738169889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K47kaWwlvB0QgUEcbod96X79kXNV4c3e9UEBsXFBFcM=;
	b=XbJODTjQYXweCJCBc8IkLhdHKro/9FjFDi2SuEsI6mvPPptTxgHyk2oNhzHf1CGZRm+4WX
	B7NhXqT+KkEckAhMf+Uy9v8t7NbnW+h+35sHES3Ymbm5r1dMURo7+WS7IeRVHFqiQzwKTy
	ec1uZIXO5ot+OdB9Sg7lhal2tjZVc1c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-xhkjTSeKNs6zBiKuXVjijQ-1; Wed, 29 Jan 2025 11:58:07 -0500
X-MC-Unique: xhkjTSeKNs6zBiKuXVjijQ-1
X-Mimecast-MFC-AGG-ID: xhkjTSeKNs6zBiKuXVjijQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab6d69317a3so84758166b.2
        for <selinux@vger.kernel.org>; Wed, 29 Jan 2025 08:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738169886; x=1738774686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K47kaWwlvB0QgUEcbod96X79kXNV4c3e9UEBsXFBFcM=;
        b=lhZy+BcWLrf4ebJX7zg8i1Zowbyl+AQSnLLWxfOApkcu9h2eph6C1PWVUoJoVaVfD+
         Yf5+K03BCpuhv6uojWsJH7Ws9TsLLXpZpLZMSUxl6lvlLAx0aF4+8PP8xedceqaJ8O6Q
         4YYm9Y9JRNncqXOhPWKZDVk0fz3k3GeSYLwiB9qiDYHKKn1krOdzGCByL1cOcJepuZV/
         85D8eqJyJf7LU+1cDsZlXCJ2BAEoZiE+MHseT4MDKwbVWnNHnnzsZuP2wZxPSixejl2B
         59MRGMJ617Qj4S/APHCDUdA8YN++9ZyBzlf6D4a5vD0GkO7lYyMyyVbZIXWqqjn5YBuN
         1K0w==
X-Forwarded-Encrypted: i=1; AJvYcCXtGbGdo/rkgn+MM04dTV5OKV+V3w5QXTYPk2iLbezv2pkIBEp7tsFAVt6BmUAutKYKpR1Lm619@vger.kernel.org
X-Gm-Message-State: AOJu0YzC1VEYkZOkhhhy42OsXKi7lmtvxKHecc/zNHVZEnc/oJQ57oqb
	/SVpQDGqhHiWwV8SsqMpejhHArgI+NOda2i6GB24ls6kbheKjFuTMEqVHB0/XyGSyMQMVmrbBiF
	1m9gMAu06bNbZVZw9Lzyw00gyqNmFV5fv7MseBQJexvcGjf2jvNNTcaI=
X-Gm-Gg: ASbGncsmEFopmtq96dtAtLe/NFHl67zjo4S1UuxWZ3RFmVDtgNXX0rB+MZvijWoPGM7
	f8+RIGpN+8sJfT5IxN4tu2AoXY81Erj1uZGpH52LM7hVxJBxxT1mzW2LgbBUN5id4sXmieKqFik
	S7Rxf74SGUKb3j2Y2v0eFgW2FmLfvH0zXuz+YmGbEFS6zCq++IqcCesLmpjGHw/c5/tDcr7Waxp
	YDYfYNlqv/vBtctCLbJIuTqTezjVu/ZIT9pub7OLL9pDiqCiJ3ikdzYcOxAtkF1t30RJGY1ZyQ7
	NPRjIRW2+XtzcwnqREYfoCQUQKppEoPj5yrz1wIBFnHx9HqHt87GaYf3
X-Received: by 2002:a17:907:971f:b0:aa6:a844:8791 with SMTP id a640c23a62f3a-ab6cfe120e9mr362631066b.45.1738169885881;
        Wed, 29 Jan 2025 08:58:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3fQki93wvSIZNI2gPgUJncSMHks44LgIjMTqpIUAYXOgBM3KZNLb1wrvEfXMxgDFWGdYD3g==
X-Received: by 2002:a17:907:971f:b0:aa6:a844:8791 with SMTP id a640c23a62f3a-ab6cfe120e9mr362628766b.45.1738169885491;
        Wed, 29 Jan 2025 08:58:05 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e653c6sm1002813366b.64.2025.01.29.08.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 08:58:04 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux-refpolicy@vger.kernel.org
Subject: [PATCH v5 0/3] mount notification
Date: Wed, 29 Jan 2025 17:57:58 +0100
Message-ID: <20250129165803.72138-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This should be ready for adding to the v6.15 queue.  I don't see the
SELinux discussion converging, so I took the simpler version out of the two
that were suggested.

Will work on adding selftests.

Thanks to everyone for the reviews!

Miklos

---
v5:
 - drop FS_MNT_CHANGE (Christian)
 - rebased on current mainline (Amir)
 - add FSNOTIFY_MNT_EVENTS (Amir)
 - change selinux permission check to FILE__WATCH_MOUNT (Paul)

v4:
  - add notification on attribute change
  - deal with two FIXMEs
  - move data and code to #ifdef CONFIG_FSNOTIFY regions
  - function renames for more consistentcy (Christian)
  - explanation comment in umount_tree() (Christian)
  - style cleanups in fanotify (Amir, Jan)
  - changed FAN_MNT_* values (Amir)

v3:
  - use a global list protected for temporarily storing (Christian)
  - move fsnotify_* calls to namespace_unlock() (Christian)
  - downgrade namespace_sem to read for fsnotify_* calls (Christian)
  - add notification for reparenting in propagate_umount (Christian)
  - require nsfs file (/proc/PID/ns/mnt) in fanotify_mark(2) (Christian)
  - cleaner check for fsnotify being initialized (Amir)
  - fix stub __fsnotify_mntns_delete (kernel test robot)
  - don't add FANOTIFY_MOUNT_EVENTS to FANOTIFY_FD_EVENTS (Amir)

v2:
  - notify for whole namespace as this seems to be what people prefer
  - move fsnotify() calls outside of mount_lock
  - only report mnt_id, not parent_id


Miklos Szeredi (3):
  fsnotify: add mount notification infrastructure
  fanotify: notify on mount attach and detach
  vfs: add notifications for mount attach and detach

 fs/mount.h                         | 26 +++++++++
 fs/namespace.c                     | 93 ++++++++++++++++++++++++++++--
 fs/notify/fanotify/fanotify.c      | 38 +++++++++++-
 fs/notify/fanotify/fanotify.h      | 18 ++++++
 fs/notify/fanotify/fanotify_user.c | 87 +++++++++++++++++++++++-----
 fs/notify/fdinfo.c                 |  5 ++
 fs/notify/fsnotify.c               | 47 ++++++++++++---
 fs/notify/fsnotify.h               | 11 ++++
 fs/notify/mark.c                   | 14 ++++-
 fs/pnode.c                         |  4 +-
 include/linux/fanotify.h           | 12 ++--
 include/linux/fsnotify.h           | 20 +++++++
 include/linux/fsnotify_backend.h   | 42 ++++++++++++++
 include/uapi/linux/fanotify.h      | 10 ++++
 security/selinux/hooks.c           |  4 ++
 15 files changed, 396 insertions(+), 35 deletions(-)

-- 
2.48.1

