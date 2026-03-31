Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE977367F2E
	for <selinux@vger.kernel.org>; Tue, 31 Mar 2026 02:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923245; cv=pass; b=Nakzh7IgBpHdEEWrCgpk6KesS5KLwCvLj/coqSJo4GH9ev7FFCcEa5O7k6NCTiA8HgIIP+8efa6FaVF/HmyfSRg7s/T+g1zD89mNHfBYFoScekKTubrX1d+eX51pIYt8G8wbzLAvLgxJCmBP+2al73Yt4px2aUwL/0rQVPlwWfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923245; c=relaxed/simple;
	bh=kuHXhiMZpV8pzgclUVPNNZAJrO4wx07kTO5po2LMqSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zf9ZAy67Np7nEcoAi301ndpfqZ4S8BdHYQi+L9Aw5oVhqGslL0ff0yu0ViOKk72cZr7tdHJx+49re7qulFNhOlWggn6d7auX71XyqOCaWxGXue53u3qnU7CrflIOQ4bx/uBH8+QzZ7SOwD86pIk3rYOxiERGjASjtZobY9Ga+Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GYGCT/NS; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GYGCT/NS"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35c1a131946so2998551a91.0
        for <selinux@vger.kernel.org>; Mon, 30 Mar 2026 19:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774923242; cv=none;
        d=google.com; s=arc-20240605;
        b=IzPrgJDp0p/uRXo3QE/fW56bW/XGBGlnAgfAS1IT7adN1z5xS/IgBLcgQg3SJ3Qxub
         We/Ttk8FOWkOgFc4pHHDkabUglbfINPNP/A3pryk/Ps0b0q7KFJdVJU5uCI9yTzo4iQg
         5PXhWHnkg3eooQGD5hbOxx1kBu1X4G6+4f0QNzs68aKO4KzPhPgUlqEC4lkVaArsI8co
         gxc7eZkRPpPqMtT2w7MqwZH63pIfun9HsDdqOeTJyFIVOo8L0rMVxv/FtzxJhIArW1D/
         6phskJTEkhifIbEDKO6U+Zb14qdKQp/8csNiflLVeSrhQOycma1L3A2NJVwN5SJ8UDdL
         8w6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cTY73uli4S8kcgZc+rHMQS5AIJA2/isaeJaubiJWEjo=;
        fh=y9e5yiFJ9D9hTDOmweZy1hPZHC9NDAOTkHV5GK4T0pk=;
        b=FAaA2jkahk/oD3ZNF+SIYpYNtJf+wASMEp+TZrHau5px4tYQshNu9GiH2MXmBndyGk
         +Q2HBi0qIa97oIUXjetZ+kmm8M1EXS8Kfxq9/bNAesf8CukstbXJs2W9UOPImv/EGSPU
         ArOOOx94kPwHT/Vx/FitAPrFsT/Vd+fH6JYlYPYwrWKfqNGTsr2+EIvWMa2yKt+5n9Ti
         jFp8ifi0TnCANITlOwy0Jm2CR9mGohuzvZXXABS/8HW8Dorp4mAYXXgK8G2aPPTaENHR
         ff+sJu9D/BkwLMM6qn4rRhh6ioVqWsEa9nIPM338Nktmk8mV1NI1NiiXZ4q3Ia6CF5c5
         WvBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774923242; x=1775528042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTY73uli4S8kcgZc+rHMQS5AIJA2/isaeJaubiJWEjo=;
        b=GYGCT/NSXsOi8vmwL5DlhSSh4I0Ja1JeqXScEjDMtkGydO6MDYcNwbPBuyi6AL/0gk
         8aeEnV5M73vYmilF4UnDnaD9lw68AJSwi/mrbGJu6/X2S8kL1o/fjwaFi2qtnO9Gux63
         8uW0tJA2iXIWKcWULVPxGbHGThdqvHpYWA3tdHkhJpGTqTiEdrh/GtQ1SMnwEhZHmAME
         gl+JtG2JY4GkeQtUvrfJMRYk2Cuc0JLLAQi3BZePNnRz2VyhcbnlqCSjZHXvFr5hBBnK
         mvxiKzyfoK5ytQAJySI0ZXdzbc3EwvtOXSgMOqVMsyrK57e8CC2etHkVLyjCya6cr374
         AKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774923242; x=1775528042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cTY73uli4S8kcgZc+rHMQS5AIJA2/isaeJaubiJWEjo=;
        b=K4CFaSmfuLm1Qv1RFjtW58QkfAAe2JH2jJTv/N0Z0nNEyDCLuKADrHXeqPqIsqRJ6o
         bbRi5uT/oYPzSJATEcbaXXw8PtaiCigm2Ufh7qEJ+KTbmYQjEHcmImjVRYbDqnoJr4c0
         Io8qFvxAoKVKPorZh+zbmv+wXgV4HaaarDaw6wXApeTIEfsL0Mvkscq9luPh7TxaDTwp
         JkZnGh+UXo58tqGqY1DjcyxgRtnrWiyhf6kH9SNd9GvbRRkjB8A22fXagRmCqS4jyvOZ
         UAGmtcZMyzpnsYr7Fedmx20jHYoJfIWOZwcjZSE79por4iFzYq7rv5fT3x3NAwrRuvOl
         zsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEbX66NqN20VK71N8CBE3Q2lpt/Zo8FFRasI+c0WmezQlF1V1Qi0xkdxb/v1foqvDOCq/yag68@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+U1aRjE6vInmCqInsMbGv0yCE+HdUfqajVMVUIJCQ/yumkEqY
	1mD3kD/tNMliPChCB8B0+MMCZFdg6+7pW/ciLToD5uVVoypZoFgOieiJyddQzKj5w8ay3K+NXuK
	s7f7xpaf5t9XQcSBwXHWIcnLrUf/7XuFhROsPBhzqeAOKsY+IyNPowQ==
X-Gm-Gg: ATEYQzwpvisvcVu+V9DYAn63HFt5ruACFJqOFUXnTMf2UMAnWYj/7SDpX6p9cD+Hw67
	PELAcNG3AUwRP9I2NdWS6N9Z2MYk1DmffdxGEmjmzjCc/KcD8A6W3dBWowHv5iN/glvT0ArbAme
	hYWZusgeVPhPWFS/8rwXpB9d4mxEw5z2DIJ1m42PDbpbE+5f+5flGQu1hQjvqzQJ33LTps7lsDo
	SVcVL5RpF/qP0CYPq73hTlSeUJ63z9G8rBa49YboV19DHsxOeI+aGwbT8tv7kjbCMGkjHwcIVo4
	wTY9xZI=
X-Received: by 2002:a17:90b:1e4e:b0:35d:aa02:d776 with SMTP id
 98e67ed59e1d1-35db8e5d15amr1344113a91.2.1774923242128; Mon, 30 Mar 2026
 19:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327220446.353103-4-paul@paul-moore.com> <20260327220446.353103-5-paul@paul-moore.com>
 <CAOQ4uxgcOCP8cf8KvCsC=5OiuRvULKOf52mc2n9qEBAhPKoUGg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgcOCP8cf8KvCsC=5OiuRvULKOf52mc2n9qEBAhPKoUGg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 30 Mar 2026 22:13:49 -0400
X-Gm-Features: AQROBzAeO-pr44FHCmrznY1FfG77xj1P2susMVAMZI8kAhJNYbfNcCYgp9cpQWg
Message-ID: <CAHC9VhRvJwrp47-A0frOjJcTmiLr0G218idQ9obXBrNpRWuDUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: add backing_file LSM hooks
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 4:35=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> On Fri, Mar 27, 2026 at 11:05=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > Stacked filesystems such as overlayfs do not currently provide the
> > necessary mechanisms for LSMs to properly enforce access controls on th=
e
> > mmap() and mprotect() operations.  In order to resolve this gap, a LSM
> > security blob is being added to the backing_file struct and the followi=
ng
> > new LSM hooks are being created ...

...

> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index aaa5faaace1e..0bdc26cae138 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -50,6 +50,7 @@ struct backing_file {
> >                 struct path user_path;
> >                 freeptr_t bf_freeptr;
> >         };
> > +       void *security;
>
> This needs ifdef SECURITY

Yep.  That will require some other changes, but I should be able to
keep those fairly limited.

> and the name should be user_security

I'd strongly prefer to keep it as "security" both because "void
*security" is a very common pattern in the kernel when adding LSM
blobs to structs, and we don't know what each and every LSM may need
to store in the backing_file LSM blob.

> > +void *backing_file_security(const struct file *f)
> > +{
> > +       return backing_file(f)->security;
> > +}
>
> I prefer the name backing_file_user_security()
>
> Terminology here is very confusing but when saying
> "backing file" it is more natural that one is referring to the
> backing xfs file with overlayfs has opened.
>
> The "backing file" already has an LSM blob f->f_security
> which is fair the call it the "backing file's LSM blob" ...

From a LSM dev's perspective, I would call file->f_security blob a
file's LSM blob regardless of if the file is a user or backing file;
the backing_file->security blob would be a backing file LSM blob.  If
you look at what the SELinux code does, specifically in the
__file_has_perm() and __file_map_prot_check() functions (newly added
in this patchset), you'll see this supported by the code: the
file->f_security field is basically handled the same regardless of if
it is a user or backing file whereas the backing_file->security field
is handled very differently because it is a backing file.

While I think it makes sense to match the accessor function's name to
the struct field, ultimately I care more about the struct field's
name.  If you really feel strongly about changing
backing_file_security() to backing_file_user_security() I can live
with that so long as we keep backing_file->security intact.

> > @@ -73,8 +79,11 @@ static inline void file_free(struct file *f)
> >                 percpu_counter_dec(&nr_files);
> >         put_cred(f->f_cred);
> >         if (unlikely(f->f_mode & FMODE_BACKING)) {
> > -               path_put(backing_file_user_path(f));
> > -               kmem_cache_free(bfilp_cachep, backing_file(f));
> > +               struct backing_file *ff =3D backing_file(f);
> > +
> > +               security_backing_file_free(&ff->security);
> > +               path_put(&ff->user_path);
> > +               kmem_cache_free(bfilp_cachep, ff);
>
> Not directly related to your patch, but as this is growing, IMO
> this would look cleaner with backing_file_free() inline helper
> (see attached path).

Sure, I'll include your patch in the patchset.  I'll also fix the
comment style in the patch to match C style in the rest of the file
(I'll note the change in the metadata).

> >         } else {
> >                 kmem_cache_free(filp_cachep, f);
> >         }
> > @@ -290,7 +299,8 @@ struct file *alloc_empty_file_noaccount(int flags, =
const struct cred *cred)
> >   * This is only for kernel internal use, and the allocate file must no=
t be
> >   * installed into file tables or such.
> >   */
> > -struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed)
> > +struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed,
> > +                                     const struct file *user_file)
> >  {
> >         struct backing_file *ff;
> >         int error;
> > @@ -306,6 +316,11 @@ struct file *alloc_empty_backing_file(int flags, c=
onst struct cred *cred)
> >         }
> >
> >         ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> > +       error =3D security_backing_file_alloc(&ff->security, user_file)=
;
> > +       if (unlikely(error)) {
> > +               fput(&ff->file);
> > +               return ERR_PTR(error);
> > +       }
> >         return &ff->file;
> >  }
>
> There is an API issue here.
> in order to call fput() we must ensure that user_security was initialized=
 to
> NULL (or allocated).
>
> I don't think that we want security_backing_file_alloc() to provide this
> semantic and the current patch does not implement it.
>
> Furthermore, user_path is also not initialized in the error case.
>
> Attached UNTESTED fixup patch to suggest a cleanup with
> init_backing_file() helper.
>
> It also changes the variable and helper name to user_security
> and plays some trick to avoid many ifdef SECURITY.
> Feel free to take whichever bits you like with/without attribution.

I think I've got a cleaner approach than what you've proposed, let me
code it up, test it all, and I'll post a new revision of the patchset
soon.

--=20
paul-moore.com
