Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7052AE8D;
	Sat, 27 Jun 2026 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782542067; cv=none; b=CPqdB2lhj7jxqtB5YgNinKLwhzTEKgAmLYRdr3I5cZ4glF2UBvspZXbmmbxWwVRA/OrWxnow0H1hcU2NEmrd7VfiSRTTngQvZTVcCYnDYKMH9EVOd7hU9qapC8lP1j7HZFLn4XnerMGTem60wIK1x1CILodnv1u7xf2WzpldM7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782542067; c=relaxed/simple;
	bh=JAWo4zJJS3JRTum4jacM9ljutp97g2tV1ZbZMnplD5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tPj/FkA3YHpW8KHTpnL+wpJfStD8yxKk2smcvYWBKzvDFSl/5fhdXtW8TgrHGjDExmh1PR5mnbW1XkI+8L049sxZlo54xBohpuDUozaTuP00u57HaIQiWk8/8i6eD/dJztpceYyjowPDyGqih1x38HzKrRluwnssjb6LIj/GbS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gi9JE31p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gi9JE31p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38E41F000E9;
	Sat, 27 Jun 2026 06:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782542066;
	bh=KWxeVPtrh/V2mFggoQX+5lq//WDGvCNXOGuWFWXqGKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gi9JE31pU5xBW/DLC6TmGnMIr9Q5hrhHGRsmEqhqMaOTVTzRsR3EasPzG2W3SAq83
	 hvQAtVZnGUXY8HRVd0bZlCaMhvd6kDo+TZgwurNUm9fnHAjqpFfIN5ZG8+wBEm7EKi
	 6BOK+m2E6HXVb/ttmwAYUkJ8ed2GXDnvd2jc2w/CmrsQshw+qBeLv5R8GRVHVZn+uW
	 +5pDYe9irkXciWaIar4h+LzcpO/lpPWEBUhURuKyXmYh9+UvM7Omneq5rlN3quCtVQ
	 0uOxZpaU9g5huNId/4GfeCnH0Z37MXx9+YnZhNFjGSrBh6PdgTLzbGKd6dgVt7qFop
	 +TKbY42pl+7Rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 stable/linux-6.6.y 1/3] fs: prepare for adding LSM
 blob to backing_file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: selinux@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260627065720.1945589-2-caixinchen1@huawei.com>
References: <20260627065720.1945589-1-caixinchen1@huawei.com>
 <20260627065720.1945589-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 06:34:25 +0000
Message-Id: <20260627063425.D38E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> From: Amir Goldstein <amir73il@gmail.com>
>=20
> [ Upstream commit 880bd496ec72a6dcb00cb70c430ef752ba242ae7 ]
>=20
> In preparation to adding LSM blob to backing_file struct, factor out
> helpers init_backing_file() and backing_file_free().
>=20
> Cc: stable@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-erofs@lists.ozlabs.org
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> [PM: use the term "LSM blob", fix comment style to match file]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> [1. The commit def3ae83da02
> ("fs: store real path instead of fake path in backing file f_path")
> is not merged, The 6.6 LTS version accordingly operates on
> &ff->real_path instead of &ff->user_path.
>=20
> 2. Mainline's file_free() does both the backing_file cleanup and the
> kmem_cache_free() synchronously.  Linux 6.6.y defers the actual kfree()
> to file_free_rcu() via call_rcu(), so only path_put() is done
> synchronously in file_free().]
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627065720.1945=
589-1-caixinchen1@huawei.com?part=3D1

