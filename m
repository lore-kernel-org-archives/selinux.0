Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F311B8EB5;
	Wed, 14 Aug 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652891; cv=none; b=tx5X5BuVEMEBr7M0gJhh/FT8Hme+fZttrI8zhGLqwoN6Jc+/IsEB5N19mdBPxYe5ChGQa3bTTEUK9LSyVXBL4ZHXvADgR4EjhVOsixLgxwyQIi6oKIMAyPNGUtZv8nRykKRubTob5JxzmJT1yRh9+UgYQ2nk0OXrpTXX7NhyrpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652891; c=relaxed/simple;
	bh=qMyqAYiD1xBjteoCtdLOra6ThFdlapF9VTpqVUN2Ri4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UQER9V5QveEC+A++QvnVMxjVNDWAGIAi8ktE/ZWIuUm0wBYoAcEQhIH6c3u4Vp4jbOuIBRJ9Vm2Y39GeXdw+lz8aRq5JVykTL0QxYfjuzjjBbRiVCbeoMxwu9oP70GERet4kA5zTwecSOhxy6ko+7xxpJOdd0ol1u6ge30lhho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF7yF6je; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF7yF6je"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072F0C4AF0A;
	Wed, 14 Aug 2024 16:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723652891;
	bh=qMyqAYiD1xBjteoCtdLOra6ThFdlapF9VTpqVUN2Ri4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YF7yF6je7UBZ18bsmzEsL2M+z1fk+ZSX/HnWfN2A1p6D0wT/hrEFa+e20OZya96Ts
	 BTDSXTtge0G7OHFUuYMOYYKEy2y4jGn7b0uDiHjZa2Ea73iAYyeVbUqmFmwzQxtsE7
	 JOI5LyON99QkszUsTMrREcWsQiVv/g45uZKBvEfpeShTfZsHQbHOcPk7M71DVBR7xe
	 ztsbxEOR4YcJC+rqHRDP+lnartm5ajnrmyugyAFUU3+337IBDzS1Xl2oHynx9KYrgw
	 TEQQXUrjDfwP6pw6krg+HBay6YGT2cIAvXA4j4+QoZ0fPKBqKiPW9LDITAFyTaOXv1
	 IxgrMXh+UqCzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712C638232A8;
	Wed, 14 Aug 2024 16:28:11 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20240814
From: pr-tracker-bot@kernel.org
In-Reply-To: <30fc5b38165e4eda57d640eca76b7df1@paul-moore.com>
References: <30fc5b38165e4eda57d640eca76b7df1@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <30fc5b38165e4eda57d640eca76b7df1@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20240814
X-PR-Tracked-Commit-Id: 05a3d6e9307250a5911d75308e4363466794ab21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d5906799f7d89c9e12f6d2e0fccb00713c945ab
Message-Id: <172365289010.2319409.1724128984605755694.pr-tracker-bot@kernel.org>
Date: Wed, 14 Aug 2024 16:28:10 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 14 Aug 2024 11:32:08 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20240814

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d5906799f7d89c9e12f6d2e0fccb00713c945ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
