Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AA2C433EF
	for <selinux@archiver.kernel.org>; Wed, 18 May 2022 16:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbiERQDf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 May 2022 12:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbiERQDe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 May 2022 12:03:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E25E170F04
        for <selinux@vger.kernel.org>; Wed, 18 May 2022 09:03:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso2536244wmq.1
        for <selinux@vger.kernel.org>; Wed, 18 May 2022 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJ8x3A3SUh3hnIZHUc6rKyMmPbJB4WADynnntPJs/B0=;
        b=CFxKqA/ZOWiK2KBTxEXLxhszvMD6eEl28C9EC52rsAOz9y7u1qFvR5NbNXHFkojhXI
         L2oleUu6PJlNSNAXR+tZ40UR+65+zx3QkrDapDy9Fbqle4L55rwhjEWAEoAEhe3jnEZM
         Y+VewS4gm1Bcurjijqv5eRljKfCWFj84ltnVA5EgeJPZneEIh+cKnCHbhA/6upMndLOG
         A270E1nf9QDhDzvXKn+6Qe5xjXRcvox2oUTGuQp9wW8RsHYqdDTPRy275gqhzUd4PSFs
         Bh0VxypunuqM7GyZ1TAJKm9TPHAK3yNuRksX8fFC0GizRiIehoQbZGtSHqCYugxA8++h
         60AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJ8x3A3SUh3hnIZHUc6rKyMmPbJB4WADynnntPJs/B0=;
        b=Q0p6yEUmBq6xP7cActyhQ8RtKelDbiXme4cK8oKitk1CXhPHhuZ3mErj3FyolwfeWM
         IvFaM11etLHdAqRwnEJtr9FM8Ajt4tXmBp3QybE3LhPeq3oVrxe4RRO40PyFfSLpz9Lp
         btLQmjH0rPY5u4rUqeO3gsNMHGBCRweHLymsNU9aIOrEinIVumyRUKLThJ/ZCUeMqvEx
         oSzcFXE4SnIKaA2vbYkx/IkfkZCQ1h3PBjhcRju80WqDZH7ndPbEIl8d723F0Jg739dj
         lO60TCwIy0kJIHzOUigCoqFJB1V6fwXRv6zKDXTaDE4KJyCt3kha8kXGyjI/RTMz1JGh
         jQGg==
X-Gm-Message-State: AOAM5328utEcy2dgT4O9jjHeQuF7ldw91Gzl1/TRPziCg76qhqLF/CXI
        uQjsciM+IV6tDBzsNbtY8f9LKuEojKG7l5iHYhmB
X-Google-Smtp-Source: ABdhPJzVkBLylwaOZnnE42Ze2+ZD83Vb86r4fTxzPJH20bRDkwa1kPO33WF2FFIPJZRBjsneeGByTg/CPobPZKy0ryo=
X-Received: by 2002:a05:600c:3487:b0:397:ca9:c98b with SMTP id
 a7-20020a05600c348700b003970ca9c98bmr596753wmq.51.1652889811850; Wed, 18 May
 2022 09:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092137.141626-1-gongruiqi1@huawei.com>
 <CAHC9VhTj365p3SJvX+8eBqRO3wddnj0sXtRDp=jEhSdADwiGrg@mail.gmail.com> <6e2534c3-9af1-0c84-96ac-79075f79ab39@huawei.com>
In-Reply-To: <6e2534c3-9af1-0c84-96ac-79075f79ab39@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 May 2022 12:03:21 -0400
Message-ID: <CAHC9VhQRPqyMrja5L+8VTb-dsUrmb1cJq+wrQ5GyA5NupPLfZg@mail.gmail.com>
Subject: Re: [PATCH] selinux: add __randomize_layout to selinux_audit_data
To:     Gong Ruiqi <gongruiqi1@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 18, 2022 at 2:53 AM Gong Ruiqi <gongruiqi1@huawei.com> wrote:
> On 2022/05/18 9:39, Paul Moore wrote:
> > On Tue, May 17, 2022 at 9:21 PM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
> >>
> >> Randomize the layout of struct selinux_audit_data as suggested in [1],
> >> since it contains a pointer to struct selinux_state, an already
> >> randomized strucure.
> >>
> >> [1]: https://github.com/KSPP/linux/issues/188
> >>
> >> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> >> ---
> >>  security/selinux/include/avc.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> >> index 2b372f98f2d7..5525b94fd266 100644
> >> --- a/security/selinux/include/avc.h
> >> +++ b/security/selinux/include/avc.h
> >> @@ -53,7 +53,7 @@ struct selinux_audit_data {
> >>         u32 denied;
> >>         int result;
> >>         struct selinux_state *state;
> >> -};
> >> +} __randomize_layout;
> >
> > I'll apologize in advance for the stupid question, but does
>
> Not at all :)
>
> > __randomize_layout result in any problems when the struct is used in a
> > trace event?  (see include/trace/events/avc.h)
>
> No, as least it doesn't in the testing I did. I believe we can use the
> struct tagged with __randomize_layout as normal except that 1) it should
> be initialized with a designated initializer, and 2) pointers to this
> type can't be cast to/from pointers to another type. Other operations
> like dereferencing members of the struct (as in
> include/trace/events/avc.h) shouldn't be a problem.
>
> I did a testing to the patch on a qemu vm by running the selinux
> testsuite with tracing events "avc:selinux_audited" enabled. The
> testsuite completed successfully and from the tracing log I saw nothing
> abnormal with my bare eyes. You can do more testing if you want or you
> have other ideas of how to do so ;)

That's great, thanks for verifying this.  I was aware of the other
restrictions but wasn't sure about tracing.  Now I know :)

It's too late to go into selinux/next for this dev cycle, but I'll
queue this up for selinux/next once the merge window closes.

Thanks again!

-- 
paul-moore.com
