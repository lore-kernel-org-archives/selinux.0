Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F90C433EF
	for <selinux@archiver.kernel.org>; Tue, 26 Apr 2022 18:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353649AbiDZSGY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Apr 2022 14:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353604AbiDZSGX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Apr 2022 14:06:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0673627CEC
        for <selinux@vger.kernel.org>; Tue, 26 Apr 2022 11:03:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u3so26584048wrg.3
        for <selinux@vger.kernel.org>; Tue, 26 Apr 2022 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+onuqX07NQLVnhG5hcq84PDJSKTGZ1KYCLEC+GQraSM=;
        b=g9bTjXUuVtqu1ley+eg3MvLbTvaYERrW5DcPicHR1kWNztwsyfpkcmbfZfHxABsFEg
         BVECFAUSQ9C//qUwXLRfuDlS0cyxk5b4cUZjKfeJ+Ficd/SCYht0Z5/7Qjw5F92uETD4
         W6PK89d0AnfnmFotKNSOfuyhYT3FTq2C9k5suv0XrHigSwB2KhAz3T+lcqNyl81W1NMk
         0F/9/3+MN7KCB3ETbGL1FeZbFzTTc70LjoPM8DwCwaPx+q+akt57kCMz6ivxKwRExdPG
         TxmSUhaNMXlfVjkeyaQHPVs/8m60zXsizWZsE/3vt/c/CXm23lSqE4zdSxOczOEOth03
         1gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+onuqX07NQLVnhG5hcq84PDJSKTGZ1KYCLEC+GQraSM=;
        b=NE6q3E3acxXGwOK9p3oIJLNbXEUt0RHO5WKMHzrquQ/Bekz4B2R/cauXrwW/RCkvgi
         NRfzthDsgRHxfZHy+8zqOOV1UWKdayi0goS9oGJtoVG5CTPlRsIjo1Aq2AV/6NOONefb
         io4JQbICbqZU8EMXR5mrAe76M7SltA0C9Ce5MndCKtr4Sl9p5hHtDXA5bnqIo/+7zK14
         rMcAgr22NYrHwuDzDfQIXa827sB8HmkTl0VLbd59wdpk1jUQj9cciUtIfxzUSCMzF9j8
         obSbNSjv85F+NpUTNOx1vdkoAFaakt9MXd4GN7c8NaPl3XQqE/yOhpbOoEra4eDTHPbo
         5b4Q==
X-Gm-Message-State: AOAM530mCz4dynFCqQC6zuKfzhn/7AMkt0zgHrwrRmsKaZBY+E3Nf9gq
        8MJmT16PGMPlOetpb7aWe+w56hGqT4FLavVmg4uW
X-Google-Smtp-Source: ABdhPJzvaHhm+gDkGIU/mLn3si/S7ZnD78mhxMStriKTtPLrrYOnHwrB/NGl572b3NM4JieS55hPLJOhkmHdpCMJq1E=
X-Received: by 2002:a5d:590d:0:b0:20a:c3eb:2584 with SMTP id
 v13-20020a5d590d000000b0020ac3eb2584mr18627797wrd.18.1650996193497; Tue, 26
 Apr 2022 11:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com>
 <20220418145945.38797-24-casey@schaufler-ca.com> <a1702622-5980-1eb4-1cf8-b6fc6cd98b25@canonical.com>
In-Reply-To: <a1702622-5980-1eb4-1cf8-b6fc6cd98b25@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Apr 2022 14:03:02 -0400
Message-ID: <CAHC9VhRzJKAARW1rnUMu0Y6RVo_uq=i=Jzh4LmA9grtQ1W2C1Q@mail.gmail.com>
Subject: Re: [PATCH v35 23/29] Audit: Create audit_stamp structure
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 25, 2022 at 7:31 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 4/18/22 07:59, Casey Schaufler wrote:
> > Replace the timestamp and serial number pair used in audit records
> > with a structure containing the two elements.
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > Acked-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  kernel/audit.c   | 17 +++++++++--------
> >  kernel/audit.h   | 12 +++++++++---
> >  kernel/auditsc.c | 22 +++++++++-------------
> >  3 files changed, 27 insertions(+), 24 deletions(-)

...

> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index 4af63e7dde17..260dab6e0e15 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -108,10 +114,10 @@ struct audit_context {
> >               AUDIT_CTX_URING,        /* in use by io_uring */
> >       } context;
> >       enum audit_state    state, current_state;
> > +     struct audit_stamp  stamp;      /* event identifier */
> >       unsigned int        serial;     /* serial number for record */
>
> shouldn't we be dropping serial from the audit_context, since we have
> moved it into the audit_stamp?

Unless we make some significant changes to audit_log_start() we still
need to preserve a timestamp in the audit_context so that regularly
associated audit records can share a common timestamp (which is what
groups multiple records into a single "event").

FWIW, I'm working on some patches which will make a lot of this better
in the future, but they aren't ready yet and would almost surely land
after the stacking patches.  Audit will get better at some point in
the future, I promise :)

--
paul-moore.com
