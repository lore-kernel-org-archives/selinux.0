Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228182EAB6F
	for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781823066; cv=pass; b=Q6UNnQu7eMFW0TpB5WykmPIBRv52Qa/+WYxl/FGdQdXcIzkXXwXersVa5RvRIZCMH+aFHvkb5MtJ8AZjosI/645kjS5t7qJXzTHFLGDMzJ+6MvocNBWEdn97cBoq2VAraKjh+TLdnsn4745yZDH7/dZzuTHMcSLn+5hNdxPWoso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781823066; c=relaxed/simple;
	bh=EMYr1F+PpGtSmTpfHsTm52f8sshX1D1zHOemelGKRHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqGgpcW1PgKOeIZyhxfyoptM6LIAKxWc3OjWg5112pw9clSU44PuhBmJNn0/pBjdXhINQDjaKb9mU/FxYfwDqR+SPUryb0PpZs3pY90uLpcW8wtac3haDTeRXvO5KM+bxPC96GII/3vdl+JgZ1kolh1OYcUbDlTuE/xJ7iydxsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ2E6C7p; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ2E6C7p"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9156b74006aso107225485a.0
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2026 15:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781823063; cv=none;
        d=google.com; s=arc-20240605;
        b=AKeU3/Bj8zzE46j54mdD7YLGDPgOzjY9QgkAtoJt/GhHE0h+N+4YDmjKEGOEox/V30
         lJkh5OX83agTKrlB+CNaFP4dNu5tF88zF+q7vZLB4y9Nm/kmGipYtZZRCuXsxk1rhJGb
         oNH7za5ib5foyI3f6snfH/WfI1mo0Nb4K0Eb8cXNUoZaZFAfU7MgggrW10WsjJG4cINH
         0MsLX/tpoS7o8Ign/UAyCvrDBEIm+RpE8aZLRWGkBkgs4Vszn8PtYjWLFlwmYiWqEGFL
         /lN3XS+1eVjpKUaOaZAW1YygK7d15FSH56zfGRHYlyL+k5FqCW0QgG8mdAAlmAarflzs
         XU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SMwuGs+SqkOWXXKsNFJ9sJZ3Linv0hyo9Jf2noGou30=;
        fh=8gM72MOuWv6D8lJ90Zb+/E/Xx2ynsNhAb0IhciLbk8w=;
        b=dh1cU1Vpp/4ZeTiijrbsWyTdu2i60TPoQcuc7P1QGMHGGyw7feyahpdGqMvSRxDiJq
         7A/9R/ufmEEsKg/6ql1XgdZPtWt+KYiT9v4gRnxdbSYfdjhIcH50hkkUkehOPDASmRr+
         sVa6pG26dMSBd+niDDu92em0lV/t+jSgLiS636nEDXGJ8opGQK8Nph3xho/BAP1oWGWC
         VsmqpqgSzuDJH93c9qqEYuQzZdu8VYfrof+Gvlsoeb9m5Ea2wenuaSoCR406FA36Eo3C
         c4jr4v3GnhKhgE2uhjdbxlrK7SZkYUf1q6AbjVnDmZV52l9OEdohbykaNkPJNegPNDOT
         EbNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781823063; x=1782427863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMwuGs+SqkOWXXKsNFJ9sJZ3Linv0hyo9Jf2noGou30=;
        b=CZ2E6C7prhTojmgoHGdNe7OileXPbl3IdhXRahO17zU0p7sydgNazhp1YHE4kV/6eg
         /iLvrxYKEmWLRXuKoolRzvba4DUUKfRHLyiBgYpuqOcdWtg82BbySEy4qLx6HhHXP7dS
         PthIZYz4hSquO4gFZ3URQSYFja1vdkH+gSP3b9b2UHQAe+pCO5lsOGswbMvzZJQaVr3J
         LMfxXi93vOcsvLFfsN8zLILywVKhEiv9aH7ub2Wr26pPk6HXp1A+vN3Q1qU+OaSnl3td
         B+79jtylayY9plF1MJRE+jSxSw56SZl4UEYadYOtdVYwiErhIjX8wLS2AjK/RQ+xbQeP
         KzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781823063; x=1782427863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SMwuGs+SqkOWXXKsNFJ9sJZ3Linv0hyo9Jf2noGou30=;
        b=afICxvUYXn0dMWexrQAGdgkr9XT4YdSAKtlC76q3yo7UwoJbX52qZB4qoHe7Lhy4yG
         O/s+wVgiu4w25ARA4vzT2RFWhHPMMAczS3oA7zKMyfye7UZmFZA29pGaxxpuWr+OVxqb
         0ShSBgG3wQeDORNl1qIzjhFQHsq1/k6SIvnjFfKZfk010Uk45FJ06m8RH96hZsbxJ1wz
         vs2XqLzmkeQu+VqmBvIolK42ahlc6WYozVGRSL5d4F1N2GPm/hhQ1zIU/NclBE3NNjl/
         oexM/5GFkVkBgwUuziZGSN+d0a2lPz6e0AqIqAq5TUHQlsX2a/u88jU5t0bVau5m/Eme
         puQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LC2OQCKjeUO1hkb38nUXA2bczxJ2eTA7UrVCjo0f2Ks+X5Bl9HxQCYMVX7sSVJHgMM+BnUC4J@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWAtV2penTdmg/QhmIcgu1JI7p8l3dpp2XBgv98E1lngzK2zQ
	sRH10nl1seRM+6elN4Gcy14NJkG70RVI51QcUcZEWwOhNwUZhn6Sf56V8VUsq2WkhNnnDcwIEK/
	O+vMX0mJHZuFdfmIgEtJbUmukPiqN9g8=
X-Gm-Gg: AfdE7cnfRX4DA37L0Tal9KVPFt/cZJysCVNT7ppzwevJdYSGqOo0oSNYGDkudRRZZAn
	mJTeUDVb6XBlmSOLfqXsx2tG/PnJBM9gKsiwu7gykFHH0/ag3rnX5jJN+aAShGkLszW/F/9jW6Z
	xqEw2GBJgPe/BcJZsuvgnv30ffKSDcu0H2/ws0eutFQtfX5P0k1Tw5NSvq1al8P3r2nq/PI6WP6
	bVdhr7Zk0kewuBmdtnJ5Zc/SuAiOU8DKJrUCqyZaxVY060+uMrrImSgxvUGHK/LvH6EAH5bOTv/
	MC5ZzliIj4lbUp161CkxeAxzhTE=
X-Received: by 2002:a05:620a:19a7:b0:915:6504:2a11 with SMTP id
 af79cd13be357-9208d2f42f5mr171322285a.44.1781823063019; Thu, 18 Jun 2026
 15:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-2-dwindsor@gmail.com> <e9ec622a8a49be299cbbfd459e2fc10693bcd65c6dbf00c9e2645281564e5579@mail.kernel.org>
In-Reply-To: <e9ec622a8a49be299cbbfd459e2fc10693bcd65c6dbf00c9e2645281564e5579@mail.kernel.org>
From: David Windsor <dwindsor@gmail.com>
Date: Thu, 18 Jun 2026 18:50:50 -0400
X-Gm-Features: AVVi8Ceqq7GMU3vGf90S537LLM-Tkad05xeAgBh-3i_pTCiFmecE5-lsBfct2HY
Message-ID: <CAEXv5_hDJyZ=nY6JaSL=17Mtw+e_m1doj=KReWSNmgo6ULFKpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: bot+bpf-ci@kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, casey@schaufler-ca.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 5:22=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> [ ... ]
> >
> > +struct xattr_ctx {
> > +     struct xattr *xattrs;
> > +     int *xattr_count;
> > +};
> > +
>
> Paul Moore suggested in v2 renaming this to 'struct lsm_xattrs' to avoid
> overloading the term 'ctx' in the LSM space. The struct was renamed from
> 'lsm_xattr_ctx' to 'xattr_ctx' in v3, but 'ctx' is still in the name. Was
> there a reason to keep 'ctx' in the name, or would renaming to 'lsm_xattr=
s'
> as Paul suggested be preferable?
>

Indeed he did; I mistakenly inverted his original request.

Will send a fix for this, as well as converting GFP_KERNEL to GFP_NOFS
in the allocation in __bpf_init_inode_xattr.


> >  /* Default (no) options for the capable function */
> >  #define CAP_OPT_NONE 0x0
> >  /* If capable should audit the security request */
>
> [ ... ]
>
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 564071a92d7d..86a8e188b900 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -113,6 +113,9 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog=
 *prog,
> >  }
> >  #endif
> >
> > +BTF_ID_LIST_SINGLE(bpf_lsm_inode_init_security_btf_ids, func,
> > +                bpf_lsm_inode_init_security)
> > +
> >  int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >                       const struct bpf_prog *prog)
> >  {
> > @@ -137,6 +140,12 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *v=
log,
> >               return -EINVAL;
> >       }
> >
> > +     /* bpf reserves a fixed number of xattr slots for itself.
> > +      * Set the attach limit so the trampoline rejects excess attaches=
.
> > +      */
>
> This isn't a bug, but a subsystem pattern flags this as potentially
> concerning: the BPF subsystem comment-style rule for files under kernel/b=
pf/
> requires multi-line comments to have the opening /* on its own line, with
> comment text starting on the next line. The preferred form would be:
>
>         /*
>          * bpf reserves a fixed number of xattr slots for itself.
>          * Set the attach limit so the trampoline rejects excess attaches=
.
>          */
>
> > +     if (btf_id =3D=3D bpf_lsm_inode_init_security_btf_ids[0])
> > +             prog->aux->attach_limit =3D BPF_LSM_INODE_INIT_XATTRS;
> > +
> >       return 0;
> >  }
> >
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/277886=
16397
