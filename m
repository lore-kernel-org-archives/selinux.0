Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5413214
	for <selinux@vger.kernel.org>; Mon,  7 Jul 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906456; cv=none; b=H9dexyVgKzHw0xpQdhKzxqmL9MflQOTyu8z1QRlCcuAmbE+bidI11L833ISiBp1xR2nACJ+jVqFn8SeZmF2of24SZdQE+Mnh7pMeZ85VKOo3g1qUpFKIOWEnYEHvxtZ9cyvGmpm0OW/kCptQmi4ERHo+pWlfa9VZN3nHq2HXalk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906456; c=relaxed/simple;
	bh=OXSkbx0Q52JylQbUKJIpzk0wHJgdj1gJLoKAdmmIQ7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdbcdiqLvknczrrL9WFWOnEJ/fjE61M7aJOgoqt5SmoVv/n/iHK5yzcw4CDk54mVNEgUoN82/sDZVfSRKAk8kaoOIoIpfIiiHYGDGWdhODZopFpP/fa3bMMK0UNzKua67+VZtjRQWSPXLteIUKNKSOyJOTmWTDz3qAKhGTalBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXJEKPBQ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXJEKPBQ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313a001d781so2741071a91.3
        for <selinux@vger.kernel.org>; Mon, 07 Jul 2025 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751906454; x=1752511254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZ1nVspLzJGTVpIFbfrvE6bgiLLtU5bDt//S4QESNp0=;
        b=OXJEKPBQyUcjq/x9KQ8S/4dnnj5BSRW4E0+Q8puM61R2MYqOAV7/wBhBClPDqVw/p9
         uB9a/JBkYLof6G79VrL0AqFDIzELvg4BcgVk9vQ5ISy/5DGE7W6b/QWPOcefGCDCYqs3
         mfIfYMWJ4TgaLWTr26GD7qovNHkF/q3gzCoQVuRRjSxWKO5XZqjaCmjclwvOwmecRlbB
         ChjXr0m05UAf633wAZVYCpmpWYQEl/pXmEDVOWZC2DBllvfPft3+UWrGotLJsLGnUmKQ
         J5x94YcmfQIAS3y38D3895udmvmOjl2S4Cla55PqkHk+fuwU9V9Jzl8pI4WdFrj4Whnr
         Ur9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906454; x=1752511254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZ1nVspLzJGTVpIFbfrvE6bgiLLtU5bDt//S4QESNp0=;
        b=ZLxt/2yhrT0ZVTL6sx5M+k///x4M0YTVRlTYmroMcjjf5ZIilqt0YGjPUSfmTRtMgw
         eDQnm+2kTHp508js4mjZ0EV5kPhQDmbo99EZdFNpGKXNxA/lCPbDki9oINb7531FqoPz
         6FdlsgrWeYrJcUxJ+WKONS/SgU6FJEZWhRrWnCgkZrArxe97TurJbFNriJax0cjHhSOl
         B1wz5L4ruIiyvhF6YEo3ohcmam0XrIR8i+LN50WgHOJmOjCkM2KXpaw5JJdgwOcZ/kOJ
         eIUIxmhoK40jI1bjzCaBQljBRZo4UOfkYgUjtMDrSrRQdwOai7uz9fFV24FH0a+M3kqM
         b78w==
X-Gm-Message-State: AOJu0Yy70N3G0N7OBgahYQU33lJMyks2zKlJntYZhSQMG6U1KrdoqWYF
	QZ/GWGdfzBh0BIo1jwDqviDWNYQPcV5Mwsga/c5Mly+9JukB7YAS5YePfMuSL+0xQluOE78W+Qb
	XiBgFnIAlQ8qL25lKIVqto8MmglwSsvq/N+Qe
X-Gm-Gg: ASbGncuoymvg199IuahfaO8HRIKx1pdGVgcimyXXp9+1T0gxFZ3yhjpDlngirb852lm
	7I3Pp4gv6Wt1HGNV5TUExgt6NYBHqRlGz6+TwURMOA6rvwF/HNUZfjvnxbccqc8K+whggtZLIWN
	edtflxZMeOK9hPFsoNR085qyu8Kv8L2HSAbGrK3jTUk4k=
X-Google-Smtp-Source: AGHT+IHNDNCBayrS/IUqjngB4yEnQN16pY+Ddi81QNUZiPaWi2gaZ5W/IsoMIYD2zz0fHp9eFtZFqhyrb6byFPBW/as=
X-Received: by 2002:a17:90b:5488:b0:311:2f5:6b1 with SMTP id
 98e67ed59e1d1-31aac4b9fd4mr14597631a91.22.1751906453972; Mon, 07 Jul 2025
 09:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705121424.1221268-1-omosnace@redhat.com> <20250705121424.1221268-4-omosnace@redhat.com>
In-Reply-To: <20250705121424.1221268-4-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 7 Jul 2025 12:40:41 -0400
X-Gm-Features: Ac12FXxhL1gwEfmTNM-O6ctEd6XHC_SZ0rPxbHKnyDiqx1q7jSvN_R4WVM8JcAg
Message-ID: <CAEjxPJ7KwOXYV=Od3a9BE1VRSs3t=05Pwr4d2YUqXobvVSQ75Q@mail.gmail.com>
Subject: Re: [PATCH testsuite 3/6] policy/test_file_load.te: adjust to kexec
 behavior on aarch64
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 5, 2025 at 8:15=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> On aarch64, kexec writes the image into a temporary file and loads that.
> Adjust the policy such that it is able to create it and load it as the
> kernel/initramfs image.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policy/test_file_load.te | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/policy/test_file_load.te b/policy/test_file_load.te
> index 2e3f71d..5e5c85c 100644
> --- a/policy/test_file_load.te
> +++ b/policy/test_file_load.te
> @@ -7,9 +7,19 @@ require {
>      type user_tmp_t;
>  }
>
> +attribute testkexecdomain;
> +
> +type test_kexec_tmp_file_t;
> +files_tmp_file(test_kexec_tmp_file_t)
> +
> +files_rw_generic_tmp_dir(testkexecdomain)
> +files_tmp_filetrans(testkexecdomain, test_kexec_tmp_file_t, file)
> +manage_files_pattern(testkexecdomain, test_kexec_tmp_file_t, test_kexec_=
tmp_file_t)
> +
>  ###################### Allow sys kexec_image_load ######################
>  type test_kexec_allow_kexec_image_load_t;
>  testsuite_domain_type(test_kexec_allow_kexec_image_load_t)
> +typeattribute test_kexec_allow_kexec_image_load_t testkexecdomain;
>
>  files_search_boot(test_kexec_allow_kexec_image_load_t)
>  fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_image_load_t)
> @@ -17,12 +27,12 @@ exec_files_pattern(test_kexec_allow_kexec_image_load_=
t, kdump_exec_t, kdump_exec
>  domain_entry_file(test_kexec_allow_kexec_image_load_t, kdump_exec_t)
>  allow test_kexec_allow_kexec_image_load_t self:capability sys_boot;
>
> -allow test_kexec_allow_kexec_image_load_t boot_t:system  kexec_image_loa=
d;
> -allow test_kexec_allow_kexec_image_load_t tmpfs_t:system kexec_image_loa=
d;
> +allow test_kexec_allow_kexec_image_load_t { boot_t tmpfs_t test_kexec_tm=
p_file_t }:system kexec_image_load;
>
>  ###################### Deny sys kexec_image_load ######################
>  type test_kexec_deny_kexec_image_load_t;
>  testsuite_domain_type(test_kexec_deny_kexec_image_load_t)
> +typeattribute test_kexec_deny_kexec_image_load_t testkexecdomain;
>
>  files_search_boot(test_kexec_deny_kexec_image_load_t)
>  fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_image_load_t)
> @@ -30,34 +40,32 @@ exec_files_pattern(test_kexec_deny_kexec_image_load_t=
, kdump_exec_t, kdump_exec_
>  domain_entry_file(test_kexec_deny_kexec_image_load_t, kdump_exec_t)
>  allow test_kexec_deny_kexec_image_load_t self:capability sys_boot;
>
> -neverallow test_kexec_deny_kexec_image_load_t boot_t:system  kexec_image=
_load;
> -neverallow test_kexec_deny_kexec_image_load_t tmpfs_t:system kexec_image=
_load;
> +neverallow test_kexec_deny_kexec_image_load_t { boot_t tmpfs_t test_kexe=
c_tmp_file_t }:system kexec_image_load;
>
>  ###################### Allow sys kexec_initramfs_load ##################=
####
>  type test_kexec_allow_kexec_initramfs_load_t;
>  testsuite_domain_type(test_kexec_allow_kexec_initramfs_load_t)
> +typeattribute test_kexec_allow_kexec_initramfs_load_t testkexecdomain;
>
>  files_search_boot(test_kexec_allow_kexec_initramfs_load_t)
>  fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_initramfs_load_t)
>  domain_entry_file(test_kexec_allow_kexec_initramfs_load_t, kdump_exec_t)
>  allow test_kexec_allow_kexec_initramfs_load_t  self:capability sys_boot;
>
> -allow test_kexec_allow_kexec_initramfs_load_t  boot_t:system  { kexec_im=
age_load kexec_initramfs_load } ;
> -allow test_kexec_allow_kexec_initramfs_load_t  tmpfs_t:system { kexec_im=
age_load kexec_initramfs_load };
> +allow test_kexec_allow_kexec_initramfs_load_t { boot_t tmpfs_t test_kexe=
c_tmp_file_t }:system { kexec_image_load kexec_initramfs_load };
>
>  ###################### Deny sys kexec_initramfs_load ###################=
###
>  type test_kexec_deny_kexec_initramfs_load_t;
>  testsuite_domain_type(test_kexec_deny_kexec_initramfs_load_t)
> +typeattribute test_kexec_deny_kexec_initramfs_load_t testkexecdomain;
>
>  files_search_boot(test_kexec_deny_kexec_initramfs_load_t)
>  fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_initramfs_load_t)
>  domain_entry_file(test_kexec_deny_kexec_initramfs_load_t, kdump_exec_t)
> -allow test_kexec_deny_kexec_initramfs_load_t boot_t:system  kexec_image_=
load;
> -allow test_kexec_deny_kexec_initramfs_load_t tmpfs_t:system kexec_image_=
load;
> +allow test_kexec_deny_kexec_initramfs_load_t { boot_t tmpfs_t test_kexec=
_tmp_file_t }:system kexec_image_load;
>  allow test_kexec_deny_kexec_initramfs_load_t self:capability sys_boot;
>
> -neverallow test_kexec_deny_kexec_initramfs_load_t boot_t:system  kexec_i=
nitramfs_load;
> -neverallow test_kexec_deny_kexec_initramfs_load_t tmpfs_t:system kexec_i=
nitramfs_load;
> +neverallow test_kexec_deny_kexec_initramfs_load_t { boot_t tmpfs_t test_=
kexec_tmp_file_t }:system kexec_initramfs_load;
>
>  ###################### Allow sys firmware_load ######################
>  type test_kmodule_allow_firmware_load_t;
> --
> 2.50.0
>
>
