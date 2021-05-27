Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE46C47089
	for <selinux@archiver.kernel.org>; Thu, 27 May 2021 17:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BD826105A
	for <selinux@archiver.kernel.org>; Thu, 27 May 2021 17:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhE0Ryy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 May 2021 13:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbhE0Ryy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 May 2021 13:54:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EF7C061760
        for <selinux@vger.kernel.org>; Thu, 27 May 2021 10:53:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ss26so1424306ejb.5
        for <selinux@vger.kernel.org>; Thu, 27 May 2021 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pwn/tePQRcSxyC0vCEbvvC8Z286nytYCiGX5Tbprk2o=;
        b=TgF8d7AVM4JuVx64ZZXoIExkxJLaIjW6ZFpzP5blZaK7bU81qE/k9c9gLu4XEUdcxE
         Pu2zgaGJEQbBgw9Es3/hNIWM4/iAqNijZsvLXxN3XAZqwEDyG3i07PRcOQYypIqiOTmV
         ANI4H+XaHbxCvrL9AkjoN2lGs0Prlm3fZRR+BbQJ4Z4DNZLKRBG/EG/A2uiJ8cB0B23Y
         DueysHMbUTVNLLopNdGixSEGJhjpOB2RD61neReSL5zcFPR5bkQwotBr2mgEyD9kG5HY
         gYceB00VrEcdxCqhHVipFv12hwUfNqUxG+SeEauTIG904q8uluYPhE6MjIB/qHF6sltX
         jUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pwn/tePQRcSxyC0vCEbvvC8Z286nytYCiGX5Tbprk2o=;
        b=APZ+fan+5h68d0emF6gsbK5zAQh1CU/6GYtZeG84XX/5PokRjrefODdyiNM+0TfUjv
         I5IwqPu+UYDE93xkmqNIOxWFgoSwdYFbZOmqPROW0x13Ca+6lre72kR7MnbFpRlmEM8i
         0OPIGYOiGwKJrvOv4EBN1MdYZrtYJgLyIzs5Hnvk0a3snVcTeneASTx06pSxAvhuVLp+
         8WKxznsauYdSkzUhDGhcOZj6B7p75Y9umg/oYE56YKTQv5ve57uSMww5W4wgnQR8KOWg
         EQ1isU1Cla0b/2qtoXhEljoiFHATrzO3ApITHF+rXpJV7ZZeihJo20E7m3RX/IluQx4C
         bSGw==
X-Gm-Message-State: AOAM533uMGMm57ojfHd66K65yupdZJJyHy0ocjjzMi1PO9qHjmzUEVJZ
        V73NYmVAsgnYSntBIzCJH92xPyGi+xnpIkg0ldgg
X-Google-Smtp-Source: ABdhPJz4mQnOeJyvntXGZ4g2hljvC7fuOpIO7LO6JgYFoLVkEx/uCjcKXAOC/uQ2t5/WFa+YAVMZdW6AVHMT582xgD4=
X-Received: by 2002:a17:906:5ada:: with SMTP id x26mr1597510ejs.398.1622137999433;
 Thu, 27 May 2021 10:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <202105270909.1fgRW8Wk-lkp@intel.com> <CAHC9VhRy=oD=B9G_ZZejPX0dL1+vsyLkYLs59vj-SJoeVMs53g@mail.gmail.com>
 <e061750d-9591-ac2c-5331-85456c3b4135@schaufler-ca.com>
In-Reply-To: <e061750d-9591-ac2c-5331-85456c3b4135@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 May 2021 13:53:08 -0400
Message-ID: <CAHC9VhRgXBRMjUd6r3YPPn0=qttm011JWVvmx7fSXxW93G01Qw@mail.gmail.com>
Subject: Re: [pcmoore-selinux:working-io_uring 9/9] security/smack/smack_lsm.c:4702:5:
 warning: no previous prototype for function 'smack_uring_override_creds'
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 27, 2021 at 1:05 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 5/27/2021 8:29 AM, Paul Moore wrote:
> > On Wed, May 26, 2021 at 9:51 PM kernel test robot <lkp@intel.com> wrote:
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git working-io_uring
> >> head:   1f25193a3f5495eefbc9826b1de1a008a2439351
> >> commit: 1f25193a3f5495eefbc9826b1de1a008a2439351 [9/9] Smack: Brutalist io_uring support with debug
> >> config: x86_64-randconfig-r013-20210526 (attached as .config)
> >> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 99155e913e9bad5f7f8a247f8bb3a3ff3da74af1)
> >> reproduce (this is a W=1 build):
> >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>         chmod +x ~/bin/make.cross
> >>         # install x86_64 cross compiling tool for clang build
> >>         # apt-get install binutils-x86-64-linux-gnu
> >>         # https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=1f25193a3f5495eefbc9826b1de1a008a2439351
> >>         git remote add pcmoore-selinux https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> >>         git fetch --no-tags pcmoore-selinux working-io_uring
> >>         git checkout 1f25193a3f5495eefbc9826b1de1a008a2439351
> >>         # save the attached .config to linux build tree
> >>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All warnings (new ones prefixed by >>):
> >>
> >>>> security/smack/smack_lsm.c:4702:5: warning: no previous prototype for function 'smack_uring_override_creds' [-Wmissing-prototypes]
> >>    int smack_uring_override_creds(const struct cred *new)
> >>        ^
> >>    security/smack/smack_lsm.c:4702:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> >>    int smack_uring_override_creds(const struct cred *new)
> >>    ^
> >>    static
> >>>> security/smack/smack_lsm.c:4739:5: warning: no previous prototype for function 'smack_uring_sqpoll' [-Wmissing-prototypes]
> >>    int smack_uring_sqpoll(void)
> >>        ^
> >>    security/smack/smack_lsm.c:4739:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> >>    int smack_uring_sqpoll(void)
> >>    ^
> >>    static
> >>    2 warnings generated.
>
> > FYI, Casey I took the liberty of making the Smack functions static (I
> > had made the same mistake with the SELinux code).
>
> Thank you. If there was any doubt, the Smack function declarations
> were taken directly from the SELinux versions.

I figured that was the case, and for whatever it is worth I would have
done the exact same thing :)

-- 
paul moore
www.paul-moore.com
