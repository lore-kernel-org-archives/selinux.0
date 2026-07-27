Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273B040DB59
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163828; cv=none; b=of65m/GoM5K3wEx33mc0K+x+Vf6smbLnqSUZdh9hDF2EjYvyhtlOCZDivKRt32pWfn5uQ1hM8QQrrClCyVzA5HXPyXUbkVfCJVPxcGb8EDU0GKEDzVXcqIe4DTAcw+iPiDvtDVuHtuGd7bBFs9e053korq3h8dNBDop1csf6xqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163828; c=relaxed/simple;
	bh=1KEJmnrQeIty7HaeyMkUPzVclL2Or9J6aALFDj/wwfY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sm6y3zUERNbTrQDQD+CzD8e99UFWQOdu2bNOPOB8LTuEiDa1s8fMWrPxm8ferg2Hc5CC911EIBQjhWRpYrchKXLJEx497a3rEInwyUR1iYx5970KknOftsJdOhi7MEDXnfn6Ale9ywhdkQtSNF9ViAsdPyv2pRljmZvIyG/V+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UukJKDnD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UukJKDnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2841F00A3A
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163825;
	bh=1KEJmnrQeIty7HaeyMkUPzVclL2Or9J6aALFDj/wwfY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=UukJKDnDAV2ga4K5dnd4y8O/keIBBR0YqUFSvqomeeqKyqICvwgLnWoXm8eimtH2v
	 gsUYMT/5ZsC2zo+QGL88zSGNtWIwrfe29K7EIg3IuIZOTJk2PsjudSCQbBvcYgEIhY
	 KquMZ92r+ICM7N+n4tMmENqKlQi1jf4OhZmniiSZcT4pwhnksWu05vE1kMPzdoeqv7
	 7PPICQ1ydP6Yspm3CaBSSp2MeGaEySnO4N7cjXlbq/3AQeg2yc9sY4a1oqJsxq2h+z
	 ZrYEwk51RvZv84eAtDMd9cnrpoxW4wJGhhrAMhboT/X4Gs3y6AgZYAKFDW5bQdY7nO
	 BJi6hhj8GUfag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: validate constraint expression attr and op at
 load time
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260727144439.6270-1-stephen.smalley.work@gmail.com>
References: <20260727144439.6270-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:50:24 +0000
Message-Id: <20260727145025.8F2841F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> read_cons_helper() validates the expression type and stack depth
> of each constraint node but leaves e->attr and e->op unchecked,
> so a policy with an invalid operator or attribute value is
> accepted at load and only detected when the constraint is evaluated.
> constraint_expr_eval() handles such unrecognized cases with BUG()
> so the first permission check that reaches such a node oopses in
> the context of the checking process or panics with panic_on_oops.
>=20
> Reject these expresssions when the policy is loaded, matching what
> the libsepol validator already does.
>=20
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727144439.6270=
-1-stephen.smalley.work@gmail.com?part=3D1

