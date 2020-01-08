Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E462AC33CA2
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 13:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B916A20692
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 13:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="YVZL4qzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgAHNqC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:46:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41065 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgAHNqC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 08:46:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so3355347ljc.8
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2020 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rtYjbXkwyJJ6frQY7IN0ik7r1JCy0a8VOwpAJOl3+CA=;
        b=YVZL4qzD+quwISVrxqEP0ng6AleuKTNulKBVcdHkM+8Y54+fnTt7rBUG0+r5jTcQzS
         IciPYeZBFcdi7QGow18P9USwUlh2l5YKn+tj2uYSEj7lEx2YTwRqi2Zvt0/pOY3A7Cgu
         dI1GmUugGTjbmdXXIzMIhqxwtowIzkBqV2drtGOvuV140m0aHlZGSR1iov8gb0qB9npN
         XWXQT28RX7GCvxBnPgAS7ncO9HhWRmbmGIrr8G77c9dYNormeFS2Uik1O8dOAMLD8Aga
         /5Aw1Kc2CTohMr1V65CkhI1wL9eWhFnstGaB75grGNfRrmlwBW2VD6dHWESOYX+tNKgF
         lkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtYjbXkwyJJ6frQY7IN0ik7r1JCy0a8VOwpAJOl3+CA=;
        b=GyTb0r9nL5087knffp1Nnyox3APM0C/OfZLbgUI4J1MYI5YEZ91NGtYrwvhkRv59lL
         0Agv4UuCwobdwhimx0/9wYSHkik39JNfwQZU4GLzgkyxaIL/rjCMcUM5jFhSodgkSJMF
         zwOinc3ogXTq7RdBaqp+EzVcf1sYAMm4udbVYcvGZoktimrGApaC655in8GFnyLpEAkU
         2f2nBRBpqPbiUfz5YD6obacsehub1bGrGuedOgyansazDgd2gp1FZjoM4jFqDH/Jn6hL
         u+A2vSkPybiLMSVZtprTAUa7IIBIC8+FPzwlFpTu2fP4sahUuMWeoiyD4M9pT9iZtjpQ
         lXHQ==
X-Gm-Message-State: APjAAAWRpvYo8iQrhLRPjPCj9wjEZeEi3XVNl0M28CZkIMvcUSIZ6SbT
        lRaS08y0APVJigNutl5o7YO0tmc9ghyOLs3+pBUyNMk=
X-Google-Smtp-Source: APXvYqxMjVMqf/KB7IcC4X0JsfvWoVHm4r/NjJZU5Z0gQWyMHuuC7r7j/QpeaE51324hTAs1C8Jr2W42TEd4+pXIUok=
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr3030322ljj.225.1578491159585;
 Wed, 08 Jan 2020 05:45:59 -0800 (PST)
MIME-Version: 1.0
References: <20200107133154.588958-1-omosnace@redhat.com> <20200107133154.588958-3-omosnace@redhat.com>
 <bad81aeb-c21f-c5be-12a1-61912d04573a@tycho.nsa.gov> <CAHC9VhRMLJLSUY5VfdDRv=OuyLkvzsyqfpNhf_SfC9V8OALJ4g@mail.gmail.com>
 <CAFqZXNuv6OV_w_qneo-vK2Z4SBOqKRnnwNr-tgK__uSoX=76Ww@mail.gmail.com>
In-Reply-To: <CAFqZXNuv6OV_w_qneo-vK2Z4SBOqKRnnwNr-tgK__uSoX=76Ww@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Jan 2020 08:45:47 -0500
Message-ID: <CAHC9VhRzdTpW+qUbLZR8t+yDpKJfnMo9N=tZiuByp_80XHGXHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] security, selinux: get rid of security_delete_hooks()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 8, 2020 at 3:15 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Jan 8, 2020 at 6:32 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Jan 7, 2020 at 9:46 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > On 1/7/20 8:31 AM, Ondrej Mosnacek wrote:
> > > > The only user is SELinux, which is hereby converted to check the
> > > > disabled flag in each hook instead of removing the hooks from the list.
> > > >
> > > > The __lsm_ro_after_init macro is now removed and replaced with
> > > > __ro_after_init directly.
> > > >
> > > > This fixes a race condition in SELinux runtime disable, which was
> > > > introduced with the switch to hook lists in b1d9e6b0646d ("LSM: Switch
> > > > to lists of hooks").
> > >
> > > Not opposed (naturally, since I suggested it) but my impression from the
> > > earlier thread was that Paul preferred the less invasive approach of
> > > your original patch (just reordering the hooks) as a short term fix with
> > > an eye toward full removal of disable support in the not-too-distant future.
> >
> > Unless we are seeing wide spread breakages (I don't think we are), or
> > we decide we can never remove the runtime disable, I still prefer the
> > hook-shuffle over the changes proposed in this patchset.
>
> OK, I'm fine with either solution. Do you want me to rebase and resend
> the reorder patch? There are some minor conflicts with Stephen's
> recently merged patches.

Yes please.

-- 
paul moore
www.paul-moore.com
