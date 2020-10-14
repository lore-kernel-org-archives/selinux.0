Return-Path: <SRS0=aJPZ=DV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0846BC433DF
	for <selinux@archiver.kernel.org>; Wed, 14 Oct 2020 18:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB5D2222C
	for <selinux@archiver.kernel.org>; Wed, 14 Oct 2020 18:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A67xn9df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgJNSBS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Oct 2020 14:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727071AbgJNSBR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Oct 2020 14:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602698475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2b27p4YFEAeJHqR2mmOVgDiXgsiQQERuedTGQSQ7kg=;
        b=A67xn9dfscF0tSfYaP2D6nYMoiP+gMu/IGO2OksaCYZtpxAOJcKVNSQ03K0utLX52EnX5g
        Qj+97EYwKGkaf+5X0WamorL1MhVNYWEchmgc2soNp8pmlrURScUG+LncMs66Cs8q7mY8zE
        KeDtet7eDIV3IIcBIqNuaxDx852iyy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-BUfBVDuPMaiE06QRK8JVjA-1; Wed, 14 Oct 2020 14:01:13 -0400
X-MC-Unique: BUfBVDuPMaiE06QRK8JVjA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79F321062721;
        Wed, 14 Oct 2020 18:01:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 146471992F;
        Wed, 14 Oct 2020 18:01:09 +0000 (UTC)
Date:   Wed, 14 Oct 2020 20:01:06 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH userspace] libsepol/cil: fix signed overflow caused by
 using (1 << 31) - 1
Message-ID: <20201014180106.GA16337@localhost.localdomain>
References: <20201003131908.1867282-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003131908.1867282-1-nicolas.iooss@m4x.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Oct 03, 2020 at 03:19:08PM +0200, Nicolas Iooss wrote:
> When compiling SELinux userspace tools with -ftrapv (this option
> generates traps for signed overflow on addition, subtraction,
> multiplication operations, instead of silently wrapping around),
> semodule crashes when running the tests from
> scripts/ci/fedora-test-runner.sh in a Fedora 32 virtual machine:
> 
>     [root@localhost selinux-testsuite]# make test
>     make -C policy load
>     make[1]: Entering directory '/root/selinux-testsuite/policy'
>     # Test for "expand-check = 0" in /etc/selinux/semanage.conf
>     # General policy build
>     make[2]: Entering directory '/root/selinux-testsuite/policy/test_policy'
>     Compiling targeted test_policy module
>     Creating targeted test_policy.pp policy package
>     rm tmp/test_policy.mod.fc
>     make[2]: Leaving directory '/root/selinux-testsuite/policy/test_policy'
>     # General policy load
>     domain_fd_use --> off
>     /usr/sbin/semodule -i test_policy/test_policy.pp test_mlsconstrain.cil test_overlay_defaultrange.cil test_add_levels.cil test_glblub.cil
>     make[1]: *** [Makefile:174: load] Aborted (core dumped)
> 
> Using "coredumpctl gdb" leads to the following strack trace:
> 
>     (gdb) bt
>     #0  0x00007f608fe4fa25 in raise () from /lib64/libc.so.6
>     #1  0x00007f608fe38895 in abort () from /lib64/libc.so.6
>     #2  0x00007f6090028aca in __addvsi3.cold () from /lib64/libsepol.so.1
>     #3  0x00007f6090096f59 in __avrule_xperm_setrangebits (low=30, high=30, xperms=0x8b9eea0)
>         at ../cil/src/cil_binary.c:1551
>     #4  0x00007f60900970dd in __cil_permx_bitmap_to_sepol_xperms_list (xperms=0xb650a30, xperms_list=0x7ffce2653b18)
>         at ../cil/src/cil_binary.c:1596
>     #5  0x00007f6090097286 in __cil_avrulex_ioctl_to_policydb (k=0xb8ec200 "@\023\214\022\006", datum=0xb650a30,
>         args=0x239a640) at ../cil/src/cil_binary.c:1649
>     #6  0x00007f609003f1e5 in hashtab_map (h=0x41f8710, apply=0x7f60900971da <__cil_avrulex_ioctl_to_policydb>,
>         args=0x239a640) at hashtab.c:234
>     #7  0x00007f609009ea19 in cil_binary_create_allocated_pdb (db=0x2394f10, policydb=0x239a640)
>         at ../cil/src/cil_binary.c:4969
>     #8  0x00007f609009d19d in cil_binary_create (db=0x2394f10, policydb=0x7ffce2653d30) at ../cil/src/cil_binary.c:4329
>     #9  0x00007f609008ec23 in cil_build_policydb_create_pdb (db=0x2394f10, sepol_db=0x7ffce2653d30)
>         at ../cil/src/cil.c:631
>     #10 0x00007f608fff4bf3 in semanage_direct_commit () from /lib64/libsemanage.so.1
>     #11 0x00007f608fff9fae in semanage_commit () from /lib64/libsemanage.so.1
>     #12 0x0000000000403e2b in main (argc=7, argv=0x7ffce2655058) at semodule.c:753
> 
>     (gdb) f 3
>     #3  0x00007f6090096f59 in __avrule_xperm_setrangebits (low=30, high=30, xperms=0x8b9eea0)
>         at ../cil/src/cil_binary.c:1551
>     1551     xperms->perms[i] |= XPERM_SETBITS(h) - XPERM_SETBITS(low);
> 
> A signed integer overflow therefore occurs in XPERM_SETBITS(h):
> 
>     #define XPERM_SETBITS(x) ((1 << (x & 0x1f)) - 1)
> 
> This macro is expanded with h=31, so "(1 << 31) - 1" is computed:
> 
> * (1 << 31) = -0x80000000 is the lowest signed 32-bit integer value
> * (1 << 31) - 1 overflows the capacity of a signed 32-bit integer and
>   results in 0x7fffffff (which is unsigned)
> 
> Using unsigned integers (with "1U") fixes the crash, as
> (1U << 31) = 0x80000000U has no overflowing issues.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

> ---
>  checkpolicy/policy_define.c   | 2 +-
>  libsepol/cil/src/cil_binary.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 395f62284e3c..bf6c3e68bef3 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -2147,7 +2147,7 @@ out:
>  /* index of the u32 containing the permission */
>  #define XPERM_IDX(x) (x >> 5)
>  /* set bits 0 through x-1 within the u32 */
> -#define XPERM_SETBITS(x) ((1 << (x & 0x1f)) - 1)
> +#define XPERM_SETBITS(x) ((1U << (x & 0x1f)) - 1)
>  /* low value for this u32 */
>  #define XPERM_LOW(x) (x << 5)
>  /* high value for this u32 */
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 36720eda4549..e417c5c28b8b 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -1526,7 +1526,7 @@ int cil_avrule_to_policydb(policydb_t *pdb, const struct cil_db *db, struct cil_
>  /* index of the u32 containing the permission */
>  #define XPERM_IDX(x) (x >> 5)
>  /* set bits 0 through x-1 within the u32 */
> -#define XPERM_SETBITS(x) ((1 << (x & 0x1f)) - 1)
> +#define XPERM_SETBITS(x) ((1U << (x & 0x1f)) - 1)
>  /* low value for this u32 */
>  #define XPERM_LOW(x) (x << 5)
>  /* high value for this u32 */
> -- 
> 2.28.0
> 

