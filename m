Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEE3C00140
	for <selinux@archiver.kernel.org>; Tue, 26 Jul 2022 19:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbiGZTRL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Jul 2022 15:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiGZTRJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Jul 2022 15:17:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8AB29C84
        for <selinux@vger.kernel.org>; Tue, 26 Jul 2022 12:17:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so11923156wme.0
        for <selinux@vger.kernel.org>; Tue, 26 Jul 2022 12:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IN6jsLzzDm9Bg5VLYyR1jQid6gxLtPqKOGesbc2Ib2s=;
        b=FfhnaTkvEoW3v2svHGtfW03udJyaSoCToOyt8VpsTfLGPcGaIGtsn8ZEZodMp/j6GE
         FXdOmQNtbEXtSHzSexNNacBtwoxXHB7Ae/AlIcF3n3GbR8EAlto7sQOw1ImlLaEmqmMP
         thop6o0KzyQkmXRiJztC67Tzt+nXJL/hwbuBWJTBasPSTzKSMKNm11pgD9Bj7kGzWJNl
         CXYJnVXcsdHKopNVsa5gCxX8NvIfKDQYb1JoohHbMasBXzsy/VG6c+q+KtQUkVS9JvPn
         wPPNHWEB+4oSdLgT8S861znFvKI98TycI5vfDWXOgiHHiTKbxq0JawJrAWxLMnbHlU2M
         dweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IN6jsLzzDm9Bg5VLYyR1jQid6gxLtPqKOGesbc2Ib2s=;
        b=6160PO0ymoukjGyqlRM4GVM43uNYqE9lER51Zap13iTJTdusAcjUudXAjjB5+0wapS
         QNCGECvnVWFBqVVWclcXYgRjycvkxtT7/rkT+DDcrm7RrOTyblbz0bj/qUbChz/iBU5S
         m1s4j7dii4Cel7iOBQjiES6uo8chV7KQCz5J8zVdVxqbbZ14bX91zMWMqa3cDcxQ7wuI
         nGY0R3WPiyHGzFeFrJeWb4DeA6+DZHjBJGbWfVxqy6z2zsDt9j5s7k06rv94jWwA4yu/
         twYHiQOJK76AqT3nkEP13wVCo6OCsFDFN4MpOo8fQ9iC64YvOgYvsK03E4mgX+TJnyLb
         hU6A==
X-Gm-Message-State: AJIora8APS5HZwYah/pjqKdpMgAf6/NhwWfjIOprOcl0eRsOa2MT4k6u
        QV3eVYTZL/sgHWvOZLCNsBH5cqS2Nynx1ee7bPKrrjVesQ==
X-Google-Smtp-Source: AGRyM1scdlVZhU4FWKSuKZpGoUoUWqUr4HxdM3l1BSDxch3HC0WsIlkvNN0kBsfOdnVAmH/gfd87VQZEq3mrBpf5m6k=
X-Received: by 2002:a7b:ce8f:0:b0:3a2:ff2d:915f with SMTP id
 q15-20020a7bce8f000000b003a2ff2d915fmr437033wmj.165.1658863027125; Tue, 26
 Jul 2022 12:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <165818338297.423746.2325119921845739520.stgit@olly>
 <CAFqZXNvit5QK5zGjwp1tzFKSEyz0t85iqoE=Qv_yYnNYO1tsDQ@mail.gmail.com>
 <CAHC9VhRCyo6Fuq1iorFJpjn2wvN2VQba87tSfNwBdjyULZc-2Q@mail.gmail.com>
 <CAFqZXNus=Rnn=5qpQ4goLWvuinAA__ayjBCT0W3tR2HwtgOm=Q@mail.gmail.com>
 <CAHC9VhTg2jB_9F74yRsW59bHdMKQPPftV6EWGM0rK0zh0xeNuA@mail.gmail.com>
 <CAFqZXNs3+wcA_g0aojkmPACKM9tLwxxYV7OjiSjBfZNOnJeLrA@mail.gmail.com>
 <CAHC9VhT_JvJfafywYiHHdV93TAvgKZAPKQooshpG3CWyF+870w@mail.gmail.com>
 <CAFqZXNuCb+ugR0btKdBbQb7-MiHhEnm2L7XEKByVBf8+yb-x9Q@mail.gmail.com>
 <CAHC9VhTEG7DLqy4PiuJJuSgAR7L_zvMpoJauRYc_i99UjO=jWg@mail.gmail.com> <CAFqZXNuVxtDwwDHPGjCrJcO4VgDfx7DJsi1fk99XqVboawRiLQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuVxtDwwDHPGjCrJcO4VgDfx7DJsi1fk99XqVboawRiLQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Jul 2022 15:16:55 -0400
Message-ID: <CAHC9VhQzcPhzS-quFeuk03zwjE1smE16YjvZQ9Cw8jxXhMRJeg@mail.gmail.com>
Subject: Re: [PATCH] tests/sctp: remove assumptions in the SCTP tests
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 26, 2022 at 4:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Jul 25, 2022 at 10:40 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Jul 25, 2022 at 5:52 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Thu, Jul 21, 2022 at 3:51 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Thu, Jul 21, 2022 at 4:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > On Thu, Jul 21, 2022 at 12:17 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > On Wed, Jul 20, 2022 at 7:14 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > > > On Tue, Jul 19, 2022 at 4:28 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > > > On Tue, Jul 19, 2022 at 7:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > > > > > On Tue, Jul 19, 2022 at 12:31 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > ...
> >
> > > Ok, I'm going to merge this patch with some minor edits (see [1]) if
> > > you're okay with them and then I'll look into further improvements.
> > >
> > > [1] https://github.com/WOnder93/selinux-testsuite/commit/0f7bb1696a15972a555d997377348b8e4ae56b38
> >
> > Whatever you need to do so you'll merge it is fine with me.  My goal
> > is a functional test suite, I don't care that much how we arrive at
> > that point :)
>
> Thanks, I applied that patch:
> https://github.com/SELinuxProject/selinux-testsuite/commit/db1c3fbf5a718797365576d0b449dc7658da056c

Great, thank you.

-- 
paul-moore.com
