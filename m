Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C99C225760
	for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639102; cv=none; b=HN4TndeI2ZpD3MtyKRkciUEMViUq3aENfplF8xANKcQhkD9LjUHpr0v29rTgwvUnBql3BCf1WeRFFfeRR8jtlkEjo/O1NKw5himv4y9ABVViqJ2SVXIWK+xeu8PGTsCqjji5Z+7lunJF5om3wTjNW7A/tGGux1iB/jAxXDXFePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639102; c=relaxed/simple;
	bh=uD9elZd5PmrggFQZ77ejP3NJX9IBGjm8k2ZJ3bBdchI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=gg1lvzAd1zUu4rtNRsTCxvW9/R61X7ieKiRnR6lukswJy6/BPbeTGwynH+bf3jTsoq2Cuxt3YN2nc9ElyoHnWMKCzDnslpt2h0QIdVyFby/CASYGyIUTPo1dYhfwwsmXDWN3pCZb+3/RDB4YBwtomG22e3mPetJ+2uTTBhm5qjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYP2HaVS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYP2HaVS"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b40f11a1027so199830066b.2
        for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760639098; x=1761243898; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzJFLTF2vPVkCFiUS3pOr5XUGo2C9vHak/HsDph8FIg=;
        b=EYP2HaVSbxtLxokjVw+NmRihgheRIVi1svObcgGLbTuhPTJpqpV71FLHSx/nsPNgg+
         GEYLfuaEM3P8i9bIfBtFyuf7sO9wA02vrOk+I1KgsfHWV59Ln0lICzIOsRnS9iWZ0kad
         8BS5NzwOxka3Qf8mP93qpzTYqYmcvIY5cEXfDyOEKgw25OXwJiNs787mWiTlXqpZN8Zb
         yj998Ac5NbuBjps16kYfVZ3J3pUSADUZ3DGeGNTfcmFidZE0D5DvntCtGLxLs4nJuOiV
         8D4d7aDMc+JyNDiaJiyYPoIDpb3y80a+qLnMw3ZyqDrHHfWcWfn1Ly1TMegmOkrP405K
         idag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639098; x=1761243898;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HzJFLTF2vPVkCFiUS3pOr5XUGo2C9vHak/HsDph8FIg=;
        b=VWH0032/zhSfGGZRuLrXT5RfcTo7v5khUP0wQ3J4E2ORZD62GbfvF4RPFL1iLo4x3/
         rQ7W29z1j5AQOB0zbigmiu/FyHRqoiJXv9lPwq1Zh5hdwgaksZ9SIy2oz9S0VKakiwOr
         4YA7DSPkWdx+BeoLedJbnMAwoWVCg0OVhwzrWzsduf7wJYnjDV9svIb8ciW3N4CDAkcr
         qLPVbg/Dn4NeQgUy8pJQMMN16mmqnKPWF0ZntCtJP6Q+Hji8S7PLIr1Y99pBVDoDXthI
         uDp1TXb3fWUvWTzZqaYhO162NsXaoJ8ITShcFQsSy78XqAWIuTbuS79+ltyzhXpP4NAN
         oElg==
X-Forwarded-Encrypted: i=1; AJvYcCWbgFsU0A6lq1fpbFeiF48Z/zGvb4CBif1kVvFQlj6GkN3iXr6CP3oT6axZSz5UqbI6/n1BmyPV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi9WKBXtunwdhCk3Amh3H9KJujH1R8DvFCm1pyxT/mzoMmviBR
	ZNWz/Ue5wILgvhbGqnIQOIVhX6VkQFYaCDDzpZh6JEYP3BuDlFCxaROq
X-Gm-Gg: ASbGncvAaQMPgpNKMX+d0TuYsu2RmII+Pt2NedA2MktndRr6KpgHpVKq4PfziiW6MNF
	nQPKDnYPTt4fKnCG2ApWyDlOFBNseO7HWF4hJ96S62P2v/CCfuc7f5Y0JMfCN6BHRlNFxBR+XAc
	33tD+5gcZrImkDr/Sc59rB79kB+BS5W8ff3vY+6DSYl8XKV31MroSXL2o6zDbNKNGeMQIC9fHE3
	f4OABGzy7U/0fVhEZhKQFDH57+6xS6xZ0/gbkEgEqsYM38/bNUngaNIiuwktOYDZovTblnZOCdW
	LVoDH8A+86DHvr3tfhdBIUa7C7xzjI4UmRVu7nBxBOjLLyjdE8nvNCiPJyV/nGwQpioVmor2SDm
	Y7hb5YFj1GTaSFzEntYcmnT0bpJa5krecwt8cBN2qzBGSd/zHu6n+mAETChZQpaxKvgRY68DavY
	xqjGwx
X-Google-Smtp-Source: AGHT+IE6BgVM5Jb9gXBWM2LFUBU+XVaLiLIPy0+Si2cmU+HxmVbfGcdj2uOFq0uiq/ESUUb+Xie9Vg==
X-Received: by 2002:a17:906:c104:b0:b40:5752:16b7 with SMTP id a640c23a62f3a-b6475124787mr99526166b.51.1760639098034;
        Thu, 16 Oct 2025 11:24:58 -0700 (PDT)
Received: from localhost ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdaa0f9sm585727366b.45.2025.10.16.11.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 11:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Oct 2025 19:24:57 +0100
Message-Id: <DDJYGZAJRMC4.O9KO64SAAPFJ@gmail.com>
Subject: Re: [PATCH] libselinux: Ignore files removed during relabeling
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: "Vit Mojzis" <vmojzis@redhat.com>, <selinux@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20251016180929.452863-1-vmojzis@redhat.com>
In-Reply-To: <20251016180929.452863-1-vmojzis@redhat.com>

On Thu Oct 16, 2025 at 7:08 PM BST, Vit Mojzis wrote:
> In case ignore_noent is specified, ignore files removed during
> relabeling (race condition between folder read, file read and label
> set).
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libselinux/src/selinux_restorecon.c | 30 ++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 39eabeb9..7cad4c8d 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -726,6 +726,14 @@ static int restorecon_sb(const char *pathname, const=
 struct stat *sb,
>  			    pathname, newcon);
> =20
>  	if (lgetfilecon_raw(pathname, &curcon) < 0) {
> +		/* Ignore files removed during relabeling if ignore_noent is set */
> +		if (flags->ignore_noent && errno =3D=3D ENOENT){

Nit: there should be a space after the `(` and before the `{`, inline with =
the rest of the code style.

> +			if (flags->verbose)
> +				selinux_log(SELINUX_INFO,
> +					    "%s removed during relabeling\n",
> +					    pathname);
> +			goto out;
> +		}
>  		if (errno !=3D ENODATA)
>  			goto err;
> =20
> @@ -765,8 +773,19 @@ static int restorecon_sb(const char *pathname, const=
 struct stat *sb,
>  		}
> =20
>  		if (!flags->nochange) {
> -			if (lsetfilecon(pathname, newcon) < 0)
> -				goto err;
> +			if (lsetfilecon(pathname, newcon) < 0){

Same as above.

> +				/* Ignore files removed during relabeling if ignore_noent is set */
> +				if (flags->ignore_noent && errno =3D=3D ENOENT){

And here too.

> +					if (flags->verbose)
> +						selinux_log(SELINUX_INFO,
> +							    "%s removed during relabeling\n",
> +							    pathname);
> +					goto out;
> +				}
> +				else
> +					goto err;
> +			}
> +
>  			updated =3D true;
>  		}
> =20
> @@ -932,9 +951,10 @@ loop_body:
>  		case FTS_NS:
>  			error =3D errno;
>  			errno =3D ftsent->fts_errno;
> -			selinux_log(SELINUX_ERROR,
> -				    "Could not stat %s: %m.\n",
> -				    ftsent->fts_path);
> +			if (!state->flags.ignore_noent || errno !=3D ENOENT)
> +				selinux_log(SELINUX_ERROR,
> +					    "Could not stat %s: %m.\n",
> +					    ftsent->fts_path);
>  			errno =3D error;
>  			fts_set(fts, ftsent, FTS_SKIP);
>  			continue;

