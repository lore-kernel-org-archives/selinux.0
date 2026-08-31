Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640BC38F64E
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216924; cv=none; b=KJ0ZXHRscv6/AJMcYNDLJ0/47fXvW2q8JJI6DsiXOyDNZxC8vA1mpk4q6KuYv6WSDndy+HAaKv8WJO1fxzMd4ZkpHSxQX34rrfe9vU8zqFZMocc9wLIRQjvNmJS7Zvqu/mCTQBgsfgwyZ8NUpVkJ93/Ng+FbpRjCeR3vmksoEo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216924; c=relaxed/simple;
	bh=LFGM5Dat3EaQYQqJQHGAr5Z2RYzUygK/W2Ym5nihkHk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pQm7bJYPYd8618t/uVjulSonYJDMlR7LXZCS5t8DHsBXrzn/3K8LkRaF0kmdy74z0UprHurcSVCDphhb87AU5hVA7pP8ufMlwuZY/bO0F9cgFaR4pa4ZUa6gm29E9ZvG5jwoQYOk0j8ThcxQY2FxTyCGKihGHqjc2E3OY/wMht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7/DHXE4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7/DHXE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46251F000E9
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 22:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788216922;
	bh=LFGM5Dat3EaQYQqJQHGAr5Z2RYzUygK/W2Ym5nihkHk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=W7/DHXE4lNUIrVoK1oV6E895gXU5zvVRr4ZjtE9eYCkFO0sx2N8nPLR6UJcwlLpKu
	 cTRb7xc3dWEOdRn5MxXfyW2fvPS2wDA56stJDiFNUMavi2PDdCOLzrS3XqDtOb6lKe
	 qvhSXpZYkILGMKbEJIejd4QHaZeg1ZlKl6XVNf34NTE2tyuQXkuMogigzlbFF9zSRW
	 Izjhv7Auxv0RSb+UHvptty7MqQ1wdG+lCDJixx4B96TTHm/dTrjBRbyzHJsg6OuntD
	 WbJcdJC4SqhaBATJmdRxUaRswBqn6SxvVYqn9JNl0XuMlzr02dZEx6A3HUh98PokIX
	 J4PF+8eabTl1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] SELinux: hooks for secctx_to_lsmprop and
 update_lsmprop
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260831223748.4304-5-casey@schaufler-ca.com>
References: <20260831223748.4304-1-casey@schaufler-ca.com>
 <20260831223748.4304-5-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:55:22 +0000
Message-Id: <20260831225522.C46251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Implement these hooks.
>=20
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831223748.4304=
-1-casey@schaufler-ca.com?part=3D4

