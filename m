Return-Path: <SRS0=KSUI=QR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6F2C282C2
	for <selinux@archiver.kernel.org>; Sun, 10 Feb 2019 16:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6542176F
	for <selinux@archiver.kernel.org>; Sun, 10 Feb 2019 16:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfBJQtn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 10 Feb 2019 11:49:43 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:42432 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfBJQtn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 10 Feb 2019 11:49:43 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id CB72656125E
        for <selinux@vger.kernel.org>; Sun, 10 Feb 2019 17:49:38 +0100 (CET)
Received: by mail-ot1-f50.google.com with SMTP id 98so1113963oty.1
        for <selinux@vger.kernel.org>; Sun, 10 Feb 2019 08:49:38 -0800 (PST)
X-Gm-Message-State: AHQUAuYF50kT5ejCYumaQBVRGcZJOhstXXe1As4ifWh49q7HGoMKI6LH
        8fqewUvGuoM+on0DVfQlGEvXwgptr80wFPRtuxc=
X-Google-Smtp-Source: AHgI3Ib2LTM6V0IroRJj54gQs8iNlkZHkGWPOQ2hu1uDIQyQOkafAvjQSXAqYFxfH56EmyUV6LNgZnGuJIzfJtiWl1U=
X-Received: by 2002:a9d:6c44:: with SMTP id g4mr22096536otq.368.1549817377779;
 Sun, 10 Feb 2019 08:49:37 -0800 (PST)
MIME-Version: 1.0
References: <CAJfZ7=nLOTU-o5Q9TBmgKqumk=BHC2qHz=6393S=6MY24Jxwxg@mail.gmail.com>
 <20190207102545.28580-1-vmojzis@redhat.com> <CAJfZ7==y+wGjrRwfnsudvc2MO8F0ucJTmnj4k2zomaQCBdD4NQ@mail.gmail.com>
In-Reply-To: <CAJfZ7==y+wGjrRwfnsudvc2MO8F0ucJTmnj4k2zomaQCBdD4NQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 10 Feb 2019 17:49:26 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mmfmN4cDca3+4QqYOpZCEDZW+FSGXaa+UpFntyaPd=Bg@mail.gmail.com>
Message-ID: <CAJfZ7=mmfmN4cDca3+4QqYOpZCEDZW+FSGXaa+UpFntyaPd=Bg@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Update manpage
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 10 17:49:39 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 7, 2019 at 10:03 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Feb 7, 2019 at 11:25 AM Vit Mojzis <vmojzis@redhat.com> wrote:
> >
> > - Add description of -S option
> > - Sort the option descriptions based on the synopsis
> > - Add missing options to synopsis
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.

Nicolas

> > ---
> >  checkpolicy/checkpolicy.8 | 19 +++++++++++--------
> >  checkpolicy/checkpolicy.c |  2 +-
> >  2 files changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
> > index 1c8805d5..8f7dad41 100644
> > --- a/checkpolicy/checkpolicy.8
> > +++ b/checkpolicy/checkpolicy.8
> > @@ -3,7 +3,7 @@
> >  checkpolicy \- SELinux policy compiler
> >  .SH SYNOPSIS
> >  .B checkpolicy
> > -.I "[\-b[F]] [\-C] [\-d] [\-M] [\-c policyvers] [\-o output_file] [input_file]"
> > +.I "[\-b[F]] [\-C] [\-d] [\-U handle_unknown (allow,deny,reject)] [\-M] [\-c policyvers] [\-o output_file] [\-S] [\-t target_platform (selinux,xen)] [\-V] [input_file]"
> >  .br
> >  .SH "DESCRIPTION"
> >  This manual page describes the
> > @@ -21,30 +21,33 @@ policy.conf or policy, depending on whether the \-b flag is specified.
> >  .B \-b,\-\-binary
> >  Read an existing binary policy file rather than a source policy.conf file.
> >  .TP
> > +.B \-F,\-\-conf
> > +Write policy.conf file rather than binary policy file. Can only be used with binary policy file.
> > +.TP
> >  .B \-C,\-\-cil
> >  Write CIL policy file rather than binary policy file.
> >  .TP
> >  .B \-d,\-\-debug
> >  Enter debug mode after loading the policy.
> >  .TP
> > -.B \-F,\-\-conf
> > -Write policy.conf file rather than binary policy file. Can only be used with binary policy file.
> > +.B \-U,\-\-handle-unknown <action>
> > +Specify how the kernel should handle unknown classes or permissions (deny, allow or reject).
> >  .TP
> >  .B \-M,\-\-mls
> >  Enable the MLS policy when checking and compiling the policy.
> >  .TP
> > +.B \-c policyvers
> > +Specify the policy version, defaults to the latest.
> > +.TP
> >  .B \-o,\-\-output filename
> >  Write a binary policy file to the specified filename.
> >  .TP
> > -.B \-c policyvers
> > -Specify the policy version, defaults to the latest.
> > +.B \-S,\-\-sort
> > +Sort ocontexts before writing out the binary policy. This option makes output of checkpolicy consistent with binary policies created by semanage and secilc.
> >  .TP
> >  .B \-t,\-\-target
> >  Specify the target platform (selinux or xen).
> >  .TP
> > -.B \-U,\-\-handle-unknown <action>
> > -Specify how the kernel should handle unknown classes or permissions (deny, allow or reject).
> > -.TP
> >  .B \-V,\-\-version
> >  Show version information.
> >  .TP
> > diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> > index 14dc91a3..e0a00f7c 100644
> > --- a/checkpolicy/checkpolicy.c
> > +++ b/checkpolicy/checkpolicy.c
> > @@ -113,7 +113,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
> >         printf
> >             ("usage:  %s [-b[F]] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M] "
> >              "[-c policyvers (%d-%d)] [-o output_file] [-S] "
> > -            "[-t target_platform (selinux,xen)] [input_file]\n",
> > +            "[-t target_platform (selinux,xen)] [-V] [input_file]\n",
> >              progname, POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
> >         exit(1);
> >  }
> > --
> > 2.17.2
> >

