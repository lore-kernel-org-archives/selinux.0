Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04668137C2A;
	Tue,  7 Jan 2025 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293604; cv=none; b=dqcgmjF4mARTgL6LSj7nNS7dNcYuR1DiL4IjYmkxew3yZiPfmL1WtdHnVGFhTEbrYb1Hhq7kw4d4OJToXc/4r6zlOgOa9rFQYLsGmYHJLUqTNbOyFcuuu8DUrQGQmf9TLYEvheiewOP+OkupT66mZlDUN6Jadagk+yfqw+Hxhw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293604; c=relaxed/simple;
	bh=ViPtpKCnXu+XTWbVnpl7IxKO3ec7cgZpCB8a5RDpD1Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DLAZWaj2UZ3sfYOVf818EfCoaqQPofoLLoC4yF64G6ALEjQjxTWdaQrjfZjQZHpexjFScvv1XtbirpI6LXL/fZW0X8TsYJVKOcMKNKI2aawGoWD6yBvGjby3GKhznPu7v5GiBhTprlmlDA1e63WMT2xhlVs/zxA6uHz4o6VbFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8WWg7s5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8WWg7s5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0F9C4CED6;
	Tue,  7 Jan 2025 23:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736293603;
	bh=ViPtpKCnXu+XTWbVnpl7IxKO3ec7cgZpCB8a5RDpD1Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q8WWg7s5PDkDLW73ENKTBNXMUsl+M+UYctRCOVz9GNxjVd/+laPKgsWrtoGZVHry9
	 Ewxk3y3i2mPkVgafIWINWS73qU8uuAJTMWT3Ao2/L1Ywps35NiJKE5r/6OEqdLdDxU
	 44Gnm+rlQclYWaAt0OkW5dDGjeAzjdO1A4kQyD6BwVxLfqiqNeZVBo3jAS3nfs3rUo
	 Hs0bARKIoLK329R9Bb1Mn7f1XFBEM925ZZKHR7QR3CugRDZCJ6kZFQZJTeUrWp1Gbf
	 8pgf/QKVQ/43vqwEDXf29/ZEdx6VYSKPnXOQmpoVq49jNNez2gChCUQi6f1R6xrROx
	 EJrKsCee04GiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F3B380A97E;
	Tue,  7 Jan 2025 23:47:06 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20250107
From: pr-tracker-bot@kernel.org
In-Reply-To: <c3eecfb79581eed47b37aac6b1ab8432@paul-moore.com>
References: <c3eecfb79581eed47b37aac6b1ab8432@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c3eecfb79581eed47b37aac6b1ab8432@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250107
X-PR-Tracked-Commit-Id: 5e7f0efd23238039bcd4fc72ff28d94f364ec26b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780
Message-Id: <173629362465.134782.14256338314126652661.pr-tracker-bot@kernel.org>
Date: Tue, 07 Jan 2025 23:47:04 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 07 Jan 2025 16:08:48 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250107

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
