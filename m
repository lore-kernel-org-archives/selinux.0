Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B84C4338F
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 09:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3E960EFE
	for <selinux@archiver.kernel.org>; Thu, 19 Aug 2021 09:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbhHSJKi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Aug 2021 05:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234128AbhHSJKe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Aug 2021 05:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629364197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NTmyeYMhr3SaKtFVyWx4Nr72Nl00RFzORr5YMXjEoPc=;
        b=ayY5O0CKE5roJQMRU4cakfRtuBSlpIlmPFKUdadPMbNN+l7Q/oj2WZwwWbEUUD7RxoBM1C
        LBzAe6yDi+p2msYLAG0Uyj7P12VTQaVlaO+c2la36Bj/GepF1haWJ1FIh9VoXW5QX1eafe
        7lN98T2NWuaWyudCBezHQqDcOcbxtKc=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-7wxGr1m5Nq6_CD2o53rzCQ-1; Thu, 19 Aug 2021 05:09:56 -0400
X-MC-Unique: 7wxGr1m5Nq6_CD2o53rzCQ-1
Received: by mail-yb1-f197.google.com with SMTP id t101-20020a25aaee0000b0290578c0c455b2so5879403ybi.13
        for <selinux@vger.kernel.org>; Thu, 19 Aug 2021 02:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NTmyeYMhr3SaKtFVyWx4Nr72Nl00RFzORr5YMXjEoPc=;
        b=mEq5aGVT+Gen9zSv49wbS574PkKViYMh6FVONqllPoPaJGagmJ9FwFJQB90m39BDaO
         5c6K6ja8yFr/riauvvfRti9DOy1KE8uJUQ/N431W0c/bVf3ynmo2B1QXAznFQHIRev9Z
         tXHFlZhb7/wmIBLbWuk6NSE9TdVu9cB+ftE1uZoywZi6QWtzUbpS8OpbqCs8JTen5waN
         7S273IBT0b5ryNQG9+JL94xUDNLS9CKbzA8EWCJE/8ecWnwT9EP2q97VFxUzqf4+hoLG
         DK0wCkLYnNiXQGaYDEyGVxUKuB3iqjPNxF1AWjiHBA0faTSbVLCfYZ/7PT8YVGGOTlUP
         6Cjw==
X-Gm-Message-State: AOAM531rU7uXeao/zSi3xeVAn2EVhpO3B5Zr53Us2pzSFaRssPzeEJRN
        vvUVB4ExoIyq7MJwmBrvKubm1woMwEnIiIL/sIdpLYHcfrTDMV0TYJbK6wymsTe+mj73E6YqNjm
        wIjZ81t0G/ChI5tSFzGgbn28iaIkVuY154g==
X-Received: by 2002:a25:2302:: with SMTP id j2mr14923774ybj.123.1629364195338;
        Thu, 19 Aug 2021 02:09:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdyWhzHQk/DwKM3YFUodoCw+5fC3bKphoCLEnYtFcBh/w9D/HB9T0aLDmj0fvRK8yuqGl8sYccxamZsqaaOUU=
X-Received: by 2002:a25:2302:: with SMTP id j2mr14923753ybj.123.1629364195106;
 Thu, 19 Aug 2021 02:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210804130842.743651-1-omosnace@redhat.com>
In-Reply-To: <20210804130842.743651-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 19 Aug 2021 11:09:44 +0200
Message-ID: <CAFqZXNsq=XXztzkYUP6yDqm5BxVGXM6H_SVbYQ=eftspq=wj6g@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/capable_sys: skip test_rawio on BTRFS
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 4, 2021 at 3:08 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> BTRFS doesn't support the FIBMAP ioctl, which is used to test
> CAP_SYS_RAWIO. It is already disabled for NFS, so disable that test also
> on BTRFS.
>
> Fedora 35 cloud images already have BTRFS volumes instead of ext4 and
> this patch is needed to make the testsuite pass there.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/capable_sys/test | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tests/capable_sys/test b/tests/capable_sys/test
> index cd50ebc..a72616d 100755
> --- a/tests/capable_sys/test
> +++ b/tests/capable_sys/test
> @@ -9,10 +9,11 @@ BEGIN {
>      $basedir = $0;
>      $basedir =~ s|(.*)/[^/]*|$1|;
>
> -    $isnfs = `stat -f --print %T $basedir`;
> +    $fs          = `stat -f --print %T $basedir`;
> +    $test_fibmap = $fs ne "btrfs" and $fs ne "nfs";
>
>      $test_count = 7;
> -    if ( $isnfs ne "nfs" ) {
> +    if ($test_fibmap) {
>          $test_count += 1;
>      }
>
> @@ -26,7 +27,7 @@ system "rm -f $basedir/temp_file 2>&1";
>  # Tests for the good domain.
>  #
>
> -if ( $isnfs ne "nfs" ) {
> +if ($test_fibmap) {
>
>      # CAP_SYS_RAWIO
>      system "touch $basedir/temp_file 2>&1";
> --
> 2.31.1
>

This patch is now merged with minor modification - the logical
expression in tests/capable_sys had to be parenthesized because of
Perl bogosity (https://www.perlmonks.org/?node_id=734436).

https://github.com/SELinuxProject/selinux-testsuite/commit/4ed5d11312d673203d93dafbcdad441c3afc36f9

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

