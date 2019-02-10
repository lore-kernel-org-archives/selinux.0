Return-Path: <SRS0=KSUI=QR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B929C282C2
	for <selinux@archiver.kernel.org>; Sun, 10 Feb 2019 16:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93E62176F
	for <selinux@archiver.kernel.org>; Sun, 10 Feb 2019 16:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfBJQt5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 10 Feb 2019 11:49:57 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:38634 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfBJQt5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 10 Feb 2019 11:49:57 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6FBE0561265
        for <selinux@vger.kernel.org>; Sun, 10 Feb 2019 17:49:54 +0100 (CET)
Received: by mail-ot1-f51.google.com with SMTP id s5so13745001oth.7
        for <selinux@vger.kernel.org>; Sun, 10 Feb 2019 08:49:54 -0800 (PST)
X-Gm-Message-State: AHQUAuZmV7UJnxuvep6mQ9CCTY2EDrT0FxP1f+/kqPpMKDrpj/FG4RBC
        MJewerGR0QQFRtF7Od3Wk0A0ebnyNuWbnHiwqN8=
X-Google-Smtp-Source: AHgI3IboiZwquehheppoAzNwisS0Ncooj0tTgC5+TJLzZTxqkWm+17qN1avOo9YPBj9Qvt1RsPuIdVX4ucOadZNDbQs=
X-Received: by 2002:a05:6830:1658:: with SMTP id h24mr12409219otr.301.1549817393579;
 Sun, 10 Feb 2019 08:49:53 -0800 (PST)
MIME-Version: 1.0
References: <pjdmun8x8v1.fsf@redhat.com> <20190207091844.11336-1-plautrba@redhat.com>
 <CAJfZ7=mCJu_e1hzkmWHZpctCgQgzW9jPzt19Lw1rVsP=N2ygDw@mail.gmail.com>
In-Reply-To: <CAJfZ7=mCJu_e1hzkmWHZpctCgQgzW9jPzt19Lw1rVsP=N2ygDw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 10 Feb 2019 17:49:42 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==8NyqqHiZB_CfPEbZCZFfK=TFLPoKECXkCUa=FTg251Q@mail.gmail.com>
Message-ID: <CAJfZ7==8NyqqHiZB_CfPEbZCZFfK=TFLPoKECXkCUa=FTg251Q@mail.gmail.com>
Subject: Re: [PATCH v2] dbus: Fix name of polkit function
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, Dan Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 10 17:49:54 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 7, 2019 at 10:04 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Feb 7, 2019 at 10:18 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > From: Dan Walsh <dwalsh@redhat.com>
> >
> > Add missing action org.selinux.change_default_mode for change_default_mode() and
> > remove unused action org.selinux.change_policy_type.
> >
> > Fixes: e8718ef51463 ("Make sure we do the polkit check on all dbus interfaces.")
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.

Nicolas

> > ---
> >  dbus/org.selinux.policy | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/dbus/org.selinux.policy b/dbus/org.selinux.policy
> > index 01266102..9772127b 100644
> > --- a/dbus/org.selinux.policy
> > +++ b/dbus/org.selinux.policy
> > @@ -70,9 +70,9 @@
> >           <allow_active>auth_admin_keep</allow_active>
> >          </defaults>
> >      </action>
> > -    <action id="org.selinux.change_policy_type">
> > -        <description>SELinux write access</description>
> > -        <message>System policy prevents change_policy_type access to SELinux</message>
> > +    <action id="org.selinux.change_default_mode">
> > +        <description>Change SELinux default enforcing mode</description>
> > +        <message>System policy prevents change_default_policy access to SELinux</message>
> >          <defaults>
> >            <allow_any>no</allow_any>
> >            <allow_inactive>no</allow_inactive>
> > --
> > 2.20.1
> >

