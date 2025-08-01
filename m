Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E71D5CE5
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754073512; cv=none; b=dKhd1p1n+JVK0zHgt7362CiGm1LeqNI3zNW95npzUG2HPqZFCTgiONMNV+4msFjRi3XlvNAMnezc0H9s/b+lhQ2bdjVbttiWt62/4l99vvoeITuVBq+Lqj9lVsrOcok1Y9A/YYHwxHuXDg8SoGVzodOoS1tulCYlNvqJOak4Nw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754073512; c=relaxed/simple;
	bh=oSSAs42lD3plOAoKgxguxym57zog1c4MEGurdFxOafA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KU61gDrH8g2JkRXBlfu4+b4r8UJu3FRLrjkqOLGgk/hiyAZ+aL4N447t7d3M13KPFSk2MhmkC/OoTdcECaxpUtRUs+UDb8w8bJEbJy13utH3mgdsHyScfRe9BPh839j0IFCdxHqpoBVIGW++4v44QeXd5pcnFTUbQXH9uaQfDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luzsVsHg; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luzsVsHg"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32117db952aso24350a91.0
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754073510; x=1754678310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkXTjMsDQQb5r7DOGMtZRWkjU1xbXpZZo0DENsu90EM=;
        b=luzsVsHgHhBO80kheEP8wfqrHkkK7dZFXYz7zc6GFeWIIEzB+zI+9p4wYeXgLrS0Jd
         reZr/GMFt13/WVXo9e4FjPrnVaTOHyXkIJ3riHxK81iIzpBwvYj8sVb/2Ak5xvKSsCaT
         TkQ6OR3Blcg0/5gbIxG+TtyyM+ImMDqT1slzbIwoeQ5GtzWbBL68vN614V3YrSRsC0BD
         8ixEIB29Cekea0rqNPlF6bjFF/GkKV7OCZ+/aMgaxskst4hNxLw2+l1w1FxnB+siCO/h
         9BTBVJKTjhCCgDDa46BaCBKefkgHgL/YdA61RLRnx//BJki8CC33NXoAoR35p5zFK0cO
         ZO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754073510; x=1754678310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkXTjMsDQQb5r7DOGMtZRWkjU1xbXpZZo0DENsu90EM=;
        b=hwH1cYNfKzrhcrMdQLmy1i9kIDVOEtG541+dHYK2Z8q5QSeVqJj+foI5gQpdVUuA7k
         pAfGAjSmYokEaVp/NLkQfITMwXBsKCIc16T193FyMlVCy9lZ7mV2aRvtnbGB9jPsdZm+
         LOeBqPK9eiuEmoX6Q5SzV3Kw/u/oO0Cy4CKbGzMuARj29fY9eyZ95DKdPIaUqfurVGwd
         k9AptU7cji0vNL6vDVYhS39Oe4pH3iaTCyizcHSZbmnd7fwXcOriSFyAbn2W/y5JfWay
         Ue+yxpQ/xfm5whBW44tlWlVswElY4LbpbO0G5kNZCZleQIjRAyG8hvS4Hh5T8p7+ccaQ
         xJMA==
X-Gm-Message-State: AOJu0YzQvCI9dBlgd4o4ALfa+EO/VediokSQw4LisAPWdtPwkwTMzs1r
	yRJKG8QK+tXcxruACFys8xfq0cDxdcO75WdHcKJbdqc3HUKnjrUgu0lXThcpgliiMbc/G7fLqEd
	Q7wHkH5bEJe5bx1J4VcWxaXa1idK+YZI=
X-Gm-Gg: ASbGncsz7v5T2dPypoRZnsfrjTPITkbkB/XjSQC2mtxfX9BDgGISQKssvD64z3wbnW5
	4ffHcwaI0dZln4RxWlGPVgFTGeT68vBlxO31dx4uhuVYYl8hMhdOtPcwGPkJ8NaKBUKaqlP0zpj
	Ooi/UHqnzsy8uA5HYbM6jQnyTFVfBB9a6Hga45FDYV1Xf4WT+08azLAdpTc4sCKj2kJRRCURwV8
	RVsNkY=
X-Google-Smtp-Source: AGHT+IFHC+VnMGO1OYs5eivpjz0U+v4Ww4S+GLxCxBwGPtWBTnrcUGUCodXFO5msk+7U5l8EPNp/rhMik9zxEenLupY=
X-Received: by 2002:a17:90b:1650:b0:31e:f193:1822 with SMTP id
 98e67ed59e1d1-321162c8f2dmr925205a91.28.1754073509990; Fri, 01 Aug 2025
 11:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801154637.143931-1-danieldurning.work@gmail.com>
In-Reply-To: <20250801154637.143931-1-danieldurning.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 1 Aug 2025 14:38:18 -0400
X-Gm-Features: Ac12FXx8S24PcDm1HFzRkx1NVjUnKYiG6E3NK3p1gKZ2poivSSgNz_sIMsqtP9Y
Message-ID: <CAEjxPJ799AYzKGMJr5vmcP+b_ikPncy-vwaKZudRMRokwyuXMQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: implement bpf_token_cmd and bpf_token_capable hooks
To: danieldurning.work@gmail.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 11:49=E2=80=AFAM <danieldurning.work@gmail.com> wrot=
e:
>
> From: Daniel Durning <danieldurning.work@gmail.com>
>
> Implement bpf_token_cmd and bpf_token_capable hooks for SELinux.
> For both hooks we check against the token SID, to support
> delegation. We could add a further check based on process SID
> when the token is first created.

I agree with the approach - it is consistent with how tokens are used.
I suppose we could perform a process-based check in
selinux_bpf_token_create() if it was generic, or add one to each of
these hooks if we want a different permission for different cmd or cap
values.

We may need to wrap these checks with a new policy capability (see
security/selinux/include/policycap.h and related code) to avoid
breaking compatibility on existing systems using BPF tokens, if any.

>
> Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/hooks.c | 48 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 335fbf76cdd2..bffddffe0b25 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7154,6 +7154,52 @@ static void selinux_bpf_token_free(struct bpf_toke=
n *token)
>         token->security =3D NULL;
>         kfree(bpfsec);
>  }
> +
> +static int selinux_bpf_token_cmd(const struct bpf_token *token, enum bpf=
_cmd cmd)
> +{
> +       struct bpf_security_struct *bpfsec =3D token->security;
> +       u32 sid =3D bpfsec->sid;
> +       int ret;
> +
> +       switch (cmd) {
> +       case BPF_MAP_CREATE:
> +               ret =3D avc_has_perm(sid, sid, SECCLASS_BPF, BPF__MAP_CRE=
ATE,
> +                                  NULL);
> +               break;
> +       case BPF_PROG_LOAD:
> +               ret =3D avc_has_perm(sid, sid, SECCLASS_BPF, BPF__PROG_LO=
AD,
> +                                  NULL);
> +               break;
> +       default:
> +               ret =3D 0;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int selinux_bpf_token_capable(const struct bpf_token *token, int =
cap)
> +{
> +       u16 sclass;
> +       struct bpf_security_struct *bpfsec =3D token->security;
> +       u32 sid =3D bpfsec->sid;
> +       u32 av =3D CAP_TO_MASK(cap);
> +
> +       switch (CAP_TO_INDEX(cap)) {
> +       case 0:
> +               sclass =3D SECCLASS_CAP_USERNS;
> +               break;
> +       case 1:
> +               sclass =3D SECCLASS_CAP2_USERNS;
> +               break;
> +       default:
> +               pr_err("SELinux:  out of range capability %d\n", cap);
> +               return -EINVAL;
> +       }
> +
> +       return avc_has_perm(sid, sid, sclass, av, NULL);
> +}
> +
>  #endif
>
>  struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
> @@ -7525,6 +7571,8 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
>         LSM_HOOK_INIT(bpf_map_free, selinux_bpf_map_free),
>         LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
>         LSM_HOOK_INIT(bpf_token_free, selinux_bpf_token_free),
> +       LSM_HOOK_INIT(bpf_token_cmd, selinux_bpf_token_cmd),
> +       LSM_HOOK_INIT(bpf_token_capable, selinux_bpf_token_capable),
>  #endif
>
>  #ifdef CONFIG_PERF_EVENTS
> --
> 2.50.1
>
