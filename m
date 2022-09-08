Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F13C54EE9
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 13:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiIHNlk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 09:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiIHNlh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 09:41:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94441ED3B2
        for <selinux@vger.kernel.org>; Thu,  8 Sep 2022 06:41:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z17so10047583eje.0
        for <selinux@vger.kernel.org>; Thu, 08 Sep 2022 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=O03TMllftMecE1kSiTdOfb+znaTQrAaLfpgIm5o8zqI=;
        b=E0m0huzlBtVTPXzaAmMDjvVQ+Xwtf7bAuitrXyL1mg2FVQ2LfMU+lpkCj/ZjNGlMdM
         ILQcfdMR9xBmyy/9nUknw5ZX4XC7XbzJLM10cW84lJXC1HB94PCPM1WoTOcLZA2Oj+Cy
         oPz5kRBqhqmMsPSyOQUzck1gr+fmCmU6ubjGv7ud+elUcySiXmoK0gATRtNUwnVcu4wv
         cRQZcMvyiUM85ZXrj72VmkARD6qtOhc4gNvZxJ4QCxji2OIu4M5sRn7HmgrHfxjTFq0F
         JQw7moAPOusNpAvb0IwCAIv4oueM3OhJlKprC9V+TsIhAyV1YSF+urxgm0gbcC5BUE6s
         w6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=O03TMllftMecE1kSiTdOfb+znaTQrAaLfpgIm5o8zqI=;
        b=Glh8SXvPtjsOJscBHV1MzPf5hguffseLQN4apBiTpo7Cqx/beXDx877ArZ8Y3Rxr92
         a2JsgIFrBim3SbWpXgd1Bkn/MOI6JMbpwyN9UOdY8pW0S6djA5R9l7V4tyBdVFDHwV28
         CiAmoH6LPjl65OQVAQylZNWfGE6ZlnnnQ/gfD2UXCBPDsstIrgcoppYduWdHVRaEv+s8
         kFlm7qlQsOG48/OnT5t191T2Ne+HX0XngGoBlU26ZGH/ZYqQIr4OZSDlu3hbUmynrF8P
         PqDq3w9rw51ZbLQ2lTEQmZndzdYIT+As6DcA775S24KoxKrclp8yAwCJFHRVhe6/6eir
         9jqg==
X-Gm-Message-State: ACgBeo2/kgvwGgk4sa32tK/Qj+foCB+RhOQ98aPth1W1HUPEF743+X9z
        BObck49roQyudlN0OWEiuM7h0jjhs4Hck1Ksp7o4lC+9
X-Google-Smtp-Source: AA6agR7hbQYe+qC1AW0wvwBl6F32ksBQEoXlFrVt4RD9JvcUgCjvHmXg+1bsqw+8xlq8c6a3mk83+X+bU6WE/fOfi2o=
X-Received: by 2002:a17:906:594f:b0:770:866c:b77c with SMTP id
 g15-20020a170906594f00b00770866cb77cmr5277224ejr.508.1662644494066; Thu, 08
 Sep 2022 06:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
 <CAHC9VhRWwwxB=8De88_MdMS2ncEgP9dqX6hH1ao_zrJeRE_ndA@mail.gmail.com>
In-Reply-To: <CAHC9VhRWwwxB=8De88_MdMS2ncEgP9dqX6hH1ao_zrJeRE_ndA@mail.gmail.com>
From:   Ted Toth <txtoth@gmail.com>
Date:   Thu, 8 Sep 2022 08:41:22 -0500
Message-ID: <CAFPpqQFJYz79tFEanv1F2busJJzMw+DSe6Ba0qhoAkiTH9OSZg@mail.gmail.com>
Subject: Re: context of socket passed between processes
To:     Paul Moore <paul@paul-moore.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 7, 2022 at 5:46 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Sep 7, 2022 at 4:19 PM Ted Toth <txtoth@gmail.com> wrote:
> >
> > systemd uses a helper process (sd-listen) to create sockets and pass
> > their fds back to its parent. I've patched systemd to call semanage to
> > get the context for the port if it exists and create a context using
> > the returned type when calling setsockcreatecon.
>
> This obviously depends on how you structure and write your policy, but
> I don't think you want to use a port type directly as a socket type.
> I think we talked about this a little in the other thread, but for
> bound/listening sockets maybe you could do a transition for new child
> sockets based on the listening socket and port types.

To be clear you are suggesting to call setsockcreatecon with the port
type but also have a transition rule to transition the port type to a
socket type?

>
> > Everything looks
> > right i.e. the port type is retrieved, the context is created and
> > setsockcreatecon is called without errors. However 'netstat -Z' shows
> > the listening sockets type as init_t and not the type in the
> > setsockcreatecon call, is this the expected behavior? Can anyone help
> > me understand why this is happening?
>
> You're calling setsockcreatecon() before you create the listening
> socket, right?  I wouldn't expect this to work properly if you create
> the listening socket and then call setsockcreatecon() hoping to have
> the new label applied to the new child sockets.

It's not my code  ;) the systemd sd-listen process code does the
setsockccreatecon, bind and then listen.

Regarding how to get the port context, what would you suggest?
Currently I'm calling semanage functions but have considered using the
sepol instead.

>
> --
> paul-moore.com
