Return-Path: <SRS0=j9Lo=ZI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C667C432C3
	for <selinux@archiver.kernel.org>; Sat, 16 Nov 2019 17:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7940821844
	for <selinux@archiver.kernel.org>; Sat, 16 Nov 2019 17:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfKPRE7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 16 Nov 2019 12:04:59 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:35749 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfKPRE6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 16 Nov 2019 12:04:58 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1350E5646CE
        for <selinux@vger.kernel.org>; Sat, 16 Nov 2019 18:04:54 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id n23so10770026otr.13
        for <selinux@vger.kernel.org>; Sat, 16 Nov 2019 09:04:53 -0800 (PST)
X-Gm-Message-State: APjAAAVILzJzcUuJbuEtiJb0uLmiSOwFrFQiNW9dpIpx5oyvzkkb6yQ+
        RQCPUpUvlGjLB0O8qawmtmTDqsIxFs+2Fymm4qo=
X-Google-Smtp-Source: APXvYqywt38pcT8dq7El1ovXFerFZmeovDd/bcV788njguYOmGRP9z0uJbtFF8/lYIBBS6vH2k0kPYv6E9ObfwkL+4s=
X-Received: by 2002:a9d:3b0:: with SMTP id f45mr16792733otf.92.1573923892949;
 Sat, 16 Nov 2019 09:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20191115145425.1460016-1-plautrba@redhat.com> <6ce96a14-0be8-5829-7fa4-e84d7f33c678@tycho.nsa.gov>
In-Reply-To: <6ce96a14-0be8-5829-7fa4-e84d7f33c678@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 16 Nov 2019 18:04:41 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mBDX3c9rM42qYvsQebKV6MA_YGvSMmbu2BtCrjCAXZDg@mail.gmail.com>
Message-ID: <CAJfZ7=mBDX3c9rM42qYvsQebKV6MA_YGvSMmbu2BtCrjCAXZDg@mail.gmail.com>
Subject: Re: [PATCH] dbus: Fix FileNotFoundError in org.selinux.relabel_on_boot
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Nov 16 18:04:54 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 15, 2019 at 4:01 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 11/15/19 9:54 AM, Petr Lautrbach wrote:
> > When org.selinux.relabel_on_boot(0) was called twice, it failed with
> > FileNotFoundError.
> >
> > Fixes:
> >      $ dbus-send --system --print-reply --dest=org.selinux /org/selinux/object org.selinux.relabel_on_boot int64:1
> >      method return sender=:1.53 -> dest=:1.54 reply_serial=2
> >      $ dbus-send --system --print-reply --dest=org.selinux /org/selinux/object org.selinux.relabel_on_boot int64:0
> >      method return sender=:1.53 -> dest=:1.55 reply_serial=2
> >      $ dbus-send --system --print-reply --dest=org.selinux /org/selinux/object org.selinux.relabel_on_boot int64:0
> >      Error org.freedesktop.DBus.Python.FileNotFoundError: FileNotFoundError: [Errno 2] No such file or directory: '/.autorelabel'
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > ---
> >
> > Note: This is python 3 only code and it fails in travis with PYVER=python2.7 RUBYLIBVER=2.6:
> >
> > $ PATH="$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8
> >
> > Analyzing 187 Python scripts
> >
> > ./dbus/selinux_server.py:90:20: F821 undefined name 'FileNotFoundError'
> >
> > ./installdir/usr/share/system-config-selinux/selinux_server.py:90:20: F821 undefined name 'FileNotFoundError'
> >
> > The command "PATH="$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8" exited with 1.
>
> Hmm...given that, do we want to defer it until after 3.0 final release,
> or are we going to switch travis over to only test with python3 now?

Hello, I personally do not have a strong opinion about dropping Python
2 support before or after 3.0 final release (for information, the Arch
Linux packages will be Python 3-only anyway, because the distribution
maintainers began dropping related Python 2 packages such as
python2-audit).

Nevertheless, on the patch itself, I am wondering whether
"FileNotFoundError" could be replaced with "OSError" in order to make
it compatible with Python 2. The main drawback of this alternative
approach is that it silences PermissionError and other kind of errors
that could be useful when debugging some issues on a production
system. This is why I prefer keeping "FileNotFoundError", and the
patch looks good to me.

Thanks,
Nicolas

> >
> >   dbus/selinux_server.py | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/dbus/selinux_server.py b/dbus/selinux_server.py
> > index b9debc071485..be4f4557a9fa 100644
> > --- a/dbus/selinux_server.py
> > +++ b/dbus/selinux_server.py
> > @@ -85,7 +85,10 @@ class selinux_server(slip.dbus.service.Object):
> >               fd = open("/.autorelabel", "w")
> >               fd.close()
> >           else:
> > -            os.unlink("/.autorelabel")
> > +            try:
> > +                os.unlink("/.autorelabel")
> > +            except FileNotFoundError:
> > +                pass
> >
> >       def write_selinux_config(self, enforcing=None, policy=None):
> >           path = selinux.selinux_path() + "config"
> >
>

