Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1F11A0BD6
	for <selinux@vger.kernel.org>; Tue,  2 Dec 2025 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764640847; cv=none; b=hWgPE6idwnDs3UNdhBsYVRTAZJQp739DWFlpw6ffa8XFTmmEZK8X39D7i69Kt2yfIpyD1fWGIBJa4zo98HTw6wqwYD3L9DqsM+3OoqjY6kM6NuUgD+uwg4EcAX1LCoGzOwiUnoeuqM6UMIqjHBzW1W1l5FDsq2MO1XEkLChw3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764640847; c=relaxed/simple;
	bh=jIor6HZfBVDSpqYaaFhDlLF+FN2tt3dPpZB/qWbN1Dk=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Aj94scf5BfxsMrKd6BvHddYGy9gPUN9KqyaxzWSzK1DgVHWHFfqLMZKkrMDf8Ef5jMoHSTzgsbCNKEeAqeQY0j99cAvqTqDptv8f8uYXfe72LY+xUFR78QNiNlSppfwuO59R0fXaN9I+iDqcVqAVvo1lA6sBicNv6SCRHsR3f7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WEYmaHnX; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WEYmaHnX"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2d56eaaceso476789085a.0
        for <selinux@vger.kernel.org>; Mon, 01 Dec 2025 18:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1764640844; x=1765245644; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah3Feu6sAO09lbeHSVtb4lWfsmSbB0P6fly/Y481iLs=;
        b=WEYmaHnXEra8N0eFhIVkq5f2/wIRmtdI/FontWN8JLkOcFafGgY6wi0zHDht9sGQB8
         +jDkscY3fI+Q3s+EP6a+2s3hi+uPGOVEx3Ryfu5R38OPtTUlHmSN98FYtVdhDwgA6Z+n
         DvCtnnERjvJeFKhHszRiSs3fXCkePzQGoyhP4ulA/qzw/eZFfqgMGd58ZpZ/+VqKDaGr
         ejThqNAwbaVo2Aocsd6U6tASHAoxk81TqvBFrLB5EKFy/Vlg0kZw3B3ZDKhTRR2Ll2it
         iHdRsG5M1xzRF26gvrWWbVYxfkAUu2idj7heFqn23HFGu6vJtl7HWZL7Yw7V0vu51A/d
         N47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764640844; x=1765245644;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ah3Feu6sAO09lbeHSVtb4lWfsmSbB0P6fly/Y481iLs=;
        b=BihELRJxMmgikdjK7Qdf46JjqTxlXWfORku7udu9/9EFhGkUUvT9RobS+WMqp9c+9H
         0oGIb81PnHcRS2Nuzk3h5pCvloOFUxkxyY0uIIGWTgyLDlx7WpeynAUtN95c1KLx+hd8
         5TQ8zFPwrkPiqfeWE1jWtnHnyFGfCDkIa0Uf45JlrbRYidual4/7oWuZZEB2P9wHMExr
         ntWIIfZn4l85p6IaGFyly8zPlDHIQczxJLYPq183hzhgUC/Gj2eHC+3IB6Ee96PUFN4W
         DqhtQZfmOaI/ZG8kzX3LtqrnTwT5uMumjKrqG1UH/JaLQ3opdn07YeKSs/zxBWiEzJTH
         Xh9w==
X-Gm-Message-State: AOJu0YwGLPvgtYpwTucH8JWLPymSg2J5cWfzfsw/ZCdMU5Cd5M9DvbZj
	CZsHE3M2WJUOOxq4AvZWqaN23Ym/wp7u3DwZxSlzpgAjiFmdyblFRdPPXg0CuAQbvKtOFEsD0+9
	YS+Y=
X-Gm-Gg: ASbGncu3B5ZjFPzpUWqr1icbxMgJGHWv2oWW2Rn4HjjXS7LumV8AmQab3NYi9+qZq0+
	RuSzwFVIBI3UO3VSLTa+GKSiMYkZdDRCU96qGM0AFpav2652eBvPM+BghLPvxvv61dkz1Rl+ix4
	1kkYaClRX8ztAdjd8qOEfGdg+fc3fJdtTp7DVf1UPIILCGRhQRIL/s7qqqV5Zxgs+VoIQo9rBGd
	p1IKLOyVCWxPOhPABGgZrRXdXnk1Did47Auw8ynQKCc9dHwLF/1quPwsMsmpGeQkJEFfLieOSqf
	U4Jt0IJdsJu4Rpw6RYNR9SUp4S5qKpCe91YvM7F5DEOkqDP0yyTsOUkdJzhMp9a94Un4XNlPTnv
	AIR9meGTjWmZPBTfRDjkljcFlNgKo0te63Odcpi9e7RgQH2wR41OnQ4t64b1Riv/s+QnIR6uBdD
	WBPIAMgiS0VfvBfA3jLUV4wV6FHsV8SroLfSuwaZXRLD1CBSR5S7Y0BtZM
X-Google-Smtp-Source: AGHT+IEwvuzceuk/POjZI3s8E+Cqj8tznNYRNViaB0HVGSt9OUapuyEOJ6ghH8dfJwYlFthpdc9RXA==
X-Received: by 2002:a05:620a:4141:b0:89e:99b3:2eaa with SMTP id af79cd13be357-8b33d1b24a4mr5849567985a.8.1764640843938;
        Mon, 01 Dec 2025 18:00:43 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-886524e1609sm94731756d6.17.2025.12.01.18.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:00:43 -0800 (PST)
Date: Mon, 01 Dec 2025 21:00:42 -0500
Message-ID: <c48b683b30a44eb12a0ff032876386fd@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20251201
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

A handful of SELinux changes for v6.19, the summary is below, but I
wanted to call out a merge conflict caused by the recent task/cred
changes sent up during the v6.18-rcX cycle.  The conflict does require
some manual intervention to resolve, but it is limited to changing
the "SECCLASS_FILE" parameter in two avc_has_perm() calls to
"isec->sclass" in selinux_bprm_creds_for_exec().  The
selinux-pr-20251201.merge tag contains an example fixup of the merge
conflict.

Here is the pull request summary:

- Improve the granularity of SELinux labeling for memfd files

  Currently when creating a memfd file, SELinux treats it the same as
  any other tmpfs, or hugetlbfs, file.  While simple, the drawback is
  that it is not possible to differentiate between memfd and tmpfs
  files.  This pull request adds a call to the
  security_inode_init_security_anon() LSM hook and wires up SELinux to
  provide a set of memfd specific access controls, including the ability
  to control the execution of memfds.
  
  As usual, the commit message has more information.

- Improve the SELinux AVC lookup performance

  Adopt the MurmurHash3 for the SELinux AVC hash function instead of
  the custom hash function currently used.  MurmurHash3 is already
  used for the SELinux access vector table so the impact to the code
  is minimal, and performance tests have shown improvements in both
  hash distribution and latency.
  
  See the commit message for the performance measurments.

- Introduce a Kconfig option for the SELinux AVC bucket/slot size

  While we have the ability to grow the number of AVC hash buckets
  today, the size of the buckets (slot size) is fixed at 512.  This
  pull request makes that slot size configurable at build time through
  a new Kconfig knob, CONFIG_SECURITY_SELINUX_AVC_HASH_BITS.

Paul

--
The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20251201

for you to fetch changes up to 20d387d7ceab95aade436c363927b3ab81b0be36:

  selinux: improve bucket distribution uniformity of avc_hash()
    (2025-10-23 18:24:30 -0400)

----------------------------------------------------------------
selinux/stable-6.19 PR 20251201
----------------------------------------------------------------

Hongru Zhang (3):
      selinux: Introduce a new config to make avc cache slot size
         adjustable
      selinux: Move avtab_hash() to a shared location for future reuse
      selinux: improve bucket distribution uniformity of avc_hash()

Thiébaud Weksteen (1):
      memfd,selinux: call security_inode_init_security_anon()

 include/linux/memfd.h                      |    2 
 mm/memfd.c                                 |   14 +++++-
 security/selinux/Kconfig                   |   11 ++++
 security/selinux/avc.c                     |    9 ++--
 security/selinux/hooks.c                   |   26 +++++++++--
 security/selinux/include/classmap.h        |    2 
 security/selinux/include/hash.h            |   47 +++++++++++++++++++++
 security/selinux/include/policycap.h       |    1 
 security/selinux/include/policycap_names.h |    1 
 security/selinux/include/security.h        |    5 ++
 security/selinux/ss/avtab.c                |   39 +----------------
 11 files changed, 110 insertions(+), 47 deletions(-)

--
paul-moore.com
