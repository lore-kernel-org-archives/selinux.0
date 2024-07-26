Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A3A4D9FB
	for <selinux@vger.kernel.org>; Fri, 26 Jul 2024 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019013; cv=none; b=pD/xhoSgGZoxMuKkgRWzVelSHsEx1CqEY8yve5iv6gvQS5qzaU7pxKyhI5tQGiTcBAH7/BOidvJd6+KUAxVoibp0o/FNaV0qY11i6VpbwUdimISvVw2EVA3BWrlV6NBFTzzV3y4jBB9XqxW/5QWugcSCl5rnMlo+w1iYqHZgiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019013; c=relaxed/simple;
	bh=Nl0ASeBa7+jSJ9uIMWxc32ybxsw+g/ETZPjqWGit9jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emxaoUTCTA9UFOnu9PwY4fAmnsabk9M0eRd2AudXmklD1IZZnTd7uAFTU0A3pqZtptdpD+ThyZnb2nLJidt8wpp1vhZBAtu8SsSTP6tJ1MhMG5atgwhmNiOkwxf50h+oWlj/teYqChRwj3x3SNEb55zEAW0Y2I+MHkJY4oPiDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Igy5Bwqe; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Igy5Bwqe"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a0b2924e52so760262a12.2
        for <selinux@vger.kernel.org>; Fri, 26 Jul 2024 11:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722019011; x=1722623811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2Rj94L1feDWhWPIZj+g6222qAr4pw18rxm3JaaSXt0=;
        b=Igy5BwqetAsL92HShzlvA4HCaeSmdXFQHxGykbpBjiwHHNvZDJfrVObFPRPISwCbTY
         5uiGx/Z5fC5sOtYfzQ90H55joz+jrE8ujOa8WjkO3nluGqKXcDJ4HCE+rvlhqW69XPqn
         jgsJTIpLJMPEHZE3mrxRkj6+/OVTHLC9JHM+9sreXFqu0CFgHbbVNtNdnI9n6vLdzBxz
         nxNsOkmoCMIgYBx+oQOK9YVEuHDf5SeExbJli3I8O3rrkK7ibvV3MOYb1aCxaTrQulAE
         bHesRovq/QPejISHCds28RzaKhdgTQYFGy3FdcgNkZgJajzvYmkNgcekp2iOxqWsGq2L
         5EEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722019011; x=1722623811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2Rj94L1feDWhWPIZj+g6222qAr4pw18rxm3JaaSXt0=;
        b=ZyI54liilwaJMWfxXFnf9dE8E+iuZoJ7YQadDi3d66iz33W4ZIVuOcX9Fag8xUkD66
         /15pqp9N3eHNDDGkgJoH08pHgtj3eqAFGjDVnXay0maegVSMoOPuJF6YjhJdMNJYK6PY
         nL0+Az9XFg2F1u+Dg9RgEH6qAGsTNK4UpR5YHp7OfIw8QISTKpeakFs3HFSKB+QUirxR
         +ndw+9VH86ng9nMQDozZzH/ChbZh6ukNV9NEVPwt+tOt4QIiA6ezWVLb8WfZXzLdZD0r
         ntQhUVohvEhBj4wkSdudUtpBf4FDXXBm/4ENCslEpCfjt26vbHIYuDkVXKc3Rb7EH0ys
         JgAg==
X-Gm-Message-State: AOJu0YxBusv1IMtGP7q6qoQSyj9yV/+JNM10hVUFQW+WX6UJQflZxxZk
	WSoeq7EsO3WE1MfevW1w3NCND6UaBF/Ri6uV/i0Hzu9tjLAx8D0Rr3ZF9Hc234HJVHLSc6EVPz8
	HITfOw9iPMsXsVBuFhK0q9woZGQh0SYZ3
X-Google-Smtp-Source: AGHT+IFe8+TvSGJvNpI2QKZumq/+la7g+/G6gHnJxUNJ4UPIck+emd5ILbMGatGLQhFyrqorrr9G1Uv0U79N66M5cdw=
X-Received: by 2002:a17:90a:6fc2:b0:2c8:e3e6:ec99 with SMTP id
 98e67ed59e1d1-2cf7e72a3c2mr371343a91.43.1722019010916; Fri, 26 Jul 2024
 11:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b4ec6621-dbbb-4f59-9d2e-7fd4edc6b116@redhat.com>
 <20240725161107.1446978-1-vmojzis@redhat.com> <CAEjxPJ72F11Y2qSa4A6xaU=gdOt18u2H9OOqhZwv0RFkR0OEfg@mail.gmail.com>
 <CAEjxPJ6_FN9NuO-jHmnPVFqypt=6Pxyko9J1=G9xQdC+umWEmA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6_FN9NuO-jHmnPVFqypt=6Pxyko9J1=G9xQdC+umWEmA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 26 Jul 2024 14:36:39 -0400
Message-ID: <CAEjxPJ4bQZeZzLGdk0HPFPkm4uob7oHB7sygyXQo2km9BAK5Xg@mail.gmail.com>
Subject: Re: [PATCH v4] libsemanage: Preserve file context and ownership in
 policy store
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:54=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 26, 2024 at 1:50=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Jul 25, 2024 at 12:11=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com=
> wrote:
> > >
> > > Make sure that file context (all parts) and ownership of
> > > files/directories in policy store does not change no matter which use=
r
> > > and under which context executes policy rebuild.
> > >
> > > Fixes:
> > >   # semodule -B
> > >   # ls -lZ  /etc/selinux/targeted/contexts/files
> > >
> > > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 42139=
7 Jul 11 09:57 file_contexts
> > > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 59347=
0 Jul 11 09:57 file_contexts.bin
> > > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  1470=
4 Jul 11 09:57 file_contexts.homedirs
> > > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  2028=
9 Jul 11 09:57 file_contexts.homedirs.bin
> > >
> > >   SELinux user changed from system_u to the user used to execute semo=
dule
> > >
> > >   # capsh --user=3Dtestuser --caps=3D"cap_dac_override,cap_chown+eip"=
 --addamb=3Dcap_dac_override,cap_chown -- -c "semodule -B"
> > >   # ls -lZ  /etc/selinux/targeted/contexts/files
> > >
> > > -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:=
s0 421397 Jul 19 09:10 file_contexts
> > > -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:=
s0 593470 Jul 19 09:10 file_contexts.bin
> > > -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:=
s0  14704 Jul 19 09:10 file_contexts.homedirs
> > > -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:=
s0  20289 Jul 19 09:10 file_contexts.homedirs.bin
> > >
> > >   Both file context and ownership changed -- causes remote login
> > >   failures and other issues in some scenarios.
> > >
> > > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> >
> > With the selinux/restorecon.h fix applied first,
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Ah, spoke too soon. The GitHub CI testing failed with this:
> semanage_store.c: In function =E2=80=98semanage_setfiles=E2=80=99:
> 520 semanage_store.c:3047:25: error: ignoring return value of =E2=80=98fc=
hown=E2=80=99
> declared with attribute =E2=80=98warn_unused_result=E2=80=99 [-Werror=3Du=
nused-result]
> 521 3047 | fchown(fd, 0, 0);
> 522 | ^~~~~~~~~~~~~~~~

Unfortunately, you can't just mark this as intentional, as per
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D25509.
Casting to void doesn't eliminate the warning. Saving the return value
but not using it somewhere triggers another warning.
Calling assert() if rc !=3D 0 breaks make test in libsemanage. We don't
have a handle here or in the immediate callers so can't just call
ERR(). Changing it to:
rc =3D fchown(fd, 0, 0);
if (rc)
   fprintf(stderr, "Warning! Could not set ownership of %s to root\n",path)=
;
seems to solve the warning problem but is a bit ugly.
