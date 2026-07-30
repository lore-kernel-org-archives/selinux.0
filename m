Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D835B632
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443088; cv=pass; b=RlTEGb7Gzy0G7EPfJ0Horp4JFTvtAUsBLrEV99Qgk9Gq4zTK/jauQ6hmb2fYVg5fBxB+YF6Bodky5Daoq3yMKWjgCVa4l8eKIkDCeSpgE/KbpklaMLhnodBbHp3PjgJ+K8rkLorNnP7N7hwBGngLD+E/gDIpey3Bx+nz+LP3taw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443088; c=relaxed/simple;
	bh=zjg05IjQ9d/nwUS7L+AhHLSH0onzGA8XK8yQCiNLpIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJVRdsIBkYpGLNGlbGGNhe3eie82KJV2qExyqymShzCjs8n9M1BceTtJqUapjlgxP0KnxEFlvInkWVBqcBgwfupd2tZFQkpOfUb+1EL+hiV2iuz9465dbZqYQCYQrKDCuavacxnav2DyYYECCNqVUKVVgG0r/jE1Uex9ZvntHAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CjQAf7y0; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CjQAf7y0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ceae1ed204so2752595ad.0
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 13:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785443081; cv=none;
        d=google.com; s=arc-20260327;
        b=Mf9Y7DqQgj9yHHH18g9+hRjEn5Oq4ydqP9ZfhWndVvpW8fXXvabU5OtV8IU8xEGc2y
         LNx6cktTMqJQbgpbxln2bLsFIWV8R2fktutMK0wVlAjGv21PsFlsvYKOlpS3IZv4u1Ym
         K+BcWl6JhFfKG8u16Wo8Kea0RXrsOyFAg0ac1FC+TcfOWdJr5mtA1ZSDsC0zzAFsSxuQ
         Pif1qy4WGMlxzu1YWG+98cLoWIAd1qvUg/ob9UNtpZgZt5CPwpGzEjINIaV6P96EQh8O
         90R0hD8jjZIdk8QO6X7rCCrajlC7yIokgJrkeZQv34Vii3OdnwrZwZetWfl/DaHSUPyu
         d8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U6aPBpdB3jxdcLUgu9/FJ49H0AFBhM2ebJvHl6QhDAM=;
        fh=gIapZp1KAmuSly6oKonmwSg8au0t4RyAw9vEyI5LWVU=;
        b=MU18d7mO2HiCbktYVxMuvMTtjrA/a9ihYwHOsm4P7OJJ2Ht1UkhAOA2UXVnKykmDnk
         2ITsF1/5y5zB+/UiawOowDPtB2mc/7zHFYE+Lbor9Zmy6phSkAKSCkULkKGr6/WEXGu5
         0mZ3j1bMIUMWhjznPLstz6HPaziMU0bgAW3fuCdoWil/r1Yjy2cwgF6ewh0Ooenf0oIN
         2T0Ku0jPSjyCa9WyE37SjU4IFzhHmnLXyZaoliOHDLHCo7tTARKPJsugqZDB2jbP+HZJ
         pJ3CwiviWUIjHo2H0v9Cm4E5eEERB//9gczaw7Syh5p4pQql4y+PkbZm0lOnuNb6R/SJ
         +kmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785443081; x=1786047881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U6aPBpdB3jxdcLUgu9/FJ49H0AFBhM2ebJvHl6QhDAM=;
        b=CjQAf7y0T9VuwE5qWX4nWqVN+98/JuA0s3wDNVNfHrO4BTQ263yJIA2n83RZY/+E5x
         EUnkW9kYfENFcp2Bf9YxyafhxerFlmMMv83fEwTme9ln6T7OsVVL4Q1EWK/5U3JAwz/V
         y0204iKwe0dFl72FkGQrNgN6dkIkbQmYUcUKFVuO99q4c+aViU5QZmkENY7tbsuQhJQr
         6CSNl20NCowJTNJC2rTe6HBrbo1Osp7SoJa84TLBo19yos0PvxHPMHjuWEEKJCI30wfj
         MalY8U1+wq/s+HPmoVXAnxtlo6H2T3mIdfGO67DFb+UcBlDl1F+abjnCRoLNDN/OSvGy
         Tkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785443081; x=1786047881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U6aPBpdB3jxdcLUgu9/FJ49H0AFBhM2ebJvHl6QhDAM=;
        b=SrZqEp/PUI4MJ7+nvhP6gGMa3yU9kDevyNTCRjtDiIsyv7Zgx+tjNxCOEhfn8/dmjh
         v9xYo8WbaOMp75Vy+MnPGqLtSBhYG9cAafmiyYGZ9cihPSAEKBWxdaWfhMB8dGvgorA2
         ij/BMwRTTxV9MisdGkQly9yqx7ZBfSmooxgTnV4rWBixcgYNyrsDke9eGvlYguOjSJaA
         jn4YQMZginOYSqZnR/dYyaRuhc+Kk4+OwLkO65IqSuJWtUO0EP8sBjdaXMxhC89dbEAg
         1StNfOyVZ2SCCCA6iLU5XFoiuLqFGroddOZnoSG+BOOn3e2T6lpZ67ERhQSijkSfouMA
         xl2w==
X-Forwarded-Encrypted: i=1; AHgh+RrWT9tXKr69XEInd1+P6NUkmzDCAa/6dItp6tliYbMyX6SgdqUQSDcc05Z3yuV9tMWD3Uk2Gsqy@vger.kernel.org
X-Gm-Message-State: AOJu0YxfxXgm9vcBnO5bxPkjBRFyxQpKr6PcIbUsiNMmaqYPukxzvOYd
	4C9t0Bolp79UJLlSvnx3X89lWXZB3JRUG8/t5Srlx8VZ8qa2b9J1n+yAGdl6j0U3XzwaVKZF9TI
	Le2FSRva5bvQQiUDF9VBN6EvI56df4S4dlYj0Tbmg
X-Gm-Gg: AR+sD11nnok5VsjJgzdUfQONp+5vGowAnbfL7mXlm63LZJ5wDQvAcu87p0M/xmwil8d
	QWb4+wXqR21png57ZhLYfh8SnW7+Rk3s13PSqpQC0ui6RRsz0xHz3ULD3Oz5sUW3JaZwq7pC/2R
	9W6mryPhjZmbWxTqP1CskRp1gQEa3oEOE6Zs7BiOJ/j9Gr5JjDRv5jVBUKK3Wn6RceGm+8qrkLB
	SGoXQ46w1oZYag/UncHkz3ADJVc/f8Dc6qT4OWsseMNlF5j9MtsnNjRHuUIP4qr4dudBy+EwC/S
	QQdYbEcM6VFTJf5EkaFj45/qPt2Pbp3/vSkS2ZIjNZY5
X-Received: by 2002:a17:902:ea0c:b0:2c2:cf20:213 with SMTP id
 d9443c01a7336-2d035ca49f3mr33283765ad.29.1785443080906; Thu, 30 Jul 2026
 13:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-b4-disp-eed1276a-v2-0-82d58cf5f882@proton.me>
 <20260727-b4-disp-eed1276a-v2-2-82d58cf5f882@proton.me> <CAEjxPJ4X_p6Qpebe9cV=eruOVM2HXHMDWsWJpQA3QoBc+W1kXA@mail.gmail.com>
 <20260728174158.70827-1-hexlabsecurity@proton.me>
In-Reply-To: <20260728174158.70827-1-hexlabsecurity@proton.me>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 30 Jul 2026 16:24:27 -0400
X-Gm-Features: AUfX_myUj78KlwKVSPxO4zXMnrlwPg287sCG9tloNK3eQEvTe-Du-r25hOyKwls
Message-ID: <CAHC9VhRt96xoRi9EcmU9cvBUiCJfrG=FBZPz92JyKmvQvesgvQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: reject a class permission count below its
 inherited common
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 1:42=E2=80=AFPM Bryam Vargas <hexlabsecurity@proton=
.me> wrote:
> On Tue, 28 Jul 2026 10:43:39 -0400, Stephen Smalley wrote:
> > Sashiko again made some interesting observations but not about your pat=
ch per se,
> > https://lore.kernel.org/selinux/20260728014625.C7A391F000E9@smtp.kernel=
.org/T/#u
>
> The first one reproduces. security_get_permissions() sizes the array by t=
he
> class's permissions.nprim and fills it by value, so any index no perm dat=
um
> claims stays NULL, and sel_make_perm_files() passes every entry to
> sel_attach_file() -> d_alloc_name() -> hashlen_string(). One u32 in the p=
olicy
> image is enough: on the policy I tested, class process has nel =3D=3D npr=
im =3D=3D 31
> and inherits no common, so raising its nprim to 39 leaves slots 31..38
> unwritten.
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:hashlen_string+0xa/0xc0
>   Call Trace:
>    d_alloc_name+0x61/0xa0
>    sel_make_policy_nodes+0xb35/0x1310
>    sel_write_load+0x2a5/0x490
>
> load_unaligned_zeropad() doesn't absorb it: ex_handler_zeropad() rounds t=
he
> address down and bails unless fault_addr =3D=3D addr + sizeof(long), so a=
 NULL
> base takes the ordinary fault.
>
> It doesn't stop at the loading task. sel_make_policy_nodes() runs under
> selinux_state.policy_mutex and the only unlock is the out_unlock label th=
e
> oops never reaches, so every later load blocks in D state; SIGKILL doesn'=
t
> clear it and only a reboot recovers. Under panic_on_oops it is a panic at
> step one.
>
> The second observation is real as stated: get_permissions_callback() does
> overwrite perms[value - 1], and the cleanup loop walks i < nperms freeing
> whichever pointer survived, so the first kstrdup() leaks. What makes it w=
orth
> more than its severity is that it also defeats the obvious fix for the fi=
rst
> one. Requiring the counts to add up -- nel plus the inherited nprim equal=
s
> permissions.nprim -- doesn't close the gap, because symtab_insert() hashe=
s
> and compares the name only, so two perms may carry the same value: the co=
unt
> still matches and one slot is still never written. The property that hold=
s is
> that the values present are exactly {1..nprim}, onto and injective, where=
 the
> two patches on the list establish only "into".
>
> The classes side has the same shape: get_classes_callback() also writes a=
t
> value - 1, and sel_make_classes() passes classes[i] to sel_make_dir(). By
> inspection; I have not reproduced that one.
>
> Policy crafter and the full log on request.

Thanks for looking into this, Bryam.  Are you interested in working on
a patchset to fix these issues?  We could always use the help :)

--=20
paul-moore.com
