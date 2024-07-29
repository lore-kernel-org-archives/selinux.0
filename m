Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465EF79B8E
	for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253488; cv=none; b=DLbDYzNJYAIW0eWKC5k93QcTXYqTgJ90UMfcCBBl2zJinIV+TT9lmI9aWSL8PXTK+awdyLGyPvyP/hJuSHvyXEa5tai5wLiRH8NtMgXeaRtZgOEknk5tQ2HaQ0d1Dc4KKS6cwjkea/HHadcjTRaTFB1oJapn8lBY2+y7SwWIZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253488; c=relaxed/simple;
	bh=oj8ffR7taPbXkIVUgS81jayo75TOcgu7kKOOF+tvNMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZB6h1UZZsH5K7GrL1QEjaCzForqexnOfQd8BTcer4Sv42+WL/0ZlnQXROUcLp8MRVSV6JEfh6Sw0U7XjHdp2FdsKpvcz8x6ZBIGlXeHKkvzfyVNSJRIUsaPwVIOlnIdUCSWpGFUJjH4yGmzkWBXCIjKJGr1MdOe/CKzW0GArb+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKGVe3Cb; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKGVe3Cb"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb5243766dso2343821a91.0
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 04:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722253486; x=1722858286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9653tnN66SDhE4rFx3RnwKG/EdJ79g6GwRg/xYlQjI=;
        b=FKGVe3CbEgu+xGuwZ+eqbt4Tammvqvr/bKEnz4fCXErbv2/yGKYVH6Z2iKI9jrVagL
         aJN4/Ou7R1QJARnmsbMireQ3hvWFg5E54sJezXDN7pFPozPtFoSd1SK/Vw19zPp4z318
         78BOv8E4J3EeKPXkaPn7QuZbyZvPZph5KHEgSQv4JfDK360bW2FR4Z36zm9eFqfQVk7i
         P5a6ffhRhcMgFuk28DiEy64GmnogE5stWh30jDXguo8xB+khImULORlJYBeuytWU8vNF
         B4cgr1uhLQ5INSCHlZiCW4CR4CUTe/ZiupohXCZmwM4mIZAWReTygh5cY4asttFqi607
         z7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722253486; x=1722858286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9653tnN66SDhE4rFx3RnwKG/EdJ79g6GwRg/xYlQjI=;
        b=FGlFnAUprr6YEfX4SlLD3pg+ogPsg1EQeksMhhkA3d+RLeaqTW0BsBTMxaJtSPXUz5
         EBvBgBrAnnzWyHsOgwUvVXlwZoxan6slBTBWgqUpWdaTLv7c/SezgwrLmUUodlIBEolJ
         8qlKM5fJuYTHcwQRDQOOMHMPym6rdSLQt26Bn0AeLGEyw+eBwEuGOUFkvklEYwgRiTAe
         4VMzZ5y4D2AmfqrMKDchLYPIBaSDyk2QR1suEA+WIsIhRvLN1TeNpO9ZaYiauW9gVIbx
         siN2yOX/fvnvL//dIwm3SkPGwG3vbDjH0R6diEcqpdIJjO2MmDJo6IScOAJvuHp50eKC
         jIfg==
X-Gm-Message-State: AOJu0YwC7k8aGKgwjGLXpxSjbrGEwjEiIgP5st2UeiWbHnKD4dm6jmFB
	Kk8VF3bcCjisIwtdKD82getrtQKzRbCUmVJv/+LlGQ3Hc3Y4qg/0v7eGC4IH8bCiRQLQxRyJRan
	o5HDQnvG3HQUBfP2HYDFMvYGMmnk=
X-Google-Smtp-Source: AGHT+IEK+R6Qnt98/41gyno11s8NXeisblFkCXUGLwCQPw8uWSlhsxb7OXcCPjQNKJaIiRem9g7Au4xVcm7GMz82XUU=
X-Received: by 2002:a17:90a:fb81:b0:2c9:66d3:4663 with SMTP id
 98e67ed59e1d1-2cf7e720c12mr7519188a91.43.1722253486442; Mon, 29 Jul 2024
 04:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4bQZeZzLGdk0HPFPkm4uob7oHB7sygyXQo2km9BAK5Xg@mail.gmail.com>
 <20240729113247.1673713-1-vmojzis@redhat.com>
In-Reply-To: <20240729113247.1673713-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 29 Jul 2024 07:44:34 -0400
Message-ID: <CAEjxPJ4ymgQyf2rzD4exOZ5jQ71B=1a+AVswN4+dM3=LU2RFyQ@mail.gmail.com>
Subject: Re: [PATCH v5] libsemanage: Preserve file context and ownership in
 policy store
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 7:33=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wro=
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

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> Changes in V5:
>  - Check return value of fchown and warn user if it fails
>
> Should I start creating github pull requests for each patch to catch this
> type of issue in the future (so that I don't waste your time)?

You don't need to create a PR to trigger the GitHub CI testing; just
push the change to a branch of your own fork of the selinux repo and
it will run the tests for you.

>
>  libsemanage/src/semanage_store.c | 32 ++++++++++++++++++++++++++++++++
>  libsemanage/src/semanage_store.h |  1 +
>  2 files changed, 33 insertions(+)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_=
store.c
> index 27c5d349..0ac2e5b2 100644
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
> @@ -767,6 +768,7 @@ int semanage_copy_file(const char *src, const char *d=
st, mode_t mode,
>         if (!retval && rename(tmp, dst) =3D=3D -1)
>                 return -1;
>
> +       semanage_setfiles(dst);
>  out:
>         errno =3D errsv;
>         return retval;
> @@ -819,6 +821,8 @@ static int semanage_copy_dir_flags(const char *src, c=
onst char *dst, int flag)
>                         goto cleanup;
>                 }
>                 umask(mask);
> +
> +               semanage_setfiles(dst);
>         }
>
>         for (i =3D 0; i < len; i++) {
> @@ -837,6 +841,7 @@ static int semanage_copy_dir_flags(const char *src, c=
onst char *dst, int flag)
>                                 goto cleanup;
>                         }
>                         umask(mask);
> +                       semanage_setfiles(path2);
>                 } else if (S_ISREG(sb.st_mode) && flag =3D=3D 1) {
>                         mask =3D umask(0077);
>                         if (semanage_copy_file(path, path2, sb.st_mode,
> @@ -938,6 +943,7 @@ int semanage_mkdir(semanage_handle_t *sh, const char =
*path)
>
>                 }
>                 umask(mask);
> +               semanage_setfiles(path);
>         }
>         else {
>                 /* check that it really is a directory */
> @@ -1614,16 +1620,19 @@ static int semanage_validate_and_compile_fcontext=
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
> @@ -3018,3 +3027,26 @@ int semanage_nc_sort(semanage_handle_t * sh, const=
 char *buf, size_t buf_len,
>
>         return 0;
>  }
> +
> +/* Make sure the file context and ownership of files in the policy
> + * store does not change */
> +void semanage_setfiles(const char *path){
> +       struct stat sb;
> +       int fd;
> +       /* Fix the user and role portions of the context, ignore errors
> +        * since this is not a critical operation */
> +       selinux_restorecon(path, SELINUX_RESTORECON_SET_SPECFILE_CTX | SE=
LINUX_RESTORECON_IGNORE_NOENTRY);
> +
> +       /* Make sure "path" is owned by root */
> +       if ((geteuid() !=3D 0 || getegid() !=3D 0) &&
> +           ((fd =3D open(path, O_RDONLY)) !=3D -1)){
> +               /* Skip files with the SUID or SGID bit set -- abuse prot=
ection */
> +               if ((fstat(fd, &sb) !=3D -1) &&
> +                   !(S_ISREG(sb.st_mode) &&
> +                     (sb.st_mode & (S_ISUID | S_ISGID))) &&
> +                   (fchown(fd, 0, 0) =3D=3D -1))
> +                       fprintf(stderr, "Warning! Could not set ownership=
 of %s to root\n", path);
> +
> +               close(fd);
> +       }
> +}
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
