Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5308C433E0
	for <selinux@archiver.kernel.org>; Mon, 15 Feb 2021 21:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8070464DE8
	for <selinux@archiver.kernel.org>; Mon, 15 Feb 2021 21:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhBOVp0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Feb 2021 16:45:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229646AbhBOVp0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Feb 2021 16:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613425439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gAl82Wlxbaxrdw0iky4UP55eDZVWvci4UL13Vj7Tz/M=;
        b=CUk3EFYFANPz1cVL4AFTt1R0oLuN83NMqVLfjdV1AQ4bFpUnkiBYUxiPsW3UrcnhQfRdzM
        yU19sVFRLHuKAHsGCQaN2djhBxTGxSDkt/BnGUNl3MMICf5dTmkkKP7s3yzY0yU0WQeD6B
        m/eojyy/+FDIH8mnpUE36M4ay7xLD3w=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-93fWUJ-COsyElNmYaW5NCQ-1; Mon, 15 Feb 2021 16:43:56 -0500
X-MC-Unique: 93fWUJ-COsyElNmYaW5NCQ-1
Received: by mail-yb1-f197.google.com with SMTP id f127so11136854ybf.12
        for <selinux@vger.kernel.org>; Mon, 15 Feb 2021 13:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAl82Wlxbaxrdw0iky4UP55eDZVWvci4UL13Vj7Tz/M=;
        b=WDQQ7qwfUMjNY5I7QvuAuZ1S9XHRMnM6ZBsbwwt1mFKF7xXiOA0BdPJfzAJym5fbkl
         sQGVzABtFbqntx4wq7Yfr3gr7z7gcL+pz/yQ4w4Xc/OA+EAw+EvvDOL85mfLUqZu+MVk
         zJi8yrYpdyRicrhmq+1X90hAZgnMFSo14wabB2e71aJlSNIWytEpoZ/+h+RGjBU+Ekdd
         /fYCqQT1jqAo5hO6Yz+KWegJDe+xvEO/ZXbUXUR/Nz5+ZZ6WwCfPdGW8wsLAaha5gXr0
         CYKU3mK91i3PxY/I7mPNf/S/3v+BkGRdUeO7CJ3LaRkWAKDc3JwAIUhclif0RA0S3/gX
         aoug==
X-Gm-Message-State: AOAM533Opgez0dE37yP8XdDsvUeAlEnaqJAHVR8cFJeqH5vhoCyJg5Bw
        dJ6e27oOXFuritpEErLuIyHfRLIBF7dPSW4YUCj7cSHk/71BMG0av7xin/DvWZONyR/ymLadDHS
        TPqzHY7DLnZ5zGFiOrgFsJ4C0g+Ky6ipyiA==
X-Received: by 2002:a25:83cc:: with SMTP id v12mr24930636ybm.293.1613425436096;
        Mon, 15 Feb 2021 13:43:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZ+6XWrqM+3bgI9m9M+ZOqm1AwHL2Ma4niVX8zdLDebhzO9gvxJ3IaKIDu9M9P8SH+3Owzw5drG7MZVcLYJ9Q=
X-Received: by 2002:a25:83cc:: with SMTP id v12mr24930614ybm.293.1613425435849;
 Mon, 15 Feb 2021 13:43:55 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhTVymm3+=jVTgzmOwkSNcfg=ZP7vMCJymNTZtyPjJUwfA@mail.gmail.com>
In-Reply-To: <CAHC9VhTVymm3+=jVTgzmOwkSNcfg=ZP7vMCJymNTZtyPjJUwfA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 15 Feb 2021 22:43:42 +0100
Message-ID: <CAFqZXNttdJNkcCvCBRuYr60K4ivHUdsVWSMi64mAT7zsf4pRmA@mail.gmail.com>
Subject: Re: selinux-testsuite failures with selinux-policy-3.14.8-1
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 15, 2021 at 10:19 PM Paul Moore <paul@paul-moore.com> wrote:
> Hello all,
>
> While tracking down a test failure before sending the SELinux PR to
> Linus for v5.12 I noticed that the latest Fedora Rawhide policy update
> breaks the selinux-testsuite, specifically the lockdown test.  While I
> haven't tracked it all the way down to the root cause, I suspect the
> additional lockdown permissions added to the policy may be the
> problem.  Changelog snippet below:
>
> * Thu Feb 11 2021 Zdenek Pytela <zpytela@redhat.com> - 3.14.8-1
> - Bump version as Fedora 34 has been branched off rawhide
> - Allow xdm watch its private lib dirs, /etc, /usr
> - Allow systemd-importd create /run/systemd/machines.lock file
> - Allow rhsmcertd_t read kpatch lib files

> - Add integrity lockdown permission into dev_read_raw_memory()
> - Add confidentiality lockdown permission into fs_rw_tracefs_files()

Yes, it's because of these two ^^

In both cases the corresponding lockdown permission is logically
needed to do the given operation, so we added it there. The testsuite
kind of naively expects that the interfaces won't grant these
permissions and thus the test is failing now :)

I think we'll have to open-code the rules in test_lockdown.te or use
some broader interfaces that aren't directly related to /dev/mem or
tracefs, but allow access to them (minus the lockdown permissions).

I have it on my mind to try and fix it, but it'll probably be a while
before I get to it...

> - Allow gpsd read and write ptp4l_t shared memory.
> - Allow colord watch its private lib files and /usr
> - Allow init watch_reads mount PID files
> - Allow IPsec and Certmonger to use opencryptoki services
>
> FWIW, reverting to selinux-policy-3.14.7-18 resolves the problem.
>
> --
> paul moore
> www.paul-moore.com

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

