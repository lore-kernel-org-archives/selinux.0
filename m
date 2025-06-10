Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F1515C0
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749578970; cv=none; b=umVwJmfIkhk8tX4wgYfciKCx4/s+mxzyjD5cDqqZwH/aN68rTYQosiDXEJsBUz8wsoTI0q0gUiWg5UFoLnNwuHwHufawpj3Z+JXGB7G9sAFHdIPReDm8JOrNa9YrMTPe06jKRXM+q5KIvhT6DvQCIOlntBJwT0/iWjlhqY20NfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749578970; c=relaxed/simple;
	bh=6btZeTBFsJsylENk35Vf/oXkmFosi2sRnMpXLw1PoJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrIY6Ly/LFiSa4Nn1FOBHP642wHyYpCxN4FDSi8S89Z8WmxQlxHqIKlvME1auMVISBBnaKR2MS8kOT6bGVts6aMnUsLRE11NY6zb0YJESx7PR6LYK0I8rCJok/o83oc7HODqtIYLoT9ayYVSaPON8X13WYF+lC028LHTr6S40Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWFO+QM7; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWFO+QM7"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d0a0bcd3f3so13074985a.1
        for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749578968; x=1750183768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7ON4ACspMh3kTYlX3qUDvOqdnrVvgEI+gPgcTT7CR4=;
        b=ZWFO+QM77+6WBjyOVsXcahfQz7lK3mzTeOPuDWiJJ8gQ3uFnVRZlIRBOsx46snB3Zj
         T1gaJnwuJR8P1hf8h5HxbjSkZy4HjRqCsfEFt//qC1/iPCu5Gj5gDMLHNkyhLPMlI3VS
         wcB+VLQBxWozUyEd+hTKwJoQB1PRERNk3SKHd3khqWy6NokIgNZzhuD1PzBpYc7L417P
         s8SnJ0xApppyfnz2gjy3VrkM4rSIUHVVb96RmxkkEOOpdy5s0B7Wg2Eyr7yo0Q8ClQXt
         oDr9KiYqOxKjt2EFi7caUI9P2Ha6slmGekKUMF3aTPhJfTjRYOLs3GDRFwQg8SOGOsXH
         d7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749578968; x=1750183768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7ON4ACspMh3kTYlX3qUDvOqdnrVvgEI+gPgcTT7CR4=;
        b=dFs4n06ULzfl90SuIaX8Jy0xGD+v2BfOgyWe9RmdetwYf7sMVVL/jVa2DFKBJzMbnN
         fqTQn6RC72ap8DepWUacXQRl0EUm21/EpwQPpfEbin+HoQIxZPnvvPU8KzoPO9dstGYQ
         oZuSbxn5kJ3KKqylCAIVLBQhuhlN/7IaBh3R2WOVYg3dXlgVe9fWU23nhtikXNx83vwy
         8AD00KOpHKtHD5NufoHQcoZ749W2sEayNvHzhk4fzSXGgLAFjJlQxswCymttbkXaqvvX
         iQ3DpoTn3mJ4HuerqSUc3k/jLt1i6sGcZ2kj2ahyANJQ1anF8qveVcmwNrDTRhEdcIo3
         qkdg==
X-Forwarded-Encrypted: i=1; AJvYcCUsO/Zckp0VVYuvPKHxDBjR3NqODH86IyO7NBy9+2GW+O92Mi/ftt+Lts7fi1fVkc7QcgGMfKjD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ztO0XvEm11ugLqVF/t+t8jCruDWfPtKN+C1Qj/zw57QYuVGI
	ZMVIvafDkyGZS95hrg25/LPUMQJIGtLTxO0Ao9HjOQdAGmOC0fv5CgS1tM2oy0rKkMt/Bo2HqRE
	Mx2tvT8c58RsiQcY5lsvivUdsmrem/94=
X-Gm-Gg: ASbGncuAVYjx7AiXTarVfxS6kM0Y5HNn5Z/TLnOKkvF6XYRUEvxPJ43k5RtfjLzL2Yy
	2ME09tt0TxJgJLRB2DLrd4xqejLsVdhjOSNDZrUy6OSYmHpqu3eeNDjfmklKWVZU27Mfis8wMx2
	euBuw7GSwBj3jU8jC1hCFaJttxEkiwNNj2jJSyEEZhMlY=
X-Google-Smtp-Source: AGHT+IFWCOYMWJ+ZRET+tZi/rc+o8VEF+IXwa6P4qaAN7NhvLtIHeI70ATJeTcQL6+9gtQLDFHhaHiobTYLMLBaKeP8=
X-Received: by 2002:a05:620a:4446:b0:7d2:1351:bf24 with SMTP id
 af79cd13be357-7d3a88088e0mr53704585a.11.1749578967661; Tue, 10 Jun 2025
 11:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530123048.53419-1-cgoettsche@seltendoof.de>
 <20250530123048.53419-2-cgoettsche@seltendoof.de> <87plfbetzh.fsf@redhat.com> <871prrlttc.fsf@defensec.nl>
In-Reply-To: <871prrlttc.fsf@defensec.nl>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 10 Jun 2025 14:09:16 -0400
X-Gm-Features: AX0GCFt0VQ58wTOlDZcWKiJ3gJpK8UJRLNDd7mFRKug_aAn2iNZvbKzmWO2TeqA
Message-ID: <CAP+JOzT+W+fiEQdw4c4MkX_h8A=sp4fCnBfA5kGgN9Xcd9=7UA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libselinux: retain LIFO order for path substitutions
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: Petr Lautrbach <lautrbach@redhat.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, 
	selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 7:28=E2=80=AFAM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Petr Lautrbach <lautrbach@redhat.com> writes:
>
> > Christian G=C3=B6ttsche <cgoettsche@seltendoof.de> writes:
> >
> >> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >>
> >> Store the path substitutions in LIFO order as in previous versions.
> >>
> >> Fixes: 4d436e4b ("libselinux: use vector instead of linked list for su=
bstitutions")
> >> Reported-by: Dominick Grift <dominick.grift@defensec.nl>
> >> Link: https://lore.kernel.org/selinux/87ldqftsxd.fsf@defensec.nl/
> >> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >> ---
> >> v2: add patch
> >> ---
> >>  libselinux/src/label_file.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> >> index 61a9ddb6..b785eab6 100644
> >> --- a/libselinux/src/label_file.c
> >> +++ b/libselinux/src/label_file.c
> >> @@ -1350,6 +1350,15 @@ static int selabel_subs_init(const char *path, =
struct selabel_digest *digest,
> >>      if (digest_add_specfile(digest, cfg, NULL, sb.st_size, path) < 0)
> >>              goto err;
> >>
> >> +    /* LIFO order for backward compatibility */
> >> +    for (uint32_t i =3D 0; i < tmp_num/2; i++) {
> >> +            struct selabel_sub swap;
> >> +
> >> +            swap =3D tmp[i];
> >> +            tmp[i] =3D tmp[tmp_num - i - 1];
> >> +            tmp[tmp_num - i - 1] =3D swap;
> >> +    }
> >> +
> >>      *out_subs =3D tmp;
> >>      *out_num =3D tmp_num;
> >>      *out_alloc =3D tmp_alloc;
> >> -- rc =3D cil_gen_node(db, ast_node, (struct cil_symtab_datum*)role, (=
hashtab_key_t)key, CIL_SYM_ROLES, CIL_ROLE);
if (rc !=3D SEPOL_OK) {
if (rc =3D=3D SEPOL_EEXIST) {
cil_destroy_role(role);
role =3D NULL;
} else {
goto exit;
}
}
> >> 2.49.0
> >
> > It fixes the original reproducer:
> >
> > root@fedora:/# cat /etc/selinux/fedora-selinux/contexts/files/file_cont=
exts.subs
> > /new_root /
> > /new_root/foo /usr/bin
> > root@fedora:/# matchpathcon /new_root /new_root/foo
> > /new_root       system_u:object_r:root_t:s0
> > /new_root/foo   system_u:object_r:bin_t:s0
> >
> > but it's important to say it depends on the order of entries in .subst:
> >
> > root@fedora:/# cat /etc/selinux/fedora-selinux/contexts/files/file_cont=
exts.subs
> > /new_root/foo /usr/bin
> > /new_root /
> > root@fedora:/# matchpathcon /new_root /new_root/foo
> > /new_root       system_u:object_r:root_t:s0
> > /new_root/foo   system_u:object_r:etc_runtime_t:s0
> >
> >
> > it looks like it was like that even before with 3.8:
> >
> > [root@fedora-41 /]# cat /etc/selinux/targeted/contexts/files/file_conte=
xts.subs
> > /new_root /
> > /new_root/foo /usr/bin
> > [root@fedora-41 /]# matchpathcon /new_root /new_root/foo
> > /new_root       system_u:object_r:root_t:s0
> > /new_root/foo   system_u:object_r:bin_t:s0
> >
> > [root@fedora-41 /]# cat /etc/selinux/targeted/contexts/files/file_conte=
xts.subs
> > /new_root/foo /usr/bin
> > /new_root /
> > [root@fedora-41 /]# matchpathcon /new_root /new_root/foo
> > /new_root       system_u:object_r:root_t:s0
> > /new_root/foo   system_u:object_r:etc_runtime_t:s0
> >
> > It would be great to have this behavior documented, but it's a differen=
t
> > issue.
> >
> > If there's no other objection I'll merge tomorrow before 3.9-rc1.
> >
> > Acked-by: Petr Lautrbach <lautrbach@redhat.com>
> >
>
> I applied this patch and it addresses my issue (restores compatiblity).
> I can also confirm that ordering the specs indeed also addresses the
> issue at least in a simple test I did.
>
> I do prefer that ordering shouldnt matter.
>
> Thanks!
>

If it fixes Dominick's issues, then I have no objection. I had planned
on verifying that it had fixed his problem, but now I don't have to.
Thanks everyone,
Jim

> --
> gpg --locate-keys dominick.grift@defensec.nl (wkd)
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift
> Mastodon: @kcinimod@defensec.nl
>
