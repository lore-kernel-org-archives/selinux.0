Return-Path: <SRS0=OI58=4F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7260CC34022
	for <selinux@archiver.kernel.org>; Mon, 17 Feb 2020 23:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E419206E2
	for <selinux@archiver.kernel.org>; Mon, 17 Feb 2020 23:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="yFTAEVm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgBQXVK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Feb 2020 18:21:10 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42459 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgBQXVJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Feb 2020 18:21:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so22539072edv.9
        for <selinux@vger.kernel.org>; Mon, 17 Feb 2020 15:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7L8JY3rP0eSy6TAwmSjUbhH7fPTwGMtdJ8VGXQoOmvg=;
        b=yFTAEVm8phQmZHFuvnch44+Aaw0SFUKvhTSgkOg8evmMu3W8A041nW9TjbdZftkFts
         AcqvHU/J/yknQ9yzU1O2dpP+F8BOqdLDiWDViOLIiPNWIgCqjkQvxXZGjDMYc4QavKpj
         MRahrg/Rl37IfSsUofT6wY1QUbYfdcWiUdVpTp5He+KcM2a1mLlOXfAg6Md8+gyjZ9+3
         dr4cpezinul82iAGh2WfAa0xWo7jXXiyOevGS/kf7lrz8mhdxNIqrCRt7iX4i2j4XBaI
         WQXOAdzJt8OYQ19m9Ssf+dadiuSsankhCaPRCJ0vSw8mCXFbc8RIzOfTOo+6OLRLxUQN
         6okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7L8JY3rP0eSy6TAwmSjUbhH7fPTwGMtdJ8VGXQoOmvg=;
        b=lIa0NvxCopo42XfuXz7gkKM52gxTeEcwJaV1DD4LQPauhl4pyrnqpbg2SunvDX9/pC
         SwX3iJT4ja3ipuAhaGyzoU6Lw3PxxWmqsYTrqO7LNwjBSLhYOT9QflHdRZ31OXR/QmZo
         /Mo+MGGiUAl9NfELR2Y0ZacJHEN63EU+NnYsFJ5+pCxsJA5VGMBF/zntxghZvLCxE59H
         I80GycIkk0afOnU3e0f7RlXx6poX3esiU1id8/Us5VX2uC8bwbxuJBTyAW74gDR9HXml
         rqkxsCvo4bxFknNn+wEfB6n7BCzYpCj8n9BOZ+bmqqbnaeynkrKCgommEdioBNZXYMhc
         zJOg==
X-Gm-Message-State: APjAAAUW0BdBJlX0ohyqVg+Fl2h1I7PUrBMzagY2BEaJTg39qqa9Rjv1
        SnlKg0ltH/K5CdK6EmcbLMD0F4Iou0xDO0TNA+Hz
X-Google-Smtp-Source: APXvYqyk55c8MBwKyPrq/VUAX082Z4Ybe2jK1swU17WKX/nAUYZ91YiOr/0ox51+/HnrI5I+EahUlNB+8yrWM1GJ0kE=
X-Received: by 2002:a17:906:9352:: with SMTP id p18mr16620565ejw.95.1581981668213;
 Mon, 17 Feb 2020 15:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20200212112255.105678-1-omosnace@redhat.com> <20200212112255.105678-3-omosnace@redhat.com>
 <CAHC9VhRwqRLNgycuX_MSYE83tFJBiresfiYRcz3RYX9Le+pTSw@mail.gmail.com> <CAFqZXNvkLVDuHZ8XbgEn9JFJ51=QGbAHK4Sbrc5r8mwLURT9Sg@mail.gmail.com>
In-Reply-To: <CAFqZXNvkLVDuHZ8XbgEn9JFJ51=QGbAHK4Sbrc5r8mwLURT9Sg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Feb 2020 18:20:57 -0500
Message-ID: <CAHC9VhQCG5VBtHhs8L2VPi29CaRqyNY3yzAM8u82Xh1LF7AGXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: optimize storage of filename transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 14, 2020 at 4:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Feb 14, 2020 at 1:35 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Feb 12, 2020 at 6:23 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:

...

> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > > index 981797bfc547..d8b72718e793 100644
> > > --- a/security/selinux/ss/policydb.c
> > > +++ b/security/selinux/ss/policydb.c
> > > @@ -1882,64 +1884,91 @@ out:
> > >
> > >  static int filename_trans_read_one(struct policydb *p, void *fp)
> > >  {
> > > -       struct filename_trans *ft;
> > > -       struct filename_trans_datum *otype = NULL;
> > > +       struct filename_trans_key key, *ft = NULL;
> > > +       struct filename_trans_datum *datum, *last, *newdatum = NULL;
> > > +       uintptr_t stype, otype;
> > >         char *name = NULL;
> > >         u32 len;
> > >         __le32 buf[4];
> > >         int rc;
> > > -
> > > -       ft = kzalloc(sizeof(*ft), GFP_KERNEL);
> > > -       if (!ft)
> > > -               return -ENOMEM;
> > > -
> > > -       rc = -ENOMEM;
> > > -       otype = kmalloc(sizeof(*otype), GFP_KERNEL);
> > > -       if (!otype)
> > > -               goto out;
> > > +       bool already_there;
> > >
> > >         /* length of the path component string */
> > >         rc = next_entry(buf, fp, sizeof(u32));
> > >         if (rc)
> > > -               goto out;
> > > +               return rc;
> > >         len = le32_to_cpu(buf[0]);
> > >
> > >         /* path component string */
> > >         rc = str_read(&name, GFP_KERNEL, fp, len);
> > >         if (rc)
> > > -               goto out;
> > > -
> > > -       ft->name = name;
> > > +               return rc;
> > >
> > >         rc = next_entry(buf, fp, sizeof(u32) * 4);
> > >         if (rc)
> > >                 goto out;
> > >
> > > -       ft->stype = le32_to_cpu(buf[0]);
> > > -       ft->ttype = le32_to_cpu(buf[1]);
> > > -       ft->tclass = le32_to_cpu(buf[2]);
> > > +       stype = le32_to_cpu(buf[0]);
> > > +       key.ttype = le32_to_cpu(buf[1]);
> > > +       key.tclass = le32_to_cpu(buf[2]);
> > > +       key.name = name;
> >
> > We don't really need the "name" variable anymore do we, we can just
> > use "key.name" instead, right?
>
> It is possible, but there is a slight obstacle in that "key.name" is
> "const char *" and "name" is "char *" (and str_read() expects a
> reference to "char *"). We could change the type in the
> filename_trans_key struct, but is it really worth it?
>
> I like to have a separate variable for the name, since it is easier to
> spot that it is something we allocate and need to take care not to
> leak it. It is easier to forget that there is that one member of key
> that you need to free in the error path.
>
> I'll be foolish enough to hope that I convinced you so I'll wait for
> your reaction for now, but I'm willing to do the change if you still
> want it :)

Heh ;)

Okay, I'm convinced, let's keep "name".

-- 
paul moore
www.paul-moore.com
