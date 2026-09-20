Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85228505E
	for <selinux@vger.kernel.org>; Sun, 20 Sep 2026 02:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789870039; cv=none; b=l9QjHM0gRc3WzYGa/yc4CbvceVc7mjG0O6mZ9ZX3xIBMkOK+5esw4nsKz3OGukqi5+q7P+fmlGjyefIFABug6tY8FSTl4pZGpSBgEoXhdCeskzXGbfi/tJtrFsUchKSMhfGghnnblTy3gUB3/AP6RTH/jTSZlvXnB3yZVw1ZCg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789870039; c=relaxed/simple;
	bh=v3ioTneesQ4IhyYIfJxKV4qgKfus9Larac1jgDv+YKU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=eZPfMTZgaJeW5LRtLyoe0LKBK6y4EKVa6kWyimOLTm2nCKTeAhScgj1Vb5ZcIPycQygrlL4anDB3XrmkViMmKILmzOqhUVMpxbysWHdHFuP+vGQWlRGFwyzTgNmYaTkzbD1SHm2B6cTaRtVsbIkzyqOoUcNagpC7FQaUlE03xyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f72xp97m; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f72xp97m"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfe57a3aso19770976d6.2
        for <selinux@vger.kernel.org>; Sat, 19 Sep 2026 19:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789870037; x=1790474837; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G3+zGNgJRkxBaioG5ib3jA+WMEMkM7qf13aN5UYh0n8=;
        b=f72xp97mARjRcuBps6jbRNZ7PRLKmF96Z0UzNvppBVEZEBzPSfC/be0f53Lmek/qcw
         +oEMAzIY1u5NG+N1dDL5Q5Cx6whNdo/Sx/IQ/+REPfHT4SQAY7qUyM7UD0eISTyFgw5m
         /Mn06FdHxgIZ7y8dpKbTS59Uc/wrC807Gpu95w6NFvKGNNFqpA3sB3WqtAVpcn3UdWYC
         0JUiI1ndhrmFhIM5rtY+0wdJBPKIRRa20/iP0521s/pIkzV2bAp9raYshiyojNaTYbok
         K0SmnYOBG0rSfKcd4u9xTROuaWC7wL/ZyciP+DRroV2j2/bZ0OJW0IoAU6YS0Cjblr0L
         293Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789870037; x=1790474837;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G3+zGNgJRkxBaioG5ib3jA+WMEMkM7qf13aN5UYh0n8=;
        b=SxsmSDjpTylxuQe/+scFmG/hhOz9LuHaSzphZdQnamED3CFjLx74jUGy7Q5gIJh92c
         ony7Woz/QmGxOlYQPrgp2GDLSdGy9ZAwY0f1hiG34HAP5rvDBs8kfS1tNgjUvQrnxk15
         qy8RYY1BfCSicApd4La5b9/dfW/NZmXpRJA6bw5NDZp+jOJ9sZ5kIhmfrC+ceMPwuvLY
         1DGA9ARxvqFOVisAf6hiwyfmEOW0DzQVI5U6N78rRRhBVpb7pMbXs/KeCY9mkbJgPZ5F
         rssMdOr+/1U5f5TKqJi/7GniS8dGRdf2l88weW8Iha3NHz1pFvKQFpu40+dLRg831muD
         zqzA==
X-Gm-Message-State: AFuF++nzntqkNzarQpLFZ4ueCc/O0rSODUgMnfmsM+MRXqHNIF5gpsgP
	FkFSThNMeS1xeJHaAQoOyIk2dGxbwVneZIvXkqTlECSy19XllO1xCtoDi62xbxgXGg==
X-Gm-Gg: AYBFou1gomTJTRqCv7J5HQSW6sHnkrv2kmgINZmucqNbTHoIzoz99JjZG510aPXxYGp
	558TghS72Jweau0pfGAZEYWRTXIWDsrVlRrxUgf6JXYyttvzmPMa/Fdhdio32oaHM4hslO56AJS
	XDaf80i+kf0B4e/k1nD+0c8OY80vHm6Mte2w4eelb5/GLQe04kzkdi11tHGqbXc4UxZtwdTiNXk
	ky18sMtDzC0ZEqb6oKG40ZRkITEfso/sfDC0jyoZC7WJ7+WE0Vf6NT9H7ULgDcHHHr1Kkc/dAlE
	z9ojVn4qlCYdWK6lpk0m7wdJXo1iLLLaxhiuMctXMMlCMG3UnV70kVLqca2937QkMlVh221Uovk
	j9nGVPqF0YQm9UOziuXWVyE8biByejWqLdYVQy7LQetOGYS6+G+2lBi+DCxWghNdlN9lW6OBTrZ
	yyprsuROk07C1GhomcM6iHp76O/TZRJQNNbcmqCscoJJWqztinn7GfGhxYY5L4oNSdzTT5LL+v2
	5KxrzedENEO6oa6wgRdLGCEbStj0vhN0DXEcb/EW/utj4h7UcpgJSoS4/JELHX2lfbJjvj/loAL
	4w==
X-Received: by 2002:a05:6214:ca8:b0:912:5951:179b with SMTP id 6a1803df08f44-912a8017caemr43115516d6.30.1789870037098;
        Sat, 19 Sep 2026 19:07:17 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260aa1c03sm33242166d6.39.2026.09.19.19.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 19:07:15 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:07:14 -0400
Message-ID: <932d0e418d78fa40b5d18951a34876ac@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20260919
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Linus,

Three fixes for Linux v7.3-rcX:

- Ensure that the cached SELinux access decisions are correct.

- Fix the SELinux overlayfs code to properly track the top-level/user
information on multiple stacked overlayfs filesystems.

- Fix the SELinux overlayfs code to properly enforce mprotect() access
control policy on all of the different layers in multiple stacked
overlayfs filesystems.

Paul

--
The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20260919

for you to fetch changes up to 78fc54b934bfb2c18aad8154c7302067146946f9:

  selinux: recheck intermediate backing files on mprotect()
    (2026-09-15 23:30:07 -0400)

----------------------------------------------------------------
selinux/stable-7.3 PR 20260919
----------------------------------------------------------------

Christian Göttsche (1):
      selinux: always fill AVC decision in avc_has_perm_noaudit()

Karl Mehltretter (2):
      selinux: preserve user SID across nested backing files
      selinux: recheck intermediate backing files on mprotect()

 security/selinux/avc.c            |    5 
 security/selinux/hooks.c          |  158 ++++++++++++++++++++++++++----
 security/selinux/include/objsec.h |   10 +
 3 files changed, 150 insertions(+), 23 deletions(-)

--
paul-moore.com
