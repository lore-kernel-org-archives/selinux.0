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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9657EC433DF
	for <selinux@archiver.kernel.org>; Thu, 23 Jul 2020 13:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E00F2065D
	for <selinux@archiver.kernel.org>; Thu, 23 Jul 2020 13:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTwCp8vR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgGWNYv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGWNYu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jul 2020 09:24:50 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D41C0619DC
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2020 06:24:50 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x83so4942419oif.10
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2020 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SpqTMrMDu0KwcY605keOaAQsB5kFSaM+fSlsjJi1FYE=;
        b=uTwCp8vRsZj76geLSXvTZulzWYmZv5YMISz8cK+nNw6jS+VkVwh93jAnfXeRn5S0DF
         nI5Ozx8VM0ZEa0zeZYz8gUgJcQFLagAty2zng/yLHF4xG/gKkDE3H2q6BayDU3GR+daj
         nZvwVjp3YI2X1OgJS8VUVIOaLy8DYevryfQijWki2EpbtPlAxjkp9YuVFHJjYvQ4tx0M
         e2gur69Z4FNzOYt9Wgpl81HFLpERGi8RD4OVASxRawK7dDVZ1LoFJkkWxBHssgAEP5XG
         aBCLpCjs4kzdOw1GMU8iYIlWUzc2IPpqWOckPB2GRGFLtZOm1PJNEu4vM3m2om1aSkoX
         DQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpqTMrMDu0KwcY605keOaAQsB5kFSaM+fSlsjJi1FYE=;
        b=aNz1rj1xdQnvqYr4XdwokrAkvWGz/DiRhA+QSKXT11jvAcn6kSAX6WemKpaSq42WiB
         Un3BYGcb95MZ67HeianWA6mDTCAMusIm+8EM6/R87JWUwlXB7mTj/EbnaxTjyrzl+EJb
         lzu1so8XIVRnCKdcAqkafVWzv+yRyu4NOX4rluFm4agxYdqHC+gjUGh5oVoREpUwsxpl
         +AYRMfSUM7D/m/NJotWVIogSF9iSDX5oUKv/nx7USwaxmy+1r73aEXqXWckyzoEoXoU1
         bepaKbfA4ldiRzFRVqrgRJwbA0T87ADFtTxQXZJrb6uSucFUw2cOk6W2qBBP1hUMrILf
         TJiw==
X-Gm-Message-State: AOAM533BNxnsp/zd9umUzeZE5RhrSNNxbwWewAA4WYXWpLuzz80Isr5j
        Hkim32APsf1t7Dou0ZTZf+xU3jtnRK+66qrBd4c=
X-Google-Smtp-Source: ABdhPJxU/8tyUqI7p6SiOgmy5ggv3sCAvVJNl3zxuC+95wBd24jbDIeDWhLlk0yAqYMrQNh2ONsTINXlpjD8x8qweX0=
X-Received: by 2002:aca:2807:: with SMTP id 7mr3837834oix.140.1595510689972;
 Thu, 23 Jul 2020 06:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200721195153.1974509-1-dominick.grift@defensec.nl>
 <20200721200230.1976501-1-dominick.grift@defensec.nl> <ypjl365kzkvb.fsf@defensec.nl>
 <CAEjxPJ6kVLAd41X9s7216+Svdo7his_WcQW52R04CztDEYr7fg@mail.gmail.com>
 <39629738-f5db-e784-1f57-e6b8958b73ac@defensec.nl> <CAEjxPJ4x_JM0B01NoLHZexwA9DWerDPDxP0TJaJgGT=GSBBT7A@mail.gmail.com>
 <a87a0d28-aa9c-ea6a-9f63-fe2f01d56e23@defensec.nl> <CAEjxPJ7YfUkhej=aMObg7c42KgHpmX_qBdC+30BmuhJ9-LtBJg@mail.gmail.com>
 <cf636a16-5f4c-99e7-f2a9-0fede46b233f@defensec.nl>
In-Reply-To: <cf636a16-5f4c-99e7-f2a9-0fede46b233f@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 23 Jul 2020 09:24:39 -0400
Message-ID: <CAEjxPJ6e=FSV6xiuZQW1m8yxEg-zQ-VMk=iQQYNF9JiQb3XJag@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v8] objects.md: some clarifications
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 23, 2020 at 9:04 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
>
>
> On 7/23/20 2:22 PM, Stephen Smalley wrote:
> > On Thu, Jul 23, 2020 at 4:13 AM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >>
> >>
> >>
> >> On 7/22/20 7:32 PM, Stephen Smalley wrote:
> >>> On Wed, Jul 22, 2020 at 12:57 PM Dominick Grift
> >>> <dominick.grift@defensec.nl> wrote:
> >>>> Can we not just assume that if that happens, that the kernel should just
> >>>> treat the context as if it were the context of the unlabeled isid.
> >>>
> >>> No, because then a simple typo or other error in a context provided by
> >>> a user or application would end up being handled as the unlabeled
> >>> context instead of producing an error return that can be handled by
> >>> the application or user.
> >>
> >> So are you saying that it is up to the libselinux consumers to deal with
> >> this? what do you suggest they do in these situations?
> >
> > libselinux cannot handle it in the general case.  If using the
> > userspace AVC and SIDs obtained via avc_context_to_sid(), then
> > libselinux could transparently re-map those to the unlabeled context
> > if they cease to be valid.  Otherwise, it is up to the callers to deal
> > with and the correct handling is application-specific.  SEPostgreSQL
> > does this for example:
> > https://github.com/postgres/postgres/blob/master/contrib/sepgsql/label.c#L460
> >
> > However, I don't think that would help something like systemd; even if
> > you re-map the context to the unlabeled context, you aren't going to
> > get a useful result from security_compute_create() or similar to use
> > in labeling sockets, processes, files, etc.>
>
> I suppose systemd probably should not fail "hard" when getfilecon (or
> whatever) fails and returns with "invalid argument", and it should then
> just not use setfilecon rather than not create the object at all (as it
> seems to be doing now)

There is a tension there with fail-closed versus fail-open and the
potential for a security vulnerability to arise if it proceeds.  Would
have to look at the specifics to evaluate how it should be handled.
Of course, in practice, one really shouldn't be removing contexts
while they are still in use (or else use aliases to preserve some
degree of compatibility).
