Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5970C433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 15:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA85206A4
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 15:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1voqlIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgFHPvn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730326AbgFHPvm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 11:51:42 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A310BC08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 08:51:41 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id q188so3552074ooq.4
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=npR0W4z8SIrkM+X34koGpbw9r1nz+qk9vfZSzkBNpdc=;
        b=A1voqlIKM32ow4AsTtuBep3e1WSzRHmBdWXltOoD9hTzLajTNsjwpLAHg4XApz9cWn
         pZgN26PdGQEW6DAgNSdy+1WQXVyac+wqyH0sQqDwhhzRhV5pZyNJZ5hkAGckuCIbctEs
         1vX2uHd6u5AH96v9LA+ul8s/rL3F+5BuSs+9Df8dESuISbgcV9Pf9Djkphi8xJmnnbwC
         lFirQrRVlRoM6IGGfH6M8czVs/1GW/NbJ00weq/JSyX/OME+JmxVhPgayJCJVGTOVu63
         DlK0GS78PmJB3VIDCzTKlzP4UV7T/3RGJxwuuzm82CDkytjN8M7SdYQJ6c1J692+reZ6
         A9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=npR0W4z8SIrkM+X34koGpbw9r1nz+qk9vfZSzkBNpdc=;
        b=iFz9QlAzz35FxKYle+V9pPn1MbxalPdYWi7jDkeugdLLw+koshv91OnQ4YnkYQvZPR
         /PP3Rac/x68ZI4cjr7LjrcPK80UCKFKV9tA4Zn6W0rejfElHdvMN9djQjul5UCC/bPvs
         9agGVuAAViHVur1/TkJjF2kfTQkkCbVhEwQyzKF59PuwQtqcOIa1WciW7dfYm7mowIuf
         KUFJP9QqLnup//vOoX+B096IL+fD2d7cmBn1tIJZr5yoQnflzvUW1zy7qH8QNVg4OwPI
         RB/u7MuqoFOQKnKJZ5BEpmEvJOUlODPG9MLepcEy7QEbiHJpkdf4qoGfHJjciKlN8iGS
         bvFg==
X-Gm-Message-State: AOAM531AXMD5u01b4mRxMnGlkrpJg2kaQmcd8kaqKeMx7FRiOa5xVeRQ
        mprRdrPD3SG5SUxkk7AtlnkAz7uLSe/bLb5eFoQ=
X-Google-Smtp-Source: ABdhPJzckQqowWoBjIHdGdp0TqOwHj6Ah505kA+bysD+2KDqik6vWNp32npdEln3cvPB3/Yq6SBG3vWPABaX3j0H4Js=
X-Received: by 2002:a4a:e74a:: with SMTP id n10mr17581369oov.71.1591631500752;
 Mon, 08 Jun 2020 08:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200528125128.26915-1-cgzones@googlemail.com>
 <20200605144912.22522-1-cgzones@googlemail.com> <20200605144912.22522-3-cgzones@googlemail.com>
In-Reply-To: <20200605144912.22522-3-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 8 Jun 2020 11:51:30 -0400
Message-ID: <CAEjxPJ7ijbkLTYBjOu=LgxixZ+U4Xr6iQtQf8BEtV853XNEhoA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] sepolgen-ifgen: refactor default policy path retrieval
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 5, 2020 at 10:49 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On a SELinux disabled system the python call
> `selinux.security_policyvers()` will fail.
>
> Move the logic to find a binary policy by iterating over appended
> version suffixes from the python script `sepolgen-ifgen` to the C
> helper `sepolgen-ifgen-attr-helper` to make use of the libsepol
> interface `sepol_policy_kern_vers_max()`.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

I think there are two problems with this change:
1) It drops the attempt to use /sys/fs/selinux/policy entirely, even
if SELinux-enabled.
2) It will incorrectly try to append version suffixes to a pathname
specified via -p and open those files if the user made a mistake and
specified a non-existent file rather than just reporting an error on
the original user-supplied path.

Instead, switch the helper to take a -p pathname optional argument
with no required argument, and if no pathname was specified, then have
the helper itself try selinux_current_policy_path() and then
selinux_binary_policy_path() + version suffixes.  This will require
linking the helper with libselinux but I don't see that as a problem
since it was already a dependency for the python script.  We don't
have to worry about the helper command line interface being stable
IMHO since it is just an internal helper and not directly used by end
users.

> ---
> v3: Move the iteration logic from sepolgen-ifgen to
>     sepolgen-ifgen-attr-helper and use sepol_policy_kern_vers_max()
>     instead of selinux.security_policyvers(), to work on SELinux
>     disabled systems
>
>  python/audit2allow/sepolgen-ifgen             | 26 ++-----------
>  .../audit2allow/sepolgen-ifgen-attr-helper.c  | 39 ++++++++++++++++---
>  2 files changed, 37 insertions(+), 28 deletions(-)
>
> diff --git a/python/audit2allow/sepolgen-ifgen b/python/audit2allow/sepol=
gen-ifgen
> index 4a71cda4..19c3ee30 100644
> --- a/python/audit2allow/sepolgen-ifgen
> +++ b/python/audit2allow/sepolgen-ifgen
> @@ -27,7 +27,6 @@
>
>
>  import sys
> -import os
>  import tempfile
>  import subprocess
>
> @@ -65,34 +64,15 @@ def parse_options():
>      return options
>
>
> -def get_policy():
> -    p =3D selinux.selinux_current_policy_path()
> -    if p and os.path.exists(p):
> -        return p
> -    i =3D selinux.security_policyvers()
> -    p =3D selinux.selinux_binary_policy_path() + "." + str(i)
> -    while i > 0 and not os.path.exists(p):
> -        i =3D i - 1
> -        p =3D selinux.selinux_binary_policy_path() + "." + str(i)
> -    if i > 0:
> -        return p
> -    return None
> -
> -
>  def get_attrs(policy_path, attr_helper):
> +    if not policy_path:
> +        policy_path =3D selinux.selinux_binary_policy_path()
> +
>      try:
> -        if not policy_path:
> -            policy_path =3D get_policy()
> -        if not policy_path:
> -            sys.stderr.write("No installed policy to check\n")
> -            return None
>          outfile =3D tempfile.NamedTemporaryFile()
>      except IOError as e:
>          sys.stderr.write("could not open attribute output file\n")
>          return None
> -    except OSError:
> -        # SELinux Disabled Machine
> -        return None
>
>      fd =3D open("/dev/null", "w")
>      ret =3D subprocess.Popen([attr_helper, policy_path, outfile.name], s=
tdout=3Dfd).wait()
> diff --git a/python/audit2allow/sepolgen-ifgen-attr-helper.c b/python/aud=
it2allow/sepolgen-ifgen-attr-helper.c
> index 1ce37b0d..dab6fb15 100644
> --- a/python/audit2allow/sepolgen-ifgen-attr-helper.c
> +++ b/python/audit2allow/sepolgen-ifgen-attr-helper.c
> @@ -147,13 +147,42 @@ static policydb_t *load_policy(const char *filename=
)
>         policydb_t *policydb;
>         struct policy_file pf;
>         FILE *fp;
> +       char pathname[PATH_MAX];
> +       int suffix_ver;
>         int ret;
>
> -       fp =3D fopen(filename, "r");
> -       if (fp =3D=3D NULL) {
> -               fprintf(stderr, "Can't open '%s':  %s\n",
> -                       filename, strerror(errno));
> -               return NULL;
> +       /*
> +        * First use the pure given path.
> +        * If it does not exist use paths with version suffixes,
> +        * starting from the maximum supported policy version.
> +        */
> +       if (access(filename, F_OK) =3D=3D 0) {
> +               fp =3D fopen(filename, "r");
> +               if (fp =3D=3D NULL) {
> +                       fprintf(stderr, "Can't open '%s':  %s\n",
> +                               filename, strerror(errno));
> +                       return NULL;
> +               }
> +       } else {
> +               for (suffix_ver =3D sepol_policy_kern_vers_max(); suffix_=
ver > 0; suffix_ver--) {
> +                       snprintf(pathname, sizeof(pathname), "%s.%d", fil=
ename, suffix_ver);
> +
> +                       if (access(pathname, F_OK) =3D=3D 0)
> +                               break;
> +               }
> +
> +               if (suffix_ver <=3D 0) {
> +                       fprintf(stderr, "Can't find any policy at '%s'\n"=
,
> +                               filename);
> +                       return NULL;
> +               }
> +
> +               fp =3D fopen(pathname, "r");
> +               if (fp =3D=3D NULL) {
> +                       fprintf(stderr, "Can't open '%s':  %s\n",
> +                               pathname, strerror(errno));
> +                       return NULL;
> +               }
>         }
>
>         policy_file_init(&pf);
> --
> 2.27.0
>
