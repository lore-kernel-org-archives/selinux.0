Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C980DC0044D
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 17:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5627520737
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 17:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQPY7lPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgCKRwS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:52:18 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45754 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgCKRwS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 13:52:18 -0400
Received: by mail-oi1-f193.google.com with SMTP id v19so2736868oic.12
        for <selinux@vger.kernel.org>; Wed, 11 Mar 2020 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEm2IqGLQxM9NUu/E+GbI1DOjT0znN38MfTXpQeUKwQ=;
        b=TQPY7lPrK9PWqckBMskmSB4PGP8+9cm+cX2DU8icC63lqNaahYGVZ0Xoo7LX0AYfaC
         yg7sqUYH8ksCW7J5uJ7MDFbkIKjqsxjZc/zygmw0VvZRhAmrPuETWs+qzEHBA3DAPM9u
         UePPXGOJxxwjuYf7EzZQqtd4g8LtwLwi3gzrEh1RtLxRV9yoOAeFSbFNAl/RrzX5n+xr
         M14DJjuMclkbAthOgXwCAZinhMNxuF7TkLY9nsl5vuluND15OOhVDAgyMpnACFVJNo0Q
         sxHpmwW5INDWHrHXq2SKdZHrnQu9EiOTEIU9qxDhAaX6W2VMk2BBfmXfq4BvhaSncLHJ
         JKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEm2IqGLQxM9NUu/E+GbI1DOjT0znN38MfTXpQeUKwQ=;
        b=nMGbaYnZgvlsTIHfzP+7oICnTSt/rQOv8hYUwXKVz1IOBgoBkVrEa39PHfYM17pMzt
         3gZ8wPzlbEzU2dkSw9+rXyBm27oj9fObUXpd2VNHpAN8ieBen+uCzmoV7iI3lM3U41UO
         qzinNkAmYumjpB5kGhcMYfkl7dZv29UbpcL1alwJ3zCFeVjpgPfsUhqknrpeNyHTxEqP
         oLh4IYm7T2hX4HrU3qI8/8zDgeum6OLf7fzGebV7f9xWEdD5AOK38fARHxS3wWnH0qqa
         OosSBO7lNXEWd43dA72ctA/nx+s5BgV11Z+YpTfk9aKJkXrf66tRhf79g7yJYYqYDQvx
         dk/A==
X-Gm-Message-State: ANhLgQ3eLhBttp9W+u1zSVwM5nb8XIMySsc4Dizo/kcfEpMdHbBMfUHI
        bDAkAECSSLYA/4bJrUWlzxPUp9I1bY/F0T8FTZ4=
X-Google-Smtp-Source: ADFU+vvccGA47UUl+xu2NQDXiLfk+BY80OG1L5oFBMifrx1UbVPno9RLAlLbwGX4J6AwsHjcfAP9VdkiOFE8WdNVLzs=
X-Received: by 2002:aca:5191:: with SMTP id f139mr2872849oib.140.1583949137005;
 Wed, 11 Mar 2020 10:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200310162456.32240-1-richard_c_haines@btinternet.com>
 <CAEjxPJ69FMkO=X4fxMvgF1F7rsv9ZsEaJemgFzkuvzRWrgfUNg@mail.gmail.com> <6b43f33ac519bbeaa42a79125e2e97e9823ec8f9.camel@btinternet.com>
In-Reply-To: <6b43f33ac519bbeaa42a79125e2e97e9823ec8f9.camel@btinternet.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 11 Mar 2020 13:53:09 -0400
Message-ID: <CAEjxPJ4ES3fsDsWbyz+35a+TUW1PfBSQTL37m8SOdJx74NsQqw@mail.gmail.com>
Subject: Re: [RFC V3 PATCH 0/2] selinux-testsuite: Use native filesystem for tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Scott Mayhew <smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 11, 2020 at 12:54 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> On Wed, 2020-03-11 at 12:02 -0400, Stephen Smalley wrote:
> > On Tue, Mar 10, 2020 at 12:25 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > [1]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce
> > > [2]
> > > https://lore.kernel.org/selinux/20200303225837.1557210-1-smayhew@redhat.com/
> >
> > Even with the patches above applied, I am seeing failures during the
> > tests/nfs_filesystem tests:
>
> Looks like my /mnt was mis-labeled. I've fixed and had to add this to
> test_filesystem.te:
>
> files_mounton_non_security(filesystemdomain)
>
> and now works okay. Could you confirm please, then I'll resend new
> patch later

With that change to policy and no other changes, it then fails earlier
during fs_filesystem/test as shown below even
though the kernel does have the referenced patch (and it passes if I
revert that policy change).  Also, I noticed that
as it is running the tests for filesystem and fs_filesystem, it shows
a question mark (?) as the total/planned number of tests,
suggesting a problem with the plan.

...
filesystem/test ............. ok

#   Failed test 'Failed as kernel 5.6.0 without "selinux: fix
regression introduced by move_mount(2) syscall" patch'
#   at fs_filesystem/test line 752.
# Looks like you failed 1 test of 26.
fs_filesystem/test ..........
Dubious, test returned 1 (wstat 256, 0x100)
Failed 1/26 subtests

Test Summary Report
-------------------
fs_filesystem/test        (Wstat: 256 Tests: 26 Failed: 1)
  Failed test:  22
  Non-zero exit status: 1
Files=63, Tests=623, 161 wallclock secs ( 0.33 usr  0.90 sys +  2.76
cusr 46.78 csys = 50.77 CPU)
Result: FAIL
Failed 1/63 test programs. 1/623 subtests failed.
