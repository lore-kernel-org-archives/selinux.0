Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C67C77B75
	for <selinux@archiver.kernel.org>; Wed,  3 May 2023 18:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjECSe7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 May 2023 14:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjECSen (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 May 2023 14:34:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CFC7D8B
        for <selinux@vger.kernel.org>; Wed,  3 May 2023 11:34:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f137dbaa4fso1406962e87.2
        for <selinux@vger.kernel.org>; Wed, 03 May 2023 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683138865; x=1685730865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVk7wrNJHr7l2K+19NoQsFvBJzolnT62XzINoSB2C2Q=;
        b=P+LfQa6rnFySG95uzNvl7Btxq1HMIcprBLnEmNj2ikh5GqOJtN8GrbxlbWWgpYW0kG
         MoNdfNxYf9J7yf4Lj7A9QaJKWmh8Sm8EzdO5pZW9qfRG5+rsAJFuDcwQG99ycFnti+t6
         klb/LrTt1aEh8irpE6BKY/WjwfXTa0jNLQrmvssHU1xrNFSvZOUApzSk0sHiy1zGx+i5
         B7YpEJZmPaBN2luw2Zai1oz5RquwiNkHysWpA85sY0LsVoO0MUl1i3eeKki1VJIHv8n+
         TCTecjO1xobkPZ958eg6WxjBkm8GmBo11Sd8f49EsVEA2ytAs7JiX6cobhSfZQEXBtnL
         TS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683138865; x=1685730865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVk7wrNJHr7l2K+19NoQsFvBJzolnT62XzINoSB2C2Q=;
        b=imJjNt+0aqRB+lKazutMYrBoJKBOmVuSA0A5ZpShGsAAawBtPyIYP+98FLoFpdhOBB
         MuWaproeHwN625BR5lJ4/sKT7Hnucy9cIpXHFKGSx6vUn+bEMDMwa9msz+TNsJ1Lg99u
         MelmMOEF5BXHdKpnJ2w+JZhUodSE5pxpIpM74EiUgjkRrs7LH9CyhiKQV2pjrdUSHrxV
         plwT2a8NaaQrgSkdgbrkk9hoEUBfFv8bJgcMj+ypyl9fySVvigY7VSmuSWyO/3nffywB
         Sc+KPi8K/BDUdj3DGNNRB2WIjAAa5GgODWc9vpwIasbNq7lI58KmQmPqqjAOfheEvv6q
         3vdg==
X-Gm-Message-State: AC+VfDy0gITpL3FpIDIqqeuelVoP5hV8PpRTvkmeifDBAZ7m0FgaKWpG
        8AOC5MWP6MymDmTHXBDS9g0z9oYwyLTP8MrCQxU=
X-Google-Smtp-Source: ACHHUZ5k2OXvJVGG/WM4yrz/fPJtNdnVRV2jN7mTt9M/QoVIsbbWECAAySk9M8kA1cSZOQEaa74EX0WWFhWncr/kR3w=
X-Received: by 2002:ac2:4196:0:b0:4e7:fa9a:4d3c with SMTP id
 z22-20020ac24196000000b004e7fa9a4d3cmr1059076lfh.16.1683138864875; Wed, 03
 May 2023 11:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230503120332.699464-1-vmojzis@redhat.com> <20230503120332.699464-2-vmojzis@redhat.com>
In-Reply-To: <20230503120332.699464-2-vmojzis@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 3 May 2023 14:34:13 -0400
Message-ID: <CAP+JOzS-uvCErLiQVrqeOnhqo1vmcOmX9xmca7XJrB5M4eph6A@mail.gmail.com>
Subject: Re: [PATCH 1/3] python/chcat: Improve man pages
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 3, 2023 at 8:11=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wrot=
e:
>
> - Explain applying range/list of categories
> - "-d" removes all categories of given file/user
> - Add examples
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/chcat/chcat.8 | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/python/chcat/chcat.8 b/python/chcat/chcat.8
> index d095a255..ae65fef1 100644
> --- a/python/chcat/chcat.8
> +++ b/python/chcat/chcat.8
> @@ -1,6 +1,6 @@
>  .TH CHCAT "8" "September 2005" "chcat" "User Commands"
>  .SH NAME
> -chcat \- change file SELinux security category
> +chcat \- change SELinux security categories of files/users
>  .SH SYNOPSIS
>  .B chcat
>  \fIcategory file\fR...
> @@ -25,23 +25,33 @@ chcat \- change file SELinux security category
>  .br
>  .SH DESCRIPTION
>  .PP
> -Change/Remove the security \fIcategory\fR for each \fIfile\fR or \fIuser=
\fR.
> -.PP
> -Use +/- to add/remove categories from a \fIfile\fR or \fIuser\fR.
> +Use +/- to add/remove categories from a \fIfile\fR or \fIuser\fR (only a=
 single category can be specified at a time). Or specify the desired list/r=
ange of categories to be applied (replacing the existing categories).
>  .PP
>  .B
>  Note:
> -When removing a category you must specify '\-\-' on the command line bef=
ore using the \-Category syntax.  This tells the command that you have fini=
shed entering options and are now specifying a category name instead.
> +When removing a category you must specify '\-\-' on the command line bef=
ore using the \-Category syntax. This tells the command that you have finis=
hed entering options and are now specifying a category name instead.
>
>  .TP
>  \fB\-d\fR
> -delete the category from each FILE/USER.
> +delete all categories from given FILE/USER.
>  .TP
>  \fB\-L\fR
>  list available categories.
>  .TP
>  \fB\-l\fR
>  Tells chcat to operate on users instead of files.
> +
> +.SH EXAMPLE
> +.nf
> +Replace categories of user "test" with c0.c6
> +# chcat -l c0.c6 test
> +Add category c1023 to user "test"
> +# chcat -l +c1023 test
> +Remove category c5 from file "file"
> +# chcat -- -c5 file
> +Remove all categories from file "file"
> +# sudo chcat -d file

Don't want the sudo here.

Everything else looks fine with this patch.

Thanks,
Jim


> +
>  .SH "SEE ALSO"
>  .TP
>  chcon(1), selinux(8), semanage(8)
> @@ -52,4 +62,3 @@ When operating on files this script wraps the chcon com=
mand.
>  /etc/selinux/{SELINUXTYPE}/setrans.conf
>  .br
>  /etc/selinux/{SELINUXTYPE}/seusers
> -
> --
> 2.40.0
>
