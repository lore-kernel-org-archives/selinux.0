Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E81B4247;
	Tue, 25 Mar 2025 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944586; cv=none; b=uklxk7eLg0KngpsGt5iDruQ0JtWmBSqdJUMX6Q9SPPu74fTzjTBmAiSiNivFs36zKzxuTXkcwvwFJ34Yw3orS214x+Eqt3nA+n7p7/DoDAeFv9apP6/lnzZoYHIosW8NcLErEyeE8g/r620/6rnl2x0A69Zll98ll8OrY2fKlzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944586; c=relaxed/simple;
	bh=X3qvrbQnIW1UWG0xrD9ejZfEJ0k/ydduTQAJYzJ8cuc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Qt6oD0qBFjadYDxI/dwK3MUfQo581mBC8KGwt0Qy+Lr/Pz70iimQb7pfmXlUTZRw7ksOgsjEEttBOitpRS0OfYEbaZBa84KlixILUrC7gj9zEAXNodeom6FhKKjsxZdIc8ohB9glLyYz6kT3OEXCrMPSmlZTmjNEGVI74S3EJOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6qLaBpM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6qLaBpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725ACC4CEE4;
	Tue, 25 Mar 2025 23:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742944585;
	bh=X3qvrbQnIW1UWG0xrD9ejZfEJ0k/ydduTQAJYzJ8cuc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T6qLaBpMMdnQADhdfgtF5LmrxGGL7r+tSgUgkqIUKyhxiNH1NMLW8uli5YSjzPWDL
	 cjUbCwCfrBChB1Ds3Z7tFxYxiAE1Dktpu7m5cySzTUODKlGPqp720mE1Vzet+W3vVP
	 PjfU8ipl5u0r/buZkuuc6pE0RB6ZgtYrkLZNjivuM47AwaXdk9sJkITey4t4/lccRn
	 bKSE0SqgSVyaN4/udo+08uOacuMg2xR6bDL4S08pe9Gsd1eRf42SZs42+YwnN+kmY9
	 H+TfsO88ZTYfiMLzf+n6ne7/dliPC48D7JzTOYu8gDhOeoAj3ygZ5aVqF2XsvLiq3p
	 Dc0OTxIQVS09g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB232380DBFC;
	Tue, 25 Mar 2025 23:17:02 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
From: pr-tracker-bot@kernel.org
In-Reply-To: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250323
X-PR-Tracked-Commit-Id: a3d3043ef24ac750f05a164e48f3d0833ebf0252
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59c017ce9ec77953ca5198b41d4101f57dd4af0d
Message-Id: <174294462147.770882.14434427249406038583.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 23:17:01 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Mar 2025 15:39:46 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20250323

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59c017ce9ec77953ca5198b41d4101f57dd4af0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
