Return-Path: <SRS0=oO2X=WX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFC3C3A5A3
	for <selinux@archiver.kernel.org>; Tue, 27 Aug 2019 17:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19752070B
	for <selinux@archiver.kernel.org>; Tue, 27 Aug 2019 17:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="XBGeEgAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfH0ROk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:14:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38823 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0ROj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Aug 2019 13:14:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id c12so4440686lfh.5
        for <selinux@vger.kernel.org>; Tue, 27 Aug 2019 10:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwH8RVR0MXgLwbByxkYz0JNO95wQN1BPKZYhWUUAFeI=;
        b=XBGeEgAqy7HWSGSlc3mUfSE3B65SbT9mhKS8jIFZrBcXbRkLJ/c8J81U3IAqlFx2st
         Csdh9AdR18bJZdvzOaQ2w7Zc7eeFFKTfxD8R+7Ajtfngc1SX7HPHz4biAPBuoDBKCYQB
         P5PJbjMWBlShePE1uGEkSYk2idhEdULAqwBio63gXSqmWl9oPhpF0Dapz3XGCpFhyFZ6
         SXRgng2V4Wmb/otI7K56FYWIp7tZD0CSSrJ67VbAvCjEq0z0gbuqwqY/z4Mh4NM6qIeI
         YzeKZA36LLnCv/ulFSh5cXk5bV9iIaer8DBpwQ1H05TCGW63UyqOu8gDQb2Gzc89W67+
         ei+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwH8RVR0MXgLwbByxkYz0JNO95wQN1BPKZYhWUUAFeI=;
        b=lu2RF6+NpWcmDXl1D4230eAAxCtlUw1DhzS6g4q4HHiraZ8lN4DYslIr+VSEPij1S7
         yTeTl+NQyQ7uEadRnKM1wxo8a1opXpHTkbBQwYf1EVHzaDOsRweh9gGz6u+X8RVszOYM
         pS+PP/iBFn8UEtCr8k+ivHCOtz7+qlIKVmCeoOSet+/xBzeX7PsU8KcQyiJbz5MB+hdJ
         HGtp8Hv3UxtiMMZnfSzVsMI7lc98IUXx++jgHrXd5meFsxOajpXyFXv8CqMOKZceOndC
         36qWNQaOcFKZDU1mVbbsokapImYt+3n8z1EExUOw3J4LtMEUkSWnJ9bWO/pA3PSdTJRy
         ASBQ==
X-Gm-Message-State: APjAAAWqYgzejUUIvnu3pG6QlfWvcAeoH5XvDlBbtnOKxjOn1oYAM8vP
        yuoE7eTFe1j1DgSgOWgrimGGPHlU++k0Iumv0BNV
X-Google-Smtp-Source: APXvYqxM12cj6Xm/qe0YG/iPt8R4ge5BojDgvfWaQOtHMwt7Fp3hgF3bd1mTl9ppYtGHAGST+9x+j0RJRVIZSKPcgPQ=
X-Received: by 2002:a19:cc15:: with SMTP id c21mr8163213lfg.64.1566926077381;
 Tue, 27 Aug 2019 10:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190710133917.1188-1-acgoide@tycho.nsa.gov>
In-Reply-To: <20190710133917.1188-1-acgoide@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Aug 2019 13:14:25 -0400
Message-ID: <CAHC9VhQqrgR7+qakF+bz-i0tL9fN0YQSSmXMyGL-TeLnkNpBkQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: add tests for fsnotify
To:     Aaron Goidel <acgoide@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lukas Vrabec <lvrabec@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 10, 2019 at 9:40 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
>
> Added a suite to test permissions for setting inotify and fanotify watches
> on filesystem objects. Tests watch, watch_with_perm, and watch_reads permissions.
>
> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
> ---
>  policy/Makefile              |   4 ++
>  policy/test_notify.te        |  74 ++++++++++++++++++++++++
>  tests/Makefile               |   4 ++
>  tests/notify/Makefile        |   5 ++
>  tests/notify/test            | 101 +++++++++++++++++++++++++++++++++
>  tests/notify/test_fanotify.c | 105 +++++++++++++++++++++++++++++++++++
>  tests/notify/test_inotify.c  |  43 ++++++++++++++
>  7 files changed, 336 insertions(+)
>  create mode 100644 policy/test_notify.te
>  create mode 100644 tests/notify/Makefile
>  create mode 100755 tests/notify/test
>  create mode 100644 tests/notify/test_fanotify.c
>  create mode 100644 tests/notify/test_inotify.c

FYI, I'm still waiting on the new permissions to show up in the
Rawhide policy so I can test this and verify everything is working
correctly with a "released" policy.

I also had to perform a number of fixes to get 'make check-syntax' to
run cleanly.

-- 
paul moore
www.paul-moore.com
