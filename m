Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333A3C43334
	for <selinux@archiver.kernel.org>; Tue, 26 Jul 2022 08:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiGZIyc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Jul 2022 04:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGZIyc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Jul 2022 04:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45DBB2CDF0
        for <selinux@vger.kernel.org>; Tue, 26 Jul 2022 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658825670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5fnPWXADxRHSCRAAQLJYtv3wtUHeDf3GIqcOXnhlZM=;
        b=i6YyxnViB9xJGj8Ie2KHO8JlqSkLsnJ+UmuZTbMULdNt4lTlawFI96ryQ5OmlqGwov6lyE
        NAodrOCsp+gxfQrSyv0TnlTqtKexi6jw3Q0KZXM9EGWaqx2NNHroMpW0Cf0RoX2sWYNFMB
        nm4ksH2ISQsWQJ5oYh51G0mwfza3DiM=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-IkYI2iYEPiqUvNsO3KmCtw-1; Tue, 26 Jul 2022 04:54:28 -0400
X-MC-Unique: IkYI2iYEPiqUvNsO3KmCtw-1
Received: by mail-yb1-f197.google.com with SMTP id v19-20020a252f13000000b0067174f085e9so681522ybv.1
        for <selinux@vger.kernel.org>; Tue, 26 Jul 2022 01:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5fnPWXADxRHSCRAAQLJYtv3wtUHeDf3GIqcOXnhlZM=;
        b=ZsNjgslA3S8g8QFL05c1tYadPjxx58HR2z9yYARHazI4UIeRa0XCR68VqWDPKTTJzs
         HCI8nfxOdLA6tb+41+RU31lHhkbSb9Ki7C7npTjx9sxnbNEmIqkvCE5aymJrkQTR8ybz
         KsQsP5nDsuup+zwmJe0s7D6ZWhSXT+7iNJc1EE3jA/p0+qrOn4prDV/UGoXaAUYLuByX
         pNsTLw+32DHT3N5IzhCtjABxqQuKrwXvnmcRk9nFBRVxbxKNu3mObOQeuu3wDpg0X7N2
         4CycH/ff5tXL+L2b6LabMe6QRSdo+JpXMPHFK2OTYVAPTQTtXnsvt66tuV71Yp2DIPhd
         tLfg==
X-Gm-Message-State: AJIora/nL2tTQ75zTBBy7YwPLb2aJNOpSbnJtOmwPVzESmbqPVwPbx2J
        Q8T3f581WTJut9FTUJ5RBvLW4BqwJKHC5cNKHnKniWwMk+xk8zSmaAVyIbgJZdBtmppR4tGJe8Y
        k3mMngIbegTYkjSvXCX+msthfPteOCm5zkw==
X-Received: by 2002:a0d:d513:0:b0:31f:5267:f9c4 with SMTP id x19-20020a0dd513000000b0031f5267f9c4mr217522ywd.247.1658825667436;
        Tue, 26 Jul 2022 01:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vvGcN2IvTb7ZLtYsHm7smNhFufaaucaLmITz9+xxs88Hm/gPkWeqNypAcsFkABhHNM6Y/BNsjyaZ1ZqpEkCSw=
X-Received: by 2002:a0d:d513:0:b0:31f:5267:f9c4 with SMTP id
 x19-20020a0dd513000000b0031f5267f9c4mr217513ywd.247.1658825667237; Tue, 26
 Jul 2022 01:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <165818338297.423746.2325119921845739520.stgit@olly>
 <CAFqZXNvit5QK5zGjwp1tzFKSEyz0t85iqoE=Qv_yYnNYO1tsDQ@mail.gmail.com>
 <CAHC9VhRCyo6Fuq1iorFJpjn2wvN2VQba87tSfNwBdjyULZc-2Q@mail.gmail.com>
 <CAFqZXNus=Rnn=5qpQ4goLWvuinAA__ayjBCT0W3tR2HwtgOm=Q@mail.gmail.com>
 <CAHC9VhTg2jB_9F74yRsW59bHdMKQPPftV6EWGM0rK0zh0xeNuA@mail.gmail.com>
 <CAFqZXNs3+wcA_g0aojkmPACKM9tLwxxYV7OjiSjBfZNOnJeLrA@mail.gmail.com>
 <CAHC9VhT_JvJfafywYiHHdV93TAvgKZAPKQooshpG3CWyF+870w@mail.gmail.com>
 <CAFqZXNuCb+ugR0btKdBbQb7-MiHhEnm2L7XEKByVBf8+yb-x9Q@mail.gmail.com> <CAHC9VhTEG7DLqy4PiuJJuSgAR7L_zvMpoJauRYc_i99UjO=jWg@mail.gmail.com>
In-Reply-To: <CAHC9VhTEG7DLqy4PiuJJuSgAR7L_zvMpoJauRYc_i99UjO=jWg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 26 Jul 2022 10:54:14 +0200
Message-ID: <CAFqZXNuVxtDwwDHPGjCrJcO4VgDfx7DJsi1fk99XqVboawRiLQ@mail.gmail.com>
Subject: Re: [PATCH] tests/sctp: remove assumptions in the SCTP tests
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 25, 2022 at 10:40 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Jul 25, 2022 at 5:52 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Thu, Jul 21, 2022 at 3:51 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Thu, Jul 21, 2022 at 4:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > On Thu, Jul 21, 2022 at 12:17 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Wed, Jul 20, 2022 at 7:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > > On Tue, Jul 19, 2022 at 4:28 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > > On Tue, Jul 19, 2022 at 7:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > > > > On Tue, Jul 19, 2022 at 12:31 AM Paul Moore <paul@paul-moore.com> wrote:
>
> ...
>
> > Ok, I'm going to merge this patch with some minor edits (see [1]) if
> > you're okay with them and then I'll look into further improvements.
> >
> > [1] https://github.com/WOnder93/selinux-testsuite/commit/0f7bb1696a15972a555d997377348b8e4ae56b38
>
> Whatever you need to do so you'll merge it is fine with me.  My goal
> is a functional test suite, I don't care that much how we arrive at
> that point :)

Thanks, I applied that patch:
https://github.com/SELinuxProject/selinux-testsuite/commit/db1c3fbf5a718797365576d0b449dc7658da056c

> > > The difference being that with SCTP an association exists whereas
> > > there is no similar state for UDP.
> >
> > That's irrelevant ...
>
> It's not, but since we both agree the behavior isn't changing, let's
> "agree to disagree" and move on.

Agreed :)

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

