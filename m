Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCCB47535E
	for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158875; cv=none; b=ufj5D++ydP9elbq0bkjzMc4oKVpXZZOYk6ubZx5gW/rMJDYkIStBnQLCjxjyezRY43ntdMhpdeOfBzhYo/jspXHPKYPWEIwioIksSV5shfIY0mTobuyPqlq1mC54x6kToct6QF3R+/N5ao+A0MMHunfte51skxAZoS6NWKlrvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158875; c=relaxed/simple;
	bh=UKIAXxCTzWm43G706Y7Kdgmc82TA3SPvC7jZ442D0HA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mD8luNisNabYkyjEPTZY7RMe99pr3D7hF1L/YVjdt9+UWJLPiNEpbj93quB/9ZU6kY/1OYzMwq2p5mVILusqmTgrvdW+rczL2Q2Zgm5Q9eUsyfRAt0X5cp/R3xGBR8uZy6GTNSmn41asHf5yZZ05ZX6cLph1CxzLr136ZpChkZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSJZ0meT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSJZ0meT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1C71F000FF
	for <selinux@vger.kernel.org>; Wed, 23 Sep 2026 10:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790158863;
	bh=UKIAXxCTzWm43G706Y7Kdgmc82TA3SPvC7jZ442D0HA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XSJZ0meT63kJJEiSjDpCodIvcfRgeG6zcOmhJNfO4fJgVMQAsFeLQKXLQhjW7EZGo
	 rvTJCVzEcF4v+TJg7CUz04el+iU45Qjm93AyTu2nH1gfiK35rBgCbp+QdJBR4r3kYn
	 qkMyKD1kMNhn2aRK0VUvSOV6BM3sXRA8v16WTDVuTFw6xz8Jfy3TuX9w/CiEOQjiyl
	 F1LRxhkC7SOtAIoPZ1HYRBgb92/S3aKtmCJg6H+owR2SZfX+1RKRMZ3OvcEdi7mYtk
	 UZFS2/OnG4RXmz5Bkdqefk1KJv8Az/7cdIrL2sxRRbk6d93QbzFTO4QeFwZHNvZ5mT
	 4b43hLX0JJTVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selinux: fix data race on AVC latest_notif
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260923101323.2996793-1-cgoettsche@seltendoof.de>
References: <20260923101323.2996793-1-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 10:21:02 +0000
Message-Id: <20260923102103.2C1C71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> avc_policy_seqno() reads latest_notif without holding notif_lock, while
> avc_latest_notif_update() can update it under that lock. KCSAN reports
> these concurrent accesses during policy boolean updates and permission
> checks.
>=20
> Use READ_ONCE() for the lockless read and WRITE_ONCE() for the update.
> The spinlock continues to serialize the comparison and update against
> other writers. Reads made while holding notif_lock cannot race with a
> writer and can remain plain accesses.
>=20
> This marks both sides of the intentional concurrent access and constrains
> compiler transformations, without suppressing checking with data_race().
>=20
> Fixes: 788e7dd4c22e ("SELinux: Improve read/write performance")
> Reported-by: syzbot+a7f7cb0737bd91aa698c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da7f7cb0737bd91aa698c
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923101323.2996=
793-1-cgoettsche@seltendoof.de?part=3D1

