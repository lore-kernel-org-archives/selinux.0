Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F374156F0
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279597; cv=pass; b=qsDUdwJEbQT+WO9yLRBpLf3VnVF9ikxJmrPm47+dRJUbJXeCWpVh9R88s7RNbd4SwaqXxcgMp2vmRJhYvFOrzjX5/h66bLTJQNlQx83nnVNBzyFzM4CaVNXx/3RC70qcbXcULiXna06WCLEPhtKP0KyMAcN/NItJBYl5WMKIBgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279597; c=relaxed/simple;
	bh=IUcrGWiJR1uzA7cra8lxbz+nYgHRa4AfxDzyUnHrJwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLLlIZ/wEOhUwc8Lu6Ny+Utxc9aX9/Z2GV/XSz4ndykttb00SH+87izwABVHN/P5aGzogbEFTwLJ2m3hN0OHhd8xIa0Pt4Kv0wlKCZ19LCvtcjJO8S7yxmzpG2nRpEXuRdUzvXosOP02Jh9l1ICfdLs2a5VyVesfBzRbmHg9i9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VttRdMNV; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VttRdMNV"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd53691be5so910135ad.1
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 12:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790279588; cv=none;
        d=google.com; s=arc-20260327;
        b=Zn5Ud8lqwKvXKG/qykWcBBTYrSgnDb2sVp757k82XkO+ToG6ur9XvUD5jpoX/ToqXJ
         dK1mMAZXgNd8yEjBNhsPrvm785Mqr421WO8LUq4KugLPzEUmp9DXiVj9yj0LpWNyjFjG
         hcmbxmstBm+LXqxgG76kPXwAvvdx1msdLexsoVXLwYYlbOcrDE6ZAhAELsSgJ43jb0zv
         yF7bn3WOqwz2q63oHpNIeDyVKDHPfrbByNH2LM5CA+hK/GZYVudjCqr+MsF3siTEs0hR
         gqfTHa+2QGmBEcd8KHZ+GbUaWrJ9cdB/53DzA4uCRLe++4XE7DnBov6EZWuHuFHt2c68
         N3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ka4vhjO0Y34np2NFECQERBXtTKAZ8dWAgfAVbGxH7U=;
        fh=Niow270oPMw1fVz1wLhLoyJbZweXbCmphCpZABBojUo=;
        b=a7FXSPoc2yShrtspGtg+TKL3yygTGa1gYZCKXvxWGBKQ+xHDAM+R8FW4nbO8QWsAeS
         acVqmCDxQgJiulspC964hSp+/N8NElrA9gcFjemMFVbZCM+A1V37vKtoIVVFP0mFi0DM
         /YLiCHc1Q+uYrggtGvqb36WGqNAhtU5eVpwj8EadtlEgypmTnT/ASq+82Uuqp/jSEtca
         /nHav96+af7YJEnK+yaxOteEOV1mMHQ03u0RAYrfwJMa4gl493lw0BJN5nYOz2xwi396
         8bV1Yz1S3NfSc/sYEQFpS0/oQWCTZ9uWAGnFw7Hg+Wjztj9GissJ13RfNLUg1gzQ83zr
         bhnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790279588; x=1790884388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ka4vhjO0Y34np2NFECQERBXtTKAZ8dWAgfAVbGxH7U=;
        b=VttRdMNVoIgsVKWpl1ZQfzJr7RtMx7spkH7wAxkK32qsrrZxygdtzkY9e3b6JmOLfN
         DZqEwNqz1Arz4aWydPZ5NJcDuIKicxpGt/i/TwVvP0k3ikY1Dd/KHByW/njK8nLtkC4A
         9J+trZNDldvoNNIYF02JuZFvVbBuiqTnBZX50/DYTCoYGVMPjKttUA2CKPXR7gwnZwJy
         O6oBrOZd6p3aaDS57yJ/u5cBxWbSadKfmN/HOAWsT3oplVlc4QDvkQ1V75LKG2XDq5/H
         TfJjnwSHezFx8wwJETEyW41uK0xHiBgZ2XoQx/6hCGPqtn2TbfXvWX6AwQzrHS1JM0lD
         mQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790279588; x=1790884388;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ka4vhjO0Y34np2NFECQERBXtTKAZ8dWAgfAVbGxH7U=;
        b=0tnHTmC5fxneQqVmjEwqqChlwIA0QpDFfqUH32f9PozJoTcbO7hdRIGcb/Y0vViRbq
         Qx2cloMIT2ijg6yzSiYWqpyq5aMH/99cGx52SA4R/wBIVFmmriUsRsQ4bi6+lX2ckehU
         LYvUIZocha/iCc1rZJURFtQDIC9tQb3CVfyIrXqGJxLv0uPBmwoUcGKYC5Yg10Jg2jkR
         7f7ntuSyoYAqnulrJLZFqH07P6aAfS4tXPAqiFRA8Mxuj2FohPLacJbS2MY1bO5lOwoT
         QE9ALz9Z1682doq6YLzqUfUpYBwQXjWPtE40i46mf34kmuMfHcn3uRCpu3Jr/pAlKq/y
         fxdg==
X-Gm-Message-State: AFuF++lPg1WerQVWQlUNL+AD2SXIHymfku3wozubg2+XM9XRmxH32Lps
	uFGdoe0TmvApgqQDPEFp78jc7oSPiT9VWKUKsJFgx2kbYFB2syjVB01jgDN14hvfjGNCah0iG68
	Q8y8wq5q8d9dDFw27bL7x7Qd/yGf7OAABgzh3t1MxO+AkACTHxGV2zQ==
X-Gm-Gg: AYBFou1LXr4SSe/prxCP6WAVd+ONiGJwcMemOjSjmo2RYYImrl8FLXhkcEH9Hmc+jkm
	zc+A9Gr3VYTCjgCSyS9nwlNQgPtCa28kYnDMo79svuOXWHQ9NULWLeI7Mo9XGycalX9K/VaGAHP
	X5oFDaH/BOQt5Bv6akY130QOSVwB61V/dbzlmQ0PCOfdKMabNNsBwKU6CV33smfTfZc2I+1t9E0
	GZpbkRQJ1IN54Ka9WPh53Y99k85UCLTOtvFs2M32/5w1UbzTHcaDf0cu0XjITOBOpq9nQQUKRql
	Hjn3FC48ZWSfsDQ2PX3VIIByyYUjPPhr7lBXdRvidPr8x0YAZC88kPMVQ2bHiJOwWYcG8RqySZH
	195A7Ohhed3M=
X-Received: by 2002:a17:903:2ac7:b0:2dd:ad74:ac7d with SMTP id
 d9443c01a7336-2df7e27c485mr34588925ad.24.1790279588501; Thu, 24 Sep 2026
 12:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923165248.56940-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260923165248.56940-1-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Sep 2026 15:52:56 -0400
X-Gm-Features: AclHuK-VmJOOkKfLNuKagC6ZlVdIvVBWZ8vvafpxz0kUskEZfeFygCi3GgXOaKk
Message-ID: <CAHC9VhTYA54ThOArtOihdaYLgH30RXOnq=-RT1w49kiY7ug0TQ@mail.gmail.com>
Subject: Re: [PATCH] SECURITY.md: update to reflect our current disclosure practice
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com, jwcart2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:04=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The upstream SELinux project has never posted security advisories to
> the oss-security or distros mailing lists. Historically this was
> handled by the distribution security teams. With the recent enabling
> of GitHub security advisories for the selinux userspace project, we
> have started publishing security advisories via GitHub and on the
> selinux mailing list but are still not posting to oss-security or
> distros. Update the SECURITY.md file to reflect this. Others remain
> free to forward advisories we release to those mailing lists if
> desired.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  SECURITY.md | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Looks reasonable to me.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/SECURITY.md b/SECURITY.md
> index 1f255c81..8d690eee 100644
> --- a/SECURITY.md
> +++ b/SECURITY.md
> @@ -61,15 +61,6 @@ and responsibly disclosed. If a CVE, or other tag, has=
 been assigned to the
>  problem, the GitHub issue title should include the vulnerability tag onc=
e the
>  problem has been disclosed.
>
> -### Public Disclosure
> -
> -Whenever possible, responsible reporting and patching practices should b=
e
> -followed, including notification to the linux-distros and oss-security m=
ailing
> -lists.
> -
> -* https://oss-security.openwall.org/wiki/mailing-lists/distros
> -* https://oss-security.openwall.org/wiki/mailing-lists/oss-security
> -
>  ### Maintainer Process
>
>  This is the process maintainers will follow upon receiving a security no=
tification.
> @@ -91,4 +82,4 @@ This is the process maintainers will follow upon receiv=
ing a security notificati
>     period up to 90 days if the complexity of the issue requires it or if
>     severity of the issue requires coordinated rollout amongst distros.
>  6. Public disclosure will involve pushing the fix to the public repo and
> -   publishing the security advisory on Github and to the mailing list.
> +   publishing the security advisory on Github and to the selinux mailing=
 list.
> --
> 2.55.0

--=20
paul-moore.com
