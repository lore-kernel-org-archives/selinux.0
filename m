Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C61BF5C
	for <selinux@vger.kernel.org>; Wed,  3 Apr 2024 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712113910; cv=none; b=DdiKCZXWcCkmG1mbPb7uKZShh48Lqve0unIZOp/oCh0nU9ko+se1+z6R9UCBueNKznljciwrP/tCkVdOF+Q73mz6xnCxn6dXYuZHhNFb4OY84V69o7n1HBOMX+S6zOe/X4GqUm++gZOz/v/Qs/mzFB1uqbKjsewW6X7xM6mTF8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712113910; c=relaxed/simple;
	bh=JrM1uuFnTIVBKbjDsmBuCX7sxswHD1aKYDxO96MS6V0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=V92BLM1VNMlKz5UvQG92GWgLvI3WdyINQ2Noge7UMT0FCPtv3tkS1SXBloX2sEswuHHG+oSp3R825vRaV6sVgnXDp9AP72kQfAE++eImhXgEX+pNhYNrf0+Id6tuNBIECkVSrrnOPaeDy+E+2HFHDF5C9kLy5lxOuQ+iR8OKTnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gn+CaIq7; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gn+CaIq7"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-432d5b5f00bso4731271cf.0
        for <selinux@vger.kernel.org>; Tue, 02 Apr 2024 20:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712113907; x=1712718707; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10kPDwtnOEt8AZOr3ERW9xy/nQdgWpYkiYiozTsU2nU=;
        b=gn+CaIq7e0C/FTM3wnme0xjlmWmFpeRSGdYQE9wd5msEJ1e67odLHVokusixkHkG1Z
         SowUMEQfzMJbQD8prpk9GtuzLbE0qKdLX0ptS/emTFqZQJTxwIG8Fr4FabJbocUJmYyL
         Y3ODP7gr2atYEmXCgIicf1tSxSh/IEqI/FCXfFKkueK1bRgj0qynD0SNGa2wNXjfP+y2
         Vtd8ABtS6ujLw8E6cTpnIXFY9vOjw/Z7AMJk8GEKpRecTvJX831XfE9BIMGDxgbjirWD
         r6L+diK6v4E4cazySK3Hy45i2JuIHMfJLBxSls9RjhPD9KHwOpumWQf8TdYGg2BxTRfZ
         cc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712113907; x=1712718707;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10kPDwtnOEt8AZOr3ERW9xy/nQdgWpYkiYiozTsU2nU=;
        b=SCb9qHx+E5x2z2Ni0fdlQ68FExaMSTFm7xrMb/1KDDXzWd4lbuvgJh6PUvkaGsWk+o
         NTTRxsCSQrMMtn6zaM/jwIdw6joXkufFjCKQYyfqFELNDnlgiyMxdUDmctu0dM+PkIwY
         QEdMEhz1NgDWTghUZ9xhhGjczWoy2x6Rwpve/U9/OKkjt4SMHaTUMrRx8MiS/dYP4y13
         iVqtidHO+Wfs1ZPXFiJeq1lIUrG2bkJjAEGBM+M8dPVQQhlzIuWHO5PbYApOSZLZkd71
         ZAoK7JS1Y9uDWiirxuSDRbtNnbRHyuI/+AUTV5HZEPMXWJbaeV3uiGdFzq0sJdu6ukSL
         lQxg==
X-Gm-Message-State: AOJu0YyF7M7d6xOBm5vqLG0PKZy6s+K9xIex2Bq31WzChOIYQgOckota
	OiZ8e2Vy6RKnJjPgMHs4G/TgL17nHLAvqAa4/B1AOA8ZaQMjTYXfyOJMS68nIHXHpr3bsfCt6Z0
	=
X-Google-Smtp-Source: AGHT+IE78oAKuIVYbax+koIpgJJOpn/ZYMkQ/QoOzelQ16IOpVq6C4shR8C6h7JU+WX+5bbERMuWHg==
X-Received: by 2002:a05:622a:1711:b0:432:f37e:d274 with SMTP id h17-20020a05622a171100b00432f37ed274mr2421865qtk.8.1712113907185;
        Tue, 02 Apr 2024 20:11:47 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bb12-20020a05622a1b0c00b00432ff561b2esm1776656qtb.79.2024.04.02.20.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 20:11:46 -0700 (PDT)
Date: Tue, 02 Apr 2024 23:11:46 -0400
Message-ID: <cf11f516883d7fbf75a34f7981174e73@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20240402
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Hi Linus,

A single patch for SELinux to fix a problem where we could potentially
dereference an error pointer if we failed to successfully mount
selinuxfs.  Please merge for the next v6.9-rcX tag.

Thanks,
-Paul

--
The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20240402

for you to fetch changes up to 37801a36b4d68892ce807264f784d818f8d0d39b:

  selinux: avoid dereference of garbage after mount failure
    (2024-04-01 23:32:35 -0400)

----------------------------------------------------------------
selinux/stable-6.9 PR 20240402

----------------------------------------------------------------
Christian Göttsche (1):
      selinux: avoid dereference of garbage after mount failure

 security/selinux/selinuxfs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--
paul-moore.com
