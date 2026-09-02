Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768183A6EE3
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387021; cv=none; b=NJ7G96nMG8K7VhcrRG35+Ad7/GZTn+D5yDSaQmtCQpKcOWWfSew4+YvO5Oxw77FQnXh6ugT/pVdOVaq25KZbvY1OtM7hhhCJb6bFz9HJdYTKLzW69/criFFGA2E/sbrwC0WruCOvgb4C2JOA9Io40bBZH10b5oEU/gZRlSMhODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387021; c=relaxed/simple;
	bh=78hVt9noMj+r5FXpeNOLSbH5eSqyxwFflh18O9S4mgw=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r1/Qb+1bOrPOe7XqwHoUgQzaEUK2/IxsKvPxL7rYJmbp3WE/6H91Be0BFYJnV+hIvsm2IhTq4z94WoGjbifbKNuNAXuTrlXlV2G/T82JHekJgKpO3ECt6yzfjI2NhL6/FJeGWIug9iMrqyFB3/TH7whNi5x7LIWfb3Wwie4hytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJsc5Cpa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJsc5Cpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07ABC1F000E9
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387017;
	bh=78hVt9noMj+r5FXpeNOLSbH5eSqyxwFflh18O9S4mgw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=WJsc5CpagC2Io2j47tKPThlqPj2bi6Kzqo5xoV5qZe4lob+J0j2bazkz8ly/SOE90
	 BdS+zf/yklrARpyBWgN3UjRk57FtD68dy4oHeaTzNz3S61vfWe382cJHItJ/B/FkGI
	 aCvtff/dQHysDp0DFMyGELlfeG4uNFemwLIXcPVqpKYmiG2tA7G9fWqHd+93yQk9Ga
	 2TlHQjsY0FF9inUU30zoLKkVoNWOlnKYSfhWunpS0gBMzsZurY1DIWV9/0+TpD+yuF
	 774TV2mD8t+p1oK/jFNjvizSrAlW4Xp17H8ii81g4p7kwIvekx84yT71X5srPwPRr7
	 h+20nRfD2Z5Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] SELinux: hooks for secctx_to_lsmprop and
 update_lsmprop
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260902220150.18586-5-casey@schaufler-ca.com>
References: <20260902220150.18586-1-casey@schaufler-ca.com>
 <20260902220150.18586-5-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 22:10:16 +0000
Message-Id: <20260902221017.07ABC1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902220150.1858=
6-1-casey@schaufler-ca.com?part=3D4

