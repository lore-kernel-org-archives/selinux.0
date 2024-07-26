Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8DD18AEA
	for <selinux@vger.kernel.org>; Fri, 26 Jul 2024 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016238; cv=none; b=hbOvWpl1WhUOTOo0GXwqXPU5IpGDMqYWwjx8TTSCn0aKMp9daFTV8tJzjwftgqJPs/WQDc6FJ4IZho4mEJPoV07/ZxJyAe6iUoGeQMOGapECyg6hP8SmwxnZOb0fxgOz98T3IqIHJulVDi5wMvMimZtbvFFohkCrxPWhP+fg//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016238; c=relaxed/simple;
	bh=KT1rRksIDUVv4lQPi8nd06Tm9ILQH3rNLVuQX4DUqM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBsa3AQYxx9KIEtIp3YI1Aq/Y1WU4IZTz7HVr2J6Ux+FAZDGBhUBZNMDLVKPG2z6fXpC/C4HL9iS+bBM5DlX8GveTNcys2bd9UJussxo5ED1VRh1HfSy9nLf154IPiUwHc0x+0XPn5pQOGSuKJ0qpM97aAUFVULNR0ZrnCP9eFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duWbwLvx; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duWbwLvx"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7669d62b5bfso861665a12.1
        for <selinux@vger.kernel.org>; Fri, 26 Jul 2024 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722016236; x=1722621036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RsPVf1KhtvNdfvWw580o8ryXofRwQ1Wf8qtMbgruVQ=;
        b=duWbwLvxSKS4tizqSgft0Ywkl+AhmoyLszVnAbiBqm+s9k8KZY/pLQgMNqvk+UvU5Y
         QmRrejxba4ASRROYZO3+1NdS9X9zxWoO/1MD5yCK+fLKikMIKp4cj6++sww52DVXo8Yi
         gr2yHqmYVYY1zaR4H8pnYf70oRzNjH6Y20LDtoQOYvRRQi5R3KFzUX5AWN2PzafiVIVc
         EfsN2UTiRmLdVzgUth0X/cN3QZipOKW9N3z3JwWL8bvVKxVgVJ4xjt7AwvnZxxWaZMwB
         TbffN+w7C1rUWhne+BqUoito/ftkDjedbORZzFVqdm79W1jN7ET5gZHyqgbKpfMlJGUl
         z1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016236; x=1722621036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RsPVf1KhtvNdfvWw580o8ryXofRwQ1Wf8qtMbgruVQ=;
        b=kp2UxD8ZeA00dmKVCvteC2/MTJHzKur9/55dsaYuwpRmyHiLBrRL8XV6DqzjCvBOZC
         Hrm+jbopAx0dHIZWw6capuo8F1mmq/6WXK1vQ7E9PEiS6S4hm7FEdTdntDaKgv2je790
         1myA66nwQWxC9trJxzyPqpCa8JCGThqzqt9jsaCezKa+OYlZ/MPpgDE+yT0k8zyP+Y6v
         u/Bk0jawLjgRWkDRoYGIV+08r82ag+fIpW4pzAYSpqHbbhfhJ42gzVAzts74zPlyEPmk
         iGOQVx3bJJYcAwDSBSa843k2JUA6XuCYT13TinnlpKpYHN886oE8F/KHMavYX1ClijDA
         h+Ag==
X-Gm-Message-State: AOJu0YxfpgxE3wzT6CyvN4G//D84fmGJv1JT6G9VV9mB+MD/xm0RHp0h
	1gxoXeROJpnuZCdPNR6FNEKaZPSWlckuOGzeOFikQauhYUAnqoykNBBY24KDUu2wGHum5yVmrQb
	/WbhT/cWxsLz9nW1x0m/A3qFUmAxC/w==
X-Google-Smtp-Source: AGHT+IHfOkpKUE/wnN/yJVYYLlTd5zCRfjqlrfYTL6oU4svyo8PX6tut377bI10t70lxIKicrPnz4PXBMTUaJ2+D9+w=
X-Received: by 2002:a17:90a:4dcf:b0:2c9:784b:4a49 with SMTP id
 98e67ed59e1d1-2cf7e82fd8cmr247308a91.38.1722016235665; Fri, 26 Jul 2024
 10:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b4ec6621-dbbb-4f59-9d2e-7fd4edc6b116@redhat.com> <20240725161107.1446978-1-vmojzis@redhat.com>
In-Reply-To: <20240725161107.1446978-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 26 Jul 2024 13:50:24 -0400
Message-ID: <CAEjxPJ72F11Y2qSa4A6xaU=gdOt18u2H9OOqhZwv0RFkR0OEfg@mail.gmail.com>
Subject: Re: [PATCH v4] libsemanage: Preserve file context and ownership in
 policy store
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 12:11=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
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

With the selinux/restorecon.h fix applied first,

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsemanage/src/semanage_store.c | 31 +++++++++++++++++++++++++++++++
>  libsemanage/src/semanage_store.h |  1 +
>  2 files changed, 32 insertions(+)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_=
store.c
> index 27c5d349..95596a93 100644
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
> @@ -3018,3 +3027,25 @@ int semanage_nc_sort(semanage_handle_t * sh, const=
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
> +                     (sb.st_mode & (S_ISUID | S_ISGID))))
> +                       fchown(fd, 0, 0);
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
