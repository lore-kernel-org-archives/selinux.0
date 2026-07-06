Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C888385D77
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348663; cv=none; b=HcPYPVwVqu/lL6AmNS6LDkXlpM/s83kMk4gn6EJo+03OxUldbSUeglZ2w71uRrl53qwc5O7B3VfJ5YDcTDOsd8RiXIc0D2L2yfgjP45pXfBDLham0DuDew7beDKWNioBS91XGMkrP+fuj1J0GaYrvWvqNDTfCekziR/e9q7YLG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348663; c=relaxed/simple;
	bh=4tWpsvGXjaO2Upv5bOZJa0LxxEynw0RyFhDCQzzWrzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aitkv6GR1hz0f02XBttCALQkcmifL2vjfpPG6EtrKXlPnrwB2fIc17X9KVR4dzYRvVn/dmUZ74YoLXzbO3dA/OkTgtQi840iYasQJKcRfM2z5HETc/c8HAyJ5i2P2osp12PxroB+jSW2PEs5KPwihwaimNkgorucJAtdVKvBiOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnJhHado; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnJhHado"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8eefd4a8057so22695986d6.0
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348661; x=1783953461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=77fZ67NC5TLtvlHtWVKO+96vhkPWdG3xHwxDoVnJcCw=;
        b=UnJhHadoy2uKkXPWQ6WluUc6t39mSFhpgRnKjPi7f+dhX8cyvC+lBUie5HvqLODC6g
         848GRbO1CGPNpM7VHsestVSNDx6X8TfjOrwzcuxFda66LWCj/wtWP19RPje7nY37B5cz
         wgD7uZCL+s8feJt28IlVLavVyfbsi+E75PIkgB0FDGJ6RiBoiEh/l5165Nwe4ZbSvUp/
         b88MJRwznG4ga9lfy/eWeHRCQnYUT1J6/sZV7JJz1JBOZqvR1pCbJwr4JHqL2xDJHGij
         jU9e5lEKc1P4E8CHl8gwjL/tS5e/+9X+wW9bVC1VXTyqyXnd3R1J/KhogjatjGsQVLM2
         vhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348661; x=1783953461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=77fZ67NC5TLtvlHtWVKO+96vhkPWdG3xHwxDoVnJcCw=;
        b=CmOBJF9SEh1BYIon/uFoQ3QuyzFd6ZHFeBytRJtuxb81G8fQAIpgWI19pybmIo7hhJ
         /9CXfu5AmhaRw4ALh2D5bFYc3jfLfI5u201U1eygxq5S0gl/kaRAOipQxF9EJKZzwYb1
         mS7QkGScG0EoNN63UZjNCdr+2jB89/2q1ER9TyMMS7zEPEcUE1rXXX7vTAkApAGTkmN5
         k3XP508xQItawkOQrRjn1HGOogl59QaWhxdjx2r+/onVgdUlxDX+A4MJMJKgZMZdAMj7
         f9QJPzzuX1VWwgBgVAtNXsVtgdVqEeGLLAq/Y6tYBo2K0fAPzRXenowsdhMJwgw9rc7Y
         pfqg==
X-Gm-Message-State: AOJu0YwmH5+OsYtXDLXLF2o/Nh77Sot4BmAiGw3jrzwBqu1c3QgD4cx2
	EeMyjTFhRsNcvF2lrqzyYtHRjigSuraLCz9LTHbdenklehRTAw4aeJmqtZ1yYg==
X-Gm-Gg: AfdE7clbbEgDlVmhQsSUU6gZV3CR/NpPmsF5UZ/G0bCU6YRu3uzkw4J7NxFEkqECnwB
	HTP4yK4v6qBSW10h/KE8Cxd858GUSAyYGsgotFZlCKUAN2tPsPiWSuao7Gz5OaxhHuMaY/CE49S
	aWF/Livh1IPEnM05aic3t2ArHN1XJqjW1g2CEhUg5a0f6mk8Vvv5in2nYlxORqXNYwztLUPxtix
	Yv9JE1sY67OIC7I4M3wWSitaLljNthXQgt22fQW00VEq+uCHSNsU8iQ3p4Mln/rRH68A4SighaY
	UN0g8bxgyosL1D/nu8XlQ7g4Zvb1+JrMz/mGaCsMnZtAZXd2Rf1pT4ELTLxGrwAKrWp469PGb5s
	FhZGfwQJaOajbtsOf2M6BBSQWLb0KCBxdTUp7B1Hba++De8/4b9FOJ2yzN6OIWyXcg30kWwPklc
	17t41ri9upRt98UyQit9WgXPVDdWpZ1cHoddc1MxBGA6Wkcz5zU9wBal9OAI5FRpNT3N880JBep
	6dYByDrfNcNkkjL
X-Received: by 2002:ad4:5f88:0:b0:8ee:e686:1b24 with SMTP id 6a1803df08f44-8fcb50e76acmr8267366d6.45.1783348661236;
        Mon, 06 Jul 2026 07:37:41 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f304533sm136972416d6.18.2026.07.06.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:37:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 0/3] userspace: use openat2 if available
Date: Mon,  6 Jul 2026 10:37:23 -0400
Message-ID: <20260706143726.47421-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the selinux userspace to use openat2 if available.
Fallbacks are provided in the cases where it is not available.

Stephen Smalley (3):
  libselinux: selinux_restorecon: use openat2 if defined
  restorecond: use openat2 if defined
  sandbox/seunshare: pin_dir: use openat2 if available

 libselinux/src/selinux_restorecon.c | 23 +++++++++++++++++++++++
 restorecond/watch.c                 | 23 +++++++++++++++++++++++
 sandbox/seunshare.c                 | 17 +++++++++++++++--
 3 files changed, 61 insertions(+), 2 deletions(-)

-- 
2.54.0

