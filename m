Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F353B601
	for <selinux@vger.kernel.org>; Tue,  8 Sep 2026 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871395; cv=pass; b=YE3ntE+oB05eZvI1osumIc2HW3uTrHGzjPgOTIjKh7YVTsSbFJeufwTiEaqi/a3cVwoo5pAiZ3eJ+tRmjzVvf5wdPnJeMSHaj9uhwmGnBYt27lbVtx1NpqGXlK2IQ78uhe/wMYOLEu02ajaq9H51ULqs7Vn8J9xmK3BvN7M+pRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871395; c=relaxed/simple;
	bh=HMCCe44KsDmkDHXrSXxBUrKDHFqRgo19xtzho9sH6rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQv5QL+dqtpRY8WfPgBLGmBpfVj9vZIzFmofVbxKXHgQQQBdoyarYbwx++jbp4MM/1Xaw+CC+Hr1jPqiPD8NQZoWw8z2S13G/z9SihwiqyoMISecJ09w4J0DHAdjaBUwcARXCNsg0ucxZ+KNqN/md4NxLd6dbmbeYcDtQx7l5MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOsWMHqm; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOsWMHqm"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4765ce0573eso2093238fac.0
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2026 05:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788871393; cv=none;
        d=google.com; s=arc-20260327;
        b=mbqGnG4WYILSmhFQl01ux1Dxp3KEghRjiq1M9TyGE/8lEJK5JBH4FVlZ8BpBsLLFOn
         44kb056E71FYBHFu0Qz3IM5q/vnUKNAfXniz6EioT16A6z+KwqMDIdVpiCmBUCk8qgBN
         9DcxsfVvsKAvd19y36TaHFXVFFXhFxwzDYRo2nIYOXD377Pt0x3g+8jlaO51CNpIP+e+
         lnoe5hkELGDQC6KjjqzE6RCxSv5BkCvMIwRU8iJzaUSvxNsa5QKxQR7GGKUdsJkspxdK
         rnebFwSLlCjOYJEOJI+ceuNlOco4GCNEtGfEbyRLGP0SKe/Gv8wO3qLJfClGovbQsLg1
         pcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q36KMtG6PqJYaBBQCND8s5IJlu/FSyCsmFUBlKMkdXM=;
        fh=9xggjHf/SJHZhY/cQYWDqwzyHYfNP7dR/l21asaTENg=;
        b=TRpd92HxrsKSnCKI2WpLrI8N8PbDtcpfTwRYVGTEX5hkizI/qceYZFcwE0GCENjGTw
         mEia6sNyeVgcWBxzu8evGl3xduoxRcKl4xM6e3LtoMVOMc2tgam66gPPBeatnL57mJNm
         SjEjIzIf9+96UKOEZuev62K8Ioioer2I5G2JiER2MDvq0+UKSpFhBNdTpLJxzmi7QbGS
         zGDb7m2m7WfDjDzHWKsuEb9s3RPFnZn2ghZxgEfL/ZoIolmraAEf4QNsCbGlWRt65gdM
         oUK8M8uf2OZe+18QqaCwC2Y/mMYZgp6T3xjEhKij2VbSAZwg65+n2pfRZWV9mJvQUgTF
         J/kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788871393; x=1789476193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q36KMtG6PqJYaBBQCND8s5IJlu/FSyCsmFUBlKMkdXM=;
        b=hOsWMHqmTvjATqQah3jm4h+zcTOc+2jOZtdQlZakjSEHSJfcWHCaFlCGqoWXZRmnWW
         p3+k5jg32NRCS3aLtNCrmUd7yoIBqOIZriF3J7G+M7cC343Yz1IPgW2Yy3hW4w4Zk7eY
         RZ99cTpDwOu92aHkknQ6NQ3QCiUogxvu+w+fizZaDbnJOyFd2u81FIQIMnHi8ghgs7vz
         60h+U9dUDTyQ1nxhGxTowlpK+IZvWc+BcLPA7OA8JZ5JLfagtzL0KWL2C6ec5AzpbkFx
         R98jRD71yf7EvI47jSkYOOZkoTOmYPffKl//d/8GPX8enqujhauCEahiZQa8+7ylKM/Y
         +21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788871393; x=1789476193;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q36KMtG6PqJYaBBQCND8s5IJlu/FSyCsmFUBlKMkdXM=;
        b=qdp9X8stdhqs3x+fSCBZ1tlcF5hhXMXmEhkO8DddNZ6USzTSxfgzflajFtqQhCb8Qq
         iG7XXko0FC2uzc9SG/EGIGY7V9njos8G436UI6tFiKeLEadeHgz8V67NY8ZQWyMxvcGf
         po91NrON5FIfqI5a2YkM9Vg5ew4g/6AkQ40NbIPGDX/jXFr/eATI9dGUzT8BYRv2HPfb
         5WITi6HD93h2eF2nIvWfXcn+cv2KaJwZgKIO2A+d39lj8GlGpyBkLWoQlWQiwvYZw2SG
         MYKVLxDJISsFwj0rarqc5PZoNBwa0lyuCafNc5OSy9nNL7+qSFlM4T7jZUXp6GeOcQz/
         tyUw==
X-Forwarded-Encrypted: i=1; AKwUvBwkCaP6lX9DGdNHXlh63u6aF9/EK2pdgLuRwvnndmnqDcBP9pHYmq3Ou0w75O9d4DurbGpXc30F@vger.kernel.org
X-Gm-Message-State: AFuF++ntcd8UcdZ7rBlZBtnhJ5QZGiNxa/RtX846BMzru7RIYI5Q0y1n
	XbBm2kef8+JMPq7NslVSUQR44sg8ZNkuFMyLx6qvNkIjcoR494dPutjDk/jP2MbjB4K9Ek8ccKm
	VF2+z0Z6AkNQI+SKe5S/LYt6LG2HwyuU=
X-Gm-Gg: AYBFou0i6vp0KVgIY6dAwcbHGRameBrWOz7tZcfwaqhmC6GDPDKC03tk+fYqU6zmufL
	c+DveJAUQHtSIn+Smgf/is6xCSR/VQwXsj3QBZFdSfDvuoMHmv0x7TFIfYxxVJfjMdLB/nZIwBU
	9yAfQL4OfsgZkSt20QEmUnPs97QSLQU8zedINZY3WehpsJBvPiMBY95bAo7+Y5SGUYUtkr0xDXv
	ad2Ss7IZCfKQjLjebHi7hXbHkA7XZ5uGBcdGtVNdm1sypKhMzQkxi7pPp9CyHOln/7C0iB2raRC
	hpgVl9IRfqKYzyGEZ1XVYv4UKlSi1ADYfngZpa2cx39B
X-Received: by 2002:a05:6870:c22a:b0:475:e2e9:4f48 with SMTP id
 586e51a60fabf-475e2e95336mr14551506fac.22.1788871392844; Tue, 08 Sep 2026
 05:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <L8sbFRgfQca4r8AaNEEfTw@coker.com.au> <CAEjxPJ6SQcdEDFfV3W7Bk5JKbAxRp+9tuvr2yhUdDePmeXNAKA@mail.gmail.com>
 <CAHC9VhT+k9qWsA40APOi4Q1hg8M+Ft_A7D3epdBW7P2QczPf6Q@mail.gmail.com>
 <RvCmRlQYQ3uewSzEeY0utQ@coker.com.au> <CAEjxPJ5f1DCW5FWSE77_3HcMjt3QxMewCL5fX+PsdE_SXn-VZA@mail.gmail.com>
 <CAEjxPJ56+YkfCgt_08NgD+6pQsvDGrsUgx3o5eC-U1ZmE9pfqw@mail.gmail.com>
In-Reply-To: <CAEjxPJ56+YkfCgt_08NgD+6pQsvDGrsUgx3o5eC-U1ZmE9pfqw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 8 Sep 2026 08:42:59 -0400
X-Gm-Features: AcwNN1WKkpw_mPA778lewUHlKqrqjlxpx9JiQKYrpSXXIrA9VXGeS_uF5-Q0Dvc
Message-ID: <CAEjxPJ7TLMCPkE7fwKrSp_FKJ5xm=7YpNu8LA4GM1-EFkjsamw@mail.gmail.com>
Subject: Re: kernel oops on recent policy with older kernel.
To: Russell Coker <russell@coker.com.au>, James Carter <jwcart2@gmail.com>, 
	Inseob Kim <inseob@google.com>
Cc: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>, 
	selinux-refpolicy@vger.kernel.org, Chris PeBenito <pebenito@ieee.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 1:06=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Sep 7, 2026 at 11:23=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Sun, Sep 6, 2026 at 9:17=E2=80=AFAM Russell Coker <russell@coker.com=
.au> wrote:
> > >
> > > On Wednesday, 2 September 2026 01:35:44 AEST Paul Moore wrote:
> > > > > Date: Wed, 22 Jul 2026 21:04:27 +1000
> > > > > Subject: kernel oops on recent policy with older kernel.
> > > > > I get the above when loading the latest git policy compiled with =
3.11
> > > > > userspace on Debian kernel 6.12.74+deb13+1 and Debian kernel
> > > > > 6.12.86+deb13.
> > > > > The same policy on a 7.x kernel such as 7.0.13+deb14 works correc=
tly.
> > >
> > > https://www.coker.com.au/w/
> > >
> > > Below is the kernel message log output with Debian kernel 6.12.107+de=
b13-
> > > amd64_6.12.107-1.  The above URL has the Debian kernel image and the =
policy
> > > file.  The command "ar -x linux-image-6.12.107+deb13-
> > > amd64_6.12.107-1_amd64.deb" extracts the kernel if you want to use it=
 on a
> > > non-Debian VM.
> > >
> > > It's hanging not crashing which is an improvement.
> > >
> > > [   10.414520] audit: type=3D1404 audit(1788699747.392:2): enforcing=
=3D1
> > > old_enforcing=3D0 auid=3D4294967295 ses=3D4294967295 enabled=3D1 old-=
enabled=3D1
> > > lsm=3Dselinux 1
> > > [   10.530653] SELinux: no sid found, defaulting to security isid for=
 /
> > > booleans/aide_mmap_files
> > > [   10.535475] SELinux: no sid found, defaulting to security isid for=
 /
> > > booleans/amavis_use_jit
> > > [   10.537368] SELinux: no sid found, defaulting to security isid for=
 /
> > > booleans/allow_httpd_anon_write
> > > [   10.540012] SELinux: no sid found, defaulting to security isid for=
 /
> > > booleans/allow_httpd_mod_auth_pam
> > > [   10.543230] SELinux: no sid found, defaulting to security isid for=
 /
> > > booleans/httpd_builtin_scripting
> > > [   10.546402] SELinux: no sid found, defaulting to security isid for=
 /
> > > booleans/httpd_can_check_spam
> > > [   10.549244] SELinux: no sid found, defaulting to security isid for=
 /
> > > booleans/httpd_can_network_connect
> > > [   10.551298] SELinux: no sid found, defaulting to security isid for=
 /
> > > booleans/httpd_can_network_connect_cobbler
> > > [   10.554654] SELinux: no sid found, defaulting to security isid for=
 /
> > > booleans/httpd_can_network_connect_db
> > > [   10.556863] SELinux: no sid found, defaulting to security isid for=
 /
> > > booleans/httpd_can_network_connect_ldap
> > > [   10.559776] SELinux: failed to initialize selinuxfs
> > > [   10.568734] systemd[1]: Failed to load SELinux policy.
> > > [!!!!!![   10.585074] systemd[1]: Freezing execution.
> > > ] Failed to load SELinux policy.
> >
> > This appears to be due to enabling this policy capability in refpolicy:
> > https://github.com/SELinuxProject/refpolicy/blob/main/policy/policy_cap=
abilities#L154
> > which was done by this commit:
> > https://github.com/SELinuxProject/refpolicy/commit/2e810736211785675f0b=
e23a26638cd44c69eaae
> >
> > As noted in the comments, that policy capability requires kernel 6.16+
> > and the one above it that
> > was also enabled by the same commit requires kernel 6.15+.
>
> I could be wrong, but I also think that enabling that policy
> capability requires adding "*" wildcards at the end of existing
> genfscon statements to preserve the prefix-matching behavior, so that
> change may break even 6.16 and later.

It appears to me that there was an attempt to make checkpolicy aware
of the genfs_seclabel_wildcard policy capability and have it
automatically add the trailing "*" to the genfscon paths when it is
enabled, but I don't think that works for modular policy. I do not see
such wildcards in the policy.35 file you provided, not that that would
help with kernels < 6.16 anyway.

> Could likely make the selinuxfs case non-fatal since it falls back to
> the security initial SID anyway but other genfscon-based labels may
> still break without updating the genfscon statements.
