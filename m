Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8209BC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 18:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBAC22B4B
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 18:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgMIF7Jq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgHZS0w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgHZS0v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 14:26:51 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34EAC061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 11:26:51 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h17so281369otl.9
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ed919c5wBgd5nqUG1Czb4ioriIJat0THS4HbUU7PCsc=;
        b=sgMIF7JqZQ4/kiP83Lry8j9370IKbLTTJ+yEQZFtbSuxA9512y8YpBlpcmrWx1KBi+
         ExIEa3Skb7fK41Zv8jObefV35aVOwsVgJK7vR3bKuaOo0r7iull4doxk+/nXqkkLpapD
         BBNXTF0YLAw0aiNg7sWXZWMO2MvdgdXvWUCMHQYGV++Lf9Tru54GZdwQVoFLkENdqJmC
         1706GxZVcDlIFLUbZcZCVm6sq0902WC8bCi0Ap6DDPu92Ny125lYpwkG5YeUjwWxOAdh
         Ehl+tHqFpkxvZRQqWMNqT4WtpDOG+tsuZnjpAjtBuombg/X8MUR8rf/ps5Kzfl8po89u
         DHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ed919c5wBgd5nqUG1Czb4ioriIJat0THS4HbUU7PCsc=;
        b=NywhyOHGykMUHu1cE9tICU5qJgRwfn5+w5CHqWfd7NjpEKH8oMXfivvaU1HYtL3nxX
         GLm5/z0H9mrAli01sfdYcdsUaT7Ia50PMcjj8hTpzTHLsYpS/jdYO6xg8KM6bGJ8L8xJ
         yHlViIhzd+CKBUEyaiQJ7QjZONqXVeHR3DvUNxVI/sIabY9dup+QfxYzJ4nU137IHVnb
         8JGlSh149T0up14IlsjIyeOjibNcAfkxOX8lC92s2RsMm7Q9TqubzFPNUSJxUECsfo3t
         Mz+7+OnKH2mm6KPgoz+Vm2xKhZPs5+jCjKUhkj4uNXqlSQEn9SBweCnb8Vhm1icDgh7K
         TtDQ==
X-Gm-Message-State: AOAM530xBkAoXNrioXg9P6R4dmk+rO0v5KO0sAWbP5gkn3L1irCftECf
        J+gMbGV6XXP4USr9qusiAvAkG+LPWICyINcIoFdNs5zU
X-Google-Smtp-Source: ABdhPJxfWRux3ay1rrPW/9OO8+47EAW/XDGNta4SkLB9vCRVlGzS98IyR4KGgnAySyFhOGucJ+bvYoVqMEa5dlo0YR4=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr10280286otr.89.1598466411099;
 Wed, 26 Aug 2020 11:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200824134416.331220-1-chpebeni@linux.microsoft.com> <CAEjxPJ5V+zX8cbZoM6o2w_Ae0p-md9CJje3rOEfcrE7Qw57GQA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5V+zX8cbZoM6o2w_Ae0p-md9CJje3rOEfcrE7Qw57GQA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 14:26:39 -0400
Message-ID: <CAEjxPJ7Y8cGXKmgA+M36fx8qD+f78kF-xOS+Ooq+OogWNJYp4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] libselinux: Remove trailing slash on selabel_file lookups.
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 10:55 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 24, 2020 at 9:45 AM Chris PeBenito
> <chpebeni@linux.microsoft.com> wrote:
> >
> > Having a trailing slash on a file lookup, e.g. "/some/path/", can
> > cause a different result, for example,  when file contexts are written to have
> > the directory have a different label than the contents.  This is inconsistent
> > with normal Linux behaviors where trailing slashes are ignored.
> >
> > Many callers already strip the trailing slash before the lookup or users
> > revise the file contexts to work around this.  This fixes it comprehensively.
> >
> > v2: fix length issues
> >
> > Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
