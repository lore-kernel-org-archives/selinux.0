Return-Path: <SRS0=RjX6=SZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECF5C282DD
	for <selinux@archiver.kernel.org>; Tue, 23 Apr 2019 20:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1F9218B0
	for <selinux@archiver.kernel.org>; Tue, 23 Apr 2019 20:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="gItHDwtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfDWUTD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:19:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38133 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfDWUTD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Apr 2019 16:19:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id v1so272949lfg.5
        for <selinux@vger.kernel.org>; Tue, 23 Apr 2019 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ISPtN114/vVDuvBUDQI+XOUJt45zg0Mc6YZThYyu9sE=;
        b=gItHDwtXfT3vkgFtkuMveM178GaK6E5BSH/sjG7WZHN92faZ+NIO1mJcaOYaIOXK1p
         bcO0SzU+RR/oz/yNUATaISXuEoPyA8f8qymglN1JJpQCpAsN27sye6iJBExT/tUJ/kbN
         4l0mde06G+ysr/0Rw0CMfKb/ILGd/JdqLCmZpxQ8/AVO+RLFcWITTnp9ROlmZdM2eXXI
         liOIisIYiA/0G23ZhJ04RNJsV8Fzp2YB4Nrkd2cudFbA7PbxP82uHe9V3PeuCecpTzIH
         EWubVuGPSeJLLeXFs/r/6MEE7c43R6qZ6Np/bmngVrrt0wOaABymndI9VLLE9OgtizXn
         OOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ISPtN114/vVDuvBUDQI+XOUJt45zg0Mc6YZThYyu9sE=;
        b=M5wiojh+VosZVEnncabKKgFBZeZakkQME3KuK5SY1LDXYImUHza2ngxJhXwXy64BYz
         Jozd6AhK1wkH+GUVy95yhSfKyT6hYZ3D7Q142eaovMKVAjoxWosqGeeiq75wtqbyOpbz
         SlYr9GwN5AVqLDULBDlhhRBts1GiK7e0e6mJH628oGI4q/R8+Ux5pCji7ZYOvpAOs/Ea
         DQd/5hI/w7m1D4HVYMupUlZvg0kkwMFU+khTE3YJeifzDvvHyj8TzjXXH9T7Eg2KpAtJ
         M8rRyK/Q9Yjd0VSTE/aP7yDxz/LpwMcO29GVkdoxhURzwFaQOGAPt9lM7vMEc2YFFb6W
         6vYg==
X-Gm-Message-State: APjAAAWsYgquuwlr+PAOJxiXaE5oG+YAI3dqmC3Yu4ABPOT4IDXCT+u9
        OqAZbTEZ6XrbMagtQe2dpGP4nm9+r1H6HSvL/UgS
X-Google-Smtp-Source: APXvYqzrRBQ5T03gOBocls3T9W4sEi7dljbs3juDVJw6tHxpnKFH8khBxwRVfKUcuCt5dOaJL94v5xypJIJdjS7rrlw=
X-Received: by 2002:a19:2814:: with SMTP id o20mr14905670lfo.117.1556050740201;
 Tue, 23 Apr 2019 13:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
 <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
 <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
 <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com> <CAHC9VhSpnSpYLLOcFUFLM=UU8tUTLAzJYb2NgdbN-nLPrh=55g@mail.gmail.com>
 <20190417145711.GI32622@redhat.com> <CAHC9VhSzo4DsMRknOA-4KKYJEir0wW74+quLheTjRw94OmhscA@mail.gmail.com>
 <20190417162723.GK32622@redhat.com> <CAHC9VhT_nk1jmrTj3W=F+1gP1vU3iZsZ=UGOCwdiBLbUsOc9=w@mail.gmail.com>
 <0ca3f4cf-5c64-2fc0-1885-9dbcca2f4b47@schaufler-ca.com> <5CB7E5D4.2060703@huawei.com>
 <CAHC9VhQkrR+m9_dYLg4VG-26TdUnf8XFjbmuVQ70YCOp6DhN_g@mail.gmail.com>
 <5CB933C4.7000300@huawei.com> <CAHC9VhTdJ6uUOjyxrk=+iOkKe=VN+N9DMPtV=OchAY34x95g=w@mail.gmail.com>
 <5CB9DC75.7010600@huawei.com> <CAHC9VhQqxL+LsK8YTD6PpTHaZsZ-PxAq3atdZKQcZLQZQH7t4g@mail.gmail.com>
 <5CBACC8F.8010409@huawei.com> <CAHC9VhSZBh8B+1CPM=PdLdbSFq1ba1ffuOJTgnzE5oBLXUEDxQ@mail.gmail.com>
 <5CBE8FC4.8060400@huawei.com>
In-Reply-To: <5CBE8FC4.8060400@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Apr 2019 16:18:49 -0400
Message-ID: <CAHC9VhRitKcax43NL5JThKqsysyakmarYiC4qTQTkka5SNNHuw@mail.gmail.com>
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Oleg Nesterov <oleg@redhat.com>, john.johansen@canonical.com,
        "chengjian (D)" <cj.chengjian@huawei.com>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.com>,
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
        SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 23, 2019 at 12:08 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
> On 2019/4/23 3:48, Paul Moore wrote:
> > On Sat, Apr 20, 2019 at 3:39 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> >> I'm not sure you got my point.
> > I went back and looked at your previous emails again to try and
> > understand what you are talking about, and I'm a little confused by
> > some of the output ...
> >
> >> --- a/kernel/acct.c
> >> +++ b/kernel/acct.c
> >> @@ -481,6 +481,7 @@ static void do_acct_process(struct bsd_acct_struct
> >> *acct)
> >>           flim = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
> >>           current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
> >>           /* Perform file operations on behalf of whoever enabled
> >> accounting */
> >> +       pr_info("task:%px new cred:%px real cred:%px cred:%px\n",
> >> current, file->f_cred, current->real_cred, current->cred);
> >>           orig_cred = override_creds(file->f_cred);
> > Okay, with this patch applied we should the task/cred info when
> > do_acct_process is called.  Got it.
> >
> >> Messages:
> >> [   56.643298] task:ffff88841a9595c0 new cred:ffff88841ae450c0 real
> >> cred:ffff88841ae450c0 cred:ffff88841ae450c0    //They are same.
> > Okay, it looks like do_acct_process() was called and f_cred,
> > real_cred, and cred are all the same.
>
> This is a original message, without patch applied.

The patch I am referring to is your pr_info patch (above).  I'm not
talking about any other patches at the moment; I just want to
understand the example dmesg output you copied into your email.

With that in mind, the message above seems to indicate that
do_acct_process() has been invoked with f_cred, real_cred, and cred
all pointing to the same credentials struct, yes?

> >> [   56.646609] Process accounting resumed
> > It looks like do_acct_process() has called check_free_space() now.  So
> > far so good.

...

> >> [   56.649943] task:ffff88841a9595c0 new cred:ffff88841ae450c0 real
> >> cred:ffff88841c96c300 cred:ffff88841ae450c0
> > Wait a minute ... why are we seeing this again?  Looking at the task
> > pointer and the timestamp, this is the same task exiting and trying to
> > write to the accounting file, yes?  This output is particularly
> > curious since it appears that real_cred has changed; where is this
> > happening?
>
> This is the message when the BUG_ON was triggered without applying any
> fix patch.

The only place in the code that generates this message is the bit of
code that you patches in using the pr_info() patch (above), yes?  If
so, that would seem to indicate that the same task is calling
do_acct_process() twice, yes?  I may be fundamentally misunderstanding
something about process accounting, but I though do_acct_process()
would only be called once for a given task - while it was exiting.
Yes, no?

> If we apply this patch "proc: prevent changes to overridden
> credentials", program
> runs like this:

I'd like to focus on understanding the dmesg output you shared first,
because it doesn't seem to make sense to me.

-- 
paul moore
www.paul-moore.com
