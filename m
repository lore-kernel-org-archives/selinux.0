Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A986C433EF
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 14:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9AD610E6
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 14:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhJNOMU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Oct 2021 10:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhJNOMU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Oct 2021 10:12:20 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F8AC061570
        for <selinux@vger.kernel.org>; Thu, 14 Oct 2021 07:10:15 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso8346673ota.9
        for <selinux@vger.kernel.org>; Thu, 14 Oct 2021 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d0NpGo8V12A5Aec/BENNrRRJ2HYCu9NvhL4v+vTQNeE=;
        b=CtaD1/tdmmmjVnFLkgBOcNhkhPzMWPqgyGK35SN57lB/WhJPyunlPqs1uhzoluzbS0
         dCxv12CU7nYCjF/4BBDIDJkctBJCf8Om7hpYuFEszrOxpbrT9Mffv8oCJ1t36M99ZFp/
         5dB/lkAtE6juQPnc1NAzkD2SfuxJ0HJHwLG1OkNYwIngzyuObTqeGS9+Y3PBGgauZU7r
         noJOqJ04Q4NV7PhWkeyVFKKNgz9+N4NaiYLic3mnEmk13cwhblSnGuw55UlNpAGaaXBs
         PsZtlFKVaOvtOulh1emcWMY5BWBXlrACBpunrzhWagz4M7k15crFUsTDdGjtGiUG4I03
         11JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d0NpGo8V12A5Aec/BENNrRRJ2HYCu9NvhL4v+vTQNeE=;
        b=Y+0v5i9eqxysTJdjYek2oh+zPGLISuTR1MB8cOGqFjXg+bSGKbY0KdVQ76YxKBvInf
         i9idi8y54F87gcYBnc6WHRVOGQFWhvUGeid6hrDjU2KJe18dSxNAz5Mn+cLmff444w9O
         KxQ/uUQEjuXrH7cmXWPe40Tt5WWoYQBzA7XKDzqgcNnMmzx9NUqYTrxMRJjHwIXZ/HMu
         FWHGWRN7Tw1QJfsWDPU/bRZPt7JunHZVBdlRZuWqm4yDZf5HmhC63a354nTjtbWPOcYW
         MsHrirCRN6xQgi6xOQbL+HicTe+24cX87oDuVZI5Ki2RrnyYGC2BlMYn78dHwrHBjHQU
         Lkyg==
X-Gm-Message-State: AOAM532jIEaII9vD9h+E6qTKo2ue5lIQMIto4YidX0sIeHDUbBl5UBoQ
        T/E19TsRe3qENwaPOcDw3cAb+6uZEmQtkCuqXNpaO9YG
X-Google-Smtp-Source: ABdhPJz9PGJK7ZR1UbQAAeMVmkDeuWjDIX/Y3IviaERwIrosqswdLwUcSdkhJGi3SewyNi6YVzjIoYqIDF2p5cOshuk=
X-Received: by 2002:a05:6830:1acc:: with SMTP id r12mr2700178otc.154.1634220614518;
 Thu, 14 Oct 2021 07:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com> <20211011162533.53404-29-cgzones@googlemail.com>
In-Reply-To: <20211011162533.53404-29-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 14 Oct 2021 10:10:03 -0400
Message-ID: <CAP+JOzREerZYGsLduOJsT0tD94dt7cqhucMT=-3oKXsyNXKphA@mail.gmail.com>
Subject: Re: [RFC PATCH 28/35] libsepol: validate ocontexts
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 11, 2021 at 12:41 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
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
> ---
>  libsepol/src/policydb_validate.c | 37 ++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 9134e541..5c06e6f4 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -677,6 +677,41 @@ static int validate_filename_trans_hashtab(sepol_han=
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
> +                       if ((i =3D=3D OCON_FS || i =3D=3D OCON_NETIF) && =
validate_context(&octx->context[1], flavors, p->mls))
> +                               goto bad;
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
> @@ -861,6 +896,8 @@ int validate_policydb(sepol_handle_t *handle, policyd=
b_t *p)
>                         goto bad;
>                 if (validate_role_allows(handle, p->role_allow, flavors))
>                         goto bad;
> +               if (validate_ocontexts(handle, p, flavors))
> +                       goto bad;
>                 if (p->policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS)
>                         if (validate_filename_trans_hashtab(handle, p->fi=
lename_trans, flavors))
>                                 goto bad;
> --
> 2.33.0
>

ocontexts are also in base modules.
Jim
