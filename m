Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED847C433EF
	for <selinux@archiver.kernel.org>; Wed, 15 Dec 2021 17:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhLORlm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Dec 2021 12:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhLORlm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Dec 2021 12:41:42 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4183C06173E
        for <selinux@vger.kernel.org>; Wed, 15 Dec 2021 09:41:41 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id t19so32733244oij.1
        for <selinux@vger.kernel.org>; Wed, 15 Dec 2021 09:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CEsMSwzRRGWJW4PVrBodLfDw/1lqHZA8rCSabre/XwE=;
        b=D2Wa+6GTw6xa9kzytjtz4Q3P7TyGGI4hLvgySEaxb3Bw4/m1FswiNunGsN1vQaZZfM
         5RnxIu1nZPqsUpvon6ceZeNn4VoR72yqoZbOpp6BvRclK6DHL8AaOdj5KgiBM89iQoHx
         Wj8yczIHbsTWoyAPFG+2wSy1oXp49I+bkUlz6uYdC/ZkQHRrKW3vqLanvWejUxCe0lWr
         ZvQ+JueVAcJsLjYmqbQn9YHyRaTSTrVCZ6he1CgPuwf8CFx27ADoLk45Ckv+a9OoVPBl
         ln+eo4GwVnDDjkkVS4PUkO57qszz1pLnxLiID3vPRRbA8egJuvv7TPkHuG8KXftc8bGp
         8oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CEsMSwzRRGWJW4PVrBodLfDw/1lqHZA8rCSabre/XwE=;
        b=mVTQMbJkZ14T9+cd7x1SkbG2WfLh9zPBV3RbXAJfXtjvB65ZKCzg+VVAmy6zyg91mp
         vaoWDz6yUkttM0bhoph66cz7VpMms5NO2OFg8zobA4xYkM3eMpHVgv515AWHts8+r99y
         9gK17kz3QFbo9AuFN4rUOPc95/QzhogW0sfdj/6rvD5ppyxvklqo+mHXl1cYafy+6Ifo
         BfIEzcvczkVgmH51Bo/AIsSm8DK+ufb0+rzC6TmmfNxT9zJihDAVn7J0kz08R3MYr7MF
         JWrb222GnbaY3FpQ/m40dkvddG4uoNU09mtknAF0lLtsAxUjvplJDUUSZHiki/ArTW4R
         7fTg==
X-Gm-Message-State: AOAM531B1OeiDvzaztzVWjqzzIJ/BWscHraNBOMcOprKHXvmgBcGqE+w
        wLa5CoqRwxQEnKzPuP3q8ouhGk1/ytknJKzxe+3MJMe4LQk=
X-Google-Smtp-Source: ABdhPJw5hgU0VOC+C5lZjrKj9VTwR8KmHziy7BgyZK06GfdCeOxc/+HC2ngcETw/Mf1CVpQjR0D94ts+4Fu6BJVGVWI=
X-Received: by 2002:a05:6808:64c:: with SMTP id z12mr862892oih.128.1639590101207;
 Wed, 15 Dec 2021 09:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20211105154542.38434-1-cgzones@googlemail.com> <20211209164928.87459-1-cgzones@googlemail.com>
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 15 Dec 2021 12:41:30 -0500
Message-ID: <CAP+JOzTpxm-EDhB=6NZob06+=c2PxtkxmYYUgHbM=U-t-h=Gow@mail.gmail.com>
Subject: Re: [PATCH v3 00/36] libsepol: add fuzzer for reading binary policies
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 9, 2021 at 2:07 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add a libfuzz[1] based fuzzer testing the reading and parsing of binary p=
olicy
> files. This fuzzer will be run within the OSS-Fuzz service.
>
> Handle and reject a variety of edge cases causing crashes or resource lea=
ks.
>
> The fifth patch ("libsepol/fuzz: limit element sizes for fuzzing") limits=
, to
> avoid oom reports from the fuzzer, caused by huge memory allocations, all
> identifiers to a length of 2^16 for the fuzzer build only.
> A potential limit for the release build needs further discussion.
>
> [1]: https://llvm.org/docs/LibFuzzer.html
>
> v3:
>   - Drop RFC status
>   - [10] libsepol: add checks for read sizes
>     use PERM_SYMTAB_SIZE instead of bare 32 as limit
>   - [11] libsepol: enforce avtab item limit
>     take zero based numbering of variable items into account
>   - [30] libsepol: validate ocontexts
>     only check FS and NETIF ocons in selinux policies (not xen)
>
> v2:
>   - reorder patches
>     1. oss-fuzz related
>     2. libsepol parsing and other crashesand UB
>     3. enhance policy validation
>   - misc changes based on review by James Carter
>
>
> Christian G=C3=B6ttsche (36):
>   cifuzz: enable report-unreproducible-crashes
>   cifuzz: use the default runtime of 600 seconds
>   libsepol/fuzz: silence secilc-fuzzer
>   libsepol: add libfuzz based fuzzer for reading binary policies
>   libsepol/fuzz: limit element sizes for fuzzing
>   libsepol: use logging framework in conditional.c
>   libsepol: use logging framework in ebitmap.c
>   libsepol: use mallocarray wrapper to avoid overflows
>   libsepol: use reallocarray wrapper to avoid overflows
>   libsepol: add checks for read sizes
>   libsepol: enforce avtab item limit
>   libsepol: clean memory on conditional insertion failure
>   libsepol: reject abnormal huge sid ids
>   libsepol: reject invalid filetrans source type
>   libsepol: zero member before potential dereference
>   libsepol: use size_t for indexes in strs helpers
>   libsepol: do not underflow on short format arguments
>   libsepol: do not crash on class gaps
>   libsepol: do not crash on user gaps
>   libsepol: use correct size for initial string list
>   libsepol: do not create a string list with initial size zero
>   libsepol: split validation of datum array gaps and entries
>   libsepol: validate MLS levels
>   libsepol: validate expanded user range and level
>   libsepol: validate permission count of classes
>   libsepol: resolve log message mismatch
>   libsepol: validate avtab and avrule types
>   libsepol: validate constraint expression operators and attributes
>   libsepol: validate type of avtab type rules
>   libsepol: validate ocontexts
>   libsepol: validate genfs contexts
>   libsepol: validate permissive types
>   libsepol: validate policy properties
>   libsepol: validate categories
>   libsepol: validate fsuse types
>   libsepol: validate class default targets
>
>  .github/workflows/cifuzz.yml     |   3 +-
>  libsepol/fuzz/binpolicy-fuzzer.c |  63 ++++
>  libsepol/fuzz/policy.bin         | Bin 0 -> 1552 bytes
>  libsepol/fuzz/secilc-fuzzer.c    |   5 +
>  libsepol/src/Makefile            |   6 +
>  libsepol/src/avtab.c             |   6 +
>  libsepol/src/conditional.c       |  53 ++--
>  libsepol/src/ebitmap.c           |  27 +-
>  libsepol/src/expand.c            |   4 +-
>  libsepol/src/hashtab.c           |   4 +-
>  libsepol/src/kernel_to_cil.c     |  10 +
>  libsepol/src/kernel_to_common.c  |  23 +-
>  libsepol/src/kernel_to_common.h  |   4 +-
>  libsepol/src/kernel_to_conf.c    |  13 +-
>  libsepol/src/link.c              |   3 +-
>  libsepol/src/module.c            |   4 +-
>  libsepol/src/module_to_cil.c     |  13 +-
>  libsepol/src/optimize.c          |  11 +-
>  libsepol/src/policydb.c          |  27 +-
>  libsepol/src/policydb_validate.c | 477 +++++++++++++++++++++++++++----
>  libsepol/src/private.h           |  27 +-
>  libsepol/src/services.c          |  12 +-
>  libsepol/src/sidtab.c            |   3 +-
>  libsepol/src/user_record.c       |   8 +-
>  libsepol/src/users.c             |  12 +-
>  libsepol/src/util.c              |  11 +-
>  libsepol/src/write.c             |   2 +-
>  scripts/oss-fuzz.sh              |  17 +-
>  28 files changed, 686 insertions(+), 162 deletions(-)
>  create mode 100644 libsepol/fuzz/binpolicy-fuzzer.c
>  create mode 100644 libsepol/fuzz/policy.bin
>
> --
> 2.34.1
>

For the series:
Acked-by: James Carter <jwcart2@gmail.com>

As I noted, I will move the comment out of the expression when I apply patc=
h 11.

Thanks,
Jim
