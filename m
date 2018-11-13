Return-Path: <SRS0=smjq=NY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AAAC43441
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 13:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA77223AE
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 13:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0tLoKvDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA77223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbeKMXbm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:31:42 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43436 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387587AbeKMXbm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Nov 2018 18:31:42 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so8808456lff.10
        for <selinux@vger.kernel.org>; Tue, 13 Nov 2018 05:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+jfIEparKCQuV8hDmpHEkq5Krl/4zl4141C46iqxqw=;
        b=0tLoKvDXuy+w1YgEJBJc5VY95G6/piD9EM45DskUvnWKbmRHMYl0FdDfnY/GgWo/pl
         fnPO5hqSOxzqECeJegAizhJWm7Qtu5+XRzlEV2Y9Sklw4yuRsZ/9TtiebgmyyJpZeTl/
         N1PQBMlqckA9neCKlLtj67XPaoQ7do5paJduvJW+eQa2rTAV6eWIi1cNyMwFaDTRue/C
         9qVmncPNBH79ClLbvofHQ3SY3IfgBr2lHQPxMdkLAGLDwAKopxHanh7B4A7C5i06p1pc
         xj0Q2vlBYDRCiP3Mu0P8MUgyp4n1w/JjIuci+Gm8CutnRIqIy8G2IdteVQpM+bY8Ponx
         vPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+jfIEparKCQuV8hDmpHEkq5Krl/4zl4141C46iqxqw=;
        b=OJMa4VqRZ9EpQAThsYvrbCTBBzxJXbsa/yYONMzLvSRB9u1GnBppKB795tfpq0zB/3
         eQKOle6ZZwZaXfOSccY1nvmOnpubqE3nh3Z/umg7g/VTsQ9c240XaC6hRRzfB7u6PxMq
         4t2XBNlSrlZAncn3Jh8KK8QSJEaIHGfhpt6RZhGjwBu/bTam1Yhpf+uVTn6069j+OlhT
         B/kUW/yWSCN1oheC9siNci7aLyEJODWzH7xXsiOb2bEU0tmCBeVYtHIJQROlyZr5cmaT
         qzl79LSiE6t/6j4oKw6J1HTpC6Wgv4Dsm7Gj9lk/uDxZlmWQ2/aLZPPT79I4Cpx8FkeB
         HB+g==
X-Gm-Message-State: AGRZ1gKUxgbU0xGlv4zEr6DXgX23vKOX8WryMz01/oeIy9engSjZLaNc
        By7SCBlqVlMhiqL/R4wLGHsORz/Gy8GmoFIDAnHh
X-Google-Smtp-Source: AJdET5d7W7xCy75M4Skbx2MXP3A79VVwpF8kK0wW+7FmSNGYFSthVpo2x/rWETS1POaPLWeSiiuMXw7sAUSKZQ4UdKI=
X-Received: by 2002:a19:e601:: with SMTP id d1mr3110260lfh.71.1542116010482;
 Tue, 13 Nov 2018 05:33:30 -0800 (PST)
MIME-Version: 1.0
References: <53491A18-DD21-4E34-BC2F-AB449C7844E8@gmx.us> <CAHC9VhTiCPwQ51ciexRCp4M5rN2C=pTm=anRaMgTsZ9coX96Zw@mail.gmail.com>
 <7DE35AF4-20E1-4402-9B5A-4D8AACE15D56@gmx.us> <CAHC9VhRODL9JYjJ3QpExMaztA3PFv_Z1t=Q=4K8QMtJh7ntVuw@mail.gmail.com>
 <989F5A08-F283-4BB7-B3D9-67E25EE05F69@gmx.us>
In-Reply-To: <989F5A08-F283-4BB7-B3D9-67E25EE05F69@gmx.us>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 13 Nov 2018 08:33:18 -0500
Message-ID: <CAHC9VhS6UuYa_z_T04DddoGS3WhTnv4G3b_DdoEeipcJgqjziw@mail.gmail.com>
Subject: Re: BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x60/0x150
To:     cai@gmx.us
Cc:     linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 12, 2018 at 10:11 PM Qian Cai <cai@gmx.us> wrote:
> > On Nov 12, 2018, at 10:09 PM, Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Mon, Nov 12, 2018 at 7:59 PM Qian Cai <cai@gmx.us> wrote:
> >>> On Nov 12, 2018, at 7:41 PM, Paul Moore <paul@paul-moore.com> wrote:
> >>> On Mon, Nov 12, 2018 at 2:39 PM Qian Cai <cai@gmx.us> wrote:
> >>>>
> >>>> Running the trinity fuzzer on the latest mainline (rc2) generates this,
> >>>>
> >>>> [15029.879626] BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x60/0x150
> >>>> [15029.887275] Read of size 2 at addr ffff801ec53c5080 by task trinity-main/18081
> >>>> [15029.887294]
> >>>> [15029.887304] CPU: 28 PID: 18081 Comm: trinity-main Tainted: G        W  OE     4.20.0-rc2+ #15
> >>>> [15029.887311] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50 06/01/2018
> >>>> [15000.084786] [15029.887320] Call trace:
> >>>> [15029.915511]  dump_backtrace+0x0/0x2c8
> >>>> [15029.920046]  show_stack+0x24/0x30
> >>>> [15029.923367]  dump_stack+0x118/0x19c
> >>>> [15029.927539]  print_address_description+0x68/0x2a0
> >>>> [15029.932245]  kasan_report+0x1b4/0x348
> >>>> [15029.938760]  __asan_load2+0x7c/0xa0
> >>>> [15029.945098]  selinux_sctp_bind_connect+0x60/0x150
> >>>>
> >>>> [15029.950571]  security_sctp_bind_connect+0x58/0x90
> >>>> [15029.955493]  __sctp_setsockopt_connectx+0x68/0x128 [sctp]
> >>>> [15029.960943]  sctp_setsockopt+0x764/0x2928 [sctp]
> >>>> [15029.965564]  sock_common_setsockopt+0x6c/0x80
> >>>> [15029.969923]  __arm64_sys_setsockopt+0x13c/0x1f0
> >>>> [15029.974456]  el0_svc_handler+0xd4/0x198
> >>>> [15029.978293]  el0_svc+0x8/0xc
> >>>> [15029.981174]
> >>>> [15029.982667] Allocated by task 18081:
> >>>> [15029.986245]  kasan_kmalloc.part.1+0x40/0x108
> >>>> [15029.990517]  kasan_kmalloc+0xb4/0xc8
> >>>> [15029.994094]  __kmalloc_node+0x1c4/0x638
> >>>> [15029.997933]  kvmalloc_node+0x98/0xa8
> >>>> [15030.001511]  vmemdup_user+0x34/0x128
> >>>> [15030.005137]  __sctp_setsockopt_connectx+0x44/0x128 [sctp]
> >>>> [15030.010586]  sctp_setsockopt+0x764/0x2928 [sctp]
> >>>> [15030.015205]  sock_common_setsockopt+0x6c/0x80
> >>>> [15030.019564]  __arm64_sys_setsockopt+0x13c/0x1f0
> >>>> [15030.024096]  el0_svc_handler+0xd4/0x198
> >>>> [15030.027933]  el0_svc+0x8/0xc
> >>>> [15030.030814]
> >>>> [15030.032306] Freed by task 3025:
> >>>> [15030.035451]  __kasan_slab_free+0x114/0x228
> >>>> [15030.039548]  kasan_slab_free+0x10/0x18
> >>>> [15030.043299]  kfree+0x114/0x408
> >>>> [15030.046357]  selinux_sk_free_security+0x38/0x48
> >>>> [15030.050888]  security_sk_free+0x3c/0x58
> >>>> [15030.054727]  __sk_destruct+0x3e8/0x570
> >>>> [15030.058478]  sk_destruct+0x4c/0x58
> >>>> [15030.061881]  __sk_free+0x68/0x138
> >>>> [15030.065197]  sk_free+0x3c/0x48
> >>>> [15030.068255]  unix_release_sock+0x4a8/0x550
> >>>> [15030.072353]  unix_release+0x34/0x50
> >>>> [15030.075843]  __sock_release+0x74/0x110
> >>>> [15030.079593]  sock_close+0x24/0x38
> >>>> [15030.082913]  __fput+0x1b8/0x368
> >>>> [15030.086055]  ____fput+0x20/0x30
> >>>> [15030.089199]  task_work_run+0x14c/0x1a8
> >>>> [15030.092951]  do_notify_resume+0x1e4/0x200
> >>>> [15030.096961]  work_pending+0x8/0x14
> >>>
> >>> Any chance you have a reproducer for this?  Or at the very least a
> >>> line number inside selinux_sctp_bind_connect()?
> >>>
> >> Yes, running trinity as non-root will trigger it all the time on this
> >> aarch64 server so far.
> >
> > Is it just aarch64, or are you seeing it on other arches as well?
>
> I only have an aarch64 server to test so far.

Did you see similar problems with 4.20-rc1?

> >> $ trinity
> >>
> >> https://github.com/kernelslacker/trinity.git
> >>
> >> If you have a debug patch I am happy to try that as well if you
> >> need to gather more information.

-- 
paul moore
www.paul-moore.com
