Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106E338591;
	Wed,  3 Dec 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790542; cv=none; b=PIDQAURKGkDwW6z5qwaDpjfzn1J/1AbonYokV22zbVn01gURs/JmU6RN3vHD0gDWkvGD4GyqwjkaG9Xpm2yTQqz5/vQtyTciR4nrPv4H1oS06iiFlfmujcFCJqlRbJ9BjcRIWVGm4gAah6mN2deHCd8zFQyrX5S0KlXpYzaJRF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790542; c=relaxed/simple;
	bh=IllfteV889LeBU1lQsaQrGqTNeuhiXXBPqbz8+gc8RY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bYWvAk8dtja3aIgZ+YOAgUz26+SYHTJf9cWp5tXA3S38ceiLgmCjXBqzHzLE8UP5pGayw3PkdUcnktPsZL/tuwePGJNEh2BqVcWp4aBuKuIuq3jhg8njm3yP2uZ/xlnp7VRte812c43NW++y6GO65yFsCUzOp/iWjQTrbkJC9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LftwxM7g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LftwxM7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0911C19421;
	Wed,  3 Dec 2025 19:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764790542;
	bh=IllfteV889LeBU1lQsaQrGqTNeuhiXXBPqbz8+gc8RY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LftwxM7gC4Ls/XTDlq6opaYNXms9pAIpi4HalTfJcART+4d1Kr/m6BXWgPIaTmQi2
	 QqAvr01/PfINhlz/Eak8YGhJafqwPsu2nOL5OTxtqE61EP3Rm3iPpKpt2MmvJZXl0o
	 oT1NsZwYVqF0kgTKRqPWrcncu2fbz+DWCeiVHgypIkLFJMjbPAYAZi5ZnxAf94aYnn
	 vgRcJNj3ip8M6QoFCPuOLT+4T64mCqnlk2Uj3MOmQmaE/WGwM59SbV6JFp+ICJoG1g
	 cWfWZvUI95B1+ZRpIolcIbHHfIVmmigTFjn25jSO/HDyvBP/ceLOhOQ2YzFK4+Fxtz
	 A5cPmhvr6bolQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F280E3AA943C;
	Wed,  3 Dec 2025 19:32:41 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20251201
From: pr-tracker-bot@kernel.org
In-Reply-To: <c48b683b30a44eb12a0ff032876386fd@paul-moore.com>
References: <c48b683b30a44eb12a0ff032876386fd@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c48b683b30a44eb12a0ff032876386fd@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20251201
X-PR-Tracked-Commit-Id: 20d387d7ceab95aade436c363927b3ab81b0be36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51e3b98d737aa3e76e077db77b9aa749436c93ac
Message-Id: <176479036046.47894.13453081691978902454.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 19:32:40 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 01 Dec 2025 21:00:42 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20251201

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51e3b98d737aa3e76e077db77b9aa749436c93ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
