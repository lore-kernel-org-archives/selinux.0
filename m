Return-Path: <SRS0=zdOf=SS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355FFC10F0E
	for <selinux@archiver.kernel.org>; Tue, 16 Apr 2019 03:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0069D2064B
	for <selinux@archiver.kernel.org>; Tue, 16 Apr 2019 03:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LohpepcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfDPDlI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:41:08 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44671 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfDPDlI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Apr 2019 23:41:08 -0400
Received: by mail-ua1-f65.google.com with SMTP id p13so6247564uaa.11
        for <selinux@vger.kernel.org>; Mon, 15 Apr 2019 20:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=knJ4ZxxYb6J3GKaV7EwaY4sfVnSPjwGvsgjyVKDi2yY=;
        b=LohpepcYBAREZDvlv6AnI67BSEa7If74Bl7iwNw4t+8mv+LJGn/2f9zGdljkXp6wEE
         VFUBltaB9DOThRYuNwGgdKMWPh8P35D9yUle6LTv1Lpx1odF/gQU6g0iCAr0zw3OgK16
         h9O2GQkjc+xEACfn0XkQFCeOpLY+IpyNw0a6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=knJ4ZxxYb6J3GKaV7EwaY4sfVnSPjwGvsgjyVKDi2yY=;
        b=Jpz2xhA7NNJR4i4U329WzYRiGbZRx40D44LGs3+cvfDBCN4VglXFT14/ovVxJkjoa1
         94LrCiiVb4vifHdi/NlI53PiVeJeTqlOItN889JucJxxg46Pkx7dRdDY1gVViYQmZkiT
         4D8Ya9xek/8EpSBcq5W9jqlHn6UIuUJdLTd9IH3Pf+8ZU0COUERsCyrGPgL+5J+hm435
         ud1plrTm+wRL4qdhHrifQHyVIsKng5FSOykhVsDIuqLQmNquNcD+oi419Uz/ZgWNwSZa
         sSJA/EaeCR78i4OIWzUSpJsZs/oFbzEs4utgD0g8l0mydWBSuWMAlxaSyua4yeaMj0lP
         7ZTA==
X-Gm-Message-State: APjAAAVXWKdiqaJIPb+uLfuPAPCr/jKl95E8qko/eYswUuavztM5rEwd
        51xbo6KV9H5BpOO2FwZERHWTbQw2Ljo=
X-Google-Smtp-Source: APXvYqzzxzqnv7FyZ4yW7/T0QLNt5vWvlpIi2xbvkPoDgBHf74ueD5Zjy2KhkQagytUkImadXxpTTw==
X-Received: by 2002:ab0:6994:: with SMTP id t20mr31299702uaq.105.1555386066500;
        Mon, 15 Apr 2019 20:41:06 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id l15sm6674263vsq.22.2019.04.15.20.41.05
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 20:41:05 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id t78so10744090vsc.1
        for <selinux@vger.kernel.org>; Mon, 15 Apr 2019 20:41:05 -0700 (PDT)
X-Received: by 2002:a67:f04e:: with SMTP id q14mr43589866vsm.133.1555386064658;
 Mon, 15 Apr 2019 20:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <6e4428ca-3da1-a033-08f7-a51e57503989@huawei.com>
 <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com> <20190415134331.GC22204@redhat.com>
 <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
 <20190415150520.GA13257@redhat.com> <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
In-Reply-To: <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Apr 2019 22:40:52 -0500
X-Gmail-Original-Message-ID: <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
Message-ID: <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     Paul Moore <paul@paul-moore.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "chengjian (D)" <cj.chengjian@huawei.com>,
        NeilBrown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 15, 2019 at 11:20 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Apr 15, 2019 at 11:05 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > On 04/15, Paul Moore wrote:
> > >
> > > On Mon, Apr 15, 2019 at 9:43 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > Well, acct("/proc/self/attr/current") doesn't look like a good idea, but I do
> > > > not know where should we put the additional check... And probably
> > > > "echo /proc/self/attr/current > /proc/sys/kernel/core_pattern" can hit the
> > > > same problem, do_coredump() does override_creds() too.
> > > >
> > > > May be just add
> > > >
> > > >         if (current->cred != current->real_cred)
> > > >                 return -EACCES;
> > > >
> > > > into proc_pid_attr_write(), I dunno.
> > >
> > > Is the problem that do_acct_process() is calling override_creds() and
> > > the returned/old credentials are being freed before do_acct_process()
> > > can reinstall the creds via revert_creds()?  Presumably because the
> > > process accounting is causing the credentials to be replaced?
> >
> > Afaics, the problem is that do_acct_process() does override_creds() and
> > then __kernel_write(). Which calls proc_pid_attr_write(), which in turn calls
> > selinux_setprocattr(), which does another prepare_creds() + commit_creds();
> > and commit_creds() hits
> >
> >         BUG_ON(task->cred != old);
>
> Gotcha.  In the process of looking at the backtrace I forgot about the
> BUG_ON() at the top of the oops message.
>
> I wonder what terrible things would happen if we changed the BUG_ON()
> in commit_creds to simple returning an error an error code to the
> caller.  There is a warning/requirement in commit_creds() function
> header comment that it should always return 0.

Would callers be expected to call abort_creds() on failure? There are
a number of places where it'd need fixing up. And would likely be best
with a __must_check marking.

It seems like avoiding the pathological case might be simpler?

-- 
Kees Cook
