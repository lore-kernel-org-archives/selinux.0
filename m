Return-Path: <SRS0=bGuM=BB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29021C433E1
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 17:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE849207DD
	for <selinux@archiver.kernel.org>; Wed, 22 Jul 2020 17:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKEu5kq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgGVRc1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgGVRc1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jul 2020 13:32:27 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9CCC0619DC
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2020 10:32:27 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h13so2397668otr.0
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2020 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1zKf7JgZyzsTC44uTkLUfu4REWKGsRuR6OpnLWodAg=;
        b=FKEu5kq7eOiKgJy9EDB3MG7KeG+qXn7CkgjEa61s+B7MJBbIIs13WEwEOpR241TbNH
         y/Qi2frwfplKomt3SvX+SorVi8lONjMlGqP7dw/ZcU4h5+sHu6agMSKr3+Dv4uKSUf3I
         899oNaIUt9rmAq8Jg+yjEoFpd3Ft2GcOl0Km7ErMQHnrFFAedxF9XUiMIdHUGvRwooVC
         X8LCIZKZTjhO/MXtdxRBF/VUS03IEYoQAuywG93zqeFFaaKV1MrWn/wGcT2Eo7uMrlbj
         qJ40Os+k9aBMTMHfga4KfmupohDKfiNfnlPhv3l0jPfjM8UvRr7l6ZoSSSS/jOvSdfE4
         y93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1zKf7JgZyzsTC44uTkLUfu4REWKGsRuR6OpnLWodAg=;
        b=T2h5lyZYiETQ3i+6QLK6bWyxMKttiH8D2TmSm1NIdhYuEggyy2SX48Dq30HOopI0cG
         popHXku7am7LbgiC5El4+KkgHKEDtGzsLLVoXDrQR54BCoIqvgJBC2hE8bloRuml0yW4
         uQBmy5jg+0lg9XCxio4Iw6szAbxf3maJBaYbIGeWP1aWiFFlmHyl6sRWTlwAz1RmTa/L
         yw3qWg1uO4PqEJlkHd1hQoRC2ZU80Mjj8aIj9kiUIezq+gu6V0m22CM5P79PZ7eZUnRF
         KO6cxuMi7SZs5yYLfUrsoHNsZOPNJHnQ4Kphc7DlvSAbPr5t7shFHH0SbDjzZ5/dwl7g
         Nucg==
X-Gm-Message-State: AOAM531FkKwNtVvcfXl+fkNCcOZQ4h3HK7wGtcW9XudI9ARmZUQOe3tP
        hKmtsUGAd0hwshaLbe8FoUSdPHMAwjB92dFJpHdXOQ==
X-Google-Smtp-Source: ABdhPJwFRJQhxA0nf8lj9SNZPtDD8rsm0aYB2vv0GW4AW+CLPdx3PaD8UX7xATLeNIq+rg+7bfTOncJXy9Bk8jChrkI=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr930678oto.135.1595439146735;
 Wed, 22 Jul 2020 10:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200721195153.1974509-1-dominick.grift@defensec.nl>
 <20200721200230.1976501-1-dominick.grift@defensec.nl> <ypjl365kzkvb.fsf@defensec.nl>
 <CAEjxPJ6kVLAd41X9s7216+Svdo7his_WcQW52R04CztDEYr7fg@mail.gmail.com> <39629738-f5db-e784-1f57-e6b8958b73ac@defensec.nl>
In-Reply-To: <39629738-f5db-e784-1f57-e6b8958b73ac@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 22 Jul 2020 13:32:15 -0400
Message-ID: <CAEjxPJ4x_JM0B01NoLHZexwA9DWerDPDxP0TJaJgGT=GSBBT7A@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v8] objects.md: some clarifications
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 22, 2020 at 12:57 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> Can we not just assume that if that happens, that the kernel should just
> treat the context as if it were the context of the unlabeled isid.

No, because then a simple typo or other error in a context provided by
a user or application would end up being handled as the unlabeled
context instead of producing an error return that can be handled by
the application or user.

> I mean that is what it boils down to anyway: everything always needs a
> valid context. so might as well treat invalid contexts as unlabeled
> isids? Not sure how "state" is relevant here as invalid is invalid.

The state is whether the context was previously valid and used by the
application.
