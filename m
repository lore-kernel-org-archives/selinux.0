Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997E238D35
	for <selinux@vger.kernel.org>; Mon, 17 Feb 2025 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739825938; cv=none; b=KPCgQTbFYMJrDiaJ5jiTwDcw06z95SbxxRWyvoi89wKf9lM5l5VzRrCJWvimmUYWATAvFCfV6hMW7XZ4j+sBb6vSAQ5P4it0+H6mXyuDkuhcSyJawy29MTk6Mb5r5gKnamt2Qe6Q9CA3kmiosEF0YAf1yHldfvCjc3MiZhJHX3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739825938; c=relaxed/simple;
	bh=INKXXKoF6Yj8bsCamBMwfIiLf36z6W1erkBsvTvCPgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqTxEFDWnn8isq7GRk/TK8tPPMVMtOcBpE8/o+FGKl9jeyxEBQnklUQvtOhfM1Mq+zjlHWTokBKqLOQhKGi1cHZEFek0T5Iz2QdrJxX2k6RliGyDERX0FMRE7XJEV7yjApoiFPmzEnUiMSiXRz0nb3IxLTv3rWitUV5LGXV+szA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Dx/5Dwd7; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Dx/5Dwd7"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so3419406276.3
        for <selinux@vger.kernel.org>; Mon, 17 Feb 2025 12:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1739825935; x=1740430735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1wWjpA6BK3V16yEWZEy5Y7jMSrgpcbwqff+bNgsU++8=;
        b=Dx/5Dwd7Yqo1zsxdAlic7Ejux0DIE3oJCUa+5AZ+0BfYzAKF0Sx5XZaQH8H+7V5xdM
         x7psvxYsN5GRay/oQZ9pNydJOuJBfGE/goUdP9vUvDjkIMsQrIrITV7iOIfU8mGaWBVY
         +04vDUZOCDTQn9dzovdobR4QfcxsEqHqLuSqmJB0DFNn6nLHP2zPV+XGlsMZDk9yH90x
         zs1yH3X65zjWSpjdb4BCcvBrLuSnJFWXz9Q0Z27m9P0pkkNr/d84niTMJHAidiVfKsrx
         xt3WDAaCKW1lG0qFOQrckJwZkz65+iskgSnHwG6dNRtLRVE8QL5DeQOWvVT12Zfc557c
         hyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739825935; x=1740430735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wWjpA6BK3V16yEWZEy5Y7jMSrgpcbwqff+bNgsU++8=;
        b=ogTKe7tJYRsi6y7qIlmZSW4m4ATPdWk948NtAAPIcqjPXeoEVFywn/za91IJ6vI6OV
         km6U5hCsVpxFziHPsc37AFK7hHkgk9RuehoOw5uLZ5kHPZhfZuD+dHw1lFu4rXza++uA
         tbqPAHF8xXTtj+2rf7kRTIDSXuVJCddx6/JKwTfaQrmtW4SDCXTjw8t8lgFQfouNBmPG
         Kb6re2lYPt96fGQRa27LyuFyh3L2PocFBZykNFvCShlV7diRXNHdWnrATx7rIOtQog5E
         gOkeXLb6F6lbY70W4MTl7Fm0ZFDN8zng9j4qO92MnT56U1EaIrjRxMKfifRVj0PvtSEI
         Od4Q==
X-Gm-Message-State: AOJu0YzT9ZgpS7UCy2lQNLuB3+/4i9EhnnpFq+ZzjRqZLA9VFRM3ge4o
	Y8OQLnCEH+NwHaz2m3FanyaMGiEyGzzGz7CPYYcH+4tcrROgoOJAMvNFry6vmyfww1sNZ/3iRXj
	XKWfG9E16dre0WNC1YJMdbA5hybA=
X-Gm-Gg: ASbGnctSG0d39YTAWzHBGa+USQRqczgTMW3fKQ+FoW5HPLLBvCGlYTLpEku5Jj6vndx
	CuEbneldpzWE62YKF+Clqi/c34FxbD4J9nU6BN7xWS5L8vLBKLnEbERSn24Ltchle7QYEGr9R9g
	==
X-Google-Smtp-Source: AGHT+IEVQl4hsluKquNKVRKtncEEhkuFzwngNhZW8IjiaHTM9uQLLshF0bmJIHk1k8OOZtlEoUniAbOIiNtI97nO7H8=
X-Received: by 2002:a05:6902:108e:b0:e58:37c9:b66a with SMTP id
 3f1490d57ef6-e5dc906aa14mr9894404276.27.1739825935579; Mon, 17 Feb 2025
 12:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211182159.37744-1-kippndavis.work@gmx.com>
In-Reply-To: <20250211182159.37744-1-kippndavis.work@gmx.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 17 Feb 2025 21:58:43 +0100
X-Gm-Features: AWEUYZlJjeYsFGS0iad1aKzDADnCeSTEmDUF-Vuk9ozB7UOGJp82pxAf-yUu6sY
Message-ID: <CAJ2a_DdXpShgNYUgO6XRTPV=sKVC6+po6ZebHSVS5p3MNAx7ng@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: add permission checks for loading other kinds
 of kernel files
To: kippndavis.work@gmx.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 19:22, <kippndavis.work@gmx.com> wrote:
>
> From: "Kipp N. Davis" <kippndavis.work@gmx.com>
>
> Although the LSM hooks for loading kernel modules were later generalized
> to cover loading other kinds of files, SELinux didn't implement
> corresponding permission checks, leaving only the module case covered.
> Define and add new permission checks for these other cases.
>
> Signed-off-by: Cameron K. Williams <ckwilliams.work@gmail.com>
> Signed-off-by: Kipp N. Davis <kippndavis.work@gmx.com>
>
> ---
> Changes in v2:
>   - Removed the `-EACCES` return in default case in
>     selinux_kernel_read_file() and selinux_kernel_load_from_file(),
>     reverting previous fallback behavior.
>   - Added a compile-time check in these functions to catch new
>     READING/LOADING_XXX entries.
>
> Thanks for your review! I've adjusted the default case so as to not
> return an error and depart from pre-existing logic. I first tried to use
> the pre-processor #errors but failed with the READING/LOADING_MAX_ID
> enums, so I opted for BUILD_BUG_ON_MSG as a compile-time check with
> those same enums instead to catch new entries.
> ---
>  security/selinux/hooks.c            | 56 +++++++++++++++++++++++------
>  security/selinux/include/classmap.h |  4 ++-
>  2 files changed, 49 insertions(+), 11 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7b867dfec88b..67bf37693cd7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4096,7 +4096,7 @@ static int selinux_kernel_module_request(char *kmod_name)
>                             SYSTEM__MODULE_REQUEST, &ad);
>  }
>
> -static int selinux_kernel_module_from_file(struct file *file)
> +static int selinux_kernel_load_from_file(struct file *file, u32 requested)
>  {
>         struct common_audit_data ad;
>         struct inode_security_struct *isec;
> @@ -4104,12 +4104,9 @@ static int selinux_kernel_module_from_file(struct file *file)
>         u32 sid = current_sid();
>         int rc;
>
> -       /* init_module */
>         if (file == NULL)
>                 return avc_has_perm(sid, sid, SECCLASS_SYSTEM,
> -                                       SYSTEM__MODULE_LOAD, NULL);
> -
> -       /* finit_module */
> +                                       requested, NULL);
>
>         ad.type = LSM_AUDIT_DATA_FILE;
>         ad.u.file = file;
> @@ -4123,7 +4120,7 @@ static int selinux_kernel_module_from_file(struct file *file)
>
>         isec = inode_security(file_inode(file));
>         return avc_has_perm(sid, isec->sid, SECCLASS_SYSTEM,
> -                               SYSTEM__MODULE_LOAD, &ad);
> +                               requested, &ad);
>  }
>
>  static int selinux_kernel_read_file(struct file *file,
> @@ -4131,10 +4128,32 @@ static int selinux_kernel_read_file(struct file *file,
>                                     bool contents)
>  {
>         int rc = 0;
> -
> +       BUILD_BUG_ON_MSG(READING_MAX_ID > 7,
> +                 "New kernel_read_file_id introduced; update SELinux!");
>         switch (id) {

Should READING_UNKNOWN be handled?
It seems not to be used currently in-tree, but maybe stay on the safe side?

> +       case READING_FIRMWARE:
> +               rc = selinux_kernel_load_from_file(contents ? file : NULL,
> +                               SYSTEM__FIRMWARE_LOAD);
> +               break;
>         case READING_MODULE:
> -               rc = selinux_kernel_module_from_file(contents ? file : NULL);
> +               rc = selinux_kernel_load_from_file(contents ? file : NULL,
> +                               SYSTEM__MODULE_LOAD);
> +               break;
> +       case READING_KEXEC_IMAGE:
> +               rc = selinux_kernel_load_from_file(contents ? file : NULL,
> +                               SYSTEM__KEXEC_IMAGE_LOAD);
> +               break;
> +       case READING_KEXEC_INITRAMFS:
> +               rc = selinux_kernel_load_from_file(contents ? file : NULL,
> +                               SYSTEM__KEXEC_INITRAMFS_LOAD);
> +               break;
> +       case READING_POLICY:
> +               rc = selinux_kernel_load_from_file(contents ? file : NULL,
> +                               SYSTEM__POLICY_LOAD);
> +               break;
> +       case READING_X509_CERTIFICATE:
> +               rc = selinux_kernel_load_from_file(contents ? file : NULL,
> +                               SYSTEM__X509_CERTIFICATE_LOAD);
>                 break;
>         default:
>                 break;
> @@ -4146,10 +4165,27 @@ static int selinux_kernel_read_file(struct file *file,
>  static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
>  {
>         int rc = 0;
> -
> +       BUILD_BUG_ON_MSG(LOADING_MAX_ID > 7,
> +        "New kernel_load_data_id introduced; update SELinux!");
>         switch (id) {

dito

> +       case LOADING_FIRMWARE:
> +               rc = selinux_kernel_load_from_file(NULL, SYSTEM__FIRMWARE_LOAD);
> +               break;
>         case LOADING_MODULE:
> -               rc = selinux_kernel_module_from_file(NULL);
> +               rc = selinux_kernel_load_from_file(NULL, SYSTEM__MODULE_LOAD);
> +               break;
> +       case LOADING_KEXEC_IMAGE:
> +               rc = selinux_kernel_load_from_file(NULL, SYSTEM__KEXEC_IMAGE_LOAD);
> +               break;
> +       case LOADING_KEXEC_INITRAMFS:
> +               rc = selinux_kernel_load_from_file(NULL, SYSTEM__KEXEC_INITRAMFS_LOAD);
> +               break;
> +       case LOADING_POLICY:
> +               rc = selinux_kernel_load_from_file(NULL, SYSTEM__POLICY_LOAD);
> +               break;
> +       case LOADING_X509_CERTIFICATE:
> +               rc = selinux_kernel_load_from_file(NULL,
> +                               SYSTEM__X509_CERTIFICATE_LOAD);
>                 break;
>         default:
>                 break;
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 03e82477dce9..cfac41d12f7d 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -63,7 +63,9 @@ const struct security_class_mapping secclass_map[] = {
>         { "process2", { "nnp_transition", "nosuid_transition", NULL } },
>         { "system",
>           { "ipc_info", "syslog_read", "syslog_mod", "syslog_console",
> -           "module_request", "module_load", NULL } },
> +           "module_request", "module_load", "firmware_load",
> +           "kexec_image_load", "kexec_initramfs_load", "policy_load",

In the SELinux world the word "policy" refers mostly to the SELinux policy.
Maybe rename the permission verb "policy_load" to
"security_policy_load" or similar? (it seems to be used by IMA,
loadpin and zram currently)

> +           "x509_certificate_load", NULL } },
>         { "capability", { COMMON_CAP_PERMS, NULL } },
>         { "filesystem",
>           { "mount", "remount", "unmount", "getattr", "relabelfrom",
> --
> 2.48.1
>
>
