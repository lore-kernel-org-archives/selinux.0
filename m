Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325497262E
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782186569; cv=pass; b=KCsCCLp5NRLDh3SE6MUR0+ROf9gIUUt7WMU/FX7SKt7zljVfYIlAP/bplMrh9oJDqRN/8zZ9QIxkV9AB+BHTA8or7j92V0lX1AZkP1YUYtlLSk7b8l1DAzSrcPqOqQoOxVQPGCAaSKkn5mTEm9bcg5jbR9rjyK0CRG9w1NW/cFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782186569; c=relaxed/simple;
	bh=RR1hHV2J785WpEVHL0k8zZuvODXfgsvw/MD1CpAaxyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwAbSoXelZB8JYKWpbI+fYsYNb164cktPiKpDMv+QAjNs5DH1hd7NuK0aTBNXV/c7+meRV9kW6dHLPyonomly83oPtv4C+qRUyokeScazBxd2FJT/JU42mV4ggqtH/pupD7QkfjjM6w3O7uXYCMXIC23COWh4jJGfXd5MmX5WoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2VXEIsq; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2VXEIsq"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8de412e58edso47137476d6.3
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 20:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782186566; cv=none;
        d=google.com; s=arc-20240605;
        b=hGi2/rsi0ifftVek7ZoKoFBQU183bTM8Exiv3FvH50K89uLliKt1J0+W57DX3Ddjvq
         VGhV4MtYKCHAkj7oLa15QKp5lnEWjs6umZLkjnLG+CHe3/ddTF5lSF092hmIj+UzgSCr
         NYDVUtnivEPOIvYviNEgfPolmf5yCFsOaJwQ+QGN7qNOvI0W9EjUOEjhgZCEREw6e6J0
         45H9i+kCx4m7xIHWAyUSXD5WzbDckOgk4RZlRaFurPWYigfaLgejkma6NCCYxBn+Bv13
         i1C0R3V8WQBafXR44TPqmkiaR/dxm8ekya+B7oTchacm92EhDfbO3t4tT6/IfSgd9M4E
         NpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hg2qvAeQyfTz4Manlgss62I8/Xh54jm/4GmfoVCRIRc=;
        fh=L2kZ4H7slmlW2Pmd7eIwGQHCxwx7PG7ObURCGkxbjf8=;
        b=TTuGvmYmOp2UruQhvl7iIx3MUVJY/veyJHQ0SNjwzwXAlbMSb2vIWL4ZeVBQj4kMUX
         Twev60x1yosf2cPcrvNwDgLvmWSvRHtVB//5+t2se4STbnjfeO9lCAMO7uEFtsc9ls4r
         XZFM8DvAVWSjJerlyvfSD+ScNxByoPoQdCENOgU8OoRSl8iIT01if5km6HAOTiMPVbqK
         lcUHfDnlPREMlEogL/TCTlU1hLO0A66WGFLeNyKC/SMg/sFp+2sFGP6dWiMcbQEVlGVr
         UjFjB/fW8VC9EhUMqhA7aOSQfOLMns//4yRwYdG/TYZpzCriQcbv2wdI3W/OgODt8VrU
         DVQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782186566; x=1782791366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hg2qvAeQyfTz4Manlgss62I8/Xh54jm/4GmfoVCRIRc=;
        b=f2VXEIsqUPpQtjzWk0AALYcAw5dv8DgPoC1lxGm4F7afw/MKVYqNjJNlgIpQXVMtgB
         dW5+xn/gyQj5jdqGUMXn+Jfp+EpOjWIh47APFF4MBi94JfvRNK62E0uyJceJpIZ8f19v
         NZAIB1LF6TxkN29Hp/30I1I+5xCSibfaWZpgPvb1wuPYAHHQ5QX1y5Bnz6TsJHlZbeec
         ufbpPfihOBmn6fcoPthWWE8D+UgNn1K1XFX8Jyfer0Y29qAdXkbr53xdgWpZ+JI1oEyX
         GB0KzvLZRKvJfuNkCb8lVZE0sn5SavxJfY1+yCEH7FZuZMAv9zqTicbx1jkwweQl5SyK
         1Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782186566; x=1782791366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hg2qvAeQyfTz4Manlgss62I8/Xh54jm/4GmfoVCRIRc=;
        b=bmFwr7h9fOPQlyISCajQZ3AEfNNFhipQISOxqjMgA/uNBgNA7imqoNmmPgVERMD+u3
         lOhH5NrvT4SQ6U5t8P08krnRg4D1cZOgoyTX9y696hs84fO2bmbSQJrByywStasYNZ26
         Mf9kx7CS0GoD5B/jB4v180RmcgbeoseFcWEk+X+LycsC+WEkEqL27GK4Yo/WVoK7lZGC
         ZtHtngBiR9lW40x2liwq9tbBcJXMcYvX+mYFMDzWS4NcN7LHYvLgeiIL1E1DInfyC+1t
         N/e0fVE9qnSv+RhiXpd4NgpFqUf4mncCNSzQCefWvOYCwZNC7cbJh9Fjrh18G8QGOGFg
         VKhg==
X-Forwarded-Encrypted: i=1; AHgh+RoXxDS1o/S3q52ZfLlE3phn9eATZ4R9ILaWgl+BGFdP9BqSjxDpfRBsRa7HtlVQYDfh9cuHDqUG@vger.kernel.org
X-Gm-Message-State: AOJu0YxYPV5HpA4ZnVQ1qyoZUw072fjoBDVuMXG0V5de/m1gvZNEdWDw
	jzGJpGk7+tDTBtzEajpzJdijgeNjmq0Fj/zf6/Y25wGf2dGnDEIl/y3VjGTI9kKIkCNV2wRXAK8
	YtHfptkF1CnnEV2jxWcY1AiSmJfw5GQs=
X-Gm-Gg: AfdE7cmj9RMgz6/HM7GhvzCAfLRpZiDuXkFwtsJ1JOJRur9Mws9XByhbDR6vQxkM44t
	SpxY9T6zBrdKePcKRxl3Lu5j4QZXgPJyBfCqwReaW3GiJVoyvqqjgr9GbNdUkeWWhitwz8sccwT
	IvtwG7tugQTVHJ7aKcCGP3MzL3SGA8q7fkLU71mzJTvTICvT90YIZMZD2LgtRAGy+wZZSS8mRo7
	/Gjo0RtvHt/8qf6EuOnJA+KDMc3wdBf3gT1BzktuZLivaGsRTZg+LAOH3/PTiQBpXjZxSHQXww4
	2Q4c7vA6sV4Wcwqc3I32pXwJlGM=
X-Received: by 2002:a05:6214:c4a:b0:8dd:a358:ee8c with SMTP id
 6a1803df08f44-8df91338058mr230818586d6.23.1782186566075; Mon, 22 Jun 2026
 20:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-1-dwindsor@gmail.com> <20260618203411.73917-2-dwindsor@gmail.com>
 <DJFZGYZFMN73.1799LMXW49WZO@gmail.com>
In-Reply-To: <DJFZGYZFMN73.1799LMXW49WZO@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 22 Jun 2026 23:49:14 -0400
X-Gm-Features: AVVi8CcisxKRwafLGJbgn3FDnILUrTQohjbGOcGFK09DM9CZwfDUyuni252s2_0
Message-ID: <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 7:57=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu Jun 18, 2026 at 1:34 PM PDT, David Windsor wrote:
> > +
> > +static int __bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> > +                               const char *name__str,
> > +                               const struct bpf_dynptr *value_p)
> > +{
> > +     struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)v=
alue_p;
> > +     size_t name_len;
> > +     void *xattr_value;
> > +     struct xattr *xattr;
> > +     struct xattr *xattrs;
> > +     int *xattr_count;
> > +     const void *value;
> > +     u32 value_len;
> > +
> > +     if (!xattr_ctx || !name__str)
> > +             return -EINVAL;
> > +
> > +     xattrs =3D xattr_ctx->xattrs;
> > +     xattr_count =3D xattr_ctx->xattr_count;
> > +     if (!xattrs || !xattr_count)
> > +             return -EINVAL;
> > +     if (bpf_xattrs_used(xattr_ctx) >=3D BPF_LSM_INODE_INIT_XATTRS)
> > +             return -ENOSPC;
>
> This check is good to have, but it's enough. No need to duplicate it.
> More below.
>

> > +
> >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc=
_id)
> >  {
> >       if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> > -         prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > +         prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> > +             /* bpf_init_inode_xattr only attaches to inode_init_secur=
ity. */
> > +             if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &&
> > +                 prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_secu=
rity_btf_ids[0])
> > +                     return -EACCES;
>
> This is unnecessary. Only one hook will have xattr_ctx type.
> The normal verifier type enforcement will do its work.
>

Good point, thanks.

> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 1a721fc4bef5..b41b02173e24 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_tramp=
oline *tr,
> >       }
> >       if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> >               return -E2BIG;
> > +     if (node->link->prog->aux->attach_limit &&
> > +         tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_limit)
> > +             return -E2BIG;
>
> No need. The check inside kfunc is enough.
>

Paul wanted this check because it occurs at bpf prog attach time,
whereas the one in the kfunc is at inode creation time.


> >       if (!hlist_unhashed(&node->tramp_hlist))
> >               /* prog already linked */
> >               return -EBUSY;
> > diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> > index 40efde233f3a..d7c44c5c0e30 100644
> > --- a/security/bpf/hooks.c
> > +++ b/security/bpf/hooks.c
> > @@ -30,6 +30,7 @@ static int __init bpf_lsm_init(void)
> >
> >  struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init =3D {
> >       .lbs_inode =3D sizeof(struct bpf_storage_blob),
> > +     .lbs_xattr_count =3D BPF_LSM_INODE_INIT_XATTRS,
> >  };
> >
> >  DEFINE_LSM(bpf) =3D {
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm=
/evm_main.c
> > index b59e3f121b8a..e0a05162accc 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -1062,14 +1062,16 @@ static int evm_inode_copy_up_xattr(struct dentr=
y *src, const char *name)
> >   * evm_inode_init_security - initializes security.evm HMAC value
> >   */
> >  int evm_inode_init_security(struct inode *inode, struct inode *dir,
> > -                         const struct qstr *qstr, struct xattr *xattrs=
,
> > -                         int *xattr_count)
> > +                         const struct qstr *qstr,
> > +                         struct xattr_ctx *xattr_ctx)
>
> the rest looks good.
> Pls split the patch. Introduce xattr_ctx first across the LSMs.
> Then another patch with a new kfunc.
>
> pw-bot: cr
