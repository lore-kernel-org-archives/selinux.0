Return-Path: <SRS0=smjq=NY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2FBC43441
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 14:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C28C2086A
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 14:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bFdS5t9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C28C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeKNA2H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:28:07 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45984 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbeKNA2H (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Nov 2018 19:28:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so8929721lfa.12
        for <selinux@vger.kernel.org>; Tue, 13 Nov 2018 06:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKPL0B2pOM9qr5Z1DJAjtkxFxMra4nIcREdBIewKubE=;
        b=bFdS5t9cMDtUve+NLCdrf5w4WOZ5t6N+nqEpcyoFDtm33F6kTN4Ow2LBy/NZrFf+G3
         afmyQCM6jPAc0PlI7nJgVMnIbLoFiK2vTwqurWWcxw7FVBieaMKUGTafzPh7tGRUvB0B
         iwi3SszHEnYte4yBbCL4DdiCHLQRnYuUYDp3c6JjZflmcV9E4YEw/CV9Mg3yo2ZVLiQn
         BMJUD9VMatSUYXVNIjENIL4tU6YvphhONjPvCkHAo1FKN8vHG1NelQ4yi8NSE6yqgJ0J
         F4A5/jT0Qb2uxBPfxCpvINo7H8Fjocuyjz4TRNeYwux8iYG6swg18htIQCUXZ9ZJLklX
         7NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKPL0B2pOM9qr5Z1DJAjtkxFxMra4nIcREdBIewKubE=;
        b=pSnIoMz0TuznWQR39IOim+f4idrcO8wDJXxDGJbKZatSP2723J6DIXVMH5hLHf94MW
         ZqSGMt539B7t/bRdTXL/33aK9SnUyLuuTyRaWSi5Kfe8jGDxuB/Y0JKYcHBhaB2lkOpk
         RM2M88Jpd2LKgOuluGgIbdWLtuA9KsYHkKE89gHkddjBSJusrmkmojZG0eQbx9tc4RE5
         dZRab7P0pvBZP+MJtf7IAZLggeaoVFiWBELs+mN4RuQw/I+7reMlb6d2E7Y1cO2Gz6PI
         Nx8Lsp3nH3ldfTMk6//jeySr2NN41mDs97RggTnUQU0+PNqirdQ5G4BJUBI4zn9pjTvW
         LSww==
X-Gm-Message-State: AGRZ1gIfmH85D4cZ0AMvpT53rs47kbLWPG6Re0KYyj1zYfn2MjX10lIQ
        g0SIi2aJNYz+NtN7bds24edeoeiSwpVz1QGUqkCU
X-Google-Smtp-Source: AJdET5chGSqhk0MZvrrqyl2deVJdUjQMqTXG4qSxVy5vQ+O3RjC4ilITpKLThfpbG2XAOEzuiTNqFbyiyALainFu4kw=
X-Received: by 2002:a19:f115:: with SMTP id p21mr2998752lfh.20.1542119380733;
 Tue, 13 Nov 2018 06:29:40 -0800 (PST)
MIME-Version: 1.0
References: <53491A18-DD21-4E34-BC2F-AB449C7844E8@gmx.us> <CAHC9VhTiCPwQ51ciexRCp4M5rN2C=pTm=anRaMgTsZ9coX96Zw@mail.gmail.com>
 <7DE35AF4-20E1-4402-9B5A-4D8AACE15D56@gmx.us> <CAHC9VhRODL9JYjJ3QpExMaztA3PFv_Z1t=Q=4K8QMtJh7ntVuw@mail.gmail.com>
 <989F5A08-F283-4BB7-B3D9-67E25EE05F69@gmx.us> <CAHC9VhS6UuYa_z_T04DddoGS3WhTnv4G3b_DdoEeipcJgqjziw@mail.gmail.com>
 <trinity-0b0183f4-440a-4989-9b0d-73986f051600-1542117163088@msvc-mesg-gmx021>
In-Reply-To: <trinity-0b0183f4-440a-4989-9b0d-73986f051600-1542117163088@msvc-mesg-gmx021>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 13 Nov 2018 09:29:29 -0500
Message-ID: <CAHC9VhQ0=KjKuD=hGCpTdBBFLCjFueBXX5UidDEXRSSHSsf9EA@mail.gmail.com>
Subject: Re: BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x60/0x150
To:     cai@gmx.us
Cc:     Eric Paris <eparis@parisplace.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 13, 2018 at 8:52 AM Qian Cai <cai@gmx.us> wrote:
> On 11/13/18 at 8:33 AM, Paul Moore wrote:
> > On Mon, Nov 12, 2018 at 10:11 PM Qian Cai <cai@gmx.us> wrote:
> > > > On Nov 12, 2018, at 10:09 PM, Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > On Mon, Nov 12, 2018 at 7:59 PM Qian Cai <cai@gmx.us> wrote:
> > > >>> On Nov 12, 2018, at 7:41 PM, Paul Moore <paul@paul-moore.com> wrote:
> > > >>> On Mon, Nov 12, 2018 at 2:39 PM Qian Cai <cai@gmx.us> wrote:
> > > >>>>
> > > >>>> Running the trinity fuzzer on the latest mainline (rc2) generates this,
> > > >>>>
> > > >>>> [15029.879626] BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x60/0x150
> > > >>>> [15029.887275] Read of size 2 at addr ffff801ec53c5080 by task trinity-main/18081
> > > >>>> [15029.887294]
> > > >>>> [15029.887304] CPU: 28 PID: 18081 Comm: trinity-main Tainted: G        W  OE     4.20.0-rc2+ #15
> > > >>>> [15029.887311] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50 06/01/2018
> > > >>>> [15000.084786] [15029.887320] Call trace:
> > > >>>> [15029.915511]  dump_backtrace+0x0/0x2c8
> > > >>>> [15029.920046]  show_stack+0x24/0x30
> > > >>>> [15029.923367]  dump_stack+0x118/0x19c
> > > >>>> [15029.927539]  print_address_description+0x68/0x2a0
> > > >>>> [15029.932245]  kasan_report+0x1b4/0x348
> > > >>>> [15029.938760]  __asan_load2+0x7c/0xa0
> > > >>>> [15029.945098]  selinux_sctp_bind_connect+0x60/0x150
> > > >>>>
> > > >>>> [15029.950571]  security_sctp_bind_connect+0x58/0x90
> > > >>>> [15029.955493]  __sctp_setsockopt_connectx+0x68/0x128 [sctp]
> > > >>>> [15029.960943]  sctp_setsockopt+0x764/0x2928 [sctp]
> > > >>>> [15029.965564]  sock_common_setsockopt+0x6c/0x80
> > > >>>> [15029.969923]  __arm64_sys_setsockopt+0x13c/0x1f0
> > > >>>> [15029.974456]  el0_svc_handler+0xd4/0x198
> > > >>>> [15029.978293]  el0_svc+0x8/0xc
> > > >>>> [15029.981174]
> > > >>>> [15029.982667] Allocated by task 18081:
> > > >>>> [15029.986245]  kasan_kmalloc.part.1+0x40/0x108
> > > >>>> [15029.990517]  kasan_kmalloc+0xb4/0xc8
> > > >>>> [15029.994094]  __kmalloc_node+0x1c4/0x638
> > > >>>> [15029.997933]  kvmalloc_node+0x98/0xa8
> > > >>>> [15030.001511]  vmemdup_user+0x34/0x128
> > > >>>> [15030.005137]  __sctp_setsockopt_connectx+0x44/0x128 [sctp]
> > > >>>> [15030.010586]  sctp_setsockopt+0x764/0x2928 [sctp]
> > > >>>> [15030.015205]  sock_common_setsockopt+0x6c/0x80
> > > >>>> [15030.019564]  __arm64_sys_setsockopt+0x13c/0x1f0
> > > >>>> [15030.024096]  el0_svc_handler+0xd4/0x198
> > > >>>> [15030.027933]  el0_svc+0x8/0xc
> > > >>>> [15030.030814]
> > > >>>> [15030.032306] Freed by task 3025:
> > > >>>> [15030.035451]  __kasan_slab_free+0x114/0x228
> > > >>>> [15030.039548]  kasan_slab_free+0x10/0x18
> > > >>>> [15030.043299]  kfree+0x114/0x408
> > > >>>> [15030.046357]  selinux_sk_free_security+0x38/0x48
> > > >>>> [15030.050888]  security_sk_free+0x3c/0x58
> > > >>>> [15030.054727]  __sk_destruct+0x3e8/0x570
> > > >>>> [15030.058478]  sk_destruct+0x4c/0x58
> > > >>>> [15030.061881]  __sk_free+0x68/0x138
> > > >>>> [15030.065197]  sk_free+0x3c/0x48
> > > >>>> [15030.068255]  unix_release_sock+0x4a8/0x550
> > > >>>> [15030.072353]  unix_release+0x34/0x50
> > > >>>> [15030.075843]  __sock_release+0x74/0x110
> > > >>>> [15030.079593]  sock_close+0x24/0x38
> > > >>>> [15030.082913]  __fput+0x1b8/0x368
> > > >>>> [15030.086055]  ____fput+0x20/0x30
> > > >>>> [15030.089199]  task_work_run+0x14c/0x1a8
> > > >>>> [15030.092951]  do_notify_resume+0x1e4/0x200
> > > >>>> [15030.096961]  work_pending+0x8/0x14
> > > >>>
> > > >>> Any chance you have a reproducer for this?  Or at the very least a
> > > >>> line number inside selinux_sctp_bind_connect()?
> > > >>>
> > > >> Yes, running trinity as non-root will trigger it all the time on this
> > > >> aarch64 server so far.
> > > >
> > > > Is it just aarch64, or are you seeing it on other arches as well?
> > >
> > > I only have an aarch64 server to test so far.
> >
> > Did you see similar problems with 4.20-rc1?
>
> I did not test on -rc1.

I ran trinity a few times on my test kernel and nothing terrible
happened; this was expected since I don't have KASAN enabled in my
kernel builds at the moment.  I'm building a kernel with KASAN right
now to see if I can reproduce this on x86_64 (I don't have easy access
to a aarch64 system).

It might be helpful if you could also try to debug this issue just in
case it happens to be aarch64 specific or has something to do with
your particular configuration.

> > > >> $ trinity
> > > >>
> > > >> https://github.com/kernelslacker/trinity.git
> > > >>
> > > >> If you have a debug patch I am happy to try that as well if you
> > > >> need to gather more information.

-- 
paul moore
www.paul-moore.com
