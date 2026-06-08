Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ADE1E51E0
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921969; cv=pass; b=Be3ASKVoCXWClP8Wei7aHcKaQr8maSyQrZXkzl85PUtd8EW7R39oEzqzrWSk7sp1qkDyG3/i1rZLl7a98KdMRvduBK1WVEbmTFWU7Lusq9jcx76H0kzlrFi0PtDIfa7ILy9sItY3owwMdwAAIxpWAGvPsDXOktBHCg9nWXr02cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921969; c=relaxed/simple;
	bh=hfVKEYZ32W6cWuUKx/A1kW6RwewkWrBG1NeZcb+WL+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hE+2R+omY3OGdJGekXQS2Our/+lH8pJ0lqqzgqBQXmCL6sR6RKWGGbj3q4ijsex+LTUgCjSu0tYAwkTAbsijBiIloE0s7t8qRgDbtOjQqTNgDh6kG1lWigkmpklDwlsAy9p5lWJ4a9/DJ1KCfziSKC9ubdHPJUDef6Y3kUQB6cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp8nmcYe; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp8nmcYe"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c86307c4e6bso288529a12.0
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 05:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780921967; cv=none;
        d=google.com; s=arc-20240605;
        b=AGlKMC0Ulp77wdoTNojr8LRFbiWUztZXf4jugOVIaPiNaEiv9JIP7ERNU7Y9mngGEw
         cVuoyxXef8n7cdMmk1bUHXfHH20P0sonnRMh+kYRYqmNo64TcxowA1IF5ETJz8AS9eYJ
         Vy1QBafIYceSH1J9zObaRwiTDeaouweOuKFXW/Xm9/7E8pkGrH+6/eckmmnQNyoh8k/3
         EYlPUZ3z7jtKxu54lxzLBKxXZn9Ao1vV5Pl7C8IcmixmEV9TU2bF3GFNa0ueE8eQ7kM4
         fn0/NafLvCP3mwMKWgUl1WuGR8CsWM2TIrku6EI41hYtJ2ea9BMG1NjY55qFDyp5xrgB
         7scA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DZNAZd8he0qYILxCpRtGAa+ymRifC8aK/cf8y8rx+ko=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=NeplAV6hz19lfT3kuH3p9FPT2CqADGvyqP6XiGxD32xx1q1ZCKOfE51xsf4wkeFN94
         2dZcKAEJa4j/JejuMtNGKQWhXS4v9VyeXEnzIDTagylnNKGUpTWQ5Wn41NfNnKhqxujy
         RBvcg4occQiZpPXR+d//U4YuBulVx5+Q8w9bo4+J2MeZcar/aM7oWDe4/hy/5PsGcLN9
         q3TetpdiQapukr7CMef9MF+2ftG/jbyoS52anNZmA5+OEdJfVOuCMTnhPx8HnBl5ijNl
         AcECILC7GJ0STZvrfaFDKP1LkY7RRi6+s2RuOwt+hWgHNfVjfFh6ty+LXT4nmiCRO4yz
         q5MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780921967; x=1781526767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZNAZd8he0qYILxCpRtGAa+ymRifC8aK/cf8y8rx+ko=;
        b=Yp8nmcYey1Jq0uiz+N6t6OHpyZhC0MmEEjkIHybVPTidGo2xuC5a627QmwS0zbZOKI
         Alf0Ig//ljkih+bu2n5Gh0a4B08jGwgRBLqwlMD4r4yE/c2madMkSVU6GCwkLCQo/Iaa
         yu8QeO9Ue4P/ki58P0r761dRoz7z98Nmu5DW3RqacRTyeY26w0uUUUe/JcT2m9EWefmn
         6N4k+e09d0loFInJ/QFVD3ZdV4xRX6Y9noWblPwcKwPAVZusvHkV4tGQ4uDD/gyGkz9I
         GUINfQf6OjrOK6iNSWmKLGDBw2OnaCbJXObdtIbxIXHzQ9pc68zKzh8zJ6TeY5Tgjgeq
         2h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780921967; x=1781526767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DZNAZd8he0qYILxCpRtGAa+ymRifC8aK/cf8y8rx+ko=;
        b=EqT44cQJWD99CFxzzFVZKbKTN1xKINMNLLZc9jHeaklHsNPJRTMysfJHUpcPnWcG2c
         emgiGnZgKfUVBrwSKMTqUfeIYkdHE4EMydrX0V+TguhPypATiAf9JdijBM6fASQoEtTD
         jQeA+VPGbYUAExVmHZchNfoO/7GfV1kPv1Lv3ql36dGWv1HmF09pO/SibH5V24YfCJNM
         ZdoRQOBT4VbcOtj2QwXR1IubYP8MExFjug7eaz4oG0+Mk558MNMyAxGSzAiOseLoTlJ8
         vwp5LpSS5wa90MkYIMLx0bI86YQeVOqLPfUhzXeXeYX4Ib3c62QzxChLIAny6FOqg9DJ
         trKg==
X-Gm-Message-State: AOJu0Yydqf3+gh8QHGIPzZvledYGnqNaiCob3A+wJTl7vuOber6L+oow
	ecomeE6NdPisQOodf3nji7ePJPrwim98stOqf1OIifYl5Zcz+H6kW5hlm82T5psG1Tawc2V/srF
	JU3JsjFzN6noLxCOVNh1EDgRKAWKbKEuSfg==
X-Gm-Gg: Acq92OG91wyo9MjIkeIs61DH3HfD25SOtd9j7QDbj/0YrkvziYwobVubSAXU06MEzCS
	gF36ZFy4LTzy4iZ02tv4EKTo1egOvG/vydYoI+0Mc79hg1AYvz8wRhmdvTtrs2w67DmMqQPqTRk
	EJgQiDtYqmNLgLSdzMGMJBzIOSx3VA2wZcDU/Q+4s/QNE1cOr3H5YhbGBZ1GHxcyD1DAyjwPZaX
	0fzWgI8EvBbr8HpPcnIGZoC3oXn6C3mvgRDi9r0kKeLEzsv6hX9f/ghwcKJewHgnHBhs2lWT84x
	hdZjTJgvLEa879CzMQ==
X-Received: by 2002:a05:6a21:7a8e:b0:3b4:7bcc:5227 with SMTP id
 adf61e73a8af0-3b4ccd6ad00mr17983956637.12.1780921966944; Mon, 08 Jun 2026
 05:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605173421.279607-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260605173421.279607-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 8 Jun 2026 08:32:34 -0400
X-Gm-Features: AVVi8CcbVW5cS_Cxd_v_d0i6EZy5lBetXPs3Mb-HLGTRctvLz1abFzW9kUpcPwg
Message-ID: <CAEjxPJ7+6DEQdu0HD8hR5mFy263qLk7XvVDFYMiQTKsmCtCXkQ@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: drop fscon statement support
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 1:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> fscon statements predate the upstreaming of SELinux and were never
> used in any mainline Linux kernel version to my knowledge. CIL never
> appears to have supported them so they are "lost" on conversion to
> CIL. The kernel still accepts the entries in the binary policy but
> doesn't use them for anything. This has come up previously but never
> been addressed and given that there is a potential heap buffer
> overflow in define_fs_context(), let's just get rid of checkpolicy
> fscon support altogether.
>
> Link: https://lore.kernel.org/selinux/CAJfZ7=3DmP2eJaq2BfO3y0VnwUJaY2cS2p=
=3DHZMN71z1pKjzaT0Eg@mail.gmail.com/
> Link: https://lore.kernel.org/selinux/CAJfZ7=3DmP2eJaq2BfO3y0VnwUJaY2cS2p=
=3DHZMN71z1pKjzaT0Eg@mail.gmail.com/
> Fixes: https://github.com/SELinuxProject/selinux/pull/518
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  checkpolicy/fuzz/checkpolicy-fuzzer.dict  |  1 -
>  checkpolicy/policy_define.c               | 60 -----------------------
>  checkpolicy/policy_define.h               |  1 -
>  checkpolicy/policy_parse.y                | 13 +----
>  checkpolicy/policy_scan.l                 |  2 -
>  checkpolicy/tests/policy_allonce.conf     |  2 -
>  checkpolicy/tests/policy_allonce_mls.conf |  2 -
>  7 files changed, 2 insertions(+), 79 deletions(-)
>
> diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.dict b/checkpolicy/fuzz/=
checkpolicy-fuzzer.dict
> index fb7e66c0..80f92c8e 100644
> --- a/checkpolicy/fuzz/checkpolicy-fuzzer.dict
> +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.dict
> @@ -61,7 +61,6 @@
>  "dom"
>  "domby"
>  "incomp"
> -"fscon"
>  "ibpkeycon"
>  "ibendportcon"
>  "portcon"
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 7be7b21a..e36b97c9 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -4871,66 +4871,6 @@ int define_initial_sid_context(void)
>         return 0;
>  }
>
> -int define_fs_context(unsigned int major, unsigned int minor)
> -{
> -       ocontext_t *newc, *c, *head;
> -
> -       if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
> -               yyerror("fscon not supported for target");
> -               return -1;
> -       }
> -
> -       if (pass =3D=3D 1) {
> -               parse_security_context(NULL);
> -               parse_security_context(NULL);
> -               return 0;
> -       }
> -
> -       newc =3D calloc(1, sizeof(ocontext_t));
> -       if (!newc) {
> -               yyerror("out of memory");
> -               return -1;
> -       }
> -
> -       newc->u.name =3D malloc(6);
> -       if (!newc->u.name) {
> -               yyerror("out of memory");
> -               free(newc);
> -               return -1;
> -       }
> -       sprintf(newc->u.name, "%02x:%02x", major, minor);
> -
> -       if (parse_security_context(&newc->context[0])) {
> -               free(newc->u.name);
> -               free(newc);
> -               return -1;
> -       }
> -       if (parse_security_context(&newc->context[1])) {
> -               context_destroy(&newc->context[0]);
> -               free(newc->u.name);
> -               free(newc);
> -               return -1;
> -       }
> -       head =3D policydbp->ocontexts[OCON_FS];
> -
> -       for (c =3D head; c; c =3D c->next) {
> -               if (!strcmp(newc->u.name, c->u.name)) {
> -                       yyerror2("duplicate entry for file system %s",
> -                                newc->u.name);
> -                       context_destroy(&newc->context[0]);
> -                       context_destroy(&newc->context[1]);
> -                       free(newc->u.name);
> -                       free(newc);
> -                       return -1;
> -               }
> -       }
> -
> -       newc->next =3D head;
> -       policydbp->ocontexts[OCON_FS] =3D newc;
> -
> -       return 0;
> -}
> -
>  int define_pirq_context(unsigned int pirq)
>  {
>         ocontext_t *newc, *c, *l, *head;
> diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
> index 6e1788a2..55292464 100644
> --- a/checkpolicy/policy_define.h
> +++ b/checkpolicy/policy_define.h
> @@ -33,7 +33,6 @@ int define_compute_type(int which);
>  int define_conditional(cond_expr_t *expr, avrule_t *t_list, avrule_t *f_=
list);
>  int define_constraint(constraint_expr_t *expr);
>  int define_dominance(void);
> -int define_fs_context(unsigned int major, unsigned int minor);
>  int define_fs_use(int behavior);
>  int define_genfs_context(int has_type);
>  int define_initial_sid_context(void);
> diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> index 0089e541..27e52d05 100644
> --- a/checkpolicy/policy_parse.y
> +++ b/checkpolicy/policy_parse.y
> @@ -132,7 +132,7 @@ typedef int (* require_func_t)(int pass);
>  %token SOURCE
>  %token TARGET
>  %token SAMEUSER
> -%token FSCON PORTCON NETIFCON NODECON
> +%token PORTCON NETIFCON NODECON
>  %token IBPKEYCON
>  %token IBENDPORTCON
>  %token PIRQCON IOMEMCON IOPORTCON PCIDEVICECON DEVICETREECON
> @@ -175,7 +175,7 @@ base_policy             : { if (define_policy(pass, 0=
) =3D=3D -1) YYABORT; }
>                           opt_default_rules opt_mls te_rbac users opt_con=
straints
>                           { if (pass =3D=3D 1) { if (policydb_index_bools=
(policydbp)) YYABORT; }
>                            else if (pass =3D=3D 2) { if (policydb_index_o=
thers(NULL, policydbp, 0)) YYABORT; }}
> -                         initial_sid_contexts opt_fs_contexts opt_fs_use=
s opt_genfs_contexts net_contexts opt_dev_contexts opt_ibpkey_contexts opt_=
ibendport_contexts
> +                         initial_sid_contexts opt_fs_uses opt_genfs_cont=
exts net_contexts opt_dev_contexts opt_ibpkey_contexts opt_ibendport_contex=
ts
>                         ;
>  classes                        : class_def
>                         | classes class_def
> @@ -703,15 +703,6 @@ pci_context_def    : PCIDEVICECON number security_co=
ntext_def
>  dtree_context_def      : DEVICETREECON path security_context_def
>                         {if (define_devicetree_context()) YYABORT;}
>                         ;
> -opt_fs_contexts         : fs_contexts
> -                        |
> -                        ;
> -fs_contexts            : fs_context_def
> -                       | fs_contexts fs_context_def
> -                       ;
> -fs_context_def         : FSCON number number security_context_def securi=
ty_context_def
> -                       {if (define_fs_context($2,$3)) YYABORT;}
> -                       ;
>  net_contexts           : opt_port_contexts opt_netif_contexts opt_node_c=
ontexts
>                         ;
>  opt_port_contexts       : port_contexts
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index 8f9d73d6..6e59e9db 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -211,8 +211,6 @@ domby |
>  DOMBY                          { return(DOMBY);}
>  INCOMP |
>  incomp                         { return(INCOMP);}
> -fscon |
> -FSCON                           { return(FSCON);}
>  ibpkeycon |
>  IBPKEYCON                      { return(IBPKEYCON);}
>  ibendportcon |
> diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/po=
licy_allonce.conf
> index 5e09f74b..4115dea2 100644
> --- a/checkpolicy/tests/policy_allonce.conf
> +++ b/checkpolicy/tests/policy_allonce.conf
> @@ -67,8 +67,6 @@ constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D =
r2 and t1 =3D=3D t2));
>  validatetrans CLASS2 sameuser and t3 =3D=3D ATTR1;
>  sid kernel USER1:ROLE1:TYPE1
>  sid unlabeled USER1:ROLE1:TYPE1
> -# fscon statements are not dumped
> -fscon 2 3 USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
>  fs_use_xattr btrfs USER1:ROLE1:TYPE1;
>  fs_use_trans devpts USER1:ROLE1:TYPE1;
>  fs_use_task pipefs USER1:ROLE1:TYPE1;
> diff --git a/checkpolicy/tests/policy_allonce_mls.conf b/checkpolicy/test=
s/policy_allonce_mls.conf
> index fa182906..fb742086 100644
> --- a/checkpolicy/tests/policy_allonce_mls.conf
> +++ b/checkpolicy/tests/policy_allonce_mls.conf
> @@ -71,8 +71,6 @@ constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D =
r2 and t1 =3D=3D t2));
>  # sameuser will be turned into (u1 =3D=3D u2)
>  validatetrans CLASS2 sameuser and t3 =3D=3D ATTR1;
>  sid kernel USER1:ROLE1:TYPE1:s0 - s1:c0.c1
> -# fscon statements are not dumped
> -fscon 2 3 USER1:ROLE1:TYPE1:s0 USER1:ROLE1:TYPE1:s0
>  fs_use_xattr btrfs USER1:ROLE1:TYPE1:s0 - s1:c0.CATALIAS;
>  fs_use_trans devpts USER1:ROLE1:TYPE1:s0 - s0;
>  fs_use_task pipefs USER1:ROLE1:TYPE1:s0 - s1;
> --
> 2.54.0
>
