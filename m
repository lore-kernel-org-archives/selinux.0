Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9EF3093A5;
	Fri, 19 Sep 2025 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758280145; cv=none; b=SunPkhaJcAcIqOWpoMdRo68YIB1gml2lhwc6arxTT8j+PSIVxYhXb/Pp4uWoj9+DEBYhqiq1uWQL3E33AFC+WBKqhm2Y52sSoD0By2vt95MPUUQpsfAUn8p6N7Rk/Jivgn6oAMNoob22M39JykP8cHFbUuU3PS4AFG7Qev7iBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758280145; c=relaxed/simple;
	bh=V06mTc7mmAHF1get2Z6bBhxQM9RUjQgKarI2B38U708=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3dbo633ZHUoyK4EFdpZdN91NYqahqxYEC0KC8Ny5965PqgYvB4bPebA0/tUlsCGh7CFH4WRyX1+eUUh55jOSavDUtg/QZw6o2RoeSHc2y0in9vUGKjp8/Mfzxv1QICRLPrRN1A8r6jdGdA07G8mgywxjsHvuqmHXjLnqjLvjJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRuGVFgF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRuGVFgF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91021C4CEF0;
	Fri, 19 Sep 2025 11:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758280145;
	bh=V06mTc7mmAHF1get2Z6bBhxQM9RUjQgKarI2B38U708=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRuGVFgFl9c98eKuCm34wFvL+/NoSt67LZ4HPIF87vqLIjAj/1hPJg/ziH2M93Q6x
	 2L65uXr/CFu/xGN8X9warleY2HNZtLGro4SY2qYedciKfYA2kdxXkMT1zTVnqDqNWN
	 huNuf/7o/gZ6KAc1akfAKlUrKtDRBOQjW1EJ5OYrtwfBKUMeS57K6Lorq1FWOgHJ8N
	 mWqeqi43CwnJ2OcQCs39kwDtVcBHo6XPAoLi+I60MuuT34bNj+lX33KrdeGYfMh4Gx
	 pAgozTYfE14YWenS/jP7x3gHTCyQvjjrPS+qOh47KbL1bsNR3SeIDtEsNVDfoQSIFk
	 LIm3vywdLak3Q==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH] pid: use ns_capable_noaudit() when determining net sysctl permissions
Date: Fri, 19 Sep 2025 13:08:58 +0200
Message-ID: <20250919-gaswerk-auffressen-168545629187@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250910192605.16431-1-cgoettsche@seltendoof.de>
References: <20250910192605.16431-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=brauner@kernel.org; h=from:subject:message-id; bh=V06mTc7mmAHF1get2Z6bBhxQM9RUjQgKarI2B38U708=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSctTzz6rOZ2vobl7ofp9gJNBz/4j953t1tR5a0T6/Z2 NifsfCPZkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEXl5iZFh54JVwkcFBERb/ bcmcuxUtpbVDHrJGLbKO0z7x4sG58g8Mf2XfS9osqXwm3u7tIdOt+TvmhcG8S9uNwj+pSfz7eEH sHSsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 10 Sep 2025 21:26:05 +0200, Christian Göttsche wrote:
> The capability check should not be audited since it is only being used
> to determine the inode permissions. A failed check does not indicate a
> violation of security policy but, when an LSM is enabled, a denial audit
> message was being generated.
> 
> The denial audit message can either lead to the capability being
> unnecessarily allowed in a security policy, or being silenced potentially
> masking a legitimate capability check at a later point in time.
> 
> [...]

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] pid: use ns_capable_noaudit() when determining net sysctl permissions
      https://git.kernel.org/vfs/vfs/c/b9cb7e59ac4a
