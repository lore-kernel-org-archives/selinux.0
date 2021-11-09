Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F3FC433EF
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 19:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3654C610CB
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 19:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbhKITHY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Nov 2021 14:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhKITHY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Nov 2021 14:07:24 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC38AC061764
        for <selinux@vger.kernel.org>; Tue,  9 Nov 2021 11:04:37 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so178141otl.3
        for <selinux@vger.kernel.org>; Tue, 09 Nov 2021 11:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r1yePGvAPZNhxg9Lf6Tw2HP3mWYEcsFX2hkIj8tof9Y=;
        b=BbIh5UJ81/bWDTfJvYFzC3fVVq8OfzKLCzukgkrh94pddpwHBYTcqSGy4O+agciHUl
         GrW5gi2HiE/wWHPIVh9bDfbN9ecvxtvzaSnclnfm/NhNLyQoSFYalfI7b/NAHNi53hvd
         aSvBwy37ELlFg97sJs3BabR36lswHtbDjpxs8e4Mi3xnXq+GTddi/5KzPI9TiKq2Gd6r
         xw4tY87FlF2GCLRakzre+r/TjS/e7Opjoc5PjLeLKehSl4Prg7XLX4JAJkKDP5iDX7xt
         vkDnRokeZi02Pi5bWPqB/HZcSq4tT3rNZLmILYHCRkVP6X00Y28MAVUFUcFBcQeF+CiL
         y+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r1yePGvAPZNhxg9Lf6Tw2HP3mWYEcsFX2hkIj8tof9Y=;
        b=eW70d2BT9IGTIjKoD73BNqaLjleKPGgrYG+Aq3Cjcr797SVk75v5TRY1/br9qNXxhi
         eiyr1j6nQTMIztvQ+l3p+O0lYzOYyTDq9M018FdcXyvV/Jq5tkzGfTi0Ws6Et+4a+ZZe
         0qeOUnpe6NrwAoyNLZ+a8xJwkkTlzyAvBUccgSJp9C3o6YkTKGiZgx7VoEOGeNq4vM3Y
         MactCAt3oDQwlmT9jusAq1dZxcsF9hge2ue5SVmxcCEOA4cuf0JpiKPmNWXSYHZeeN1o
         hfFQ4mwq2Cg3TJjP9t75/BQrjmAVbtpi4IF0SLNtNvOyDAvheKBfxQw5qfRaeAXn+/ww
         tJ/w==
X-Gm-Message-State: AOAM532HLphiWqHle4KCqWfE6TGIVWfGN3hvzD2U9MpGAERIH3yE+2rA
        m91U3lPdc+jxU6w2vfoaaNFnUK0SQQiB/fqkfVGwkRRcR7w=
X-Google-Smtp-Source: ABdhPJzs6kwfixlSAi/JIgzCbG5fR3gjPh80K0I7B6WutqMgzi0QKg7I+FfEhSDdWpzzuMl+2u0YvOyg2QCS74vkz7c=
X-Received: by 2002:a9d:6346:: with SMTP id y6mr8196278otk.154.1636484677290;
 Tue, 09 Nov 2021 11:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com> <20211105154542.38434-31-cgzones@googlemail.com>
In-Reply-To: <20211105154542.38434-31-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 9 Nov 2021 14:04:26 -0500
Message-ID: <CAP+JOzSGHwq9vtNJ81iNgazwuZNZEg631wNsFuAo0vs_eMJ-pw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 30/36] libsepol: validate ocontexts
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 5, 2021 at 12:11 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Check the literal contexts in ocontext statements are defined.
>
>     =3D=3D91274=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0=
00000000000 (pc 0x7f60b0afe8c6 bp 0x7ffd42edc990 sp 0x7ffd42edc148 T0)
>     =3D=3D91274=3D=3DThe signal is caused by a READ memory access.
>     =3D=3D91274=3D=3DHint: address points to the zero page.
>         #0 0x7f60b0afe8c6  string/../sysdeps/x86_64/multiarch/../strlen.S=
:120
>         #1 0x4bd128 in __interceptor_strlen (./out/binpolicy-fuzzer+0x4bd=
128)
>         #2 0x5eb387 in create_str_helper ./libsepol/src/kernel_to_common.=
c:69:10
>         #3 0x5eb11e in create_str ./libsepol/src/kernel_to_common.c:99:8
>         #4 0x56ad7b in context_to_str ./libsepol/src/kernel_to_conf.c:240=
8:9
>         #5 0x56a717 in write_sid_context_rules_to_conf ./libsepol/src/ker=
nel_to_conf.c:2441:9
>         #6 0x55b26c in write_selinux_isid_rules_to_conf ./libsepol/src/ke=
rnel_to_conf.c:2476:9
>         #7 0x55b26c in sepol_kernel_policydb_to_conf ./libsepol/src/kerne=
l_to_conf.c:3206:8
>         #8 0x55a34f in LLVMFuzzerTestOneInput ./libsepol/fuzz/binpolicy-f=
uzzer.c:38:9
>         #9 0x45aed3 in fuzzer::Fuzzer::ExecuteCallback(unsigned char cons=
t*, unsigned long) fuzzer.o
>         #10 0x446a12 in fuzzer::RunOneTest(fuzzer::Fuzzer*, char const*, =
unsigned long) fuzzer.o
>         #11 0x44c93b in fuzzer::FuzzerDriver(int*, char***, int (*)(unsig=
ned char const*, unsigned long)) fuzzer.o
>         #12 0x475dd2 in main (./out/binpolicy-fuzzer+0x475dd2)
>         #13 0x7f60b0a887ec in __libc_start_main csu/../csu/libc-start.c:3=
32:16
>         #14 0x423689 in _start (./out/binpolicy-fuzzer+0x423689)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> ---
> v2:
>    also check in base modules
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb_validate.c | 44 ++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 57eb2550..96f133c9 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -736,6 +736,47 @@ static int validate_filename_trans_hashtab(sepol_han=
dle_t *handle, hashtab_t fil
>         return 0;
>  }
>
> +static int validate_context(context_struct_t *con, validate_t flavors[],=
 int mls)
> +{
> +       if (validate_value(con->user, &flavors[SYM_USERS]))
> +               return -1;
> +       if (validate_value(con->role, &flavors[SYM_ROLES]))
> +               return -1;
> +       if (validate_value(con->type, &flavors[SYM_TYPES]))
> +               return -1;
> +       if (mls && validate_mls_range(&con->range, &flavors[SYM_LEVELS], =
&flavors[SYM_CATS]))
> +               return -1;
> +
> +       return 0;
> +}
> +
> +static int validate_ocontexts(sepol_handle_t *handle, policydb_t *p, val=
idate_t flavors[])
> +{
> +       ocontext_t *octx;
> +       unsigned int i;
> +
> +       for (i =3D 0; i < OCON_NUM; i++) {
> +               for (octx =3D p->ocontexts[i]; octx; octx =3D octx->next)=
 {
> +                       if (validate_context(&octx->context[0], flavors, =
p->mls))
> +                               goto bad;
> +
> +                       switch (i) {
> +                       case OCON_FS:
> +                       case OCON_NETIF:
> +                               if (validate_context(&octx->context[1], f=
lavors, p->mls))
> +                                       goto bad;
> +                               break;

Should use a default case.

The bigger issue, which I didn't catch the first time, is that this
doesn't work for a XEN policy.
In policydb.c there is an ocontext_read_xen() and an
ocontext_read_selinux(), which is called depends on whether
p->target_platform is SEPOL_TARGET_SELINUX or SEPOL_TARGET_XEN.

Jim


> +                       }
> +               }
> +       }
> +
> +       return 0;
> +
> +bad:
> +       ERR(handle, "Invalid ocontext");
> +       return -1;
> +}
> +
>  /*
>   * Functions to validate a module policydb
>   */
> @@ -936,6 +977,9 @@ int validate_policydb(sepol_handle_t *handle, policyd=
b_t *p)
>                         goto bad;
>         }
>
> +       if (validate_ocontexts(handle, p, flavors))
> +               goto bad;
> +
>         if (validate_scopes(handle, p->scope, p->global))
>                 goto bad;
>
> --
> 2.33.1
>
