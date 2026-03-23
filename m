Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D1285CAE
	for <selinux@vger.kernel.org>; Mon, 23 Mar 2026 04:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774239925; cv=none; b=VtHUMafVTJgXIGBf+kWdTqKqwkZN2EhJyjiMWWsAy/ISs8L07Nr0itWn4g8ZjByDj/ZWp9Z0/cBIPBrf5Q87+rqyh4gm71efAG0Gedb09GDtJJa0YvszHdyD268rW743+3312OPXlfamZBLalojTE+PbwOETuZOtoGa3FRrjVkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774239925; c=relaxed/simple;
	bh=9CQVC13UfnGA+k7t8MLBC3z2a9+S87m7Va2FqPx1Gpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5xLv6JL3UVxGrBIX+2jTRZTmLCzTcXpUoOKGFjMFEv8rk51VsC/xyga2xbnuzLwnSbn+c8ZCySq6+ow3OcfPyGqA30YF6UIHqNF6P/bBO/t2RwMYrBC3/hCWHmse+oDQgHXEjcBC3v95sI2uK+9tz//2RG/Q/490HsXUJKNl5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L7SKQgsw; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L7SKQgsw"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cfc1aced74so385062185a.2
        for <selinux@vger.kernel.org>; Sun, 22 Mar 2026 21:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774239922; x=1774844722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHNU+T5mQ52dsDV+e3ezWpkvnj+dhj3Dc5R6m19Ae3g=;
        b=L7SKQgswiIi65AfM5bbqq8OwWMKTtk5IxpH57PRJEwNgk5XIG9sd2XkEr2ase3CRU5
         8CTiFME0Iaj8RCJ12hHPnbbZfgliDDnVtOKT5tfgr+e3I0bcUR8olKXpMhPXyH69ue1z
         lHEcJ86UIYZKbhQ/ZB7veE16p/01zOzlXeGTWseFkZr9X/+/Fio+2U4SaMuP0Z8btpJs
         lTVgV+2hlad3dtZdDMVmqmraKMNWdqLiSXECCfI0ZC66T1TO0uDqCXPVmtmcN0IlST9Q
         tFBKSn8TFbDBvOxc4ufU+YbJfHmalXKa+ro0cDcq71dMK5JL/BeE9SBKCo4ibyA52zwo
         lrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774239922; x=1774844722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHNU+T5mQ52dsDV+e3ezWpkvnj+dhj3Dc5R6m19Ae3g=;
        b=HRlWhJ5dymVpM53nycxRFaFSsFPBk+pV+IN/i3Njp9OG92rdZAi9Zl2JCl/fn6uCNT
         kDEM9XgMEz8fTncNJZqwkA7SINaXzEWQycRTQhNDIp3GbWpMLsgXarQUYoEpAOfj8NNf
         UQqa/Ns9mfF32n/yhVk9xelLccUZnfsOOowNaDFHlca8+1bJMIyl16aipMfzGw05SMy4
         9FdC2dSLMmpPHmrRuPz6tqCbAq8Sjh1PehQfcvUAMl5GBL5b/sEkCnn54EHR2n2SVRY1
         sVZ3Qniose1smWVowiKAJH4dZ3nUK3qBefHlp8yliw8okdKyrbbY8OUVKnQjGEJR7czO
         Y0tA==
X-Forwarded-Encrypted: i=1; AJvYcCVXAc89vOlSecCuCE53PRTcRTL7QIddUVhJSLtWez4Thzo4VcAwrkDhuIoHpaGCcgKjHNe5ymNH@vger.kernel.org
X-Gm-Message-State: AOJu0YyWdwtzluNadf//XyaZmtlBlDLx/KQgYz394zcu8QHHT2aEMd0B
	JM0EdIm1M4aUTXkHehUtq4Ugdr+hHfWtFOUOqPsEoRGaNn94D/J09U/gkK1saaqQWA==
X-Gm-Gg: ATEYQzwkHWKCw2fM8O+dSYwsSjQjzSQx8+MMv85FslC3/rfUB6dftmm2mFDh0diDYfp
	yKUe3DtiCPJ64nyGaSXrIQoN+axJTG0jUBvoPXN0r+OcX1De+F/cjeU7DP0Q7z7OA3iuUrWaB+g
	82zj6ZrI6NpzVkqILA2UTlmJwwCG6WGpSg+PW2pemJAqjcp4Z/D1S6jNWrxQ6JaSyPowtxKWqkS
	HokdFD+M7rnZkeeusYUyz69rnUJxAxBvR6TjHZlRnFOnr6I6M1+zHT0Sxy7dKwEoMArtJu12UK1
	++XoNwkKuu0wiC8TaOXhhmqW5tsJLGP/dLARTetp/adv6vm65IsCRfNK3zp5yYHPq0sXBsCK17M
	sjQfZwRiAk7Ef7ZXQH76HuQeZk5i6rJsiblitkgdoq1c+Av3N1A5coo0Y7kzVkk0gU40GSmhVu2
	vtyZ+2SWalil4LXfTL7z61OrgB2Bxubgrn+ggyr+At4er3FL6KeY9jtW+yCupOgpcHMIPL
X-Received: by 2002:a05:620a:3193:b0:8cd:94a5:2f22 with SMTP id af79cd13be357-8cfc7e6d7eamr1552756685a.20.1774239922032;
        Sun, 22 Mar 2026 21:25:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc8f5fa29sm677110285a.10.2026.03.22.21.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 21:25:21 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>
Subject: [RFC PATCH v2 0/2] Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Mon, 23 Mar 2026 00:24:17 -0400
Message-ID: <20260323042510.3331778-4-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up revision to the patchset[1] posted a week ago.  This
second version has changed significantly in terms of approach and
implementation, as it has become clear that the overlayfs/VFS devs are
unable to make the user O_PATH file approach work.  Unfortunately, this
pushes a lot of the complexity down into the LSM, as opposed to the
backing file code, and will likely result in code and state duplication
across the different LSMs, but at this point in time it doesn't appear
we have any other options.

I'm marking this patchset as a RFC since I've only done basic testing
on this patchset, and I still haven't satisfied myself that the code
covers all of the different cases.  Additional inspection and testing
is required, however, please feel free to take a look and comment on
anything that looks odd.  As always, additional testing is welcome and
encouraged.

[1] https://lore.kernel.org/linux-security-module/20260316213606.374109-5-paul@paul-moore.com/

--
CHANGELOG:
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
 security/selinux/hooks.c          |  252 +++++++++++++++++++++---------
 security/selinux/include/objsec.h |   17 ++
 18 files changed, 387 insertions(+), 85 deletions(-)

