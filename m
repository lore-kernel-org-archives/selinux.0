Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951DA27280A
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680694; cv=pass; b=J2CiefgfTcPYoHLH3ezmDEM+mwCRgVtd1TuMmMN5MDb5LUZOurgUFy4S4i2kXwxmfIh9Lmwr5ZOXCfux/2uftvtsdaCu5zYJ10t6Ewo6AzC06VkY/3ByJ7CkEW6oBR/8TcjDszJVo9gemRgvaLP1vx0/OpLcpq6g3RZa02Y4EEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680694; c=relaxed/simple;
	bh=m7zETAwylNvVwfTj+CbLavgdnh4LJNQC708FpDyHrAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=focn5Ye04O609vN6xqUkRH6FthqE6IemQNGFovvez2CyIKADjaiH+WZkgLi/SXnCWXp9mnrfJIuxINyewN3k9OQX4wB2dFJOwQ8iMiRTluighMLzPC8yQ2jRaU1S4rujes8SE5tt5vSxgTkjjpoCuHc/yCZeP/ym6gEyryTCr3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctLmPFzh; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctLmPFzh"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-393d07e8938so62225041fa.2
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 06:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778680691; cv=none;
        d=google.com; s=arc-20240605;
        b=jHPVY2JiubNuHxlAhoZ048kMtcHM8ebfWhhy8KL+uVjQCp/AcQsxQdyhRgC1v+dGXY
         sd180kn0S1V6SVrWd+/yBazY+ITf+wsMKiQ28HBRZ9lQIDz0hCDjN3Hlok8a9V1AUrH1
         rj9ugBfJnrQqbwc59G/oQk8bOjmk4QV3/lyCcSA6c3vhYSISHqsuCMCbN5shKH+3QnD2
         kxSl3iPixMQ3XxyG4wISPqU0MYPacEY1FHarAwu3d7XFk/FNPvP+51W6syjfEdu4oSP2
         dNyeNqY2qXrSYMxRZ8DFQ7W4SAOFQBSn8vGIjVd8/MEYfa1mmQJOPMQh57G26g9yvCb8
         e5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dk3yTfIr8vrjZ2bdTgzar0NUwIgXyFBbK1VXGEOx6yM=;
        fh=hapXqpZGe4cDnCTZrpZZF99e4yjEyXaPZz+LrgUG2+k=;
        b=CBrOwDW8RpwenTM7B25G19rIyCesESWdekYOqyDy+V6jpiLXD5rulRios8b9TBaJTE
         IkjSevn/fM6G8ExkYitQLFDlqEkZh+Qttbj5AR2ESpkxTklusmIsgI3MhxA87LE1rYui
         MZ7WwqU6/fGZ59hxR8nBLlhyowiYlEqarcqBk3oPB4aVn9EE5qbF3cinaKBi4CDX9Er4
         hl6s1xDEskvlIUz3V1ycUnJCuJA2JU5Sqeh65c6hX2832LmBHNB1bppWvG9UBhSno7Ji
         qC//hHNtY1xNB+bkW8sWoxIr/Ou9Ow01yi8myOp/bWgOeNV7tG5jgMwqurDzuWeM5mvY
         hbPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778680691; x=1779285491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dk3yTfIr8vrjZ2bdTgzar0NUwIgXyFBbK1VXGEOx6yM=;
        b=ctLmPFzhrinEqtB6gw41Vgk4Yxx0fQKaaUFdwTthkBYbRv0q8oFOppV5fL0SnrJdRu
         OARVzcXQPGRQBHG3yydfr+LK5JmZgT52cCP5tKqFUlLSKAr/v7ODi+ly+7itX1XANbLg
         9bn2BfVS2MKAUQgzH6ct9VgYUrAWbqToIRcS6jpFJlTfvnRj7oV8BckMu3f05O0Mrhxf
         GzFFDHAR+kgCHfntmjysY3s3Q+7OoHzt9JPLnuQ7Az0pAXf6MYjl2HPpnPMVoTCkLzg+
         7esNykXheLjx0jlRTfjwk9bk4nWD211f6Hx9eMYwDKtGV6+UHhcKZoaU+CWaFhgOfhPd
         igtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680691; x=1779285491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dk3yTfIr8vrjZ2bdTgzar0NUwIgXyFBbK1VXGEOx6yM=;
        b=eh72zCp71fi1fQX4juUKjSjBe6ylYyCLFogW57g2phjxsEr4x7xuqlc2/lxfgoUlJD
         Uw7GTQprgdc1zGogekbfpxsa8hqdurTEMDJRFzvw/IqoIiosPpNiUw5JHTfiXPWT3aP/
         vqAqA4oKKT89MlQIN+GObUqVYK3yMEtBmT6wv/OooM752J94VgxRm6UpPPWHtQ5RwTji
         0HUgakb/Mva+X2nadCrWYsNYM/8EYTRgL5u7wzNLyQs+JieEGY2m7TObJbdzr9L9iQ96
         fkUcOpThnIysa2SGgxeHAQiUOSMz90iS9yyP36e0zxiNt+VhrKQpuE+gB3UdDzWLDKNe
         QFbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8BSPbnf2Gi4ry8kQQQqUOXapeaNAZGZ4K3J65yX8KncfrRoYZTBLwPXaYqzmAOpOUtwbh36/xl@vger.kernel.org
X-Gm-Message-State: AOJu0YyoR6Tv+EROs1qnIkzwgGz1kymuuCsvKam81mXY9tZGRFAJ7++u
	MOBWoZYYOX+4rqnrBnjBpKpGMgtfvJhdBiuquUhfHNFGZ0GFrJI+rfGw3Xm9wctuvmgic7mnewl
	8KhfRcrAJEgY7KaxdP8TyZ9iMLaRsjqk=
X-Gm-Gg: Acq92OGu0hPUxzu+uMiiXxQKEpzaHS7U4Ll1gqtUR53Q9KWNrkc71R2GuyUHn+fKUsm
	7NlaAS0XpSWKXKQQ+Ory8nMT1PE6ml9R2k4NOjqFMM7xpf0tr7ykuzms1VY/WytIbvoZ9Yn4fwj
	1lcuy2WKsbe4CBhzjHZrCMqjJBP3ASnB7Bu8ynuBlRtwd+pTQHJURQNT4opmwP7NSAPv0dj+cCY
	2f5L55u7R7eGQ22c+B40E7H8XqYN+hk1q/ahCNbVqWwAWPH9d0ohxA/vdB5cWG9/0eLTZSmBoWd
	JlJTC3ZNXKIoRpE=
X-Received: by 2002:a05:651c:12c8:b0:38d:ed62:f1d5 with SMTP id
 38308e7fff4ca-3944ea4ea72mr9954861fa.17.1778680690441; Wed, 13 May 2026
 06:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403065234.2172150-2-nvraxn@posteo.uk> <20260403065618.2172556-2-nvraxn@posteo.uk>
 <CAP+JOzR4bmbSTwyxV6W0awuOQH+jJwCokp=T9s4UuPMuOM0tKQ@mail.gmail.com>
In-Reply-To: <CAP+JOzR4bmbSTwyxV6W0awuOQH+jJwCokp=T9s4UuPMuOM0tKQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 13 May 2026 09:57:58 -0400
X-Gm-Features: AVHnY4LSXQdzRnWYuNvWxZdmEtkKGi17zCM9yDcWeUfFDGGgQoRFaSHpqcBCm-8
Message-ID: <CAP+JOzTsazrEerpfmOYb7i_jOSh6UkRH7OG_65DOsf_9Vt+gFg@mail.gmail.com>
Subject: Re: [PATCH v3] libsepol: policydb_read(): use a static string for policydb_str
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: nvraxn@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:14=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Apr 3, 2026 at 2:56=E2=80=AFAM Rahul Sandhu <nvraxn@posteo.uk> wr=
ote:
> >
> > We know the maximum possible size of policydb_str at compile time; it's
> > POLICYDB_STRING_MAX_LENGTH + 1 (with + 1 accounting for the null term).
> > As POLICYDB_STRING_MAX_LENGTH is trivially small, make it a static str,
> > avoiding an extra allocation.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/policydb.c | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)
> >
> > v3: fix authorship mess
> >
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index 9760b164..8d290d86 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -4192,7 +4192,7 @@ int policydb_read(policydb_t * p, struct policy_f=
ile *fp, unsigned verbose)
> >         unsigned int i, j, r_policyvers;
> >         uint32_t buf[5], nprim;
> >         size_t len, nel;
> > -       char *policydb_str;
> > +       char policydb_str[POLICYDB_STRING_MAX_LENGTH + 1];
> >         const struct policydb_compat_info *info;
> >         unsigned int policy_type, bufindex;
> >         ebitmap_node_t *tnode;
> > @@ -4222,16 +4222,9 @@ int policydb_read(policydb_t * p, struct policy_=
file *fp, unsigned verbose)
> >                 return POLICYDB_ERROR;
> >         }
> >
> > -       policydb_str =3D malloc(len + 1);
> > -       if (!policydb_str) {
> > -               ERR(fp->handle, "unable to allocate memory for policydb=
 "
> > -                   "string of length %zu", len);
> > -               return POLICYDB_ERROR;
> > -       }
> >         rc =3D next_entry(policydb_str, fp, len);
> >         if (rc < 0) {
> >                 ERR(fp->handle, "truncated policydb string identifier")=
;
> > -               free(policydb_str);
> >                 return POLICYDB_ERROR;
> >         }
> >         policydb_str[len] =3D 0;
> > @@ -4248,22 +4241,16 @@ int policydb_read(policydb_t * p, struct policy=
_file *fp, unsigned verbose)
> >                 if (i =3D=3D POLICYDB_TARGET_SZ) {
> >                         ERR(fp->handle, "cannot find a valid target for=
 policy "
> >                                 "string %s", policydb_str);
> > -                       free(policydb_str);
> >                         return POLICYDB_ERROR;
> >                 }
> >         } else {
> >                 if (strcmp(policydb_str, POLICYDB_MOD_STRING)) {
> >                         ERR(fp->handle, "invalid string identifier %s",
> >                                 policydb_str);
> > -                       free(policydb_str);
> >                         return POLICYDB_ERROR;
> >                 }
> >         }
> >
> > -       /* Done with policydb_str. */
> > -       free(policydb_str);
> > -       policydb_str =3D NULL;
> > -
> >         /* Read the version, config, and table sizes (and policy type i=
f it's a module). */
> >         if (policy_type =3D=3D POLICY_KERN)
> >                 nel =3D 4;
> > --
> > 2.53.0
> >
> >
