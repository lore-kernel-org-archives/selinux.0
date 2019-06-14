Return-Path: <SRS0=ZMzQ=UN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C93C31E4B
	for <selinux@archiver.kernel.org>; Fri, 14 Jun 2019 19:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305CB2183E
	for <selinux@archiver.kernel.org>; Fri, 14 Jun 2019 19:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="QkZjo8R1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfFNTAq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:00:46 -0400
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:28174 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNTAp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jun 2019 15:00:45 -0400
X-EEMSG-check-017: 686154856|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.63,373,1557187200"; 
   d="scan'208";a="686154856"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Jun 2019 19:00:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1560538819; x=1592074819;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=rl8Z4Ih13I1NZ/lJgrp/X52iXCAej8qdematxkldZvw=;
  b=QkZjo8R1w/C0Rz7UnWT+iMogUhDNE00rYL/yuKtLnQYdKrrgfgfrELeo
   jbHMQemoI7wgX627N7xM+H6mPvBVyi5Zjg/F+uTqQutWKO7vW4gJJPsLU
   uhj2XAQcCtKwP//h7TVom95fkuFvbrVf3sJ59cOnLUkoZAnWlIkfkPgmx
   l7R2aMoKaXmT1MAblLJaPUW6zudXnKaCaW7RP/CeroxE20cJtET2MJ511
   G5zTsp/erv6ZgRUY1cWfMFz9PMkIlVZMK/CZWIqzr7oEzm19Hr+cnhx9f
   uXAg5uX7fKsG3J1hwxi/w1CNV6LrYN+2YCy4IfiLc70vXmDZ7aZFIIrj0
   g==;
X-IronPort-AV: E=Sophos;i="5.63,373,1557187200"; 
   d="scan'208";a="24768169"
IronPort-PHdr: =?us-ascii?q?9a23=3AMvLmPBOkBvUV/PfWbXEl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/TyrarrMEGX3/hxlliBBdydt6sdzbOI6uu5AjdIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfK5+IA+roQjQq8UajpZuJ6g/xx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipPDYOma4sEEvQPM+BWoYLgo1cCtAWyCA2pCO7p1zRGhGL53bci3u?=
 =?us-ascii?q?o8Dw/G0gwuEdEAvnvao9r6NrsdX++uwanUzzjOde9a1Svz5YXKdB0qvPGCXa?=
 =?us-ascii?q?h3ccrU0UQhCh/FgUuIqYzlITyV0PkGvXWe7+V6UeKvj3AoqgFsqTWo3ccjl5?=
 =?us-ascii?q?LJi5kJylHE6Sp5wIE1Kce+SE5ge9GoCpRQtyaEN4ZvRM4pXm9muCE/yrIcuJ?=
 =?us-ascii?q?67ejAHyI85yB7bavyHdZWI4x37VOaLJjd4hmxqd66jhxqo9kig0OL8WtG30F?=
 =?us-ascii?q?lUtCpFlMfDtnQX2xzU8MiHReNx/kig2TaT1wDT9/pLLVoomqrcLp4sxKM7mJ?=
 =?us-ascii?q?kLsUnbAyP7l0r7gLWWe0k54OSk9evqbqv8qpOBMYJ/lxvwPb40msOlBOQ1Kg?=
 =?us-ascii?q?0OX2+G9uuizLDj5kj5QKlSjv0xj6nZrIjWJcQFqa69BA9Yypoj5AylDzenzd?=
 =?us-ascii?q?QYhmMLLE5FeR2bj4jpPEvCIPbkAvekn1ugijJrx/HCPrH5A5XNKGbMkKv5cL?=
 =?us-ascii?q?pg5ENRxxA/wNBC655OFL0ML+z/VlXsuNDACx82KQ20w+LpCNVn0YMeXHqCAr?=
 =?us-ascii?q?SEP6PJqlKI+uIuLPWMZI8Sojr9LeMl6OT0gX82nl8dY7Gl3YELZ3CgAvRmP0?=
 =?us-ascii?q?KZbGL0gtcFC2gKoxY+TPbxh1KYSjNTfWi9UL885j4hFIKqF5vMRoeogLaZxi?=
 =?us-ascii?q?e0AoVWZnxaClCLCXrobJuLW/MNaCKUP89gnScJVaauS4A/zxGirgz6xKR9Lu?=
 =?us-ascii?q?rS5CIYsYjv1N9v5+3cxlkO8mlMAtiHm0WEUn1ulGoDR3dixKR2vFBnwF6ry6?=
 =?us-ascii?q?V0g/VEU9dU4qUNGhw3MZ/a0vxSFd//QETCc82PRVLgRc+pUh8rSddk+MMDe0?=
 =?us-ascii?q?ZwHZ2ZixnH2ye7S+sOm6ejGI0/8qWa2WP4Ycl61SCVh+Eak1A6T54XZiWdja?=
 =?us-ascii?q?ll+l2WXtSYng=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BJAwBN7gNd/wHyM5BmHQEBBQEHBQGBVAUBCwGBYQUqa?=
 =?us-ascii?q?lIyKIQWknZMAQEBAQEBBoE1iVKRDAkBAQEBAQEBAQEtBwECAQGDekYCgkwjN?=
 =?us-ascii?q?wYOAQMBAQEEAQEBAQMBAWwcDII6KQGCZwEFIxU2GwsOCgICJgICVwYBDAYCA?=
 =?us-ascii?q?QGCXz8BgXYUD6kWgTGFR4MggUaBDCgBi1wXeIEHgREngms+glUMAoRrglgEi?=
 =?us-ascii?q?3CIMpUyCYISghuELY0DBhuCKGmGGYoGhAKNHIcgkUkigVgrCAIYCCEPO4JsC?=
 =?us-ascii?q?YV2hAiBDIVbIwMwgQYBAY9JAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Jun 2019 19:00:18 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5EJ0I8G010249;
        Fri, 14 Jun 2019 15:00:18 -0400
Subject: Re: [PATCH v2] Add CONTRIBUTING.md
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <CAHC9VhQcrzJ7bQZccJw9v7cYUewMGMRdDVm8bkBwc4KFYsDKng@mail.gmail.com>
 <20190531201905.26607-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4f25e603-24b2-fd92-80a1-c52b0c0864df@tycho.nsa.gov>
Date:   Fri, 14 Jun 2019 15:00:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531201905.26607-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/31/19 4:19 PM, Petr Lautrbach wrote:
> Based on https://github.com/SELinuxProject/selinux/wiki/Contributing
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Merged with whitespace fixes applied.

> ---
> 
> github preview is available at
> https://github.com/bachradsusi/SELinuxProject-selinux/blob/add-Contribution/CONTRIBUTING.md
> 
> 
>   CONTRIBUTING.md | 88 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 88 insertions(+)
>   create mode 100644 CONTRIBUTING.md
> 
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
> 

