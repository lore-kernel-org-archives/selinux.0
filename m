Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B769C5AC75
	for <selinux@archiver.kernel.org>; Tue, 25 Jan 2022 23:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbiAYXg3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 18:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbiAYXgV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 18:36:21 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4638C06173B
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 15:36:20 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j23so61000768edp.5
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 15:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYNA1CVJ1M6lrfRYYmGpOXg9P7wsf14wwNEYFVpQGRg=;
        b=xU6QF2/+7XDapkHCfliHO7u2D33hB0Ch0R0zZzdpTzTPvC1Y047yhrhmDkYlG1ppFH
         gDW0mIb8aCXFh74WuQjozBdZq/rhW8qM4AQxx9Gc6cVqBnmsb9EmIUcnS26wJDDqHOQE
         4RVbKQUT85I+CGWgw00+JSAS9l7zZbLAvWCSkp0DwQEc28JTxoc6BwlKJtyHRa/RVTa6
         S+l/jyHJzEXW6dG/nQAPWnAFvDC15uCBPbvWQTLdw3Fa4dbM3ZEkZYQ3dBcqLrLQPlaV
         ak8bOHgCGnKCoRhPjerDD31SgD47NnYfjU2UmhwWxXlWNCd5yuiuBTidOBnJO35Ij32W
         gZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYNA1CVJ1M6lrfRYYmGpOXg9P7wsf14wwNEYFVpQGRg=;
        b=2YFuya3k2IFagSuqRjVjLczJU9ePXrr79G669HtsXUEpVp18lcQAgWrFJwWt3386LD
         M6yix1mELRPRuRiunOdanZxmIzdXzCSA+HHUK7vpp7tCgdSl41U1Wze/x/n1e1bfJNF0
         I5F44nlgqWXZVL2fDPgDSXkuZN5rvVMSxZqqOAXINEKxyDaH2oADqmSjr5YXc//aOjNY
         pwRBPrhEXdGtA4YXLboqOLprqA973+i9SwudQ5Ty6s5BoNyBqxtbcc0KfsodMM8pzdcu
         oejY+gEBqJ0+vPmJ5lfHq4dMIzcZ+lG0gKP+C1hfA1XUQD+ohapr4+f7m0Yp3ZeFpUML
         u/nw==
X-Gm-Message-State: AOAM530F4fOKM8Vj7WzHOqqkSXH3KT/FOKtQOaK0xfS7KiaqPbAqz494
        0gldT5/ONKujNW8QHGU6D6byphKToJcFbiF0xtJH
X-Google-Smtp-Source: ABdhPJzyKxTfCZQvgfVyP8WAgYiBXBKlAsCF/r32JYcD5TCu4aPsnLVRGgfZiEjWYbgBZ/IJQhgPdfZ0kOdvDMZdfEE=
X-Received: by 2002:aa7:d407:: with SMTP id z7mr22532317edq.331.1643153779366;
 Tue, 25 Jan 2022 15:36:19 -0800 (PST)
MIME-Version: 1.0
References: <018a9bb4-accb-c19a-5b0a-fde22f4bc822.ref@schaufler-ca.com>
 <018a9bb4-accb-c19a-5b0a-fde22f4bc822@schaufler-ca.com> <20211012103243.xumzerhvhklqrovj@wittgenstein>
 <d15f9647-f67e-2d61-d7bd-c364f4288287@schaufler-ca.com> <CAHC9VhT=dZbWzhst0hMLo0n7=UzWC5OYTMY=0x=LZ97HwG0UsA@mail.gmail.com>
 <e046ab1e-0e59-afb2-ae28-fafa17ea8ddd@schaufler-ca.com>
In-Reply-To: <e046ab1e-0e59-afb2-ae28-fafa17ea8ddd@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jan 2022 18:36:08 -0500
Message-ID: <CAHC9VhRA5HN6zaq=oAfT-RR+FC9v018Y_Am5xcridYj3h3JN-g@mail.gmail.com>
Subject: Re: [PATCH] LSM: general protection fault in legacy_parse_param
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 6:30 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 1/25/2022 2:18 PM, Paul Moore wrote:
> > On Tue, Oct 12, 2021 at 10:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 10/12/2021 3:32 AM, Christian Brauner wrote:
> >>> On Mon, Oct 11, 2021 at 03:40:22PM -0700, Casey Schaufler wrote:
> >>>> The usual LSM hook "bail on fail" scheme doesn't work for cases where
> >>>> a security module may return an error code indicating that it does not
> >>>> recognize an input.  In this particular case Smack sees a mount option
> >>>> that it recognizes, and returns 0. A call to a BPF hook follows, which
> >>>> returns -ENOPARAM, which confuses the caller because Smack has processed
> >>>> its data.
> >>>>
> >>>> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
> >>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>> ---
> >>> Thanks!
> >>> Note, I think that we still have the SELinux issue we discussed in the
> >>> other thread:
> >>>
> >>>        rc = selinux_add_opt(opt, param->string, &fc->security);
> >>>        if (!rc) {
> >>>                param->string = NULL;
> >>>                rc = 1;
> >>>        }
> >>>
> >>> SELinux returns 1 not the expected 0. Not sure if that got fixed or is
> >>> queued-up for -next. In any case, this here seems correct independent of
> >>> that:
> >> The aforementioned SELinux change depends on this patch. As the SELinux
> >> code is today it blocks the problem seen with Smack, but introduces a
> >> different issue. It prevents the BPF hook from being called.
> >>
> >> So the question becomes whether the SELinux change should be included
> >> here, or done separately. Without the security_fs_context_parse_param()
> >> change the selinux_fs_context_parse_param() change results in messy
> >> failures for SELinux mounts.
> > FWIW, this patch looks good to me, so:
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
> >
> > ... and with respect to the SELinux hook implementation returning 1 on
> > success, I don't have a good answer and looking through my inbox I see
> > David Howells hasn't responded either.  I see nothing in the original
> > commit explaining why, so I'm going to say let's just change it to
> > zero and be done with it; the good news is that if we do it now we've
> > got almost a full cycle in linux-next to see what falls apart.  As far
> > as the question of one vs two patches, it might be good to put both
> > changes into a single patch just so that folks who do backports don't
> > accidentally skip one and create a bad kernel build.  Casey, did you
> > want to respin this patch or would you prefer me to submit another
> > version?
>
> I can create a single patch. I tried the combination on Fedora
> and it worked just fine. I'll rebase and resend.

Great, thank you.

> >>> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> >>>
> >>>>   security/security.c | 14 +++++++++++++-
> >>>>   1 file changed, 13 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/security/security.c b/security/security.c
> >>>> index 09533cbb7221..3cf0faaf1c5b 100644
> >>>> --- a/security/security.c
> >>>> +++ b/security/security.c
> >>>> @@ -885,7 +885,19 @@ int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
> >>>>
> >>>>   int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >>>>   {
> >>>> -    return call_int_hook(fs_context_parse_param, -ENOPARAM, fc, param);
> >>>> +    struct security_hook_list *hp;
> >>>> +    int trc;
> >>>> +    int rc = -ENOPARAM;
> >>>> +
> >>>> +    hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
> >>>> +                         list) {
> >>>> +            trc = hp->hook.fs_context_parse_param(fc, param);
> >>>> +            if (trc == 0)
> >>>> +                    rc = 0;
> >>>> +            else if (trc != -ENOPARAM)
> >>>> +                    return trc;
> >>>> +    }
> >>>> +    return rc;
> >>>>   }

-- 
paul-moore.com
