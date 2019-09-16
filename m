Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A539AC49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 16:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E862214D9
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 16:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YWurWQwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfIPQoM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:44:12 -0400
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:62664 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfIPQoL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 12:44:11 -0400
X-EEMSG-check-017: 28338238|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="28338238"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Sep 2019 16:44:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568652242; x=1600188242;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=wmKjCP+9AXt8Fc4Lig1MzWWwAswuOhxg5j+2XKFEsO0=;
  b=YWurWQwUneFxNil4aeOyrEYEmZ476/Ef53sm2Y6MLhw/OD0tK2UPQaMq
   HCrljLCX4lhtkVc/b5EE/EFoLMVDxkrHN3X+JhsCmKsOEtcB93uieVzOQ
   3KpY761yHS+lSWyF8plUUJXgIcmgKXsZ0VOWDPVuaQrC+UL3vcY1CGYt+
   f8tySwhMj4gU+1RExQm58Yt9d2K4T6fWLgZKdyLojXbi6MQWUomgBQ7Mq
   euQDcsGegwBWdXhDnkS0l7nLqWCJM7aOudjmZkddbrUaxBDacDXEfYnfx
   Q223BELYl/3/cBkEgoGKRHtGKX5uucHOLREMEkaCJMro+TcYCZUb9pzpO
   A==;
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="27959526"
IronPort-PHdr: =?us-ascii?q?9a23=3AV0HyqRR7CN5bCxr+glAnRpVP19psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zbBeN2/xhgRfzUJnB7Loc0qyK6vumADdLuM7d+DBaKdoQDk?=
 =?us-ascii?q?VD0Z1X1yUbQ+e9QXXhK/DrayFoVO9jb3RCu0+BDE5OBczlbEfTqHDhpRQbGx?=
 =?us-ascii?q?H4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyLBKrpgnNq8Uam4RvJrs/xx?=
 =?us-ascii?q?fTv3dFdetayX50KV+cgh3w4tu88IN5/ylfpv4t6dRMXbnmc6g9ULdVECkoP2?=
 =?us-ascii?q?cp6cPxqBLNVxGP5nwSUmUXlhpHHQ3I5wzkU5nyryX3qPNz1DGVMsPqQ780Xy?=
 =?us-ascii?q?+i77pwRx/zlCgHLT85/3rJhcF2kalWvQiupx17w47TfYGVKP9zdb7TcN8GWW?=
 =?us-ascii?q?ZMWNtaWjdfCY2gcYQAE+sBPf5Zr4bjoVsOsQC+DhSoCO/21zNEmmP60ag83u?=
 =?us-ascii?q?svCwHG2BErEcwIvnrasd75ML4eXO6xwaXNyzjIcvFY1irn6IXQbx4vv/+MU7?=
 =?us-ascii?q?Jzf8Tfx0YgGAHKgUmfp4H+IzOY1P4Av3SH4+duV++ijXMspQFrojiow8chko?=
 =?us-ascii?q?vJh4wJxV/e7yV53Jg5LsC/RU55b9+rDIFftzuGN4doWc4iX2Fptzo6yr0Bo5?=
 =?us-ascii?q?K7ejMKx449yx7QbPyHbZGF7xT+X+ifJjd4gWhqeLO5hxuq9UigxfH8Vsyu3F?=
 =?us-ascii?q?lWqSpFl8HAtn4W2BzS7MiHROVy/l271TmT0ADT7+dJKl03m6rDM5Mt37E9m5?=
 =?us-ascii?q?UJvUnDAyP6glv6gaCIekk+5+Sl7fnsbK/8qZ+GLYB0jxnzMqEpmsOiH+s1Kh?=
 =?us-ascii?q?MOX22H+eSk073j4FH5TK1KjvIolqnZt4jXJdgBqa6jAg9Vz50j5wyjDzamzN?=
 =?us-ascii?q?sYnX4HIEhDeB2blIjmJ0vCIPX5Dfe7m1iskTFryO7aPrD5H5nAIXfOnK3hcL?=
 =?us-ascii?q?pg8UJQ1gU+wc5F655JEr0BJej8Wk71tNzWFB85NAm0zv7lCNRzyowRQ3iPAr?=
 =?us-ascii?q?OHPK7JrV+J5v4gI+mLZIMPvjb9MOIq6+ThjX8+h18RZbOp0ocPaHCkAvRmJF?=
 =?us-ascii?q?2UYXztgtgdFmcKuhAxTPfwhF2DVj5TYG2yX7kn6zE+B4+nAp3PRoe3gLyOxC?=
 =?us-ascii?q?27BIFZZnhaClCQFnflb56EVOkIaCKTJM9hjzMFWKO/S48uyx6urhX2y7l5Ie?=
 =?us-ascii?q?rO/C0Xq5bj2MJy5+3JmhFhvQBzWuKc2GaJRno8v2QPXCR+iKZ+qkt5w0zF0K?=
 =?us-ascii?q?9/mOdwEIBDofRTXVF+fYXRy+18FsDaRA3MZJGKRUygT9HgBis+HfwrxNpbYV?=
 =?us-ascii?q?l2Es++1FiX3TWhCqUJzZSXFZc09eTaxHG3KMFjnSWVnJI9hkUrF5McfVatgb?=
 =?us-ascii?q?Ryok2KXN/E?=
X-IPAS-Result: =?us-ascii?q?A2AqDgAru39d/wHyM5BmHQEBBQEHBQGBZ4FuKm1SATIqh?=
 =?us-ascii?q?CGPBoIPmTOBZwkBAQEBAQEBAQErCQECAQGCEoItAoJvIzgTAgwBAQEEAQEBA?=
 =?us-ascii?q?QEFAwEBbIUuDII6KQGCZwEFIxVRCwkPAgImAgJXBgEMBgIBAYJfPwGCCg+tD?=
 =?us-ascii?q?oEyhE4Pb4M3gUMGgQwoi3iBV0CBESeCPS4+hC2DIoJYBIEvAYkYghWJFIEyl?=
 =?us-ascii?q?UcGgiaFdYEQhRCIZQYbmRmOCYVOgj6TByGBWCsKQYFogRoBATIfhhWKbyQDM?=
 =?us-ascii?q?IEGAQGPbgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Sep 2019 16:44:00 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8GGhxuo010332;
        Mon, 16 Sep 2019 12:43:59 -0400
Subject: Re: [Non-DoD Source] [PATCH 0/9] Fix issues found by static analyzers
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190901180636.31586-1-nicolas.iooss@m4x.org>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <393f7b30-35e5-5c43-7d26-070dd43adbb3@tycho.nsa.gov>
Date:   Mon, 16 Sep 2019 12:46:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190901180636.31586-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/1/19 2:06 PM, Nicolas Iooss wrote:
> Hi,
> 
> In August I ran several free static analyzers in order to find new
> issues in the userspace code. I used:
> 
> * clang's static analyzer (with scripts/run-scan-build)
> * https://lgtm.com/ (I wrote a simple configuration file to analyze the
>    C code, the results are available on
>    https://lgtm.com/projects/g/fishilico/selinux-for-lgtm/ )
> * Facebook's Infer (https://fbinfer.com/, I wrote a script to invoke it
>    like clang's static analyzer)
> 
> Each analyzer gave many results, with several true bugs in them. Here
> are patches that fix some of them. I will post the configuration files
> and scripts I used separately.
> 
> Thanks,
> Nicolas
> 
> Nicolas Iooss (9):
>    semodule-utils: fix comparison with argc
>    libsepol/cil: help static analyzers by aborting when an allocation
>      fails
>    libsepol: do not dereference a failed allocated pointer
>    libsepol: do not dereference scope if it can be NULL
>    libsepol: reset *p to NULL if sepol_module_package_create fails
>    libsepol/cil: do not dereference perm_value_to_cil when it has not
>      been allocated
>    python/chcat: remove unnecessary assignment
>    python/sepolicy: remove unnecessary pass statement
>    libsepol/tests: do not dereference a NULL pointer
> 
>   libsepol/cil/src/cil_binary.c                        | 10 ++++++----
>   libsepol/cil/src/cil_mem.c                           |  5 +++++
>   libsepol/src/avrule_block.c                          |  3 ++-
>   libsepol/src/kernel_to_cil.c                         |  8 +++++---
>   libsepol/src/kernel_to_conf.c                        |  8 +++++---
>   libsepol/src/module.c                                |  4 +++-
>   libsepol/tests/test-common.c                         | 11 +++++++----
>   python/chcat/chcat                                   |  1 -
>   python/sepolicy/sepolicy/__init__.py                 |  1 -
>   semodule-utils/semodule_package/semodule_unpackage.c |  2 +-
>   10 files changed, 34 insertions(+), 19 deletions(-)
> 

I forgot to mention this when I commented on patches 2 and 3, but patches 1 and 
4-9 all look good to me.

I plan on merging these, my take on your patch 2, and your updated patch 3 
tomorrow, unless there are any objections.

Jim


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
