Return-Path: <SRS0=IDnY=ST=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C77C282DA
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 15:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DFF20835
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 15:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="tQ4w3HaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbfDQPlG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:41:06 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41315 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732775AbfDQPlD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Apr 2019 11:41:03 -0400
Received: by mail-lf1-f65.google.com with SMTP id t30so19222946lfd.8
        for <selinux@vger.kernel.org>; Wed, 17 Apr 2019 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rq83qqDgPSIYQekPM6XsUCWIuA2bW1sMvSnNQ0r8hM4=;
        b=tQ4w3HaJHMstWggmB8MMrcdLefmY8RjcX421/gXcEmtHs6fv7sjbFyI+BkKkkxwfZj
         Axu6SkvM/suKancjl2itfvoQXjvr1hml7HnzebK8advEQp6hhpep20yeqx/MG2Kn+aUl
         L7eNQTzo4+HdEUOIpKvRNEFf67P633l0prnKfHI96qfYoqLoJnpEfwg/WkixWfdRd2UV
         omlRnX1KFiG9B0kICK2Uq/ECAENYHKP3PvJiPPEcchT7aSUzDnvJNG1UY5yKNqka4kBs
         maajRY0ekPm3tlpy1ibliVenixi77fwZ2h8LawZdua96OoJYCtYksqSUAH8NXF7IEri7
         Z6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rq83qqDgPSIYQekPM6XsUCWIuA2bW1sMvSnNQ0r8hM4=;
        b=JtNDPrh89Yx1Y3yZFIxJsHzGp7TGCkSeJNZfyoGPnftgTVYwFdvKvfnY630pqe1euN
         adGuZ5mnt0k93rXaXGWcj5oTcwi+cYBGCoEQMh/I7n/W8jlw0mLYGSM7RgABUwCF9fzm
         LSlb76FGyRum4ArIeRpTGSp2mxUyuIIsS9jboct+Hsp6c9FxdQ+PVjpDlfyUuqh1t4VU
         rJeeNYcPpssx7L8gXP/l8+enlclk6xFUvbfpJl3wi2tsBdcWniKsGKs2N4RK6t5tER0S
         jEhVZIS6L0R4WwVpOeyyas9KVPKNBJJFgP/Je2OpoTlqz2XAuM+4fqUB6g61uFcIZDgG
         qPqw==
X-Gm-Message-State: APjAAAUQUH5utHnc8qs/c7QhWGgWaDrReV4gkm5P6oZSVPGQ2Wl6EtN7
        IPABRfbQK2Jw1vmgx73GLYB0rEoC4hqLHvBpL6Zi
X-Google-Smtp-Source: APXvYqx6RzmK2bTROVnmkUeQxjEM5Cs1fpJhsuGkXxzA4/peu/pNT2+Dh3jiN+1/ycJhKy9qCg1wGzq5nYnIk6ijGKE=
X-Received: by 2002:a19:ee11:: with SMTP id g17mr48494329lfb.117.1555515660485;
 Wed, 17 Apr 2019 08:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <6e4428ca-3da1-a033-08f7-a51e57503989@huawei.com>
 <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com> <20190415134331.GC22204@redhat.com>
 <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
 <20190415150520.GA13257@redhat.com> <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
 <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
 <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com> <CAHC9VhSpnSpYLLOcFUFLM=UU8tUTLAzJYb2NgdbN-nLPrh=55g@mail.gmail.com>
 <20190417145711.GI32622@redhat.com>
In-Reply-To: <20190417145711.GI32622@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Apr 2019 11:40:49 -0400
Message-ID: <CAHC9VhSzo4DsMRknOA-4KKYJEir0wW74+quLheTjRw94OmhscA@mail.gmail.com>
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "chengjian (D)" <cj.chengjian@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        NeilBrown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SELinux <selinux@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 17, 2019 at 10:57 AM Oleg Nesterov <oleg@redhat.com> wrote:
> On 04/17, Paul Moore wrote:
> >
> > I'm tempted to simply return an error in selinux_setprocattr() if
> > the task's credentials are not the same as its real_cred;
>
> What about other modules? I have no idea what smack_setprocattr() is,
> but it too does prepare_creds/commit creds.
>
> it seems that the simplest workaround should simply add the additional
> cred == real_cred into proc_pid_attr_write().

Yes, that is simple, but I worry about what other LSMs might want to
do.  While I believe failing if the effective creds are not the same
as the real_creds is okay for SELinux (possibly Smack too), I worry
about what other LSMs may want to do.  After all,
proc_pid_attr_write() doesn't change the the creds itself, that is
something the specific LSMs do.

-- 
paul moore
www.paul-moore.com
