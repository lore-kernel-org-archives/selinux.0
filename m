Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05330393DD9
	for <selinux@vger.kernel.org>; Fri, 27 Mar 2026 22:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774649104; cv=none; b=WM3kRo1wN8P9Olj2GGFM+7/v21L2RM4+FMRclB3eGyxd097OkRROIcxgUZ3yClOCYdL4uGHUJX95obdGzvU/p7cmGw6WsOdpcZEgIjlw7WNn2rtGfZrd95FcT7hur+8g1blE/OHry1OOAihLWJqFUhL8Lkd9m8MhkzAtZaSyc1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774649104; c=relaxed/simple;
	bh=Vzh/+jHRIGpmYHe5gU3rnLfig2+dnLv+37f6At4au3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HwLuQ60Dfk8XY1MpVzjNKO1LIGGW9993Ql5AFtROan6CZMq43QHQxlyz9aP9p3W8M0EjfBbfoyvlF/drRjv+MMLVil52iWg70lOogmVN++VchLsyhWSQ4+A7BstkFr4eG0ql4MqH6+TJw94TqFFS+JNDFsirH4C10XD5C42PPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IgQPajF6; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IgQPajF6"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cd80f56b27so256978685a.1
        for <selinux@vger.kernel.org>; Fri, 27 Mar 2026 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774649101; x=1775253901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3S8EhNAp/M6HE2VsRMXkSr61L034glOOF85HPPP/Kto=;
        b=IgQPajF6Uy4Lc1BNZuXYBleA2pUwwbgrEuOvuCy/0CZabfdMsZ7+5d57l1S3FnwstA
         OTOatZXgxkh/zsiFRc04C8Z1jNXJYmNggXq5qSPGHV97szdfMiHy9H8XbwvhwaamMok0
         hl2q2i3dPAUM+MvhcX0ctzsa+FIQtCkYy2R8LzY/Ndjqt7Q7a9fL8tfYXdlDq8jPKnY1
         3biJwgyJsJEN66x5N3LeNtFT/TA5MhlHBAagM+swABLERuYdPGdO8YnDNkSt++CCbznR
         Nnqwxu+7tjSC2l5wU9Rzv/5RbRl8OnenoesZU+9FprjLc/O5y8tA265dCIfgaeAX0rVK
         xFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774649101; x=1775253901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S8EhNAp/M6HE2VsRMXkSr61L034glOOF85HPPP/Kto=;
        b=aUHRR/Nu8nO/sqRxae0zyf12DXnqywY4zJUAbkXeRxsodL9l1B9rfW+bt6z52KFnLj
         7GpUX+I2Lu0xYJfbegwUN1hV9a9EyFAffyNKcASheiOT71kkxI097gEVdBBhl+U8AhIF
         i/I17U/iMOdie9V6a0zxcXbdMvuZfUFSpD4LAV6uGkNT+9VsEEMm4+tGfqYdeT2+h3Ry
         Ci0GDNuWpP1TI5ythjs5EfYQf4aWnrhovQQlgPxrRW4ppLKSTNSfn0Q0QTSCwaOA17SH
         ErfuxTQ5zvkQIOZMjvAZkGTZsmfhtsG5gVvGaNU/qVwMV4v1j1QGoo1LuiLoYuLPyHHz
         Vi3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPWIATsFpha9ufEhuCBoqjar0qcaQDtPWHTD3VnDUAniBYQAlKS+jN1juF5598MtiJphWC4i/U@vger.kernel.org
X-Gm-Message-State: AOJu0YxmU6ErayPlBM7Hb5PqkL/azvgnaN+qvfpmTaaVOs0/hPZZsuIO
	xYTdJ26fmoXCchd/b32vfct1RddsIjFGzb7Hi0WUFES0ceFB1GZyewmeNh1p3gsHwA==
X-Gm-Gg: ATEYQzy3Ux20c62mx6n4XSfChYDj5LtXeIJn7agb2qZN7yqMYtoNA1GqM5JiwZUBt5f
	05Eh67BxdfFM4ethxBbpf/lu8sqMsY60CGDsTDp70N2sXZKBraIqYOqaPKjpZNybjZ7K9+yeBFQ
	X0ka13SDMdX/9KU+ww9I8bBpx44f2iheG5HLPjXk7KG81JlNtLdw5FWUIH4DM3w+/1mo9zNMS64
	j6Ldz+G02rkkVkMPVgLetbVMNKBNvk6q5OQ8R4hKYI46hZz08bvZlKeF45o7ia5PL91NiFwY0ie
	ywSjNtj5S4RnRWI3cFqx7jFRH70k4ntT8WsDq4/vAnBsqmMOAjsOOLXKfGY6oXoM2Q3IA1g3Wcl
	1oQnkKNbeGFnf28sPRumv3BkTBZnZdqNONgLr0ixHyRzzrbkVJp0Y7ej/LW1OgpNNTcMsqYktfJ
	BzmN8er4jFmiAiKwc5dm4BwR4A2IPuvSnYuQUqOwWJoN2mNdqRx7F0rqXGZCFCl05kF3b9nCyR1
	cUu5tw=
X-Received: by 2002:a05:620a:2944:b0:8cb:52e0:15e7 with SMTP id af79cd13be357-8d01c621d51mr531573385a.33.1774649100763;
        Fri, 27 Mar 2026 15:05:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edb8ebsm31425685a.7.2026.03.27.15.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:05:00 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 0/2] Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Fri, 27 Mar 2026 18:04:31 -0400
Message-ID: <20260327220446.353103-4-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A very minor update to the v2 patchset[2] posted earlier this week.  The
changelog is below.  The primary reason for posting such a lightly revised
patchset is to drop the "RFC" qualifier as I've had the opportunity to do
additional testing and I'm reasonably happy with the results.  As always,
anyone reading this is welcome, and encouraged, to do any additional
testing they believe might be helpful.

I plan to merge this into lsm/stable-7.0 either later tonight, or sometime
over the weekend, so the patchset has some time in linux-next.  As we're
fairly close to the v7.1 merge window, I may decide to hold this for Linus
until then; let's see how things turn out with linux-next as well as any
additional review comments.

[2] https://lore.kernel.org/linux-security-module/20260323042510.3331778-4-paul@paul-moore.com/

--
CHANGELOG:
v3:
- fix the LSM hook stubs (kernel robot, Ryan Lee)
- fix the lsm_backing_file_cache allocation size (Ryan Lee)
- minor style, simplicity tweaks to the SELinux patch
v2:
- remove the user O_PATH file patch from Amir
- add the backing_file LSM blob and lifecycle hooks
- update the SELinux code to reflect the other changes
v1:
- initial version

--
Paul Moore (2):
      lsm: add backing_file LSM hooks
      selinux: fix overlayfs mmap() and mprotect() access checks

 fs/backing-file.c                 |   18 +-
 fs/erofs/ishare.c                 |   10 +
 fs/file_table.c                   |   21 ++
 fs/fuse/passthrough.c             |    2 
 fs/internal.h                     |    3 
 fs/overlayfs/dir.c                |    2 
 fs/overlayfs/file.c               |    2 
 include/linux/backing-file.h      |    4 
 include/linux/fs.h                |    1 
 include/linux/lsm_audit.h         |    2 
 include/linux/lsm_hook_defs.h     |    5 
 include/linux/lsm_hooks.h         |    1 
 include/linux/security.h          |   22 ++
 security/lsm.h                    |    1 
 security/lsm_init.c               |    9 +
 security/security.c               |  100 +++++++++++
 security/selinux/hooks.c          |  256 +++++++++++++++++++++---------
 security/selinux/include/objsec.h |   17 +
 18 files changed, 389 insertions(+), 87 deletions(-)

