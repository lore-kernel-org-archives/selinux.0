Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9C547F77D
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526000; cv=none; b=K1K/idcpfe/VrROGoxk6GLkaExwW7vEt+laNlmeWuBHGdgHushHgV2XtAUiprvKuc6BaJABtubHl1uDttBdZBCNJvF2Lb4kqTYyg2dIRP8HKHnFE6c+RgHJ4IhzD/K/cTdyFqrQ2Na44AR55yGPc4a4ImSa2Z3wFq17FVazNTVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526000; c=relaxed/simple;
	bh=RIxTJjfMVAljUreDOLy0DNxiZl8AYbGHUBf0CI4uVR4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WyrBzxhDAcOCbnxFi/t5p9ziDokoEaNALfzDWYOg8IyJyxjMqOriS6z+KC7rNxIYaA0KoIOeKrw1BADNi+xNgvzBip9MWdal+KwRDDRKJgWtu6lhPOjG3/i+3nPgovQAMZf9KvM9KjSNzecsd/6o8nV3MgrQb84Idv4yRU5xcwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/DTObeU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/DTObeU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788525997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v4WCEy76mZ3dhesnAjSi2JHRIqddCMUG/CZNelbC/Fs=;
	b=H/DTObeUdSb0Ws/kGo4Mp5hnrNBqj0qXmWYuzeKevGoD8sbU7NfYkop2EJBFS5aJ4DZImz
	p0YpTqYtocekoifSd9VlbJsqF/7vnijE2L9r3cY0XgHJjF/3DiWIWFZdCMXdwpVdig2wXB
	BiaLeHUhyJYRUymYJvJEwLNySGMrtWM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-zSswoNAkNgutQw8IHQK1lA-1; Fri,
 04 Sep 2026 08:46:36 -0400
X-MC-Unique: zSswoNAkNgutQw8IHQK1lA-1
X-Mimecast-MFC-AGG-ID: zSswoNAkNgutQw8IHQK1lA_1788525995
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52D1E1888628;
	Fri,  4 Sep 2026 12:46:35 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB8461955F10;
	Fri,  4 Sep 2026 12:46:34 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
 selinux@vger.kernel.org
Subject: Re: [PATCH userspace] SECURITY.md: update Ondrej's email address
 and add GPG fingerprint
In-Reply-To: <20260903155837.516393-1-omosnacek@gmail.com>
References: <20260903155837.516393-1-omosnacek@gmail.com>
Date: Fri, 04 Sep 2026 14:46:33 +0200
Message-ID: <87ik4l18wm.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com> writes:

> I'm going to use my personal email for upstream contributions from now
> on. Update SECURITY.md to reflect this.
>
> Also add my GPG fingerpint. The key is not yet signed by other patries,
> but I've been using it to sign my git commits for a while now. It can be
> also found at:
> * https://github.com/WOnder93.gpg
> * https://gitlab.com/omos.gpg
> * https://keyserver.ubuntu.com/pks/lookup?search=3DCEEE4E9CF1676119&finge=
rprint=3Don&op=3Dindex
>
> Link: https://lore.kernel.org/selinux/CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7V=
YpK8KuseMQS-9tNA@mail.gmail.com/
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> ---
>  SECURITY.md | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/SECURITY.md b/SECURITY.md
> index 52ab863c..1f255c81 100644
> --- a/SECURITY.md
> +++ b/SECURITY.md
> @@ -40,7 +40,8 @@ window.
>    *  (GPG fingerprint) 578C 4211 832F 0A7E A2C5  A7C2 21A4 6E60 3F74 4ECF
>  * Jason Zaman, perfinion@gentoo.org
>    *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EAF
> -* Ondrej Mosnacek, omosnace@redhat.com
> +* Ondrej Mosn=C3=A1=C4=8Dek, omosnacek@gmail.com
> +  *  (GPG fingerprint) 9F17 354B 2928 339C 5130  906D CEEE 4E9C F167 6119
>=20=20

I hereby verify that this is Ondrej's key

Petr Lautrbach
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEcgDrLD9eSIRjwM6ezcroySfGvjEFAmqavYQACgkQzcroySfG
vjG7tg/+KTaC0uj3MQz4henqElcCjNsuhPhmQ/8mVGyzRGvCr3UaH1OBazvmM7Fb
88vaDkV3A95ZLYZRk7X/aANlYB44f4I1ncIew9H+bOISaehCTO86xQXs0z8qNSol
2bduHbDT22wWDvgxqhGnc9UEd7dPwLvf/jQ3lLabavfslK+G0PKxSaoBVX8Yz1ZH
/J1z5AxnIGIl5UQpYoIzXsmwK/fIcvGZ8q0+XPLEi7pz9fzpS+QE8Jp04U/QSdKo
1TN9RtsLgCXIvlcXbEZjpBLBxI3lW1bLnq2tJlfj5YtT7RnI4TSzwaZ8HC5TsDU/
qhUEXzMAUmKcOvfvZJ8b6w/ehbN3BkcDyUDtdMEZXLyzZjNoJttOa0FoW9nfwoeU
wnLS7hTVdNnkVui1VWuq9GWtqhbgp6+KDYtBbE7GHzzvycMBJOIZakgwaOsc7pvQ
+vddPu75XwnzyJmC3/kEnGUsOyHyPfwJZ4/+Etos48KZHOE/2I6skmoRXhGasAe/
9NTL1vM5eKWhZWZV2QMAgkgoB7oulPC+EZXKiBrE13uTACibUCKO/ZC1+XLlIIDE
kvUQEgfhct2WTunr/DBquqU/4AojIsNZdOa3SVAez+viFWf29v40edtKGVRUTZG9
dx0J1hK5KP92kErl4am8G088DHAnU5jeXbtrB8gGTmmhRqXxTIs=3D
=3D/OCL
-----END PGP SIGNATURE-----

