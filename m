Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3603876A9
	for <selinux@vger.kernel.org>; Fri, 10 Apr 2026 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863574; cv=none; b=I/KbaXfVeCFCkfgd4YMnhyOZHBuwy+WdnT/YJ7fyn5Q7iq/qulQuqeR4QJHeYIb7IFgfInQxCND6KDh+Ma0ralKN4YQ1VyNdxlELeYhW6I6b37O1gSkRXzANJGGMiqTusY2JYxSkns2FA2+p9JvylH+QLPACZ1ZNbbqOQFUssmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863574; c=relaxed/simple;
	bh=RjKD6/7f0V5Pv8dDCdBDZirn9vm90RAC+82O3MrCRRU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=fOT14to6NA0AwxFkqDGOxCe3BKs8yEaacUNMwFRSm4HMziyh6SRa2864UgWVjRjaeA2clzTPAYvFr8AgX8K+H4SEkrLE82JNjbVKQBNX56nOuJ05u08kS5POMAUMkySCpNDOTgHNaEoQ9E7Uxa81YsUEG30LQc+mhoO5mswVMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BMH8lXfl; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BMH8lXfl"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50bbc41677dso34478501cf.0
        for <selinux@vger.kernel.org>; Fri, 10 Apr 2026 16:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775863572; x=1776468372; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKeEg/Y0drNcc2Fnb+CIsFkFz7BP00BXAJeV9myWHSc=;
        b=BMH8lXfl4nHqxsnBJVqLTP9jrD/+5fkMOJxB/Znhmp0DO+4Jb21IHM/aW2KZZWseVM
         VCIfAafNwRWsinzuGCrfesC7ysy2J0jX8BDmFyBI1N5cCmHESqXCcYEb5F5paW1U1mJN
         mKEfBa1rky1FrRLCviQ3/O9m0n2GNmmqSTJm76dwxQlnn/LT++cngXGXN7wiaMAAsNJ0
         Y+bqoEr1jAEPORBeXqLKcvSAHFCnGzrWlejOqYEv7hCQStX9cOy6C6gJ8Mqui14OwNSW
         Rd0LXgOeKMQk10cIrWayAY0STjTZMpaj6j2taeAZox8j+r7hv7FkKp1BG5kZBNRJ4GeZ
         7D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775863572; x=1776468372;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKeEg/Y0drNcc2Fnb+CIsFkFz7BP00BXAJeV9myWHSc=;
        b=YZyeWqBJgsA/inokWliGWngEzO7oxBnoctlxBTLNCDtw3Uwjk/DewnURV1mYGkwZ/B
         gHVM150jq/gPqHSh2R8bo4DWPADq9/8irqEnNMebamc3JxerdQYiPnHjdy778qcIU2Hn
         lfxBxfU7sO8Nwtd5sNMu1qlUcYe1GAivOM5PZv9Mi/0J0GuiL3+HhcX0eh3g6EhLOTAL
         kFm+RJeTtWdkdFHfoEwIQ+Fx0rGGDomEmTx6BGIlEIC7ZEz9H8wdtUwq6E4++76HCk19
         GaAcA2O/1D14lw8uHfwhKulSgPjxz/5ztJeA+4GC9S3sneHu0B6Z5wZNl1uPB3FitlGO
         DbtA==
X-Gm-Message-State: AOJu0YwOYeUevVuJVqk8bdi4rsINQfxHVDhmyNf5L3p9yl7ABohORsFb
	R1sUd7Q+eSreckjje3H0566g+KK2OF6CgTQU1kSyPw3Xi+aVnyk4GV+AfYCaD/24ApKsqZcyh5p
	U/GE=
X-Gm-Gg: AeBDieuAyNrN5zmYMjx0KPfMKxJxKdHrb+gephL4BTxhMZBm17duuAl5O2l/f6AoQIL
	fz2osW9onc8JMkhLSqZQqhTYrcayLSy1JH1ratcc4k1PWN7TbiReFskUr3VgjmtxcyXjTBLpEhi
	z1A5o9wFINLOw4gRfQQ7rBGgJLr3lEUn/ls/35IDYXON6e3oPkB1iYtFX5rX+CW8ImrC/gsRXfa
	pH5eWW8NnP5HdIEFDBG9bdkx45U4IMlnvFWbz+x/JCNbetfhNWCokvrq6chbnyTCSqqZhUJCSAp
	QYuLv1jd4L8Ja0ahEMOVqOqK8x/8n4CAGemHxL82nz2TQDb4J/BXALr2fgNNe66KutkGDrBDQCx
	fLBWthJtfb9VMqFWLgYH8Puu2nozB3XqpviSnV/6PcoBwqAfUJoWjBQAFZlYDds3XO/B/YqiE0/
	rSQ9rCnz7cfE1w/3A1f0TI3WOc/wuaqcQ7P6uYEtHIcm9ClQHEFJcu2Xnuz7IAdYSKru6OR7nzv
	uHurug=
X-Received: by 2002:ac8:5d89:0:b0:50d:6d90:31fc with SMTP id d75a77b69052e-50dd5b95d29mr83445011cf.13.1775863572287;
        Fri, 10 Apr 2026 16:26:12 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84c4af3dsm33861406d6.31.2026.04.10.16.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 16:26:11 -0700 (PDT)
Date: Fri, 10 Apr 2026 19:26:11 -0400
Message-ID: <60af9bced9ea23be5deffcb469805ff5@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260410
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

Just a single patch from the SELinux tree for v7.1, although you will find
an important SELinux fix in the LSM pull request (if you haven't processed
that already).

- Annotate a known race condition to soothe KCSAN

Paul

--
The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260410

for you to fetch changes up to 8dc51459ef702bcc0ef5fb26bb4d362b38aa56c2:

  selinux: annotate intentional data race in inode_doinit_with_dentry()
    (2026-02-23 11:14:29 -0500)

----------------------------------------------------------------
selinux/stable-7.1 PR 20260410
----------------------------------------------------------------

Christian Göttsche (1):
      selinux: annotate intentional data race in
         inode_doinit_with_dentry()

 security/selinux/hooks.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--
paul-moore.com
