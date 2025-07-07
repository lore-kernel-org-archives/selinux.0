Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885221F8AC8
	for <selinux@vger.kernel.org>; Mon,  7 Jul 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906298; cv=none; b=YcBXVkwJ2ME9oH1oEsGaP7WvuxpqJEtgiZtsld6BnXQMkpkUl/ysjG/9bOVzRdiOHR4397A5ekrNDymthm2Hu4v4GmjscfwXv1q+isYgLu2v71iEJawaFKfEMzyJaSDufpde1L9eH93QwDk/Midkqubtss9QMl8v4RbJhezZP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906298; c=relaxed/simple;
	bh=Fq0I617BEaPfMG2z4wrIG7MbfeWHvlnfdHQKS+o29KE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uciS6A73wt9Dm3V+17OVzAtSLImAVrJxON8cygwEcjnk3oPBdryqukEi1rQ9tnarsheNP/jTevdl+0C7oDfTXvHtMpd83II8SaZWVqAP5vvfFl8t9B34OfshXjcMmjfFrVyq79p7/X6+gZvyTcTHADBZu7AKigR9fI9EPAc0/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfaozWcT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfaozWcT"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-237e6963f63so21706235ad.2
        for <selinux@vger.kernel.org>; Mon, 07 Jul 2025 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751906294; x=1752511094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ar3DeW3uE5epd7orxhZyin7XR4MXS8FoUrPxJ+L+jj0=;
        b=gfaozWcTFZq04E5GJe3SS+xrUmo2eQ5SRZVj7TEiKtmvdrDxAyky4Q/ps2Z0ZPig/2
         3uAGl83BwdWOZ8UzAI/Ib4ztosXQO0LSzaIrES6HZhMra/EgQIKc1Tr/utq1ZFXUsVxS
         g8GK8LvWfo/6s1pe+0Gn81ygtke1S88gFzuRjvcnCF+gLnzhgmF72PWSs3u+IeKUoMWx
         5C8kKrH40fH7Se2PNn79ylsfSFSKeHrchwwsT3R3+jNmXByXYUpDPNwhS9SEDPg5+TR+
         GFmYibZBqJEfd6k07QWYvmRlXctq1qNRDbgsAuheFD8gl/6imxPKfGu1vLd0XFEYoUdv
         2BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906294; x=1752511094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ar3DeW3uE5epd7orxhZyin7XR4MXS8FoUrPxJ+L+jj0=;
        b=L7SJybulf1rptH4EbvLIn+4s2HhVsEgQHzYd6K1JG/kvAHY+b4m0L/EcGzmdhzT0j2
         4x75novB9ilAMoAE+vkpx3WV6re6r9SbNrckss9kI5CxiY99uAiHGJUurpn0fELCy6po
         gMkTbqb1WmEpLqKs4cMuzqRalVUxNAPpX0qDx5C6Ota8Sxg5gB5RhuJE5UNTknlmT1Rr
         IC90BS4yc/1OjHegwRFh5yPm3vNjpfsxz/TXnA6det+3T2fvLdtbISrY6IZ+Hzc9ZMe2
         Svz/kNC/KSw+5a/Oh7jQWnKA4JRkLd9/JAXhvqXpHsK3E0FMFA8eOqrC5wYW5unu7s9S
         hfsA==
X-Gm-Message-State: AOJu0YxtF+ye1IwDbVrfk0GhNP3/sWkFlOwDhwEOFjJODnW0VTqpJ7tg
	RUb98BHT68q4mGOV1dXHJF3OM9jxirIUcHhtrsVvi4jC9XhQ80B/MCRcnebDUBEE3DXuDe9CXWh
	OmZi/vOYKLqZ5GaW5I2+YWqpX7vdSLgTOPQ==
X-Gm-Gg: ASbGncsbZFwbXP1bmzJg84t5k0MopqilgPTxpoNLGgME9uteYGmw6lsrQ0MwoXa8qVq
	pQ54YGJajnvzQsnen4bavWzc8ou+AFcyTzgoZX+Zyc464uQERu22+mA/KAcWqoQ6BSoBNeJVBIT
	iHdyL1I+kRl25yVXeorXIkZjx/9S9obm8HE+WuizDsK5A=
X-Google-Smtp-Source: AGHT+IE8QOydkl2nKZAkJJQw+hfCqWxkGMFZY1lQLltEfWUIKXGQPhBFKeTHQl5au7eyunkI5B4G54Qts5IIr1TW8po=
X-Received: by 2002:a17:902:d48e:b0:236:7165:6ecf with SMTP id
 d9443c01a7336-23c8758cbaemr193340925ad.38.1751906293596; Mon, 07 Jul 2025
 09:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705121424.1221268-1-omosnace@redhat.com> <20250705121424.1221268-2-omosnace@redhat.com>
In-Reply-To: <20250705121424.1221268-2-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 7 Jul 2025 12:38:02 -0400
X-Gm-Features: Ac12FXz4_V3fxlzESI-urXeUUTsb3plO_GHW08A1699TOqDwOcGWKRkML-ZSTGo
Message-ID: <CAEjxPJ4EkLSa2wGgO6KRTd=tS4ub1=YgOP6pCjJXE=DaT=Fijg@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/6] policy/test_file_load.te: remove excess semicolons
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 5, 2025 at 8:25=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policy/test_file_load.te | 52 ++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/policy/test_file_load.te b/policy/test_file_load.te
> index e98503a..2b52ffc 100644
> --- a/policy/test_file_load.te
> +++ b/policy/test_file_load.te
> @@ -9,12 +9,12 @@ require {
>
>  ###################### Allow sys kexec_image_load ######################
>  type test_kexec_allow_kexec_image_load_t;
> -testsuite_domain_type_minimal(test_kexec_allow_kexec_image_load_t);
> +testsuite_domain_type_minimal(test_kexec_allow_kexec_image_load_t)
>
> -files_search_boot(test_kexec_allow_kexec_image_load_t);
> -fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_image_load_t);
> -exec_files_pattern(test_kexec_allow_kexec_image_load_t, kdump_exec_t, kd=
ump_exec_t);
> -domain_entry_file(test_kexec_allow_kexec_image_load_t, kdump_exec_t);
> +files_search_boot(test_kexec_allow_kexec_image_load_t)
> +fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_image_load_t)
> +exec_files_pattern(test_kexec_allow_kexec_image_load_t, kdump_exec_t, kd=
ump_exec_t)
> +domain_entry_file(test_kexec_allow_kexec_image_load_t, kdump_exec_t)
>  allow test_kexec_allow_kexec_image_load_t self:capability sys_boot;
>
>  allow test_kexec_allow_kexec_image_load_t boot_t:system  kexec_image_loa=
d;
> @@ -22,12 +22,12 @@ allow test_kexec_allow_kexec_image_load_t tmpfs_t:sys=
tem kexec_image_load;
>
>  ###################### Deny sys kexec_image_load ######################
>  type test_kexec_deny_kexec_image_load_t;
> -testsuite_domain_type_minimal(test_kexec_deny_kexec_image_load_t);
> +testsuite_domain_type_minimal(test_kexec_deny_kexec_image_load_t)
>
> -files_search_boot(test_kexec_deny_kexec_image_load_t);
> -fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_image_load_t);
> -exec_files_pattern(test_kexec_deny_kexec_image_load_t, kdump_exec_t, kdu=
mp_exec_t);
> -domain_entry_file(test_kexec_deny_kexec_image_load_t, kdump_exec_t);
> +files_search_boot(test_kexec_deny_kexec_image_load_t)
> +fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_image_load_t)
> +exec_files_pattern(test_kexec_deny_kexec_image_load_t, kdump_exec_t, kdu=
mp_exec_t)
> +domain_entry_file(test_kexec_deny_kexec_image_load_t, kdump_exec_t)
>  allow test_kexec_deny_kexec_image_load_t self:capability sys_boot;
>
>  neverallow test_kexec_deny_kexec_image_load_t boot_t:system  kexec_image=
_load;
> @@ -35,11 +35,11 @@ neverallow test_kexec_deny_kexec_image_load_t tmpfs_t=
:system kexec_image_load;
>
>  ###################### Allow sys kexec_initramfs_load ##################=
####
>  type test_kexec_allow_kexec_initramfs_load_t;
> -testsuite_domain_type_minimal(test_kexec_allow_kexec_initramfs_load_t);
> +testsuite_domain_type_minimal(test_kexec_allow_kexec_initramfs_load_t)
>
> -files_search_boot(test_kexec_allow_kexec_initramfs_load_t);
> -fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_initramfs_load_t);
> -domain_entry_file(test_kexec_allow_kexec_initramfs_load_t, kdump_exec_t)=
;
> +files_search_boot(test_kexec_allow_kexec_initramfs_load_t)
> +fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_initramfs_load_t)
> +domain_entry_file(test_kexec_allow_kexec_initramfs_load_t, kdump_exec_t)
>  allow test_kexec_allow_kexec_initramfs_load_t  self:capability sys_boot;
>
>  allow test_kexec_allow_kexec_initramfs_load_t  boot_t:system  { kexec_im=
age_load kexec_initramfs_load } ;
> @@ -47,11 +47,11 @@ allow test_kexec_allow_kexec_initramfs_load_t  tmpfs_=
t:system { kexec_image_load
>
>  ###################### Deny sys kexec_initramfs_load ###################=
###
>  type test_kexec_deny_kexec_initramfs_load_t;
> -testsuite_domain_type_minimal(test_kexec_deny_kexec_initramfs_load_t);
> +testsuite_domain_type_minimal(test_kexec_deny_kexec_initramfs_load_t)
>
> -files_search_boot(test_kexec_deny_kexec_initramfs_load_t);
> -fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_initramfs_load_t);
> -domain_entry_file(test_kexec_deny_kexec_initramfs_load_t, kdump_exec_t);
> +files_search_boot(test_kexec_deny_kexec_initramfs_load_t)
> +fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_initramfs_load_t)
> +domain_entry_file(test_kexec_deny_kexec_initramfs_load_t, kdump_exec_t)
>  allow test_kexec_deny_kexec_initramfs_load_t boot_t:system  kexec_image_=
load;
>  allow test_kexec_deny_kexec_initramfs_load_t tmpfs_t:system kexec_image_=
load;
>  allow test_kexec_deny_kexec_initramfs_load_t self:capability sys_boot;
> @@ -65,7 +65,7 @@ testsuite_domain_type_minimal(test_kmodule_allow_firmwa=
re_load_t)
>  typeattribute test_kmodule_allow_firmware_load_t kmoduledomain;
>
>  type firmware_allow_file_t;
> -files_type(firmware_allow_file_t);
> +files_type(firmware_allow_file_t)
>
>  allow test_kmodule_allow_firmware_load_t self:capability sys_module;
>  allow test_kmodule_allow_firmware_load_t test_file_t:system module_load;
> @@ -78,7 +78,7 @@ testsuite_domain_type_minimal(test_kmodule_deny_firmwar=
e_load_t)
>  typeattribute test_kmodule_deny_firmware_load_t kmoduledomain;
>
>  type firmware_deny_file_t;
> -files_type(firmware_deny_file_t);
> +files_type(firmware_deny_file_t)
>
>  allow test_kmodule_deny_firmware_load_t self:capability { sys_module };
>  allow test_kmodule_deny_firmware_load_t test_file_t:system { module_load=
 };
> @@ -87,16 +87,16 @@ neverallow kernel_t firmware_deny_file_t:system firmw=
are_load;
>
>  ###################### Allow sys policy_load ######################
>  type test_policy_allow_policy_load_t;
> -testsuite_domain_type_minimal(test_policy_allow_policy_load_t);
> +testsuite_domain_type_minimal(test_policy_allow_policy_load_t)
>
> -userdom_read_inherited_user_tmp_files(test_policy_allow_policy_load_t);
> -userdom_write_user_tmp_files(test_policy_allow_policy_load_t);
> +userdom_read_inherited_user_tmp_files(test_policy_allow_policy_load_t)
> +userdom_write_user_tmp_files(test_policy_allow_policy_load_t)
>  allow test_policy_allow_policy_load_t user_tmp_t:system policy_load;
>
>  ###################### Deny sys policy_load ######################
>  type test_policy_deny_policy_load_t;
> -testsuite_domain_type_minimal(test_policy_deny_policy_load_t);
> +testsuite_domain_type_minimal(test_policy_deny_policy_load_t)
>
> -userdom_read_inherited_user_tmp_files(test_policy_deny_policy_load_t);
> -userdom_write_user_tmp_files(test_policy_deny_policy_load_t);
> +userdom_read_inherited_user_tmp_files(test_policy_deny_policy_load_t)
> +userdom_write_user_tmp_files(test_policy_deny_policy_load_t)
>  neverallow test_policy_deny_policy_load_t user_tmp_t:system policy_load;
> --
> 2.50.0
>
>
