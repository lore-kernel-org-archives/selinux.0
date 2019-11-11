Return-Path: <SRS0=VxLC=ZD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C117BC43331
	for <selinux@archiver.kernel.org>; Mon, 11 Nov 2019 09:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA80206C3
	for <selinux@archiver.kernel.org>; Mon, 11 Nov 2019 09:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfKKJuu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:50:50 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:39244 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKJuu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Nov 2019 04:50:50 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B0E755613AE
        for <selinux@vger.kernel.org>; Mon, 11 Nov 2019 10:50:45 +0100 (CET)
Received: by mail-oi1-f169.google.com with SMTP id y194so10978252oie.4
        for <selinux@vger.kernel.org>; Mon, 11 Nov 2019 01:50:45 -0800 (PST)
X-Gm-Message-State: APjAAAXPKTfNdhzscQv9IAFDh+5E4Ntt3+DyHrHrTJIwOraSmH4AUBY2
        FRbv2YnBQGpIlC5C93Hc8Wx33ZmatmP648179oE=
X-Google-Smtp-Source: APXvYqxCtwRHNsjK+dUgEKYFyPe7Vmmxk4eCqia2uIqnZKk5sHuP1WIEUwj82EHlU+EeU8rXjWQkg9yyS6q07Zu3fPg=
X-Received: by 2002:aca:5709:: with SMTP id l9mr23161135oib.163.1573465844687;
 Mon, 11 Nov 2019 01:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20191101092724.7650-1-nicolas.iooss@m4x.org> <40955c0d-85fe-80db-a55f-fa0083556a0b@tycho.nsa.gov>
In-Reply-To: <40955c0d-85fe-80db-a55f-fa0083556a0b@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 11 Nov 2019 10:50:32 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mpbb73sf9BsD9Zw9a0Jzyc+vM_LS5_3GXRy-EEyvb=Jg@mail.gmail.com>
Message-ID: <CAJfZ7=mpbb73sf9BsD9Zw9a0Jzyc+vM_LS5_3GXRy-EEyvb=Jg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Makefile: fix cleaning files that starts with "-"
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Michael Shigorin <mike@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Nov 11 10:50:46 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 4, 2019 at 4:16 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 11/1/19 5:27 AM, Nicolas Iooss wrote:
> > libselinux/src/exception.sh creates a file named "-.o". This file is
> > usually removed at the end of this script, but some failures in it could
> > left it on the filesystem. "make clean" is then supposed to remove this
> > file, but fails instead with:
> >
> >      rm: invalid option -- '.'
> >      Try 'rm ./-.o' to remove the file '-.o'.
> >      Try 'rm --help' for more information.
> >
> > This is due to "rm -f *.o" being expanded to "rm -f -.o". Prevent this
> > buggy expansion by using "./*.o" in the command line. While at it, do so
> > for other patterns like "*~".
>
> Does any other software package use this idiom for clean?  I haven't
> seen it.  I'm wondering if we aren't better off doing any/all of the
> following:
>
> 1) Fix exception.sh to not create files starting in "-",
> 2) Fix our clean targets to only delete explicitly generated object file
> lists; some of them at least already have $(OBJS) $(LOBJS) so why do we
> need the extra wildcard?
> 3) Maybe use $(wildcard ...)?

The only over software that use "./*..." or "rm -- *..." are those
which handle directories with "untrusted content", ie. with files
whose names may be created by an attacker. Such as threat model is not
applicable on a build management system, which is why only few
projects use ./* or "rm --" in "make clean".

Therefore I agree with considering that creating a file starting with
"-" is a bug. I will send a patch to fix exception.sh (by adding "-o
temp.o" to some commands). Thanks for your feedback.
Nicolas

