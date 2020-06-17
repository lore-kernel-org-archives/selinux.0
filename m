Return-Path: <SRS0=Tm5b=76=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA28C433E0
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 15:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10F2206FA
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 15:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWGXxKn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgFQPXW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgFQPXW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Jun 2020 11:23:22 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101D5C06174E
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 08:23:22 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g5so1919323otg.6
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JgG0+IaBz25fUIMa8YQrwE8y0vlRhsxuB6tri0hnuRA=;
        b=mWGXxKn9YxDil9Y8uK8s1mF6iZ/6bXYILjz26KUrR+HbqPCRrzsw36XfIWVnRQnH+3
         R9iKWb0hSTxL08+oSTYh6sM7609D16hlQk37cXJ9l3T2se6USLQQ0aBWMOM4NwdFSGjB
         zQbdUNub9j/0dpeYwJj9lSoGwrhz2/A5uGp+WW27TkDz7Z4PYvp5uXkEvQ+AGAdlppyi
         9eIAv3S/Tb95J1/rtODA1knWrDKulBvy5j5ICvZXd3N7q+5BE/cBmywM+d8gBj06CFrR
         p7loDbe2NzGFN4cry0wTZEWMx2hSP58bIsxh6sq7BULjaZQ7coK01kOx7N03LDYnBtTv
         EjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgG0+IaBz25fUIMa8YQrwE8y0vlRhsxuB6tri0hnuRA=;
        b=qZzCnxeRcIf2kZM9bhDkvUubRtR0bRc1JfBEaMyZbd56LOG6dC7Yyd6m9CDVgjdcSZ
         dnshBM6Z/9WoaAyODy728s3Q6Hgz+sH8FbG2t4DLwJgqYrYS8xR3C9YX9DIIX4S7yd/K
         67u+9fhciprchW3fpzNlhAlAY0K0AXiGy0uceOWJ4EQCmvW3SghXXDUO9DGkkrMuWDFU
         GdQAHOuEBTNQ04q+01lXtfIpszFhI84Ewfa+x+BDadDue2HrUW1FMDpwRnuq3LD2TWCx
         d3UmvmKZ4rfPjxDk1gHpoJwmXNZ1yQtI9R74WuIh1h33ms7adZw8lxrLkTsg5JjMzNqi
         iyWg==
X-Gm-Message-State: AOAM532VIVFIzx4Q4OaF7J2EXxzFAbAuYfVf1DC4O8DezqJ0dJKMspKb
        1trq4Z1TEjCrUEpA55d0lIUCcmot/f1XUYP8eZWqGOP4kAo=
X-Google-Smtp-Source: ABdhPJxtIQ5vV118EPw2W87ZKWxYNWsHuLdchGdeJfN69tcamoXSILJz37M6o/g0pexPq9iveYRbBoPYlOXd+Cx9Xvo=
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr7315237oti.162.1592407401345;
 Wed, 17 Jun 2020 08:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <3a60cdb1-3e30-da2a-8225-abfdc0f6b3d7@gmail.com>
 <CAEjxPJ4+cVRjWZ3=j7DoOadBarZBteqAsanCTp+fnH+ztpER9g@mail.gmail.com>
 <CAEjxPJ7rygAQjqYBiYHRw__cJjO4mJdV_7K38aG=i19s2_-FNg@mail.gmail.com> <CAJVWAV2x42n-5TJa+v=KkETao2jvL3qMPD9PKm9HzKXaGi6V0w@mail.gmail.com>
In-Reply-To: <CAJVWAV2x42n-5TJa+v=KkETao2jvL3qMPD9PKm9HzKXaGi6V0w@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 17 Jun 2020 11:23:10 -0400
Message-ID: <CAEjxPJ7LpVVpqyygve71K+Pr-w34w3DZgNAJqocbRAV=RVKMhg@mail.gmail.com>
Subject: Re: Minimal CIL policy requires process class with transition permission
To:     Dac Override <dac.override@gmail.com>
Cc:     bauen1 <j2468h@googlemail.com>, selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 17, 2020 at 10:12 AM Dac Override <dac.override@gmail.com> wrote:
> Speaking for myself here. I want to be able to clarify as much as
> possible, without having to resort to: "this is added because of some
> kernel internal", because those aspects distract when you try to learn
> how to write a policy from scratch. Things tend to stick better when
> you understand their purpose.

Yes, it is mostly a legacy of the original tight coupling of kernel
classes/permissions to policy and hardcoded assumptions about
different default behaviors for processes (subjects) versus objects
(which these days are at least mostly configurable via default rules
and the like).  So we could probably eliminate the hard requirement
here on process transition.  Just not sure it would yield a very
usable system if you loaded such a policy.

> The situation is improving though. I don't think we were able to write
> a policy by just being aware of this "process transition" internal in
> the recent past. The lifting of the classordering make it possible to
> start with just "process transition" and then get all the classes and
> perms from dmesg as you go without having to be aware of all the
> classes and perms needed (let alone any ordering as now you can just
> all unorder it)
>
> Another path in this picture is the ability to omit unused isids, It
> just does not help trying to explain "were just adding these sids and
> sidcons due to some kernel internals" Now we can just stick to used
> sidcons and explain why they are needed.
>
> So aside from the "process transition" secret sauce, I think the only
> other aspect that might be hard to explain are the sidorder and the
> need for sidorder.
>
> But other than the above now writing a policy from scratch is just
> easier. Thanks for that.

You're welcome.  Another thorny spot for new policy writers is likely
when/how to use the various fs_use_* rules and when to use genfscon
(and at what granularity); script/selinux/mdp at least will
auto-generate a sane default set for you based on kernel
configuration.  And unfortunately we've grown a set of hardcoded logic
around specific filesystem types that need to get generalized and
turned into policy-driven rules, as per
https://github.com/SELinuxProject/selinux-kernel/issues/2.
