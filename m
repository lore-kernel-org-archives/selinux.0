Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C296CC77B78
	for <selinux@archiver.kernel.org>; Thu,  4 May 2023 14:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjEDOGh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 May 2023 10:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjEDOGg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 May 2023 10:06:36 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4138D46BB
        for <selinux@vger.kernel.org>; Thu,  4 May 2023 07:06:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4efeea05936so619177e87.2
        for <selinux@vger.kernel.org>; Thu, 04 May 2023 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683209193; x=1685801193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtzhorbA6J45KMyuD5gYbGUR3ZUi1Fa3o38ByCBi5aE=;
        b=bQy3+IsE9nrY5X4QtmNybu4rhHywc0I9L2/Df+OCSamtzwx23JchwqRCKZ7L0x3UTN
         FzgfIkbpCzjj24LbuGb0cSHSaFgFBr+61hXw++V3I0r3TPNSPSm4NrVmYh8z435r++Dd
         89VjIZt69TB0puUIKRHHIMKKTI11UCKL1XL5OAe9EL0viMEhYDAAlx4f3dzl0VWh/j1V
         Y+HfXWcMshMrALKIAsifGHGtjxmcYer3Qd9f1P3l5+fBBdIu9y0OyvjgLDOiHBS+gFG3
         rLVVvaY6e+RCSYrk6CtgpXcVBlJYYbsWzMKG7gXizeA7BMwjgLGrFE6QfkvenneXkjBs
         QyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683209193; x=1685801193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtzhorbA6J45KMyuD5gYbGUR3ZUi1Fa3o38ByCBi5aE=;
        b=Nbv7QICtdOG2NFxWmmFkPyK2oK5ofsIQ5JGcRKXgEIIN1GSRygu0trU8rnmpGPaArI
         tI6+01MyTyXPRO2mE4E7UXVRsAaNuau83gRAppqvCjWqL+2ikquuyZHgiXgVExcjHygE
         brEjbWloTa3tnHm+57+QQQAq/HQTu46DxAeuI58loBsA9NkOaUNuRatyHRimwDlnije8
         0vKFAZm6ybewiUne9cG7LIe6NlyadbG1e9dEmiOX75oqM99IwgWeRY1xsoik79J4Rxqe
         rZU+T7OMin1V5fxQidsJlW4faqQ/wgVZRor48SzfK/zMoWKrwpy01iX8kU/WYFpOfrbK
         7UCQ==
X-Gm-Message-State: AC+VfDyapDNjXAvD0F07CCbaSAomPuQkACR6u+BEWhAEH68i1G4d+aXo
        aHloRbxl8Yk58UJM6/0qhW0Pykek/hP5b6F7xAw=
X-Google-Smtp-Source: ACHHUZ6DtStECm+ttkgSVmWT0iU5pBUg5Av5Ed5ujJ/olgjZ03z7NCc7Zq6dHkfkwar94EIFgIPyPquy7pwSH8b67fU=
X-Received: by 2002:ac2:508d:0:b0:4eb:18d:91df with SMTP id
 f13-20020ac2508d000000b004eb018d91dfmr1624692lfm.27.1683209193333; Thu, 04
 May 2023 07:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAP+JOzQBSknYVqAqhu6WGwnTDBCXc-P1B73+MnfbcEyGi621CA@mail.gmail.com>
 <20230504120450.771407-1-vmojzis@redhat.com> <20230504120450.771407-2-vmojzis@redhat.com>
In-Reply-To: <20230504120450.771407-2-vmojzis@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 4 May 2023 10:06:22 -0400
Message-ID: <CAP+JOzQR=8PSe8AXDvBWoA4LXHCbO_eHJJGuSduH4g-uPHqnRA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] python/chcat: Improve man pages
To:     CAP+JOzQBSknYVqAqhu6WGwnTDBCXc-P1B73+MnfbcEyGi621CA@mail.gmail.com
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 4, 2023 at 8:06=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wrot=
e:
>
> - Explain applying range/list of categories
> - "-d" removes all categories of given file/user
> - Add examples
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

For all four of these patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/chcat/chcat.8 | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/python/chcat/chcat.8 b/python/chcat/chcat.8
> index d095a255..3e1f7ca2 100644
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
> +# chcat -d file
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
