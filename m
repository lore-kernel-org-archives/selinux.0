Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB648C282CB
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 07:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939F22081B
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 07:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfBEHRe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 02:17:34 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:47980 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBEHRe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 02:17:34 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D59815611DD
        for <selinux@vger.kernel.org>; Tue,  5 Feb 2019 08:17:29 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id s13so4151236otq.4
        for <selinux@vger.kernel.org>; Mon, 04 Feb 2019 23:17:29 -0800 (PST)
X-Gm-Message-State: AHQUAubDm0/iKW9iwgMtG0oeE662q+QyIE3lSMwNh3aC52ff/U+JjGHy
        k9RUm5vTNGxdjr69GBf+NHQAatdGFvSpkYvXTyU=
X-Google-Smtp-Source: AHgI3IaE1rpytcesZU517nUNgkQoNSfMeNDJ7lffDUXI0NRS32D1CLCt9f07PIscA85KFwveOpA5t730f/IgJ+wxo8s=
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr1864335oth.338.1549351048834;
 Mon, 04 Feb 2019 23:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20190130133300.3415-1-vashirov@redhat.com> <CAJfZ7==AqfrjxZ_7yBt6d_2VsiOQtBPOUgwinmXvfWx6k_2ZMQ@mail.gmail.com>
In-Reply-To: <CAJfZ7==AqfrjxZ_7yBt6d_2VsiOQtBPOUgwinmXvfWx6k_2ZMQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 5 Feb 2019 08:17:17 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nL4xQVP_QRipkE+upk5_cyguLaywoaeggTcoBT8DRvcg@mail.gmail.com>
Message-ID: <CAJfZ7=nL4xQVP_QRipkE+upk5_cyguLaywoaeggTcoBT8DRvcg@mail.gmail.com>
Subject: Re: [PATCH] python/restorecon: add force option
To:     Viktor Ashirov <vashirov@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Feb  5 08:17:30 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 3, 2019 at 11:08 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Wed, Jan 30, 2019 at 2:33 PM Viktor Ashirov <vashirov@redhat.com> wrote:
> >
> > This adds 'force' keyword argument to selinux.restorecon() function
> > using SELINUX_RESTORECON_SET_SPECFILE_CTX flag.
> >
> > Signed-off-by: Viktor Ashirov <vashirov@redhat.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged. Thanks!
Nicolas

> > ---
> >  libselinux/src/selinuxswig_python.i | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
> > index 2af7c7e0..4c73bf92 100644
> > --- a/libselinux/src/selinuxswig_python.i
> > +++ b/libselinux/src/selinuxswig_python.i
> > @@ -20,7 +20,7 @@ DISABLED = -1
> >  PERMISSIVE = 0
> >  ENFORCING = 1
> >
> > -def restorecon(path, recursive=False, verbose=False):
> > +def restorecon(path, recursive=False, verbose=False, force=False):
> >      """ Restore SELinux context on a given path
> >
> >      Arguments:
> > @@ -29,6 +29,9 @@ def restorecon(path, recursive=False, verbose=False):
> >      Keyword arguments:
> >      recursive -- Change files and directories file labels recursively (default False)
> >      verbose -- Show changes in file labels (default False)
> > +    force -- Force reset of context to match file_context for customizable files,
> > +    and the default file context, changing the user, role, range portion  as well
> > +    as the type (default False)
> >      """
> >
> >      restorecon_flags = SELINUX_RESTORECON_IGNORE_DIGEST | SELINUX_RESTORECON_REALPATH
> > @@ -36,6 +39,8 @@ def restorecon(path, recursive=False, verbose=False):
> >          restorecon_flags |= SELINUX_RESTORECON_RECURSE
> >      if verbose:
> >          restorecon_flags |= SELINUX_RESTORECON_VERBOSE
> > +    if force:
> > +        restorecon_flags |= SELINUX_RESTORECON_SET_SPECFILE_CTX
> >      selinux_restorecon(os.path.expanduser(path), restorecon_flags)
> >
> >  def chcon(path, context, recursive=False):
> > --
> > 2.20.1
> >

