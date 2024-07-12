Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C48374D3
	for <selinux@vger.kernel.org>; Fri, 12 Jul 2024 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777003; cv=none; b=t8D/ublgKUNmU6R+YOorO0t/FbXvvxiqCcsCFSIf9fnXXh3OvrELDIJ+ksAaCXBl0vX+IJysRjbTpO09VAI0qWw7aGpThWQcfQTCdLsGXjI+1XNsuOFqFCPVZllA5t85v/jkb8/3wppUExIPAfD0yLtaOJiGnaydjgb0xotFEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777003; c=relaxed/simple;
	bh=9+icTmomshVx8Lwn08WwllFmpWMyp8gJGEdnZbILj7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSJe3Pq1l8AOVUGJ7fm+kIUjqaeTT48LLB9zDuduZ6EwxxnK51w7uRRyj0km08XFsU5oRP3goJXTBJ9zW/IjlZLsZDJ8BxU7igMIUj+AsBmDX8PUZ83e1F7xI1ovXetSEDF7deS6S/rR4Sg1Owj02fxRKVuQhv4tmzQzBc6L/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BfHTjsQd; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BfHTjsQd"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e03a6c1741eso1850450276.3
        for <selinux@vger.kernel.org>; Fri, 12 Jul 2024 02:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1720777001; x=1721381801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m6Q0F2ccE1Di/nJlZAVaCDUEEEPbAYjtG5cmCaLNb04=;
        b=BfHTjsQdNrEzQIOcbY7EdSJrSILmtfM5YmHihrbOkpOsoGZX0/7nKF4ZM07gPcyJcp
         8ZzZ4JH/WA0fvSm/xFAERqKHsq2FX0T6DUB5zZX++G98Uz8EMvNeRIIFArpx8XTA0kKL
         xtB57PPbnxjxk13T2TbmKM1OuCDh5SrcHUy4GMJnYctjjh2RJKd6ln1L7wdN/ZNVsNJ4
         mKC/V1FgTO6HyrUuiHD6H3BtuLa8BfyWIajTxwuSIFIFUQml7TAK8/fGvCK5dZDrm/22
         /BN+kEEWYs8CwN0VPl7ynmxWBeu9R5sSWklyQTvvAuMKxnPQL+JFWy/edNs1aYSaNzVE
         vbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720777001; x=1721381801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6Q0F2ccE1Di/nJlZAVaCDUEEEPbAYjtG5cmCaLNb04=;
        b=souyxASAGU8jhKcIl4cYXd/Tqjj66fOJdr/X7K/E3MxdujMVAqTonztza0xio+4d7c
         6eqv0NQXDdos9jsd3JpbkG18V6onOVgQHFmeywbw33qzeXnJp67CVhRPKnWr1PoaxgF5
         SgpjapELd/3if2PFmpnywRdVaTeHnY7x7Xm1/gLKAKbNyCMRyXxnJiRI2QJk+oxtA2ds
         gQn1NKGufhxGJPIYYQSdz9I/yklZZeos4Qcr1hZmEdarDeRSLdlm7JU4UfHq8EB7Z5vV
         n7OyznjF8QbB786g4gAwzmKp2Djwq4wM1AFqDO/x11zFVGhnva+15DMPSMPqq+axU434
         7hsw==
X-Gm-Message-State: AOJu0Yw+jiPyuTcuael9Xgp553iJYps5QocN0hDqwB/U8QBGjnCgEA65
	6m1warz3GEPMxERLBOIpIn0s0CdHdCJXcJT0IJeOEkzuQvV7cr5qgnNqxMAeTRTm3Bin7Fi/OQx
	XQwkiuZXh2mwXghbs0nZQnJkcy78=
X-Google-Smtp-Source: AGHT+IFbRPvwoC32Ls/UXWz7k+SrLOSNC/B8Tv+lK+iR6kw1JzDocP/ezYAQO9xwC0SMilJDEXMlJTQ8nFv3pF/EfqA=
X-Received: by 2002:a25:9902:0:b0:e03:a248:7dd3 with SMTP id
 3f1490d57ef6-e041b061cb3mr12886385276.23.1720777001451; Fri, 12 Jul 2024
 02:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711145257.392771-1-vmojzis@redhat.com> <20240711145257.392771-2-vmojzis@redhat.com>
In-Reply-To: <20240711145257.392771-2-vmojzis@redhat.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Fri, 12 Jul 2024 11:36:30 +0200
Message-ID: <CAJ2a_Ddn+UHFLMRov25RiTo-2ffv14nRE24=SC23iA+EmUX0Kg@mail.gmail.com>
Subject: Re: [RFC PATCH] libsemanage: Do not change file context when copying files
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 16:53, Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Issue:
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
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libsemanage/src/semanage_store.c | 24 +++++++++++++++++++++++-
>  libsemanage/src/semanage_store.h |  1 +
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> index 27c5d349..694c1519 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -731,7 +731,9 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode,
>
>         if (!mode)
>                 mode = S_IRUSR | S_IWUSR;
> -
> +
> +       semanage_setfscreatecon(src);
> +
>         mask = umask(0);
>         if ((out = open(tmp, O_WRONLY | O_CREAT | O_TRUNC, mode)) == -1) {

The setfscreatecon context should be reset directly after the creating
syscall (also in the failure case), e.g. via

void semanage_reset_setfscreatecon(void) {
    int saved_errno = errno;
    setfscreatecon_raw(NULL);
    errno = saved_errno;
}

>                 umask(mask);
> @@ -812,6 +814,7 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
>         }
>
>         if (stat(dst, &sb) != 0) {
> +               semanage_setfscreatecon(src);
>                 mask = umask(0077);
>                 if (mkdir(dst, S_IRWXU) != 0) {
>                         umask(mask);
> @@ -831,6 +834,7 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
>                 snprintf(path2, sizeof(path2), "%s/%s", dst, names[i]->d_name);
>                 if (S_ISDIR(sb.st_mode)) {
>                         mask = umask(0077);
> +                       semanage_setfscreatecon(path);
>                         if (mkdir(path2, 0700) == -1 ||
>                             semanage_copy_dir_flags(path, path2, flag) == -1) {
>                                 umask(mask);
> @@ -952,6 +956,24 @@ cleanup:
>         return status;
>  }
>
> +/* Get file context of "path" and use it for the next file to be created.
> + * To be used for creating a sandbox labeled the same as the original SELinux store */
> +int semanage_setfscreatecon(const char *path)
> +{
> +       int status = 0;
> +       char *fcontext_raw = NULL;
> +
> +       if (getfilecon(path, &fcontext_raw) < 0){
> +               fcontext_raw = NULL;
> +       }
> +
> +       status = setfscreatecon_raw(fcontext_raw);
> +
> +       freecon(fcontext_raw);
> +
> +       return status;
> +}
> +
>  /********************* sandbox management routines *********************/
>
>  /* Creates a sandbox for a single client. Returns 0 if a
> diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
> index 1fc77da8..135e6ac6 100644
> --- a/libsemanage/src/semanage_store.h
> +++ b/libsemanage/src/semanage_store.h
> @@ -124,6 +124,7 @@ int semanage_get_cil_paths(semanage_handle_t * sh, semanage_module_info_t *modin
>  int semanage_get_active_modules(semanage_handle_t *sh,
>                                semanage_module_info_t **modinfo, int *num_modules);
>
> +int semanage_setfscreatecon(const char *path);
>
>  /* lock file routines */
>  int semanage_get_trans_lock(semanage_handle_t * sh);
> --
> 2.43.0
>
>
