Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7E1C10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 15:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1AF20724
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 15:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlUpkVOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCMPqd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:46:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43936 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgCMPqc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 11:46:32 -0400
Received: by mail-oi1-f196.google.com with SMTP id p125so9816363oif.10
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFOrxiY+i6I6J5uDIGDBG2mqCbkE9i0oc6FVQa+gf/4=;
        b=KlUpkVOC+ChAYP41gMbXwSdoD62+/mH3o/M0seBB4RFFEhYPf5pbZRiE3ytwHrGDlB
         lfnLwvHNKojx7QTqnwZNHTl8jba7WPjXB5eHpmYyNw5vP+uCqVqthLxOeRTjqgXEskjc
         qgy/iEZEQMZJb81JO7mwR/y4ijda7ZGtl3kyKInCRoW+SatTMKREe0iXHFN8LnoqDCtw
         TyCepurqOEuqJs2C+Fyam91PeW/un8zB/7jueYjWC+6mLGFnZsmZHZ4CYtNbzT2wLtML
         T+BJ6gZWDufga0ZfIIlEH1+oT2n0ohqqm9ICU/Jefpp1CZwy/2fX6W0IxfZdKivwS7Bq
         M10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFOrxiY+i6I6J5uDIGDBG2mqCbkE9i0oc6FVQa+gf/4=;
        b=OReC1A4qnd4OLgW3TJnFPFbYvOCQAaracjHV6wvK/fIi7Wewef30D1kSA/X9TNHH/v
         S7g4iaDSHk9SHpGvlBna84N/rUbTHxibd8xHP8ANO/dEHGSXDqkdm51sDjy6nN5RUmDF
         a2X4Ue3MwKoL7eU9UK0P7cR80fnBp2qeGw3BEC7D/QXeWM/8lV6mlytfdB8OEhcDEWYq
         /mL08SiDZ2Bj4uzY2GGLdJKqes3HZSNhM9vfaOV1O/Ft45hUYT8QN4XKfJhDFbwu5FzA
         ObhkZfcZoCZcz9wGswWsL1E/ApRWbGqwGfPEb+RZu6HjP1MYwG/6UOauz8TL4E4OErzN
         nOsA==
X-Gm-Message-State: ANhLgQ30WAqLkFG9qf0Ub+sj0U+0PDVRtBKkW7/0H1c+eAa8kW8ORmSd
        QkdySvr3ijEJ8rMeib58TbF8l2u6VZ1ygRpb4u8=
X-Google-Smtp-Source: ADFU+vsOpyLe9TKa5tzdXFBuLgUxhuu89VmxYr8c/2VM7+ZX0OSeHiXlMDlylt/syjk7t2JGF5+T/j4RGqLXR138qBo=
X-Received: by 2002:aca:5191:: with SMTP id f139mr7732586oib.140.1584114391950;
 Fri, 13 Mar 2020 08:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200312113637.20355-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200312113637.20355-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 13 Mar 2020 11:47:25 -0400
Message-ID: <CAEjxPJ7Ds4J=7hO9K-B1pLXUfCgx4vFbMth-3nQW9x_4xV7S0Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] selinux-testsuite: Use native filesystem for tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Scott Mayhew <smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 12, 2020 at 7:37 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> If you test on the selinux-next kernel (that has the XFS patch [1]) with
> the "NFS: Ensure security label is set for root inode" patch [2], then all
> tests should pass. Anything else will give varying amounts of fails.
>
> The filesystem types tested are: ext4, xfs, vfat and nfs4.
>
> I've revamped the nfs.sh to handle tests that require specific mount
> options, these plus many more are now in tests/nfs_filesystem. This only
> gets run by nfs.sh.
>
> There are two minor workarounds involving multiple mounts returning EBUSY.
> These are either bugs or features.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce
> [2] https://lore.kernel.org/selinux/20200303225837.1557210-1-smayhew@redhat.com/

Still failing for me:
filesystem/test ............. 13/27 Failed mount(2): Permission denied
filesystem/test ............. 18/27
#   Failed test at filesystem/test line 679.
Failed umount(2): Invalid argument

#   Failed test at filesystem/test line 690.
Failed mount(2): Permission denied
filesystem/test ............. 21/27
#   Failed test at filesystem/test line 714.
Failed umount(2): Invalid argument

#   Failed test at filesystem/test line 726.
Failed mount(2): Permission denied

#   Failed test at filesystem/test line 750.
filesystem/test ............. 25/27
#   Failed test at filesystem/test line 756.
Failed umount(2): Invalid argument

#   Failed test at filesystem/test line 763.
# Looks like you failed 7 tests of 27.
filesystem/test ............. Dubious, test returned 7 (wstat 1792, 0x700)
Failed 7/27 subtests
fs_filesystem/test .......... 18/26 Failed fsconfig(2): Permission denied
Failed config_opts

#   Failed test at fs_filesystem/test line 706.
fs_filesystem/test .......... 20/26 Failed umount(2): Invalid argument

#   Failed test at fs_filesystem/test line 717.
Failed fsconfig(2): Permission denied
Failed config_opts
fs_filesystem/test .......... 23/26
#   Failed test at fs_filesystem/test line 780.

#   Failed test at fs_filesystem/test line 786.
Failed umount(2): Invalid argument

#   Failed test at fs_filesystem/test line 794.
fs_filesystem/test .......... 26/26 # Looks like you failed 5 tests of 26.
fs_filesystem/test .......... Dubious, test returned 5 (wstat 1280, 0x500)
Failed 5/26 subtests

Test Summary Report
-------------------
filesystem/test           (Wstat: 1792 Tests: 27 Failed: 7)
  Failed tests:  18, 20-21, 23-26
  Non-zero exit status: 7
fs_filesystem/test        (Wstat: 1280 Tests: 26 Failed: 5)
  Failed tests:  19, 21, 23-25
  Non-zero exit status: 5
Files=63, Tests=623, 164 wallclock secs ( 0.36 usr  0.99 sys +  2.77
cusr 48.23 csys = 52.35 CPU)
Result: FAIL
Failed 2/63 test programs. 12/623 subtests failed.
make: *** [Makefile:133: test] Error 5
make: Leaving directory '/mnt/selinux-testsuite/tests'
Test failed on line: 72 - Closing down NFS
