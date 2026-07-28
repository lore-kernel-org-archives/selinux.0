Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B442BC3D
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250128; cv=pass; b=ZZbzPJHQNpfNzubmITkFDU3krA48krZPjMrsuo3WqnK7N0PDfZZ2Ac3uK5BqSz+Nyq8gXeKW6YBSOMvk6i6ZK5kGxReF704EhbLG/HNHzYDGISkJ8PQkTvecabIRJoVzaOxO5RvlHirc8Ps+0oa/eUfPPrh0B+eQpwJzbQE85VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250128; c=relaxed/simple;
	bh=KSyI7RwyXM5yIIxzQcpO2iJ6gN3jI0RPSQ6K1i9va08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJGlmLGkDz60CoXNxqFj7odqqMSNBHZpmqVNo2/57gD8VTacrT9+pzFnTBjwH4/h6JQxGZ1iQR1wSADnWEuVn8z5/CwjBzQgyzPny2osVEmkmjraXSMukkLQ0KhPV+Xvif+pn3BXUxQT4YP4vnO4zUEHG0r3qmQHvzJcrG+API8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqpFMeHj; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqpFMeHj"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6ab015de764so1244121eaf.3
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 07:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785250126; cv=none;
        d=google.com; s=arc-20260327;
        b=AzwDFF7dWafHv46E9Qpap5hnUUUrhzD08j4bPPk4rjpvYkwfOLQKH6K089AiKWczRI
         S6dbtAsMCIEL/IxyEg6GBERhUpts4J34XDwA0QlH+3KLpgrO7pJ3UQ3bATl+dI1vVsFf
         517ZR7+TnnlXH78D2j206TXMQgY9X+wtbr3xkclFcedl0hhpT/EcYTSnC/f8tw1n1vnv
         nkBfsVh3Vk/MSyMa/0trl0qJp7i98pe1JlOf97Bw3Y65M1qbKcUGPk7hVnRjQVkYBi2z
         8wzhNaNSzqUMVosLULWvg3Cq+olru19tcW0kUBN5g6TPFAr8WGiElJpWP6pIdWljH9r/
         qa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rRYxR7Dlt9zXmRSrN6wuJUBS+iPNMth0/lRtQzk4sy0=;
        fh=E51Jjr8Bz9WzQ+Ik80n9UcoRPIh3NakEhV8l9xr/qbM=;
        b=N2121RjD/hZXXsrmWM56VkAZT/V1bchqy1sy9hqQql3iJ8OXG5uOWClYXb56iwNSbc
         /YJsTw9VfBeBCDBXQR6WWnNF53pNtURxZxwPeV3V+wnc2WiFtIgJWWuKM55kTQqwVS9B
         btU07kvuao0zFbxFpBDZw0b/z6A+LJprCBQDZNfFvIcuEB792CykRMgDNBAtXmdLk/Cf
         ba0ATSYi1biYWwHu9UghwY8mn5/cps04SUINHrGZt+SjQO6q/K9QbBl4CfSe1VaRANKW
         Pav5cctRl6pPlRf8dgKa1p6m5CIDEPdRk2S/pasIrivJpXYmOk3N6lcY+2BuhiwpFy0Z
         LNxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785250126; x=1785854926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rRYxR7Dlt9zXmRSrN6wuJUBS+iPNMth0/lRtQzk4sy0=;
        b=UqpFMeHjvcdKLQwFqeY0AOzXd9IOyIVCmJYPN7EOQa0CP2xbCH+KbfmRvLqmfnJShm
         7wiQy7ap08/1k9bbhWV21pKUD7QEIwK75zH5zu1PtvxZ7LFO4/UGfPA3E2e0uaSFJ0Sf
         BIOb7HgJ1oW9wbdGYWQOtGNNHz9I6RFVgwLqIvuh6NHStmRI479+PAu2mrVUexOK0tTP
         0Jp8WCdwmqUwg47NpKXS+P9fBrbiomb80ZpVULwl0cNO2MdO537WVzZiyrMYCq5XVluX
         AtO9KPLHJu95IC24AtvlWknVhbJ7TUP3/wCboRoeBvNqJiBnJ03Y1ByZT58ldp8pgVct
         zAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785250126; x=1785854926;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rRYxR7Dlt9zXmRSrN6wuJUBS+iPNMth0/lRtQzk4sy0=;
        b=DODW258zGv8LLtmPBmmR8WX/goU2nAKNVoADa8c64K+4jY92p2H4JghAPYi/HS8Ql8
         v5oG9+xCIw+ttMZ7O0O+cgbdQ9603M1HnbL9fcVZ2Un1gmm6VZ7TMaOYxXcJM263YzvF
         1qIhu+hfucud+V8JPbGE3+9L2VzEMgtZIs4/4Ol4aM4HuHsm6fHZUDd3z4ZStNrRYgnC
         69kK02O4GOcowXeSyek9BbOaVR19i7fS1BG0dDVadHX4SA3qFSLeNob5+DhCF3QikpT+
         qXSb0Ra+sD4GI8Egy77VqSLPuvZ7Tq6pEqjVWHP+N1c8IRdgCaf2bjOc8/tT4FommODw
         hd2Q==
X-Gm-Message-State: AOJu0YwSqmFZodyVE9Puy7oKtquQG6oEZEF93YJmNk/agbebEZmG+OGu
	GwVSi7XovhbdCLomFD8HoJMKFwXYvjfvUs9IJZe6t0j2eZsLz+aGMSsc/bqU2tZdlcqJPM4Dmvf
	NrQMe6WUbvfIMt7uenIvfkPeea2sx5nE=
X-Gm-Gg: AR+sD10yKY86BE6T5SZJrh7Wm/9PSdQn+O5C0d8eQfqGooNCJq7MDqnzdCm/YBk4xw+
	Kg6CkvUICIVaeBKqyZ973QOf4CShxGkbM10VX9esEg+R9aSKWfa/VKeqNUbccC3v99uLjnSssIg
	WtFB9wkJEdGT2SBEypUeIsH4HNBQJbFqfy08NxiCQU4f6SeWwXftuyqksiK0FuV7CkmYt/nanJl
	dzg1gVezRmwEZGSjx3wj1G5OVWMlrs8Qte4RF51ltQw9poI04DiTVz/VZsE6yCcmzsM8dBt
X-Received: by 2002:a05:6820:184c:b0:6aa:f295:1d63 with SMTP id
 006d021491bc7-6ac96c97bc6mr1081677eaf.42.1785250126239; Tue, 28 Jul 2026
 07:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728065917.1343947-1-jsegitz@suse.de>
In-Reply-To: <20260728065917.1343947-1-jsegitz@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Jul 2026 10:48:34 -0400
X-Gm-Features: AUfX_mwA_Xz2nvU9WUuhsF0FiC2P_S9CfV81houN1mr9qrBhi-oIX-KxLPyk8JU
Message-ID: <CAEjxPJ4Q0Ki0sFWZKx78eSsjdOmTsECeFYNd4x++PLhL0473Sw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] selinux_restorecon: Do not exit on directory cycles
To: Johannes Segitz <jsegitz@suse.de>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 3:06=E2=80=AFAM Johannes Segitz <jsegitz@suse.de> w=
rote:
>
> All other failures are handled gracefully. Directory cycles can e.g.
> happen on BTRFS filesystems with subvolumes. Skip them and continue
> instead of exiting
>
> Signed-off-by: Johannes Segitz <jsegitz@suse.de>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 30f1b836..4233ba65 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -1393,15 +1393,13 @@ static void *selinux_restorecon_thread(void *arg)
>                 if (is_dir) {
>                         if (descend && walk_is_cycle(state, ent_sb.st_dev=
,
>                                                      ent_sb.st_ino)) {
> -                               selinux_log(SELINUX_ERROR,
> +                               selinux_log(SELINUX_WARNING,
>                                             "Directory cycle on %s.\n",
>                                             ent_path);
>                                 close(ent_fd);
>                                 close(rd_fd);
> -                               errno =3D ELOOP;
> -                               state->error =3D -1;
> -                               state->abort =3D true;
> -                               goto finish;
> +                               prune_pathbuf(state);
> +                               continue;
>                         }
>
>                         if (state->sfsb.f_type =3D=3D SYSFS_MAGIC &&
> --
> 2.55.0
>
>
