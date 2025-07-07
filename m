Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95003224220
	for <selinux@vger.kernel.org>; Mon,  7 Jul 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906341; cv=none; b=LiWWNmxrvm5+y8+0Nf0SIIzX/nTNXTm+JEiJEmFnu55iSHa2YDs+Gd4GhumUfN9CY40VpeH0myVI8laimck0WPr5h5cquTedPzKtTHlDADXypx8AyK8P2YI+pyrtiHgJOXG8sd0Z8pQSQFG4gUOFWPCupz3Yl1vlORmV4Aj/NZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906341; c=relaxed/simple;
	bh=ebsfDfICVynmkMgKeuSfTknhh4rklmtOQ+KG0hWJoVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yw9huWxag/S1jbclJ/QBkURapxzTaPRif6oO2XUw3eKjfB0JR1OJ4JL9SUF4heuRrWnx/3tyA9+MU4oWgdQ7WDFxWpqJz3/futkxfLeKxdDtqsAsYaunGJr47wk9oFiFW8gCojlTKnGZRA32sX7JwhYPwUY6xddhBt+oiPVq1Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvT0KjFJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvT0KjFJ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so2605028a12.0
        for <selinux@vger.kernel.org>; Mon, 07 Jul 2025 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751906339; x=1752511139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzqTmT4+lZM7pPK23TIZL7Sy0q288tk6Oiyt3iMlN3o=;
        b=KvT0KjFJzgTNZqXVKbvthrTG0ZBUIqFeFJa0I7txaPSWHgbKl4lKLJum9oPFLcgLLK
         b9UGoncnXUz10UCrV5CVLao0XxIPdasF2gS1QuMJq1ft2jy6BolxjSMzBA6qtyDqVALq
         WNoTt+rAOw86AWhLeXU8kh16q9Tgw0RYtGmkG2VTcu0EccVxzU7/JtfjcmPxD4EIywpT
         VvazD6+s3FL15HpF+zLJyFB6DYVY/SBYDeg0is/SVOGPDlUvURvXRMBVkM6koG3851JK
         0opfbWJEl61BoXvD/lFFEpFWyJy4AcNW+TWamWNfMVXXCo2X5Mu8+jncDawjQ4TEVFFa
         UAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906339; x=1752511139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzqTmT4+lZM7pPK23TIZL7Sy0q288tk6Oiyt3iMlN3o=;
        b=xMj7WzYUo1VnUtMoZZzubnEthEBRmg0yPmHIraQML4N6XCaCguYfgMJhwEVNGvIXdV
         dZILs4ynSSnej1AD9ij2ZqdIWKro3wSiuCausYpOB4IepemrX8+Dm2xldlk4S6OtYCgV
         2baXKNB8iuk0XEdiLAv2najIavLWxxWQzWu4lldOJgNiC0R5vt8gi+TkElk+/5b5jIVX
         JVmNCH9RT9BX67DFUE8uqwZ4OoTSLJRcaQ9qm3yVr1GrVK+m+NOtOyGz7OuFPNGWS29G
         rKd/xlo/6kD68parK7N5WKD1t7VP52TzkaEFvYN9XWpmVLeUh6n1BT45tZJenoXNWVMJ
         mtnw==
X-Gm-Message-State: AOJu0Ywt9cLgvF9zZseKlF2fQCiN5jNpsEn+JFbSEUlp4RHrNbmj+2LZ
	sQ5hN0ZGDuaee5pktLNCrCy6tVCAt73dbPeI7Efddjkv5LtQz+UWcyQBNghOjG/Q6E9FCCB9fLA
	zlwyVoj7wAdESooqChazEABRDwUAH5cU=
X-Gm-Gg: ASbGncv8A/mxBVtkZh5Nm0JHcDb+E+Yp2M/Q1jF9Lyx3YsVcrm5RqQLQhvAkM89GWDj
	qQ+VEdCHn6x6nuRzXaFW0WBMoP/GvwMLp9sSkpLX2GuvL4ae2vWQ4OfZK/5yYB0fCu+KUiKyi/z
	8nyyNr2mU02lHLAGnAbBqNVnBxwUPqCJgpdf1LFTUZshE650u3dta+IQ==
X-Google-Smtp-Source: AGHT+IFSo/yDAHnAY1HlpfxgirByWXXT/GhKteCFsAvnf/Esa+C/skYohnEIchYY0G8WOn+BJcjV95cLSV638BCU71I=
X-Received: by 2002:a17:90b:2c01:b0:312:e76f:5213 with SMTP id
 98e67ed59e1d1-31c20e6e252mr118946a91.28.1751906338629; Mon, 07 Jul 2025
 09:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705121424.1221268-1-omosnace@redhat.com> <20250705121424.1221268-3-omosnace@redhat.com>
In-Reply-To: <20250705121424.1221268-3-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 7 Jul 2025 12:38:46 -0400
X-Gm-Features: Ac12FXzLhf7bTMEGyDlsWA_DnfUuXQI_Lt2cnPIXxK9ishC6GoIQIRAYGr5sQpQ
Message-ID: <CAEjxPJ6H=AEtVrwbOUeuwq=EVTXiBKJgny+ACTZEYz=D0nsOZA@mail.gmail.com>
Subject: Re: [PATCH testsuite 2/6] policy/test_file_load.te: use testsuite_domain_type()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 5, 2025 at 8:14=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> The minimal version is not necessary here - use the basic one.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policy/test_file_load.te | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/policy/test_file_load.te b/policy/test_file_load.te
> index 2b52ffc..2e3f71d 100644
> --- a/policy/test_file_load.te
> +++ b/policy/test_file_load.te
> @@ -9,7 +9,7 @@ require {
>
>  ###################### Allow sys kexec_image_load ######################
>  type test_kexec_allow_kexec_image_load_t;
> -testsuite_domain_type_minimal(test_kexec_allow_kexec_image_load_t)
> +testsuite_domain_type(test_kexec_allow_kexec_image_load_t)
>
>  files_search_boot(test_kexec_allow_kexec_image_load_t)
>  fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_image_load_t)
> @@ -22,7 +22,7 @@ allow test_kexec_allow_kexec_image_load_t tmpfs_t:syste=
m kexec_image_load;
>
>  ###################### Deny sys kexec_image_load ######################
>  type test_kexec_deny_kexec_image_load_t;
> -testsuite_domain_type_minimal(test_kexec_deny_kexec_image_load_t)
> +testsuite_domain_type(test_kexec_deny_kexec_image_load_t)
>
>  files_search_boot(test_kexec_deny_kexec_image_load_t)
>  fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_image_load_t)
> @@ -35,7 +35,7 @@ neverallow test_kexec_deny_kexec_image_load_t tmpfs_t:s=
ystem kexec_image_load;
>
>  ###################### Allow sys kexec_initramfs_load ##################=
####
>  type test_kexec_allow_kexec_initramfs_load_t;
> -testsuite_domain_type_minimal(test_kexec_allow_kexec_initramfs_load_t)
> +testsuite_domain_type(test_kexec_allow_kexec_initramfs_load_t)
>
>  files_search_boot(test_kexec_allow_kexec_initramfs_load_t)
>  fs_rw_inherited_tmpfs_files(test_kexec_allow_kexec_initramfs_load_t)
> @@ -47,7 +47,7 @@ allow test_kexec_allow_kexec_initramfs_load_t  tmpfs_t:=
system { kexec_image_load
>
>  ###################### Deny sys kexec_initramfs_load ###################=
###
>  type test_kexec_deny_kexec_initramfs_load_t;
> -testsuite_domain_type_minimal(test_kexec_deny_kexec_initramfs_load_t)
> +testsuite_domain_type(test_kexec_deny_kexec_initramfs_load_t)
>
>  files_search_boot(test_kexec_deny_kexec_initramfs_load_t)
>  fs_rw_inherited_tmpfs_files(test_kexec_deny_kexec_initramfs_load_t)
> @@ -61,7 +61,7 @@ neverallow test_kexec_deny_kexec_initramfs_load_t tmpfs=
_t:system kexec_initramfs
>
>  ###################### Allow sys firmware_load ######################
>  type test_kmodule_allow_firmware_load_t;
> -testsuite_domain_type_minimal(test_kmodule_allow_firmware_load_t)
> +testsuite_domain_type(test_kmodule_allow_firmware_load_t)
>  typeattribute test_kmodule_allow_firmware_load_t kmoduledomain;
>
>  type firmware_allow_file_t;
> @@ -74,7 +74,7 @@ allow kernel_t firmware_allow_file_t:system firmware_lo=
ad;
>
>  ###################### Deny sys firmware_load ######################
>  type test_kmodule_deny_firmware_load_t;
> -testsuite_domain_type_minimal(test_kmodule_deny_firmware_load_t)
> +testsuite_domain_type(test_kmodule_deny_firmware_load_t)
>  typeattribute test_kmodule_deny_firmware_load_t kmoduledomain;
>
>  type firmware_deny_file_t;
> @@ -87,7 +87,7 @@ neverallow kernel_t firmware_deny_file_t:system firmwar=
e_load;
>
>  ###################### Allow sys policy_load ######################
>  type test_policy_allow_policy_load_t;
> -testsuite_domain_type_minimal(test_policy_allow_policy_load_t)
> +testsuite_domain_type(test_policy_allow_policy_load_t)
>
>  userdom_read_inherited_user_tmp_files(test_policy_allow_policy_load_t)
>  userdom_write_user_tmp_files(test_policy_allow_policy_load_t)
> @@ -95,7 +95,7 @@ allow test_policy_allow_policy_load_t user_tmp_t:system=
 policy_load;
>
>  ###################### Deny sys policy_load ######################
>  type test_policy_deny_policy_load_t;
> -testsuite_domain_type_minimal(test_policy_deny_policy_load_t)
> +testsuite_domain_type(test_policy_deny_policy_load_t)
>
>  userdom_read_inherited_user_tmp_files(test_policy_deny_policy_load_t)
>  userdom_write_user_tmp_files(test_policy_deny_policy_load_t)
> --
> 2.50.0
>
>
