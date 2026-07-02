Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9B7262E
	for <selinux@vger.kernel.org>; Thu,  2 Jul 2026 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958763; cv=pass; b=KsmtMiYelBuBCSMVWNlcr3FYgOss0o0LEY9aB02cfo01AsYyMoUo6rT+q9X8fDV+EdXVG8GbeBV9rzF8u66tcJvEyx1q33A/Pj5cOM1XalWCUTL5nyFz86WL3m9DWtKieFkG81dDfLrcSFvYjLMrHXpe5ec5a4EqY8NGuzChIPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958763; c=relaxed/simple;
	bh=bVCkiYVyOx/KQJoiljgI5r7COsErSJEga/BuptH4ZHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3YDtJ+AtDSL7zhp/LpA76oJEnQrKHbaQzMAPqXeAJYI6Qe4NV47jdTJK5yWUeNCyWhD/d6iAjrSvMY7FOga42BB1yNG2IblKHrgf4sugph9lxTDL7OSOi1KWwbKhgmG/cJW22xvKQwS96TeQuHD8tg4fJc1ot7ib722wD7/4tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG1TNvlN; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG1TNvlN"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80814edb536so15468157b3.2
        for <selinux@vger.kernel.org>; Wed, 01 Jul 2026 19:19:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782958761; cv=none;
        d=google.com; s=arc-20260327;
        b=SHuO+dDaTO0bFmfNusktd0Z7EhifDW1XjGLuTtYPs4hqYrg0nsYjFfW9g+d/67A4fZ
         kKggkr6hYTkkXPnZhcBxUvduUWp6EuYQcBxVrj1Dkci0V9WMBzMMJljvVm8FLqX6ZubV
         I3fUGLXVwsUfxWK9i28+hbMf+jP1QSf4Nh308Rv3umaYZr951AP0WiBjlcgSFNPN9mMA
         OVfUGlmo1sBTcPXhD5wvy3ifXBGRwSYOCe1reQupEwnssa0iLK4jhydL7nBe05xq1qf6
         hFntPJ7qVDWzItVm9muYrtyzrWI6mjpW9WTUEIDL5IgW99aEYpFtzUx+2G7Knz3Y8OOE
         2JSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GRFsV9Bxnn2vge26L9Bw1HjGqWcaHOxma4aTsHDng2w=;
        fh=d6LE4EC+zrA5p/nM+xriGS/d7MqfHG6vlGAHL08JNSY=;
        b=ZAS2VV6H6QFyPQF3oo/Jithw3cWR7dP7luV5fVnC89t3RFrh0zF3GUxjiogzM1Stgd
         OuP6vzrL3sDoZO019c9EyfVEE/hCTIN+HRlSG5A2uYbUcGtp/7c4XPRZlk5st11LGMuC
         uf9sdfQ53buN0LVvByUlPhLm6CkHc3LZriwdEMGvtVUS/7L/qvE3IiHkE5Hq5oPvx6u+
         swOv32oPLsn57luFqA6Ij5Mg8ghEG5xv5id6/KtXWe5YMK/i2Pkl6ij/US9I5FpfsBjr
         BRGNCiBJCdyABxYSll2bOzETBZS47uWkMrBoAkWRL3DwKUqezBmwGBh3fAj8xrQcs88b
         Q4cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782958761; x=1783563561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRFsV9Bxnn2vge26L9Bw1HjGqWcaHOxma4aTsHDng2w=;
        b=EG1TNvlNW0i2xGx0fIufhFTAjEsHITIHovCFZYvMqu/JW8BVO0SVukq1IUcqZyol8O
         0trxfdUCZFTgO0lhjKxl7M3TDi5l3oGhBpUMtC1js0uuRX4QAeYHBt7AWND/WqxgYab3
         aLPO6og11Ndj1vt/AYtQrvKPx6Rj6y1ptjnzCIBduLkxRz4An/NFPwhTAR1swEh6insQ
         sh+asbGdw8Y1wsMrELBHAzRGb08m9nsDf/Pjq1G8jZ33Z3fGGIzquShq2TxX1kQLklQm
         ug/N3/q+S8AJssV70eS/OzP/NyM5VWxWCMeVRB8t5nMdol0edyqPnUZdNVteBXhGPRA9
         5fRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782958761; x=1783563561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GRFsV9Bxnn2vge26L9Bw1HjGqWcaHOxma4aTsHDng2w=;
        b=kG6k+RIHTd8gb/jU/3K33ufi5hDFjNTUecmDH6YgKewzTpOzHtmNW/zy2UJMLfGC2G
         nMomgtOEqVA8gBAGe93SVYsaz6eGIGOERyVKmHakg0sUn5bxUsBdC8Npj/g5x3OgJgVo
         I2sFRTmuVj2Yx9gutAWnIg0JsvgUx39jx4LUW60NScTYoplmqSEHVTSmlk3OIZNlZbQa
         WyybbMuib+ZlzR3EpwbAMOd9vYWGGMdgHLgVBD/9Xjsdzsfvf2aAibTzny+Ym01GxJoL
         H38AW8rJ+iJbVdgOCPAgUmT0jR6uyXcH7mWX/LIbZW422T02sBzHNMm0ofw1Hn8iN2dU
         tXyA==
X-Forwarded-Encrypted: i=1; AHgh+RrsCfIq9fGRki6Yts23x1TUk5xGGIsofH0NcJ4u8LPBGs+68awQXG3UZoyFQYmrg+rM1piuu/CD@vger.kernel.org
X-Gm-Message-State: AOJu0YzilC2M/YeDxfxRKUVOd2Ku+mKjiSk0Ex3HXtlqpVcoMMev6JR4
	xK3Uh0XkNsVnPpatiNYdp8tRFZWQHGZ2Io6zfyNKxNwcAeWfJKuvip2Rmok50LYUnKoy+xnPl5w
	Fm98YjbpbMsYngP7R2WcaCBb+2mUPwtln+IBz
X-Gm-Gg: AfdE7cmaBAP/kr/FPhjjUxHLThY53RIF5Qoe2NDgXldTDVwGjA6D4K1wsSBpJw3UYtl
	kksK0varFRoUmcJeahl5iHPuaZaFJa3kmzPutx51LJWSo8Q7F19pKCOfxX61pHodJE2jnwHBrNI
	aF4jEd24y65Tp9RmqhWZg3eB4yJl9XeHIGgirgD8ZDSRyAwUiQm/a+3mPu6oO+B7jm1g8kPDVPC
	1WwR1xrRZiaOj6vl/KgayMli4W03kmvMjfCG764l39L2se1+of9LedMQY5GWW+ynkdxZ7Q/jO08
	aiM725B8l+vd6xGzsCWrwTjRKYtjNQ==
X-Received: by 2002:a05:690c:e1cb:10b0:814:4ac5:cc51 with SMTP id
 00721157ae682-8144ac5e2bemr23247247b3.0.1782958760887; Wed, 01 Jul 2026
 19:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629063005.64700-1-laoar.shao@gmail.com> <CAAVpQUD4tpO7h92FCrp_phkjQv-QXXyrYBvhGRDDDG=doht1nQ@mail.gmail.com>
 <CALOAHbDvvk1pkZb8dqz9+FET3N813b2Hhx3M9hKF95FETuDgSQ@mail.gmail.com> <CAHC9VhRHG19f+TvDuCo5DJp=XtiOF1otDzc56khkdSWTJedrLw@mail.gmail.com>
In-Reply-To: <CAHC9VhRHG19f+TvDuCo5DJp=XtiOF1otDzc56khkdSWTJedrLw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 2 Jul 2026 10:18:43 +0800
X-Gm-Features: AVVi8CeCfAIeRP-JnrTURktEN9s6vCaMkDJL5fqpU91F1UreqKxOiKbtY2gwpVE
Message-ID: <CALOAHbCqU=caK9Aund+JOZiO3HEHd7t8xmsU27iHVWQV2Uh1YA@mail.gmail.com>
Subject: Re: [PATCH] selinux: suppress warning flood for retired DCCP netlink messages
To: Paul Moore <paul@paul-moore.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	casey@schaufler-ca.com, kuba@kernel.org, selinux@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 7:53=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Mon, Jun 29, 2026 at 10:24=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > On Tue, Jun 30, 2026 at 12:16=E2=80=AFAM Kuniyuki Iwashima <kuniyu@goog=
le.com> wrote:
> > > On Sun, Jun 28, 2026 at 11:30=E2=80=AFPM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> > > >
> > > > When deploying linux-6.18.y stable kernel to production servers, we
> > > > observed kernel dmesg being flooded with SELinux warnings when runn=
ing
> > > > `ss -l`:
> > >
> > > Please update ss instead of reviving dead code in kernel.
> >
> > I will submit a patch to update ss shortly. However, I suspect other
> > tools may also invoke this deprecated interface, which could flood the
> > kernel log. It would be preferable to suppress these warnings in the
> > kernel to maintain compatibility with existing tools.
>
> I think there is a middle ground where we still output an error
> message to the console, but we only do it once.  Yes, we are adding a
> couple lines of code to check for DCCP netlink messages and print the
> error, but I think that is preferable to log spam.
>
> Yafang Shao, could you update your patch to check for DCCPDIAG_GETSOCK
> in the -EINVAL error handling code in selinux_netlink_send() and use a
> pr_warn_once() to output an error?
>
>   pr_warn_once("SELinux: DCCP has been removed, pid=3D%d comm=3D%s\n", ..=
.);

Thanks for your suggestion.
I will update it.

--=20
Regards
Yafang
