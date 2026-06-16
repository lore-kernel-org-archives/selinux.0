Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F4A43DA3C
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623089; cv=pass; b=NCCPYtnIlWkHU+3ClQWG0h7Q7BhnhcV8rd8Q3EaVz9625PwLt6/IcAv0x0OfgnZodxChuTPiUHvZeHD0+t5vrwLU7LOhPS2/XUX1UTRU6BAHWGkbYFJKt6VXxnRBzU+lcDBeCTdjb59L63JwA7KpWD4rhPhUTeZC87a80lGG6OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623089; c=relaxed/simple;
	bh=FnWWH7CHRewtEhsApSm1WYsgvsXj2TnS25LTNUwgJPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2CMhhEyN2zCl1yBuA29WXdjyZlMlyeS5Y9RRuQNOa0jm9dlNtUBX80EvnJPHjjwbCaBZ2Kx1Qje6yHIYk2TuNKoG4QKQYaBXUcs9j9niDAVwNcLiTcjlfnQs6LiOqt7SReIWxWlJ7+hhg7XtlLPzJ0wJFx/xHKhp6RVzm8HY4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDvMOceg; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDvMOceg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf20f6be6bso34802425ad.3
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 08:18:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781623087; cv=none;
        d=google.com; s=arc-20240605;
        b=k/gfMA4/NO8qrrpkdjYXeZd3tUhtAVlDB3us1d+rZTicyiapuZGY/hF79ws33d3nJZ
         d1YftcWFKan3nTl3pA3Svxyd5pk76cRszwpfyDu4Pb5lI3Ioxa3tXLSL9EwDSlLW2pkp
         mQ1Q1HSYS2agDthcyymVk8JskNYjKCGQjkXFzVmDfvYMVzj2ks19Amx+JLAJw6tTGgy5
         5IOAMDD0JfNR47vJabfIaUnz8U7yNCI0STfe1hbSzZ+ZzIo0OfDDTiQ0O4KGp/ay7uQI
         B/BL7m8K/1ETcERZ60Rp4DS+7KIfVk8239OwJr3xHijzKpfQNcj7NWrjnERFOeZyK8y+
         aJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lotmf9ZAUn4SOlHpVP5+OZFQAr9yPRXcSb+Pw8+8m5U=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=cRvYlrdffhzomf6dXDZPcIeHoNAk5YBHiglJCZy1iEK9RhgOfdDJN1jqQ06qx1+sju
         LP6QiJ3+7VIpPwl2FrbVmCfoGpcvt6JMHdXA7QSB9z/3NIk+nRCDbzhUOmjwE6y1TSQt
         fpqsCEVaD6hSHlLZKJGFjOrSWy5OH/kWvtdJYUO7b8/eNhXO1OzaiOIaNfr+nRMi4fAS
         pX4DTrnD813LuiLShDo+/NF2NbQDCWRdzwkN+sDX9l+pVvgpNke1Y2x5eIK7p9JbPT4E
         fGZnWiQOr8od/PDHYcPFfHQakkS4pHX79O/jo0f906RRVf8BlaZzuXMdvMyfF2lfeRsX
         HN1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781623087; x=1782227887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lotmf9ZAUn4SOlHpVP5+OZFQAr9yPRXcSb+Pw8+8m5U=;
        b=HDvMOcegW5ABw9B/YmvWIcqfE2pK9NcWstIHJDwIXp6WFVff4AQseAzbFXNXDeTRqn
         U8HEPIvIxFYj67sTH6GcfQiMkIYIKF62RJAndChRJhy5DknaNaXicagS0kT5ZVoSmAH8
         4hrxwIBUvwlyIRV3HmG48ENlN8VKOe/6ZnO9bdmOgDu5EE3kJRvo4zOrMytuWaPd0tTr
         QTYOrueCP/eVMqYEHVx2W4Y3cJKRJSn+TnLoHhybdg0YrdGQZvWSSnTJOcvxJmN6aIfC
         utQEVO3VQe/5scX+0RLgDPIWo2l/ascDmCpIhtMPdLKeEomx1hhy2uYz95m1SuX7WTtC
         MSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781623087; x=1782227887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lotmf9ZAUn4SOlHpVP5+OZFQAr9yPRXcSb+Pw8+8m5U=;
        b=pH4vwEHP911eAm5KYFnwvXLvoQY9BMF8NE1m3hAjcb93jJviztiHyj0a3fzin4Ka3a
         OMFmnu9Rzx+srhLcLpqtyUeBKmCd8rUgR2xy+Fd+Lk4pLDNkgtG3jfleQ2LRm+7V6GVm
         WPz0Jfh9SGl+vCelu0WTbyaqEHHJ3dFXqp7ou22RhlADs/EbrKbbrZIWwH0hlKlH3GZx
         LpNsQwYFahYx2XSFHoN7vIUKzNNZbNsSI/vpTNXSARNewDMy4GvLNp2rSWixrIMQuQ2J
         WptKeUDPSWwFt84HagNRm01b1x5AAr7qjVtI+ivG3GMGrQDwX+KoFEh3TbrFNw39OQu8
         3pag==
X-Gm-Message-State: AOJu0YxUXVznauIRXR1m44isB0zR2haukpFY1cyWzoOw/x+0eol2zUuK
	cPEfWFVNHsmiNacYNLE43nepdIyFxu22x0ZN8ztsb4MJlQ1/vOB5urApYUkzQ6sacLN9Q9+Hz2Z
	zpzn5aTlRGg+qDO8ncRDgrQdGKhQMyebWTw==
X-Gm-Gg: Acq92OGKFdklujdL4Pin3IiaxfKTGjn8tiVbCnsQ44njFwjJ9HXbK9X9Kco1vWjQya0
	WgRICekEL584IcWSOpG+59SjTBX0VknpEj/YKRGPowy+bljMRtfUPJTl3v4XpF7Ghc8CKIAdyLg
	Y2Q87oTs9S8IUdGftJ4lbpPZa74UAHMrHqxX6DX07Opet9wQ6P0y0bEOLeEk36q0IAliSbu/HZV
	K45cNxHy1Nv1EgbMHTgVDNPSA0STfBSzMEv4mg7gxVX7hhLpSyCK7glXdC0FMpMB+3d3m2AaH/k
	x4aDxN4=
X-Received: by 2002:a17:902:ced0:b0:2c6:6424:c79f with SMTP id
 d9443c01a7336-2c69a0dc52amr43347025ad.8.1781623087163; Tue, 16 Jun 2026
 08:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616150716.42470-1-jwcart2@gmail.com>
In-Reply-To: <20260616150716.42470-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 16 Jun 2026 11:17:55 -0400
X-Gm-Features: AVVi8CfxnDYMkN7JcPNttT2Xd8D4KXysMV_MM2g9bj6E5flHzkza-okCHV260pk
Message-ID: <CAEjxPJ7VoDULuU=su_Hz_MDBa+Rgi1_RxgeSCo8Z9qJKeKGd1Q@mail.gmail.com>
Subject: Re: [PATCH v3] libsepol: Check for proper length of addr and mask buffers
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 11:07=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> When creating an ocontext node the addr and mask buffers lengths
> are not being checked that they are the correct value for the
> protocol.
>
> Verify that the addr and mask buffer lengths are the correct vaalue
> for the protocol and output an error if they are not.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v3: Use sizeof(tmp_node->u.node.mask) and sizeof(tmp_node->u.node6.mask)
> v2: Use sizeof instead of 4 or 16
>
>  libsepol/src/nodes.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/libsepol/src/nodes.c b/libsepol/src/nodes.c
> index e3ad36a8..5471d701 100644
> --- a/libsepol/src/nodes.c
> +++ b/libsepol/src/nodes.c
> @@ -34,10 +34,26 @@ static int node_from_record(sepol_handle_t *handle, c=
onst policydb_t *policydb,
>
>         switch (proto) {
>         case SEPOL_PROTO_IP4:
> +               if (addr_bsize !=3D sizeof(tmp_node->u.node.addr)) {
> +                       ERR(handle, "Wrong address size for IPv4 address"=
);
> +                       goto err;
> +               }
> +               if (mask_bsize !=3D sizeof(tmp_node->u.node.mask)) {
> +                       ERR(handle, "Wrong address size for IPv4 mask");
> +                       goto err;
> +               }
>                 memcpy(&tmp_node->u.node.addr, addr_buf, addr_bsize);
>                 memcpy(&tmp_node->u.node.mask, mask_buf, mask_bsize);
>                 break;
>         case SEPOL_PROTO_IP6:
> +               if (addr_bsize !=3D sizeof(tmp_node->u.node6.addr)) {
> +                       ERR(handle, "Wrong address size for IPv6 address"=
);
> +                       goto err;
> +               }
> +               if (mask_bsize !=3D sizeof(tmp_node->u.node6.mask)) {
> +                       ERR(handle, "Wrong address size for IPv6 mask");
> +                       goto err;
> +               }
>                 memcpy(tmp_node->u.node6.addr, addr_buf, addr_bsize);
>                 memcpy(tmp_node->u.node6.mask, mask_buf, mask_bsize);
>                 break;
> --
> 2.54.0
>
