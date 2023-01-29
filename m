Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92841C61D97
	for <selinux@archiver.kernel.org>; Sun, 29 Jan 2023 19:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjA2ThI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 29 Jan 2023 14:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjA2ThH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 29 Jan 2023 14:37:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4941ABE9
        for <selinux@vger.kernel.org>; Sun, 29 Jan 2023 11:37:06 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s3so9124299edd.4
        for <selinux@vger.kernel.org>; Sun, 29 Jan 2023 11:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LjNRdZwxkRJ0vFdsmq2ag31ZmCitajaeBu6nMn3bMFw=;
        b=T3mtI/b1brIeEiv5kwKymJvI/OjLOLsGoBC4tFkU4G6xxgFbjmQxuUDM+FrAG6+VGY
         Lu6ttQ9dIxivczYfaCeGRaksIhQxI0yjM7H5556hi+BIURa+M09Kxc2BRODJJ9N5xCEp
         5kECE6w2Yo90zEzJo6Pz7vNuwb2DQLwmmWuZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjNRdZwxkRJ0vFdsmq2ag31ZmCitajaeBu6nMn3bMFw=;
        b=OWjectrGNQnNFkB9tGzR2bMSf/poULnYS5J/uOSf0cB/E49k7xEedaNQVnK2XIWRIq
         ziYkrIfcWTcfqhXtX2jUosQZeTGeBQyt75avqTVYFzKldmVu9z3HQ6aaNFKbAOnzAsTJ
         q4n9qBGdZK8pYskhf0UH8l2AzcVNtBitbRw5h1RDhQVHVMI22F7GGlvUbXgKAckNcbX4
         Mjq78LXp/oFXvUzFobXtGdfa5c+eK4x4It+1Cr5FcTvvKnNYnVZWh+onwyiRS8cARgnx
         mlKUluoS66tejIYQYaLZ6PcPiVzTKrUTnHKDJGKnAyTnh/96SqQC1EvwmoO4AYhEQl5f
         45nQ==
X-Gm-Message-State: AO0yUKXKhkFES6fhPfCQFnUH8DNsRK+mq1gvNaG8UqQfpKh8fBLkfP4H
        vWNfSEXxBecr0NnYHifZ/0lu9BmMbumTLR/tSTg=
X-Google-Smtp-Source: AK7set/4BYrpdch3W+UYaCMlQd1b9D7a5Uy/nR+hsH+XhbIsRtUY1pFYm3TepiYJ2c+TeM0oHU2WFQ==
X-Received: by 2002:a05:6402:344f:b0:4a2:4485:2930 with SMTP id l15-20020a056402344f00b004a244852930mr2267653edc.14.1675021024350;
        Sun, 29 Jan 2023 11:37:04 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id sh39-20020a1709076ea700b007b4bc423b41sm5705482ejc.190.2023.01.29.11.37.03
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 11:37:03 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id k4so20942943eje.1
        for <selinux@vger.kernel.org>; Sun, 29 Jan 2023 11:37:03 -0800 (PST)
X-Received: by 2002:a17:906:add6:b0:878:51a6:ff35 with SMTP id
 lb22-20020a170906add600b0087851a6ff35mr3351150ejb.43.1675021023550; Sun, 29
 Jan 2023 11:37:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whR4KSGqfEodXMwOMdQBt+V2HHMyz6+CobiydnZE+Vq9Q@mail.gmail.com>
 <CAHC9VhR1jRM2K0757sNYS8VvSUxRWOKUJ1unbsZm9LOEM3Up6Q@mail.gmail.com>
In-Reply-To: <CAHC9VhR1jRM2K0757sNYS8VvSUxRWOKUJ1unbsZm9LOEM3Up6Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Jan 2023 11:36:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=whLndwMFSF_OAWdqxXYXUev_H9YqEkXQ1_PKoPO8u=G2g@mail.gmail.com>
Message-ID: <CAHk-=whLndwMFSF_OAWdqxXYXUev_H9YqEkXQ1_PKoPO8u=G2g@mail.gmail.com>
Subject: Re: Looking at profile data once again - avc lookup
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jan 28, 2023 at 2:33 PM Paul Moore <paul@paul-moore.com> wrote:
>
> I'll take a look, although just a heads-up that I don't generally
> merge patches into selinux/next at this point in the -rc cycle unless
> they are bug fixes, or some other critical patch; it's likely this
> will need to wait until after the upcoming merge window closes.

Yeah, that patch was not some kind of "please apply this urgent fix",
more of a "I'm looking at path walking again, and the selinux code is
more expensive than the *actual* path walk is" heads up.

> > Comments? Is there some case I've missed?
>
> You're correct in that selinux_state parameters currently always point
> back to the single global instance, however there was, and still is, a
> point to that patch ... although I will admit it is a long time
> coming.

Honestly, considering that the selinux code is literally more
expensive than THE REAL WORKLOAD it is checking, I really want people
to take a second look.

If some new feature makes that crazy-expensive thing *worse*, we have issues.

If it's been that way for five years with no progress, and no clear
indication that it's even some high-priority issue that lots of people
are asking for, maybe that should be a big hint.

                 Linus
