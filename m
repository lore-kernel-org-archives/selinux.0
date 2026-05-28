Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BDF26CE32
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976412; cv=none; b=MT8MuQ1QaRBUdq2WTjat1o8Yy3kNtygKrDu1fplyoVt5q2QyXzRu26VenSLUpqay9rZT+rce8fG+Mz7XD5OL8vK/64Te6vlDyB5zqw4C+hMrsddeXNb3hOfn71J0AQpdNkWA/+I6b/1suoW1tMBi689U/65RtjJ2sLKPPy/ZFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976412; c=relaxed/simple;
	bh=k0MF4pBq3YKRpctbwO7OKi+/WJDUV6r0y/W6fLv65YA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dF9VFVy/aB5WLHPjQzq3dHxjn3EPLN5XzAP7ixflcRgwPlQKPDpe3oer6qlfeYXxVRyME3t7KFVLPSlqTDakUdpUwdb1xAhfuOfF5eB8XtW3HhHLq/MEk4nOKmZpPhs1CAmluDC7scQLjs3HYsmTt+4eFjgUhFp7f5H2yFA4x1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUtt+CKO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUtt+CKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779976409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTbo67J9emavKMpTIhAepwifK360p5pTIgWY+RcZ+u0=;
	b=fUtt+CKO9uX8i4Ax5999cV8dVPzfZivDK2ENPw2jmmHxxKar9wMoplca+t7tfZqT7A4XEj
	EZRnNM9jlyYBgQJKYaJfSIJaOInpMbAgyiTBjNVnVNuir215JDlTAQfuF3+5GroFjAoI4z
	OBx4f+92mHYP6AtCtg2dhtHDtZkAUAs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-34zRHg32PPCcN4jKEBDfaA-1; Thu,
 28 May 2026 09:53:26 -0400
X-MC-Unique: 34zRHg32PPCcN4jKEBDfaA-1
X-Mimecast-MFC-AGG-ID: 34zRHg32PPCcN4jKEBDfaA_1779976405
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7027195608C;
	Thu, 28 May 2026 13:53:24 +0000 (UTC)
Received: from localhost (unknown [10.44.32.147])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 765A91770;
	Thu, 28 May 2026 13:53:24 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Pepper Gray <hello@peppergray.xyz>, selinux@vger.kernel.org
Subject: Re: [PATCH] adjust audit2why map for python2 and 3
In-Reply-To: <CAHLDejxHRvHPWYK8q-VO4_OpEozY-4bKc4hSuFL6SL6o=JKw_A@mail.gmail.com>
References: <CAHLDejxHRvHPWYK8q-VO4_OpEozY-4bKc4hSuFL6SL6o=JKw_A@mail.gmail.com>
Date: Thu, 28 May 2026 15:53:23 +0200
Message-ID: <87a4tjod2k.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Pepper Gray <hello@peppergray.xyz> writes:

> From 3cd62189af93997ab5ff58684352af38900c7758 Mon Sep 17 00:00:00 2001
> From: Pepper Gray <hello@peppergray.xyz>
> Date: Sat, 11 Apr 2026 19:33:07 +0200
> Subject: [PATCH] adjust audit2why map for python2 and 3
>
> align conditional python symbols creation and export
>
> fix: #461
> Signed-off-by: Pepper Gray <hello@peppergray.xyz>


Please use `git send-email` to send patches next time.

Python 2 is not supported in this project since SELinux userspace release 2=
0191204 / 3.0
Python 2 EOL was January=C2=A02020.

Petr

> ---
>  libselinux/src/audit2why-py2.map |  5 +++++
>  libselinux/src/audit2why-py3.map |  5 +++++
>  libselinux/src/setup.py          | 16 +++++++++++++---
>  3 files changed, 23 insertions(+), 3 deletions(-)
>  create mode 100644 libselinux/src/audit2why-py2.map
>  create mode 100644 libselinux/src/audit2why-py3.map
>
> diff --git a/libselinux/src/audit2why-py2.map b/libselinux/src/audit2why-=
py2.map
> new file mode 100644
> index 0000000000..249f0beb3b
> --- /dev/null
> +++ b/libselinux/src/audit2why-py2.map
> @@ -0,0 +1,5 @@
> +AUDIT2WHY_2.9 {
> +  global:
> +    initaudit2why;
> +  local: *;
> +};
> diff --git a/libselinux/src/audit2why-py3.map b/libselinux/src/audit2why-=
py3.map
> new file mode 100644
> index 0000000000..e99b8d7688
> --- /dev/null
> +++ b/libselinux/src/audit2why-py3.map
> @@ -0,0 +1,5 @@
> +AUDIT2WHY_2.9 {
> +  global:
> +    PyInit_audit2why;
> +  local: *;
> +};
> diff --git a/libselinux/src/setup.py b/libselinux/src/setup.py
> index 679ea43f8b..9201448f0e 100644
> --- a/libselinux/src/setup.py
> +++ b/libselinux/src/setup.py
> @@ -1,11 +1,21 @@
> -#!/usr/bin/python3
> +#!/usr/bin/env python
>
> +import sys
>  from setuptools import Extension, setup
>
> +PY_MAJOR_VERSION =3D sys.version_info[0]
> +
> +if PY_MAJOR_VERSION >=3D 3:
> +    audit2why_map =3D "audit2why-py3.map"
> +    description =3D "SELinux python 3 bindings"
> +else:
> +    audit2why_map =3D "audit2why-py2.map"
> +    description =3D "SELinux python 2 bindings"
> +
>  setup(
>      name=3D"selinux",
>      version=3D"3.10",
> -    description=3D"SELinux python 3 bindings",
> +    description=3Ddescription,
>      author=3D"SELinux Project",
>      author_email=3D"selinux@vger.kernel.org",
>      ext_modules=3D[
> @@ -19,6 +29,6 @@
>                    include_dirs=3D['../include'],
>                    library_dirs=3D['.'],
>                    libraries=3D['selinux'],
> -                  extra_link_args=3D['-l:libsepol.a',
> '-Wl,--version-script=3Daudit2why.map'])
> +                  extra_link_args=3D['-l:libsepol.a',
> "-Wl,--version-script=3D{}".format(audit2why_map])
>      ],
>  )

