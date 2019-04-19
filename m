Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E411AC282DA
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 18:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED0E20645
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 18:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="asUVADWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfDSSuX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:50:23 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41620 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfDSSuW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Apr 2019 14:50:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id t30so4617563lfd.8
        for <selinux@vger.kernel.org>; Fri, 19 Apr 2019 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sUNkOJM5qQtNldmZZQggNGfurY1I1f4x5vigVCXTz5M=;
        b=asUVADWY1w/KJmvk3KMptj3GHBzRs/1x148BANaxwxjkyMSdwMhNhtFeZUQSoAzFlt
         PinC8ym4WsV3RSD7j6cw+f/vwC7jv2iohDUYgEWc0XfgEshit3qTQj3S830qlxs7YNDv
         uewDFfCZf8QxgXVychr4LWxSw4GJ4cfW7EIT7fQl9HmhWKgtDCt/3fUipb8STmZNOIDb
         OBe+UPHtv2AnTXQ49p9VrEU+HqluA5dPs6oJw5iDOTCJaz1R2V/XbcmlwKiVrK6warbB
         HYd6FNgLcrydrmmAdhOyLE/qy/0AOEz+lffTleVl7NlPxaVuYL3EUf/NNRUs+6jp2yaV
         RvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUNkOJM5qQtNldmZZQggNGfurY1I1f4x5vigVCXTz5M=;
        b=UcJ6Sm4BB3+MuUlDSpzBAurbDkRwINGXFVsZFidmf7EP090Js1fMmgwtxMGrA5qi4+
         JlwnnoeAhA4efTAnokzfR61lctlWokMgLlhShbxB1A4XatCcQ5HXjxK6VhGRd6JF3fgx
         cTeVu4RLxLLUsZ0lxGsZAORB7OHGO612DO6wRohtKoS5ElEp7aenAEzN0xv/tLnr1C2w
         UqGW72zRAr2LRSPf3hRBtgc5HWYu/2kGNr2KVWYNKe/OTAgaD2Hl39d2zzIQSkopZ8nz
         MHaMAu4689dymzoQOptg1wGcRFppEt3+MYK7xTr74dJD2EZqlW7OrlsskXeAHc5TOyT8
         54ag==
X-Gm-Message-State: APjAAAVpVw+jQRWv5Ppnx3hFvLn1cCpxBwkcJ+EH2DkLhSptYLfuW1jW
        BjpTHzvIemPh+Do911FncL1U55tO/Wlvh3yC42Ue
X-Google-Smtp-Source: APXvYqw0//3w9hhdaegDxBJ6hccf6Q5Sh4sn4DOwxGN3dliwNYTV3AbmbJlw2zyCh6FgTPUZQJkZPh6tP/i3GAATOOQ=
X-Received: by 2002:a19:6b0d:: with SMTP id d13mr2241991lfa.79.1555680305311;
 Fri, 19 Apr 2019 06:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
 <20190415134331.GC22204@redhat.com> <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
 <20190415150520.GA13257@redhat.com> <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
 <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
 <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com> <CAHC9VhSpnSpYLLOcFUFLM=UU8tUTLAzJYb2NgdbN-nLPrh=55g@mail.gmail.com>
 <20190417145711.GI32622@redhat.com> <CAHC9VhSzo4DsMRknOA-4KKYJEir0wW74+quLheTjRw94OmhscA@mail.gmail.com>
 <20190417162723.GK32622@redhat.com> <CAHC9VhT_nk1jmrTj3W=F+1gP1vU3iZsZ=UGOCwdiBLbUsOc9=w@mail.gmail.com>
 <0ca3f4cf-5c64-2fc0-1885-9dbcca2f4b47@schaufler-ca.com> <5CB7E5D4.2060703@huawei.com>
 <CAHC9VhQkrR+m9_dYLg4VG-26TdUnf8XFjbmuVQ70YCOp6DhN_g@mail.gmail.com> <5CB933C4.7000300@huawei.com>
In-Reply-To: <5CB933C4.7000300@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Apr 2019 09:24:54 -0400
Message-ID: <CAHC9VhTdJ6uUOjyxrk=+iOkKe=VN+N9DMPtV=OchAY34x95g=w@mail.gmail.com>
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

On Thu, Apr 18, 2019 at 10:42 PM Yang Yingliang
<yangyingliang@huawei.com> wrote:
> On 2019/4/19 10:04, Paul Moore wrote:
> > On Wed, Apr 17, 2019 at 10:50 PM Yang Yingliang
> > <yangyingliang@huawei.com> wrote:
> >> On 2019/4/18 8:24, Casey Schaufler wrote:
> >>> On 4/17/2019 4:39 PM, Paul Moore wrote:
> >>>> Since it looks like all three LSMs which implement the setprocattr
> >>>> hook are vulnerable I'm open to the idea that proc_pid_attr_write() is
> >>>> a better choice for the cred != read_cred check, but I would want to
> >>>> make sure John and Casey are okay with that.
> >>>>
> >>>> John?
> >>>>
> >>>> Casey?
> >>> I'm fine with the change going into proc_pid_attr_write().
> >> The cred != real_cred checking is not enough.
> >>
> >> Consider this situation, when doing override, cred, real_cred and
> >> new_cred are all same:
> >>
> >> after override_creds()    cred == real_cred == new1_cred
> > I'm sorry, you've lost me.  After override_creds() returns
> > current->cred and current->real_cred are not going to be the same,
> > yes?
>
> It's possible the new  cred is equal to current->real_cred and
> current->cred,
> so after overrides_creds(), they have the same value.

Both task_struct.cred and task_struct.real_cred are pointer values,
assuming that one uses prepare_creds() to allocate/initialize a new
cred struct for use with override_creds() then the newly created cred
should never be equal to task_struct.real_cred.  Am I missing
something, or are you thinking of something else?

-- 
paul moore
www.paul-moore.com
