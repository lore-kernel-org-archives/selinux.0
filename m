Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6D0C433DB
	for <selinux@archiver.kernel.org>; Sat, 20 Feb 2021 14:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB30664EE0
	for <selinux@archiver.kernel.org>; Sat, 20 Feb 2021 14:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhBTOmj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 20 Feb 2021 09:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhBTOmi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 20 Feb 2021 09:42:38 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296F2C061574
        for <selinux@vger.kernel.org>; Sat, 20 Feb 2021 06:41:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z22so15821230edb.9
        for <selinux@vger.kernel.org>; Sat, 20 Feb 2021 06:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcMXzHETlziskFHmDJ+qkZLeneeQpeM7XNw3uJBtD+c=;
        b=zk0Biby6NMxEZ6ecW0PWpgn8ZAopV4xiduHkt5Y+g3jLy3ocDGq+UmmxovqEVr5Vuu
         WuFDzXipTa6VtxmlSQXVdRfkRKHHhQSI6y6wxob9XH0u4hkWEqF2m1VsdO1PiR7p4esk
         a007+B5AkQjVjRwe3u/D1kjwTDTxhi336ukxIr3f78nhvjgy+Y4x1EL+mgw1G+RruO6W
         fK6vmqOsRvYwbcmUefiudl0G7zYN5CSWWfdRDOnHdjiYhygTd+HjLdrmzBCpeIHarsDn
         4rxU2yJCssHDB18gLnYebSjl8zQB+JVEWR6Ek+tLGlQ7KsTvvsTrQ5m8BD2AlmWVYdfY
         wnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcMXzHETlziskFHmDJ+qkZLeneeQpeM7XNw3uJBtD+c=;
        b=VUVZ6WsA5Ksg1bCDvXrGnLPvz5AisGRKbG+078PksvsBkejROZUNOZzHQKru6JARlg
         4EI/t332xi6fqPBJl1/+nNHbovUM+7CprrW4FjKZPIGksw8xxbDIWEwTSHJuJOQfU7gG
         Ewpb6JBPi0mDT7unBZvEB92TtH+2ndJ1Rpl0kU2ocM0LnlBV5HbX0oqHnAXe9Bu4rABG
         2MiKYNAbhFVhwWT7bzIy2R8XPz3MaQMgQ1zGwqGrTrQck5b2GtqL0zN3H+amUxu0J0Id
         QvEjXYEAhV1fzofdUhTrXptDJ0D6o7NLnEMJ1NT7L6mreIWdgX9WoYIduIEjRNIXOSIT
         Rhgw==
X-Gm-Message-State: AOAM530S1OjbwhCq11Wy3TM6FZxvz7+4jtWI4fFP53CwckqqfRcqMDbj
        zGE79fjKA9VXUUB4HhU8PqJTfiU9IDxiIk/xLLIM
X-Google-Smtp-Source: ABdhPJxxLAZLt/puGXEZyNivaEvDVegaTzTNADNqggY/6U73kUDTWgCF0vyCCU1n+fkOfxsvgqCtQWMRbxJG7KkTEHs=
X-Received: by 2002:aa7:df0a:: with SMTP id c10mr14279765edy.12.1613832115287;
 Sat, 20 Feb 2021 06:41:55 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl> <9ea5259b-fd84-e176-c042-c52a1c4fcc27@schaufler-ca.com>
In-Reply-To: <9ea5259b-fd84-e176-c042-c52a1c4fcc27@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 20 Feb 2021 09:41:44 -0500
Message-ID: <CAHC9VhQBbep2WkD6JkCemtcXFLq7j5=AQeM9vVJ4_gmvi7hPQA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Split security_task_getsecid() into subj and obj variants
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 19, 2021 at 8:49 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/19/2021 3:28 PM, Paul Moore wrote:
> > As discussed briefly on the list (lore link below), we are a little
> > sloppy when it comes to using task credentials, mixing both the
> > subjective and object credentials.  This patch set attempts to fix
> > this by replacing security_task_getsecid() with two new hooks that
> > return either the subjective (_subj) or objective (_obj) credentials.
> >
> > https://lore.kernel.org/linux-security-module/806848326.0ifERbkFSE@x2/T/
> >
> > Casey and John, I made a quick pass through the Smack and AppArmor
> > code in an effort to try and do the right thing, but I will admit
> > that I haven't tested those changes, just the SELinux code.  I
> > would really appreciate your help in reviewing those changes.  If
> > you find it easier, feel free to wholesale replace my Smack/AppArmor
> > patch with one of your own.
>
> A quick test pass didn't show up anything obviously
> amiss with the Smack changes. I have will do some more
> through inspection, but they look fine so far.

Thanks for testing it out and giving it a look.  Beyond the Smack
specific changes, I'm also interested in making sure all the hook
callers are correct; I believe I made the correct substitutions, but a
second (or third (or fourth ...)) set of eyes is never a bad idea.

-- 
paul moore
www.paul-moore.com
