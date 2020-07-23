Return-Path: <SRS0=Vikk=BC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AA0C433E0
	for <selinux@archiver.kernel.org>; Thu, 23 Jul 2020 12:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF32E22CB2
	for <selinux@archiver.kernel.org>; Thu, 23 Jul 2020 12:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCFC2n+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgGWMXL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgGWMXK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jul 2020 08:23:10 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13856C0619DC
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2020 05:23:10 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id w17so4191762otl.4
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2020 05:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VA/dRB1MRIT2J0/maze+SprSY7cjufRhO+ngCGeoe64=;
        b=YCFC2n+/BjGPxKB3BmnLON3JEguUBJhFSmdoN9XeWGQKunMSKtC/5j88jCUjmGTMMz
         DP7G5LtFdqGJlQuO1Uabn4eXs05RQNOfLilKokkw7z8hW9rjyrKumQz/+x+fZbmUuzvO
         J5DpkCaXImVkf5FqWPVXOICvZMpaS/MEteKpoWgKisiut2kd9aMlGs43cLkb42nC3+MF
         XV0BaXQScyGZVjBsmOUhjVz/cpY38FvXVzxeEWN1VZSlVclbJFvryeWMaRNpu0U3o6LA
         3DNHrC7Sg9z1JczE9fbV8DtL6T/qJjXvwQUaT28vIxvlMzJBmSdOJKNVTp3pDaAlQ4c3
         gvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VA/dRB1MRIT2J0/maze+SprSY7cjufRhO+ngCGeoe64=;
        b=HJQJn5AKdm/9Qd49pzvsD3MlKWtTUzhZiZGYyBMPsi+bXPiedzoDuiUmXLgfOGAqMj
         9p9YAO73zzOmNPBhxsd+X7YhUru5BkL5y/7MChQVZ9POiWFH0v37B6BnxLM3V0rMv+tq
         gusAERCB2B6VAfCpvPl3cAkGh+uDMpdNVKQt8cohQYbe9WcuIJCFXKtv02NwpK6bzLmr
         JEA5+aW0SuiDFzran2JQXLGJXkKD87tHrBdPlmqg81k6saepz5qFqVQ/USgG72ZwjyaR
         mY3/K6NUJ+CMcgztoIjHB3wTQzYpN6r1e2YlICfT6PXI3ohHadGbneIJNVv1nrk0T/ow
         G3EA==
X-Gm-Message-State: AOAM531omZsn/pQ5ZQRquAC+GzH88gW55uXXX1jeaBzOcGGLZmLVK6YN
        4K9jIF+Nt5w7qTrX9VYxn6DZGFUHjEe7WUGkapoxgyFm
X-Google-Smtp-Source: ABdhPJzB289Ym9EV4Z6hRc8AQ/Wlq18Ct+T3QRZEjtnFHfw0b/JEWMSUe+cqBFmlJoywnfP3mnz0x+TsAPWfbvr04Aw=
X-Received: by 2002:a9d:6e14:: with SMTP id e20mr3735546otr.89.1595506989455;
 Thu, 23 Jul 2020 05:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200721195153.1974509-1-dominick.grift@defensec.nl>
 <20200721200230.1976501-1-dominick.grift@defensec.nl> <ypjl365kzkvb.fsf@defensec.nl>
 <CAEjxPJ6kVLAd41X9s7216+Svdo7his_WcQW52R04CztDEYr7fg@mail.gmail.com>
 <39629738-f5db-e784-1f57-e6b8958b73ac@defensec.nl> <CAEjxPJ4x_JM0B01NoLHZexwA9DWerDPDxP0TJaJgGT=GSBBT7A@mail.gmail.com>
 <a87a0d28-aa9c-ea6a-9f63-fe2f01d56e23@defensec.nl>
In-Reply-To: <a87a0d28-aa9c-ea6a-9f63-fe2f01d56e23@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 23 Jul 2020 08:22:58 -0400
Message-ID: <CAEjxPJ7YfUkhej=aMObg7c42KgHpmX_qBdC+30BmuhJ9-LtBJg@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v8] objects.md: some clarifications
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 23, 2020 at 4:13 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
>
>
> On 7/22/20 7:32 PM, Stephen Smalley wrote:
> > On Wed, Jul 22, 2020 at 12:57 PM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >> Can we not just assume that if that happens, that the kernel should just
> >> treat the context as if it were the context of the unlabeled isid.
> >
> > No, because then a simple typo or other error in a context provided by
> > a user or application would end up being handled as the unlabeled
> > context instead of producing an error return that can be handled by
> > the application or user.
>
> So are you saying that it is up to the libselinux consumers to deal with
> this? what do you suggest they do in these situations?

libselinux cannot handle it in the general case.  If using the
userspace AVC and SIDs obtained via avc_context_to_sid(), then
libselinux could transparently re-map those to the unlabeled context
if they cease to be valid.  Otherwise, it is up to the callers to deal
with and the correct handling is application-specific.  SEPostgreSQL
does this for example:
https://github.com/postgres/postgres/blob/master/contrib/sepgsql/label.c#L460

However, I don't think that would help something like systemd; even if
you re-map the context to the unlabeled context, you aren't going to
get a useful result from security_compute_create() or similar to use
in labeling sockets, processes, files, etc.
