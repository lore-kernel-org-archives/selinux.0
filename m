Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100922089
	for <selinux@vger.kernel.org>; Thu, 25 Jul 2024 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909319; cv=none; b=uis6j+dnmu/h4FpcX9jMobVdC1VLxceQQGCNRU8AcQRcfXQGzljh65Ska6MJHPgJ0MA+LEBZOcyMUT8s6f24SnWK17YmrygMAjBZ3qQEeX2ekVKXeBBwFNzhhFzfnkNWOFdFKAKP1x42/OFSq0T1auvC91WYzJ0pdVJcCDc8KPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909319; c=relaxed/simple;
	bh=nSbokG/TvqTfeJT+ZnZiPqw1ONLsvjMZmLGjmOW27iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFrx6MnL/hzVTO/BIlgHC6M4EUZ1XykPjhBflV8k6Q4nm5NKUSfhExafrWJRAl5BTlIPuOJC0w2Raz2hEOjf6kdJTPw0309EwpqgSb0d5VditecjceRaMfHNfjdQ7hxS7uFdRsl7lzPgb1eq0KNkD6xHMOfg2N0HdBgUJR7Syp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BM6L+LtQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM6L+LtQ"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a263f6439eso517422a12.3
        for <selinux@vger.kernel.org>; Thu, 25 Jul 2024 05:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721909317; x=1722514117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYbHawX+rRUSoJNJKTl3zV8B3z3UBOiQyXDQ8RjJ1T0=;
        b=BM6L+LtQWo/DRHq6tX6rXPd8BnIv0mGdjePB73nQ0Fx9NoDhuOVGlTQYpFh+1k0V7v
         fhvpzcyRPrY5msqslk5wClPb8oHcrihifImilGdBIFJx6kOnlMQfsKn+MpXVezHc29F+
         siPcd7cZ0D6tWp1PYxvmmepFaKbqcy7lIX/hhwkFM7gOmz2LdGp3LYSK3fgMz4v1pUvl
         Fh0nnSu3iKNlSty0KuiJghz5wnNQAKshnAUFHwQHgQ3apdQSkjUF0xN6aldM23SrXJcM
         SWTURUoDKR5aRX7uSiL92a+UvgB0iYAOPZy3CgLl9p6Tw3qLyycRkQmFP52ewMPcvUAT
         sQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721909317; x=1722514117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYbHawX+rRUSoJNJKTl3zV8B3z3UBOiQyXDQ8RjJ1T0=;
        b=e7ud0LcMt3FC+xs6y+ABv6x6CP+fNttzTWbyXWuXsRzVn53Lbl5XiSJXoL3mEQyifi
         VRZYOpJ+4WvQEUi4oqU16nz1C44eOqeEuA7BxQX4fIv7iln7DtnumiZ2hL9xS+0we5J2
         hu+W18cQU4QWyWMgIvKekKec4puNoiWSfdGzKOzPxyGD7OsIm5sEv/dZFpqtaMjxDQbZ
         iv2z4wRL63mpSjW7o1b3ocUHMSThV/tyg7VkyKwfEapQm1fzop1Wzf3gn3Y9k+mCpYTp
         VI+eqlgcNAj03MfH3D7slz2MmHne22VcynXLw7YQqdoaHZArmtLfQ0chmGRiRPClBUES
         kRSQ==
X-Gm-Message-State: AOJu0Yz27eLEV1iSWYUjZsp6WwATpHRO6zux+Ya2vC92Ej3Btgjoqisq
	sRVKRnW65DqkN9nIIDUmeFbVEKORn7Cp6tLCoYu4ss/tP73jfFhi03j3eaVkLy1OrHtOsY/UH1v
	mEowl07FToild/oEmO1QaAkiAV5pSyA==
X-Google-Smtp-Source: AGHT+IFOe49SqNoRNdkwGnoUuaNei6gtBHif6N5YCzk7Y0ggmccB5kQO1PWwYZ6EqdOFpAasr/oYTRBreF5ORUxM4UI=
X-Received: by 2002:a17:90b:1c05:b0:2cd:4b37:a965 with SMTP id
 98e67ed59e1d1-2cf2e9b247amr1752795a91.1.1721909316856; Thu, 25 Jul 2024
 05:08:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa2d6136-20b7-4d05-bde1-499849450d54@redhat.com> <20240723125850.1228121-1-vmojzis@redhat.com>
In-Reply-To: <20240723125850.1228121-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 25 Jul 2024 08:08:25 -0400
Message-ID: <CAEjxPJ4ERdnWi-PwEEzLMm7QkyWdZHj6T62ims5bYgS=U=s78w@mail.gmail.com>
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

I think you meant to wrap the body of the above if statement with { }
so that the chown() only executes if geteuid() !=3D 0 or getegid() !=3D 0
too.
Yes?
This isn't Python ;)

> +}
