Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56063214
	for <selinux@vger.kernel.org>; Mon,  7 Jul 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906616; cv=none; b=KipSjCZz9iJyCQ+SGsiAgS0xW3XsL4ha806lr64jS0j207NPguJW7VGMBqBnOQEc+lUF5yhsIjky4LKAbAjuW2ElGWwjPBkZRHTwx/HqgeEvVVnE6eNhgAEkOZ3GViGy+ia3AJTa6yuvODgBcM1CYHOfnFuy4eoIHszLwVyQLko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906616; c=relaxed/simple;
	bh=N7KOix/tSjIgVCZ3YoYcyFevMbE7vqP8PBPJucL+63c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5GjKzP3k+oCgEGu9eg+Jd8janMFWHh/VevBhz/785PdoFtRKNtT49YiUWfFuNajhmHPESvSEgzAcjd54VpCYCovdR6KZEVawxZkFKep12Vf4iX3Ic4TP7LAH/mrzoIADhZpT4Vva9MQB1F5VuYaTza2LjuRgRVywXww/q7autQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ftd0fIxv; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ftd0fIxv"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso2443440a91.1
        for <selinux@vger.kernel.org>; Mon, 07 Jul 2025 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751906614; x=1752511414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzeuRyq51afb67YOdwoZxoKPzk0korm976Endxr/9mk=;
        b=Ftd0fIxvMb6vu1Ucq/UUgz8s2i8moM44VdzLqsEu9bcshohoN4NuTROehifsXUiwwM
         NAJ5Xwc3RWpPDQOTZpDiRCnFvAfZAfd/ZLAqZkwc2m8To2jFlTcxS5qPao7t3WgvIwsy
         sOl7CjsE8X5WI/g2vzwsZC/IIeUKszNRpDuoUS/g9A5dHFmCYxDZ2ZH+MCecSp1dgY1b
         XurcPqBYq9yBV26VnH9etGRHiUzTyNqASelN7iEpG0H7Nx6JI2KkSlJMmB4yA/QwX6BD
         s2hKzHlSvDPt3MoF/m0DxGGfynL5NBfjpcZZ0NaJPAe3P/otAmgNJ8pZA1TDMOzrwxJs
         4juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906614; x=1752511414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzeuRyq51afb67YOdwoZxoKPzk0korm976Endxr/9mk=;
        b=IozwpKLuVLbwfADEeQT5mpvuorFXdCmO+va3cviEa0HJ689ElvtmqgYShJqQkYy+YI
         7fSSZkCLCF4P9X/ch4zpP6UPf971CaB+Fq0QOphgy6dQBAZeWB4EMSzhqN+Z+wzZ4pwS
         WE02mnDOVlSgknZyNFuLgMI7TywT4v1BWGKwMb3Og5/O/xzg3LgJkJiw7HyWHpNQgn1J
         MxLZA1G9Jr1AFsMu8dpxVA7FZcxnmrJLbswnY96bmQoDoGLPmdqbj94D7I7qnNLKANOz
         E4oCl8fuYTnYyW7cfuH5yvj7XqJ63aJLHjkg5icoFQQKIXdTeTXKp9Jv2onXHj6Ll429
         WaOA==
X-Gm-Message-State: AOJu0Yw6btLb512GYw0b97hELXvgNLRTeJ8jfTvRwG4MxSoc+ODJyCIC
	8uxQCXCB7c2rO5OcaZwiTgcfxwsZiYBYt4KnmM4nCOU185oQ28wO5KOtRKhFlQKqRsikJ2JqAG3
	qwaqS+GhgqgPvA8ontU73krkwuq5W1ocMSx2w
X-Gm-Gg: ASbGncsffAFgxmXYItVqNcbS8qXngV8Qf+Hv0C+fQtm+et+BBEe32RMdjQOPydpK/hV
	jaX62nBNZsggx4UBeTW60P27K2F/T/rlozGFIU0O1N+WRkmXiwj9L91XDx9qvQpD/GBzmS/x3A+
	0CwJ9SNl2kAGu0FVSfERGv97A/YAOLZf/FZTs7onuAPeY=
X-Google-Smtp-Source: AGHT+IEroOI4Yb7/J6m/6IlWhibd+BV1JWAPvPW5Q2Kf9Sz7J/y+/s3y9CmQJO5RzhkN/k/OyI2rTWVeCZwgMlARql0=
X-Received: by 2002:a17:90b:43:b0:311:ae39:3dad with SMTP id
 98e67ed59e1d1-31aaddb71dfmr15960436a91.30.1751906614035; Mon, 07 Jul 2025
 09:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705121424.1221268-1-omosnace@redhat.com> <20250705121424.1221268-7-omosnace@redhat.com>
In-Reply-To: <20250705121424.1221268-7-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 7 Jul 2025 12:43:21 -0400
X-Gm-Features: Ac12FXwpEp7BN_ylcYKUKm8ccsRDSjHvn7Mh2x_upGV1oN4yTzulMR4_d0tUox8
Message-ID: <CAEjxPJ64+dby1mVD80_Tg_kY-Kdm9eCa8ZgRDxGh9qTUFPtxTQ@mail.gmail.com>
Subject: Re: [PATCH testsuite 6/6] tmt: add some missing permissions to policy
 before running the tests
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 5, 2025 at 8:15=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> To enable test coverage for permissions that haven't been added to the
> distro SELinux policy yet, we may want to temporarily add these
> permissions to the policy. Since these new permissions will often only
> be present in new kernel code, let's do this only when testing the
> secnext kernel.
>
> The permissions added are the file loading permissions (extending
> module_load coverage) and the nlmsg permission (enabling the nlmsg
> test).
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  tmt/tests.fmf | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/tmt/tests.fmf b/tmt/tests.fmf
> index c9f5ff4..64c7c40 100644
> --- a/tmt/tests.fmf
> +++ b/tmt/tests.fmf
> @@ -37,6 +37,29 @@
>            --nogpgcheck --releasever rawhide \
>            --repofrompath 'kernel-secnext,https://repo.paul-moore.com/raw=
hide/$basearch' \
>            kernel-modules-*.secnext.* kernel-devel-*.secnext.*
> +
> +        # add classes/permissions currently not supported in Fedora
> +        semodule -c -E base
> +        sed -i \
> +          -e 's/\((class system (ipc_info syslog_read syslog_mod syslog_=
console module_request module_load \)\(halt reboot status start stop enable=
 disable reload undefined ))\)/\1firmware_load kexec_image_load kexec_initr=
amfs_load policy_load x509_certificate_load \2/' \
> +          -e 's/\((class netlink_[a-z0-9_]*_socket (\)\(nlmsg_read \)/\1=
nlmsg \2/' \
> +          base.cil
> +        echo "(policycap netlink_xperm)" >>base.cil
> +        # allow nlmsg to some system domains so that the system can boot
> +        for source in daemon initrc_domain systemprocess unconfined_doma=
in_type sysadm_t; do
> +          echo "(allow $source self (netlink_route_socket (nlmsg)))" >>b=
ase.cil
> +          echo "(allow $source self (netlink_firewall_socket (nlmsg)))" =
>>base.cil
> +          echo "(allow $source self (netlink_tcpdiag_socket (nlmsg)))" >=
>base.cil
> +          echo "(allow $source self (netlink_xfrm_socket (nlmsg)))" >>ba=
se.cil
> +          echo "(allow $source self (netlink_audit_socket (nlmsg)))" >>b=
ase.cil
> +          echo "(allow $source self (netlink_ip6fw_socket (nlmsg)))" >>b=
ase.cil
> +        done
> +        semodule -X 456 -i base.cil
> +        rm -f base.cil
> +        sed -i.orig \
> +          -e 's/module_load /module_load firmware_load kexec_image_load =
kexec_initramfs_load policy_load x509_certificate_load /' \
> +          -e 's/nlmsg_read /nlmsg nlmsg_read /' \
> +          /usr/share/selinux/devel/include/support/all_perms.spt
>          ;;
>        local)
>          # for a non-rpm directly-installed kernel - assume all necessary=
 files
> @@ -100,6 +123,7 @@
>      - jfsutils
>      - dosfstools
>      - rdma-core-devel
> +    - kexec-tools
>    /main:
>      summary: Run the testsuite
>      duration: 20m
> @@ -139,3 +163,7 @@
>        semanage boolean --modify --off ssh_sysadm_login
>        semanage login --modify -s unconfined_u root
>      fi
> +    if [ "$STS_KERNEL" =3D secnext ]; then
> +      semodule -X 456 -r base
> +      env -C /usr/share/selinux/devel/include/support mv all_perms.spt.o=
rig all_perms.spt
> +    fi
> --
> 2.50.0
>
>
