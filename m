Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75367C282DA
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 18:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420DB205F4
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 18:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="mxkAJYVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfDSSrZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:47:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33521 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfDSSrY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Apr 2019 14:47:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id j11so4632198lfm.0
        for <selinux@vger.kernel.org>; Fri, 19 Apr 2019 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iK1taWbgATs8Vl8fFsChTbd5jcA8vAv8F4ZJybEWxxU=;
        b=mxkAJYVmuq2pr6gOlJ0xL389JPlOlngx6VE/088bLhYmI7OQF43z1E4M8O+BW+POKE
         PR3zP9uyePtE3LCa5weImSzv4ICMWTzz1c5kVbO/oEStZ9XsFILFY6EwGQ0qUbS/bYxH
         LSfJCvjW+t2Mlq438H0xzjAr8ue1U7JJW7+v5mnKOGqFFBvvp+61pGdvqkCUFshPPUGa
         qeYIw1MTq4rk3hS9QIjOLMVgF+L3sfuY3II0YNEM15IRnJMhVjnMixF0qIowDclYTvoR
         swb2KkBkXzVVOIhVIPkg5L62a1BSReSf6rDDUEF2ScPoVS51vzwe6v41CLkIdSLk7IwG
         IpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iK1taWbgATs8Vl8fFsChTbd5jcA8vAv8F4ZJybEWxxU=;
        b=q2DCl93rE42jf6eR/RPXzpGmtTcf8LZcb7Y5f7LAjn9glsTpy9WTS6kxLjtpccL4nc
         r7Q3rAMHPISathNBZgPDwltDcGBbQwulHjRwS1/lc4+H8ANytyMG307qPAKEW3rhfvMv
         IUIGmlgmCGtYE9DzYQBtM1VjB3v9pPT5VGSAsfyWc3aS0dfG7TI26Zs3fWlLihhZIL+1
         hJK6NmGxxIy4q3EugDq3z4dLkwohLutzW5O9xY0hLFtwbHjqY4jz+yBcDs+cwzVtN598
         u/6WOLk85kr2TJ2LcNTsNqtEKWrzb0CaZakoNYY1Pg2qPm7J1eCINBSQgpPMbvNwr22w
         NLZA==
X-Gm-Message-State: APjAAAUgTgjjvrAqnKtwxZvmPhkEcOuJIRFOmtaf/09G8eZ7YSE/nEep
        3DGcb9tal15rSuYMOXSuuSmdHspGIUmk8IbxRbU4UqE=
X-Google-Smtp-Source: APXvYqyHYDOuzDa4e9JuBSsCJiFvs/FyB2lIMrmM48Pvdmxy8YprG6nz6qk/neEAlYQkJTgIXoi7dCWZIHUWMztxVGs=
X-Received: by 2002:a19:2814:: with SMTP id o20mr2658257lfo.117.1555690420662;
 Fri, 19 Apr 2019 09:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
 <20190415134331.GC22204@redhat.com> <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
 <20190415150520.GA13257@redhat.com> <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
 <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
 <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com> <CAHC9VhSpnSpYLLOcFUFLM=UU8tUTLAzJYb2NgdbN-nLPrh=55g@mail.gmail.com>
 <20190417145711.GI32622@redhat.com> <CAHC9VhSzo4DsMRknOA-4KKYJEir0wW74+quLheTjRw94OmhscA@mail.gmail.com>
 <20190417162723.GK32622@redhat.com> <CAHC9VhT_nk1jmrTj3W=F+1gP1vU3iZsZ=UGOCwdiBLbUsOc9=w@mail.gmail.com>
 <0ca3f4cf-5c64-2fc0-1885-9dbcca2f4b47@schaufler-ca.com> <5CB7E5D4.2060703@huawei.com>
 <CAHC9VhQkrR+m9_dYLg4VG-26TdUnf8XFjbmuVQ70YCOp6DhN_g@mail.gmail.com>
 <5CB933C4.7000300@huawei.com> <CAHC9VhTdJ6uUOjyxrk=+iOkKe=VN+N9DMPtV=OchAY34x95g=w@mail.gmail.com>
 <5CB9DC75.7010600@huawei.com>
In-Reply-To: <5CB9DC75.7010600@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Apr 2019 12:13:29 -0400
Message-ID: <CAHC9VhQqxL+LsK8YTD6PpTHaZsZ-PxAq3atdZKQcZLQZQH7t4g@mail.gmail.com>
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

On Fri, Apr 19, 2019 at 10:34 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
> On 2019/4/19 21:24, Paul Moore wrote:
> > On Thu, Apr 18, 2019 at 10:42 PM Yang Yingliang
> > <yangyingliang@huawei.com> wrote:
> >> On 2019/4/19 10:04, Paul Moore wrote:
> >>> On Wed, Apr 17, 2019 at 10:50 PM Yang Yingliang
> >>> <yangyingliang@huawei.com> wrote:
> >>>> On 2019/4/18 8:24, Casey Schaufler wrote:
> >>>>> On 4/17/2019 4:39 PM, Paul Moore wrote:
> >>>>>> Since it looks like all three LSMs which implement the setprocattr
> >>>>>> hook are vulnerable I'm open to the idea that proc_pid_attr_write() is
> >>>>>> a better choice for the cred != read_cred check, but I would want to
> >>>>>> make sure John and Casey are okay with that.
> >>>>>>
> >>>>>> John?
> >>>>>>
> >>>>>> Casey?
> >>>>> I'm fine with the change going into proc_pid_attr_write().
> >>>> The cred != real_cred checking is not enough.
> >>>>
> >>>> Consider this situation, when doing override, cred, real_cred and
> >>>> new_cred are all same:
> >>>>
> >>>> after override_creds()    cred == real_cred == new1_cred
> >>> I'm sorry, you've lost me.  After override_creds() returns
> >>> current->cred and current->real_cred are not going to be the same,
> >>> yes?
> >> It's possible the new  cred is equal to current->real_cred and
> >> current->cred,
> >> so after overrides_creds(), they have the same value.
> > Both task_struct.cred and task_struct.real_cred are pointer values,
> > assuming that one uses prepare_creds() to allocate/initialize a new
> > cred struct for use with override_creds() then the newly created cred
> > should never be equal to task_struct.real_cred.  Am I missing
> > something, or are you thinking of something else?
>
> In do_acct_process(), file->f_cred may equal to current->real_cred, I
> confirm
> it by adding some debug message in do_acct_process() like this:

I would expect that; real_cred is the task's objective DAC
credentials, so using it for f_cred makes sense.

What we are now talking about is the task's subjective credentials,
which can be overridden via override_creds(), and are what the LSMs
change via proc_pid_attr_write().

> --- a/kernel/acct.c
> +++ b/kernel/acct.c
> @@ -481,6 +481,7 @@ static void do_acct_process(struct bsd_acct_struct
> *acct)
>          flim = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
>          current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
>          /* Perform file operations on behalf of whoever enabled
> accounting */
> +       pr_info("task:%px new cred:%px real cred:%px cred:%px\n",
> current, file->f_cred, current->real_cred, current->cred);
>          orig_cred = override_creds(file->f_cred);

-- 
paul moore
www.paul-moore.com
