Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B01C282CB
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 11:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACA620821
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 11:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfBELKp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:10:45 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39170 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBELKp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 06:10:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so4988471otl.6
        for <selinux@vger.kernel.org>; Tue, 05 Feb 2019 03:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHiz5BnB40t7CyxMYJeN0f/lG9oKrCAQiaNvrLJ9gig=;
        b=UrOYAAO5rje05pJ5geO0ivSYwgCBKea9nDNdfl4iVFhpeBZucZ0Nyj+6EOm5E/SMun
         HpdIstLW5imv93yA1la66YTRJDDd+KrFPk1HtxgP5psQoKm7Yrrp34HDc6pmV+Yi271n
         VetNAGQ1kC6IH4Fje83r8Ng/gIJ8dHjWXoqZV9vHPQ/t8NgC9ZqxXp2rQIC6rqQHaUII
         B5E0Wt/LoNmjQ8ChGh0548N9p41etwXrDda6taOsEXaf8Phk2SksqBrRXG74uy71ZaZ0
         PXIbTiPKBeHoJeUEs9mZL+UhoBtLj+8Pqgm9z8VgbOWh9HYvj/9axh53P8zX0m2fiKxZ
         BSOQ==
X-Gm-Message-State: AHQUAuaeGNgw/mKmWYEDFYnKhyJPf4+/i4DP2G83jVeOjmP0rc2vy65e
        2b3kM9bUfWoVDmY3/BaWl6dObcs+GxOf/ksxbG3OCRH+
X-Google-Smtp-Source: AHgI3IbDNmS2WRlsaXoMdKMTLDPOdNIafFPgpe/Iv60QoyMyrkXTanXaKY0w7L80ChJuRmdqikj5jCe3bSZUIhw7vA4=
X-Received: by 2002:aca:2403:: with SMTP id n3mr2265420oic.328.1549365044485;
 Tue, 05 Feb 2019 03:10:44 -0800 (PST)
MIME-Version: 1.0
References: <20190205085915.5183-4-omosnace@redhat.com> <201902051753.YakI70it%fengguang.wu@intel.com>
In-Reply-To: <201902051753.YakI70it%fengguang.wu@intel.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 5 Feb 2019 12:10:33 +0100
Message-ID: <CAFqZXNveDL23r8Q3sQ_FM_bK6R157z0x=BjxQ4vS8rT+bW45PQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] LSM: add new hook for kernfs node initialization
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 5, 2019 at 10:52 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Ondrej,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on driver-core/driver-core-testing]
> [also build test ERROR on v5.0-rc4 next-20190205]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Ondrej-Mosnacek/Allow-initializing-the-kernfs-node-s-secctx-based-on-its-parent/20190205-171434
> config: x86_64-randconfig-x013-201905 (attached as .config)
> compiler: gcc-8 (Debian 8.2.0-14) 8.2.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    In file included from fs/file_table.c:15:
> >> include/linux/security.h:796:1: error: expected identifier or '(' before '{' token
>     {
>     ^
>    In file included from fs/file_table.c:15:
>    include/linux/security.h:792:19: warning: 'security_kernfs_init_security' declared 'static' but never defined [-Wunused-function]
>     static inline int security_kernfs_init_security(
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> vim +796 include/linux/security.h
>
>    791
>    792  static inline int security_kernfs_init_security(
>    793                  const struct qstr *qstr, const struct iattr *dir_iattr,
>    794                  struct simple_xattrs *dir_secattr, const struct iattr *iattr,
>    795                  struct simple_xattrs *secattr);
>  > 796  {
>    797          return 0;
>    798  }
>    799

*facepalm*... Fixed in v5.


-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
