Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C285C433E0
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 12:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5596B20760
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 12:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlO/Efqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgFKMOY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgFKMOX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 08:14:23 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92918C08C5C1
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 05:14:23 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id b8so5221117oic.1
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 05:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ywEG+Ag0qnpx7lv5Wpl5kNUSGur1nPOHWtuxkktv0c=;
        b=GlO/Efqx/q0/1/Aq6E6t+URlAARctydT3MV8N2Wz+jU1BYdjX2YXGa+sIEi7s0beDy
         qJnUBxgU9uVA/oMWR62qh/3YO/IOJ9+ua5AMvb4FTuOdwgUyS8ttaTUIJdq702Tr3uUw
         /kUkqPhLPI90KcwJemPsDZhAEqwxDdQ/ESAUioS6w4XCfWXYq6lwatwiGqjHsNiv5uIY
         OIKSvqCOLE1lad9zIYKsJibXTqeVe7iUaDrC0TCNxYgMi+YTm389quFDIGlyBWVJfNRU
         fJrYhGczqlvBro2c/hIP/b0t42hqtsyxG8wnip4+QlOSlUtpVFUDGjxJkWF0Tv+DQbp/
         xFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ywEG+Ag0qnpx7lv5Wpl5kNUSGur1nPOHWtuxkktv0c=;
        b=sdBrxOwpQ5GqBmRUWyOd9uTNr/A7X+AmFEeqWxty5t6D3f/UIcCcU8UryffRadfnOK
         eeemVFZtH2E2DQKTdZTkb2CqFY3v1t9WB6Zk0F2In9t5vQifCq3cFEMVCbcgiBo6TcaQ
         6gaVF+ha74K6qCQ5i//QPQFOTqGQ+v1TK7RI7XqtW90aB6DcqlqJKZNef9hyc7hCmdhu
         IaemdDngA08dQJEzpw4M26HnYtPaXbeJ4neFamVi339MvOpLZRC92C0gDi9vYMO0qHTh
         5mQY5aXkroU5qIp8XVvl6AZ6/9cAJoNjB1OZ4vKh/c3WTKtQNWDb4WVK5y4S8zKY9kjF
         gngA==
X-Gm-Message-State: AOAM5314jHvvQRYS/q1eV7fp8p/+FcCyuZP3+wOmEAF8qGDv3FWeUKjg
        dwsTbLhTETb4pwMvPg8PkULDJDiIpiTir5+fSo4=
X-Google-Smtp-Source: ABdhPJydNeuj0hWV1O9R0DcCiS0r8WKV9FvTXzhx47wLcdh4F3dG9tHsYtgQMK+OIXyhDpUQYoQ66EDpGnQTL6MStQE=
X-Received: by 2002:aca:3283:: with SMTP id y125mr2236735oiy.140.1591877663049;
 Thu, 11 Jun 2020 05:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200520163421.27965-1-william.c.roberts@intel.com>
 <20200602191856.5040-1-william.c.roberts@intel.com> <20200602191856.5040-2-william.c.roberts@intel.com>
 <20200611120145.GA453655@localhost.localdomain>
In-Reply-To: <20200611120145.GA453655@localhost.localdomain>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 11 Jun 2020 08:14:11 -0400
Message-ID: <CAEjxPJ4+0ct9ZmTxgX9zjer7OGzYY_bWRNMEF0PDe9emVx8SXA@mail.gmail.com>
Subject: Re: [PATCH v3] ci: run SELinux kernel test suite
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 11, 2020 at 8:03 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Tue, Jun 02, 2020 at 02:18:56PM -0500, bill.c.roberts@gmail.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > The current Travis CI runs the userspace tooling and libraries against
> > policy files, but cannot test against an SELinux enabled kernel. Thus,
> > some tests are not being done in the CI. Travis, unfortunately only
> > provides Ubuntu images, so in order to run against a modern distro with
> > SELinux in enforcing mode, we need to launch a KVM with something like
> > Fedora.
> >
> > This patch enables this support by launching a Fedora32 Cloud Image with
> > the SELinux userspace library passed on from the Travis clone, it then
> > builds and replaces the current SELinux bits on the Fedora32 image and
> > runs the SELinux testsuite.
> >
> > The cloud image run can be controlled with the TRAVIS env variable:
> > TRAVIS_CLOUD_IMAGE_VERSION. That variable takes the major and minor
> > version numbers in a colon delimited string, eg: "32:1.6".
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
>
> I pushed all Acked bugs to my fork's branch 3.1-rc2 and the travis jobs failed:
>
> https://travis-ci.org/github/bachradsusi/SELinuxProject-selinux/jobs/697177370
>
> ~~~
> #
> # Great we have a host running, ssh into it. We specify -o so
> # we don't get blocked on asking to add the servers key to
> # our known_hosts.
> #
> ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "/root/selinux/$TEST_RUNNER"
> bash: /root/selinux/scripts/ci/fedora-test-runner.sh: No such file or directory
> The command "scripts/ci/travis-kvm-setup.sh" exited with 127.
>
> Done. Your build exited with 1.

Hmm..worked for me.  I looked at your travis log file and it showed
the culprit: your repository is named SELinuxProject-selinux rather
than selinux and the script assumes it is named selinux.  So the
script just needs to be a little more general I guess.
