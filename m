Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F33C00523
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 08:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068E4205F4
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 08:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzcHRi+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgAHIP7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:15:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26898 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726290AbgAHIP7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 03:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578471358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=guT6kTsLokgbAQupkBrMXa7hfvd98YhJfrx8THelgJk=;
        b=fzcHRi+e6HiSHkfKF6oWvBcOmxIxwQiy2S6+Y7KGXwCdEaLzTtc4BlMZ8XAUpT4H6fZI2n
        cCpjrRFAiEaMFD57/X3dWd/FBE04xzcTFNH/6S890wxJffeE+kZHZ/6Nyb/Z3ApDhk+h5S
        K4npDAT8GehkaSTUnsALAdJNWzemHJA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-a_I165z5OLKodsF4V7UzZA-1; Wed, 08 Jan 2020 03:15:57 -0500
X-MC-Unique: a_I165z5OLKodsF4V7UzZA-1
Received: by mail-ot1-f71.google.com with SMTP id d36so1288526otb.16
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2020 00:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=guT6kTsLokgbAQupkBrMXa7hfvd98YhJfrx8THelgJk=;
        b=gXIIdZaBb84FSTwyTm/LOYGkeDYJV2ygssCZsWSGS3hJ2i+IiG7vB5U3lrJiB7yMe0
         MDcJytLZt6xpExmIomYaQ/EMHp73x5Oi2AkBqUhtpksmrMhd9bIrc1H58PAe4sIOY24s
         BhOvJ0yaHlyNYhsE8H4PnAbOTgk/vPXIcZPHYBT3buW5xs9NPUPxl21E71ZZy7Qlbsho
         e9RUCRySrb7Pgo473Da6FvdBk+emIl5Wdi+dX/eLMRZZlehuDdDCCDFyn1x2alfNP8pY
         i2IcOXtqwrXpqPKuKzjd9SV7JbfV1QGKSrNrtO0NkpEczK1l8K/EMNmMfWTcM/t+GUpk
         /3Sg==
X-Gm-Message-State: APjAAAUz/yRlMgfH5C2V8tOAGFHoIgVi1tDcyJVWst8GOkZw8KH0yGA1
        WU6ZticFPbxih7P+UADi8gJXWHEshRdrgiuz9KYHJmkcVWuYzlnSthXCtvh1r+blPZ9sp7DmpNc
        EPeJiQRlgXtwELYx+TQyVSu5F0z5F+mRW7A==
X-Received: by 2002:a9d:65da:: with SMTP id z26mr3263209oth.197.1578471356449;
        Wed, 08 Jan 2020 00:15:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1WDTTWu8JFjHIcvLnML19PJN0hLw7rnXAyqh09eUDmnCDMK7ErIGk79rg1Nu/pOncZ8YIduADmYgLXuRvClU=
X-Received: by 2002:a9d:65da:: with SMTP id z26mr3263183oth.197.1578471356198;
 Wed, 08 Jan 2020 00:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20200107133154.588958-1-omosnace@redhat.com> <20200107133154.588958-3-omosnace@redhat.com>
 <bad81aeb-c21f-c5be-12a1-61912d04573a@tycho.nsa.gov> <CAHC9VhRMLJLSUY5VfdDRv=OuyLkvzsyqfpNhf_SfC9V8OALJ4g@mail.gmail.com>
In-Reply-To: <CAHC9VhRMLJLSUY5VfdDRv=OuyLkvzsyqfpNhf_SfC9V8OALJ4g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 8 Jan 2020 09:15:44 +0100
Message-ID: <CAFqZXNuv6OV_w_qneo-vK2Z4SBOqKRnnwNr-tgK__uSoX=76Ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] security, selinux: get rid of security_delete_hooks()
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 8, 2020 at 6:32 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jan 7, 2020 at 9:46 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 1/7/20 8:31 AM, Ondrej Mosnacek wrote:
> > > The only user is SELinux, which is hereby converted to check the
> > > disabled flag in each hook instead of removing the hooks from the list.
> > >
> > > The __lsm_ro_after_init macro is now removed and replaced with
> > > __ro_after_init directly.
> > >
> > > This fixes a race condition in SELinux runtime disable, which was
> > > introduced with the switch to hook lists in b1d9e6b0646d ("LSM: Switch
> > > to lists of hooks").
> >
> > Not opposed (naturally, since I suggested it) but my impression from the
> > earlier thread was that Paul preferred the less invasive approach of
> > your original patch (just reordering the hooks) as a short term fix with
> > an eye toward full removal of disable support in the not-too-distant future.
>
> Unless we are seeing wide spread breakages (I don't think we are), or
> we decide we can never remove the runtime disable, I still prefer the
> hook-shuffle over the changes proposed in this patchset.

OK, I'm fine with either solution. Do you want me to rebase and resend
the reorder patch? There are some minor conflicts with Stephen's
recently merged patches.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

