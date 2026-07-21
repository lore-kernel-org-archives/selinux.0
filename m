Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162E42D73B9
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638005; cv=pass; b=hc/l7cwpUp3273E40UWjO6UIeREHhjvPuO7R36Zv/Ew91UQ9aTxm/dgwIM/97wzDI6q8T0zKKd3uJ7gRow4Q/PlKA1Sv+ZA3z0PQSsZJ58vROmDPdNkavgfL8KqCJTAuoT5ihlcCaVcZdG0e8PT3qgSFIQnJDQaHCcOPCrVg99I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638005; c=relaxed/simple;
	bh=nXOw3tfuMHvnPB0zVjRqtoT8j3DKYrF4xWTQHAALFss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rfh4GxHDkBIL9Oj84V1LBMIUXX5rLfCrdZ+MErpIab2RWtUhR1rT0tYywCUTrn5rlX1wBvOBt0Gzl6PM0miThGsckfpnlu+Wz2yvy5Xzuc/SfqZQfv8yOpcDb9h1iKzRrdZWaBHkF987+1ktx+NyJw0he75pAnwMPunsJLIG01s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlFV57Zr; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlFV57Zr"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce98cb8165so50973795ad.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638003; cv=none;
        d=google.com; s=arc-20260327;
        b=NRW5y0BnrIa67edHgeRn2MQSAIPlsAuy0W5FgzIy8yTTNA9AxlRSYEhqbgS3zQ/Nmr
         npya0Anj9TJameMaypFz7GqoEs1qguYQCcWo0avCyjf3yErd/NP6IqoLyzPZeWQnDY8x
         Uv9Us/3byHT/4ElK+uZbiKXuMtcEmRQPYOFE++GF/YOUhilkgnA5wEg6mCQh1/d5Tpeg
         NzozuoHJqRiTmy34Wpn9jfl0QZnB+kXUHVl5SWU50hDlIfE1ZAwW34HmoCNVskssA22L
         DkDEFc6HQuI4qb2ZigfTvqFh+bIZlP3rd17GpZUHbxL+NJzflVEZ3Uscu4Y3EkXnyvxU
         JOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4jNcYDTYIit8GYBA/idkNQq2GywWo3jvABVtu8mGb94=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=NGRqn7n6+ZQ+03vBVws2aL4TN8nHT1uMrirzIAvlGJoKW2K9DZcoHSlsmBFKyxkVOd
         B1buVy4EqA9x3m/c6zEURIcZ0roBNsQ+7Rxg9EoS9QuAX1I01SFTj3c7yRpIXpx+IF5F
         wqi/jOijnH/g0xgrS7H2Mr4hK05vhb59j+Mz+7JYBz4gQIegdJQDNLZhG7/W8hQ1IkGp
         Y95HeP1+qNMWgG/+xPhzxErvVf/ibmUsOqYK/Cvb8QSkyRiqkJbaeEv7DHR4UeNymsAE
         UMT4jiKqpoeN8iFf7VAyt+OQkF6dVhcQCEEHlxKdoGlwSVw+VQSwX7YTvNeQ62uOP3v0
         8U4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638003; x=1785242803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4jNcYDTYIit8GYBA/idkNQq2GywWo3jvABVtu8mGb94=;
        b=UlFV57ZrP6ajoCb2yYJKidOemXMd/qlj2hkwsIhUtt5SHWncEERNqVApHMCXoRx18D
         wMFSdLWC8SNMJyLXTUQ96bexm7Oa4uaYPFd81Onx0zTSOaTbIuLhGrN686RGdAKGIkxW
         pcQ1KdbtVc9ByDKGyCdXG2gCW2aepRIPqYXmH/buWi82KsmvhRsk+kpCCtV+MBciy6tg
         G1GC9tgy3HP1q1d5zXrg4fW97wABJICWxagM/4emLV59yviG/u99ZMrF7PAarkAVeeyg
         RMizpIuqZ8K4bmPTPEFbXFSiuitBcNsckrw3KFY0ncTS8YLBkPcwZmXZK3E+G8ZXhR+r
         DuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638003; x=1785242803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4jNcYDTYIit8GYBA/idkNQq2GywWo3jvABVtu8mGb94=;
        b=Sj/Lqn467YpGoLQAFRaTuIp/LyTglnY4W3vUVPuhStgf/g3ALor2yb4XVBZsmXRYmw
         OHgHF4f61IFE1ptwncMsRy+DzdLdmdhgFs2jtU8r0OBLkOlW2q43YQqbCB2zSt8NDZK0
         6rHltul0zG+aIh3ObY9TvoSgIXjtdZkYYhH5L2D8912bO6dumzgGoyJoKpGaWhUZ9SeW
         TZVHiXpDuMXlbaDnDkU5AwJfbv/+s14RtKQ2lSFH1ulM3IXKld9L85SXdBrgLXlWgSYg
         1iGmso6grQtM0Hx75W4Rx4SIuJ99zL2h6ol3EVMzlAcnFWbby3qxgRsuVkQql0zJz6Q+
         UOkg==
X-Gm-Message-State: AOJu0Yzo9IXkGh64sALHkU+hncm6Pk01PQ4rpO9/ogz+tEzJ0fgRnJp7
	9EXcIVVN9EBV/FC+DgFiOSVMRd5CM2+2LX/IVB9QP1YRAtXUHWEp0TGW6L8tt2yPYupyPQ8AWG3
	+/NCs6NgsMtpVpgVcxO16p2RuNYEq2YjHGw==
X-Gm-Gg: AR+sD13pX9ZIYuYrq7xIJw/hDoU+scYW3WV8RFyWKCAicR7+ZGJIzL2PliPR3Yhqqph
	vw9Ye0zslK609NN0QWQw2ZqqQIIelAAxYQ93E8sMnhvLtOhy1ZdqWwkX5iDaw5upCT8iJkl19V8
	IOjtywd542sefie3ZKy7zYqmyVq7oPL5gi+XkMlC94m18s6gtII3Q60ysB1e+vd9bof4EaixK5i
	jMFGyCJMPrQ31Vyfx9buz7R5m9PZu+4IUzgawbLdpSzu1FWM5BfH8Hb7ed0xwzVGNuFsKHx
X-Received: by 2002:a17:902:ebcd:b0:2ca:2390:ff13 with SMTP id
 d9443c01a7336-2cf3484420bmr184377425ad.5.1784638003312; Tue, 21 Jul 2026
 05:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715165824.43247-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260715165824.43247-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:46:32 -0400
X-Gm-Features: AUfX_mxdJs2a__eLzRBJdQlzqD6Sq3U4YHaWaPVb6AN1P86mmYKsm6QbFdG4wtQ
Message-ID: <CAEjxPJ7zTURaQ1eLCfd8bfGALpWgGvvuiXXuvuYg2MQKifqevA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: user_base_parse: prevent OOB read on
 truncated config
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 12:58=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> If the configuration file happens to be truncated after the role name
> on the last line with no trailing newline, semicolon, or closing
> bracket, user_base_parse() will incorrectly advance the pointer beyond
> the end of the buffer and dereference it. Only advance the pointer
> when a delimiter is actually consumed.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  libsemanage/src/users_base_file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/users_base_file.c b/libsemanage/src/users_ba=
se_file.c
> index 4aa2266b..05904b3e 100644
> --- a/libsemanage/src/users_base_file.c
> +++ b/libsemanage/src/users_base_file.c
> @@ -115,7 +115,8 @@ static int user_base_parse(semanage_handle_t *handle,=
 parse_info_t *info,
>                         info->ptr++;
>
>                 delim =3D *(info->ptr);
> -               *(info->ptr)++ =3D '\0';
> +               if (delim)
> +                       *(info->ptr)++ =3D '\0';
>
>                 if (semanage_user_base_add_role(handle, user, start) < 0)
>                         goto err;
> --
> 2.55.0
>
