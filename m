Return-Path: <SRS0=N/SO=R5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D6AC43381
	for <selinux@archiver.kernel.org>; Tue, 26 Mar 2019 21:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6D2206B7
	for <selinux@archiver.kernel.org>; Tue, 26 Mar 2019 21:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfCZVeI convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:34:08 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:54782 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfCZVeI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Mar 2019 17:34:08 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7F0CE5646F5
        for <selinux@vger.kernel.org>; Tue, 26 Mar 2019 22:34:05 +0100 (CET)
Received: by mail-oi1-f177.google.com with SMTP id v7so11196642oie.8
        for <selinux@vger.kernel.org>; Tue, 26 Mar 2019 14:34:05 -0700 (PDT)
X-Gm-Message-State: APjAAAXuvVLg6vuZtE1exIJUSm66yCQ1FOnMDDryduUQJqjH1ArI7uaJ
        5guY4IEfstWtAczyNobuwCh500jPdhMkRaxxPPM=
X-Google-Smtp-Source: APXvYqzfXmcnZNmlxQ88iX2dIUq1EQ1qbl4HHHF1jcsQYmH6eO/H5TwLROlds24EXcrgvsv/0b5lek7lgyZf669ocP4=
X-Received: by 2002:aca:ac4d:: with SMTP id v74mr14987237oie.50.1553636044376;
 Tue, 26 Mar 2019 14:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190318210913.2392-1-nicolas.iooss@m4x.org> <pjdlg18ihf8.fsf@redhat.com>
 <877ecspgz0.fsf@gmail.com>
In-Reply-To: <877ecspgz0.fsf@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 26 Mar 2019 22:33:53 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kN1CUYGiePHoE_HYw9NVRWErTKuWyet35_EMEiChMqgQ@mail.gmail.com>
Message-ID: <CAJfZ7=kN1CUYGiePHoE_HYw9NVRWErTKuWyet35_EMEiChMqgQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] restorecond: use /run instead of /var/run
To:     Dominick Grift <dac.override@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org,
        Laurent Bigonville <bigon@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Mar 26 22:34:06 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 21, 2019 at 1:08 PM Dominick Grift <dac.override@gmail.com> wrote:
>
> Petr Lautrbach <plautrba@redhat.com> writes:
>
> > Nicolas Iooss <nicolas.iooss@m4x.org> writes:
> >
> >> On most distributions, /var/run is a symbolic link to /run so using
> >> /var/run or /run lead to the same result. Nevertheless systemd
> >> started
> >> to warn about using /var/run in a service file, logging entries such
> >> as:
> >>
> >>     /usr/lib/systemd/system/restorecond.service:8: PIDFile=
> >> references
> >>     path below legacy directory /var/run/, updating
> >>     /var/run/restorecond.pid → /run/restorecond.pid; please
> >> update the
> >>     unit file accordingly.
> >>
> >> Switch to /run in order to follow this advice.
> >>
> >> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> There are other occurances of "/var/run" tree-wide. Some more important
> than others: cd selinux; grep -r "/var/run" .

Are all distribution using /run instead of /var/run with a symlink
from /var/run to /run? For me, it is all right to move a PID file,
which is only shared between the service and the service manager, but
moving files such as the Unix socket /var/run/setrans/.setrans-unix
could cause issues on systems where /var/run and /run are different
directories.

Also, policycoreutils/scripts/fixfiles currently contains:

find /var/run \( -context "*:${UNLABELED}*" -o -context
"*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /var/run
{} \;

This command does not do anything useful when /var/run is a symlink
(either a slash needs to be added to the path, in order to use
/var/run, or /run needs to be specified too). Right now I do not have
much time to investigate how several distributions configure their
/run and /var/run directories (I am writing a research paper related
to Dell's iDRAC system, which appears to be using SELinux since its
version 9). If nobody else does this, I plan doing this work in April.

Thanks,
Nicolas

