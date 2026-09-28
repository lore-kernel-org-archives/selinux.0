Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2574F3927
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615247; cv=none; b=EsFrm5TTu++cuOzGJ70LHKDmrLfipyjU4cIbVm6pXeacqlIEC7Fxp76jIw7hQUp4M5fk2rWbilWG3Z0nfJ9228KOKQ2z1ZjPE7PiLdViKCx/jeT1DIagn4LOFEvWLrpkqemzD4lk0jwT9kNBcsy90Kys1QMdVfc0L3WByiU4Uz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615247; c=relaxed/simple;
	bh=u8xL66+JbmGek8c4vbYipkVBXooDcyIEKYiCo6yIqeU=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jJ7TSabyTWYURC3iLlkf5FF2pZTkAcvRSwhBhLmFc37nd7+dcAZ3BlAqnFQPzbnMyjZEMFqI7oqfZzlh4e37kUhCUEYNf6qp1HdJgWz+h3ScxuI11JH44jitnuQ7LlB/6qpYtxQ9J6qzGpdtwnDn6rhs8Kq4RiO8R5rYeZccF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUPyr4Vc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUPyr4Vc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D79A1F00893
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790615242;
	bh=u8xL66+JbmGek8c4vbYipkVBXooDcyIEKYiCo6yIqeU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dUPyr4VcK79WWAuh475ZPaWs9U8JWPdFN/NbeEkCDoO5wEAbi6xkBJc37vICjxx15
	 KSNreL9zVPBE3ukChYaqEkUu+gQTiE2bMI9YLsMAnwvdF+iad9wHjl5yvtBTCblrYP
	 X9ZzrsLWEmSe3uFNx5uTpBfI6e79gJnx73xVF7qbx7ion1sOynOs8HMxu23ht2W+LL
	 eHd+rvzIeYVCJe9huc/aN/+RU2+Bb1UDOzh5UCsdiP5muUAEgp5zv3SebgJLnfU0kh
	 aZw86bLPfbj8xseJ/mXf365Vt91mQ5mhZpqVBw0xm9OzvsMY8aMDv5D8A23EV6HXG2
	 v72Ef5S6M8I9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] selinux: validate permissive and neveraudit map
 types at load
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260928165253.2388012-2-cgoettsche@seltendoof.de>
References: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
 <20260928165253.2388012-2-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:07:21 +0000
Message-Id: <20260928170722.1D79A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>=20
> The permissive and neveraudit maps are read as ebitmaps and indexed by
> type value, but their set bits are never checked. A bit that is not a
> defined, non-attribute type is silently accepted. Validate every set bit
> of both maps in policydb_index() with policydb_simpletype_isvalid().
>=20
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165253.2388=
012-3-cgoettsche@seltendoof.de?part=3D3

