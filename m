Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B04C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 20:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CDC205F4
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 20:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="c38SvAdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgAJUVs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:21:48 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41240 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgAJUVs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 15:21:48 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so3407574ljc.8
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 12:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yLQzw93HlFRviBArrYyOpwzYNVdXPIbSagU7ITmK9s=;
        b=c38SvAdvl5MAfXJDwFU2V+RiTubIzBd2TjNeAJqMhTvspaEe7WGd55Y3cOMbOU+h4H
         Db+eLJDBIqHJtMEB2fF0knHiqr5KcUU5wCVCZ0LJjqGMufJ5FGF+/eT4TWaEs/C9W3Cs
         ZmDd8VbrdkBHPOm7AqXSzr/7CHyViM47H4cXTR+cNagHUkeNL1R+3F5ZYwOvHlhAd4KM
         XV0UqrUHF5pDgEAfsVOZdZuGA8988z4IppY3sVlrTJgt1eH3ZBlokZ78NHfasfplUb9A
         ccKOW4rmVXsKKHtaQXFU1SAgmpAu+Xj3n6720CJ348XhpS1RqYKd8m7M3wUZ/2CS47m2
         DHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yLQzw93HlFRviBArrYyOpwzYNVdXPIbSagU7ITmK9s=;
        b=BtzNoCC1fIgmB3OuW9cOM4jFUucHiQ9WCbC2O3wSZ+86YQOuEIMeDDu1FWNw2+90x/
         b+pkyIXTLNhMi2XjpG4ivg0PiQjvaz/8kURPez3zmq0ZU6BoSRFantYcc4zMgmlhgk0m
         rX80daCCvlrVtOEaBrZqnedFLk567kXoJO+PtkJwJH5Oi2enBjXEo6xSID6Hpi5YVCmb
         pxQu6rWqpfEwviiQCR4MtAWMFnqRrm4bCFw+mawe+o2QgDNbIpKf7SYyIRHJLFI2toVF
         l2M+rdn3EsppafN+mqK/GQcxrTddOPFipSxONtTlPYKO007lOibrzbKrY8rKVkn08qSK
         8F0g==
X-Gm-Message-State: APjAAAWCWBxwxSgAM835UtXF6LMIr+/yzTaRZCyojXKZvI6qeY97E1ou
        GnxfXaO9QaD99a/GDTYk52qA7VRQZt4jj5XM/Let
X-Google-Smtp-Source: APXvYqzdxdZN/CE1UMUF3qE36RvSxD+f6Rn1i6mtmQ4ixgyTfIlH7BQru54RYoZTyn6ZQmfrlFWJlcqeo37GqR747pU=
X-Received: by 2002:a2e:9f52:: with SMTP id v18mr3547382ljk.30.1578687706327;
 Fri, 10 Jan 2020 12:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20200107133154.588958-1-omosnace@redhat.com> <20200107133154.588958-2-omosnace@redhat.com>
In-Reply-To: <20200107133154.588958-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jan 2020 15:21:35 -0500
Message-ID: <CAHC9VhSu3Nt8JEQW-WOVwGnzsKy1o4uj=FkoVXaa-qQaRoJ85w@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: treat atomic flags more carefully
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
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

On Tue, Jan 7, 2020 at 8:32 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The disabled/enforcing/initialized flags are all accessed concurrently
> by threads so use the appropriate accessors that ensure atomicity and
> document that it is expected.
>
> Use smp_load/acquire...() helpers (with memory barriers) for the
> initialized flag, since it gates access to the rest of the state
> structures.
>
> Note that the disabled flag is currently not used for anything other
> than avoiding double disable, but it will be used for bailing out of
> hooks once security_delete_hooks() is removed.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c            | 21 ++++++++--------
>  security/selinux/include/security.h | 33 +++++++++++++++++++++++--
>  security/selinux/ss/services.c      | 38 ++++++++++++++---------------
>  3 files changed, 61 insertions(+), 31 deletions(-)

Merged into selinux/next, thanks Ondrej!

-- 
paul moore
www.paul-moore.com
