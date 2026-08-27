Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3248423A
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844043; cv=none; b=Ph4q8N8VTBtcs8fB4N1pEfCFH+hn51VS4m+6tJphGoj6kjajqUQVzehCF14DpIgZJ+yX0oDlJOqDT7EaEV8sL625NZoAoEMon0Ds/LzNnwutgNmdfM8+eWE1XRqvKU3LBaAtssjmmJSgwZdy+L02hWd+tfyKbIkWasRoBbwVB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844043; c=relaxed/simple;
	bh=Qucv/aYJgzSZZM7ocl2OOsIYxXiQWz8YjialeoOWup4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=egm/L/mU6ixBK8fqcMLjxXl3ywRUZUMxtyorSy4xRdQaN1QHVJPzRbmyxoOGAneTCk8RuyNAYRhQP08Db2Yk8IL5AUhDZ6ltKSpqkIqp+gk8MrropaTUGP06yr6HA3wSFn5cy/AG8jo1/3ah5PqNPYjhzcGLlMfx5H2YgsoHVF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwsBgC4Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwsBgC4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4311F000E9
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787844042;
	bh=YwtiFgy+AIpFr/SECgqn9/TqA/LjI1PQGI8GpFJsIk4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=IwsBgC4YERbVp6g7Iwg9ix90xBPhBzaf1cfj41zaAy/uRTVHD9xp6bd6t5IsbCakU
	 QGYXR/SP89SXPrgieNMeqCfIAOHOuXPCeFrU4uHlPbku3qtj1RBPAAs3BV8bv4yCXF
	 hDTyBFbjGMUJjswfCyPKuXakByRrUu2jWmDcT85hGkiQi4rdl3A/LySK4Cv+Krt9C0
	 mXFNh1ndGTU8SpoEZxhZy9jtvaxFUxFdjCYsw+BoCMx0rWC7oML7TalR0Rczopg8DU
	 0K2+hS5xhjzZ6pL4Ahc9c8CYKTu38kMjPawSUaY+rc0/OXQicfPfccqt67aouBw6T5
	 9sJoqyoWdheFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: convert selinuxfs inode numbers from unsigned
 long to u64
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260827151203.108111-2-paul@paul-moore.com>
References: <20260827151203.108111-2-paul@paul-moore.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 15:20:41 +0000
Message-Id: <20260827152042.2F4311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> Starting with commit 0b2600f81cef ("treewide: change inode->i_ino from
> unsigned long to u64") inode numbers were changed from an 'unsigned long'
> type to a 'u64' but somehow selinuxfs was lost in the conversion.  This
> patch corrects this oversight and converts selinuxfs to 'u64' inode
> numbers.
>=20
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827151203.1081=
11-2-paul@paul-moore.com?part=3D1

