Return-Path: <SRS0=smjq=NY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F37C43441
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 03:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465AE223DD
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 03:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="voMXZCXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465AE223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbeKMNFi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Nov 2018 08:05:38 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:33148 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMNFh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Nov 2018 08:05:37 -0500
Received: by mail-lf1-f49.google.com with SMTP id i26so7723326lfc.0
        for <selinux@vger.kernel.org>; Mon, 12 Nov 2018 19:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YF+T26w6kVQ2fH1Gu0ZTlxe8ch9Qej9T477ten3mr+0=;
        b=voMXZCXeLtJi4t64TnvFQFwS7kao5Zzt80esxiS5EaAmI4M+Lo7K0iS2cQKORwk3OJ
         BccDiTFSuAyiTd12S2Sf/7IwlKHOwbB/yC8SRfTXIWXhinTwZWDGjIxHW/syTm0k7hGZ
         uk3Kr9H/eczpxCN5aB8u0UCGuRWt8plMp4SQz0MdGopEf0mEk+kjz15z0NHtSfPa7smQ
         /eRxtcBPZUeHS9vvv0+iSaMlvZo5OC2li77opMtFNCzovIcyHVTwAXl6XnZPCV5ARsiQ
         CEjMnZjgfHG0LHcsQe7ehSvo1AI2mbvDhYMfUysGS9VYpv4xeNzcraT7ghPVhRBdGik9
         AoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YF+T26w6kVQ2fH1Gu0ZTlxe8ch9Qej9T477ten3mr+0=;
        b=X8r5thvUGc3UKbrtb1DefrPvVCr8RES0BHhjtiqa0EAkkQciF92Zu/l5uyG2rQ4wm7
         b/5bSRVUeuha0Sx7nDymrih7/J1CS49Da1KHc/HrNdyM/2YLb+ZFAxjXD8a4MGkUOLx6
         epoOaQNCcsTogtutInBcWsxwGvQQVFct5e3wn72hJi11wbPn37hiRCeHO8ICK63RdhMK
         6h4GRQt41ipZhu0Q0TH9NJRA4UiMvZtcXMvcqEhbzkuC+xIjhj9qGWLjlVidas5e4RE0
         zkRPq6J6wXvImP9voYjjSClJp0aaUyJX7yXVAWgpp+wTUEZHJGcqPgPOllNPqUsxLhk0
         /wcA==
X-Gm-Message-State: AGRZ1gK/raNfgEEpSIMYlqn9iaMdoOrRxVYDL00IfEGb8tK+T043ZHMU
        sKTHcix/rDgWErl/lpSLjGvODZTNXAXucfGjG14V
X-Google-Smtp-Source: AJdET5cQAwbeA0UTZSRZeNGv/lFXmU6MrHwiHHKt2R/bOyz3OhsJjlFz6rwPtcQdKXn1CMK3ZlH+B0FAufBCZ1LUslg=
X-Received: by 2002:a19:8fce:: with SMTP id s75mr1889164lfk.151.1542078571284;
 Mon, 12 Nov 2018 19:09:31 -0800 (PST)
MIME-Version: 1.0
References: <53491A18-DD21-4E34-BC2F-AB449C7844E8@gmx.us> <CAHC9VhTiCPwQ51ciexRCp4M5rN2C=pTm=anRaMgTsZ9coX96Zw@mail.gmail.com>
 <7DE35AF4-20E1-4402-9B5A-4D8AACE15D56@gmx.us>
In-Reply-To: <7DE35AF4-20E1-4402-9B5A-4D8AACE15D56@gmx.us>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Nov 2018 22:09:19 -0500
Message-ID: <CAHC9VhRODL9JYjJ3QpExMaztA3PFv_Z1t=Q=4K8QMtJh7ntVuw@mail.gmail.com>
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

On Mon, Nov 12, 2018 at 7:59 PM Qian Cai <cai@gmx.us> wrote:
> > On Nov 12, 2018, at 7:41 PM, Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Nov 12, 2018 at 2:39 PM Qian Cai <cai@gmx.us> wrote:
> >>
> >> Running the trinity fuzzer on the latest mainline (rc2) generates this,
> >>
> >> [15029.879626] BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x60/0x150
> >> [15029.887275] Read of size 2 at addr ffff801ec53c5080 by task trinity-main/18081
> >> [15029.887294]
> >> [15029.887304] CPU: 28 PID: 18081 Comm: trinity-main Tainted: G        W  OE     4.20.0-rc2+ #15
> >> [15029.887311] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50 06/01/2018
> >> [15000.084786] [15029.887320] Call trace:
> >> [15029.915511]  dump_backtrace+0x0/0x2c8
> >> [15029.920046]  show_stack+0x24/0x30
> >> [15029.923367]  dump_stack+0x118/0x19c
> >> [15029.927539]  print_address_description+0x68/0x2a0
> >> [15029.932245]  kasan_report+0x1b4/0x348
> >> [15029.938760]  __asan_load2+0x7c/0xa0
> >> [15029.945098]  selinux_sctp_bind_connect+0x60/0x150
> >>
> >> [15029.950571]  security_sctp_bind_connect+0x58/0x90
> >> [15029.955493]  __sctp_setsockopt_connectx+0x68/0x128 [sctp]
> >> [15029.960943]  sctp_setsockopt+0x764/0x2928 [sctp]
> >> [15029.965564]  sock_common_setsockopt+0x6c/0x80
> >> [15029.969923]  __arm64_sys_setsockopt+0x13c/0x1f0
> >> [15029.974456]  el0_svc_handler+0xd4/0x198
> >> [15029.978293]  el0_svc+0x8/0xc
> >> [15029.981174]
> >> [15029.982667] Allocated by task 18081:
> >> [15029.986245]  kasan_kmalloc.part.1+0x40/0x108
> >> [15029.990517]  kasan_kmalloc+0xb4/0xc8
> >> [15029.994094]  __kmalloc_node+0x1c4/0x638
> >> [15029.997933]  kvmalloc_node+0x98/0xa8
> >> [15030.001511]  vmemdup_user+0x34/0x128
> >> [15030.005137]  __sctp_setsockopt_connectx+0x44/0x128 [sctp]
> >> [15030.010586]  sctp_setsockopt+0x764/0x2928 [sctp]
> >> [15030.015205]  sock_common_setsockopt+0x6c/0x80
> >> [15030.019564]  __arm64_sys_setsockopt+0x13c/0x1f0
> >> [15030.024096]  el0_svc_handler+0xd4/0x198
> >> [15030.027933]  el0_svc+0x8/0xc
> >> [15030.030814]
> >> [15030.032306] Freed by task 3025:
> >> [15030.035451]  __kasan_slab_free+0x114/0x228
> >> [15030.039548]  kasan_slab_free+0x10/0x18
> >> [15030.043299]  kfree+0x114/0x408
> >> [15030.046357]  selinux_sk_free_security+0x38/0x48
> >> [15030.050888]  security_sk_free+0x3c/0x58
> >> [15030.054727]  __sk_destruct+0x3e8/0x570
> >> [15030.058478]  sk_destruct+0x4c/0x58
> >> [15030.061881]  __sk_free+0x68/0x138
> >> [15030.065197]  sk_free+0x3c/0x48
> >> [15030.068255]  unix_release_sock+0x4a8/0x550
> >> [15030.072353]  unix_release+0x34/0x50
> >> [15030.075843]  __sock_release+0x74/0x110
> >> [15030.079593]  sock_close+0x24/0x38
> >> [15030.082913]  __fput+0x1b8/0x368
> >> [15030.086055]  ____fput+0x20/0x30
> >> [15030.089199]  task_work_run+0x14c/0x1a8
> >> [15030.092951]  do_notify_resume+0x1e4/0x200
> >> [15030.096961]  work_pending+0x8/0x14
> >
> > Any chance you have a reproducer for this?  Or at the very least a
> > line number inside selinux_sctp_bind_connect()?
> >
> Yes, running trinity as non-root will trigger it all the time on this
> aarch64 server so far.

Is it just aarch64, or are you seeing it on other arches as well?

> $ trinity
>
> https://github.com/kernelslacker/trinity.git
>
> If you have a debug patch I am happy to try that as well if you
> need to gather more information.

-- 
paul moore
www.paul-moore.com
