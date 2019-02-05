Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8B6C282CB
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 07:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB0A2083B
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 07:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfBEHTT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 02:19:19 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:59705 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBEHTT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 02:19:19 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6F97D561203
        for <selinux@vger.kernel.org>; Tue,  5 Feb 2019 08:19:16 +0100 (CET)
Received: by mail-ot1-f48.google.com with SMTP id 81so4193722otj.2
        for <selinux@vger.kernel.org>; Mon, 04 Feb 2019 23:19:16 -0800 (PST)
X-Gm-Message-State: AHQUAuZ4x5yrbgqF1Dk/9ASt9iZVSDSWRyHPD/rUxGEeplJnDOaev7EM
        YCKoANmFCXp5AcgLc0sIplmXiLdHjDl8M0JlPuk=
X-Google-Smtp-Source: AHgI3IYv5XpqaC7t+E85+F0B7yHk5kOQWztS3eE6bVYAzDajCTL6KbZ0AfGeQj7t4WWtgjVcExFJXA2VHRcCRxUl5Lc=
X-Received: by 2002:aca:a86:: with SMTP id k6mr1839972oiy.334.1549351155576;
 Mon, 04 Feb 2019 23:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20190131194824.4944-1-plautrba@redhat.com> <20190131194824.4944-2-plautrba@redhat.com>
 <CAJfZ7==7=Jntk=7_Np3O6R0kE9H7AOdZ3VDu+=Dhnp-ORzKmOg@mail.gmail.com>
In-Reply-To: <CAJfZ7==7=Jntk=7_Np3O6R0kE9H7AOdZ3VDu+=Dhnp-ORzKmOg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 5 Feb 2019 08:19:04 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=n_AOMhxFNeF2DP4g1CcBGv=CiTYqp3q4HoQWjQak7FVw@mail.gmail.com>
Message-ID: <CAJfZ7=n_AOMhxFNeF2DP4g1CcBGv=CiTYqp3q4HoQWjQak7FVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: Change matchpathcon usage to match with
 matchpathcon manpage
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Feb  5 08:19:17 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 31, 2019 at 11:02 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Jan 31, 2019 at 8:48 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged. Thanks
Nicolas

> > ---
> >  libselinux/utils/matchpathcon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
> > index 67e4a433..9756d7d9 100644
> > --- a/libselinux/utils/matchpathcon.c
> > +++ b/libselinux/utils/matchpathcon.c
> > @@ -14,7 +14,7 @@
> >  static __attribute__ ((__noreturn__)) void usage(const char *progname)
> >  {
> >         fprintf(stderr,
> > -               "usage:  %s [-N] [-n] [-f file_contexts] [ -P policy_root_path ] [-p prefix] [-Vq] path...\n",
> > +               "usage:  %s [-V] [-N] [-n] [-m type] [-f file_contexts_file] [-p prefix] [-P policy_root_path] filepath...\n",
> >                 progname);
> >         exit(1);
> >  }
> > --
> > 2.20.1
> >

