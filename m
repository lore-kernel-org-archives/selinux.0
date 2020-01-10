Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBD6C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 20:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E245B205F4
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 20:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="YxCq+R3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgAJUXL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:23:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32952 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgAJUXL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 15:23:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so3457457lji.0
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 12:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7cqrWUHzi64rL5hmH2iWib1ynzwHDU+B5CXSephwtQ=;
        b=YxCq+R3IzE9umcV9eHqP7RTgB5s+9OXQRZBrkUAeiz7jfIMUK58CTQN1r9EMtzFm8J
         fsAKtHx48s+l1tL79Drxp1KVWO5BZGeGmAJ+SAUuCp92sEbwbNpbAyKLR2RmAcMFJVH5
         OwAboT9+d+xi6MLYXYIbSonWSHZc4MKpnYZY+CO84J+R757ADYgkNjyunWejn7ALWApT
         LNNFhLAydKJ1ZGx3mHf0rPBa/GTSWS4kRU6PbNnizvCjnSZofs+j6ExXgGnvQFuR1/O0
         08bxm8oblCcMCDjTEpGqTqdpE40tsVBH6J6VawyvJy0H5lG9M8UBJNwDes2Ymao941zI
         TQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7cqrWUHzi64rL5hmH2iWib1ynzwHDU+B5CXSephwtQ=;
        b=VTQ9M2zsSOBZ55IH3ThuyJSR/xPhwF0r7Tc+V5e2RtQG6lgsYFx0QrlP0dl78nqB2j
         t6zAVwPDmbtyYgDS5wKqe4NaSld3qh6PQmU6tlM9Q2GsyMBfWhcuBaOzKLIChcHibpsv
         QLe0YX2rBjB/eLqm6tLnavJrhEhfAPVehiON8YaG5yiSmjDI1aLThyT9Ji4ZSLjP18Yt
         WGfgbmluEauvV7zJm07V5RSI8yCmN/ZmfilEZzcRzIbLB5aE6A+wSJrxKip/QPbNZ7U9
         8qMPVYCbTWaMmKRWXFz5A6nN9ABLYfS32UXoZ8VKYH9xM3gbcQ1Wddp+fwGsRzLhUrEf
         NnpA==
X-Gm-Message-State: APjAAAUWHKnRPGhup4aiayF2ZArQ1T8hj/JuAdMLj/XefJ/Xb9Pb1DHj
        6/SUXNgJrloPVuLmzo5AYfCH9yyPdiXZB2mzYGcX
X-Google-Smtp-Source: APXvYqww8CBeR0r59ZlMOsEcNMfteGEDfFe+EYJmT3fAehiALflwCMe19vZPEAK/RBw1LLOc8IWLP+Kxo9vu6tUsq0Q=
X-Received: by 2002:a2e:3a12:: with SMTP id h18mr3806856lja.81.1578687789674;
 Fri, 10 Jan 2020 12:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20200107133154.588958-1-omosnace@redhat.com> <20200107133154.588958-2-omosnace@redhat.com>
 <alpine.LRH.2.21.2001080644500.575@namei.org>
In-Reply-To: <alpine.LRH.2.21.2001080644500.575@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jan 2020 15:22:58 -0500
Message-ID: <CAHC9VhTJ+s+AQPZ0dDdizfx62XO+cLZ76-8XntE209t6DL9H+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: treat atomic flags more carefully
To:     James Morris <jmorris@namei.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 7, 2020 at 2:46 PM James Morris <jmorris@namei.org> wrote:
> On Tue, 7 Jan 2020, Ondrej Mosnacek wrote:
>
> > The disabled/enforcing/initialized flags are all accessed concurrently
> > by threads so use the appropriate accessors that ensure atomicity and
> > document that it is expected.
> >
> > Use smp_load/acquire...() helpers (with memory barriers) for the
> > initialized flag, since it gates access to the rest of the state
> > structures.
> >
> > Note that the disabled flag is currently not used for anything other
> > than avoiding double disable, but it will be used for bailing out of
> > hooks once security_delete_hooks() is removed.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
>
> Reviewed-by: James Morris <jamorris@linux.microsoft.com>

You get an extra helping of gratitude James for being the only one to
properly trim your reply ;)

-- 
paul moore
www.paul-moore.com
