Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FDCC761A6
	for <selinux@archiver.kernel.org>; Fri, 31 Mar 2023 15:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCaP1z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjCaP1y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 11:27:54 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB491D2E7
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 08:27:53 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id dg15so7822210vsb.13
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1680276472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zKulOCXzF3Ofu1Dd2XLffFQ8yzeJm3bXIhHoZbjLhyA=;
        b=AvPKmjs68Azqbmoi8ydkiHXTwLmMsGy8W3Ck3+HzaPeeU+MXXXzx9RgdOKt/xPxrwJ
         MItpmBEhjhIIcOMfDkt76/+K9fyRRhuysJRbDwyMAHbmM7egxe1/QtVSj//2hO4aZM92
         3/VjfVEo4c6hJZWxLkE74MAbudivXcPuYhCZ7v9U7ayyaTaHNe5e4CdKv9pMEkTlVusE
         cTgpGWK4Qt7Lk3tt7WauNNsFXutz3yYfPWS7xAn19Qzz+lnUcYpnNhvaspyQw4Rz+NE/
         LAUwx/jJ0eEpujnMZgwXBbdU0hXVVY2c7cqzG9sORjB9qXpPsn/TKY+PcydCEc+lhDgh
         RFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680276472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zKulOCXzF3Ofu1Dd2XLffFQ8yzeJm3bXIhHoZbjLhyA=;
        b=C7XcAZDJj3WmxTp0yBWfhnGQJ2zz+TOq40gdw92EPQLDi0tZMnGwLfI8sLaZO9j0CJ
         aH7OtNYVrGecxgSglybsfDU/8AW2n7bflGVqkq9g7wofmCIYl7dA13NHsk3rLpP31kkS
         nokKFP5Prg6h0we72A9Db8vyz6xwDAXTL110SYm7Md/vqovIXrRe6tIqoDP8UU8GwVgc
         XQqf8FbYyr01akHaZuT3yhVO/eBjzm2Fs9Skp2h3O02MFJsZdmllT1plVVrFvNtdk1sC
         NnX27kDhjKVweCTYaj/3kzXSJupPpiMYgFC8Iuu1Pg0yth0ve3DAlKLIh8gfbBUEa7jb
         OWOQ==
X-Gm-Message-State: AAQBX9eGOv9a1IgepR6OvMjJntqkFBaA4fXbSUS59iP7rYsB6yxg2Png
        eYiFPf/wpqAIVJmfZWG2qcfEVmLfGtmlMqC1aopx0TX4J1RTNCF9
X-Google-Smtp-Source: AKy350YbcFRkxMVyyd0xVu50CRy8OviswWzah0Zc4qh8mc5m1YSmY1nvXZR8trcdMJvjQhAwtJSBaXzkljqcgnPyrgs=
X-Received: by 2002:a67:ca87:0:b0:423:d4af:dfda with SMTP id
 a7-20020a67ca87000000b00423d4afdfdamr15022580vsl.2.1680276472462; Fri, 31 Mar
 2023 08:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <c58a0cc8-6453-45ca-9bfc-f041b0e7478a@app.fastmail.com>
 <CAP+JOzR_nL0Y12hOU2gTU6=U+J4YaZsyE6TLMQWFSUi0dJ3NCA@mail.gmail.com> <b0037c2a-c10c-4819-8add-14c176aed942@app.fastmail.com>
In-Reply-To: <b0037c2a-c10c-4819-8add-14c176aed942@app.fastmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 31 Mar 2023 17:27:41 +0200
Message-ID: <CAJ2a_DfJUQW9Obq-8y=w6AZcK9svv4hqWrzRx3yWvSugFzaAKg@mail.gmail.com>
Subject: Re: Possible bug in policy compilation
To:     Jonathan Strauss <john@pleasantsmoke.com>
Cc:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 31 Mar 2023 at 15:53, Jonathan Strauss <john@pleasantsmoke.com> wrote:
>
> James Carter wrote:
> > Jonathan Strauss wrote:
> > >
> > > I'm not sure if this is the right place to post this, I was writing a
> > > policy for an API gateway and couldn't figure out why I wasn't getting
> > > a domain transition. Turns out I was missing `type init_t;` in my
> > > require block in the type enforcement file, but the compiler did not
> > > complain about the missing type.
> > >
> > > Seems like it should have failed with the missing `type init_t;`
> > >
> >
> > It is hard to say what is going on without seeing the policy you were
> > trying to compile. Are you able to share it?
> > Jim
> >
>
> Apologies in advanced if I mess up the formatting, looks like I am also
> missing another type `sysadm_t` (Still trying to understand the roles so
> it's a bit ugly) reproducer here :
>
> https://github.com/pss-john/se-missing-type

In your policy you are using the interface `init_daemon_domain()`,
which introduces via its requirements[1] the type `init_t`.
So for the remaining portions of the file `init_t` is in scope.

The following statements should be redundant by using init_daemon_domain():
  allow init_t gateway_exec_t : file { read getattr execute open } ;
  allow init_t gateway_t : process { transition siginh } ;
  type_transition init_t gateway_exec_t : process gateway_t;

The fact that the domain transition is not triggering means either the
subject process is not labeled init_t or the entry point is not
labeled gateway_exec_t; search for avc messages regarding the
permission execute_no_trans.


[1]: https://github.com/SELinuxProject/refpolicy/blob/8e8f5e3ca3e5900cad126cb8b4fadaa8adb8caac/policy/modules/system/init.if#L343-L348
