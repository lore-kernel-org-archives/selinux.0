Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73644199934;
	Wed, 21 Aug 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246137; cv=none; b=GWfZrkoAOKPDbuFcysOXVow7/S6uZ7IxkGBEC285+yGL5GTpnF0IRNW7skFQutDrafdVlke99YIVYbI4useZqNn1fcTxW2z/1/LURwydfCycucsDmBRqhGMaI1rjt2RoIkOzmn2GeX58XdjPnmFlFjziMbiCKhbMqbZHKCxzK94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246137; c=relaxed/simple;
	bh=O7V8KYMSajSUNX3b9Z/edT5CV5vX89JyG+dhDML59hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zoy+H6FaTwDYhV8AsMuKw8cYoYdKhXjWAN2fia217m4S+yvbUfuUWTP/xiQ3YUjZuiLR32Y9reKHBjB/80R+FHuxh/ZC0WaP+3sS6BLqTF+513tzza+dARBpqhDevtDS/8+QiPi1mVb5G6J4Ef/jh6OEw2PdPEP6Mv7kcpskCEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=j1IHER+Y; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="j1IHER+Y"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1724245682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=neAFZ5sIt4iGJauRibFWk0r0ZsYy9vNajk9gseizc6s=;
	b=j1IHER+YCvWISW1QbkccVAUsrDwQqXNv5ZT8H6OMcryGXSFvczTiFgQhwZnY6uv8c0Bjdr
	n+vIBWC/Wqlo3aZPEvSjgWk5JsDLvnLvX0f3AyaxsylYXwvGmcZLleHG0DgVHjKQ+snX4o
	iy9lC5F5jw5WO0aAaUjY1zELBKvDwcJr2Sxgib4NI5vcPUAOwK7PrCZDMB60IIYluSUUw+
	2c/PzY34I4xspV39XpgFSNt9Rt2RVADB65hddE9tESMVWkN+6bw1VFMiGkD22nPr7v0Ym8
	TcKhbLzNn0RTveTuV2dCUF1XqrXMCN0epWY6dVMlG03s8xGh4vIrlO4WR1FHgA==
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com,
	jsatterfield.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	xiujianfeng@huaweicloud.com,
	tweek@google.com,
	brambonne@google.com
Subject: Re: [PATCH 2/2] selinux: add support for xperms in conditional policies
Date: Wed, 21 Aug 2024 15:07:52 +0200
Message-ID: <20240821130755.25031-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240405161042.260113-1-cgoettsche@seltendoof.de>
References: <20240405161042.260113-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> From: Christian Göttsche <cgzones@googlemail.com>
>
> Add support for extended permission rules in conditional policies.
> Currently the kernel accepts such rules already, but evaluating a
> security decision will hit a BUG() in
> services_compute_xperms_decision().  Thus reject extended permission
> rules in conditional policies for current policy versions.
>
> Add a new policy version for this feature.
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> Userspace patches are available at:
> https://github.com/SELinuxProject/selinux/pull/432
>
> Maybe the policy version 34 can be reused for the prefix/suffix filetrans
> feature to avoid two new versions?

Kindly ping.

Any comments?

This affects (improves?) also the netlink xperm proposal.
