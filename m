Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7512CDBE
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726713; cv=pass; b=IWCd6wqfk4B8qt0/N5AbnaNaOidZsekxfMlo5ZdbEXJg5wsOKHj3A2dg+z2dQdFUA7ml5/vuzQJqVXS3rsVy0ItXEaGA5NlnnnebJmjLhKHb9I5++uNH5VKt503mbSD1IF1REsnX5rHG9lCPTXK+5q39DON6u/PeshRlogf33YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726713; c=relaxed/simple;
	bh=v33OTf5bOUVtpH79Ef+vEY/5OjMIXVCvMwVUXTP1EhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuhxYwuRs8KVR281hws3bmrUN+13/kX78cg62LT0M9Jh/5B54h9jMrEC8UF2VIZIgXcJ1m8kBsEF06ZcPAAPAKAvu17fD7VE5q13/hn+KysTa/YHfaGBtlbLrbGOPcqtm6v9TrptC7rQwmUX6kFPtwnM28mL+syslOWp65uC2Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcJOgcZH; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcJOgcZH"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso65401a91.0
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 13:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781726712; cv=none;
        d=google.com; s=arc-20240605;
        b=gmoIjWAjHLWQt4b15mL5GtDuxlVz7v0FNWu1Q1v3uGKKc+Ygo/udio1EMtgvsOXVew
         BJ0oONdX2sArVgRKvxfVaDkbETpsn6mQCdy4yr27KD/HSmqE1iTNn+yWgy2ZeUCfUMBG
         5Y8TGyoX4hIZUEZWp9YUMlssKJ4O9tchHEfm74l95KnJ5hc2Y2/UrAjg5EM3LHAzF82u
         DTJoLD7jz7rRW3oCVRhzRftLWxHeN/TJKrHGnWkzVuYB+NPK04mA4VXxvQAP0zrYawLR
         k8eNXhQ7AXa0hbkaVW6V8nw9Ami/rcQZ0m7HjWmUH6Fdr6d+3D81pBp55iZeou5tTqlv
         uIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5e4h/yR5FnS/Rw+FMFQ/jnn8E0aRlkSdBC3WDKV2AcA=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=AI6iY3p8DMme/jwdxW9z5getc7Bl0WV6gdOmMqBIIyDSr84QUZLXMLRU+FibVRx/AA
         /IeXmudRKZDbzSPhSspuFbeCXUXTUXYbIb4pYMW6wIhQOwbXFjXV0j2vfO7NEPpuM2Fh
         yXHJCT8WZzSnoOgmjXoBLEolDi0Jp5im7jpPpzT3bqWOSJ2cJLMhYlaRmfQYMNtxZWzN
         tuxJLaL0g+hXLCKC+8t2YR++LnWzu6zVCOCubIoRJPd1K92Z8WwIa7/RvUdaFbg75DWE
         +pmgsKutIdHLXqqhPCJBSY2RB7z7u42C2mhmXpnOKReijDBfu52jpWpRh/QpLbkzueLZ
         WPsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781726712; x=1782331512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e4h/yR5FnS/Rw+FMFQ/jnn8E0aRlkSdBC3WDKV2AcA=;
        b=rcJOgcZHxIg+OhryTPN8iHwF9TilVDadFYpPJZgzqLuPeqBquwd6vg0IBg4Wvc7dzc
         GsubVDewW8VRQ+1CAko1wWMM3DFczQnna23W3o6+WDu54bPNdDQ7Tt1rZ4bpCKstPoU0
         /6w3DOmJMqodsdvH/DxLp1A3jwAwL4ixwZOzEkyBkaEauUnWXiklG/dnES5m09K1SWV0
         OV91+qXy6hUc1/WhXfvXFgsL5tnLgy8q3sR8lhqKIxH+wZ4nv+5xj/MNpUwoVK8L1DXI
         OpwekPv3/lZVWGXOIrDcWo67ccEdZbboqzAf13HPA8TEMWUgjKpJtePCYmA9VUK6JU7k
         I0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781726712; x=1782331512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5e4h/yR5FnS/Rw+FMFQ/jnn8E0aRlkSdBC3WDKV2AcA=;
        b=UDptkSosQPbLAYYBY24sLp0KVSnDFZyVD8kpNoi+F7PiyE7RJXqZN/SALAy+r/Qgeh
         SdGaDFFcDptz4R6YsPCEh4u2/9zjUd85nudd6sEnSKDjaYkpXvWMbOdJTBmihOzA33E5
         pQT72SeJehij4Wu/H3w6EP416unBAfsZ/Vt/xle/pQXwM7NDAZBJ74nAHWY19nMggJF/
         zOMib9NTfJmMSUYDi69Qokw9sZ7c4RqLBvVbK1iuj3xcuL0Ci1JoJo16BAUQf9l2X3Sg
         +pQOTiMwsRXHqgOAr2LbWia4k3iHbhyaOYszb4ns10JHN3S6WfG9QxalFZxCP25sdl15
         LEhg==
X-Gm-Message-State: AOJu0YzvDGm2w0vsfv4i1qUMm9GFI5I8AZWOWeNrVqk70+dIMv0PQKty
	zWw505tgtQdj/eeydpbbFQ9lwaiNDQorYJAP4fX9QNHKM3HY23eG6Sl2jjP74sx0cLaBe99iE3z
	N4KXnYJVA8i4sAM5Z5Ey+PE6l3Iv0Z0qfNw==
X-Gm-Gg: AfdE7cmi53OFEKmjzRf3JyBRZz3+45feoDtZHg4TQh0+APJArrxu+GHp32lNcb5r5r6
	UqoX+ZBWVKz10E7rxIHHbuftX5Ih5oSUKL/9PaRP8ldKqnZiNeZwVN3kyvh7mfGeTcyXcmGVyfF
	m2coQEVUktwL/y4k3gLbsmTavABWi4LHPEGZdeNd4m362fOQZ1de/1llAcsPaeCjwsBcAyBDyCp
	RljbD/+s99zTMqm2JYEZZYbnR7O702Z+/594nG7hO9KRLIGZWTzOo9ZSJAyf79e01Js9T9h2bLl
	NJFYeMk=
X-Received: by 2002:a17:90b:54cd:b0:37c:5af8:d235 with SMTP id
 98e67ed59e1d1-37c9e8b6739mr4369185a91.14.1781726711981; Wed, 17 Jun 2026
 13:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617195645.96604-1-jwcart2@gmail.com>
In-Reply-To: <20260617195645.96604-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 17 Jun 2026 16:05:00 -0400
X-Gm-Features: AVVi8CdgRprGC1T6MOP4woRsl2jRJqWH3uPrW6ZQfuvFhRVX6QaFnOXBvq9e9RI
Message-ID: <CAEjxPJ7JWXtoDkUkxt7Og58gwyR2_UyWimdZ-K3oPwSbj9R8zA@mail.gmail.com>
Subject: Re: [PATCH 1/4 v2] libselinux: Add checks when growing lists to
 prevent wrapping
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 3:57=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> A common idiom to grow a list or buffer is to use "len *=3D 2", but
> it is possible for the multiplication to wrap on overflow. This
> would result in the new len being smaller than the old len and
> could lead to problems.
>
> Add checks to prevent doing the multiplication if it would wrap.
> The multiplication can always be done if len <=3D MAX / 2 and
> should not be done if len > MAX / 2.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Could also use __builtin_mul_overflow() used elsewhere, but
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/matchpathcon.c | 4 ++++
>  libselinux/src/seusers.c      | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index 2623e5dc..dc276b7b 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -117,6 +117,10 @@ static int add_array_elt(char *con)
>         char **tmp;
>         if (con_array_size) {
>                 while (con_array_used >=3D con_array_size) {
> +                       if (con_array_size > INT_MAX / 2) {
> +                               free_array_elts();
> +                               return -1;
> +                       }
>                         con_array_size *=3D 2;
>                         tmp =3D (char **)reallocarray(con_array, con_arra=
y_size,
>                                                     sizeof(char *));
> diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
> index e4a844df..08514bd6 100644
> --- a/libselinux/src/seusers.c
> +++ b/libselinux/src/seusers.c
> @@ -114,7 +114,7 @@ static gid_t get_default_gid(const char *name)
>                         break;
>
>                 rc =3D getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent=
);
> -               if (rc =3D=3D ERANGE && rbuflen < LONG_MAX / 2) {
> +               if (rc =3D=3D ERANGE && rbuflen <=3D LONG_MAX / 2) {
>                         free(rbuf);
>                         rbuflen *=3D 2;
>                         continue;
> --
> 2.54.0
>
>
