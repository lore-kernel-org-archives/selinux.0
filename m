Return-Path: <SRS0=JMXr=6K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D800C54FCB
	for <selinux@archiver.kernel.org>; Sun, 26 Apr 2020 15:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579312070A
	for <selinux@archiver.kernel.org>; Sun, 26 Apr 2020 15:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBNaUcge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgDZPyI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 26 Apr 2020 11:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725778AbgDZPyH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 26 Apr 2020 11:54:07 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F92C061A0F
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2020 08:54:07 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o127so16182207iof.0
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2020 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=luwvtwbYcJYyqdxdmSvyuzv7AXRt3YO45n6RQ7pcQng=;
        b=UBNaUcgespTOSo9i7z/qcEI22FBwlRytQiC9CPTkNlohSts83V1ldbwEIT4Fj9D2AW
         b2VYSHVa3epdwY7L0sRGS2HgEmUUtMFSXqXPwLyaRwMaZrPqwhGaECa+rg3hpsdyqZKb
         RutmojN217+D0Afi9dz1FE2/j7rr1YlTtOYu4jwbI4rHYuSSQUpujlNBEvGSptKIXubw
         fSELvD12W83KgSgDCS5iKHsQUFmyPwIqh27LuqfndulYNzvoc0wu2sN71m+JlljMFOTz
         fV+4E5dRsDQ/04n0RteXXD/kqhqzaz19bpbEPoSJbdjxFAx4O1d7q2jJJePzV3WXmpqT
         1hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luwvtwbYcJYyqdxdmSvyuzv7AXRt3YO45n6RQ7pcQng=;
        b=bYt847gFaEhjRENa3V8R20zISTW+UdsMghWMA8jjlz78y8X/tWoDtur2m1cVTg8+AZ
         BXnVveh99GCj5E748fEmvG9T9R5KylNHHiYsMdp59B3CVAtvUFG+Z6eOGIcE/z9MSyyU
         v25s3z12mbniLC9WcOqwhVVSKTQAErJUOveHVfGfK9ZcI7AuxXXXcDLNUnaiZkXJKovp
         fTo+VgFB6310Ts770B2L8MFIS5wnzxjULFDDumThmpTYtPVZhhDklfIxalGIRZRBX15o
         BOYqJNkZALSpEv6qE3CHHiWBjelplrMfaZ9sM01nBJitHx/orlfoxQpqUY2KTH9sAQlM
         79hw==
X-Gm-Message-State: AGi0PuY3rO3MkQ6Db5Y96d/rXLZY+ta4oxIezuSdMFetVjkHPzJ5rpmC
        Ah4pZyx2EeOXRDyN+NTbLfX5j6uarG/qOLEiosM=
X-Google-Smtp-Source: APiQypJTXCi564JNFWJNcQZLhjeJSwiV6kw3ppq8dCVMc11yGlF1GDLR1Q6eIkD+TZpG0guU0071RDiIM1tEoRa+lH8=
X-Received: by 2002:a6b:f808:: with SMTP id o8mr17021652ioh.139.1587916446367;
 Sun, 26 Apr 2020 08:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com> <20200420154537.30879-14-william.c.roberts@intel.com>
 <CAJfZ7=nueDv_WihZu9oV9Qx+kq+cwK=ovD9jSm9rhMvDJS+01g@mail.gmail.com>
In-Reply-To: <CAJfZ7=nueDv_WihZu9oV9Qx+kq+cwK=ovD9jSm9rhMvDJS+01g@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sun, 26 Apr 2020 10:53:55 -0500
Message-ID: <CAFftDdr66Db3ZUjF=QUOORLiGhRKQ_O7WHfsF5k=U1oKj6TzmQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/19] avc: create internal avc_init interface
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Apr 26, 2020 at 8:34 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Apr 20, 2020 at 5:46 PM <bill.c.roberts@gmail.com> wrote:
> >
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > Now that avc_init is marked deprecated, create an avc_init2 interface
> > for internal users.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libselinux/src/avc.c          | 11 ++++++++++-
> >  libselinux/src/avc_internal.h |  5 +++++
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> > index ab10b0f9f1cb..505641406995 100644
> > --- a/libselinux/src/avc.c
> > +++ b/libselinux/src/avc.c
> > @@ -157,7 +157,7 @@ int avc_open(struct selinux_opt *opts, unsigned nopts)
> >                         break;
> >                 }
> >
> > -       return avc_init("avc", NULL, NULL, NULL, NULL);
> > +       return avc_init2("avc", NULL, NULL, NULL, NULL);
> >  }
> >
> >  int avc_init(const char *prefix,
> > @@ -165,6 +165,15 @@ int avc_init(const char *prefix,
> >              const struct avc_log_callback *log_cb,
> >              const struct avc_thread_callback *thread_cb,
> >              const struct avc_lock_callback *lock_cb)
> > +{
> > +       return avc_init2(prefix, mem_cb, log_cb, thread_cb, lock_cb);
> > +}
> > +
> > +int avc_init2(const char *prefix,
> > +            const struct avc_memory_callback *mem_cb,
> > +            const struct avc_log_callback *log_cb,
> > +            const struct avc_thread_callback *thread_cb,
> > +            const struct avc_lock_callback *lock_cb)
> >  {
> >         struct avc_node *new;
> >         int i, rc = 0;
> > diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
> > index 3f8a6bb1cf84..c8d26a8ae254 100644
> > --- a/libselinux/src/avc_internal.h
> > +++ b/libselinux/src/avc_internal.h
> > @@ -173,4 +173,9 @@ int avc_ss_set_auditdeny(security_id_t ssid, security_id_t tsid,
> >  /* netlink kernel message code */
> >  extern int avc_netlink_trouble ;
> >
> > +extern int avc_init2(const char *msgprefix,
> > +                   const struct avc_memory_callback *mem_callbacks,
> > +                   const struct avc_log_callback *log_callbacks,
> > +                   const struct avc_thread_callback *thread_callbacks,
> > +                   const struct avc_lock_callback *lock_callbacks);
> >  #endif                         /* _SELINUX_AVC_INTERNAL_H_ */
> > --
> > 2.17.1
>
> Hello,
> I do not see the point of having a new avc_init2() "internal
> interface". I get that avc_init() is deprecated, that avc_open()
> should be used, and that internally a new function (named avc_init2)
> is created to make the transition easier. But why is adding

Its not just transition, its so internal callers can call into an
interface that isn't marked
deprecated and we can keep the selinux build -Wdeprecated warning enabled.

> avc_init2() to avc_internal.h necessary? Which internal code is
> expected to use it?

Its not, it can be static in the file.

> If none, I would prefer to make avc_init2() static (changing this
> patch to "static init avc_init2(const char*msgprefix,", with a
> declaration before avc_open() if you do not want to move the function
> in the file).
>
> I have the same question for matchpathcon_fini2(), matchpathcon2(), etc.

matchpathcon2

>
> Moreover, I do not really like the "...2" naming (this is my own point
> of view and I won't block the patch because of it), because it seems
> to carry the meaning of "please now use this inferface", which is
> untrue. I suggest using avc_init_internal(),
> matchpathcon_fini_internal()... that do not carry such a meaning.

Thats fine, I just picked one because it was the exact naming convention
I used when discussing this with @sds. I didn't want to change that
unless someone suggested it.

>
> Thanks,
> Nicolas
>
