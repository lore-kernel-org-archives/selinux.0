Return-Path: <SRS0=wZqU=AD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B77EC433E0
	for <selinux@archiver.kernel.org>; Mon, 22 Jun 2020 12:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18EAF20716
	for <selinux@archiver.kernel.org>; Mon, 22 Jun 2020 12:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq9jBvPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgFVMW7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgFVMW7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Jun 2020 08:22:59 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C9CC061794
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2020 05:22:59 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id c194so15426667oig.5
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2020 05:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6JmRDLvA6IDf6PM049iwGUzvnXARRdvQNLAIdRISzE0=;
        b=Xq9jBvPwB1rVn4l8Py28j5LQnTdsAMFpVhnS4vgCsKIapj6Fm0CU325gAFrumKFfE6
         jVC8npciVlqXqqmaiDcYztV5zy7P7lVINC6WcuQRV23dpELjEwXUm7YEoZWV/cNRCZsm
         bzvb4D3TXiZYLeiy7URCm9OqJZTnwnfrtWY3n+BLOav/qG32CfiaVid2rD5lapA8yZhw
         6OARGG60XEbdw6VUbcnIRdNT0vyKj3H23u+qGs5bA36UwfnIgVFcR4npa26OhDpiB67h
         Yxo/XFZxDXgelWgsgpc0ZmjGe+w7YSafxeyggiKHlYXVDko8GaA9saU9Dc61BVEZo3t2
         WpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6JmRDLvA6IDf6PM049iwGUzvnXARRdvQNLAIdRISzE0=;
        b=ADN1gVJ9eR1Ewurup704pT2ReLH5tSgqoXx9Wy/AVRDYDGYlwgDk305oEPYTE0JX4Y
         DX5KlWBpADXEIyiStvAXkMc6kmfhJTR16/wXuvtNt3v7jw3PEohzzo6na5wFRzQvltPo
         QQntBeue91Bhrfq0QvRgm+1cjlbsgi/ejqxa7xQBj3m7Zx78j6+Y8fK1mM1A/tten7am
         YcJFZNf90obSRLqPG3WO24jU/z7QI9M6ENdGODz0s/iBXS54KSZg3FBrifUjWjppg0rU
         aPcFw+zTPTRvXJCuxVQdNPCUIHNIN2fI7Wn40H9LGw5OmBY8KcEG9j6JrzNWhkQ9kiK/
         rEfg==
X-Gm-Message-State: AOAM532mufyAfH7b6rhiItBvXqy3wvmpiaPDFa0p12wstXIM8eIIADde
        BGt5KbPA39aKoQanBeR+xNlf82XBjbbvMRIJ2fGOKZxm
X-Google-Smtp-Source: ABdhPJwZ5J2/2Rjq+lBQzOkPAQCqJjGRqvvgR/Sqtru9YVgT11uuwi89OIzUq2XKFOR8GOtqIwv0tGo/ITq2NoIwuVI=
X-Received: by 2002:aca:3283:: with SMTP id y125mr12326202oiy.140.1592828578853;
 Mon, 22 Jun 2020 05:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200605081952.16278-1-toiwoton@gmail.com> <CAEjxPJ50YNJViUUA=7jaLwzPDMJUE0xzegAes4YF=TwpAo88YQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ50YNJViUUA=7jaLwzPDMJUE0xzegAes4YF=TwpAo88YQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 22 Jun 2020 08:22:48 -0400
Message-ID: <CAEjxPJ6eevd1JOQN_8yC1SyQWoqPwkBvGJDu=ju+Dpku666KhQ@mail.gmail.com>
Subject: Re: [PATCH v2] semanage: handle getprotobyname() failure case
To:     Topi Miettinen <toiwoton@gmail.com>, linux-audit@redhat.com
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 8, 2020 at 12:18 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 5, 2020 at 4:24 AM Topi Miettinen <toiwoton@gmail.com> wrote:
> >
> > At least on Debian, /etc/protocols, which is used by
> > socket.getprotobyname() to resolve protocols to names, does not
> > contain an entry for "ipv4". In that case, set the protocol number
> > used by audit logs for "ipv4" to a fixed value. To ensure audit log
> > compatibility, let's use the same numeric value as Fedora: 4, which is
> > actually understood by kernel as IP over IP.
> >
> > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>
> This looks fine to me but adding linux-audit mailing list to see if
> they have any concerns.  It appears to make no change to the audit
> messages on Fedora.

Seeing no objections from linux-audit,

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
