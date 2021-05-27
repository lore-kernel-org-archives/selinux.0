Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885DAC4707F
	for <selinux@archiver.kernel.org>; Thu, 27 May 2021 15:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6038D613BA
	for <selinux@archiver.kernel.org>; Thu, 27 May 2021 15:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbhE0Pa4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 May 2021 11:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbhE0Paz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 May 2021 11:30:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CA3C061574
        for <selinux@vger.kernel.org>; Thu, 27 May 2021 08:29:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f18so700921ejq.10
        for <selinux@vger.kernel.org>; Thu, 27 May 2021 08:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HAQr2qiq3N8RTZk7F9BSuKYf0jS/AKKdmZIsfwm5p5s=;
        b=fA0T0+DS68cz2RPeLoaT/Hsx4hxW6D9zw3g4an0ACL/5BvZgc6qCa4+oxlJQEYdCMS
         DazVZZiCH6GQM4Yh3EbqdRZSkxRlYPfZa6hgIFDboVO2YYScSgGZLVei07cn1loTkkYF
         KgXWcjUfG5XjcVte9z7kCMZh9YAsVeMS9PiwPKXMLROkXHaWGnkrBQ6eqij/7UhlB2hx
         17C/dLxG0/3UoelUgVe59kReDQpcUbQKch8+5UVThCq1Y8+KfI3BJt7KrEYmWaIqnC0f
         YHBJHIG4K/fOygmhGc5ZbqbgBNE+YfIg+LvPluiB8fykS1VC272uler9MhnIa3VytCTk
         O/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAQr2qiq3N8RTZk7F9BSuKYf0jS/AKKdmZIsfwm5p5s=;
        b=XK8KghCM5yT28nFNMvFJhXxuVAaYKJediRIHbjFvBrLA0sJGCVcp1DRALTwwmohRpm
         buLDiDrq9bt9IXw4IKagQUPDypjvjL9H6zoglwk4fVet6ARTjDoi+bmhtnY+2vUq7jQi
         b9vIs837PDu9scIKzZIauqvENCXZe6fopSOQ0Ia2J7nCV8QpRqK5uh4Em7rukVBgdFPL
         0rWbbUFuem9oYXJ0cAIedPCcvFw61rPe3THchhXBHZLfW3ZIbGbAKF4OGWGS0RZuLsVn
         td+G70G38UKScmobSuZwPBu66SbnTWRlpIZoue8Rb8bx3knYF439VoreeFXjptRNJDxU
         C6NA==
X-Gm-Message-State: AOAM531XbHzqu1KGzQrMoB49cQRxoBuhipQOFxH2U5Io3lELx4dWUnI0
        8NWq8OrJMv4yQ5ePH8pOcBamGgQ6IgR6/w45NvlT
X-Google-Smtp-Source: ABdhPJz6XEEQ7qNHmk3PbMOJTOYNgmXlCHDNsADqC9Ual+5UTPPaqjZxTp3D8McZCpRrK4hduIPQ0vWSiLze3LpQGrU=
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr4337161ejb.542.1622129359636;
 Thu, 27 May 2021 08:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <202105270909.1fgRW8Wk-lkp@intel.com>
In-Reply-To: <202105270909.1fgRW8Wk-lkp@intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 May 2021 11:29:08 -0400
Message-ID: <CAHC9VhRy=oD=B9G_ZZejPX0dL1+vsyLkYLs59vj-SJoeVMs53g@mail.gmail.com>
Subject: Re: [pcmoore-selinux:working-io_uring 9/9] security/smack/smack_lsm.c:4702:5:
 warning: no previous prototype for function 'smack_uring_override_creds'
To:     kernel test robot <lkp@intel.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 26, 2021 at 9:51 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git working-io_uring
> head:   1f25193a3f5495eefbc9826b1de1a008a2439351
> commit: 1f25193a3f5495eefbc9826b1de1a008a2439351 [9/9] Smack: Brutalist io_uring support with debug
> config: x86_64-randconfig-r013-20210526 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 99155e913e9bad5f7f8a247f8bb3a3ff3da74af1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=1f25193a3f5495eefbc9826b1de1a008a2439351
>         git remote add pcmoore-selinux https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
>         git fetch --no-tags pcmoore-selinux working-io_uring
>         git checkout 1f25193a3f5495eefbc9826b1de1a008a2439351
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> security/smack/smack_lsm.c:4702:5: warning: no previous prototype for function 'smack_uring_override_creds' [-Wmissing-prototypes]
>    int smack_uring_override_creds(const struct cred *new)
>        ^
>    security/smack/smack_lsm.c:4702:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    int smack_uring_override_creds(const struct cred *new)
>    ^
>    static
> >> security/smack/smack_lsm.c:4739:5: warning: no previous prototype for function 'smack_uring_sqpoll' [-Wmissing-prototypes]
>    int smack_uring_sqpoll(void)
>        ^
>    security/smack/smack_lsm.c:4739:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    int smack_uring_sqpoll(void)
>    ^
>    static
>    2 warnings generated.

FYI, Casey I took the liberty of making the Smack functions static (I
had made the same mistake with the SELinux code).

-- 
paul moore
www.paul-moore.com
