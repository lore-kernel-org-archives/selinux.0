Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE193FD960;
	Thu,  3 Sep 2026 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468451; cv=none; b=KOFBUs4vOtR11T6y/gGvCOcYQr8gE4UFlh3vuiGX8XHQ2McDKT4Zv7KW4TidntKudOkNZxCe31gJ5ETmcN69i6Zd0lELr6lmiyrhVg74xxyVcNm4l1khd75jFduRRQhLNfFL2bJfx9ZQUaXaobDoHq+WzbdRK2nWSMVMi180eeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468451; c=relaxed/simple;
	bh=7efiFzxQFNwrEgtTSn3MFPTTuLPss7omLfJFbznXEcI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aZwN7bKATofGCVuGW+pd2ZlaWO11zhcguVx+AljrgflebbAU455Y2oGG41mF/KdAf4TU7rOpiUdqiuVai2JpXFcX/cADOdVS4I8WwA2YPtqthEWEGc/GhfrBP+4SRHYi3ovc7ZMNoHqQvG4Cz1SNhQAoRi1hnLCBKDW8rKlG/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnVTB/nF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnVTB/nF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AEE1F00A3D;
	Thu,  3 Sep 2026 20:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788468438;
	bh=iQBJ2gDurQ7wPl+YYRP+j5Ftqy8e1R+DBsIZRLrOcTc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=TnVTB/nFVDwLfFx5MuApFD6P0lI1/slYZrWMlpWm1AK6QauJs4kcOyE5HuDS8O6kG
	 9xASEBzs9bpxihXZJ5QY6vc4ZEbEml1PBbuHkufRwh22RX2Mzh2tJ9r1EpGkom2MZP
	 zjEvmlHatIuvhnt0KV6BnfiphfM9D896wUW2+PqPWzNAl9GcSpkrJAU6okOSdUUBzL
	 non/lMLgms3XtRUD6PN7gnl8xFTy1tcygEEP/D5Mv8STpuJZF8Ifp2861xkuwfb/RW
	 GnZT8GptuaThFTE77p80D7LnOXknD5+fyCSuYhOjrPP9VFQp/t1B5NFNlriuRWMIoC
	 5afNyLLmtR6WQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9396638119DE;
	Thu,  3 Sep 2026 20:46:20 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20260903
From: pr-tracker-bot@kernel.org
In-Reply-To: <8c72adc9e5a9d3ce854fab61ec5f66df@paul-moore.com>
References: <8c72adc9e5a9d3ce854fab61ec5f66df@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8c72adc9e5a9d3ce854fab61ec5f66df@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260903
X-PR-Tracked-Commit-Id: 4299767d772d4e498998e32157e45841178ab192
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a500db7819c50db59e55f1b4fa1c3baa5a2616f3
Message-Id: <178846837920.4014495.13224631345092557627.pr-tracker-bot@kernel.org>
Date: Thu, 03 Sep 2026 20:46:19 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 03 Sep 2026 16:35:27 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260903

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a500db7819c50db59e55f1b4fa1c3baa5a2616f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
