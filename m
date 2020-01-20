Return-Path: <SRS0=4oDv=3J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EBEC33CA1
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 09:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA4D207FF
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 09:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOXsNW14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgATJyq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:54:46 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40630 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATJyp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Jan 2020 04:54:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so23531430lfo.7
        for <selinux@vger.kernel.org>; Mon, 20 Jan 2020 01:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ji1G0se5rOeh2K7xGrZ+W0ZIpmo4mF5P5Bk5zc6LT/w=;
        b=aOXsNW14uv9Hj/jhOQvoIqYeaiF/HMp+zJNsIg1clcIZrjEPGT6LcoXje9MvsuiLGy
         fVzPgmXErMSFyRJb0ZWMt3Rg70fprDhoqmcV7g69znv9BUVVU4rRg+Otdvyfjw7TfJqr
         nBUgYX+pmMW0LRNKzK2XOGwyUVzVnHrQNhZ3gIaEBZ9csQqrC2Ee3qh4QJl92HxNP5vK
         6bKOI8mr09z20sLpaLZXrHcB35s2aI2Nn6n0M2pSCvKa15XseGftX8T25vzhJDuo/CTW
         Bn2n/Tp2dGn8w/cOz/BK+4avlz0+TuGzp59mFGXSdkeaeTvCiOp31JrPuxs0EoVLyw7S
         eM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ji1G0se5rOeh2K7xGrZ+W0ZIpmo4mF5P5Bk5zc6LT/w=;
        b=mXwnLPtkBx92t95snbHNOHx99cqnUa/bWCimHMLvBcJ++lXKEo5F8b4z0kcb7LyQ7n
         o/gSMYpR5AZ0J4TkVMK4xZpvyYgggH+p1WcHSyYrmTNJvPPXtXUCXXBt0ycuJXtZYT54
         rQsOUbTrqZE64pLJrN6qJgly0I8cjAnmD5VCPp9L9jGuFLfMkamBEkMRxznIZpEk08H2
         wmbtlKWy9Go/lEmpMbzCU68Vg6rsRd44A1eLWcdeek4crTW3kqVQbXuvA5bUR+Vj7nu4
         ZJvDKE46NCbAVoRC1To5dMAStj324hnA8l3ckM93NLtdENVUz+TAgbkJX4w4hFJ3U/PT
         EyFg==
X-Gm-Message-State: APjAAAXa42+YjkYOt3Xej2M+Nli5lGiNBPyhIKuHi/d45Gddz7jdeMde
        pglFYZdUAfmt7lX3xEKDi2HeiPsSn/7a+jmqpsFHZzfO
X-Google-Smtp-Source: APXvYqw8EOt4dyC0T/zZcm9il9qNy8d53nqDGKh7MMOj/CuQJwzJnRYeYHkE0RJPfGFWJXLcvB7WPAA/Nf/hW8Yxgl0=
X-Received: by 2002:a19:2351:: with SMTP id j78mr1554009lfj.173.1579514083600;
 Mon, 20 Jan 2020 01:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20200116142653.61738-1-jeffv@google.com> <CAHC9VhRSUhozBycHMZcMaJsibJDxNMsTsKVT2zOnW=5H4R4mdg@mail.gmail.com>
 <CABXk95B77UXxhiG3=xRmJmG5c7knoF2pbdpweskreftggZzkUQ@mail.gmail.com> <16fb415d3d8.27e8.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <16fb415d3d8.27e8.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Mon, 20 Jan 2020 10:54:32 +0100
Message-ID: <CABXk95CQxaqw=nq8FcG70n0RdozX-SsHNr1yQKfh3=FqPfeB0g@mail.gmail.com>
Subject: Re: [PATCH] selinux: map RTM_GETLINK to a privileged permission
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

OK. I'll put something together, but it'll be in a couple of months.

On Fri, Jan 17, 2020 at 4:19 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On January 17, 2020 3:21:10 AM Jeffrey Vander Stoep <jeffv@google.com> wr=
ote:
> > On Fri, Jan 17, 2020 at 1:32 AM Paul Moore <paul@paul-moore.com> wrote:
> >> Our current handling of netlink messages is rather crude, especially
> >> when you consider the significance of the netlink messages and the
> >> rather coarse granularity when compared to other SELinux object
> >> classes.  I believe some (most? all?) of this is due to the number of
> >> netlink messages compared to the maximum number of permissions in an
> >> object class.  Back when xperms were added, one of the motivations for
> >> making it a general solution was to potentially use them for netlink;
> >> we obviously haven't made the change in the netlink controls, but I
> >> think this might be the right time to do it.
> > That's a very large change with some unanswered questions - like how to
> > handle
> > generic netlink. I will have time later this year to make that change.
> >
> > In the meantime, this change is small (ideal for backporting) and
> > consistent with
> > how we differentiate between levels of sensitivity on netlink_audit
> > messages.
> > Would you consider taking v3 of this change with your suggested adjustm=
ent
> > to
> > selinux_policycaps_init()?
>
> Yes, it is a big change and there are some open questions, but both of th=
e changes we are discussing here are exposed to userspace so there is a nee=
d to make sure we get this as right as possible the first time.  I am not a=
 fan of exposing a change to userspace knowing that we will be replacing it=
 in the future.
>
> If we need to update the netlink controls, and I think we do, let's do it=
 properly and not one message at a time.
>
> --
> paul moore
> www.paul-moore.com
>
>
>
>
