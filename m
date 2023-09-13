Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F01BEE0213
	for <selinux@archiver.kernel.org>; Wed, 13 Sep 2023 22:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjIMWDC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Sep 2023 18:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjIMWDB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Sep 2023 18:03:01 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7EF198B
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 15:02:57 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59b4ec8d9c1so3548597b3.0
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694642576; x=1695247376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4SsNeA7U0usJeRe6/MvYC8slcbYiO1urihjwDxXGIg=;
        b=WUKOjrBZZkIezeRKvDw/FI6bWpoyr2JEDvLSjlESt5gvLlr8FlAKafkL0oc5cHJ6Cw
         kuN2EKDZkVGaJT4erj4TPs7MZDd+suOR+vBMbukHJI6jGl36OL6o6wRGGA5aGosbFBgf
         d/NNHok3JCrYLk8bf4Zk/twqEECObr3UZaL4Uu5gaNNnc5XHM6jnie2DPNiajFnL5B81
         AoF5um8XjpJtv+ia9n8RTb43MjO1SsEpcBIU9em2DZypraRVZVpGo4pfA23nIFxxgUlF
         /ASjBquc6KZ9qKcNie/GRQU/bpWNOTabcWsGQu0gv4gB3kD1LixKEr4/6NRJYrlVk4e1
         A6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694642576; x=1695247376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4SsNeA7U0usJeRe6/MvYC8slcbYiO1urihjwDxXGIg=;
        b=KVwTGL7Hy9Se+gZgoj2X0tfkfich/YKgjZYdKovBhk7rlObx1B7MaxMU6WdXUOxNbq
         sOnUvkXyN3DGgC7K3eWxuGFKTkU2yKvtKUUAFAWxDAF3Ycqtix0EUp/FoMuovGxjGKY8
         cvq7lYVOTgAjzQ3GOC1pvgAwy5tEntdo30perbSuIWyEj6h4GwognPVjEUBs+RPsXAJR
         I8eByWVgM14OEtU99mhitJqdg/3e68761XlQfK32O3eVAJuty78zm4HESA9GNHfdkh3A
         IWeDmLyaJ3ajnRd6q/KrJUtHnHxdk273RfaNFse0oAsxU/V+i5zvW4e9ozfbCoU/nm1y
         NX4A==
X-Gm-Message-State: AOJu0YwJofPuVZd2KSEoTXb5XluczX6Nt9Lytj+YuovJip+nlpBCr9/8
        52OiFTwrMDm/WyyPAPZ+1y2CQqHX9Ez3oxddwSoe
X-Google-Smtp-Source: AGHT+IEWoV5AQmrQ+WZDEiLviSL6/m45o/xQQJ5rA2gxQNy6tVzjhvfWH1S1L3H9j4tZAE0UGwJ0pkSfgQONBfyaGzQ=
X-Received: by 2002:a0d:e406:0:b0:586:9ce4:14e8 with SMTP id
 n6-20020a0de406000000b005869ce414e8mr3142470ywe.52.1694642576622; Wed, 13 Sep
 2023 15:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <ZOWtBTKkfcc8sKkY@gmail.com> <202308242024.q4KF0YIN-lkp@intel.com>
In-Reply-To: <202308242024.q4KF0YIN-lkp@intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Sep 2023 18:02:45 -0400
Message-ID: <CAHC9VhRWL6VDLGVU_L=v_T7KzAf911YJvy8_V2NVUE+Bp-i0Og@mail.gmail.com>
Subject: Re: [PATCH] lsm: constify the 'mm' parameter in security_vm_enough_memory_mm()
To:     kernel test robot <lkp@intel.com>
Cc:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 24, 2023 at 9:04=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Khadija,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on pcmoore-selinux/next pcmoore-audit/next linus/m=
aster v6.5-rc7 next-20230824]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Khadija-Kamran/lsm=
-constify-the-mm-parameter-in-security_vm_enough_memory_mm/20230823-145455
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-ev=
erything
> patch link:    https://lore.kernel.org/r/ZOWtBTKkfcc8sKkY%40gmail.com
> patch subject: [PATCH] lsm: constify the 'mm' parameter in security_vm_en=
ough_memory_mm()
> config: arc-randconfig-001-20230824 (https://download.01.org/0day-ci/arch=
ive/20230824/202308242024.q4KF0YIN-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230824/202308242024=
.q4KF0YIN-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308242024.q4KF0YIN-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> mm/util.c:928:5: error: conflicting types for '__vm_enough_memory'; ha=
ve 'int(struct mm_struct *, long int,  int)'
>      928 | int __vm_enough_memory(struct mm_struct *mm, long pages, int c=
ap_sys_admin)
>          |     ^~~~~~~~~~~~~~~~~~
>    In file included from mm/util.c:2:
>    include/linux/mm.h:3199:12: note: previous declaration of '__vm_enough=
_memory' with type 'int(const struct mm_struct *, long int,  int)'
>     3199 | extern int __vm_enough_memory(const struct mm_struct *mm, long=
 pages, int cap_sys_admin);
>          |            ^~~~~~~~~~~~~~~~~~

It looks like you will also need to update the __vm_enough_memory()
definition to take a const mm_struct parameter.  I looked quickly at
the function just now and I don't think that will be a problem.

--=20
paul-moore.com
