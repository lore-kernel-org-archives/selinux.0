Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5049214210;
	Tue, 29 Jul 2025 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753755863; cv=none; b=iBPF3SW+3VxwHh/o+kB6yAAq3/tj2xVPFUDxe3pqF44jHCMc837QeCqxuesXRXnn9zWbRKssu1AzlzaVwZ/zwOk68M8iomXzY88Dsl/McoDVwi2foiXOgMhhtGScAW8uP/+IcOUu/nCXxHcwTZDM8V0ok+7gVaqXCTnLblWyg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753755863; c=relaxed/simple;
	bh=IMbYkLASt6ZSAThWVaUFJYFkgrjOTAkJN0zp8UYjtXM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YvCz89m/OJc+bxOn6htPE6FWZbh4wbPYpG/kLFep523T4O4oGHL7JglPQuBBO2GscF7roOumMPMZqclSx6hVJoBCJdutHdmEAI9df+PlxJR4z4CydAZ7ZnbbjkH1FtEkZi5b1IippZLLzWz2ymYxkC0iZAu/ngQk1htypEc/bCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaZINrnE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaZINrnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B08EC4CEE7;
	Tue, 29 Jul 2025 02:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753755862;
	bh=IMbYkLASt6ZSAThWVaUFJYFkgrjOTAkJN0zp8UYjtXM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KaZINrnE1tHJoR7vRV/ofGpOjcxjkO0OwmdrgFq5G5ONIobfDu4bwxUFd9mdKj7h0
	 bNf3wXtGCChNgrlJwMMFA3A0pbLaj+UPJXs43y1HZ7kclhm77WKDMhT8NJbP+r9epf
	 qlGYKRNpHhKSEtGII1ctiwRrXJmQ6TtLw3SzP34q99wmt+KzmaBOLxm6rNkSrF+0/I
	 GxP5QK6Lxhq+g41rFnag+kxt0jkAM/GcvGa79RlP/dunV2UYx3wmiFTdRKKe85KiTa
	 zvX15USdLyFswbVw9b+1WPDIspEfNsmncju8Sif6ymp+d8vTujU2MFcnmyXHA8EBEE
	 ZKIrRV1cmnCag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C08383BF5F;
	Tue, 29 Jul 2025 02:24:40 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20250725
From: pr-tracker-bot@kernel.org
In-Reply-To: <6e344a8bd7d60522825222628e949a14@paul-moore.com>
References: <6e344a8bd7d60522825222628e949a14@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6e344a8bd7d60522825222628e949a14@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250725
X-PR-Tracked-Commit-Id: ee79ba39b3d6fdcfa53de6519d7e259e284e78f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dffb641bea1d0c5a4017771aafb39513701095be
Message-Id: <175375587889.935612.4691676896986606922.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 02:24:38 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 16:49:27 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250725

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dffb641bea1d0c5a4017771aafb39513701095be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
