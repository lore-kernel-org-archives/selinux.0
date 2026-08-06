Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2927544E046;
	Thu,  6 Aug 2026 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032143; cv=none; b=ZbQtogYoAItgrImDL29XlCXI7JU+z+slpveNDKF4486ELZq0yWg5GAA3JGp1pySc8Wb5RArNT19847PBi8/pDeb6ZuKk6aECJPGH44SXcLZ1/DSzuDH3+AamOtL+je29FFxUDysPEXC0uxYJKfumbAJYZOLiczELzsEJQcKQdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032143; c=relaxed/simple;
	bh=+raEcM0oj8JESoRk5AQZp9rV8Pdd8Rp2d7kCCs/M+Bk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=W7hcGBkdBganOgZghHMb4QsAEqVLapxU6XoX5JJ9xAw6oJ4yjDm5Y5vu762WGsGv/cdtcfJFvCZKfdxCFcLbbvsNgFSTxONTmH4q9WJGm82wHYOR66rhs4E4mWRfc7vnFnI6wn83Ea3krQi3YvkyuwqCYdD1JamK/rWEIlxsuaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLtcykWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLtcykWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111D11F00A3E;
	Thu,  6 Aug 2026 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032142;
	bh=yd8XfYUIJXn0TCufbrs3jZqropInFjltN+Cm8sePhr8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=GLtcykWOb9u9ZOmThmhkaI3oEZ+2/9i4mGzfKZhqjkNTdWrvIqUMpKpEajkP8rnDO
	 TCaIZaz/0vMuOEQr4cxOSBwqDhMTRi+PIH9bOXvjwl28Q4z8G8Lcd8wUkL8evBF/HI
	 HYaD4ljI4bjtBMSynG9xoIfcMvZrKqgfxgz/MUKAHFgHfA3QFpZTOYZ75sOGQwEKus
	 SXPy1W4d8l3q8+J4VTYHMZifxcH1hl5Hg8hFPa3+cj/uM/5Q1i7TeEf4SE+BjFG8pN
	 kItiZqEkxenuB0RSwg4BYxzdiA1wDB+w6guW/YvrjO0aP3v8b7ZrtpENf5tv526lwd
	 zO4R85GXbTQBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A99380820D;
	Thu,  6 Aug 2026 16:01:42 +0000 (UTC)
Subject: Re: [GIT PULL] selinux/selinux-pr-20260805
From: pr-tracker-bot@kernel.org
In-Reply-To: <e8381f47156a6d70a99d5a3c24286662@paul-moore.com>
References: <e8381f47156a6d70a99d5a3c24286662@paul-moore.com>
X-PR-Tracked-List-Id: <selinux.vger.kernel.org>
X-PR-Tracked-Message-Id: <e8381f47156a6d70a99d5a3c24286662@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260805
X-PR-Tracked-Commit-Id: 9c1cc4a7f79275ef93746f6247685763b475bfb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5096fec0c58a4f4d2475d4d88697c505800e50e
Message-Id: <178603210110.1354700.10061808698043137680.pr-tracker-bot@kernel.org>
Date: Thu, 06 Aug 2026 16:01:41 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 05 Aug 2026 16:24:35 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20260805

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5096fec0c58a4f4d2475d4d88697c505800e50e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
