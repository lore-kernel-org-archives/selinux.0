Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9535C433F5
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 21:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB57610E9
	for <selinux@archiver.kernel.org>; Mon,  8 Nov 2021 21:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240596AbhKHVti (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Nov 2021 16:49:38 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:55877 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhKHVti (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Nov 2021 16:49:38 -0500
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 958F4561202
        for <selinux@vger.kernel.org>; Mon,  8 Nov 2021 22:46:51 +0100 (CET)
Received: by mail-pf1-f182.google.com with SMTP id x131so12155364pfc.12
        for <selinux@vger.kernel.org>; Mon, 08 Nov 2021 13:46:51 -0800 (PST)
X-Gm-Message-State: AOAM533z7ihFEY2CqUkItVgf5eeCPKhr0x4FCW+6D0cMz/L1Zxhp5nD+
        pd702XwkpWUyMXOq5tc/kv8WCExuulll4p3n9G0=
X-Google-Smtp-Source: ABdhPJyORtMuMtXIoZRzAML23Yfi2WLDQEU09dWubWyJfxYr2oZvfhnpSn1lTg0ipNujsNbkCpmmSpyRmG8U/zZEkzk=
X-Received: by 2002:a63:3d4c:: with SMTP id k73mr2047023pga.44.1636408010307;
 Mon, 08 Nov 2021 13:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20211027181210.1019597-1-jwcart2@gmail.com> <CAEjxPJ4kNNPkzLcU1Ovr5DWSo7obkm+QyueMt7BE3r7ALuUnqg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4kNNPkzLcU1Ovr5DWSo7obkm+QyueMt7BE3r7ALuUnqg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 8 Nov 2021 22:46:39 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=k-1FE27swaxcnHki_0pJCZqZRgno=0fUN52VHWs7e3Bw@mail.gmail.com>
Message-ID: <CAJfZ7=k-1FE27swaxcnHki_0pJCZqZRgno=0fUN52VHWs7e3Bw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix/add optional file type handling for genfscon rules
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000029b60e05d04dee54"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Nov  8 22:46:52 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--00000000000029b60e05d04dee54
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 4, 2021 at 9:09 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Oct 27, 2021 at 5:32 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > genfscon rules have always supported an optional file type, but when
> > the ability for writing a policy.conf file from a kernel policy was
> > added to libsepol it did not include that support. Support for the
> > optional file type was also left out of CIL genfscon rules.
> >
> > This patch set fixes these problems.
> >
> > Patch 1 adds support for writing the optional file type in genfscon rules
> > when writing a policy.conf file from a kernel policy.
> >
> > Patches 2-4 adds support in CIL for handling an optional file type
> > in genfscon rules, updates the CIL documentation, and adds support
> > when writing out CIL from a kernel policy or module as well.
> >
> > James Carter (4):
> >   libsepol: Add support for file types in writing out policy.conf
> >   libsepol/cil: Allow optional file type in genfscon rules
> >   secilc/docs: Document the optional file type for genfscon rules
> >   libsepol: Write out genfscon file type when writing out CIL policy
> >
> >  libsepol/cil/src/cil_binary.c               | 39 +++++++++++++++++++
> >  libsepol/cil/src/cil_build_ast.c            | 43 +++++++++++++++++++--
> >  libsepol/cil/src/cil_internal.h             |  1 +
> >  libsepol/src/kernel_to_cil.c                | 35 ++++++++++++++++-
> >  libsepol/src/kernel_to_conf.c               | 35 ++++++++++++++++-
> >  libsepol/src/module_to_cil.c                | 27 ++++++++++++-
> >  secilc/docs/cil_file_labeling_statements.md | 10 ++++-
> >  7 files changed, 179 insertions(+), 11 deletions(-)
>
> Something here breaks on the selinux-testsuite policy:
>
> 3231# Run the test suite
> 3232#
> 3233make test
> 3234make -C policy load
> 3235make[1]: Entering directory '/root/selinux-testsuite/policy'
> 3236# Test for "expand-check = 0" in /etc/selinux/semanage.conf
> 3237# General policy build
> 3238make[2]: Entering directory '/root/selinux-testsuite/policy/test_policy'
> 3239Compiling targeted test_policy module
> 3240Creating targeted test_policy.pp policy package
> 3241rm tmp/test_policy.mod tmp/test_policy.mod.fc
> 3242make[2]: Leaving directory '/root/selinux-testsuite/policy/test_policy'
> 3243# General policy load
> 3244domain_fd_use --> on
> 3245/usr/sbin/semodule -i test_policy/test_policy.pp
> test_mlsconstrain.cil test_overlay_defaultrange.cil
> test_userfaultfd.cil test_add_levels.cil test_glblub.cil
> 3246What is going on?
> 3247Failed to generate binary
> 3248/usr/sbin/semodule: Failed!
> 3249make[1]: *** [Makefile:189: load] Error 1
> 3250make[1]: Leaving directory '/root/selinux-testsuite/policy'
> 3251make: *** [Makefile:7: test] Error 2
> 3252Error: Process completed with exit code 2.

Hello,

This error happens because cil_genfscon_init() does not initialize
->file_type, and cil_genfscon_to_policydb() then reads an
uninitialized value. The attached patch (on top of this series) fixed
the CI for me.

Cheers,
Nicolas

--00000000000029b60e05d04dee54
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="initialize_genfscon_file_type_and_improve_errors.patch"
Content-Disposition: attachment; 
	filename="initialize_genfscon_file_type_and_improve_errors.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kvr712q50>
X-Attachment-Id: f_kvr712q50

ZGlmZiAtLWdpdCBhL2xpYnNlcG9sL2NpbC9zcmMvY2lsLmMgYi9saWJzZXBvbC9jaWwvc3JjL2Np
bC5jCmluZGV4IDRjYzdmODdmYTk0Ny4uYjIxMDc3MmNmZGI3IDEwMDY0NAotLS0gYS9saWJzZXBv
bC9jaWwvc3JjL2NpbC5jCisrKyBiL2xpYnNlcG9sL2NpbC9zcmMvY2lsLmMKQEAgLTI1NzYsNiAr
MjU3Niw3IEBAIHZvaWQgY2lsX2dlbmZzY29uX2luaXQoc3RydWN0IGNpbF9nZW5mc2NvbiAqKmdl
bmZzY29uKQogCSgqZ2VuZnNjb24pLT5wYXRoX3N0ciA9IE5VTEw7CiAJKCpnZW5mc2NvbiktPmNv
bnRleHRfc3RyID0gTlVMTDsKIAkoKmdlbmZzY29uKS0+Y29udGV4dCA9IE5VTEw7CisJKCpnZW5m
c2NvbiktPmZpbGVfdHlwZSA9IDA7IC8qIEZJWE1FOiAiMCIgc2VlbXMgdG8gbWVhbiAibm90IGlu
aXRpYWxpemVkIiBidXQgaXMgbm90IGEgdmFsdWUgZm9yIGVudW0gY2lsX2ZpbGVjb25fdHlwZXMu
IENJTF9GSUxFQ09OX0FOWSBjb3VsZCBiZSBiZXR0ZXI/ICovCiB9CiAKIHZvaWQgY2lsX3BpcnFj
b25faW5pdChzdHJ1Y3QgY2lsX3BpcnFjb24gKipwaXJxY29uKQpkaWZmIC0tZ2l0IGEvbGlic2Vw
b2wvY2lsL3NyYy9jaWxfYmluYXJ5LmMgYi9saWJzZXBvbC9jaWwvc3JjL2NpbF9iaW5hcnkuYwpp
bmRleCA1YzRiNzBmNzAzNTMuLjI5ZmIxNjVlODM1MiAxMDA2NDQKLS0tIGEvbGlic2Vwb2wvY2ls
L3NyYy9jaWxfYmluYXJ5LmMKKysrIGIvbGlic2Vwb2wvY2lsL3NyYy9jaWxfYmluYXJ5LmMKQEAg
LTM0OTQsMTMgKzM0OTQsMTMgQEAgaW50IGNpbF9nZW5mc2Nvbl90b19wb2xpY3lkYihwb2xpY3lk
Yl90ICpwZGIsIHN0cnVjdCBjaWxfc29ydCAqZ2VuZnNjb25zKQogCQkJCWNsYXNzX25hbWUgPSAi
bG5rX2ZpbGUiOwogCQkJCWJyZWFrOwogCQkJZGVmYXVsdDoKLQkJCQlmcHJpbnRmKHN0ZGVyciwg
IldoYXQgaXMgZ29pbmcgb24/XG4iKTsKKwkJCQljaWxfbG9nKENJTF9FUlIsICJnZW5mc2NvbiB1
c2VkIGFuIHVua25vd24gZmlsZSB0eXBlOiAldVxuIiwgY2lsX2dlbmZzY29uLT5maWxlX3R5cGUp
OwogCQkJCXJjID0gU0VQT0xfRVJSOwogCQkJCWdvdG8gZXhpdDsKIAkJCX0KIAkJCWNsYXNzX2Rh
dHVtID0gaGFzaHRhYl9zZWFyY2gocGRiLT5wX2NsYXNzZXMudGFibGUsIGNsYXNzX25hbWUpOwog
CQkJaWYgKCFjbGFzc19kYXR1bSkgewotCQkJCWZwcmludGYoc3RkZXJyLCAiV2hhdCBpcyBnb2lu
ZyBvbj9cbiIpOworCQkJCWNpbF9sb2coQ0lMX0VSUiwgImdlbmZzY29uIHVzZWQgYSBjbGFzcyB3
aGljaCB3YXMgbm90IGZvdW5kIGluIHRoZSBwb2xpY3k6ICVzXG4iLCBjbGFzc19uYW1lKTsKIAkJ
CQlyYyA9IFNFUE9MX0VSUjsKIAkJCQlnb3RvIGV4aXQ7CiAJCQl9Cg==
--00000000000029b60e05d04dee54--

