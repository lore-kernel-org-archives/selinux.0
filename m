Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB88364032
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597968; cv=pass; b=O/JzGvQpWaLoQYK9AyZMhcVnb3OxOsODR5S3COLsHblSnBXdeEukOWQUQxBnYHKWnwfl5FpWAjtT8Y7RsRgEjgnkDTPQvPScgwZmpRJuR/nl+c3vZagcxqpqWnSSq2a4s9O5taR9hEKoKEOYzgoIhNWgnfx8a/en3abAkyruXXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597968; c=relaxed/simple;
	bh=lIPysrwHqnq3l76mQePLML//JpPSHb4lSrgS1ZHQkj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fU11lQ2kreXOdSeSavc5pZCOJy5urWPgqjlD0rywUbTLvmPw2bI2S53nPIxfgb0HLgecWpoRj04KVFsDcKuC12NjLmecqlnqYwj0FIERLkyQAm7MbstfGwyCCO26+iCu6lch6RGLSkntqbCeNr4hL0DgntTBWLe+Gp5mVvsCI04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4awV14u; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4awV14u"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3660daea6a5so3039881a91.1
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 07:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778597966; cv=none;
        d=google.com; s=arc-20240605;
        b=lX7pqEgkMW/YGOqzZGy4Y+Dbtjp05Pom6upSwXS20Ngb4kxk0Z5OwlOgdY9weftGhr
         YTWF2DlOoc8qgE7eaOZ2OC6VW3XLWvZ6kGP6+3yWU34Z3rTbJUYHpREOUO0orVzt1eNS
         8VugGsjIZQAqRMrr4uGBmiPnJhWBWHR1dbOFqLEAQuVGd47O1bP96lyjOX4vqA6aP0si
         yIkTV270zvkrwFEQ+W+l9N3B+QbuGLRHOiWkQF01gVXkLDLfh3bMZi21n1MdYIJ6Z29u
         KkigwE6PfuNLJtxiE44g7NZU4U2VFgcmyH22La3d1QmQ3izrF/+owaQIhe8uFTZyIEW8
         x0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dDNoCNO5sPJE1tFsy9a15EfSTixYq90FErwDlaN6Eww=;
        fh=ctNnd7rEgrNGVRcNYAD2iHPqnd+GFVudQHEzcgGqyZE=;
        b=YI8MlPsn5cdWrZxnfF6pMrx2VpDJgbP8LaRUCJK+iOkVm10/smN+V9BCPvJa/F+eP4
         6hI5UmB44w9h++IGkVGZdlbfVxtKoor3Q8hpc8ojpZMIkvOAFWjqUoiFvtQphXJUBtes
         SbnwL4YOLS/pgJ1mXQUN24Sme4REwiOh/8I2xOy9HnkTBGSASWkERX4mtNfswLuFCmBQ
         t9c9YSFInMCPMld6/d7IHGdouJWkg1m7a27S7yQb0drJL1Vogo4CUNU1eYr8Z4NJP38l
         xr1TprRTWvSucfLMaF5Ipi0ojw/sU++6+53kabNQT2sof0Ox/dsSv89cT2DSTjzmG89Y
         8CBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778597966; x=1779202766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDNoCNO5sPJE1tFsy9a15EfSTixYq90FErwDlaN6Eww=;
        b=e4awV14udJvby2F0UED0/1AB9EURzdSnX3rJ0lPLt9hk8hTQWLo4SV9BDcVL1NKSy/
         +eDieNYRJNxvKQkFnC6LD+GF2PMhnaPcgUT+TRMnoLlPMC87LdLhWg/Njsp1x+W4y3QL
         MhoJ4rmGCJCdw4TsykltNDUAwLXhRKITFkrSpXRnRwnZr09X3Ij7sS7xSBUbEiv/yQZd
         lQ21bvKX1WTbPFHlc4EUhj3NwaYHwgzKxHnWFb+xgglxee5KB1lCMlgRTG3t7vO/Pjg9
         GpYncLnTNwimPccPxRDIdDV5Ij8kkV/M7in0vjuV9pP8aJ2cTLplpSmuEZnPCLL0uwc6
         F0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778597966; x=1779202766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dDNoCNO5sPJE1tFsy9a15EfSTixYq90FErwDlaN6Eww=;
        b=RbOnqyGfe6VhroWgbp163K6lNx939SW9V86VpQditT9FDTHhmOjg19RmyAnlqpsbNy
         +sAha1MxPbljzYgo4349xHX/IJPm1nN9QnmsEL0LcTcRJ/doZLPFpFhuFPWLJ4Vi6RhP
         4JcRfix22LieGyUNqCVShufwTgANEK5YuxXV3gqDbB5mCeRHcem3JAqQawMXi0AAVgPu
         1Ps06r3+CoAzTKvdKLTAovUBzBbqa0ko8eJ05bFjcfA6D9zUcmVcVQrkNK/oQg5j7X8T
         QUttkZZ+NA+ViitCELc3vJSjTPBp3DpnEnk9QUh6WPH/Af7Q97l2v7dhZCPuoxvlHrp4
         U/Wg==
X-Gm-Message-State: AOJu0YxOIPv/CHUaxrZud1CGPDErLHvaqvrE+d+1itIlzKvG+6WNvjyE
	9DWvZ9q/I5NVNoQJpazQhHaQkzNxtwM2Ht2geDK/ks3KTJjYpciNvvc8GZOgsDPhgglrx5MeWCA
	c5zU8gBEhHXAcTTEvQh7Udne3pe3uihnkbQ==
X-Gm-Gg: Acq92OGvZXPjF29R2sURft51ifiamjBnTXrjHk4vwSHNe7vn8HH7fJ0/mr7xSIGj/E4
	QTJNFclFL1iSqP/ccaxXxlWmvbemTnC/X83yBCvalsQwR5/Zs+mIZGqhKrmPfhC10xEvrG/sTiI
	QANRAXXvj+fAuVjDr/0LEZGPYzH132pA5Gl47WezwTgoLKyXprhOYawxXcyfkRT4i3hODq2XC9z
	qsqtu0tOwR6/ZG2HShyd6jEw6ozME/6AgNOnpBQuPOOyKOhBL6pYborahgOqCnbcGb4d4DOegRL
	vHPiGh4=
X-Received: by 2002:a17:90b:2744:b0:368:98c0:8836 with SMTP id
 98e67ed59e1d1-36898c08a6cmr5782042a91.18.1778597965959; Tue, 12 May 2026
 07:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409090503.2846202-1-omosnace@redhat.com>
In-Reply-To: <20260409090503.2846202-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 12 May 2026 10:59:14 -0400
X-Gm-Features: AVHnY4L2-JbU7bjaM_Q7yeExntzu9UIiUyyXYM-gP05UftpjxaockQdSu0_JmzU
Message-ID: <CAEjxPJ7XGjWK6G6MkVj8WPG2bAM_JyZQCJwYFjFUQUkskgYWBw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tmt: add setup for BPF token tests
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 5:14=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> Adjust the system policy such that the BPF token tests get exercised in
> CI or when run via tmt manually.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  tmt/tests.fmf | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tmt/tests.fmf b/tmt/tests.fmf
> index 1df3a5d..88039f8 100644
> --- a/tmt/tests.fmf
> +++ b/tmt/tests.fmf
> @@ -42,8 +42,11 @@
>          semodule -c -E base
>          sed -i \
>            -e 's/\((class system (ipc_info syslog_read syslog_mod syslog_=
console module_request module_load \)\(halt reboot status start stop enable=
 disable reload undefined ))\)/\1firmware_load kexec_image_load kexec_initr=
amfs_load policy_load x509_certificate_load \2/' \
> +          -e 's/map_create/map_create map_create_as/' \
> +          -e 's/prog_load/prog_load prog_load_as/' \
>            base.cil
>          echo "(policycap netlink_xperm)" >>base.cil
> +        echo "(policycap bpf_token_perms)" >>base.cil
>          # allow nlmsg to some system domains so that the system can boot
>          for source in daemon initrc_domain systemprocess unconfined_doma=
in_type sysadm_t; do
>            echo "(allow $source self (netlink_route_socket (nlmsg)))" >>b=
ase.cil
> @@ -55,6 +58,8 @@
>          rm -f base.cil
>          sed -i.orig \
>            -e 's/module_load /module_load firmware_load kexec_image_load =
kexec_initramfs_load policy_load x509_certificate_load /' \
> +          -e 's/map_create/map_create map_create_as/' \
> +          -e 's/prog_load/prog_load prog_load_as/' \
>            /usr/share/selinux/devel/include/support/all_perms.spt
>          ;;
>        local)
> --
> 2.53.0
>
>
