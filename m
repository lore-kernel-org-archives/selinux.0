Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D9390609
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187155; cv=pass; b=RT5R22yl1QGvkTAKFI7Npba74asFYZbvLVSuCbipQf0x5cTSHTpJuVUI/kGMjhcfKBmy6h4J6eOqSq3l9B0EBA9A3YtithBjoB/owuaa3Y8u1lYq68a6/5bnlJpdCTQREW6mug4bHRuMJGD3eb0V+FNY5t3YdEBnS2GO+fj57x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187155; c=relaxed/simple;
	bh=gG3nM6GM0xXcee7k3sO2+otJiw1n1BGZCjCkgApMqe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bum7orSfIhB/jFBcdfvfOfdyJODB4qKtRboFklU+Rj1ZEJez6Eswz5LFuom5tFb5S2Zp68o9T1ypMiIMY2NNm+un8K+ACsx4NBPFC0ETs1kCvxEtiHQ3aa3LVuOLMZ2pgxRcgUJkASsALfDog2pkMr6xhC6B0TqNltlSXEipxAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayc6Yxc9; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayc6Yxc9"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37c867bd3e0so2549902a91.0
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 20:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782187153; cv=none;
        d=google.com; s=arc-20240605;
        b=WRfe01g+57s1FRryU+AO5fP1pa+g2xnzmhqR3Datk7fvMfIqXD9rcNeB1jYaaN2DrN
         3Kmen3q03Dv53Xe56DRZMH5jeCp2FUmIcs2oF6Zo4uqPVLjmq82Lh+iBQCqBN63SseTn
         ry+bRPQpRhIY3gnLJBWH5XsIiXWh4YtSbPJRWkiLS/gIBfLKq5lc9OP1kfCRvsJQG67F
         ebAvQLYAnVQPem0suO8DLr43GTJaVpUW9OksFxM3WCTV67+OqnGDNtPQ+zK/vxICdur5
         cL9igOT6vYPON5yz3XdO9cqz8kU8/1AeRC+XHhXFxuIDNyXqSb2S3npKY/lT37SQ+Qom
         wifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fv4+YQzwW9vJ3yUowssNEEOn5d5CfHMnYf5q6sRM4Aw=;
        fh=OLEi/w9akkmqSwnt2HZCWJvFMNwIe8Xozh+UDyHH98o=;
        b=kd0GFR4usvSlrqGDPZjnd+utPha0Nv3o2p8jtgIxeVFo5U9UaCh1C4xCDuCk/DgHGP
         /93dGlcYZYPVl5JQxp/SwnjY+dDLJr2cnU7Qu1UFUPO/0o+gEPtLKaoJ1Zh3WvoP4acL
         sA+iCYly+H/jnug8yLQRijQiRqzibr+/8Tlr9AlAsRf6ueU7GeuBLdM92F25QHxLNzaB
         /ow2MwfMPr+lyz1HI12CyyNAdvFyjXJVZRY5RiHl3TpwozYOzly7ZbRKIqe8LiTrtFrP
         aBxSMnbuYhtnBomIG7BA6ux1aKMXm/u4qeMT6GUDTkEXasAZhfLsHU8P1vrAfXI/JSar
         z5pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782187153; x=1782791953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fv4+YQzwW9vJ3yUowssNEEOn5d5CfHMnYf5q6sRM4Aw=;
        b=ayc6Yxc9BZ+MZUTfJWUjsUjR6/AmNZnL8Egi5GytMU1FqCvZDNwOE7s9xkQgfiztdR
         nn4jlG1gEP78vF/wMFDw8ZTiKMBvy6GjmBy58WtRFUjFfG2V+u5XAAY7w46Umife8eo4
         qgQIM+1syaO/b2udQFkxZ7jSfGNGACFkI2L+6E0oZqfxuHmPaMTbJHenO6rubQThlvf6
         IDKcvkU59HSHmQBC4k2UWtPEk2TmMMqqQhgwttGAdhfDFjuCbbnKbl/0gH7QzexsqcgP
         d0WhSZcBajAwY5rIT2/lcz1WT6GLNYVvfcU3GF7DH7yfScHes7q+viapvK0ytMpyzOXI
         YRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782187153; x=1782791953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fv4+YQzwW9vJ3yUowssNEEOn5d5CfHMnYf5q6sRM4Aw=;
        b=Vz3/iLEBdAzriSFm7eKWWAlEgTSFs781D4BFK/ev6/E2Q0SLQAGGsBhBhS2gOwXi9l
         BwXnNZFLA7HM96+9LHxOEsgzDL8qBeJLrhgC2mTYwZH0qtMWYF9K9K/4yEAOx03TfYDA
         3xQ/MbqY+lSSKiwa3g9Q3Vz+EzcOMalNzTBoMeEd6dd/IKlaMrK7lvFoJtbk6nYKhAlO
         BjjQl4ukyaB6WJjNhmAVDirmjiubFMTqg3aqQpiw0n60osKVKVJPQLvTnvVoZgPpwP0i
         KkL3vaZ8RhjSdCRI+Fth5lH06Rt4Bs1f73/pPn6K1PwYal9SBXtjwDU8oiusGwSFJ1Nc
         bG5g==
X-Forwarded-Encrypted: i=1; AHgh+RqVSNZBb8EZDf7qn0dxVC8iHsgslC8v0GbYKzECL4anATKAgAi5z+PkftrQ8T0Pi7Aad/LTL4vx@vger.kernel.org
X-Gm-Message-State: AOJu0YwV50zd2aWMoI6UevPM+Uk2rqHjbKI9tKwRLgSMKgnU9Gb+an7+
	MErV3Larf6sg7cUpb9syl9bVurzBOgAi9JfBm7IMx+d7+SyyVILmwLqr24dYOKCCSwhPHbs/Dri
	4a27sQIcjsYaxElLgQ1XdqpcTdV8zTrc=
X-Gm-Gg: AfdE7clsvFGPSb+SkC5g78sefleex/jR6JR11AAaBGCiFOA9AImq+1NsGHAzwFuPl40
	OsQ3vk3H5w49ShaYjwbab6KRXsnDQgH49uDDMjqLM2PCI9AS9yr1dPu9MSL060YvCRDivCRqhQK
	7kt9KgnEsqesKqQQ74+HKOSIPP17vaIN5PXZ2qlicaCtip+d8XM77pfQfa46c94Sb04VngAXID7
	5nPX0Ww17x4tPJQerEzRCbF+XmOKCzYsGWVjhETf78FTTsk450fiUxqbAamaKzzivjSpiH6mynJ
	lAno9qCvZ3VNgJ9FPA4ro3rnKpCgivJU2rMF+NQhN4MlG/HEG5CrGji7jLydH+tDfKgbCglcPGZ
	qIQt9dWESw59Wag==
X-Received: by 2002:a17:902:db04:b0:2c6:bb31:4564 with SMTP id
 d9443c01a7336-2c7c9ae9c89mr6495325ad.34.1782187153306; Mon, 22 Jun 2026
 20:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-1-dwindsor@gmail.com> <20260618203411.73917-2-dwindsor@gmail.com>
 <DJFZGYZFMN73.1799LMXW49WZO@gmail.com> <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
In-Reply-To: <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jun 2026 20:59:01 -0700
X-Gm-Features: AVVi8CcolJU9x8Dp8q7P56rN1jCQzLpqqLG-VPMeXHQRVjQ7aayUcNcv-uHuUCc
Message-ID: <CAADnVQJsdrL2RjxM4UE1WyWrT9KsprFP+=xLHRtFhUSccDqQcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	linux-integrity <linux-integrity@vger.kernel.org>, selinux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 8:49=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> On Mon, Jun 22, 2026 at 7:57=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu Jun 18, 2026 at 1:34 PM PDT, David Windsor wrote:
> > > +
> > > +static int __bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> > > +                               const char *name__str,
> > > +                               const struct bpf_dynptr *value_p)
> > > +{
> > > +     struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *=
)value_p;
> > > +     size_t name_len;
> > > +     void *xattr_value;
> > > +     struct xattr *xattr;
> > > +     struct xattr *xattrs;
> > > +     int *xattr_count;
> > > +     const void *value;
> > > +     u32 value_len;
> > > +
> > > +     if (!xattr_ctx || !name__str)
> > > +             return -EINVAL;
> > > +
> > > +     xattrs =3D xattr_ctx->xattrs;
> > > +     xattr_count =3D xattr_ctx->xattr_count;
> > > +     if (!xattrs || !xattr_count)
> > > +             return -EINVAL;
> > > +     if (bpf_xattrs_used(xattr_ctx) >=3D BPF_LSM_INODE_INIT_XATTRS)
> > > +             return -ENOSPC;
> >
> > This check is good to have, but it's enough. No need to duplicate it.
> > More below.
> >
>
> > > +
> > >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfu=
nc_id)
> > >  {
> > >       if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> > > -         prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > > +         prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> > > +             /* bpf_init_inode_xattr only attaches to inode_init_sec=
urity. */
> > > +             if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &&
> > > +                 prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_se=
curity_btf_ids[0])
> > > +                     return -EACCES;
> >
> > This is unnecessary. Only one hook will have xattr_ctx type.
> > The normal verifier type enforcement will do its work.
> >
>
> Good point, thanks.
>
> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > index 1a721fc4bef5..b41b02173e24 100644
> > > --- a/kernel/bpf/trampoline.c
> > > +++ b/kernel/bpf/trampoline.c
> > > @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_tra=
mpoline *tr,
> > >       }
> > >       if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> > >               return -E2BIG;
> > > +     if (node->link->prog->aux->attach_limit &&
> > > +         tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_limi=
t)
> > > +             return -E2BIG;
> >
> > No need. The check inside kfunc is enough.
> >
>
> Paul wanted this check because it occurs at bpf prog attach time,
> whereas the one in the kfunc is at inode creation time.

Sorry, we're not adding redundant code to the verifier.
