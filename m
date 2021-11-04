Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F50BC433EF
	for <selinux@archiver.kernel.org>; Thu,  4 Nov 2021 20:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23FD60F70
	for <selinux@archiver.kernel.org>; Thu,  4 Nov 2021 20:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhKDUMa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Nov 2021 16:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhKDUMa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Nov 2021 16:12:30 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0ADC061714
        for <selinux@vger.kernel.org>; Thu,  4 Nov 2021 13:09:51 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y8so11472114ljm.4
        for <selinux@vger.kernel.org>; Thu, 04 Nov 2021 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFDjWOXzyE5T/nGZ3c3Ibnf7kz7XZ2myKY7WvdI3Thc=;
        b=Cfc0ZjcDQWnpkpKpCUPxZ/DqAFbMh9H1Vejx5x4QB4nblPLUxSLJgHjm0Vz+VE1QvS
         netkDx9AHGlVnbtXTZKYEcHxwA5VG9D1iISxJs57+N3HdagnfWfOaUKbAuOFzdSOr832
         bBVhjM3zBtY/eP3a5DVhlty2cRzWVgaWOhaaRjjN9NLUTXRKUiTq+QUmhl5B1iJMHpDD
         v7EQo6aI6lLqROhpVVoqOGj+xIG3CNTTpzDC7/btUfmkPsIvBsJ2VW5eCkE/nU4nHQiW
         vQgNifqzqlZNBXR62yDMWTkkKp/rnS9x44n44ZynFwOyh/MDncmZBF/ISb0GtYLWxPFE
         WakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFDjWOXzyE5T/nGZ3c3Ibnf7kz7XZ2myKY7WvdI3Thc=;
        b=s88vDGxCNoVotK1Xlfm7Luv0lMR9GZaueI+Roymbk5TklEL+ETuMNUs6pU9UGCY1x1
         E0uXtjK8rXsltBd0ltNqT1seBmZEEzqz1NYK2H1yUq7VH7IBHE0pQVPUEi30c3Nq2C75
         F66vz2CvZAv6w+1QRKM1IOtl0ngkrTH6KGZvGSVG7wo1gB4f1ou+hceqBEtoVasY0lSq
         wM+Wj+lf+zVwH4XZlVklIdizOiTR1KnIH0VijmHyPXQm0xn2UIgUs6Ig3TiQsq8fvx3P
         ndHv6nOnDlzKWZ65o1G4SwlNnoTag9u7jXAgHTtZILyqrJycoB2XSE4ryhnxM+j+lyQp
         Wvww==
X-Gm-Message-State: AOAM530YNOFgwRjtSw/TRsVyvA0iP/twmApYBJ3UoQQpLeozYddreEUn
        MSY8jCKxGoKF5CR54n2MiSy6acYrIY/YeTG6VaEChLZzVtQ=
X-Google-Smtp-Source: ABdhPJx5vqbxBKE9LtWZdS6hxJB5wFrhRbjgcUBfrYCuOToYnctmF8bQFd38dGq5fzT5n+JCSW0G4xMXZ0e4upVuuMk=
X-Received: by 2002:a05:651c:1583:: with SMTP id h3mr55203164ljq.98.1636056589809;
 Thu, 04 Nov 2021 13:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211027181210.1019597-1-jwcart2@gmail.com>
In-Reply-To: <20211027181210.1019597-1-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 4 Nov 2021 16:09:38 -0400
Message-ID: <CAEjxPJ4kNNPkzLcU1Ovr5DWSo7obkm+QyueMt7BE3r7ALuUnqg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix/add optional file type handling for genfscon rules
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 27, 2021 at 5:32 PM James Carter <jwcart2@gmail.com> wrote:
>
> genfscon rules have always supported an optional file type, but when
> the ability for writing a policy.conf file from a kernel policy was
> added to libsepol it did not include that support. Support for the
> optional file type was also left out of CIL genfscon rules.
>
> This patch set fixes these problems.
>
> Patch 1 adds support for writing the optional file type in genfscon rules
> when writing a policy.conf file from a kernel policy.
>
> Patches 2-4 adds support in CIL for handling an optional file type
> in genfscon rules, updates the CIL documentation, and adds support
> when writing out CIL from a kernel policy or module as well.
>
> James Carter (4):
>   libsepol: Add support for file types in writing out policy.conf
>   libsepol/cil: Allow optional file type in genfscon rules
>   secilc/docs: Document the optional file type for genfscon rules
>   libsepol: Write out genfscon file type when writing out CIL policy
>
>  libsepol/cil/src/cil_binary.c               | 39 +++++++++++++++++++
>  libsepol/cil/src/cil_build_ast.c            | 43 +++++++++++++++++++--
>  libsepol/cil/src/cil_internal.h             |  1 +
>  libsepol/src/kernel_to_cil.c                | 35 ++++++++++++++++-
>  libsepol/src/kernel_to_conf.c               | 35 ++++++++++++++++-
>  libsepol/src/module_to_cil.c                | 27 ++++++++++++-
>  secilc/docs/cil_file_labeling_statements.md | 10 ++++-
>  7 files changed, 179 insertions(+), 11 deletions(-)

Something here breaks on the selinux-testsuite policy:

3231# Run the test suite
3232#
3233make test
3234make -C policy load
3235make[1]: Entering directory '/root/selinux-testsuite/policy'
3236# Test for "expand-check = 0" in /etc/selinux/semanage.conf
3237# General policy build
3238make[2]: Entering directory '/root/selinux-testsuite/policy/test_policy'
3239Compiling targeted test_policy module
3240Creating targeted test_policy.pp policy package
3241rm tmp/test_policy.mod tmp/test_policy.mod.fc
3242make[2]: Leaving directory '/root/selinux-testsuite/policy/test_policy'
3243# General policy load
3244domain_fd_use --> on
3245/usr/sbin/semodule -i test_policy/test_policy.pp
test_mlsconstrain.cil test_overlay_defaultrange.cil
test_userfaultfd.cil test_add_levels.cil test_glblub.cil
3246What is going on?
3247Failed to generate binary
3248/usr/sbin/semodule: Failed!
3249make[1]: *** [Makefile:189: load] Error 1
3250make[1]: Leaving directory '/root/selinux-testsuite/policy'
3251make: *** [Makefile:7: test] Error 2
3252Error: Process completed with exit code 2.
