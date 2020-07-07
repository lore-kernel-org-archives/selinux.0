Return-Path: <SRS0=l4yV=AS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9849BC433E0
	for <selinux@archiver.kernel.org>; Tue,  7 Jul 2020 12:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD0720771
	for <selinux@archiver.kernel.org>; Tue,  7 Jul 2020 12:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjtulQIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgGGM1L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGM1K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jul 2020 08:27:10 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A278EC061755
        for <selinux@vger.kernel.org>; Tue,  7 Jul 2020 05:27:10 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n24so31934567otr.13
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2020 05:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8P1CZ2RC2QyMrY9RODB7UHIs9mhv5Io1+jOEit3olQ=;
        b=jjtulQIXPC7XqYX59WSttznM1VkPeskuJA9zk72cUlmJpeSAj9v9ALOCuInoAVVvJD
         U6CndSyHj8XlRclFPCMr85Eu60/0327DMDK5HRp5r/Tgb7vte5O8BzeRsYvJS5jqIYhM
         WJ2ebNbi87Rq34QK+VbtH3gwfQw8Je1PdvyfDyL06aI/vaI5rpk6W2j/qhCPEIqNoc4k
         DGdRc0fscrtuNcA0lFWizAMHGt8Y+JLK08al8sjJj7T7R9XrZb3Q6fCb7NBcfC2hmnGH
         YNI0Hp4On9H5kM/35wObzqu/e/aMZhpv30/rj7HXAEuaxEL27FOBIjSa5OzezzEqU1gH
         NgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8P1CZ2RC2QyMrY9RODB7UHIs9mhv5Io1+jOEit3olQ=;
        b=HPkbLZKMxT5Y+fZo1UieJ3+ftxPe0cRrYmq+PfsqgaaKWLp6MI+jpmzF0XCsxXAm5P
         oth8Boeyvv3dIWeOtwHmH6fqD/Rj7TDp1khbTbD7afe9tNehIAFXIeWF93wfOZIg7QsH
         bmkJaQg01r7Tji55cqO+ePCek3ITynJ2t+0W/nBRQZcxvz1UFhB08Ost608klWdzQdSd
         84o8K4AMdcfB18R6rryYwM7eLl40reAR5V3DOZmL45aGkkZWo3LXygQSXbgm1+uhulRv
         2mQKxQf/GHkQ9rkXCMHjql8cB2RHIOeNL3xq4dNWqxJqFv7yXc/d3gLZxsWcFuzMEVpL
         zSNA==
X-Gm-Message-State: AOAM530PVg8Lqd2ftbArapsf/mYRXebwYo4LEeZGW+bifUbYGb7H8dYL
        Kpc3C7mUEnxaeC/DHECoUww7cWVJksQztZtfF+UWHgPqTAE=
X-Google-Smtp-Source: ABdhPJwhWW3+ucQGJ6yZWSO0SCXbQVOPXdPcxNviUwN4Qard+VJ1gEKDzkqudWxtb2s+FU+z8DilmIJnzMm4xtA6IE8=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr38096392oto.135.1594124829901;
 Tue, 07 Jul 2020 05:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200701150627.1643297-1-antoine.tenart@bootlin.com>
In-Reply-To: <20200701150627.1643297-1-antoine.tenart@bootlin.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 7 Jul 2020 08:26:59 -0400
Message-ID: <CAEjxPJ77YoCyVyg3nxqvTyGQ9tCjTb42MY4=iBD7xvf4Hg7sGg@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: setfiles: do not restrict checks against
 a binary policy
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        matthew.weber@rockwellcollins.com, thomas.petazzoni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 1, 2020 at 11:13 AM Antoine Tenart
<antoine.tenart@bootlin.com> wrote:
>
> The -c option allows to check the validity of contexts against a
> specified binary policy. Its use is restricted: no pathname can be used
> when a binary policy is given to setfiles. It's not clear if this is
> intentional as the built-in help and the man page are not stating the
> same thing about this (the man page document -c as a normal option,
> while the built-in help shows it is restricted).
>
> When generating full system images later used with SELinux in enforcing
> mode, the extended attributed of files have to be set by the build
> machine. The issue is setfiles always checks the contexts against a
> policy (ctx_validate = 1) and using an external binary policy is not
> currently possible when using a pathname. This ends up in setfiles
> failing early as the contexts of the target image are not always
> compatible with the ones of the build machine.
>
> This patch reworks a check on optind only made when -c is used, that
> enforced the use of a single argument to allow 1+ arguments, allowing to
> use setfiles with an external binary policy and pathnames. The following
> command is then allowed, as already documented in the man page:
>
>   $ setfiles -m -r target/ -c policy.32 file_contexts target/
>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  policycoreutils/setfiles/setfiles.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
> index ed67b5f12245..4844875cfc6b 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -48,10 +48,9 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
>                         name, name);
>         } else {
>                 fprintf(stderr,
> -                       "usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] spec_file pathname...\n"
> -                       "usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] spec_file -f filename\n"
> -                       "usage:  %s -s [-diIDlmnpqvFW] spec_file\n"
> -                       "usage:  %s -c policyfile spec_file\n",
> +                       "usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file pathname...\n"
> +                       "usage:  %s [-diIDlmnpqvEFW] [-e excludedir] [-r alt_root_path] [-c policyfile] spec_file -f filename\n"
> +                       "usage:  %s -s [-diIDlmnpqvFW] spec_file\n",
>                         name, name, name, name);

You didn't update the number of name arguments to reflect the format
string change above.

make[2]: Entering directory
'/home/travis/build/stephensmalley/selinux/policycoreutils/setfiles'
clang -O2 -Werror -Wall -Wextra -Wmissing-format-attribute
-Wmissing-noreturn -Wpointer-arith -Wshadow -Wstrict-prototypes
-Wundef -Wunused -Wwrite-strings -fno-common
-I/home/travis/build/stephensmalley/selinux/installdir/usr/include
-DUSE_AUDIT   -c -o setfiles.o setfiles.c
setfiles.c:54:22: error: data argument not used by format string
      [-Werror,-Wformat-extra-args]
                        name, name, name, name);
                                                         ^^
