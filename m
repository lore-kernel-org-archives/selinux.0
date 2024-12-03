Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FBE1F7567
	for <selinux@vger.kernel.org>; Tue,  3 Dec 2024 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242925; cv=none; b=byDgqB9Ft+siRHpYBAwTHtqkO03PJxD4JImx8hmWHhzaC0aVqaUKvQVAN1T2XNsfkR2INjA3h1cFtgCqrDPN45KzZjazxrAsPBMaq1Xvj2Tb7xL1uLYeC8QjNkctcDWvMGSya+1DMKSinCxIbVFDT6d9K67fZzL+gZ/LIgIm9M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242925; c=relaxed/simple;
	bh=LsMwIMZOjuShU/lPoTe2nBFcuGQu3K5RWWiKRjFHPZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fPiehOcIDOszk2p9SPYJJrf7jTvIE4AcghSimRu9GIg7dTY4gHUmPUdl+mzb5aVL23KyOhYLDNnEja4QGAXb7OVrItW4jhPBlbsZvt3BwcOoGwIA+OZ478ZS6jd3Qs3btNpD1QBHbWXDp8aqOrUtP4iVLgo/qTr2g6O90W4BtsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AsTtrTDO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsTtrTDO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733242921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1jlxvP7fUEKafkAqq0o1xFaCekBJkh/CXtcT7NGu2M=;
	b=AsTtrTDOSsyCqIpQHNO3T28ikUIr9Ed7lcRcbUn8zttchoYJDq3S5ZHaI4SgxuU1k06i1o
	PJDJzSrJRsr1xIJAjq2bUfev9fH32rujfaCGd09EPGZJa/a/bJJ3Tycl1rafObT/5bKaEM
	JOWHk14Ppy6PMwaiJcOXVMNX7Y12Zgk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-oX5XAzEMONWpnKWJrrmpCQ-1; Tue,
 03 Dec 2024 11:21:56 -0500
X-MC-Unique: oX5XAzEMONWpnKWJrrmpCQ-1
X-Mimecast-MFC-AGG-ID: oX5XAzEMONWpnKWJrrmpCQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E2FD1933144;
	Tue,  3 Dec 2024 16:21:55 +0000 (UTC)
Received: from localhost (unknown [10.45.224.23])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 169D91954201;
	Tue,  3 Dec 2024 16:21:54 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 selinux@vger.kernel.org
Cc: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH v2] libselinux/utils: drop reachable assert in
 sefcontext_compile
In-Reply-To: <20241203155448.48237-1-cgoettsche@seltendoof.de>
References: <20241203155448.48237-1-cgoettsche@seltendoof.de>
Date: Tue, 03 Dec 2024 17:21:53 +0100
Message-ID: <87ed2orb32.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Christian G=C3=B6ttsche <cgoettsche@seltendoof.de> writes:

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The two asserts following qsort(3) where useful during development to
> ensure the comparison function and the corresponding pointer handling
> were correct.  They however do not take into account an empty file
> context definition file containing no definitions and thus `stab->nel`
> being NULL.  Drop the two asserts.
>
> Also return early to not depend on whether calloc(3) called with a size
> of zero returns NULL or a special value.
>
> Reported-by: Petr Lautrbach <lautrbach@redhat.com>
> Closes: https://lore.kernel.org/selinux/87jzchqck5.fsf@redhat.com/
> Fixes: 92306daf ("libselinux: rework selabel_file(5) database")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Works for me. Thanks!

Tested-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
> v2: fix condition from not zero to equal to zero
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/utils/sefcontext_compile.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sef=
context_compile.c
> index 23d31274..e5da51ea 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -188,6 +188,9 @@ static int write_sidtab(FILE *bin_file, const struct =
sidtab *stab)
>  	if (len !=3D 1)
>  		return -1;
>=20=20
> +	if (stab->nel =3D=3D 0)
> +		return 0;
> +
>  	/* sort entries by id */
>  	sids =3D calloc(stab->nel, sizeof(*sids));
>  	if (!sids)
> @@ -203,8 +206,6 @@ static int write_sidtab(FILE *bin_file, const struct =
sidtab *stab)
>  	}
>  	assert(index =3D=3D stab->nel);
>  	qsort(sids, stab->nel, sizeof(struct security_id), security_id_compare);
> -	assert(sids[0].id =3D=3D 1);
> -	assert(sids[stab->nel - 1].id =3D=3D stab->nel);
>=20=20
>  	/* write raw contexts sorted by id */
>  	for (uint32_t i =3D 0; i < stab->nel; i++) {
> --=20
> 2.45.2

