Return-Path: <SRS0=Veyl=5F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F2CC4332D
	for <selinux@archiver.kernel.org>; Fri, 20 Mar 2020 09:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BF720722
	for <selinux@archiver.kernel.org>; Fri, 20 Mar 2020 09:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUzsGu15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCTJyS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:54:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20799 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727127AbgCTJyR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Mar 2020 05:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584698056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wLrN82yfl44Gf4RR6trq3F9whz0x08gzswKxFWcclmc=;
        b=TUzsGu15vlOqYglG86h8Qpz3rSChuO7uBQXSZSo/xqRuuxTI6hkTJeHV85LUeUQKB+YOcw
        fUcwPkAfeSn91I9aJXhdQcvZ5avr9z8/3bZsJCd6810tcNrrWQbzV66hIUjv1juzm+8D0X
        3qsB4Pea+AKp31mFeH4OY4mTw1U5+yM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-qqzJNs-pOruydlkNkSeB7w-1; Fri, 20 Mar 2020 05:54:12 -0400
X-MC-Unique: qqzJNs-pOruydlkNkSeB7w-1
Received: by mail-oi1-f198.google.com with SMTP id c123so3573125oig.19
        for <selinux@vger.kernel.org>; Fri, 20 Mar 2020 02:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wLrN82yfl44Gf4RR6trq3F9whz0x08gzswKxFWcclmc=;
        b=m3fGQ64gvlMKsz928KTKhIT7mYUrs8K/42egkmnfGChOIjE7BEDHu3dncwIzQ6BZ2J
         oN6Pltx4VZoZevEwrkxs02XnEadh9IkXfATClgclOFFK8dKNZAHmLFb3eEbTxJDqY0OV
         0BF6ZNNFgS3OKIicHM9BuQIKK6R+RP/uGzhm+FHSOsIQ1/08FFf1k0WYI9NkGjwVjaV1
         rcuw/m4TEHYsNg/7/iyv5+R1Q40QeBvWsxa44F+5DYEF7oJDnXB0np9NlM8wN19I4OB0
         iuL811uURk7Hw3wZDlH1SVrA12CvmeE81ymYHmEAvj3HhmN6OMeESGI0q9QhNsLKt+/D
         x8tA==
X-Gm-Message-State: ANhLgQ0QJJ5EpLIa1+/SKnZXH1SokahtwxIHbMX4kwGs2LrIkBVD/EiW
        mTZ3m+6rLoyeN/wG6VCfd3kNSQH6JoyXHjZz/rczEyG+9gkLkj82EVD1Lgcbbc47NtzPuQz9peD
        yiUZwTNuaoF9TFkbvdKu4VDuiaPIDzERXEA==
X-Received: by 2002:a9d:77d0:: with SMTP id w16mr6015141otl.66.1584698051281;
        Fri, 20 Mar 2020 02:54:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvEK+JWUipidNU30bpQpEVvz23oyqtRcRXIpOfeKtSrCnboLHSvy6JFe8oIIIZXqsU5FDGvxrwJIAkG1y3ZZww=
X-Received: by 2002:a9d:77d0:: with SMTP id w16mr6015119otl.66.1584698050964;
 Fri, 20 Mar 2020 02:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200319151948.15747-1-joshua.brindle@crunchydata.com>
In-Reply-To: <20200319151948.15747-1-joshua.brindle@crunchydata.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 20 Mar 2020 10:53:59 +0100
Message-ID: <CAFqZXNuF+i6L89BWQFxZTAgvJ68ifWmCXb1uS1hM37N5C+3+Ag@mail.gmail.com>
Subject: Re: [PATCH v4] Add tests for default_range glblub
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 19, 2020 at 4:20 PM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
> selinux-testsuite adds test for default_range glblub
> which can only be inserted into the policy via cil, so add
> CIL_TARGETS to policy and an attempt to detect whether the policy is MCS,
> meaning it only has 1 sensitivity and more need to be added, or MLS
> and therefore fine to test on.
>
> Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>

Thanks, looks good to me now, just one minor issue with the
selinuxuser statement - see below.

> ---
>  policy/Makefile              | 15 ++++++--
>  policy/test_add_levels.cil   | 34 ++++++++++++++++++
>  policy/test_glblub.cil       |  4 +++
>  tests/Makefile               | 19 ++++++++--
>  tests/glblub/.gitignore      |  1 +
>  tests/glblub/Makefile        |  7 ++++
>  tests/glblub/default_range.c | 66 +++++++++++++++++++++++++++++++++++
>  tests/glblub/test            | 67 ++++++++++++++++++++++++++++++++++++
>  tests/pol_detect             | 17 +++++++++
>  9 files changed, 226 insertions(+), 4 deletions(-)
>  create mode 100644 policy/test_add_levels.cil
>  create mode 100644 policy/test_glblub.cil
>  create mode 100644 tests/glblub/.gitignore
>  create mode 100644 tests/glblub/Makefile
>  create mode 100644 tests/glblub/default_range.c
>  create mode 100755 tests/glblub/test
>  create mode 100755 tests/pol_detect
>
[...]
> diff --git a/policy/test_add_levels.cil b/policy/test_add_levels.cil
> new file mode 100644
> index 0000000..374e970
> --- /dev/null
> +++ b/policy/test_add_levels.cil
> @@ -0,0 +1,34 @@
> +(sensitivity s1)
> +(sensitivitycategory s1 (range c0 c1023))
> +(sensitivity s2)
> +(sensitivitycategory s2 (range c0 c1023))
> +(sensitivity s3)
> +(sensitivitycategory s3 (range c0 c1023))
> +(sensitivity s4)
> +(sensitivitycategory s4 (range c0 c1023))
> +(sensitivity s5)
> +(sensitivitycategory s5 (range c0 c1023))
> +(sensitivity s6)
> +(sensitivitycategory s6 (range c0 c1023))
> +(sensitivity s7)
> +(sensitivitycategory s7 (range c0 c1023))
> +(sensitivity s8)
> +(sensitivitycategory s8 (range c0 c1023))
> +(sensitivity s9)
> +(sensitivitycategory s9 (range c0 c1023))
> +(sensitivity s10)
> +(sensitivitycategory s10 (range c0 c1023))
> +(sensitivity s11)
> +(sensitivitycategory s11 (range c0 c1023))
> +(sensitivity s12)
> +(sensitivitycategory s12 (range c0 c1023))
> +(sensitivity s13)
> +(sensitivitycategory s13 (range c0 c1023))
> +(sensitivity s14)
> +(sensitivitycategory s14 (range c0 c1023))
> +(sensitivity s15)
> +(sensitivitycategory s15 (range c0 c1023))
> +(sensitivityorder (s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15))
> +
> +(selinuxuser system_u system_u ((s0) (s15 (range c0 c1023))))

This line causes a warning to be triggered when installing the module
into policy store:

# semodule -i test_add_levels.cil
libsemanage.add_user: user system_u not in password file

Should that first "sysadm_u" argument actually be "root"? And are
these two lines really necessary? The test passes without them for me
on a non-MLS system.

> +(userrange system_u ((s0) (s15 (range c0 c1023))))
[...]
> diff --git a/tests/glblub/test b/tests/glblub/test
> new file mode 100755
> index 0000000..212fef6
> --- /dev/null
> +++ b/tests/glblub/test
> @@ -0,0 +1,67 @@
> +#!/usr/bin/perl
> +
> +use Test;
> +BEGIN { plan tests => 9 }
> +
> +$basedir = $0;
> +$basedir =~ s|(.*)/[^/]*|$1|;
> +
> +sub run_test {
> +    my ( $src, $tgt, $objclass, $res ) = @_;
> +    my $con = "system_u:object_r:kernel_t";
> +
> +    my $result =
> +      system("$basedir/default_range $con:$src $con:$tgt $objclass $con:$res");
> +
> +    ok( $result, 0 );
> +}
> +
> +sub run_test_fail {
> +    my ( $src, $tgt ) = @_;
> +    my $con = "system_u:object_r:kernel_t";
> +
> +    my $result = system("$basedir/default_range $con:$src $con:$tgt db_table");
> +
> +    ok( $result >> 8, 3 );
> +}
> +
> +# Verify glblub range_transition behavior
> +run_test(
> +    "s0:c0.c100-s10:c0.c150", "s5:c50.c100-s15:c0.c149",
> +    "db_table",               "s5:c50.c100-s10:c0.c149"
> +);
> +
> +run_test(
> +    "s5:c50.c100-s15:c0.c149", "s0:c0.c100-s10:c0.c150",
> +    "db_table",                "s5:c50.c100-s10:c0.c149"
> +);
> +
> +run_test( "s0:c0.c100-s10:c0.c150", "s0", "db_table", "s0" );
> +
> +run_test(
> +    "s5:c512.c550,c552.c1023-s5:c0.c550,c552.c1023",
> +    "s5:c512.c550,c553.c1023-s5:c0,c1,c4,c5,c6,c512.c550,c553.c1023",
> +    "db_table",
> +    "s5:c512.c550,c553.c1023-s5:c0,c1,c4.c6,c512.c550,c553.c1023"
> +);
> +
> +run_test( "s5:c50.c100-s15:c0.c149",
> +    "s5:c512.c550,c552.c1023-s5:c0.c550,c552.c1023",
> +    "db_table", "s5-s5:c0.c149" );
> +
> +# Verify incompatible contexts
> +run_test_fail( "s5:c50.c100-s15:c0.c149", "s4-s4:c0.c1023" );
> +
> +run_test_fail( "s4-s4:c0.c1023", "s5:c50.c100-s15:c0.c149" );
> +
> +# Verify default (source-low) behavior
> +run_test(
> +    "s0:c0.c100-s10:c0.c150",     "s5:c50.c100-s15:c0.c149",
> +    "new_class_no_default_range", "s0:c0.c100"
> +);
> +
> +run_test(
> +    "s5:c50.c100-s15:c0.c149",    "s0:c0.c100-s10:c0.c150",
> +    "new_class_no_default_range", "s5:c50.c100"
> +);
> +

git am still complains about extra empty line at EOF here. I can fix
that easily when merging, but if you're going to respin the patch
because of the selinuxuser warning, then it would be nice to fix this,
too :)

[...]

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

