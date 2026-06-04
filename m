Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387E481A82
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590227; cv=none; b=kt1lel+DnINNK746UroExU0kKnC+/z/9+IVZQdPNfUNaxzANq80l+BtYVGKoEnDKNA3kQk865PlmXOXq6GjA7z1zIYPb5RxfRNbYwgZBNIJLRqCVzKaTmEB6lLt7nGV5iJYZiMAUh0owIj/j8flPluwhhA1um6FYdpWq2gBQ/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590227; c=relaxed/simple;
	bh=X8WbjZh/86WdWRPk7Kmd6W0Gio2xxUhxxPoCyThpJ/Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=I0Wl5Ilgo3f5VolzeSWEfoL8Tn0Xx7/k2a1s6CtaRrPqExD7Ossjt5NDCXhcMXEvQ2aYoZ2GJ6ZDCShnZ0xKavIO2zdFsVszFu5C1zCVYZzNkZVc06jM3hZPtVf6Zu4IuX/EnytuTtRQnaXaNVnIoZVUJecCn+cUgqf+7lMw5Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=lIO+Lryd; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="lIO+Lryd"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 38977240028
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 18:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1780590214; bh=Ubf4lnLsj00y739zZIAUdKDSo7iZgv9pVnbNHhg0ktE=;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:From;
	b=lIO+Lryd2Avs7g7ragOLzym291Hj2IH2NwUm2Fvf77kB5MItjrE99zl1r+mg9GH/I
	 FkFeW4VKNly5p1EEG3pz+6AMKM6GnutfNzPoSdcxm+GJaJ/wxQU95UaZDDyqUsHcfW
	 L77oaaLJhRiHIx66igLaCm13zJKzeaQuf1wCP7zxgkemDMQw242C6RJtykIJlTHQyw
	 hIGqXw714+Ldd8dTpLO4V/J1RDZSA2+ohy9fZAKNEXAN70BvOMl3aFgz+OrnBV+e4s
	 YNrmIdrY8jpW2UARBEDawOSqwTplIwkG8M449U97+SVj9FOfUT++CDOEI/jj4wCInQ
	 X+SSvNZM7qqHw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gWVHT3fSNz9rxG;
	Thu,  4 Jun 2026 18:23:33 +0200 (CEST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 16:23:34 +0000
Message-Id: <DJ0EJVG6WHK7.1LTNKAF5YA8BQ@posteo.uk>
Cc: <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3] Have clang-format ignore auto-generated files
From: "Rahul Sandhu" <nvraxn@posteo.uk>
To: "James Carter" <jwcart2@gmail.com>, <selinux@vger.kernel.org>
References: <20260604155319.16844-1-jwcart2@gmail.com>
In-Reply-To: <20260604155319.16844-1-jwcart2@gmail.com>

On Thu Jun 4, 2026 at 4:53 PM BST, James Carter wrote:
> Add .clang-format-ignore files listing the auto-generated files to
> ignore taken from the .gitignore files.
>
> With the exception of libsemanage, place the .clang-format-ignore
> files in the same directory as the .gitignore files. For libsemanage
> which has a .gitignore in both its top level and src directories,
> just place one in the src directory.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Rahul Sandhu <nvraxn@posteo.uk>

> ---
> v3: Add missing newline to end of libsemanage/src/.clang-format-ignore
> v2: Use multiple files instead of just one in the top level directory.
>
>  checkpolicy/.clang-format-ignore     | 3 +++
>  libselinux/src/.clang-format-ignore  | 3 +++
>  libsemanage/src/.clang-format-ignore | 6 ++++++
>  libsepol/cil/.clang-format-ignore    | 1 +
>  4 files changed, 13 insertions(+)
>  create mode 100644 checkpolicy/.clang-format-ignore
>  create mode 100644 libselinux/src/.clang-format-ignore
>  create mode 100644 libsemanage/src/.clang-format-ignore
>  create mode 100644 libsepol/cil/.clang-format-ignore
>
> diff --git a/checkpolicy/.clang-format-ignore b/checkpolicy/.clang-format=
-ignore
> new file mode 100644
> index 00000000..f6b7b435
> --- /dev/null
> +++ b/checkpolicy/.clang-format-ignore
> @@ -0,0 +1,3 @@
> +lex.yy.c
> +y.tab.c
> +y.tab.h
> diff --git a/libselinux/src/.clang-format-ignore b/libselinux/src/.clang-=
format-ignore
> new file mode 100644
> index 00000000..001f20b0
> --- /dev/null
> +++ b/libselinux/src/.clang-format-ignore
> @@ -0,0 +1,3 @@
> +selinux.py
> +selinuxswig_python_wrap.c
> +selinuxswig_ruby_wrap.c
> diff --git a/libsemanage/src/.clang-format-ignore b/libsemanage/src/.clan=
g-format-ignore
> new file mode 100644
> index 00000000..2d2d8e8b
> --- /dev/null
> +++ b/libsemanage/src/.clang-format-ignore
> @@ -0,0 +1,6 @@
> +conf-parse.c
> +conf-parse.h
> +conf-scan.c
> +semanageswig_wrap.c
> +semanage.py
> +semanageswig_ruby_wrap.c
> diff --git a/libsepol/cil/.clang-format-ignore b/libsepol/cil/.clang-form=
at-ignore
> new file mode 100644
> index 00000000..3eb2902f
> --- /dev/null
> +++ b/libsepol/cil/.clang-format-ignore
> @@ -0,0 +1 @@
> +src/cil_lexer.c

