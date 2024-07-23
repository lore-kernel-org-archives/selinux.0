Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34B155C90
	for <selinux@vger.kernel.org>; Tue, 23 Jul 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746583; cv=none; b=bwB6thy/YUkzXvVSBF01ukSM08O7d08fL96+nNmdhpyjlWVjYj8P8NxKMoctuIN2k9Oy5r2e/SXJH0nBgrYM58hdcKjvSl8BXbTTE8z7EJFCZBOvRuWIJGC8DbqU6Nh6DKn2SOL94GrBl0vz+01uTz4eOez/feM/r3iEHSZbBn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746583; c=relaxed/simple;
	bh=PAHR66ENP9eFh2iZoStdeMbeyNLnPVfKRq3QeT8C4Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVXfrTmww3V/66PzX+Q8z4DN/tFZuaV7AUuPyvl4SuCalpXQeNaf5GlGcFOjp65HLBfuF92x4cfqTr9QughYkwMiSazIZ7FnUgyBxmswZfeEfEcQ1YR7Lo1xHs+fvhcsYQogHuQz3zgLRsIrQXPk7Eyheq53xoIjazf/fZatLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrSaQ4JS; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrSaQ4JS"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a2123e9ad5so648838a12.1
        for <selinux@vger.kernel.org>; Tue, 23 Jul 2024 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721746581; x=1722351381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mA/MxWCRd2yhIRG+cEPmBmdGGLIn5lTTheWq5KcIJmo=;
        b=VrSaQ4JSzTR9XJc+fXUgISO6KiDRRNENiEPa1dZC0CYYI5FhHgIJN6A8TATtukWK7n
         1Ar22ZN+yTVxyk1fqTu8dBNC1pjXZZ8/OA+/Yfq5F56FxEYNWjGCWxN+BbZHmF0krAOg
         e+ZA0/rxH9xpWgWJ0bathARj8Lqg7LumKhDUJy9kEmKY08RAPrC4RDHd5cLisIrBxAAg
         JIR7kcrqavI295YFAseJQJ1BYrr/4QaQCLT7Agui0rxwuwVej1YJaxrMoRx8oqPL6y0s
         z2BiQGjcuvPScfRO3Prsj9sThexpIdCIdbUppoQcMCKK2+txH1kpQruv9sjVB1UE+ofO
         8PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721746581; x=1722351381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mA/MxWCRd2yhIRG+cEPmBmdGGLIn5lTTheWq5KcIJmo=;
        b=mr+cWfKGuq4W7pCVoktjmUcgrMXUBYYX+V9zBmqJN+SK8juOfhIuENClAkWL3ZQxJ2
         fnl6yziEt0g3gU6xcAgNrQGbYvC/WlNbuYWAiCgn5rfQRpgrlxM19BvTVD7P2tNY1hao
         KFIBADGGNrtOKC/mwRtXxPNw3hkKKDfm1DnUUX4YasP/XCOByLLumIBbXAPI1rjWQ4jm
         zX5JPP3MmMuFbvbob+NhXmOXyb61nqfkwfRDq7GA9hzXRsQ4nxy6QlfqNT1aBKGziqhp
         9RYzvC0hj2D7+pxhom9H5polfEwg3TBg2ctlUp/j0efW1NvadsCaEe7ZhfJ7gmawgmL7
         lCjg==
X-Gm-Message-State: AOJu0YzYzjiHxxtgas2foBp+o2HGxI1cLRRXjtL9JcXTbhZfx6fyShvv
	lWC68l3njydJ/Rpv+ezdVEZ1hHwj/bpGTG0xuHJup4iqoPL+ypaFZBYOrAaEdA9wtEPei1ghpkt
	T6huFJs8vydpGZRn+UOLkqaq5QXg=
X-Google-Smtp-Source: AGHT+IFgAbkIAECoAwSNRdRcgMI5bzFksJcrWlSLwVHTcOgER4QJ0wzjyCJma2Xk7c/yZq6Y4CBoSQxnKBtW8hpW2M0=
X-Received: by 2002:a17:90a:b112:b0:2cd:40cf:5ebd with SMTP id
 98e67ed59e1d1-2cd8cd2036bmr3876363a91.5.1721746581197; Tue, 23 Jul 2024
 07:56:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa2d6136-20b7-4d05-bde1-499849450d54@redhat.com> <20240723125850.1228121-1-vmojzis@redhat.com>
In-Reply-To: <20240723125850.1228121-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jul 2024 10:56:09 -0400
Message-ID: <CAEjxPJ7QLHNE1MJ1xj7Fprq6BPdfEAcC5P5711xJ7Ljp+aeFsQ@mail.gmail.com>
Subject: Re: [PATCH v3] libsemanage: Preserve file context and ownership in
 policy store
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 9:09=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wro=
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

> @@ -3018,3 +3028,21 @@ int semanage_nc_sort(semanage_handle_t * sh, const=
 char *buf, size_t buf_len,
>
>         return 0;
>  }
> +
> +/* Make sure the file context and ownership of files in the policy
> + * store does not change */
> +void semanage_setfiles(const char *path){
> +       struct stat sb;
> +
> +       /* Fix the user and role portions of the context, ignore errors
> +        * since this is not a critical operation */
> +       selinux_restorecon(path, SELINUX_RESTORECON_SET_SPECFILE_CTX | SE=
LINUX_RESTORECON_IGNORE_NOENTRY);
> +
> +       /* Make sure "path" is owned by root */
> +       if (geteuid() !=3D 0 || getegid() !=3D 0)
> +               /* Skip files with the SUID or SGID bit set -- abuse prot=
ection */
> +               if ((stat(path, &sb) =3D=3D -1) ||
> +                   (S_ISREG(sb.st_mode) && (sb.st_mode & (S_ISUID | S_IS=
GID))))
> +                               return;
> +               chown(path, 0, 0);
> +}

Did you consider the fd =3D open(path, O_PATH); fstat(fd, &sb); ...
fchown(fd, 0, 0); pattern to avoid a race between the check and chown
(e.g. link changed from one file to another in between)?
