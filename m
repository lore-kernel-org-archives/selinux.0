Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E118261B9E
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 05:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043150; cv=none; b=WmsnkV5NE9TJxfxeefp8VUPLVD/OTvWqeEDfdcvLdAof1t3zg3kUvP/c9W/VeGeoQev3/ieK00apr3OP6L1/fJ9fkylzAfWiuFhhdGLDTrSLLYJ26ihjCdNWZPaEI39Ho3QPjr/m/3ouyO/++3Bdcy828IGNXmOuFEeUle+FmDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043150; c=relaxed/simple;
	bh=t0Fsxt7MKE3arJIPm9lUU+0KCO8LtWu2GPf40W6p9zQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CEvehGs3kn114VwO24rK0ihZectUb7nX0wUae4hyU+Eaeo4DBOdbLWHk3PcY28+pyWVEe2uOQxxC05i5i3C5ySffpsfn4Aij6FdJWhB95amWZlvJb4ZsFXREr9I7gCMAMfx7UEvX9bww5H3nwMN5dZhGObfK5nl798SYCH5aeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCfdsoCI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCfdsoCI"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1ad2e2391so18921275e9.0
        for <selinux@vger.kernel.org>; Wed, 14 Oct 2026 22:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043148; x=1792647948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3h9x58mhlFPARMJmWsyLCU2+ECaqeJPNd+7pH27kE2U=;
        b=RCfdsoCIIOALRyRT+wiIoO0rTGaGs6Pj5m0Yxe1A0gqXlCY2wRjWwZFm1KFzXpf3ek
         3+DmW3PPGpqE5l3RvqXvkq55U14LFhYi++jHDC4j1jv24SbeEwSIcuzP9LVQXh1gejrE
         58kdKP3aD+0RCH3V1FzMtBjm9ZD6xmQubUfTtZhwxOcsqXe5800svgzusoDeB1wgbjNf
         QPK0PRDC5VkHAlyI6imFUmj5Dq2tFEUfPQdcbsVQQZa+wpBUNSW3ZRQii69aVkF0Ut5F
         2FUWelL1vx3looFxqAPq0jpCVNntDY5NLNWJjE2RmY07ufbUkgnymihAsaL+ORdRCuvO
         Xh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043148; x=1792647948;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3h9x58mhlFPARMJmWsyLCU2+ECaqeJPNd+7pH27kE2U=;
        b=da22tbnhV9OFs9syTthtzyJMDzwwv0PDhTqepKOBsFwb/sFMKeGz26V9VVH3Q2llpA
         jVDETAKyXMnV7vFizn5QQ9ccMJPGAh4maJewAtVeJbM9mzjREfCD2t4R2EwvikoPuHll
         BT05Nj9pR5deWGlhpyuDurwaOB2lKBt7aogWKjEHeq1m6nJ8pf9+9JsXzjEwoenvYaNF
         86ZA9WWfpw9cnWdZUyLJ2cm6zkR6OlNDaBGY3Iy7cW3cCdPkpDk6gLJrnZegKCm3U1V6
         05mSNkIJ6NTxFPh3VN3brAChtCpVRoZgREzgm0CpWLYLuqaMYPS7Irl6PSwqMu/Jqf2g
         i0ag==
X-Gm-Message-State: AFq9FYLmyyufoZ9CRTaLlZ/0Hw5FQPl0nIYqULA6TOeALPqTRC3w9Sdd
	flv1Nyt8q0yaQ94yu60fHwU2YtHmSSh+vnfNF5gigEEAcUl3CNsOqpDVjg1TVQ==
X-Gm-Gg: AYBFou0nJMshkrC/0bUsuzWr3b+WgHoBb8WEZeq06KvM5JV+S+SsH65ee46RYhb27ea
	ICpeOLz4ArB0JbFPXxVslhVR7+GizXaJDZS4F0BWoXA0xzZkEX+ph4r0MHc71JR19x/C7TIgmUC
	OaC1eCNS/xQi7HU8o+m+XdUFuPoIpSx4Xt8Hf5iFAR6il6Y0kmeNLixUEKaLnl3kGNrqLqfkyw6
	V2vQr7os1FKlGayZRG4B4hFGqBv6187TLxAj+YMFrymebMYXxS6/Ag6vXCTyXG5q8EvjFlgNoRM
	H+NWJ8keWlwkp5qewSaR0Si7w2lQ5U9u3QA3eviDZCQMeeGH/Cv1DMzerzx8bFF1wzh1/c55CST
	/XyfNVaHSzN+Zx6zo3vjkJsJzGtQnveB8iH2xu9iDD4Hjf57Jn6Ux5a34aWsFDDhkbbL+EvyaxG
	qHrkemKCDi3tO6ko58Z4ybhppFPxoknXfeVGrGYfdPe5KlagCifuLrtHk7+wF5pyjkiGl34tohb
	9XF7NQ9CezPV2RccGL4zI+hsg==
X-Received: by 2002:a05:600c:1c21:b0:49c:cee0:f383 with SMTP id 5b1f17b1804b1-4a18e4b6241mr427989725e9.16.1792043147627;
        Wed, 14 Oct 2026 22:45:47 -0700 (PDT)
Received: from omos-acer ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdbb4a30sm41982805e9.15.2026.10.14.22.45.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:45:44 -0700 (PDT)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite 0/5] Misc CI fixes
Date: Thu, 15 Oct 2026 07:45:30 +0200
Message-ID: <20261015054535.844874-1-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series works around/fixes four issues that are currently making the
testsuite CI fail. The last patch additionally tweaks the Testing Farm
settings to make the CI a bit faster.

Ondrej Mosnáček (5):
  tmt: raise duration of the prepare-system test to 10 minutes
  nfs.sh: work around NFS hangs with nfs-utils 2.9+
  tmt: rework sysadm_t testing
  tmt: work around missing rule for sysadm_t
  ci: disable guest setup in Testing Farm requests

 .github/workflows/checks.yml |  2 ++
 tmt/tests.fmf                | 47 +++++++++++++++++++++++++++++-------
 tools/nfs.sh                 |  3 +++
 3 files changed, 43 insertions(+), 9 deletions(-)

-- 
2.54.0

