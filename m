Return-Path: <SRS0=IDnY=ST=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3777BC282DD
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 23:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059ED2184B
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 23:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="u9bf552P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfDQXjd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:39:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34872 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387721AbfDQXjc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Apr 2019 19:39:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id t4so258896ljc.2
        for <selinux@vger.kernel.org>; Wed, 17 Apr 2019 16:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PueCdnTmdAT9LR/dMMBLPphcTcVeVYSjT+9pj3ZFIEk=;
        b=u9bf552P1eISqEHwEehti8ZDUiZux4GSy41ZyWvrYDVAY6B0E60UfJ+fR0zJa+X+q3
         iOcjO94jP6EinkOBdEaFxpo7mfOmp6J7Z/au5MUODtDd3RBc2LCbBFaLMTR74uFuMXNu
         G0c2bTKCt5F3RKaZ8dzd4lw87laYH8qvoacFJTQ1AVQ5KXQlB8SQEaetiBakBkCgO7Nb
         jI9qT1rjnPRdbLFY6doN7AQEdkgyvEShKOX8o5v5U3Sn/DGbwj3yMXcIaUQR33Trk7uI
         fgJuPmklXSHIhu6IHPKzGL7A5FIg+eW9BzE8kkiTzViG6DbwFQjZ+O+GW4b31FguwYdH
         YRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PueCdnTmdAT9LR/dMMBLPphcTcVeVYSjT+9pj3ZFIEk=;
        b=HHW4qO3lkWJrDJW7bTEdjIUBS4bQ6Ntc91zFj6IjFsGYQGUwuHYcw0zwR3xGqdhgDA
         h7zpKZ1XUaPFWqtJmjkDQoIm6a7Hy0FGXx4AeG/GFid2pEbVodLLCjiXVyjNnPZIWQD7
         TkGDT6GP8OeKqG1giEIJ1Do8yezDbHvC5YF66cNt99sFfbRxlrwY8bkCqVRjHfgF3vih
         d/Btko16nT+Sh7DZd4qKLLusxaRhWQmIRxoAjhYDfs2GsdIVS7WIO+HYqOGn41zyYchL
         8LMLBiZAfbkazAuqzKc7J9c7kKocx9Opqd2WiV+z8z/vmKzJoYhR6a0AwSxlz/kVvto/
         VjFw==
X-Gm-Message-State: APjAAAWfxTiQx6Yr82C0rhO9uWR5JzjqvLKBR1KzcpxLnnrzaJvaobwW
        blbubkiLIt1Lpu6/JGq+cNBOIfHY1P7PRIyrnP8u
X-Google-Smtp-Source: APXvYqwcfV/AeoneU1PXoxdbf34+G0og8IhFWqb54m/cDEUxw5YMABIdT86XKiSdL3alsjfiMViHiY5prmzmEkA5MEo=
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr32153958ljk.5.1555544370455;
 Wed, 17 Apr 2019 16:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <b1575d02-fd88-65e6-2f16-70a96985087e@schaufler-ca.com>
 <20190415134331.GC22204@redhat.com> <CAHC9VhQ7ihqU0K57ctwzoHq0t0QVJPKiQQZn5TXB1FUqsvOSEQ@mail.gmail.com>
 <20190415150520.GA13257@redhat.com> <CAHC9VhSk1_fWooexHK0+5cKum55qTvj3uv5sRE=aJ4mv2GHJZg@mail.gmail.com>
 <CAGXu5jKYmoaR6bxW82ogN4iOeKi8AtEwkvVvCXd_gn3CCwFU2Q@mail.gmail.com>
 <fa325d38-db66-0ae7-0a6c-75934a9b0653@huawei.com> <CAHC9VhSpnSpYLLOcFUFLM=UU8tUTLAzJYb2NgdbN-nLPrh=55g@mail.gmail.com>
 <20190417145711.GI32622@redhat.com> <CAHC9VhSzo4DsMRknOA-4KKYJEir0wW74+quLheTjRw94OmhscA@mail.gmail.com>
 <20190417162723.GK32622@redhat.com>
In-Reply-To: <20190417162723.GK32622@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Apr 2019 19:39:19 -0400
Message-ID: <CAHC9VhT_nk1jmrTj3W=F+1gP1vU3iZsZ=UGOCwdiBLbUsOc9=w@mail.gmail.com>
Subject: Re: kernel BUG at kernel/cred.c:434!
To:     Oleg Nesterov <oleg@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        john.johansen@canonical.com
Cc:     "chengjian (D)" <cj.chengjian@huawei.com>,
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
        SELinux <selinux@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 17, 2019 at 12:27 PM Oleg Nesterov <oleg@redhat.com> wrote:
> On 04/17, Paul Moore wrote:
> >
> > On Wed, Apr 17, 2019 at 10:57 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > On 04/17, Paul Moore wrote:
> > > >
> > > > I'm tempted to simply return an error in selinux_setprocattr() if
> > > > the task's credentials are not the same as its real_cred;
> > >
> > > What about other modules? I have no idea what smack_setprocattr() is,
> > > but it too does prepare_creds/commit creds.
> > >
> > > it seems that the simplest workaround should simply add the additional
> > > cred == real_cred into proc_pid_attr_write().
> >
> > Yes, that is simple, but I worry about what other LSMs might want to
> > do.  While I believe failing if the effective creds are not the same
> > as the real_creds is okay for SELinux (possibly Smack too), I worry
> > about what other LSMs may want to do.  After all,
> > proc_pid_attr_write() doesn't change the the creds itself, that is
> > something the specific LSMs do.
>
> Yes, but if proc_pid_attr_write() is called with cred != real_cred then
> something is already wrong?

True, or at least I would think so.

Looking at the current tree there are three LSMs which implement
setprocattr hooks: SELinux, Smack, and AppArmor.  I know Casey has
already mentioned that he wasn't able to trigger the problem in Smack,
but looking at smack_setprocattr() I see the similar commit_creds()
usage so I would expect the same problem in Smack; what say you Casey?
 Looking at apparmor_setprocattr(), it appears that it too could end
up calling commit_creds() via aa_set_current_hat().

Since it looks like all three LSMs which implement the setprocattr
hook are vulnerable I'm open to the idea that proc_pid_attr_write() is
a better choice for the cred != read_cred check, but I would want to
make sure John and Casey are okay with that.

John?

Casey?

-- 
paul moore
www.paul-moore.com
