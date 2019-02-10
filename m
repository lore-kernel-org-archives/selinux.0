Return-Path: <SRS0=KSUI=QR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29552C282C2
	for <selinux@archiver.kernel.org>; Sun, 10 Feb 2019 16:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D1E2176F
	for <selinux@archiver.kernel.org>; Sun, 10 Feb 2019 16:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfBJQvP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 10 Feb 2019 11:51:15 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:59374 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfBJQvP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 10 Feb 2019 11:51:15 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D010656126A
        for <selinux@vger.kernel.org>; Sun, 10 Feb 2019 17:51:12 +0100 (CET)
Received: by mail-ot1-f45.google.com with SMTP id 98so1117665oty.1
        for <selinux@vger.kernel.org>; Sun, 10 Feb 2019 08:51:12 -0800 (PST)
X-Gm-Message-State: AHQUAuYCdkz7D7icxxk4I/wzIyCu9AfaIIFUwZQCX8FmvGg0OPPQfoOy
        b31eE/Ej3KbzTCTlufM9HA4y0HffgtdnqzQ5NGU=
X-Google-Smtp-Source: AHgI3Iau8xnw6LeWXHS/84tMXvm75OmyWWi4PGAWF5OmV8Tn+AHwnMpG7XWY0SbAdIF6Y1fzIqdyN1BT/3qG5lsCI9c=
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr23546113oth.338.1549817471973;
 Sun, 10 Feb 2019 08:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20190206194325.24875-1-plautrba@redhat.com> <20190206194325.24875-2-plautrba@redhat.com>
 <CAJfZ7==AuhPnrqqiBDh8YAQ9X7_G2VxGTDR7wdr7xSm7UVLPrQ@mail.gmail.com>
In-Reply-To: <CAJfZ7==AuhPnrqqiBDh8YAQ9X7_G2VxGTDR7wdr7xSm7UVLPrQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 10 Feb 2019 17:51:01 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=k0kLPqjeBgwf+_pusGxvsiaYHD=qgG16eqfHzonEd9+A@mail.gmail.com>
Message-ID: <CAJfZ7=k0kLPqjeBgwf+_pusGxvsiaYHD=qgG16eqfHzonEd9+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] python/semanage: Use standard argparse.error() method
 in handlePermissive
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 10 17:51:13 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 7, 2019 at 10:47 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Wed, Feb 6, 2019 at 8:43 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > This method prints a usage message including the message to the standard error
> > and terminates the program with a status code of 2.
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> For this patch:
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.

Nicolas

> > ---
> >  python/semanage/semanage | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/python/semanage/semanage b/python/semanage/semanage
> > index 9b737fa8..a9fcb319 100644
> > --- a/python/semanage/semanage
> > +++ b/python/semanage/semanage
> > @@ -743,9 +743,7 @@ def handlePermissive(args):
> >          if args.action == "delete":
> >              OBJECT.delete(args.type)
> >      else:
> > -        args.parser.print_usage(sys.stderr)
> > -        sys.stderr.write(_('semanage permissive: error: the following argument is required: type\n'))
> > -        sys.exit(1)
> > +        args.parser.error(message=_('semanage permissive: error: the following argument is required: type\n'))
> >
> >
> >  def setupPermissiveParser(subparsers):
> > --
> > 2.20.1
> >

