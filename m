Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B914225787
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553596; cv=none; b=SBfcswkpbScuVkSWK29t2unI9bCYush7bLz0n9p+JtYHZhdPB4T5XJp0LftZsEcLOTmdDSkz4CKrfYeDlQEqu0pja9vloD/qJlO4ELdpCniYvBmsuFtEXX1eu8FKn2QN8MGH+SE4w3bJZe8ZlMAwQWVeCQ9CG0lSfl15Mbjsdwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553596; c=relaxed/simple;
	bh=/EkFMjhwappzu1182t3RAvHUkHWVP3l//NaEHnkng4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MvcM+pfFhS5MQl6uETalzmjpbBY8QwjfPzc2NBqPB8lnPljNcJP06Ds25Bl6Os1ShTTRu60eIf/EQDebToB2LrX6WkTAeaAQ0YcX5XZTZlqUVs+muzFl3kwaHU0MVwe6gOBQd4/a5O/IZ8Us1p70pxX1wfrhvogfRHjQQtQUqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXpE+nx3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXpE+nx3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749553593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psUuABZWEUuTWg1yJGszOt8n8iRPYr2PD6MVCPaJR00=;
	b=UXpE+nx3gXqgVD59H7HiD55/NkhCJjNqnGS5FKhJTq/6wSpcoFMT7nvmU+O9+sOhMeMUxM
	pwtszpKqs8GWrA5gvzw7KEsVT83rH1pbVwVjEcUX5cPCBW0qTCINqgQ1f5rFYU5oWhuvQf
	GZ/+U6kQ+QFOTWMThMIgZ/d7KAowDl0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-QGkankhoOG2MuUU-rPXAZA-1; Tue,
 10 Jun 2025 07:06:29 -0400
X-MC-Unique: QGkankhoOG2MuUU-rPXAZA-1
X-Mimecast-MFC-AGG-ID: QGkankhoOG2MuUU-rPXAZA_1749553588
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADED01808985;
	Tue, 10 Jun 2025 11:06:28 +0000 (UTC)
Received: from localhost (unknown [10.44.32.151])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04D0A195608D;
	Tue, 10 Jun 2025 11:06:27 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 selinux@vger.kernel.org
Cc: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>, Dominick
 Grift
 <dominick.grift@defensec.nl>
Subject: Re: [PATCH v2 2/2] libselinux: retain LIFO order for path
 substitutions
In-Reply-To: <20250530123048.53419-2-cgoettsche@seltendoof.de>
References: <20250530123048.53419-1-cgoettsche@seltendoof.de>
 <20250530123048.53419-2-cgoettsche@seltendoof.de>
Date: Tue, 10 Jun 2025 13:06:26 +0200
Message-ID: <87plfbetzh.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Christian G=C3=B6ttsche <cgoettsche@seltendoof.de> writes:

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Store the path substitutions in LIFO order as in previous versions.
>
> Fixes: 4d436e4b ("libselinux: use vector instead of linked list for subst=
itutions")
> Reported-by: Dominick Grift <dominick.grift@defensec.nl>
> Link: https://lore.kernel.org/selinux/87ldqftsxd.fsf@defensec.nl/
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2: add patch
> ---
>  libselinux/src/label_file.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 61a9ddb6..b785eab6 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -1350,6 +1350,15 @@ static int selabel_subs_init(const char *path, str=
uct selabel_digest *digest,
>  	if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) < 0)
>  		goto err;
>=20=20
> +	/* LIFO order for backward compatibility */
> +	for (uint32_t i =3D 0; i < tmp_num/2; i++) {
> +		struct selabel_sub swap;
> +
> +		swap =3D tmp[i];
> +		tmp[i] =3D tmp[tmp_num - i - 1];
> +		tmp[tmp_num - i - 1] =3D swap;
> +	}
> +
>  	*out_subs =3D tmp;
>  	*out_num =3D tmp_num;
>  	*out_alloc =3D tmp_alloc;
> --=20
> 2.49.0

It fixes the original reproducer:

root@fedora:/# cat /etc/selinux/fedora-selinux/contexts/files/file_contexts=
.subs
/new_root /
/new_root/foo /usr/bin
root@fedora:/# matchpathcon /new_root /new_root/foo
/new_root       system_u:object_r:root_t:s0
/new_root/foo   system_u:object_r:bin_t:s0

but it's important to say it depends on the order of entries in .subst:

root@fedora:/# cat /etc/selinux/fedora-selinux/contexts/files/file_contexts=
.subs
/new_root/foo /usr/bin
/new_root /
root@fedora:/# matchpathcon /new_root /new_root/foo
/new_root       system_u:object_r:root_t:s0
/new_root/foo   system_u:object_r:etc_runtime_t:s0


it looks like it was like that even before with 3.8:

[root@fedora-41 /]# cat /etc/selinux/targeted/contexts/files/file_contexts.=
subs
/new_root /
/new_root/foo /usr/bin
[root@fedora-41 /]# matchpathcon /new_root /new_root/foo
/new_root       system_u:object_r:root_t:s0
/new_root/foo   system_u:object_r:bin_t:s0

[root@fedora-41 /]# cat /etc/selinux/targeted/contexts/files/file_contexts.=
subs
/new_root/foo /usr/bin
/new_root /
[root@fedora-41 /]# matchpathcon /new_root /new_root/foo
/new_root       system_u:object_r:root_t:s0
/new_root/foo   system_u:object_r:etc_runtime_t:s0

It would be great to have this behavior documented, but it's a different
issue.

If there's no other objection I'll merge tomorrow before 3.9-rc1.

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

