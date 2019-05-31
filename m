Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABA6C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556E526F12
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 21:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jlSLXLjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfEaVCC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 17:02:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36149 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfEaVCB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 17:02:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id m22so10656153ljc.3
        for <selinux@vger.kernel.org>; Fri, 31 May 2019 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBFO4xLVOKowEX73o/UJ70EQIjoomi+r5kwcEqgkzsY=;
        b=jlSLXLjvTRyW5XrCiaHTrMZXmotaA4vbQZj9xWHLcfm1t5hn3xrlqeCOu+Iw/e+wfK
         lIXOeknZXq7guoBLxomycyxHOmCjHudHviPbW/J8xcD6dXtNlFkJFhyQT6LyatXzQ4qt
         /PYEoVmf54aKuLq7qvJYVUL922IhSO3t06cxa/HnZVbMgMzZ3GDvH6gjXF45P3gQPakr
         aU1HScRVlHjgZAWcQMGmyNnNQyB19x45geCfISy3bhO12SqWLwthMYgXmP3vDFs1/p+X
         EJ3XxGzM6hXKLoYQ1Qx0hQ6F6S7KM+AwoFnPcq/XOXgqeRGGyyffo6dC3gtUvdtIDsLY
         aDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBFO4xLVOKowEX73o/UJ70EQIjoomi+r5kwcEqgkzsY=;
        b=MLtzolEF+Whrae53TiZezPoijsYrO+7W6M4f4gJLE7If4DJrSZWhjVTkwvUhig5NR1
         GJTjpx5N+UtJ+mdvI2yp2HO+RnxVSGpzZNnXpC874hLl3hLMfwwrzhPaac5p+GoyermP
         9mM4grpV3V46xSPCxokMb6BND0BwpgwOvU5CKzpale5J0nfgxJlsOYAOwDS0+MyCU/xN
         Y3a+/Rnc8uv/edHrVmw7smOnh2GszRg2x/XLNqkDh57C9cjJL2pPu+EKfDkMc/3bx9az
         T+lKiyXRI+vgU3kxSv4/A6sD9kNpl1qda9v3l0qQ0FT38kS8N3KoYAqIjU13r/Cva1UZ
         PBew==
X-Gm-Message-State: APjAAAXQGIpjMqMSVaO8MqK80zuas9HTkvqIeVpEevBJbOaI+AwUNkT4
        RFrOXpO05RMm+mfoADlEHs/kjksX4rAIsduh6N+cv5I=
X-Google-Smtp-Source: APXvYqxJ9dOgmQApNuRt0Nj3+xhqhVc1fi6rKZt+AfngkSrnj1ZEtr3BN8GibpYjBTexTs9VOreCgqy4ohnKcHLEYEs=
X-Received: by 2002:a2e:9106:: with SMTP id m6mr7165392ljg.164.1559336518647;
 Fri, 31 May 2019 14:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQcrzJ7bQZccJw9v7cYUewMGMRdDVm8bkBwc4KFYsDKng@mail.gmail.com>
 <20190531201905.26607-1-plautrba@redhat.com>
In-Reply-To: <20190531201905.26607-1-plautrba@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 31 May 2019 17:01:47 -0400
Message-ID: <CAHC9VhR6OU-xWJRy=irWdrAefmAt-941=7JU5hT0Sk8i7NeyDw@mail.gmail.com>
Subject: Re: [PATCH v2] Add CONTRIBUTING.md
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 31, 2019 at 4:19 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Based on https://github.com/SELinuxProject/selinux/wiki/Contributing
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>
> github preview is available at
> https://github.com/bachradsusi/SELinuxProject-selinux/blob/add-Contribution/CONTRIBUTING.md
>
>
>  CONTRIBUTING.md | 88 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 CONTRIBUTING.md

Looks good to me.  I don't normally review/ack the userspace bits, but
since I commented previously and you made the changes I feel I should
:)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> new file mode 100644
> index 00000000..25c59eff
> --- /dev/null
> +++ b/CONTRIBUTING.md
> @@ -0,0 +1,88 @@
> +# Contributing to SELinux
> +
> +Contributing to the SELinux userspace project is a similar process to
> +other open source projects. Bug reports, new features to the existing
> +code, additional tools, or updated documentation are all welcome.
> +
> +You can find a list of open issues where you might contribute to the SELinux kernel code at
> +https://github.com/SELinuxProject/selinux-kernel/issues or to the SELinux userspace code at
> +https://github.com/SELinuxProject/selinux/issues.
> +
> +See the selinuxproject.org [user resources
> +page](http://selinuxproject.org/page/User_Resources) for more
> +information on mailing lists, documentation, and other resources.
> +
> +## Reporting Bugs
> +
> +All bugs and patches should be submitted to the [SELinux mailing
> +list](https://lore.kernel.org/selinux) at selinux@vger.kernel.org.
> +
> +When reporting bugs please include versions of SELinux related libraries and
> +tools (libsepol, libselinux, libsemanage, checkpolicy). If you are
> +using a custom policy please include it as well.
> +
> +## Compiling
> +
> +There are a number of dependencies required to build the userspace
> +tools/libraries. On a Fedora system you can install them with yum:
> +
> +    # yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python-devel setools-devel swig ustr-devel
> +
> +The tools and libraries can be built and installed under a private directory from the top level with make, e.g.
> +
> +    $ make DESTDIR=~/obj install install-pywrap
> +
> +## Contributing Code
> +
> +After obtaining the code of the repository (see below), create a patch
> +against the repository, and post that patch to the [SELinux mailing
> +list](https://lore.kernel.org/selinux) at selinux@vger.kernel.org. When preparing
> +patches, please follow these guidelines:
> +
> +-   Patches should apply with -p1
> +-   Must apply against HEAD of the master branch
> +-   Separate large patches into logical patches
> +-   Patch descriptions must end with your "Signed-off-by" line. This means your
> +    code meets the Developer's certificate of origin, see bellow.
> +
> +When adding new, large features or tools it is best to discuss the
> +design on the mailing list prior to submitting the patch.
> +
> +## Development Repository
> +
> +Git is a modern source code management system. For more information
> +about Git please see the Git website.
> +
> +To get an anonymous checkout of the SELinux userland repository you can
> +run:
> +
> +    $ git clone https://github.com/SELinuxProject/selinux.git
> +
> +# Developer Certificate of Origin
> +
> +    Developer's Certificate of Origin 1.1
> +
> +    By making a contribution to this project, I certify that:
> +
> +    (a) The contribution was created in whole or in part by me and I
> +        have the right to submit it under the open source license
> +        indicated in the file; or
> +
> +    (b) The contribution is based upon previous work that, to the best
> +        of my knowledge, is covered under an appropriate open source
> +        license and I have the right under that license to submit that
> +        work with modifications, whether created in whole or in part
> +        by me, under the same open source license (unless I am
> +        permitted to submit under a different license), as indicated
> +        in the file; or
> +
> +    (c) The contribution was provided directly to me by some other
> +        person who certified (a), (b) or (c) and I have not modified
> +        it.
> +
> +    (d) I understand and agree that this project and the contribution
> +        are public and that a record of the contribution (including all
> +        personal information I submit with it, including my sign-off) is
> +        maintained indefinitely and may be redistributed consistent with
> +        this project or the open source license(s) involved.
> +
> --
> 2.22.0.rc1
>


-- 
paul moore
www.paul-moore.com
