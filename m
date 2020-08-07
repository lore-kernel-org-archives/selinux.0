Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B313C433DF
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 13:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5620320866
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 13:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiTjmFap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgHGNn2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgHGNnX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 09:43:23 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B276C061574
        for <selinux@vger.kernel.org>; Fri,  7 Aug 2020 06:42:43 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v6so1580252ota.13
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2020 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P4zd08a/aEuuvzgXCpZBGh3mPsbuLtYRCDVVyrJ0U9c=;
        b=tiTjmFap5pmExfM7DUy9NL41HWpL5y3fRXeaoCcxDRa+LNvc2oSoRHlDhlmZhkLCUs
         OXikUvyrj9f0nefh2tRN6//jk5J5mGfga/mHNdiSl9UuB/ooOy1zvy6lcuo/NQGE7Zfl
         rfyeHuQGoYNqryXuazLEtkq5KmTVJ9Kzdb+aai7Q+IRKW3H/ys9azXYkn1qwmEOL8hV7
         T2LXSjXtdC34lQvpcMiLKbRp3f5OtnKLak1g2DW2f8D2ooz0wglcfrQedK9RYI4snmDR
         Nz4DwInkxCOt2ZVrKOpG+LgWrJStiADgRFRjS3CkdMqCne7Ap/s0glwqNeRaLdoN+6/s
         pZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4zd08a/aEuuvzgXCpZBGh3mPsbuLtYRCDVVyrJ0U9c=;
        b=NUveZg2bl5IsoZiNdiT9JJqh5g5i1xcS8flNISzS6EMEz2Dt4SUCz3uERaHx5OZyjc
         oB01Izf0Yec0qrWmwSf2EnbKSz3CoH+O/Toa60vsYinakDXVmIMS1ogYy7tMz8pGNaIS
         Fjv6EN4SiaqMh3E8kj0JqwdaD2kIifyrJbZhRInjE8qwEHZHntAGn341A+EYeLz1rc6o
         F5vJ6Tsnd/knMTeNXG9j5K8hZcVLjul+oJnNL0U0Fk8MPAPaM64OdQvPlFuWWsMwkBjT
         sJsLkgCge8H6Bsg03B0G1eExxb6jES1qZyJ1aX8MQmb+yTWveULEzm41wJx8hdLq0KLP
         8fLg==
X-Gm-Message-State: AOAM530+ofkEPrsnZO1IjCyV4+ovHB8oms16BdaHnKngkRufVCYtHTR4
        BEnaDvS2YfZHLASswBbJQ6WoS9y+8NsU0CkYTpDuH0J0
X-Google-Smtp-Source: ABdhPJxRM7EzptZc1gshyezQ+7BiEr8+UTMlwQDGRK6Yl2x5+LzSRjHxzeVY8o3iEk/dLGICUf4wJ1nhS1f6UfMTzLg=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr11980024otn.162.1596807762380;
 Fri, 07 Aug 2020 06:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200807132640.1787455-1-omosnace@redhat.com>
In-Reply-To: <20200807132640.1787455-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 7 Aug 2020 09:42:31 -0400
Message-ID: <CAEjxPJ6ZOLTG91DzMCw3iat=p=Y0K0So7Yg7zeUnYdivuDAk=Q@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: run the full testsuite on a Fedora VM
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 7, 2020 at 9:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> This patch removes the old hackery to test-build the testsuite and
> replaces it with scripts that run the full testsuite on a Fedora VM. The
> scripts are based on William Roberts' work on SELinux userspace CI [1],
> which does a similar thing.
>
> The CI currently uses a F32 VM image which comes with a 5.6.6 kernel.
> Eventually we might want to run on a more recent kernel/userspace, but
> even this is already a big improvement over the old CI approach.
>
> One downside is that with this patch we lose the test build against
> refpolicy, but it shouldn't be too hard to add testing on a Debian VM
> with refpolicy later on.
>
> [1] https://github.com/SELinuxProject/selinux/commit/562d6d15272420542bf65da328bc5300219fce76
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Sounds good to me.  Only question I have is whether it would be
possible to use a Fedora rawhide VM instead of a fixed version like
32?
I understand that may have some stability issues but it would get us
more recent kernel, userspace, and policy for testing.
On the Debian side, I'd recommend Debian unstable which despite the
name is more stable I think than rawhide and is what I've used for
getting the testsuite up and running on Debian.  That exercises more
of the tests than even Fedora rawhide does currently due to defining
more classes/permissions.
