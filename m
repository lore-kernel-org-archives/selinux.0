Return-Path: <SRS0=6SNF=45=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AF1C10DCE
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 11:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD09D20716
	for <selinux@archiver.kernel.org>; Thu, 12 Mar 2020 11:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+DsrnVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725268AbgCLLhi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:37:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34379 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726254AbgCLLhi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Mar 2020 07:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584013056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qfmSQQAwDhWLECZ/Cd90GRHzoDgd7Yc+vMUqoBrWVWI=;
        b=D+DsrnVkKW1cATXcUdkUAAQRctH+qi8eaXH4p5uJOrq/VvLO9+tdo20NFTR7RipVjtHkkX
        s/pBBcFMdEMHkoBujbrhTuFvfwucQ3O5zTFgMt5+2ee60CdtYWG5HglP8Cz/N9Ny9GYyye
        zP9l8Qb/JIPLZgoxuqf4HhvObtoxM6c=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-g8jWlkKSNfKOey6OeZ5Rpw-1; Thu, 12 Mar 2020 07:37:34 -0400
X-MC-Unique: g8jWlkKSNfKOey6OeZ5Rpw-1
Received: by mail-oi1-f197.google.com with SMTP id d131so2856393oif.21
        for <selinux@vger.kernel.org>; Thu, 12 Mar 2020 04:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfmSQQAwDhWLECZ/Cd90GRHzoDgd7Yc+vMUqoBrWVWI=;
        b=GvI3uE3XTjL3Jd9qGR8z+4GvQWJaX+eRq4ySB7oG2OKFnSM6UZ+65x8NQmSm/Nm9iq
         U0UrHCrVtPajKdOTMHJWPx2VkUqdiKwCV4QdMd2gzWvkk9mTkG2ke9EjUUftZ5V9ehzI
         MUWaxDXHEKgUD6ZO7k3kLC3AVMDKWhIxji0SmrUmWxiBTH/juVlCQTX1gtOHxaFBcd+b
         pXUQj61c6xiapXpEQs39T7b8ID/n1ejn9kcYtG+rJqkdClBzMmhzgbOQf75mXQV8j7Lv
         NjQezlQn7Z3MYMd0n0Hfg4NNnitlQXvsVjBOtSY7sNDSaKIL8cTWsPlD+GpWi59Pd2vS
         n0vw==
X-Gm-Message-State: ANhLgQ0Bv/9wJhcAPGY+IvFof+PGC362RlrZWX1WYyuPZtPxqDho6Fgt
        cFeF9vHpx0RVIfRVriE2VfT2zetm8C0bXxp3VljOku6+2Syfk+wIZeo2luF/s2gH+wYxT9r8fLV
        up4tN4nLxj7vKaWnqDvsKhKk5IkE3acKq8w==
X-Received: by 2002:a4a:bb96:: with SMTP id h22mr3747260oop.9.1584013053627;
        Thu, 12 Mar 2020 04:37:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvZx0ZwkyUDOgTcxmJk5zyYqm6Z9PpAYYVvKd4lxVWxq4xxpIQDApE3pFT+FZrouA3zFtmAJ/Jz2zW8eQxOA+k=
X-Received: by 2002:a4a:bb96:: with SMTP id h22mr3747239oop.9.1584013053241;
 Thu, 12 Mar 2020 04:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200311212653.14602-1-joshua.brindle@crunchydata.com>
In-Reply-To: <20200311212653.14602-1-joshua.brindle@crunchydata.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 12 Mar 2020 12:37:23 +0100
Message-ID: <CAFqZXNv_E6EVkiQTqBu+WF3Gf8uUfrt86YSJBM_3VgyE2PmgAQ@mail.gmail.com>
Subject: Re: [PATCH v2] Add tests for default_range glblub
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Joshua,

thanks a lot for the patch! Generally it looks good, just a few minor
comments below...

First, please align the style with the "./tools/check-syntax" tool. It
doesn't always produce a perfect style, but at least it keeps things
consistent and avoids code style arguments :)

On Wed, Mar 11, 2020 at 10:27 PM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
> selinux-testsuite adds test for default_range glblub
> which can only be inserted into the policy via cil, so add
> CIL_TARGETS to policy and an attempt to detect whether the policy is MCS,
> meaning it only has 1 sensitivity and more need to be added, or MLS
> and therefore fine to test on.
>
> Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> ---
>  policy/Makefile              | 15 +++++++--
>  policy/test_add_levels.cil   | 34 +++++++++++++++++++
>  policy/test_glblub.cil       |  4 +++
>  tests/Makefile               | 19 +++++++++--
>  tests/glblub/.gitignore      |  1 +
>  tests/glblub/Makefile        |  7 ++++
>  tests/glblub/default_range.c | 65 ++++++++++++++++++++++++++++++++++++
>  tests/glblub/test            | 55 ++++++++++++++++++++++++++++++
>  tests/pol_detect             | 17 ++++++++++
>  9 files changed, 213 insertions(+), 4 deletions(-)
>  create mode 100644 policy/test_add_levels.cil
>  create mode 100644 policy/test_glblub.cil
>  create mode 100644 tests/glblub/.gitignore
>  create mode 100644 tests/glblub/Makefile
>  create mode 100644 tests/glblub/default_range.c
>  create mode 100755 tests/glblub/test
>  create mode 100755 tests/pol_detect
>
[...]
diff --git a/policy/test_add_levels.cil b/policy/test_add_levels.cil
new file mode 100644
index 0000000..09215f4
--- /dev/null
+++ b/policy/test_add_levels.cil
@@ -0,0 +1,34 @@
+(sensitivity s1)
+(sensitivitycategory s1 (range c0 c1023))
+(sensitivity s2)
+(sensitivitycategory s2 (range c0 c1023))
+(sensitivity s3)
+(sensitivitycategory s3 (range c0 c1023))
+(sensitivity s4)
+(sensitivitycategory s4 (range c0 c1023))
+(sensitivity s5)
+(sensitivitycategory s5 (range c0 c1023))
+(sensitivity s6)
+(sensitivitycategory s6 (range c0 c1023))
+(sensitivity s7)
+(sensitivitycategory s7 (range c0 c1023))
+(sensitivity s8)
+(sensitivitycategory s8 (range c0 c1023))
+(sensitivity s9)
+(sensitivitycategory s9 (range c0 c1023))
+(sensitivity s10)
+(sensitivitycategory s10 (range c0 c1023))
+(sensitivity s11)
+(sensitivitycategory s11 (range c0 c1023))
+(sensitivity s12)
+(sensitivitycategory s12 (range c0 c1023))
+(sensitivity s13)
+(sensitivitycategory s13 (range c0 c1023))
+(sensitivity s14)
+(sensitivitycategory s14 (range c0 c1023))
+(sensitivity s15)
+(sensitivitycategory s15 (range c0 c1023))
+(sensitivityorder (s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15 ))

This is not important, but you could also consolidate the whitespace
in these two files.

In the above line, I would drop the space from "s15 ))".

+
+(selinuxuser system_u system_u ((s0) (s15((range c0 c1023) ))))

Here, I'd add a space after "s15" and remove the space in the middle
of the closing parentheses.

+(userrange system_u ((s0 ) (s15 (range c0 c1023))))

Here there's an extra space after "s0".

> diff --git a/policy/test_glblub.cil b/policy/test_glblub.cil
> new file mode 100644
> index 0000000..6cd7c95
> --- /dev/null
> +++ b/policy/test_glblub.cil
> @@ -0,0 +1,4 @@
> +(defaultrange db_table glblub)
> +
> +(class new_class_no_default_range (foobar) )

Another extra space here.

> +(classorder (unordered new_class_no_default_range))
> diff --git a/tests/Makefile b/tests/Makefile
> index 46a1641..7dd5ade 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -1,10 +1,21 @@
> -INCLUDEDIR ?= /usr/include
> -POLDEV ?= /usr/share/selinux/devel
> +PREFIX ?= /usr
> +BINDIR ?= $(PREFIX)/bin
> +SBINDIR ?= $(PREFIX)/sbin
> +POLDEV ?= $(PREFIX)/share/selinux/devel
> +INCLUDEDIR ?= ($PREFIX)/include

"(" and "$" are swapped here.

>  SELINUXFS ?= /sys/fs/selinux
>
>  export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
>
>  DISTRO=$(shell ./os_detect)
> +SELINUXFS := $(shell cat /proc/mounts | grep selinuxfs | cut -f 2 -d ' ')
> +CHECKPOLICY = $(BINDIR)/checkpolicy
> +CHECKMODULE = $(BINDIR)/checkmodule
> +
> +POL_VERS := $(shell $(CHECKPOLICY) -V |cut -f 1 -d ' ')
> +MOD_POL_VERS := $(shell $(CHECKMODULE) -V |cut -f 2 -d '-')
> +MAX_KERNEL_POLICY := $(shell cat $(SELINUXFS)/policyvers)
> +POL_TYPE := $(shell ./pol_detect $(SELINUXFS))
>
>  SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
>         fdreceive inherit link mkdir msg open ptrace readlink relabel rename \
[...]
> diff --git a/tests/glblub/test b/tests/glblub/test
> new file mode 100755
> index 0000000..090a6d2
> --- /dev/null
> +++ b/tests/glblub/test
> @@ -0,0 +1,55 @@
> +#!/usr/bin/perl
> +
> +use Test;
> +BEGIN { plan tests => 9 }
> +
> +$basedir = $0;
> +$basedir =~ s|(.*)/[^/]*|$1|;
> +
> +# Verify glblub range_transition behavior
> +$result = system("$basedir/default_range system_u:system_r:kernel_t:s0:c0.c100-s10:c0.c150 \\
> +                                        system_u:system_r:kernel_t:s5:c50.c100-s15:c0.c149 db_table \\
> +                                        system_u:object_r:kernel_t:s5:c50.c100-s10:c0.c149");

I think these calls would be a bit nicer to read if you made a common
function for them that only takes the MLS ranges and class name.

> +ok($result, 0);
> +
> +$result = system("$basedir/default_range system_u:system_r:kernel_t:s5:c50.c100-s15:c0.c149 \\
> +                                        system_u:system_r:kernel_t:s0:c0.c100-s10:c0.c150 db_table \\
> +                                        system_u:object_r:kernel_t:s5:c50.c100-s10:c0.c149");
> +ok($result, 0);
> +
> +$result = system("$basedir/default_range system_u:system_r:kernel_t:s0:c0.c100-s10:c0.c150 \\
> +                                        system_u:system_r:kernel_t:s0 db_table \\
> +                                        system_u:object_r:kernel_t:s0");
> +ok($result, 0);
> +
> +$result = system("$basedir/default_range system_u:system_r:kernel_t:s5:c512.c550,c552.c1023-s5:c0.c550,c552.c1023 \\
> +                                        system_u:system_r:kernel_t:s5:c512.c550,c553.c1023-s5:c0,c1,c4,c5,c6,c512.c550,c553.c1023 db_table \\
> +                                        system_u:object_r:kernel_t:s5:c512.c550,c553.c1023-s5:c0,c1,c4.c6,c512.c550,c553.c1023");
> +ok($result, 0);
> +
> +$result = system("$basedir/default_range system_u:system_r:kernel_t:s5:c50.c100-s15:c0.c149 \\
> +                                        system_u:system_r:kernel_t:s5:c512.c550,c552.c1023-s5:c0.c550,c552.c1023 db_table \\
> +                                        system_u:object_r:kernel_t:s5-s5:c0.c149");
> +ok($result, 0);
> +
> +# Verify incompatible contexts
> +$result = system("$basedir/default_range system_u:system_r:kernel_t:s5:c50.c100-s15:c0.c149 \\
> +                                        system_u:system_r:kernel_t:s4-s4:c0.c1023 db_table");
> +ok ($result >> 8, 3);
> +
> +$result = system("$basedir/default_range system_u:system_r:kernel_t:s4-s4:c0.c1023 \\
> +                                        system_u:system_r:kernel_t:s5:c50.c100-s15:c0.c149 db_table");
> +ok ($result >> 8, 3);
> +
> +# Verify default (source-low) behavior
> +$result = system("$basedir/default_range system_u:system_r:kernel_t:s0:c0.c100-s10:c0.c150 \\
> +                                        system_u:system_r:kernel_t:s5:c50.c100-s15:c0.c149 new_class_no_default_range \\
> +                                        system_u:object_r:kernel_t:s0:c0.c100");
> +ok($result, 0);
> +
> +$result = system("$basedir/default_range system_u:system_r:kernel_t:s5:c50.c100-s15:c0.c149 \\
> +                                        system_u:system_r:kernel_t:s0:c0.c100-s10:c0.c150 new_class_no_default_range \\
> +                                        system_u:object_r:kernel_t:s5:c50.c100");
> +ok($result, 0);
> +
> +

git am complains about these extra empty lines at the end of file -
please also fix that.

> diff --git a/tests/pol_detect b/tests/pol_detect
> new file mode 100755
> index 0000000..ba25b94
> --- /dev/null
> +++ b/tests/pol_detect
> @@ -0,0 +1,17 @@
> +#!/bin/bash
> +
> +if [ $# -ne 1 ]; then
> +       echo "Usage $0 <selinuxfs directory>"
> +       exit 1
> +fi
> +
> +# This is heuristic but seems unlikely to be wrong,
> +# the kernel initial sid should always be SystemHigh
> +# and SystemHigh is normally s15
> +level=$(cat $1/initial_contexts/kernel | tr '\0' '\n' | cut -d: -f4)
> +
> +if [ -z $level ]; then echo "NON-MLS"
> +elif [ $level = 's0' ]; then echo "MCS"
> +elif [ $level = 's15' ]; then echo "MLS"
> +else echo "UNKNOWN"
> +fi
> --
> 2.21.1
>

Thanks,

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

