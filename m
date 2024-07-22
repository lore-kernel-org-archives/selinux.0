Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F41EB56
	for <selinux@vger.kernel.org>; Mon, 22 Jul 2024 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661133; cv=none; b=VzwUA54H2y/rjarDKEDNdBNGf+9vkNbb3sKBq4pTieTkdRGbhy8+mrdR8LbKX+a0tah05X9vypfmAV5M7D7gTfEIqFBPQ8FAV9O+ScBWnLmrtgM9/nAf/vhVybyQFxFdGFncktLvPOJW0vvtxN2x8nch1wbneWMkH5WiIQVTTp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661133; c=relaxed/simple;
	bh=DF/M5ISRMNzntVJTncetFq9lV8qaDTU2GjPaHx+zuH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uihzaxUFXbGsG3WR+ftg7E1P2N0rRaoYHW6eKByP8CvLlu/rXiJExnvqlP8acs8qaBvRRxxGU79Rxb80OUYDhjqM7E4K8wrF6qNwF6sl5YZVdyTmhW/MWWBvdlbaCUNmuDIHrRW4ImlJ9JEynXJbMxVqqKWoGIc5UwVamFAg/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoDOXsBI; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoDOXsBI"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8036ce660e5so188495039f.1
        for <selinux@vger.kernel.org>; Mon, 22 Jul 2024 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721661131; x=1722265931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcQTfrdtRUu6jfLJDYSZYV8vAwoU/GbbPE+c4gZwvVc=;
        b=IoDOXsBIzPQx30HahrLkC+4KsL6BTnQUEbP3Vls+LowtQmYP0y1uOr7euryhTvg3Ku
         qb8K7oeh5kvEXFo33MHQCrIHrkdGgWCRX4sGOt6IbCWaexjqMmpTx2AtHctv28p1v3hp
         5DGYUrCWCWDTDwxvgaLgiRrq9SSH/LIGONAk0LotLst24AsQcWqYbMKhpPM5SYACAxa7
         XbOpjmfSfe0Dkxk4heP3G34FjSIudsuvMUvKMqC2z1H3wiQKz7+51nu3VtSiknjWAr0J
         leTMxBlCCsJX/DtcHRjGam4+SmmimxGaL7FYf59Zm+5InU3UdpTPkq5aI9dZT9ko+ZaX
         OqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721661131; x=1722265931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcQTfrdtRUu6jfLJDYSZYV8vAwoU/GbbPE+c4gZwvVc=;
        b=IjycfeJxRZfpRSCLwGnjbmufqfCutceAbuOLudl2cg0ZLuW+niFhKlSJjde7aSS91M
         CHjwEe6KXSCDrpmzq/HJmOIk16Jhjvtbz/WvcuUZvcyvw/uigBIbR79ZtGGhjz7DxN6p
         A1QH00X2ifpfzFktTGA7P6hc06pmiKete9LwX9yUafTmUwLv87jVvovsPV3iJ210d9FW
         RgB7dUDc7oK4WgnwzemDj6CAObm+uY0sgmRWOXO+xEOGKXJZJYo2/c562U8zhZdFDb3v
         iT5oJro5ef30OETVXxwZzTExmRQmje5tWJfije5cwLZjOylHDwBjqd6i+l9OXrDkZP/O
         Oq6Q==
X-Gm-Message-State: AOJu0YxbyPqGDKi/pYSTYm0r3XS6fGn8Tphuwu6/w9Fv1RGt7an4BpY+
	IUCclSaxV1And2En50dXj4NeRM68EY9el8/3y3Bg2oCJdpFtVOGV7o3qtqc76a0Fp03XtsIqW7s
	lpbKjIestuhVvdeyIxHiaV88rTvLLhw==
X-Google-Smtp-Source: AGHT+IHdMYVzZSkUeBb5QJiZF0BBALctYH9hy5aPHjv3BNnzdiRMX94sYuwzajNA69UZof0qnQFsLlMuGi18eoJp82o=
X-Received: by 2002:a05:6e02:1a88:b0:374:9916:92 with SMTP id
 e9e14a558f8ab-399403db700mr82605525ab.22.1721661130616; Mon, 22 Jul 2024
 08:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85a7faac-a590-4e3c-9c32-f446a6f5aec2@redhat.com> <20240719132918.931352-1-vmojzis@redhat.com>
In-Reply-To: <20240719132918.931352-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jul 2024 11:11:59 -0400
Message-ID: <CAEjxPJ5AgxzF=h3fCj3JS=aaNUcEWmnJU0q6jQVCmJQty==G7g@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: Preserve file context and ownership in
 policy store
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:29=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> Make sure that file context (all parts) and ownership of
> files/directories in policy store does not change no matter which user
> and under which context executes policy rebuild.
>
> Fixes:
>   # semodule -B
>   # ls -lZ  /etc/selinux/targeted/contexts/files
>
> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 421397 Ju=
l 11 09:57 file_contexts
> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 593470 Ju=
l 11 09:57 file_contexts.bin
> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  14704 Ju=
l 11 09:57 file_contexts.homedirs
> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  20289 Ju=
l 11 09:57 file_contexts.homedirs.bin
>
>   SELinux user changed from system_u to the user used to execute semodule
>
>   # capsh --user=3Dtestuser --caps=3D"cap_dac_override,cap_chown+eip" --a=
ddamb=3Dcap_dac_override,cap_chown -- -c "semodule -B"
>   # ls -lZ  /etc/selinux/targeted/contexts/files
>
> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0 4=
21397 Jul 19 09:10 file_contexts
> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0 5=
93470 Jul 19 09:10 file_contexts.bin
> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0  =
14704 Jul 19 09:10 file_contexts.homedirs
> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0  =
20289 Jul 19 09:10 file_contexts.homedirs.bin
>
>   Both file context and ownership changed -- causes remote login
>   failures and other issues in some scenarios.
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libsemanage/src/semanage_store.c | 23 ++++++++++++++++++++++-
>  libsemanage/src/semanage_store.h |  1 +
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_=
store.c
> index 27c5d349..12c30ad2 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -36,6 +36,7 @@ typedef struct dbase_policydb dbase_t;
>  #include "database_policydb.h"
>  #include "handle.h"
>
> +#include <selinux/restorecon.h>
>  #include <selinux/selinux.h>
>  #include <sepol/policydb.h>
>  #include <sepol/module.h>
> @@ -731,7 +732,7 @@ int semanage_copy_file(const char *src, const char *d=
st, mode_t mode,
>
>         if (!mode)
>                 mode =3D S_IRUSR | S_IWUSR;
> -
> +

We generally don't make unrelated whitespace changes in a patch.

>         mask =3D umask(0);
>         if ((out =3D open(tmp, O_WRONLY | O_CREAT | O_TRUNC, mode)) =3D=
=3D -1) {
>                 umask(mask);
> @@ -767,6 +768,8 @@ int semanage_copy_file(const char *src, const char *d=
st, mode_t mode,
>         if (!retval && rename(tmp, dst) =3D=3D -1)
>                 return -1;
>
> +       semanage_setfiles(dst);
> +
>  out:
>         errno =3D errsv;
>         return retval;
> @@ -819,6 +822,8 @@ static int semanage_copy_dir_flags(const char *src, c=
onst char *dst, int flag)
>                         goto cleanup;
>                 }
>                 umask(mask);
> +
> +               semanage_setfiles(dst);
>         }
>
>         for (i =3D 0; i < len; i++) {
> @@ -837,6 +842,7 @@ static int semanage_copy_dir_flags(const char *src, c=
onst char *dst, int flag)
>                                 goto cleanup;
>                         }
>                         umask(mask);
> +                       semanage_setfiles(path2);
>                 } else if (S_ISREG(sb.st_mode) && flag =3D=3D 1) {
>                         mask =3D umask(0077);
>                         if (semanage_copy_file(path, path2, sb.st_mode,
> @@ -938,6 +944,7 @@ int semanage_mkdir(semanage_handle_t *sh, const char =
*path)
>
>                 }
>                 umask(mask);
> +               semanage_setfiles(path);
>         }
>         else {
>                 /* check that it really is a directory */
> @@ -1614,16 +1621,19 @@ static int semanage_validate_and_compile_fcontext=
s(semanage_handle_t * sh)
>                     semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC))=
 !=3D 0) {
>                 goto cleanup;
>         }
> +       semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAG=
E_FC_BIN));
>
>         if (sefcontext_compile(sh,
>                     semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_L=
OCAL)) !=3D 0) {
>                 goto cleanup;
>         }
> +       semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAG=
E_FC_LOCAL_BIN));
>
>         if (sefcontext_compile(sh,
>                     semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_H=
OMEDIRS)) !=3D 0) {
>                 goto cleanup;
>         }
> +       semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAG=
E_FC_HOMEDIRS_BIN));
>
>         status =3D 0;
>  cleanup:
> @@ -3018,3 +3028,14 @@ int semanage_nc_sort(semanage_handle_t * sh, const=
 char *buf, size_t buf_len,
>
>         return 0;
>  }
> +
> +/* Make sure the file context and ownership of files in the policy
> + * store does not change */
> +void semanage_setfiles(const char *path){
> +       /* Fix the user and role portions of the context, ignore errors
> +        * since this is not a critical operation */
> +       selinux_restorecon(path, SELINUX_RESTORECON_SET_SPECFILE_CTX | SE=
LINUX_RESTORECON_IGNORE_NOENTRY);
> +       /* Make sure "path" is owned by root */
> +       if(geteuid() !=3D 0 || getegid() !=3D 0)
> +               chown(path, 0, 0);
> +}

Arguably should check stat.st_uid/gid from stat(2) of path although
perhaps it doesn't matter.
Need to make sure that these paths only exist in root-owned
directories and can't be used to trigger a chown of some other
arbitrary file to root ownership, e.g. some suid binary.
Maybe refuse to chown() if stat.st_mode & (S_IFREG|S_ISUID) ||
stat.st_mode & (S_IFREG|S_ISGID)?

> diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_=
store.h
> index 1fc77da8..e21dadeb 100644
> --- a/libsemanage/src/semanage_store.h
> +++ b/libsemanage/src/semanage_store.h
> @@ -124,6 +124,7 @@ int semanage_get_cil_paths(semanage_handle_t * sh, se=
manage_module_info_t *modin
>  int semanage_get_active_modules(semanage_handle_t *sh,
>                                semanage_module_info_t **modinfo, int *num=
_modules);
>
> +void semanage_setfiles(const char *path);
>
>  /* lock file routines */
>  int semanage_get_trans_lock(semanage_handle_t * sh);
> --
> 2.43.0
>
>
