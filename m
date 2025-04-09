Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068EC2135AD;
	Wed,  9 Apr 2025 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242202; cv=none; b=f3klaD0KI2SZBPzciBAv1S6VP8c9mfIfGoX+P+ztm3nGA7omzBjpccAim0KeGGYaGdpDUtEZ3iddagHDKQmPlOXSHFrFWu/R9+oLz10NHcV30UuepE+GWR5P68lkk1eDVPxnBPd2t9NQnCcecN3Gb09iJ2YWIBIZzvi6CHTKwo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242202; c=relaxed/simple;
	bh=6xmE78MRz6+hWCA2lCjf7ED21aEhsGKggvD/DIgxV0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6hvAmrl75PvgaM9+NSWmpAklUABNTEmkV81LHR3L91mkfHtIUGPczW5keL3kpFTFmycDAUrS3GaADRF8+RGxI/ZzG+/cn0lK7mfPXXuhWZdk3QxIuYN3qpPsVKoryHP3amxCr6uvKVV5FiMSSczgIE3QpRy2AJzcgVaO/wtX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhsS+CQj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhsS+CQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD90C4CEE2;
	Wed,  9 Apr 2025 23:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744242201;
	bh=6xmE78MRz6+hWCA2lCjf7ED21aEhsGKggvD/DIgxV0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PhsS+CQjUrnCjtPZBBeuJehCBtW8y/mPKB9ch7PgCKxvc+TBW8VK9N9Flnx52TYSB
	 G7CnIqh3MC51Iq08LcpoW2N0MKiuzRqz4/VGWlBr5JDyfEiCe6kC91XHTuslKjS8zn
	 0oOHSqtrfxVhHrC4fePlWvkYR2fPZ6iHvq2VpYS9RpgrdsbASZJU5oWtj5wuqBoU/5
	 1NDrcRhb+Ai7TwPkeX3YBTSg+Wk6G69yphlIg0QITB/Nrk4GZsYyNe0D0ADSSvBmI0
	 U5SGw+YI7Pl5sQdgsYvgCtzdHpDIny6+wAEVYsj8uarZor1mVM68wjTAmGInJGeDWt
	 RaNxByJj9SQ/w==
Date: Wed, 9 Apr 2025 16:43:18 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC PATCH 21/29] tomoyo: move initcalls to the LSM framework
Message-ID: <202504091643.C5F41B27D0@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <20250409185019.238841-52-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409185019.238841-52-paul@paul-moore.com>

On Wed, Apr 09, 2025 at 02:50:06PM -0400, Paul Moore wrote:
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
