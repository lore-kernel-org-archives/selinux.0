Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945F9C433FE
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbhLIQzJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhLIQzJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:09 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F32DC0617A1
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:51:35 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z5so21855881edd.3
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oavRwPIIRgCFMPRQuPb0r0fkX490sZ/rwrcnjPaOdMk=;
        b=ZsvZVNYZ2LHZ5oF68eSgmfVtqD9doArCgAOm1eZOrO+jcGLT3WoEQOgajWJefu97pU
         sz4dcSJ0C30pCogrGNaId4iJaLyjjpxbtIRgMsfAvGk3Rc1OZV5Ss01LJsOO4SK3HuuW
         844ngksSHZHpM6vgjOZn+SdPa77Rqr95Pu5xjAbPW9auh7QEiWgpdd3IH5kVE3lzG2hd
         e9p6Ij06UbZpeF0pRU2+eXlqadWNXA4/7hUKv2AMVMguf902Pv4ls8G+NU4H2NkYqZ8L
         tPPTrOnT1eVBCrm39980Jgn4BLPHoqZGodupDTMuo63Wp0CrguuZF703FIHnXfjIn3om
         CS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oavRwPIIRgCFMPRQuPb0r0fkX490sZ/rwrcnjPaOdMk=;
        b=jnlCBGKIrDBX5eCe5AkhHT8lphQQ1lJNS7YIDapfDpJqrzGXn66bYG3iPezx7ivbX9
         sCEtvjpYE9tIjQWA8qpXhrp/MVJ2rfbgjkdx+p0tSrT1klNzDq6vms0o5yIVJGfuybKP
         QJG2xE4NEJCROGC7sLDqK2Z8++bh1zhd7cKxZ73/npijrQIYUinn6Xs+9OpvMhuZP84G
         jMsyha4OiiZDs4CV5AvXAmoJp44zSK8VGfsdmRoVUcnqQ55z8bdtszLugETEOiS1lv5i
         xQ4p2WpWlomsu2v5o/p3kxRk7I27VugiTZaQ13tTA+Kd9+K66CHoRvarq9BlGYS/fzqL
         gtQQ==
X-Gm-Message-State: AOAM531OQvJI4wjAwi94gJ5oQXwT4JEwF15vxJlzofymTdh/idQ+OIXS
        GKRqk8NbILn6Dk18vYiHa5HTvBNnfhI=
X-Google-Smtp-Source: ABdhPJyjxatvSaphkJQR58miDyZVakYgOKG9yiGDbjKz6T6sxDyGMIqGRacrunFu/TF6y/GDZCYtSg==
X-Received: by 2002:a17:906:2c16:: with SMTP id e22mr17032215ejh.501.1639068575474;
        Thu, 09 Dec 2021 08:49:35 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.34
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:34 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 00/36] libsepol: add fuzzer for reading binary policies
Date:   Thu,  9 Dec 2021 17:48:52 +0100
Message-Id: <20211209164928.87459-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a libfuzz[1] based fuzzer testing the reading and parsing of binary policy
files. This fuzzer will be run within the OSS-Fuzz service.

Handle and reject a variety of edge cases causing crashes or resource leaks.

The fifth patch ("libsepol/fuzz: limit element sizes for fuzzing") limits, to
avoid oom reports from the fuzzer, caused by huge memory allocations, all
identifiers to a length of 2^16 for the fuzzer build only.
A potential limit for the release build needs further discussion.

[1]: https://llvm.org/docs/LibFuzzer.html

v3:
  - Drop RFC status
  - [10] libsepol: add checks for read sizes
    use PERM_SYMTAB_SIZE instead of bare 32 as limit
  - [11] libsepol: enforce avtab item limit
    take zero based numbering of variable items into account
  - [30] libsepol: validate ocontexts
    only check FS and NETIF ocons in selinux policies (not xen)

v2:
  - reorder patches
    1. oss-fuzz related
    2. libsepol parsing and other crashesand UB
    3. enhance policy validation
  - misc changes based on review by James Carter


Christian Göttsche (36):
  cifuzz: enable report-unreproducible-crashes
  cifuzz: use the default runtime of 600 seconds
  libsepol/fuzz: silence secilc-fuzzer
  libsepol: add libfuzz based fuzzer for reading binary policies
  libsepol/fuzz: limit element sizes for fuzzing
  libsepol: use logging framework in conditional.c
  libsepol: use logging framework in ebitmap.c
  libsepol: use mallocarray wrapper to avoid overflows
  libsepol: use reallocarray wrapper to avoid overflows
  libsepol: add checks for read sizes
  libsepol: enforce avtab item limit
  libsepol: clean memory on conditional insertion failure
  libsepol: reject abnormal huge sid ids
  libsepol: reject invalid filetrans source type
  libsepol: zero member before potential dereference
  libsepol: use size_t for indexes in strs helpers
  libsepol: do not underflow on short format arguments
  libsepol: do not crash on class gaps
  libsepol: do not crash on user gaps
  libsepol: use correct size for initial string list
  libsepol: do not create a string list with initial size zero
  libsepol: split validation of datum array gaps and entries
  libsepol: validate MLS levels
  libsepol: validate expanded user range and level
  libsepol: validate permission count of classes
  libsepol: resolve log message mismatch
  libsepol: validate avtab and avrule types
  libsepol: validate constraint expression operators and attributes
  libsepol: validate type of avtab type rules
  libsepol: validate ocontexts
  libsepol: validate genfs contexts
  libsepol: validate permissive types
  libsepol: validate policy properties
  libsepol: validate categories
  libsepol: validate fsuse types
  libsepol: validate class default targets

 .github/workflows/cifuzz.yml     |   3 +-
 libsepol/fuzz/binpolicy-fuzzer.c |  63 ++++
 libsepol/fuzz/policy.bin         | Bin 0 -> 1552 bytes
 libsepol/fuzz/secilc-fuzzer.c    |   5 +
 libsepol/src/Makefile            |   6 +
 libsepol/src/avtab.c             |   6 +
 libsepol/src/conditional.c       |  53 ++--
 libsepol/src/ebitmap.c           |  27 +-
 libsepol/src/expand.c            |   4 +-
 libsepol/src/hashtab.c           |   4 +-
 libsepol/src/kernel_to_cil.c     |  10 +
 libsepol/src/kernel_to_common.c  |  23 +-
 libsepol/src/kernel_to_common.h  |   4 +-
 libsepol/src/kernel_to_conf.c    |  13 +-
 libsepol/src/link.c              |   3 +-
 libsepol/src/module.c            |   4 +-
 libsepol/src/module_to_cil.c     |  13 +-
 libsepol/src/optimize.c          |  11 +-
 libsepol/src/policydb.c          |  27 +-
 libsepol/src/policydb_validate.c | 477 +++++++++++++++++++++++++++----
 libsepol/src/private.h           |  27 +-
 libsepol/src/services.c          |  12 +-
 libsepol/src/sidtab.c            |   3 +-
 libsepol/src/user_record.c       |   8 +-
 libsepol/src/users.c             |  12 +-
 libsepol/src/util.c              |  11 +-
 libsepol/src/write.c             |   2 +-
 scripts/oss-fuzz.sh              |  17 +-
 28 files changed, 686 insertions(+), 162 deletions(-)
 create mode 100644 libsepol/fuzz/binpolicy-fuzzer.c
 create mode 100644 libsepol/fuzz/policy.bin

-- 
2.34.1

