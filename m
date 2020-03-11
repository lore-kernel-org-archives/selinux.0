Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CF9C4CEC0
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C711D20736
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+Lu5GUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgCKSxx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:53:53 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39867 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbgCKSxx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 14:53:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id a9so3213697otl.6
        for <selinux@vger.kernel.org>; Wed, 11 Mar 2020 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdJCWewEbnBv/Zm/Z+MsCON8A++W+Jg0e4SL73LPNUU=;
        b=q+Lu5GUtRdQk1E5xQ62T58fyj+BY9cfvAIB8/zVxYqQphivG6zNEbj4+NlGQppPwGb
         9oxKaWHPAtAfWYk31YsD10H+JwVmXYyByCGcIxDsPz1HWYOqkKSlqfo22ZKltGg9XrEL
         vXpg3qEKZmKusJd8Qymy0CfU2ntztRa3oBIP5O33aZHzn9YEeNv6yYrT+Tnbso/h6iN6
         gEKUMvzowHjNnhPHWCxCmxlZwZhQHOwHpaINV5zb/odPNc9PO2BluHZD0Lffd6s0h0G9
         t6CKqo0D2LvuOEiySvv47tEBFIKdEotxlall7W4V36WMXA0whzVyeTrXSxDR2zGTd9fM
         dZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdJCWewEbnBv/Zm/Z+MsCON8A++W+Jg0e4SL73LPNUU=;
        b=f0o95ykwSVeDkEWN5UacLiRb8FWsss6XbGv3IysqF8AjjN9lwj42XQDAiIJIOBcV2M
         KeG2KmLmAkyskPeQ8mHV7kwi/B2Ht0JjEa/mPk4uj+ft7VLa9RcdP8f7HkPo9sqWfqii
         xwdtCPCjK8RUIj77EjxHukqSybGh74FHJfZwGN1lwWV7aKfiSsU0+9DHBMR+qCFpthY6
         rP+ljwftHPM0SAfkmkeRuKLxE6BGrDwKSH8/O2fl5mKOaXZMp6gdQPT7EVWLCNL26JxB
         FyI3UnrJLWilCTBVsM+6Pqp5lLwAJti4Yp5ycwZlmg5BzLCCq8CEMq5pRIEVTXbyaZJP
         BKew==
X-Gm-Message-State: ANhLgQ3X7KcbekCDeKRmGbfjpACfnRw4mXmEGcaB2V4bzjdA3fcQbJw6
        kSghzhkda5rA2u1J2I2jmQkDlibg6hwPxGoERYw=
X-Google-Smtp-Source: ADFU+vsGabHugJOr3guCyW3fcJEKCDxWgYhrf0r4f8UybiyQ1AfpVcoDfKAnTIV4232SQNTakDsXiSDS3P+Qh/PLtw4=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr3442400otl.135.1583952832070;
 Wed, 11 Mar 2020 11:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200309152539.8581-1-william.c.roberts@intel.com>
 <20200310210854.466-1-william.c.roberts@intel.com> <20200310210854.466-4-william.c.roberts@intel.com>
 <CAEjxPJ4FTpQRTp2ChKrsyYUZMwicKQ_vT=BCgCDdpXLGLtODCA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4FTpQRTp2ChKrsyYUZMwicKQ_vT=BCgCDdpXLGLtODCA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 11 Mar 2020 14:54:44 -0400
Message-ID: <CAEjxPJ4jwxi8sDkwkG9EiusTPHC_qPK2Aq6v8YhsTSc-MouoPA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lbespol: remove wild cards in mapfile
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 11, 2020 at 2:53 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Mar 10, 2020 at 5:09 PM <bill.c.roberts@gmail.com> wrote:
> >
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > With the old hidden_def and hidden_proto DSO infrastructure removed,
> > correctness of the map file becomes paramount, as it is what filters out
> > public API. Because of this, the wild cards should not be used, as it
> > lets some functions through that should not be made public API. Thus
> > remove the wild cards, and sort the list.
> >
> > Additionally, verify that nothing changed in external symbols as well:
> >
> > This was checked by generating an old export map (from master):
> > nm --defined-only -g ./src/libsepol.so | cut -d' ' -f 3-3 | grep -v '^_' > old.map
> >
> > Then creating a new one for this library after this patch is applied:
> > nm --defined-only -g ./src/libsepol.so | cut -d' ' -f 3-3 | grep -v '^_' > new.map
> >
> > And diffing them:
> > diff old.map new.map
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
>
> Other than the typo in the subject line,
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> This should fix https://github.com/SELinuxProject/selinux/issues/204

and https://github.com/SELinuxProject/selinux/issues/165
