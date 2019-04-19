Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD17C282E0
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 02:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175DC217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 02:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="CFLnajm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfDSCFK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 22:05:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46748 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfDSCFJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 22:05:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id k18so3007659lfj.13
        for <selinux@vger.kernel.org>; Thu, 18 Apr 2019 19:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Zpp0a7FzYxL9MMqDWJLVdMOOMWYFYTfF+jVXBn6TGw=;
        b=CFLnajm7/r0p+aniggaeKCoBr8CFWpvvUVzviE/3RHyJC+nDSO9wsq15ZrdmPeBjdo
         oYogQLrMaJMgTPs7N6FkhYdPnzKrJShRWFsvaVHem5jkwiJSsV5n6GZQA/yKwcq/IaFn
         BJtbaxBOaeI0aSBLXMSzparNtDegUvDNfndA1FlRrjnTQWrCfNXLGekEBFHO1/0kQw7b
         cdV1AfdxAmNsQ+DEgNLyKr4/D75cQXgoyhwtiNr532dD9IyRST1OfE1wX4PfY2uKR0fr
         lED7GAfj401MAJvdsqgXnlCMGZbnEuKIE1Vk/co6TzABB/NV/sJJ5B0jTIk9mN8XAsTH
         ju4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Zpp0a7FzYxL9MMqDWJLVdMOOMWYFYTfF+jVXBn6TGw=;
        b=Gni0h8bDsA+1ULnwRHqK7pTyUhQngzG4mcdosXoY/+r2xaA+2A/uMzON6Hol8g8CST
         66aYFEl3uWReSrQM9rYDrWVg7pQQGHisQSFDBrFqO5YxnJl5lcNc20CG8B7cRL+wuqvu
         dTk/FuWFUz6FDmyrsinXr9yw+DQLatAmL09po5vfT+EAfkCzBdBz0IXqo0djIirpL6sR
         2//Amd2xG8nR4p0jIaCOtUwW/uwrOntk5OfRYG301oX+k3Y0soTAuJ1S8DVmRouRJsDF
         janbz744eurFBStKRVcQ3EsFiwJz8pM3zoA8eTqetnot/DnMHS6e5QCvyoUITCieh5f9
         C/bQ==
X-Gm-Message-State: APjAAAUpiZSdCJj0EA86YHE+zXBGj8IDvRUG8Bbfpe3bYpVTnsT5NBnh
        tyE6j+6bWulU1jBPvOArE6Q1iIN7pfPOLAUhG6J1
X-Google-Smtp-Source: APXvYqzzuCFOodQvZfk8YYXzyZdHccX91bZ8AO1HzOKZO83z1IfqIro5Y/wvGOiosvOTVhcSK06wQ+8TsbI7Wkk905o=
X-Received: by 2002:a19:f50f:: with SMTP id j15mr695903lfb.135.1555639507016;
 Thu, 18 Apr 2019 19:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
 <20190415134331.GC22204@redhat.com> <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
 <20190415150520.GA13257@redhat.com> <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
 <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
 <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com> <CAHC9VhSpnSpYLLOcFUFLM=UU8tUTLAzJYb2NgdbN-nLPrh=55g@mail.gmail.com>
 <20190417145711.GI32622@redhat.com> <CAHC9VhSzo4DsMRknOA-4KKYJEir0wW74+quLheTjRw94OmhscA@mail.gmail.com>
 <20190417162723.GK32622@redhat.com> <CAHC9VhT_nk1jmrTj3W=F+1gP1vU3iZsZ=UGOCwdiBLbUsOc9=w@mail.gmail.com>
 <0ca3f4cf-5c64-2fc0-1885-9dbcca2f4b47@schaufler-ca.com> <5CB7E5D4.2060703@huawei.com>
In-Reply-To: <5CB7E5D4.2060703@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Apr 2019 22:04:55 -0400
Message-ID: <CAHC9VhQkrR+m9_dYLg4VG-26TdUnf8XFjbmuVQ70YCOp6DhN_g@mail.gmail.com>
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

On Wed, Apr 17, 2019 at 10:50 PM Yang Yingliang
<yangyingliang@huawei.com> wrote:
> On 2019/4/18 8:24, Casey Schaufler wrote:
> > On 4/17/2019 4:39 PM, Paul Moore wrote:
> >>
> >> Since it looks like all three LSMs which implement the setprocattr
> >> hook are vulnerable I'm open to the idea that proc_pid_attr_write() is
> >> a better choice for the cred != read_cred check, but I would want to
> >> make sure John and Casey are okay with that.
> >>
> >> John?
> >>
> >> Casey?
> >
> > I'm fine with the change going into proc_pid_attr_write().
>
> The cred != real_cred checking is not enough.
>
> Consider this situation, when doing override, cred, real_cred and
> new_cred are all same:
>
> after override_creds()    cred == real_cred == new1_cred

I'm sorry, you've lost me.  After override_creds() returns
current->cred and current->real_cred are not going to be the same,
yes?

> after prepare_creds()     new2_cred
> after commit_creds()     becasue the check is false, so cred ==
> real_cred == new2_cred
> after revert_creds()        cred == new1_cred, real_cred == new2_cred
>
> It will cause cred != real_cred finally.

-- 
paul moore
www.paul-moore.com
