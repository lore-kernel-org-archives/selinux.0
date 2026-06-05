Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B01D28541A
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676573; cv=pass; b=B0fd1w27mxpYoCFCpOKNma5elFClyS+IAUgC70EdmAmif4ZLs3/QGh2Nn8V1+wthvb2U9r5HPKQE5uVwgr/XaHKT3rks/v5YmOX921Iz7GnIEZJShoo80EFEK1YlEfkf9w2himtJI/3DYZvE9Q7KkWf5c1puv5LYn26/f9fsdHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676573; c=relaxed/simple;
	bh=ADIe9e2qAiR5CXhqduaKKMjZgSAxV26MdiWVaR4z6SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eo8jElX7vA2IP5EB2+TltewkL/k15F7TS1lqbGRRYz1GrQFpw6r/6W0ESp7Rem/1VXuQ8vlUiI4eVD5ipIe2/sDoHOxZbSJGz0p58/YMOX4autwIG9xgkhT31YjUZq0ga6bdYgjIBYrL+GYaosqYhVGwWXLBIcb6oMzoiTNhzlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7LbzgRy; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7LbzgRy"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c858d69bde9so1014863a12.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676572; cv=none;
        d=google.com; s=arc-20240605;
        b=ThR6MWOmS0FBf7zpWYB0qm+RQwXkQ7j7ov6L59/cgWx+WBPUNILErVncDlIZ2sogMG
         cm2jfnxfotMD7FjBwH8J7Igeh9qNgIaGxXezmXkCt+HpxF9oHQqVUdkq9xdwQ5xXYJmA
         gqSuBgNhmXZniIl6370kPv6ulGTLDGUc2QPaMqhCMv5SryUaqp/gNZRmXNcYaHBrbLb+
         PzjzA2VBRiE7vQ0X0th6KH4vnU2tKsJYb+WwDGoAshmVtCfbL0Pd6u1Mqg8pL3nJyvju
         N9Mv4yOJT9MmGarW/5Iuauu8qTE6BxQPUf0JhTiNxCmtpq8zYTH+EVJDXgXEjAbbVDrO
         Ii8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7LmaHHhTuj5XfbH9Y0ARTx2loNdr9jxlviZzkg7fBss=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=Gm//0qAE3bSzNJByUC3mZ2Tysfl1Vn9ZoAf+5PbVmSaZ+W4MGVYG16AuR/iNamLOzP
         MLihXyH0NiVprQBhyP4EmNh21KUJKfbiTtimzCbx354IlD5IfGC9R5+wSpqio+vfuoTV
         XkkwL1KW4pjsQK5ox5G4RgTLheEMYwXm4XaPl49OT1hCfnL+YdpWI+/7kUqoGHyEYhup
         NSotrRM5CS9ObBpfcsjjdkez2OKdIislWIWkIEfv6S41pUPFklig5zat7ECdtjB3Ym0V
         ICEp+VxtFi6PB+XfwJgYvJaGZY8HfbUyIRlx3II8siW5jYI29ww4XvknkNFKn7ayWiGo
         I6tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676572; x=1781281372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LmaHHhTuj5XfbH9Y0ARTx2loNdr9jxlviZzkg7fBss=;
        b=M7LbzgRyfImVL0Y04mNnmbAXMGAhjSubaLkcVWal30Xg12PXngMHbtbEnz1YnYypnR
         1mRDph2yYSs6bb0p5w9NpKzODMAX0mbvOqriT/pwJyhQ7MXHOaLJjkYPlzL6aTcezUsd
         i2FMZxyd2jgpnVvn48qfhWCQ4Tfnsms3R3tDEIWA20yU1mW9E2cMe6XKHct7/k5jDv0T
         C2iWO7IuNlTKh3Sx/CVslhucJ9kYlylXqKgnLfRiKdDv+DVT/5rELs/mH36mzcPNTD/l
         wDOC5+ECbs3tr+CYWK9ck9ceI13LFecqR/XGQV+BcAfO5iVpmX20vX0R1Rd5slCr9lid
         C2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676572; x=1781281372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7LmaHHhTuj5XfbH9Y0ARTx2loNdr9jxlviZzkg7fBss=;
        b=fSgF5Yd4/rfNKiUwPSMFy8ijzurE13faJRInvCFliLy4f1ZhbIR6WNUv3lEZrzmprI
         /C/kDm4W++Kof2j7qfsgxtXqFeqX0aFSlK9Ud7Ro5QKfrMcAGK6WeEP1An4HrARf+XlE
         HQCEgTM+RHqwSmhc0akYwIh9NnlbhIBoVx3jJ7go+96QmrJ8rt2cbSqwAHFJc38KR3kv
         2upupDo55/waOBPORKguT1/CidCgiNZGF/8m4/HBgpM/5OkOGSiOOa2xvliZ5kxAOVig
         rQNJt7lv8SYTgqAABdX5ecRBji947MvKk1jW7hVckzrV5cP4ds8jj+LmB+8oo92e55fK
         6Oww==
X-Gm-Message-State: AOJu0YzCpFI4k398haZkCOOQYmtUTDDachcXuXHk9i0nJQa8pDLBfQQb
	v1gziKDSc4Sy/YrPNkY+Glvog5Xi0CtXQITgiwDdlb+7fR9KukA8oXGNbYafuF6iY/WrGnkeNpw
	Yndidl/sAgol9fSjuKQ1Ow2kRwYOtNl4=
X-Gm-Gg: Acq92OG2nhorqzuYvA7dEKEkFT0tORfy08P176TE61ZsEBcpJiAaprJt5jlmVb9uY5d
	ztXDtyFWnJuC+riIB8z+/PY4BiXcclVYC2A9++dErjeKElkWE8tkIetkRTHc43uobFaWwXA6JZV
	NYQYhX6Yf6drEU56/H3zS4bInbUqSBVQCyLI4IEDumlOLN9XVExaTNQnkpYkMunGozeZgL8wVG0
	qfXY/NDs6ILXwQcFRhNFfSfKIGImNWcXEbQ28ZXSjf4ws1td5WceNdabSfskWtCM3/QwoG2+Le7
	uZH5j6JREGNR+hX5Rw==
X-Received: by 2002:a05:6a21:6f10:b0:3a0:b65a:5def with SMTP id
 adf61e73a8af0-3b4ccfd5b8amr6193991637.33.1780676571869; Fri, 05 Jun 2026
 09:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604125854.255679-1-stephen.smalley.work@gmail.com> <CAP+JOzR8k=u4mcsUudgJEp3=AT3urYuFT3boyEPNO2fWt2psZg@mail.gmail.com>
In-Reply-To: <CAP+JOzR8k=u4mcsUudgJEp3=AT3urYuFT3boyEPNO2fWt2psZg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:22:40 -0400
X-Gm-Features: AVHnY4Ly_K-Gs2kKcA8SkH8xETSyzrZfs1b1mp-5zXTszgWpS_w2emMsKGWnznE
Message-ID: <CAEjxPJ6WGuyysyD7NQv5FGZNokXq-m1GjFVL0X3pTYxaWfioDA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: fix OOB cleanup in semanage_direct_list()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:07=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jun 4, 2026 at 8:59=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On the error path semanage_direct_list() indexes modinfo rather than
> > (*modinfo), thereby reading and writing the wrong pointers.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>
> > ---
> >  libsemanage/src/direct_api.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.=
c
> > index 6426ab14..9572dbf0 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -2006,12 +2006,11 @@ static int semanage_direct_list(semanage_handle=
_t *sh,
> >
> >  cleanup:
> >         if (retval < 0) {
> > -               for (i =3D 0; i < *num_modules; i++) {
> > -                       semanage_module_info_destroy(sh, &(*modinfo[i])=
);
> > -                       modinfo[i] =3D NULL;
> > -               }
> > +               for (i =3D 0; i < *num_modules; i++)
> > +                       semanage_module_info_destroy(sh, &(*modinfo)[i]=
);
> >                 free(*modinfo);
> >                 *modinfo =3D NULL;
> > +               *num_modules =3D 0;
> >         }
> >
> >         if (!sh->is_in_transaction) {
> > --
> > 2.54.0
> >
