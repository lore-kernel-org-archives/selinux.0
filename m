Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117870;
	b=IdV9Xwgk/BikDVXrH5bTgX0YyiiP5AolW+8H83jE4p9U2OCMQUfXIVJ6/NRUSgsJUnAV
	 qsNSJtDl3ZW1IVnbgTyScYjIdKF+QwO82hsrc58hVmGLBbcBuiXbGJGTbXYa52yOCrMrP
	 moJOU2yEFnwFrHe6DM76e/UIBZ4s2aXF9HCK7why6crOgp0uNfySE9OKKY+bnNiuqhqfM
	 md7OWh8ZjSXa7d5GqSCddNrcJ6Y91Q/AE9ZA07J+7D0XNj7twbsrX7e397I2NKHpMZOWA
	 y8baUpBSWM/PIRu8I9dPzRaePS6a7BY0a83LBzRRh77O+k+VOKxAoHZJdCRxG80f5GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9bvGIIouwqDTPnCZOOQ/lCc/KT+Bgya5OXDsoRTgeCo=;
	b=aAUjf9i/WT42ixeLM+efgZl2yrbPXCVZ+4UkGWJynQGOO6l+KNPL13IT0F3kjFUFqYgq
	 wnkquZd2xImU1X5/0iBz+XRbZuIKSLDkYUHdD/n/tR4w7F5sL0Db/Uzq/vWhw1kSJFhXh
	 d+yLt8Na81S1TKkdpiMks71GSS7JkCoDJ+UQVEacioaKxaMqqhrWiw46fgbnN6f8E/gjf
	 gT9asdI3Dr5tpJj+rAasMvPWjP8VftXaEC/HU/df3CXVVY7QOQ9dVAwD3ofnJRlpjXXY2
	 gOiVMXi9JftT+dJ74WA/xKuxA0QblmNxGN7A3Payf8uTOgauHEWpaYc9i3JWhCO/rDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TCruV6+n;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842F606A325
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 19:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7842F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TCruV6+n
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-94965745d92so15215185a.2
        for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795117868; x=1795722668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9bvGIIouwqDTPnCZOOQ/lCc/KT+Bgya5OXDsoRTgeCo=;
        b=TCruV6+nVFEB6No7vKR1q4NAX6vISkff4XX5T1iwSvGwvl+xYqelXMvmq+rWjlhaZB
         vLH1iNVmwzI9xFMhVgoNy6jBAgrQAZQe40+j7JxGdWXBmVSWWnzqovzJrftMzoY7TdWy
         9+F+c3823m84/kJdSK1O3QG0VwqegeloSDwMSTMaBg+Zd956evcKE9wqoH+5NzhkBXg6
         r273W6G7k/LXN6CwihqONsMq468EJajKJ4B3jQODKDeBYyG3IWiVVDkDKcqcojomUDJK
         dko98B82+TDVnA7Kk3xZ7AoBK77pbAi37kysPbuzi8aDkbDPH7piNI4MqI3yQi3m4pO3
         LmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795117868; x=1795722668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9bvGIIouwqDTPnCZOOQ/lCc/KT+Bgya5OXDsoRTgeCo=;
        b=ygxB0i0xMfkeGxAdwzo+F3kQq/xiCVC4UayPcJc1Y0PCLxYdlt9vvxtoyrVcIpqRwE
         RUoEhO1YuH+1Nr7Ag1KT3R/ojNH+D3G8J9z43G7oeYbJObSsZkeIDqiq1rW9cnJaFPvl
         eo3QJH+qePSg8f7AlxXveMVCY+kLeEVYUKJYPE26GPsFdwWQYFOJFrYmTjXe9HxdU6cF
         +9Os5GlOuyrpWPoP76xKLBznc5JAiHZCk7yFNMgLcpTZELQmA1SaQKWPZ8isY5do+QVO
         4roelLqgU78T2+S3cwJHF48JRcw1KuLKQB0uCv6KsNDwl+fcvW2U5DtHFEz19AixV7Ri
         kv1g==
X-Gm-Message-State: APuU4Z8V+WhGssQUQ6brOtaKQ21XgQL3K5GOE+cT/RDQNrwKcL/ABlj/
	UeLLJpIypMGTiAesTqrAVQPcfx6LwLOsIUz9YHliRUhW5Eaj4BDuLgzmbwYqiQ==
X-Gm-Gg: AYBFou3Y1CrofsMUEWqbQ4njx+ZKjir4RCiE8TtIyPIbBQaH+uRITLKwEppkQacTbMe
	tv9AND1H0LLhcynjircykQX+iPaozCNpQ8BILmlmHHA3BveBDPr4kDpeZZpBCkGIC38Z4LNDmoj
	5GQ2YxOGbBK0skDVz3yqw08CuKhoTseddPlhgpqr2A+OsZ5XIq6W9QtE3IkLodk1e8GdZqQNJ2y
	1HSpRqCyNYBBmUQRPJApF6rayIFsIdCKZSjo/dN+Hr7RK45hcHo/TmI5N4lrhaG/uJEHb6QrPzX
	Wi9mfQiUvynenFD/liRCpPZRGjxehrL4HMC1w1sYt527OXm3CpybBscQn5Mj4dss4LGadPmx1Qx
	cY6MBlnNHwK+zJQ/UJ3KP2K3aXy4Ziu1QPSSGA0gVURkIg9XobthVPWrJs5StOHGMVYMcfjN8Z5
	m8PG2LN/Mvb2M/Xg6vjKk4U5J23Y0gWcwFssx7ICetzl8SP33J44ByWrFXezI/zVPqkkn2+n/qW
	BkE4yckLJeNIhTDW36c2kW4Qynb4nXDV1wGutOQAboAybT8kJHjELmbT+i3hjqNt6ZG6Sw539h6
	UKAJpan0tXifCIRUTZBuoamz5PaWsIfZQ2oEiFu/BGrHqKffpnZBKCMFQhUyRl0vrrZ4kvjKpzG
	EGe+T5JsjPvwdTtalVuhBLhWpTwj4cN26R5MCgm2miii6v73x6e4q5b7cqz5B2Vy8dyqOEV8Q9u
	cN27NIQhS/ZySUTu9R2+Q5yLstikV+682I
X-Received: by 2002:a05:620a:2984:b0:93e:653e:6981 with SMTP id af79cd13be357-949ba7e2b41mr130697785a.11.1795117868428;
        Thu, 19 Nov 2026 11:51:08 -0800 (PST)
Received: from debian.. (pool-96-244-147-163.bltmmd.fios.verizon.net. [96.244.147.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34a38bsm32547785a.13.2026.11.19.11.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:51:08 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jwcart2@gmail.com,
	paul@paul-moore.com,
	jason@perfinion.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] .github/workflows: pin run_tests to ubuntu 24.04
Date: Thu, 19 Nov 2026 19:50:22 +0000
Message-ID: <20261119195022.1554-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ubuntu-latest has been updated to 26.04
but this breaks the CI test matrix. Pin
to 24.04 until we can resolve the
breakage.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .github/workflows/run_tests.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index 8ff1092f..b9270492 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -5,7 +5,7 @@ on: [push, pull_request]
 jobs:
   build:
 
-    runs-on: ubuntu-latest
+    runs-on: ubuntu-24.04
     strategy:
       matrix:
         compiler: [gcc, clang]
-- 
2.47.3

