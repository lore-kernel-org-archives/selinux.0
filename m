Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198F4C433F5
	for <selinux@archiver.kernel.org>; Tue, 25 Jan 2022 19:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiAYTqy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 14:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiAYTqZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 14:46:25 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EC9C06175E
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 11:46:14 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id q22so9655863ljh.7
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 11:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1ikFUcN/tVzW0fMx/FxScW5ahceyJ22Tp7p5x3rRO04=;
        b=CWv1dcqS9d6z8NlzDMCXj6rpH318FLRdFz5BY/i0Nq/W+uFGbdiDpgTdTCnQt14tXc
         reNilqW32iAwQTb8YsYUb4vNhVJH1SSSAygrjtDqnfZ9pv+fmYv/jsy9H45TAtbH1Rb8
         u1XrRhQNg7V3PFsCNcIJPKXLqcPvCELeDeQcMP1sTlEKik2PSk9IaMt+5zBCkR/Pp/5Y
         FDhUw9nr9lkJnqJMmpRYpSthLjAJhyTzt3VBy3PNb3AnxYLljB2JHuyZ1LIam45cKkPs
         vxsO038RSEQ7K/hsYfx0kh0Y6yT1j8o0NFtUOBSQbg1TJBgwBWbJzbkQGZypFtR19Fhx
         zLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1ikFUcN/tVzW0fMx/FxScW5ahceyJ22Tp7p5x3rRO04=;
        b=rmtZOAQqnP4jJ5LAYkPSfjxpm3GAaMgMZVgB9HbMHBmvOUQjtAoF1nqPhr5qXFQyQA
         OiFS98YgEScdeX0zOhEuOF0+RAAhI6SNpJqrvJIZHyRDDmcRTQ1herDXLYWDbZ5XsVTN
         A9jgsWXcS88NIz+ii6SDXVLWbHrpL08wPzwMh0LQKIgD5RgG7CNFuE05gKi0QxuP4fZA
         8fN4RdHbo6r5mh1PwtoOaGbeN7+jIAyL0h/lKbVELfMdwHtBK58LIcZZ/Ba/4uAanhjX
         hFIQbXnpCbyqSraCW2yZWPiJfj/IYQbpgq1WsS9XAduF3pwHIfnwxyzD40fNZ05Qhxk3
         4ziw==
X-Gm-Message-State: AOAM5307QNs9cStot+S0qnt1tzgoa+mIY0BBSFzSJfGMgY5hZuPuKR7j
        5VNz9fi8BG2gz+hz52VRVIVcou8w2r6X3YgnNHL9sQ==
X-Google-Smtp-Source: ABdhPJzPuKCgEjEjJHS0X0O6pfg/Jc6Cj92bekA8cLL6QcjUutztZ41ZgQaRpvglGyC6VvuyAkF9v2v6ZwHcD0s1n4E=
X-Received: by 2002:a2e:9610:: with SMTP id v16mr7963140ljh.339.1643139973065;
 Tue, 25 Jan 2022 11:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-9-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-9-cgzones@googlemail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jan 2022 11:46:00 -0800
Message-ID: <CAKwvOdmkfSQrLL2+fbjnRoY3wiRfpxLUU4YwP+XaiCwNrbi9ww@mail.gmail.com>
Subject: Re: [PATCH 1/9] selinux: check return value of sel_make_avc_files
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 6:15 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> sel_make_avc_files() might fail and return a negative errno value on
> memory allocation failures. Re-add the check of the return value,
> dropped in 66f8e2f03c02.
>
> Reported by clang-analyzer:
>
>     security/selinux/selinuxfs.c:2129:2: warning: Value stored to 'ret' i=
s never read [deadcode.DeadStores]
>             ret =3D sel_make_avc_files(dentry);
>             ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 66f8e2f03c02 ("selinux: sidtab reverse lookup hash table")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  security/selinux/selinuxfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index e4cd7cb856f3..f2f6203e0fff 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -2127,6 +2127,8 @@ static int sel_fill_super(struct super_block *sb, s=
truct fs_context *fc)
>         }
>
>         ret =3D sel_make_avc_files(dentry);
> +       if (ret)
> +               goto err;
>
>         dentry =3D sel_make_dir(sb->s_root, "ss", &fsi->last_ino);
>         if (IS_ERR(dentry)) {
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
