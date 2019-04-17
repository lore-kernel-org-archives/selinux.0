Return-Path: <SRS0=IDnY=ST=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D920C282DA
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 14:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352D2206BA
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 14:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="XqD4anXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbfDQOa1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:30:27 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46308 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732088AbfDQOaW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Apr 2019 10:30:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so22615780ljk.13
        for <selinux@vger.kernel.org>; Wed, 17 Apr 2019 07:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RuyB+W2pZ+QYBWd1eUaaacF+UuRg4xdSTEXA3oHZsgI=;
        b=XqD4anXLFYevMs1lRTyx2zcvCQubqkTY0PZtzr3CqPikpdNRZHVYUdC2GGYDSv5VPg
         WP7AOjjquBqxlihIVYE8Ypqmhww8GkwTIOFvHBaV1gZbcaUvBqkQgs6CUKIThv7mT9nM
         O9SiJhcvum1RY7z4u/fPT2Rx+OnWtc6EiEgWzmqnHEHvA+fJ/vJ4UtkcdUfdH01sFnx2
         2h5S1k5yplv9wpvVPXuwYWGr/lv6AE6PUhWlmvDk/RYEdzwF7uJ34XrUdoIuJKSoM2IP
         uKqyh/uuIjalzz3U+m+JazO2dcqKqch99mbK9AEfN143+E4lJE/yu5lmPpEbVWaFuQyw
         x3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RuyB+W2pZ+QYBWd1eUaaacF+UuRg4xdSTEXA3oHZsgI=;
        b=PGT6HOPKZrAfeNCpjMDsNbZCxryVB0zVqdPztSSQNlhXjJr/C0NNqbvxwY2WaLKJbR
         s208zsdEM1o3TPqTPJIZgNTTs5fxBTxzmA+8sXqpU0pj0a/tAkAArfYCk7Kc4v30Lrce
         9MEhoA9dnL/vagJBz4LnNKgGkerQbCfC+DnEDnsenQwathrWIvGIzrrpZC0bdnHeBJSg
         D2Ipv369wJpJLrEjowhOKvCohOkP/jI0nyYMbeJaCBqxQyuYMn7BSzVzbsJdHnQ7p8ht
         JXOBplKmhz7QXdcAU7Yugp+CPsBqMqUIVpDXPfT8KM60//zCtqlSq65rd1PtC/ENLoHu
         QPrA==
X-Gm-Message-State: APjAAAWPPi2Tpenjoaqz51Fn7uP2fiHINPJemx+7RWOCMznjncu+XGk4
        b78QF6Nq9R8yu1mjD0kkFFFYcVdDHYvU2TLQCHUL
X-Google-Smtp-Source: APXvYqxRX2PGOIrx7dxH9uSGpkYFbI6pJPfeVsyp3u9ILZZQnkg2xJwcGRdaU/hpbceypTXYTq6mSPH0Nbc8CBFjxXQ=
X-Received: by 2002:a2e:42cf:: with SMTP id h76mr46177693ljf.95.1555511420086;
 Wed, 17 Apr 2019 07:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <6e4428ca-3da1-a033-08f7-a51e57503989@huawei.com>
 <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com> <20190415134331.GC22204@redhat.com>
 <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
 <20190415150520.GA13257@redhat.com> <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
 <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com> <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com>
In-Reply-To: <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Apr 2019 10:30:08 -0400
Message-ID: <CAHC9VhSpnSpYLLOcFUFLM=UU8tUTLAzJYb2NgdbN-nLPrh=55g@mail.gmail.com>
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     "chengjian (D)" <cj.chengjian@huawei.com>
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
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

On Tue, Apr 16, 2019 at 10:46 AM chengjian (D) <cj.chengjian@huawei.com> wrote:
> On 2019/4/16 11:40, Kees Cook wrote:
> > On Mon, Apr 15, 2019 at 11:20 AM Paul Moore <paul@paul-moore.com> wrote:
> >> On Mon, Apr 15, 2019 at 11:05 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >>> On 04/15, Paul Moore wrote:
> >>>> On Mon, Apr 15, 2019 at 9:43 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >>>>> Well, acct("/proc/self/attr/current") doesn't look like a good idea, but I do
> >>>>> not know where should we put the additional check... And probably
> >>>>> "echo /proc/self/attr/current > /proc/sys/kernel/core_pattern" can hit the
> >>>>> same problem, do_coredump() does override_creds() too.
> >>>>>
> >>>>> May be just add
> >>>>>
> >>>>>          if (current->cred != current->real_cred)
> >>>>>                  return -EACCES;
> >>>>>
> >>>>> into proc_pid_attr_write(), I dunno.
> >>>> Is the problem that do_acct_process() is calling override_creds() and
> >>>> the returned/old credentials are being freed before do_acct_process()
> >>>> can reinstall the creds via revert_creds()?  Presumably because the
> >>>> process accounting is causing the credentials to be replaced?
> >>> Afaics, the problem is that do_acct_process() does override_creds() and
> >>> then __kernel_write(). Which calls proc_pid_attr_write(), which in turn calls
> >>> selinux_setprocattr(), which does another prepare_creds() + commit_creds();
> >>> and commit_creds() hits
> >>>
> >>>          BUG_ON(task->cred != old);
> >> Gotcha.  In the process of looking at the backtrace I forgot about the
> >> BUG_ON() at the top of the oops message.
> >>
> >> I wonder what terrible things would happen if we changed the BUG_ON()
> >> in commit_creds to simple returning an error an error code to the
> >> caller.  There is a warning/requirement in commit_creds() function
> >> header comment that it should always return 0.
> > Would callers be expected to call abort_creds() on failure? There are
> > a number of places where it'd need fixing up. And would likely be best
> > with a __must_check marking.
> >
> > It seems like avoiding the pathological case might be simpler?
>
> Yeah, Avoiding this pathological case is a better solution.

No arguments that this is particularly messed up scenario, I'm just
trying to arrive at a solution that isn't too ugly.

> From: Yang Yingliang <yangyingliang@huawei.com>
> Date: Sat, 13 Apr 2019 21:56:01 +0800
> Subject: [PATCH] fix cred bug_on
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   kernel/acct.c            | 3 ++-
>   kernel/cred.c            | 6 ++++++
>   security/selinux/hooks.c | 2 ++
>   3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/acct.c b/kernel/acct.c
> index addf7732fb56..f2065f899eee 100644
> --- a/kernel/acct.c
> +++ b/kernel/acct.c
> @@ -522,7 +522,8 @@ static void do_acct_process(struct bsd_acct_struct
> *acct)
>       }
>   out:
>       current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
> -    revert_creds(orig_cred);
> +    if (orig_cred == current->real_cred)    // [2]
> +        revert_creds(orig_cred);
>   }
>
>   /**
> diff --git a/kernel/cred.c b/kernel/cred.c
> index ecf03657e71c..c4d5ba92fb9b 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -522,6 +522,9 @@ const struct cred *override_creds(const struct cred
> *new)
>   {
>       const struct cred *old = current->cred;
>
> +    if (old == new)    //  [3]
> +        return old;
> +
>       kdebug("override_creds(%p{%d,%d})", new,
>              atomic_read(&new->usage),
>              read_cred_subscribers(new));
> @@ -551,6 +554,9 @@ void revert_creds(const struct cred *old)
>   {
>       const struct cred *override = current->cred;
>
> +    if (override == old)    // [3]
> +        return;
> +
>       kdebug("revert_creds(%p{%d,%d})", old,
>              atomic_read(&old->usage),
>              read_cred_subscribers(old));
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b5017beb4ef7..bc8108e4e90f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6590,6 +6590,8 @@ static int selinux_setprocattr(const char *name,
> void *value, size_t size)
>           goto abort_change;
>       }
>
> +    if (current->cred != current->real_cred)    // [1]
> +        revert_creds(current->real_cred);
>       commit_creds(new);
>       return size;

Doing the revert only to then commit the creds seems really ugly to
me.  I'm tempted to simply return an error in selinux_setprocattr() if
the task's credentials are not the same as its real_cred; if we do
that I believe we should resolve this problem.  The accounting write
to the SELinux file in /proc would fail of course, but I think we can
all consider that as a positive side-effect.

While I don't think this should have a negative impact on anything
else, I haven't convinced myself of that just yet.

-- 
paul moore
www.paul-moore.com
