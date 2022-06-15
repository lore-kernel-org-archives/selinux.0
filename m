Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A67C43334
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 13:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345449AbiFONqA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbiFONp7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 09:45:59 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BA130F55
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 06:45:58 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w16so15524952oie.5
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 06:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6eTjngrprdXJVGw0/PyyfipfbqRJPdyZIMuHpHkzqME=;
        b=o+IGmCl4qQb5HfIzcAo1yHP7unTcFy8ZuVuSl9ThCyL4CdQAeCi+deYdpsbzoeWx6y
         +lU9nes72lXogGFCAb8SMw14oRFGSjjnLa01oOKWHyBdXufk00ZW4Ph0YXnTyiLqRtZ1
         j447qSR0+DTcO1CdcOOdEdu8LW3PNoOQmM8sA4JdJDYadxHwmI8ejBM0gQjs/jTeGIug
         NtI54eM6SDb/UJvUb0Od5ZN301Q6BLBVEfW/GmKwsQCsvYCqnIHtZcY6no8Azb+fwHb/
         +KI1m4R2u+G8QtfyuNmKnsrxKLOAu8lTnUclqTV+GORSZzyVk7yXyei27D3g17j08BPa
         qSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6eTjngrprdXJVGw0/PyyfipfbqRJPdyZIMuHpHkzqME=;
        b=hnuqtHayjnfceSXDgY9dqqf2JHmoY/5tHMT0oqy5PAG7eaMyR7MpCwHugG6PJnPFNC
         U42wiRj2z2mHxaJLjP9OaU7T+UHFmT5X81/x/4YaW/r00j6o/9IFCwUehx4NUxbkeuip
         aCFKIUXtEfwyUjNChpGtp/lHYkyUMCdJOcNbWwjn+y2BdaYtYlwJC7ofDAT4D2Sj/M7F
         ytitnEgkrF6R51lsiG7Bz3lBsLjmKH4qwxuq8WMnku1G5CSjFZRyp883iCZhQ1oErYPr
         QBjR11CtrxfY7tqkC59YzUGJeKnNRKNPrkHGJKUOJxVVn71CwCAjcN5qTrp119icwWAA
         YjOg==
X-Gm-Message-State: AOAM5323nV6vAegFd5fRiHuDV72p2csLJ2eLdoaDpoGhy/lf4qqnl5Ms
        c669dkL2F/Ew164pTZkXhQ3Ecs8uUic2LJzi1pUSos2v
X-Google-Smtp-Source: ABdhPJy8dM7MosvUlba+gBjWzLNfZ5EiJEWHtArM8fMaiI4oyFCxWgo82/fZjbsTKe9H1vGPP1ivydD+kkcv8RVSakk=
X-Received: by 2002:a05:6808:20a6:b0:32f:3376:46f1 with SMTP id
 s38-20020a05680820a600b0032f337646f1mr5135002oiw.182.1655300757123; Wed, 15
 Jun 2022 06:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220520130847.10958-1-cgzones@googlemail.com> <CAP+JOzSmYALmPjrKYaL4kLJY7RaY8+ypzR9evHmrWUih58vyHQ@mail.gmail.com>
In-Reply-To: <CAP+JOzSmYALmPjrKYaL4kLJY7RaY8+ypzR9evHmrWUih58vyHQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 15 Jun 2022 09:45:46 -0400
Message-ID: <CAP+JOzQvro7Wfk0aBQNGZingdecsL5eSu=-VXbhD4Ne8Ou5j+w@mail.gmail.com>
Subject: Re: [PATCH 1/4] libselinux: add man page redirections
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 8, 2022 at 1:51 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, May 20, 2022 at 9:36 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The following interfaces are documented but do not have a redirection:
> >
> >   - context_str(3)
> >   - security_get_checkreqprot(3)
> >   - security_set_boolean_list(3)
> >   - selinux_sepgsql_context_path(3)
> >   - setexecfilecon(3)
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>
This series has been merged.
Thanks,
Jim

> > ---
> >  libselinux/man/man3/context_str.3                  | 1 +
> >  libselinux/man/man3/security_get_checkreqprot.3    | 1 +
> >  libselinux/man/man3/security_set_boolean_list.3    | 1 +
> >  libselinux/man/man3/selinux_sepgsql_context_path.3 | 1 +
> >  libselinux/man/man3/setexecfilecon.3               | 1 +
> >  5 files changed, 5 insertions(+)
> >  create mode 100644 libselinux/man/man3/context_str.3
> >  create mode 100644 libselinux/man/man3/security_get_checkreqprot.3
> >  create mode 100644 libselinux/man/man3/security_set_boolean_list.3
> >  create mode 100644 libselinux/man/man3/selinux_sepgsql_context_path.3
> >  create mode 100644 libselinux/man/man3/setexecfilecon.3
> >
> > diff --git a/libselinux/man/man3/context_str.3 b/libselinux/man/man3/co=
ntext_str.3
> > new file mode 100644
> > index 00000000..f4f03a6d
> > --- /dev/null
> > +++ b/libselinux/man/man3/context_str.3
> > @@ -0,0 +1 @@
> > +.so man3/context_new.3
> > diff --git a/libselinux/man/man3/security_get_checkreqprot.3 b/libselin=
ux/man/man3/security_get_checkreqprot.3
> > new file mode 100644
> > index 00000000..d59e5c2c
> > --- /dev/null
> > +++ b/libselinux/man/man3/security_get_checkreqprot.3
> > @@ -0,0 +1 @@
> > +.so man3/security_getenforce.3
> > diff --git a/libselinux/man/man3/security_set_boolean_list.3 b/libselin=
ux/man/man3/security_set_boolean_list.3
> > new file mode 100644
> > index 00000000..29731efa
> > --- /dev/null
> > +++ b/libselinux/man/man3/security_set_boolean_list.3
> > @@ -0,0 +1 @@
> > +.so man3/security_load_booleans.3
> > diff --git a/libselinux/man/man3/selinux_sepgsql_context_path.3 b/libse=
linux/man/man3/selinux_sepgsql_context_path.3
> > new file mode 100644
> > index 00000000..175a611a
> > --- /dev/null
> > +++ b/libselinux/man/man3/selinux_sepgsql_context_path.3
> > @@ -0,0 +1 @@
> > +.so man3/selinux_binary_policy_path.3
> > diff --git a/libselinux/man/man3/setexecfilecon.3 b/libselinux/man/man3=
/setexecfilecon.3
> > new file mode 100644
> > index 00000000..b2e6ab81
> > --- /dev/null
> > +++ b/libselinux/man/man3/setexecfilecon.3
> > @@ -0,0 +1 @@
> > +.so man3/getexeccon.3
> > --
> > 2.36.1
> >
