Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC78DC43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 17:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAF420842
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 17:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paulo.ac header.i=@paulo.ac header.b="KO9jv7/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfB0RHf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:07:35 -0500
Received: from mail.paulo.ac ([51.15.136.203]:51024 "EHLO mail.paulo.ac"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730296AbfB0RHe (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 27 Feb 2019 12:07:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.paulo.ac (Postfix) with ESMTP id 901DB1C10AE;
        Wed, 27 Feb 2019 17:07:32 +0000 (UTC)
Received: from localhost (unknown [179.162.9.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.paulo.ac (Postfix) with ESMTPSA id 74D051C05C7;
        Wed, 27 Feb 2019 17:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=paulo.ac; s=201902;
        t=1551287250; bh=wUFkDFa8Ihq/8tfLswJ0elCR9fgscFmCEYUDc84Ybdg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KO9jv7/iBpNSiMlc2R52usLRmr2YUO04ABB6PWuxD7czUghNxGHdEP/H91m7FDYCj
         +9D+s4wYeXh0xsehSMrlpBVrRNuI9KhNejBOqftlJ+NC1hGNK6qc2bRuuTT76hT/Ga
         i4fVSa0bBRBkV3XwoQ3+uKCfN7vj2NjPhM98r7cNjeG6Q7F4I4QL6Dem7v6S+MS/Jl
         cWNsb98yu688bB0vkJ8hPy4qL8ycxm0h92j+GOqKinCFUPt0mblE8sx2a3ZanTNaCy
         dxVNap9hBeEEl/WMqCTeqMs6hFAeppLmwT2q2zJYK77tXKnEzLywXNMTn+4VmktDoO
         mGlEOfeKBiYWg==
From:   Paulo Alcantara <paulo@paulo.ac>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com
Subject: Re: [PATCH] selinux: use kernel linux/socket.h definitions for PF_MAX
In-Reply-To: <20190225005528.28371-1-paulo@paulo.ac>
References: <20190225005528.28371-1-paulo@paulo.ac>
Date:   Wed, 27 Feb 2019 11:36:37 -0300
Message-ID: <87y36170y2.fsf@paulo.ac>
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paulo Alcantara <paulo@paulo.ac> writes:

> When compiling genheaders and mdp from a newer host kernel, the
> following error happens:
>
>     In file included from scripts/selinux/genheaders/genheaders.c:18:
>     ./security/selinux/include/classmap.h:238:2: error: #error New
>     address family defined, please update secclass_map.  #error New
>     address family defined, please update secclass_map.  ^~~~~
>     make[3]: *** [scripts/Makefile.host:107:
>     scripts/selinux/genheaders/genheaders] Error 1 make[2]: ***
>     [scripts/Makefile.build:599: scripts/selinux/genheaders] Error 2
>     make[1]: *** [scripts/Makefile.build:599: scripts/selinux] Error 2
>     make[1]: *** Waiting for unfinished jobs....
>
> Instead of relying on the host definition, include linux/socket.h in
> classmap.h to have PF_MAX.
>
> Signed-off-by: Paulo Alcantara <paulo@paulo.ac>
> ---
>  scripts/selinux/genheaders/genheaders.c | 1 -
>  scripts/selinux/mdp/mdp.c               | 1 -
>  security/selinux/include/classmap.h     | 1 +
>  3 files changed, 1 insertion(+), 2 deletions(-)

Ping?

Could someone please take a look at this issue?

It's quite easy to reproduce on my host (4.20+) when building an
unpatched 4.14 kernel[1]:

    $ make defconfig
    *** Default configuration is based on 'x86_64_defconfig'
    #
    # configuration written to .config
    #
    $ make scripts
    scripts/kconfig/conf  --silentoldconfig Kconfig
      WRAP    arch/x86/include/generated/asm/clkdev.h
      WRAP    arch/x86/include/generated/asm/dma-contiguous.h
      WRAP    arch/x86/include/generated/asm/early_ioremap.h
      WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
      WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
      CC      scripts/mod/empty.o
      HOSTCC  scripts/mod/mk_elfconfig
      MKELF   scripts/mod/elfconfig.h
      HOSTCC  scripts/mod/modpost.o
      CC      scripts/mod/devicetable-offsets.s
      CHK     scripts/mod/devicetable-offsets.h
      UPD     scripts/mod/devicetable-offsets.h
      HOSTCC  scripts/mod/file2alias.o
      HOSTCC  scripts/mod/sumversion.o
      HOSTLD  scripts/mod/modpost
      HOSTCC  scripts/selinux/genheaders/genheaders
    In file included from scripts/selinux/genheaders/genheaders.c:19:
    ./security/selinux/include/classmap.h:245:2: error: #error New address family defined, please update secclass_map.
     #error New address family defined, please update secclass_map.
      ^~~~~
    make[3]: *** [scripts/Makefile.host:102: scripts/selinux/genheaders/genheaders] Error 1
    make[2]: *** [scripts/Makefile.build:585: scripts/selinux/genheaders] Error 2
    make[1]: *** [scripts/Makefile.build:585: scripts/selinux] Error 2
    make: *** [Makefile:572: scripts] Error 2

Thanks
Paulo

[1] https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.14.104.tar.xz

>
> diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
> index 1ceedea847dd..544ca126a8a8 100644
> --- a/scripts/selinux/genheaders/genheaders.c
> +++ b/scripts/selinux/genheaders/genheaders.c
> @@ -9,7 +9,6 @@
>  #include <string.h>
>  #include <errno.h>
>  #include <ctype.h>
> -#include <sys/socket.h>
>  
>  struct security_class_mapping {
>  	const char *name;
> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
> index 073fe7537f6c..6d51b74bc679 100644
> --- a/scripts/selinux/mdp/mdp.c
> +++ b/scripts/selinux/mdp/mdp.c
> @@ -32,7 +32,6 @@
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <string.h>
> -#include <sys/socket.h>
>  
>  static void usage(char *name)
>  {
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index bd5fe0d3204a..201f7e588a29 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -1,5 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #include <linux/capability.h>
> +#include <linux/socket.h>
>  
>  #define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
>      "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append", "map"
> -- 
> 2.20.1
