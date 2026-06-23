Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00BB41C72
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217060; cv=pass; b=CAmMUsiGzqxaCbHRthcVcBMvhU2IXB1sIXq/LCjaie9TTroJbCcKlB/ODc3KDdtJ73orz3UAeFWU0Hxf5MPSoKhDVBsU6G2xXPQI+HJ1rRRkCkoBeTNzVdbQWsQi7E0I90wWPAE5CHgdzPMK/pOfrIycGe70g6VIkjUB+SZhYEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217060; c=relaxed/simple;
	bh=PumMU2UhtFb+7mvIK6cPFQdixXX+kGJnPEKQIFziu1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nt0T03w3OAz+eVbKHyiXBH0Mw65cvfaxUbmSo4cksYx9UMgZgxqn1FleCMpMrCMIvSqi4i2QeaWzAEk8XydQmVYhG2RsDtsnz5Ty1ZiU+2pPMi8JkOcUoF2lZVkIYCou9JMhQ3zw2Kkzw9HAT80WIOw276lAQz0lpR9D4iQRlqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IipBQDXb; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IipBQDXb"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c85d4b4245aso3901761a12.1
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 05:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782217058; cv=none;
        d=google.com; s=arc-20240605;
        b=W3jYjL244N8Xdsvp4BWfilsXMWmlM6m8uaAok2mCt98+lQOWK6vMwH1D+2zEHcfapO
         GvzoHZyirJW4Yo4d52gUeciOiXhRAfCX3MAIYa9RWmBJkDm6j3dVvNIJq5S6TUOdiHv/
         F1wEu3xrMnAY97mqLRztmvCiAAzvF5b4qX5Fldla/jVx2gmMMEzuD8biC9YPQnAN4kNp
         8mL6qxigD6PX7pyk9872NRMjmRrKFJVPkgsYvVKhCHmG6RzR8YsiSquk6de5p7/THNZ8
         v2tyNtMIGibRirp4Kf61X88F2E3AK3IOovwHVr+LJNg9FEtNO7CIF2z5Hp0OfMZMzKTu
         edUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bgQX7lMCoRnVrDIF+rmL/qD3x2korosxMf3Wy3gQ1DU=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=f960ZsAgvFHVtgJCvdWwoGNQZpPMMES326FDG0kWNesj9/KGAvRJS7b8T1ezU5qXA6
         LJZa+Xuz8GGaJfOuEXk1ttPuZ08x1FaWBUoLwuW2aj1Mk3IO9JmXh8XOL8AIleR9grML
         Tmf4WGJ6oMAdLgQRETyLRZ8zNPf228OFDD6WtWdd6VnXks+R611tUI8AIa2937lSP9r0
         rw91VXWbvoiREGKRS1A3oebXggyeHMpuRe/axwvNs1WV8GROvokAbtWkXnvConDzFpPf
         mr/6TePuosL5DN2SmvfzeStn9DuoIPV75yS8GuXQ+UZSAP+3z7yF6c/xty8Ijad4P6HD
         vojw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782217058; x=1782821858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgQX7lMCoRnVrDIF+rmL/qD3x2korosxMf3Wy3gQ1DU=;
        b=IipBQDXbtO9xqpeGVT1ZQ0mrJgywUNxtRsa4m1ze6bljB5JXlSeAwSQp42a4u3Dgjn
         H4P5+A3S146w5/wGUirosdMO++Z24ViKS/++1fIthcoxLMt6kTi+HfCh24qLObEfR3mS
         zDBdvhs82oT+2tvJAt3lVPJurxOjUkYWbOO8PiLYvZbCwXymnKv7RarbKS5DTlf4kB5Y
         aApe/QVU2VcdG8bcV6vo+IbedzTkkNUH7SRkIkBzqHHZuRf3coIex/T8YslK41yiVS57
         dMdCn6o8KAMON/vUevppdH39xHIoytqezdSji4h2VnPNOUG5aKdDaY7jMa0q9q7ji0K4
         T0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782217058; x=1782821858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bgQX7lMCoRnVrDIF+rmL/qD3x2korosxMf3Wy3gQ1DU=;
        b=ajMA5JZwa5CLuNbGqIGXp6YlC2IApfDuz2BZAJ+IdhugxbdkgpMqQLOoNL7aylQepQ
         60xosXKPT8PnE3PpiFGfaHcRzCD3OskiOsWTa/nNy9OBxrrNJlPvyw7SSGjclkw1C9Zi
         LwmfcWtKqi8Zq8YiTHoROt7klXYu241x34QbsByHzJ9rbnGJ0olWKte9OqZwaz0E8y5+
         hLBnpX1UrCOu27LztiwnKeDY9Yt6ufaH4T0WqxC25rJh1wYUbqOmE2RzzRyqFSQnK6+o
         7WSCnvpqCO/JbSrWk6DFfdIBGXt42rUxPV/NAtVIv6o+oy7Ywm9L25ry3kUBnd1MC9nb
         JtbA==
X-Gm-Message-State: AOJu0YzSWYgznYu1aHC9GGiYZZywQEoJVczObYjx824plvXCac2JseGG
	tfEPU+T9GJ1e4TWxk3bX9UDmF7SNx/EpOqP/2qJXD3yOLVLRIzwNbeod6sduE7GtNLPnSW8hRpU
	zheC+GSD1dP9FF/JAmBU47GVL+ZQh8+7+mA==
X-Gm-Gg: AfdE7ckzU/MmW7A9YlEZzyyL0l+0T7W9yKDebpyH5QEfiWBZnR9zsKNhDoYIikzXzND
	UYwW4zQX8ehw9bWg/GTUayXc3StaUNJbMZwxj6qdY0+b79IZUiiaO9rKZhqvX7tStmh0zPtDifn
	IMl4c/dp2X2gPHHROPkc4hkUR2F273jJtcWZAM9CqP6+zs35dq+0vM/sfEpCIVzGL4M4banQpPH
	Mc8yiQySj3H0YKx5iqXS8BqlKlgKt7Ikz/7Ns+x8t1wIZ1oZpJfX2Oa7a5zVZqPKnH/6saq
X-Received: by 2002:a05:6a21:b92:b0:3b4:7b3d:179b with SMTP id
 adf61e73a8af0-3bd18f99b7fmr2973556637.12.1782217057803; Tue, 23 Jun 2026
 05:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622203912.80430-1-kalevi@kolttonen.fi>
In-Reply-To: <20260622203912.80430-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 08:17:25 -0400
X-Gm-Features: AVVi8Cd8DdCkaLrn6594v8Rf1OdxOEI2QjqcwJmNwu1_vQ26TFQwOLZqPBVCHZo
Message-ID: <CAEjxPJ6xiRqp4W7rii1GYwLLpyUZbxFUze-Zu24VQGOXXbZ7uQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: drop unnecessary goto and label from avc_alloc_node()
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 4:40=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Since avc_alloc_node() doesn't need to perform any cleanup on
> its exit paths, there is no benefit to keeping the out
> label and goto statement. Drop it.
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/avc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 813e82bcfc27..a9401d6c2e5f 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -497,7 +497,7 @@ static struct avc_node *avc_alloc_node(void)
>
>         node =3D kmem_cache_zalloc(avc_node_cachep, GFP_NOWAIT);
>         if (!node)
> -               goto out;
> +               return NULL;
>
>         INIT_HLIST_NODE(&node->list);
>         avc_cache_stats_incr(allocations);
> @@ -506,7 +506,6 @@ static struct avc_node *avc_alloc_node(void)
>             selinux_avc.avc_cache_threshold)
>                 avc_reclaim_node();
>
> -out:
>         return node;
>  }
>
> --
> 2.54.0
>
>
