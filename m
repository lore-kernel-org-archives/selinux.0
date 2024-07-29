Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F91581F2
	for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266397; cv=none; b=pvAUJkp+zOfbiNcNPu24SlfrVh6BjNAMo+VnZLzhBf2TtjQJO2NcIc8eNVRlwlA930jtkQNrfsQdlXrVHVeNWbTXHq9nVUX7SL/BetQ7IHl/9F1HFRsOujysGK5T3Anvy4eVGZiv9jj+6DITAjbKIJxeZaKYBY9G6aZJH3PK8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266397; c=relaxed/simple;
	bh=yvjqgfX/prMMCRUsH9EFo4OGQ6RJ3MhPwdcDCNAqaaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxYnF6d51mAlpSHAAGr1Ro1OefmAdvwfvrRwKOgwpVoeikQO2d+Pqmnxcm5J910BdZPXO10ye+9NRZivAitbovk1kqS/rvq1Ln8LKJypjhPEhUFmO515J1DgHbxreg90aiIxDSqV9pg6ZYzosml1PQ+OU1i0HVY6XJ39j46svqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aH074kyb; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aH074kyb"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-710437d0affso2098896a12.3
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 08:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722266396; x=1722871196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5x5ufkZ4eQ9D6dDrLgwOhXTKsq/DY5pej8IDa9QX7E=;
        b=aH074kybItcCqdqogKO+4FDGqLwqkeSmPVSXQiCiBcR3Uw/Ffk2a5PXZsgUYKaqwLx
         vFz4pVrCF0TLkVwZuUM61DhulbX1PRrr3bblHm8ixMKFfTSGdIduRUWdaaMs7E0gO7+f
         7kM1xlheMD3HlfBIZpg3xNegqIpW18y5PCMA6OOmd+SvhJYXoH4FVLHOekfoWXNnlnDL
         vCG8mHk69K1oGp3y4rbE35veprA7zMrTz5ezCNiTWriqx3nN/vOkRhFYa+RKf+3i/KiD
         yi9H2pN0KxBUtx7MVoDQ1IioMXE725c+DArvnjS+2sCvDxeDKwx4wLhFSU5QSW2tVEjM
         BoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722266396; x=1722871196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5x5ufkZ4eQ9D6dDrLgwOhXTKsq/DY5pej8IDa9QX7E=;
        b=p+5iqd07aS3I3MuiEMVtBVqfk5gQtvRnQGLk/WYnuwIuuql4W4hdiH1dim8nV/3VcY
         vAv5ljIU4fD2PKy82bwJqVhAgtYoKz3a/RXF/ch0L01AsIXny6lI1taJvYPKSKa6kFTC
         tfHeOKL6vslxzB5ngvSJa82f8gQMeBvUBcpT2pB0LzdIR8/+31YSJdbrozlha+GR+zB6
         KUTcrNdVsxyHvrLK3ICsWndmCW+IAwZPEswdHKAdOy2fwD6q6s2Eduns7ZSKeuoCzNeG
         tgLRuDjuo7MgmP2x4bAvJ7K3pg2OsrEW2a6ACxQSu0I0gYw3WOjgd7U7i2uU+PcR+IbV
         py5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaXn6c1MEUA2FOQzuVqZUtXTgLzfOScgyRC0S59aeuptgIqJw8XG0XJdnTwQpatROwDj/nWAZCKeuKJ0ur2gIWCkTkcMv7/A==
X-Gm-Message-State: AOJu0YyyFDmCK9zUWTFhfbF9DnkEDPHJ0JncOZENviNUU1nQvE87oia4
	1mEUPi2Y8W/nd+jkG6+VlHlaPiUq+2zt1dJiq4ozUul4F/yZ1kSAjsCNzbBoRZyUofBeumqaILV
	gNFUfUHIfWZAKvDEoUiAvsJOOZZzwJg==
X-Google-Smtp-Source: AGHT+IFsRkSu62rPjH4LiGIv32Q7tQpL9vB+KSij1gkaByDsfsrBi92XnOJkNAsVP1HMdoSKlor1T5uH0frGpoKyVOs=
X-Received: by 2002:a17:90a:2cf:b0:2c9:7cf1:83a4 with SMTP id
 98e67ed59e1d1-2cf7e1fa01cmr5828995a91.20.1722266395492; Mon, 29 Jul 2024
 08:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4bQZeZzLGdk0HPFPkm4uob7oHB7sygyXQo2km9BAK5Xg@mail.gmail.com>
 <20240729113247.1673713-1-vmojzis@redhat.com> <CAJ2a_DfXGypY2Q3=X815ABgkLq7Pxbo=sApZJONc5DefmTiU6g@mail.gmail.com>
In-Reply-To: <CAJ2a_DfXGypY2Q3=X815ABgkLq7Pxbo=sApZJONc5DefmTiU6g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 29 Jul 2024 11:19:43 -0400
Message-ID: <CAEjxPJ5HtELXaJ9Hs0nS63y5pb1coucVxBhT4i89xEwpwA_rNw@mail.gmail.com>
Subject: Re: [PATCH v5] libsemanage: Preserve file context and ownership in
 policy store
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:00=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Mon, 29 Jul 2024 at 13:33, Vit Mojzis <vmojzis@redhat.com> wrote:
> >
> > Make sure that file context (all parts) and ownership of
> > files/directories in policy store does not change no matter which user
> > and under which context executes policy rebuild.
> >
> > Fixes:
> >   # semodule -B
> >   # ls -lZ  /etc/selinux/targeted/contexts/files
> >
> > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 421397 =
Jul 11 09:57 file_contexts
> > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 593470 =
Jul 11 09:57 file_contexts.bin
> > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  14704 =
Jul 11 09:57 file_contexts.homedirs
> > -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  20289 =
Jul 11 09:57 file_contexts.homedirs.bin
> >
> >   SELinux user changed from system_u to the user used to execute semodu=
le
> >
> >   # capsh --user=3Dtestuser --caps=3D"cap_dac_override,cap_chown+eip" -=
-addamb=3Dcap_dac_override,cap_chown -- -c "semodule -B"
> >   # ls -lZ  /etc/selinux/targeted/contexts/files
> >
> > -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0=
 421397 Jul 19 09:10 file_contexts
> > -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0=
 593470 Jul 19 09:10 file_contexts.bin
> > -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0=
  14704 Jul 19 09:10 file_contexts.homedirs
> > -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0=
  20289 Jul 19 09:10 file_contexts.homedirs.bin
> >
> >   Both file context and ownership changed -- causes remote login
> >   failures and other issues in some scenarios.
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> > ---
> > Changes in V5:
> >  - Check return value of fchown and warn user if it fails
> >
> > Should I start creating github pull requests for each patch to catch th=
is
> > type of issue in the future (so that I don't waste your time)?
> >
> >  libsemanage/src/semanage_store.c | 32 ++++++++++++++++++++++++++++++++
> >  libsemanage/src/semanage_store.h |  1 +
> >  2 files changed, 33 insertions(+)
> >
> > diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanag=
e_store.c
> > index 27c5d349..0ac2e5b2 100644
> > --- a/libsemanage/src/semanage_store.c
> > +++ b/libsemanage/src/semanage_store.c
> > @@ -36,6 +36,7 @@ typedef struct dbase_policydb dbase_t;
> >  #include "database_policydb.h"
> >  #include "handle.h"
> >
> > +#include <selinux/restorecon.h>
> >  #include <selinux/selinux.h>
> >  #include <sepol/policydb.h>
> >  #include <sepol/module.h>
> > @@ -767,6 +768,7 @@ int semanage_copy_file(const char *src, const char =
*dst, mode_t mode,
> >         if (!retval && rename(tmp, dst) =3D=3D -1)
> >                 return -1;
> >
> > +       semanage_setfiles(dst);
> >  out:
> >         errno =3D errsv;
> >         return retval;
> > @@ -819,6 +821,8 @@ static int semanage_copy_dir_flags(const char *src,=
 const char *dst, int flag)
> >                         goto cleanup;
> >                 }
> >                 umask(mask);
> > +
> > +               semanage_setfiles(dst);
> >         }
> >
> >         for (i =3D 0; i < len; i++) {
> > @@ -837,6 +841,7 @@ static int semanage_copy_dir_flags(const char *src,=
 const char *dst, int flag)
> >                                 goto cleanup;
> >                         }
> >                         umask(mask);
> > +                       semanage_setfiles(path2);
> >                 } else if (S_ISREG(sb.st_mode) && flag =3D=3D 1) {
> >                         mask =3D umask(0077);
> >                         if (semanage_copy_file(path, path2, sb.st_mode,
> > @@ -938,6 +943,7 @@ int semanage_mkdir(semanage_handle_t *sh, const cha=
r *path)
> >
> >                 }
> >                 umask(mask);
> > +               semanage_setfiles(path);
> >         }
> >         else {
> >                 /* check that it really is a directory */
> > @@ -1614,16 +1620,19 @@ static int semanage_validate_and_compile_fconte=
xts(semanage_handle_t * sh)
> >                     semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC=
)) !=3D 0) {
> >                 goto cleanup;
> >         }
> > +       semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMAN=
AGE_FC_BIN));
> >
> >         if (sefcontext_compile(sh,
> >                     semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC=
_LOCAL)) !=3D 0) {
> >                 goto cleanup;
> >         }
> > +       semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMAN=
AGE_FC_LOCAL_BIN));
> >
> >         if (sefcontext_compile(sh,
> >                     semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC=
_HOMEDIRS)) !=3D 0) {
> >                 goto cleanup;
> >         }
> > +       semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMAN=
AGE_FC_HOMEDIRS_BIN));
> >
> >         status =3D 0;
> >  cleanup:
> > @@ -3018,3 +3027,26 @@ int semanage_nc_sort(semanage_handle_t * sh, con=
st char *buf, size_t buf_len,
> >
> >         return 0;
> >  }
> > +
> > +/* Make sure the file context and ownership of files in the policy
> > + * store does not change */
> > +void semanage_setfiles(const char *path){
> > +       struct stat sb;
> > +       int fd;
> > +       /* Fix the user and role portions of the context, ignore errors
> > +        * since this is not a critical operation */
> > +       selinux_restorecon(path, SELINUX_RESTORECON_SET_SPECFILE_CTX | =
SELINUX_RESTORECON_IGNORE_NOENTRY);
> > +
> > +       /* Make sure "path" is owned by root */
> > +       if ((geteuid() !=3D 0 || getegid() !=3D 0) &&
>
> I currently do not understand this condition.
> Doesn't it check that we run *not* as root (in which case fchown(2)
> will probably fail)?

See the patch description. He is trying to run it with just
capabilities and not as root.
