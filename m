Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5D6C43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 19:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1777B207FF
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 19:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="LPeScoB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfLJT32 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:29:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38279 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfLJT32 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 14:29:28 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so14684117lfm.5
        for <selinux@vger.kernel.org>; Tue, 10 Dec 2019 11:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwC2Vjk4J0kQIfuygU5KWEbEvymx+2P/ZQKGv/C/8WQ=;
        b=LPeScoB2I58kmTT04Z1jaXN0z/1V80IuExeyOZ2MwBvyymYZiLX0hJ6/a3XMiZ5TfN
         boO9pgNYCZv/UxlsS22ltUfnSDaH7fuMhD3kneNWNAg1PGPbXfHC1R34Wzeji3CF+t7Z
         uh1Ty3Yql8emUIX8V67oEgrKmLr8zxK2tOtSRhRr+Z6e3SBjFG2wjGlqH6S5orK4+tUD
         EnfhKm7PhgzlCXGQhlPhpdb7M7O+YrtoNVo+5AilokXWoG384OmmewJaXWVdHzBlDvcq
         oMUR8DbhJZrql/adXc08SkCNCGEDat4x8cB/vss4HE8Rt9J4aN5OxgsUGqlzbokGOSZI
         WtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwC2Vjk4J0kQIfuygU5KWEbEvymx+2P/ZQKGv/C/8WQ=;
        b=af8+EOvvZ+b43k0ca9sOVx5MQ1hw09HZ4DMhX8+m1epnh2kuzUyA+4ye8libX4cUJ5
         dcdvQ10o6r7VnbW5KQqYOkdBwraQmyUz0Lt0iHmPsQRxZWn3iu2G6a1j9jZEkRrW6eOT
         0uygOlivYy2JC0ac72/2mHmu+OoVYBtqCoTLEXU7bsanWd2g4CmwS5ifzSeZPnSUVN4+
         stg0wNWk8HEs7y9pRnzxoz7jRvyWphYwyADi0j4fbLQaBBVPQ4BDuX/KRKxKzhlR9iol
         W3z7esxPoJ1ZgaqLfCfo1Qyyb1DzxzVADZteLkvf5fYehxRauM7iXySzncCpE22ftl6e
         2ipQ==
X-Gm-Message-State: APjAAAVTydSNGGmAmhyqIQ+601emRGFXf9h57Uh0Aug9sQrcC4nxf18e
        fWBmeEm6PiS1iWk4P3L5OfjDIsv+NJ9WbBDydh6M
X-Google-Smtp-Source: APXvYqyYZ/vqZiFyAmeFDIrv+ot5mM9kq/YLqLZlX0R+fCidku4qIbNB83ZEx8+VclMtDI7R3Nx1hhsO9dVYPdUHALg=
X-Received: by 2002:ac2:424d:: with SMTP id m13mr19723575lfl.13.1576006166358;
 Tue, 10 Dec 2019 11:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20191209075756.123157-1-omosnace@redhat.com> <23671223-f841-564c-6ae8-0401bce0fa20@tycho.nsa.gov>
 <CAFqZXNvMHEvv0tP7ybFEsH1-CvE5GGC9fEP=yXqEnQmjxgdDjA@mail.gmail.com>
In-Reply-To: <CAFqZXNvMHEvv0tP7ybFEsH1-CvE5GGC9fEP=yXqEnQmjxgdDjA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 10 Dec 2019 14:29:15 -0500
Message-ID: <CAHC9VhRe=xdz9eD9q8mO8=3QDVfsRpn7OUyXDj7o4C-cYfFHMQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: reorder hooks to make runtime disable less broken
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 10, 2019 at 6:19 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Dec 9, 2019 at 2:21 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 12/9/19 2:57 AM, Ondrej Mosnacek wrote:
> > > Commit b1d9e6b0646d ("LSM: Switch to lists of hooks") switched the LSM
> > > infrastructure to use per-hook lists, which meant that removing the
> > > hooks for a given module was no longer atomic. Even though the commit
> > > clearly documents that modules implementing runtime revmoval of hooks
> > > (only SELinux attempts this madness) need to take special precautions to
> > > avoid race conditions, SELinux has never addressed this.
> > >
> > > By inserting an artificial delay between the loop iterations of
> > > security_delete_hooks() (I used 100 ms), booting to a state where
> > > SELinux is enabled, but policy is not yet loaded, and running these
> > > commands:
> > >
> > >      while true; do ping -c 1 <some IP>; done &
> > >      echo -n 1 >/sys/fs/selinux/disable
> > >      kill %1
> > >      wait
> > >
> > > ...I was able to trigger NULL pointer dereferences in various places. I
> > > also have a report of someone getting panics on a stock RHEL-8 kernel
> > > after setting SELINUX=disabled in /etc/selinux/config and rebooting
> > > (without adding "selinux=0" to kernel command-line).
> > >
> > > Reordering the SELinux hooks such that those that allocate structures
> > > are removed last seems to prevent these panics. It is very much possible
> > > that this doesn't make the runtime disable completely race-free, but at
> > > least it makes the operation much less fragile.
> > >
> > > An alternative (and safer) solution would be to add NULL checks to each
> > > hook, but doing this just to support the runtime disable hack doesn't
> > > seem to be worth the effort...
> >
> > Personally, I would prefer to just get rid of runtime disable
> > altogether; it also precludes making the hooks read-only after
> > initialization.  IMHO, selinux=0 is the proper way to disable SELinux if
> > necessary.  I believe there is an open bugzilla on Fedora related to
> > this issue, since runtime disable was originally introduced for Fedora.
>
> I, too, would like to see it gone, but removing it immediately would
> likely cause issues for existing users (see [1]) ...
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1430944#c2

For the record, and for those who didn't click on the RHBZ link above,
I'm a big fan of getting rid of SELinux's runtime disable but concede
that it must be done in such a way to as not horribly break userspace.

-- 
paul moore
www.paul-moore.com
