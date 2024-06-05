Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73896621
	for <selinux@vger.kernel.org>; Wed,  5 Jun 2024 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717609136; cv=none; b=pSbpE2K3TfuzPeR/ykrsx71wpk6VkEJxqgwpzB6TG+rOewD2foNJzN3pJa5TQJU28FXvNhwpr8RBRBZJH1j4etmZpVVZFZL7GI8FQyeK8NAC1eTVn2bV+jhALPYii0JKRRSfwiaSgGB3iqSF+IUDWUf0Sl3Ysq6xqSftTjTQ8Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717609136; c=relaxed/simple;
	bh=QNFBIXtdIe8k1P2zhh6TLnq3Qup3YLO8FJC7yYU0rMQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ScX69GyANtz4Qzuamfq+rBDEshNmcmMPfhKtPXkmCNZi9m5PvOYxpb+MXWf9JnnpH8TkkMsBL3+ds6N4aktuej1lxWM2Oc750ZA6/+/NfHzk/pSmNt5ntCnD6S1R2p9qo7seEJBVbIXIoIuUlCq6W19X+yeC5uuh/73w4nsiErs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0mEkFSz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0mEkFSz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717609133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWIyhwrxQl3aTleLMuuQVrzPRtIOMutHHdSP3DospjM=;
	b=H0mEkFSz18wwKeW71igaGb5gL7XQ/mDLT6aeskYHbctQM/WO7GFyBvVFtOCtQof6HLQHQ6
	72T+s6qFmF4H3ayuCnhbv9OoQ70kf+Ebx0cEMmZM4pTmE5/CK1/iaKXS7P0cNH+u7R0VoY
	EAxuAkqtHpXmC0fr/VYju89oqwd893Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-ZhCb8SOKM2yi9LJ6Q6X-Uw-1; Wed, 05 Jun 2024 13:38:52 -0400
X-MC-Unique: ZhCb8SOKM2yi9LJ6Q6X-Uw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEBAB811E8E;
	Wed,  5 Jun 2024 17:38:51 +0000 (UTC)
Received: from localhost (unknown [10.45.226.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C5A828A6;
	Wed,  5 Jun 2024 17:38:51 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
 selinux@vger.kernel.org
Subject: Re: [PATCH 11/15] checkpolicy: fix use-after-free on invalid sens
 alias
In-Reply-To: <20240122135507.63506-11-cgzones@googlemail.com>
References: <20240122135507.63506-1-cgzones@googlemail.com>
 <20240122135507.63506-11-cgzones@googlemail.com>
Date: Wed, 05 Jun 2024 19:38:50 +0200
Message-ID: <871q5be1cl.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> During compilation sensitivity aliases share the level with their prime
> sensitivity, until after the level has been fully defined they are
> deduplicated.  If an error happens by that time the cleanup will free
> the shared level multiple times, leading to a use-after-free.
>
> Make use of the added new member of the struct level_datum.
>
> Example policy:
>
>     class c sid e class c{i}sensitivity S alias L;
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>


This patch seems to be skipped/missed. Others in this series were merged
or commented.

Petr


> ---
>  checkpolicy/fuzz/checkpolicy-fuzzer.c | 7 +++++++
>  checkpolicy/policy_define.c           | 3 +++
>  2 files changed, 10 insertions(+)
>
> diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/che=
ckpolicy-fuzzer.c
> index 0d749a02..d0221f3f 100644
> --- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
> +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
> @@ -134,6 +134,13 @@ static int check_level(hashtab_key_t key, hashtab_da=
tum_t datum, void *arg __att
>  {
>  	const level_datum_t *levdatum =3D (level_datum_t *) datum;
>=20=20
> +	if (levdatum->copy) {
> +		fprintf(stderr,
> +			"Error:  sensitivity %s is still a copy!\n",
> +			key);
> +		abort();
> +	}
> +
>  	// TODO: drop member defined if proven to be always set
>  	if (!levdatum->isalias && !levdatum->defined) {
>  		fprintf(stderr,
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 44236797..360cff68 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -756,6 +756,7 @@ int define_sens(void)
>  	}
>  	level_datum_init(datum);
>  	datum->isalias =3D FALSE;
> +	datum->copy =3D FALSE;
>  	datum->level =3D level;
>=20=20
>  	ret =3D declare_symbol(SYM_LEVELS, id, datum, &value, &value);
> @@ -795,6 +796,7 @@ int define_sens(void)
>  		}
>  		level_datum_init(aliasdatum);
>  		aliasdatum->isalias =3D TRUE;
> +		aliasdatum->copy =3D TRUE;
>  		aliasdatum->level =3D level;
>=20=20
>  		ret =3D declare_symbol(SYM_LEVELS, id, aliasdatum, NULL, &value);
> @@ -1035,6 +1037,7 @@ static int clone_level(hashtab_key_t key __attribut=
e__ ((unused)), hashtab_datum
>  			return -1;
>  		}
>  		levdatum->level =3D newlevel;
> +		levdatum->copy =3D FALSE;
>  	}
>  	return 0;
>  }
> --=20
> 2.43.0

