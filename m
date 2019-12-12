Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63403C2D0C9
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 17:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42116206A5
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 17:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="SDVrEY6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfLLRyr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:54:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39704 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfLLRyq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 12:54:46 -0500
Received: by mail-lf1-f65.google.com with SMTP id y1so2363367lfb.6
        for <selinux@vger.kernel.org>; Thu, 12 Dec 2019 09:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGtKX1kt13mdGM3PaLrc46A54IKaWS0nhfT5c0klyuI=;
        b=SDVrEY6zRSB4jAbWVyWXxXTTXybZNcit3dqhff4LZFJPJmdZ4cACFIuBXJj/rqot/c
         71tDbOxshm13DXBj9/w1/Prk9f+iEBDvdPkTkpJPyMAaaG1QLNzL8VbOR/eQYPISrKxc
         uh/7wLIXINfuOo21YUYAeblGwRZ1YAzA0EK1lDKvBw79iJ26blBzzTkiEGA1uyA4xP5n
         qWfOxpgNiTkpL6vVDm03Wurau0SzYU0GXte1jiel2lBBFyzS2LVwhqD+HWZX6VkaVgpi
         JZaiD/jFJO4trAcMJS8d9uME7EOmw9RDhKMjvMfoVwB1tfn9WgAQZExucB+iefBGqTBF
         h4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGtKX1kt13mdGM3PaLrc46A54IKaWS0nhfT5c0klyuI=;
        b=dgY2IUYCkngpH1WIBQGTpcdVlQBfb8pVwD6V9bjS6W1HT5prvBZpnY05iNBpcXb4Bf
         mf1fek2TWXnFQQUHzluGkY1IUikS+zedJIizmQY74Uh2vyBuSBPgu/ATPCDpm+QnR6KX
         hWz2XPGifYGe+zr/K4OSiJtidpaKz/OO52i3P72m6ASsiWgp2VEsGVClfXRfcSNX1s/j
         Myedr/Nfal0XvsUGba4uS+YRkEsL0f5OzG+dgNukYCyCWoxbFZwfV6YuQvY8I/RDSdiI
         AB0btPL5EPgUEyqm06PrIi1gSTSMj1USbIXIQwErqesHLklyBq3LwIi5HD4/yvjx0oDT
         iylA==
X-Gm-Message-State: APjAAAV/3OhsbBH+phnTUpYnbPJwTD1DvlHdkBXMYBzMFE3i9QOqjdTz
        y3RR3YO7kmqOJYkGQlMpQNdATTsc6oi1aw6ucgcE
X-Google-Smtp-Source: APXvYqxXEoMUmdSYMOWyFwoTSCHbxfzcQu8ng6pjEQNKlgq/K0OBRkOPl7aUb7CL04MXpg/bGRg8FITnPH4oW2+m8Kk=
X-Received: by 2002:a19:4a12:: with SMTP id x18mr6435721lfa.158.1576173283073;
 Thu, 12 Dec 2019 09:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20191211140833.939845-1-omosnace@redhat.com> <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
 <201912110840.62A4E64BA@keescook> <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com>
 <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov> <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com>
 <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov>
In-Reply-To: <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Dec 2019 12:54:31 -0500
Message-ID: <CAHC9VhT_CBQN+aFWjpPixi9Ok3Z7bQ-053AHg4pvqVtn-RdVVA@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        SElinux list <selinux@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 12, 2019 at 8:14 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/12/19 6:49 AM, Ondrej Mosnacek wrote:
> > On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 12/11/19 1:35 PM, Casey Schaufler wrote:
> >>> On 12/11/2019 8:42 AM, Kees Cook wrote:
> >>>> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
> >>>>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:

...

> >> selinux_state.initialized reflects whether a policy has
> >> been loaded.  With a few exceptions in certain hook functions, it is
> >> only checked by the security server service functions
> >> (security/selinux/ss/services.c) prior to accessing the policydb.  So
> >> there is a lot of SELinux processing that would still occur in that
> >> situation unless we added if (!selinux_state.initialized) return 0;
> >> checks to all the hook functions, which would create the same exposure
> >> and would further break the SELinux-enabled case (we need to perform
> >> some SELinux processing pre-policy-load to allocate blobs and track what
> >> tasks and objects require delayed security initialization when policy
> >> load finally occurs).
> >
> > I think what Casey was suggesting is to add another flag that would
> > switch from "no policy loaded, but we expect it to be loaded
> > eventually" to "no policy loaded and we don't expect/allow it to be
> > loaded any more", which is essentially equivalent to checking
> > selinux_enabled in each hook, which you had already brought up.
>
> Yep.  if (!selinux_enabled) return 0; or if (selinux_state.disabled)
> return 0; under #ifdef CONFIG_SECURITY_SELINUX_DISABLE in every hook
> might be the best option until it can be removed altogether; avoids
> impacting the LSM framework or any other security module, preserves the
> existing functionality, fairly low overhead on the SELinux-disabled case.

Just so I'm understanding this thread correctly, the above change
(adding enabled checks to each SELinux hook implementation) is only
until Fedora can figure out a way to deprecate and remove the runtime
disable?

-- 
paul moore
www.paul-moore.com
