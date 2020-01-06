Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE91C33C8C
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 22:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE1D2072A
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 22:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KT3zTq13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgAFW0g (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:26:36 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33295 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgAFW0f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 17:26:35 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so51820616otp.0
        for <selinux@vger.kernel.org>; Mon, 06 Jan 2020 14:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxfnlzR8Z4ts/JAYctHXiWfBXAVi4Rg1+RqTkuxcXH0=;
        b=KT3zTq13pwos3lUHyrco2lsAUWV1EAmrdS4rtw5xveHovt/+6pDL09kW9Ah4vhaDtm
         WaQoZdUA+TVRoB+VboEKRwhnRBaQMTgHSyDlkebw8+92WLTfEQY0TeE6KMtVMNma75FZ
         /0Su8D2L8COpd1ADE6dvVNrFzuyR+9tbIewVaht1E2oyZHlbk2jXZzU8FU9owkSMLs/7
         wyftUApIEdV5rYxtUByhbx1ASniTjeUDluhBGktPAD7sXfuMCezwUvt3XnWmK3YZofCV
         rTXKaN4t9D2CHuh6wPGSvza01dPbi8pWHrrcPR93JbwiFAihEESqZrIMuZBbAYLTJjvj
         eyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxfnlzR8Z4ts/JAYctHXiWfBXAVi4Rg1+RqTkuxcXH0=;
        b=T1sCyVe1nRV7hJXwLINTyuGzrHa3vt6LVrZWV+AeGCF5OdBOKEwJc/Z31OTRuTKyVw
         XpXMcGkupN7+XvUsLW6Hcy4wDeTl8waIEWqp/Kh+RmKkju2fWwfJex3ZHlXUOtwc7Ie/
         G3nZ3DNsL7xbQQ7K54NCzJfpF/Eu+fGIUIw/UYK/DhZViUoDvE0eCwridrVBjOvd9S3+
         wBrGs8j64gJ/y+f8giojUkHiVeuNlX6IYEltjnRlgHitjtjD7HBjpm9Le9JsDh527YDs
         uMgI548GVtiidzr+drjGaPTaDCpUwPLfu1PvHGsReQgaqmi+57+3xuz8YANtSZbVmvwz
         xyOQ==
X-Gm-Message-State: APjAAAUHvdJQzqirJBRw+EXo4PYiZwVOBgZdJb7JSPOalPl4iViYS1Hb
        Udyt47riAR68kAByeMxmTOHWcJRTt6lWaRPATKAPl59L
X-Google-Smtp-Source: APXvYqwL3jAWdvMDMj4aRBZmqvQUERlVV6jXvZVasskn9QFt2yWJfcehfWgI+srl/dO2csohUYzK2dK4JXfZgXIo96Q=
X-Received: by 2002:a9d:644a:: with SMTP id m10mr14535027otl.97.1578349594831;
 Mon, 06 Jan 2020 14:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20200106181329.167322-1-hridya@google.com> <d78e4db4-5847-082c-189a-f13d7d6a6c7a@tycho.nsa.gov>
 <CA+wgaPMHWOVYo_pVeYuvj6CrQOgy9=vQco+tnGHjPX3=CLh5wA@mail.gmail.com> <c1354989-1e08-1433-f2c0-5984da341cf5@tycho.nsa.gov>
In-Reply-To: <c1354989-1e08-1433-f2c0-5984da341cf5@tycho.nsa.gov>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Mon, 6 Jan 2020 14:25:58 -0800
Message-ID: <CA+wgaPNWxpa4bUqer2kJZBATEf1NRvGD2pN4_mkev2NiS7U-Sw@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: allow per-file labelling for binderfs
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        Mark Salyzyn <salyzyn@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 6, 2020 at 11:33 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 1/6/20 2:06 PM, Hridya Valsaraju wrote:
> > On Mon, Jan 6, 2020 at 10:33 AM 'Stephen Smalley' via kernel-team
> > <kernel-team@android.com> wrote:
> >>
> >> On 1/6/20 1:13 PM, Hridya Valsaraju wrote:
> >>> This patch allows genfscon per-file labeling for binderfs.
> >>> This is required to have separate permissions to allow
> >>> access to binder, hwbinder and vndbinder devices which are
> >>> relocating to binderfs.
> >>>
> >>> Acked-by: Jeff Vander Stoep <jeffv@google.com>
> >>> Acked-by: Mark Salyzyn <salyzyn@android.com>
> >>> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> >>
> >> Do you want binderfs to also support userspace labeling of files via
> >> setxattr()?  If so, you'll want to also add it to
> >> selinux_is_genfs_special_handling() as well.
> >
> > Thank you for the quick response Stephen :) I cannot think of a
> > use-case for the userspace labelling of files in binderfs via
> > setxattr() as of now. I
> > will make the change if one comes up!
>
> Ok, then you can include my:
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Great! Thank you for reviewing my patch Stephen!

Regards,
Hridya

>
> >
> > Thanks,
> > Hridya
> >
> >
> >>
> >>> ---
> >>>    security/selinux/hooks.c | 1 +
> >>>    1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >>> index 116b4d644f68..3f0669a708e9 100644
> >>> --- a/security/selinux/hooks.c
> >>> +++ b/security/selinux/hooks.c
> >>> @@ -752,6 +752,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
> >>>
> >>>        if (!strcmp(sb->s_type->name, "debugfs") ||
> >>>            !strcmp(sb->s_type->name, "tracefs") ||
> >>> +         !strcmp(sb->s_type->name, "binderfs") ||
> >>>            !strcmp(sb->s_type->name, "pstore"))
> >>>                sbsec->flags |= SE_SBGENFS;
> >>>
> >>>
> >>
> >> --
> >> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >>
>
