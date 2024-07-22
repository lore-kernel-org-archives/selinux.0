Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5A51C695
	for <selinux@vger.kernel.org>; Mon, 22 Jul 2024 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721675955; cv=none; b=ivPHEQOaLJqQdGj/wHKywM8TmWEo3wlLy4oXTxLDtl62c7YrhFypfF/WFXA1rsUZoXYWPPZBZgUPDmQqT8V9jb7hXBVi9KXjzDQZrk3gLjLvur+RctqM3SEhOLaj0CHC1cYZ9lx70zQ0SM5BKivujl38EgCaLHvmkeaIf4M0FVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721675955; c=relaxed/simple;
	bh=5dlJ/3UzjavEmf4d8DJiokqj9VOZUSpegJQ8OTHffg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EqDyMjjTGfBaHYwP6JPgFlwUaCAmGHHtDHfm/Ua9jUzB5yMYaNv/uEi4ckxdUYlyPUaeIs1DcYpJ11pgqV4HYRhwjv922EVzYSaWSfH8wl1aqmXxRGVt/jPmcLBkLGsW6cPr8kSeQIfVTibVtxMlMcV1B+PRFm8j/zrcz5wKG54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6XbQeK2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6XbQeK2"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb5e0b020eso2914840a91.2
        for <selinux@vger.kernel.org>; Mon, 22 Jul 2024 12:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721675953; x=1722280753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9U+03300A98Vsc2zeB7rf2s/kTbpR51XEtUWz2chHA=;
        b=K6XbQeK2KkFfi+dknwBFFL3fEiId83oeibj3+A1dhyxKH/fkI7U+ieIs8tiXjSSBia
         g3xPAe6MLompBr9W12GU0TrRWOSuzrK/Da61yCeF7trtHZhU/e+QkY8jNanmxmpJio0l
         IbOHD1ZeUIQGby3wM4NzIauQldt+2Qe14HyYeYmG5LKc4LoRLf3WiOxnS2+H1Akh1tYB
         6Bfme+wtouQTNM4NfFDAcnnB5UGEZF7O4DOn67Vvk2GhC9S3+tadg1qf5odHRbFS/RWd
         kfQ9jsWxpwsCBv5f2BSLu+dgN7tACiuw0AFtExWB4v2+WwOlTOG7YLemC9ZdI63JSuwF
         TZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721675953; x=1722280753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9U+03300A98Vsc2zeB7rf2s/kTbpR51XEtUWz2chHA=;
        b=jn3czE0Ql68Rkj0OoBitnI0N0cQM2AgRI6CaCVGEQQkLZmxyVUk3LeVZFYVnfdkjia
         2FaqqcpNcZOgP4I6IOqoHCGU9KF5gSSRj47ugx+5AK7HdP/8Jwa1Acr4nSkZultr4AkN
         4rBHqpznKDvs6EdbMaZ7uHClXrrRozlhwEgx1K8PNYmLwDHGYY+eAntEB0FOlINElQvH
         coPfG6jCNFS9gXbWk2jpMrgQalf4/ze+M6wMNUKA00eqm3frmI8wzI6SVTP7GKwf8G4G
         jCzCNuFRpFA2jMk10p1KipcTum8QTM4DvDAhqJ32pRo0jVcsgFeY5Ej2FlR78DcUsniU
         Atkg==
X-Gm-Message-State: AOJu0Yxms5O8Vv8z93iWZoV2uSv14LWQ8UreBXxT8TChGslHOkKGy+oX
	2f2Pb0lAO/C0ADarjdOVEhr7R4fSGkU8xW22lUOwWox31MdQG2mJi2A2cAQm1CV3n6agMnKZOfH
	mJamCi3GwzlSWzAW5jNcBPai7OxY=
X-Google-Smtp-Source: AGHT+IGRGwfij1tHiq4EV3MdVfVZVE0N70H9Zq/L9RDngiIiKlybGLyDIcW5Ar89q3lgPHTF+PMKU4cCQQHzXpq+xdw=
X-Received: by 2002:a17:90a:c683:b0:2cb:5aaf:c12e with SMTP id
 98e67ed59e1d1-2cd274e30aemr6323650a91.37.1721675952682; Mon, 22 Jul 2024
 12:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85a7faac-a590-4e3c-9c32-f446a6f5aec2@redhat.com>
 <20240719132918.931352-1-vmojzis@redhat.com> <CAEjxPJ5AgxzF=h3fCj3JS=aaNUcEWmnJU0q6jQVCmJQty==G7g@mail.gmail.com>
In-Reply-To: <CAEjxPJ5AgxzF=h3fCj3JS=aaNUcEWmnJU0q6jQVCmJQty==G7g@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jul 2024 15:19:00 -0400
Message-ID: <CAEjxPJ6p9hqj1Mft+J2tJ10vktNkhfjAbb322VqWyNJO10Gb=w@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: Preserve file context and ownership in
 policy store
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 11:11=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 19, 2024 at 9:29=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> w=
rote:
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
> >  libsemanage/src/semanage_store.c | 23 ++++++++++++++++++++++-
> >  libsemanage/src/semanage_store.h |  1 +
> >  2 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanag=
e_store.c
> > index 27c5d349..12c30ad2 100644
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
> > @@ -731,7 +732,7 @@ int semanage_copy_file(const char *src, const char =
*dst, mode_t mode,
> >
> >         if (!mode)
> >                 mode =3D S_IRUSR | S_IWUSR;
> > -
> > +
>
> We generally don't make unrelated whitespace changes in a patch.
>
> >         mask =3D umask(0);
> >         if ((out =3D open(tmp, O_WRONLY | O_CREAT | O_TRUNC, mode)) =3D=
=3D -1) {
> >                 umask(mask);
> > @@ -767,6 +768,8 @@ int semanage_copy_file(const char *src, const char =
*dst, mode_t mode,
> >         if (!retval && rename(tmp, dst) =3D=3D -1)
> >                 return -1;
> >
> > +       semanage_setfiles(dst);
> > +
> >  out:
> >         errno =3D errsv;
> >         return retval;
> > @@ -819,6 +822,8 @@ static int semanage_copy_dir_flags(const char *src,=
 const char *dst, int flag)
> >                         goto cleanup;
> >                 }
> >                 umask(mask);
> > +
> > +               semanage_setfiles(dst);
> >         }
> >
> >         for (i =3D 0; i < len; i++) {
> > @@ -837,6 +842,7 @@ static int semanage_copy_dir_flags(const char *src,=
 const char *dst, int flag)
> >                                 goto cleanup;
> >                         }
> >                         umask(mask);
> > +                       semanage_setfiles(path2);
> >                 } else if (S_ISREG(sb.st_mode) && flag =3D=3D 1) {
> >                         mask =3D umask(0077);
> >                         if (semanage_copy_file(path, path2, sb.st_mode,
> > @@ -938,6 +944,7 @@ int semanage_mkdir(semanage_handle_t *sh, const cha=
r *path)
> >
> >                 }
> >                 umask(mask);
> > +               semanage_setfiles(path);
> >         }
> >         else {
> >                 /* check that it really is a directory */
> > @@ -1614,16 +1621,19 @@ static int semanage_validate_and_compile_fconte=
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
> > @@ -3018,3 +3028,14 @@ int semanage_nc_sort(semanage_handle_t * sh, con=
st char *buf, size_t buf_len,
> >
> >         return 0;
> >  }
> > +
> > +/* Make sure the file context and ownership of files in the policy
> > + * store does not change */
> > +void semanage_setfiles(const char *path){
> > +       /* Fix the user and role portions of the context, ignore errors
> > +        * since this is not a critical operation */
> > +       selinux_restorecon(path, SELINUX_RESTORECON_SET_SPECFILE_CTX | =
SELINUX_RESTORECON_IGNORE_NOENTRY);
> > +       /* Make sure "path" is owned by root */
> > +       if(geteuid() !=3D 0 || getegid() !=3D 0)
> > +               chown(path, 0, 0);
> > +}
>
> Arguably should check stat.st_uid/gid from stat(2) of path although
> perhaps it doesn't matter.
> Need to make sure that these paths only exist in root-owned
> directories and can't be used to trigger a chown of some other
> arbitrary file to root ownership, e.g. some suid binary.
> Maybe refuse to chown() if stat.st_mode & (S_IFREG|S_ISUID) ||
> stat.st_mode & (S_IFREG|S_ISGID)?

Sorry, I munged that - should be something like S_ISREG(sb.st_mode) &&
(sb.st_mode & (S_ISUID|S_ISGID)).
Obviously still subject to races unless you do something like fd =3D
open(path, O_PATH); fstat(fd, &sb); <test sb.st_mode>; fchown(fd, 0,
0);
