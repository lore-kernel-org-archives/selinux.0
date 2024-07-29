Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C1314601E
	for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264929; cv=none; b=ZbIWZhsvXmSlllXvFha6BShVuyr7eg992FubPcBba8wPeN8FST5s9bpOCRhSpPYecQdylJIE+RmzYxd3mEXl5xMjSIW/oMDoiAb2RBPo7LYoFfw15hwsY8ca5KZR5atP4t2BZF8QvZNnBKLFVKlPHQUWyQh7k7XQik8US3+G3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264929; c=relaxed/simple;
	bh=fQA2qqzpRIKptDMHeMZKrIPsBlIn4jmgx39OvquBRMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWURqdkxcayWvYmyxHvpEI8xNKwMhpI0JaAkEwhLHzZZS8uSYR0agDaFKFHXfTW2WwAGwPl63JDJOLKjq1TyDtzOB7yBpiH5pVX2K/XRQlVwkdV4bEvk577dBCnuNMqiFLsQLnCYegPyjrW89RCdeaPEAbQykDoViiGJqu1NG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nHjyFCYU; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nHjyFCYU"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e03caab48a2so1489010276.1
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1722264927; x=1722869727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X/OriKDWFd6JERajqfzH6XLxOH1wLDjkiUA+L2CDPGA=;
        b=nHjyFCYUynuZx2eZTgvRuVoyi3vW1nIvO7UBbxp1XkZFOISGLaw8EJO90PO4Eauion
         M1RsV3BBAfvArOUy704Zdqv6QwAqSKfEJSXndkRII6+O2DzZzdBKxgu2mQon38oxab3F
         9QGtOqBYSvZhQJuiK+Mz3PfmhussDKwpwUuXPRtwg7Ke51Z3baX+GS3CIGdO2HrqE4xC
         alYQSU2JKYGLsFnbrB3dY9rrFssZ7z3cQM88i6UlYJl+It9cjLrFOV2IuR/A2QMcT71z
         jnZjBbvegaVgErYqHguP6/6BMFNCjtHksLu4lKYrx+wzjcUbYkz5I5dh1OOPHglBbsP9
         Z+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722264927; x=1722869727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/OriKDWFd6JERajqfzH6XLxOH1wLDjkiUA+L2CDPGA=;
        b=N43b3PWTiTNJiaEB6rFmG8YA5nwVPi3aBHyYYNSzPvgufNgzNA3lk6vXnzqHeNMkar
         yddhvtnZqG8hRUZP46mUGU0+oIA8Lar7hbSijMsWmFr1/K1/jdUXvtyN8NZ9n1wIJY4N
         hm1AUCReWzB5gd6e5TpYIbo+44Xxa95zzQhC4/RI+2bVTDWKM5NVOoFk4vbRHP7yXYYg
         kf1C6ObdERToFQ9sg7HUFVL7dsqhlh6jdG0PB/y52xSGQ3KNrDCYid49+g8ffpeOKiU+
         tofUw9CFDaKO3bNcS2UO0h8TUyqTDnmgJFY0w5G8CbQcYPYWvYxwOAu/c3UJl8V8h7z7
         EvHQ==
X-Gm-Message-State: AOJu0Ywy4DTEPLS+rCLIzFqlM4VIwlDeTejdAVL7UWKl0XHkAzadM6/4
	uO90Snd2tRFEP4cTMnL/LaE9TgsL04a+ejTtDEwO+eS4YdNBExc1PKKU+QJi/d1IUpDgnNPVrkb
	BYcYo9C0gzZ5S/L6DxmoGKQ2Jbeg=
X-Google-Smtp-Source: AGHT+IHDzq3qReAvURt/fY1UgzpHRu5Dz2dNkdSY+Z5UDwSeP0vkyGC4veoPlbp7mP2RyU8NQ2WIOA/M1Rr3PGDz2Sg=
X-Received: by 2002:a05:6902:20c7:b0:e0b:7023:be5c with SMTP id
 3f1490d57ef6-e0b7023cf1fmr2779626276.25.1722264927012; Mon, 29 Jul 2024
 07:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4bQZeZzLGdk0HPFPkm4uob7oHB7sygyXQo2km9BAK5Xg@mail.gmail.com>
 <20240729113247.1673713-1-vmojzis@redhat.com>
In-Reply-To: <20240729113247.1673713-1-vmojzis@redhat.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 29 Jul 2024 16:55:16 +0200
Message-ID: <CAJ2a_DfXGypY2Q3=X815ABgkLq7Pxbo=sApZJONc5DefmTiU6g@mail.gmail.com>
Subject: Re: [PATCH v5] libsemanage: Preserve file context and ownership in
 policy store
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 13:33, Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Make sure that file context (all parts) and ownership of
> files/directories in policy store does not change no matter which user
> and under which context executes policy rebuild.
>
> Fixes:
>   # semodule -B
>   # ls -lZ  /etc/selinux/targeted/contexts/files
>
> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 421397 Jul 11 09:57 file_contexts
> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 593470 Jul 11 09:57 file_contexts.bin
> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  14704 Jul 11 09:57 file_contexts.homedirs
> -rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  20289 Jul 11 09:57 file_contexts.homedirs.bin
>
>   SELinux user changed from system_u to the user used to execute semodule
>
>   # capsh --user=testuser --caps="cap_dac_override,cap_chown+eip" --addamb=cap_dac_override,cap_chown -- -c "semodule -B"
>   # ls -lZ  /etc/selinux/targeted/contexts/files
>
> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0 421397 Jul 19 09:10 file_contexts
> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0 593470 Jul 19 09:10 file_contexts.bin
> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0  14704 Jul 19 09:10 file_contexts.homedirs
> -rw-r--r--. 1 testuser testuser unconfined_u:object_r:file_context_t:s0  20289 Jul 19 09:10 file_contexts.homedirs.bin
>
>   Both file context and ownership changed -- causes remote login
>   failures and other issues in some scenarios.
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
> Changes in V5:
>  - Check return value of fchown and warn user if it fails
>
> Should I start creating github pull requests for each patch to catch this
> type of issue in the future (so that I don't waste your time)?
>
>  libsemanage/src/semanage_store.c | 32 ++++++++++++++++++++++++++++++++
>  libsemanage/src/semanage_store.h |  1 +
>  2 files changed, 33 insertions(+)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
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
> @@ -767,6 +768,7 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode,
>         if (!retval && rename(tmp, dst) == -1)
>                 return -1;
>
> +       semanage_setfiles(dst);
>  out:
>         errno = errsv;
>         return retval;
> @@ -819,6 +821,8 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
>                         goto cleanup;
>                 }
>                 umask(mask);
> +
> +               semanage_setfiles(dst);
>         }
>
>         for (i = 0; i < len; i++) {
> @@ -837,6 +841,7 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
>                                 goto cleanup;
>                         }
>                         umask(mask);
> +                       semanage_setfiles(path2);
>                 } else if (S_ISREG(sb.st_mode) && flag == 1) {
>                         mask = umask(0077);
>                         if (semanage_copy_file(path, path2, sb.st_mode,
> @@ -938,6 +943,7 @@ int semanage_mkdir(semanage_handle_t *sh, const char *path)
>
>                 }
>                 umask(mask);
> +               semanage_setfiles(path);
>         }
>         else {
>                 /* check that it really is a directory */
> @@ -1614,16 +1620,19 @@ static int semanage_validate_and_compile_fcontexts(semanage_handle_t * sh)
>                     semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC)) != 0) {
>                 goto cleanup;
>         }
> +       semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_BIN));
>
>         if (sefcontext_compile(sh,
>                     semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL)) != 0) {
>                 goto cleanup;
>         }
> +       semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL_BIN));
>
>         if (sefcontext_compile(sh,
>                     semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_HOMEDIRS)) != 0) {
>                 goto cleanup;
>         }
> +       semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_HOMEDIRS_BIN));
>
>         status = 0;
>  cleanup:
> @@ -3018,3 +3027,26 @@ int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
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
> +       selinux_restorecon(path, SELINUX_RESTORECON_SET_SPECFILE_CTX | SELINUX_RESTORECON_IGNORE_NOENTRY);
> +
> +       /* Make sure "path" is owned by root */
> +       if ((geteuid() != 0 || getegid() != 0) &&

I currently do not understand this condition.
Doesn't it check that we run *not* as root (in which case fchown(2)
will probably fail)?

> +           ((fd = open(path, O_RDONLY)) != -1)){
> +               /* Skip files with the SUID or SGID bit set -- abuse protection */
> +               if ((fstat(fd, &sb) != -1) &&
> +                   !(S_ISREG(sb.st_mode) &&
> +                     (sb.st_mode & (S_ISUID | S_ISGID))) &&
> +                   (fchown(fd, 0, 0) == -1))
> +                       fprintf(stderr, "Warning! Could not set ownership of %s to root\n", path);
> +
> +               close(fd);
> +       }
> +}
> diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
> index 1fc77da8..e21dadeb 100644
> --- a/libsemanage/src/semanage_store.h
> +++ b/libsemanage/src/semanage_store.h
> @@ -124,6 +124,7 @@ int semanage_get_cil_paths(semanage_handle_t * sh, semanage_module_info_t *modin
>  int semanage_get_active_modules(semanage_handle_t *sh,
>                                semanage_module_info_t **modinfo, int *num_modules);
>
> +void semanage_setfiles(const char *path);
>
>  /* lock file routines */
>  int semanage_get_trans_lock(semanage_handle_t * sh);
> --
> 2.43.0
>
>
