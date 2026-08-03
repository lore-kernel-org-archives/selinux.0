Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169B4266AA
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780763; cv=none; b=W+7s0lPXmfn8wzF7QeFnLZwYZBdQrvGO8/QY06711qKT3AdclR04i9wrWePKjDXjVkbN68f76qmpbTkz4tezl8A/nPTiJlmpwDECzZQwIuJiUeeV/s42ubkWdvMFW07xt+b9Y6eRaihaWy/YPOOsNKi2vU+/fnhKAmSR0m/5YuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780763; c=relaxed/simple;
	bh=hsqNOBWfhClScsZNQVfAUSWt+mgu7GOPIM1ibli9gxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D52JlvtNLHbW12GQESmDNlSYjQ2heHMXfZdxZr0Tyqia8CPwWDacFwMu44jOt36gGwpg2DJuYczlhLxr7b1OerOiIOoEivD001Nxij3HrW5cg+ReXoat7kWPksUhdKWVmVVQ1HrNoqK64+AUQgyz5wtOvDHNKoB+5zDTQTf5/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5FALs1r; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5FALs1r"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-908239232adso1231316d6.1
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785780761; x=1786385561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ewAcpH+Zb7+dxsU3Cn0SxdVCVgpoTVfYTY35TFtkW7A=;
        b=K5FALs1rvIkej4d5zSupcEPCMwlMVhFavrI+MWBR4bCSKe8rQeRoadETKORpAu0uXd
         4RIDtmWTWxhSG/VtvgpEeh8y7j0a1bc8g25s2Rsv9XXLr/Gqv5+Cpu8AWkK8050mG+Ln
         JSO/a5emBJ1GD8FfKawZAyjG0Yni2FjjBWQ7QDJpk4rnuXtPPv3XUy93VsRdUI9vD8dI
         xCaB3cJKzqArt2/sl+QVEEMhsRgbxzVbMkNqdCX/IsaIr+UOvt+3dI716pZRaEzPn8J2
         J9szkH1iMHBSwhObeUo6Bny0ck9cX1PkyAFxT8zypOXw4/e004cAP/uCSVESgtfkzJ7H
         l1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785780761; x=1786385561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ewAcpH+Zb7+dxsU3Cn0SxdVCVgpoTVfYTY35TFtkW7A=;
        b=E1d/Gt7Zg38GtXv7tQpR69tXci/Xf/Dj9dbgd/iYx/nr0/MqYcMnTzjxgPrfY6E2Qc
         XiRE/a+50hOnL/AiEZ1fFkOJeE1zYn8LulIgXS1Xt67aB8Md9SYExO1O/Bn7hxgomzKf
         TeYSx/rrRhPjJvnoWyRFwe0/2BaaHzYHecvCrLcYAoGISoCPkMQXPaEacxdwwpvE7R3i
         GEBSWH0pfsl3MY9Z0i9pcmHreYeuHNVF6LA8S527IdUnz6wBhGeZ6glLbjjtaHRWXmoK
         S1tahieCU/2BBoBWPMorAT8H0NCcujSArjYy+lvu/bpfSzrod252lZPEDKQEMbETzFiN
         1Q4g==
X-Gm-Message-State: AOJu0YyqFK4aAEW274CdzgFGBxhdfnzZUcR8T1NAXvTosweBXB5CSe8l
	lazmHYCD+oh2jTIZ6v/AFO4HbBqLvSmtUqj0yWGj52ChAqlhuDk7GlYLlseuVw==
X-Gm-Gg: AR+sD11z0WZi13zyaS3zDkVXsRr9Ua/cRydkToW6/8hBwRYd6OXbTj63G6K9CSvJ9Hg
	CxF4QkFLZ8Y2CVPaOOJYqmyKvegKKhrMGYSnQUEqejxjQ6WJzaM8t/1uRhFNXPa5b3jeV4CvE7e
	Pexx+OMOQTrtvU1ArUD9LqGqeQA0hiSSGp0uvVi4+9888BaGmWYbAoj6LP2gD9QDtr/3eUJ58EK
	+B17ZZ3wQedID0OfROiKtBgX97h5lvlSOEX4R/X0SfV5gSZNtezdE2hbtinvdA6pXjCRvC2EKD5
	QQQ1vFf6pw4yo29QfWHvT5BvsimzRCsyWY6/61AsCBiAkMDfy7Gq8DIyrOT2hZC2WJzM4umrRiO
	J03thbl6g1fhkxg8Kp1aMy58+gF0OlfVEqZRJ6xXLCt+K/qhCPEp09zh9PRVLbcu1n78ZbkRxB1
	10MFIXBc6vhRaO+QXSYg9f5W3z+D0Gp/3pxf3iblbDhiL4y6EVjhypS+C8SjXcbcD8Gt6ls8GYK
	ID6lz8sSbKyBrIRxpVwx04U3w/wOJK0pdMmkq42Ans0EitT9De9u4akq0aFVRZO
X-Received: by 2002:a05:6214:493:b0:8fd:b96d:195b with SMTP id 6a1803df08f44-90872c2b7cbmr11396706d6.15.1785780761109;
        Mon, 03 Aug 2026 11:12:41 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908434bb4efsm81384786d6.21.2026.08.03.11.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:12:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] .github/workflows/cifuzz.yml: switch to main branch
Date: Mon,  3 Aug 2026 14:12:25 -0400
Message-ID: <20260803181225.47458-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cifuzz workflow was still using the old master branch,
which was recently deleted. Switch it to the main branch.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .github/workflows/cifuzz.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/cifuzz.yml b/.github/workflows/cifuzz.yml
index c4e592c5..8236b04b 100644
--- a/.github/workflows/cifuzz.yml
+++ b/.github/workflows/cifuzz.yml
@@ -3,10 +3,10 @@ name: CIFuzz
 on:
   push:
     branches:
-      - master
+      - main
   pull_request:
     branches:
-      - master
+      - main
 jobs:
   Fuzzing:
     runs-on: ubuntu-latest
-- 
2.55.0

