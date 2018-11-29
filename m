Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F27C43441
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 11:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A015F20673
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 11:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iOH2IbJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A015F20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeK2WJb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:09:31 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36761 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeK2WJb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 17:09:31 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so2988798itj.1
        for <selinux@vger.kernel.org>; Thu, 29 Nov 2018 03:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UTSZ+NIsXuvldaMkrRodw1dSZWFfY/im96/BMN7oX2c=;
        b=iOH2IbJZE8BOpVqeIw/QxneX8rrhNSl3HnyaVM0YXD5Lp2p0mCa0De2tGnvAWhz9Do
         3xOexO6kkZh5IfNR0g4d9daobgKb1PENjwNMMlnHqee+5/i94GlvJt7ym5yEA8hqHmrU
         c42kHQZV8OvDqnGthsVY1l2krILDi6amEQNs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTSZ+NIsXuvldaMkrRodw1dSZWFfY/im96/BMN7oX2c=;
        b=CaR4mnzCMzO+/dLHgyT5tdI3/GS0hng/+qpUVB5M0Lk1dhdN9ADq6YNydnpIAQfb3L
         sTLPP0zyWSxs8boVJ+IBGZD4nQSMh7ge/IXnbt37o3ehTr3/WIwPru9lmCwOP25cjriU
         uje5h3uU/i4kWKqMjeaZCWEwWKTURXlWwYnFH2cAsrfOy0/50Js+nj+OdKWTEhtmjgug
         V6o29E4AmFd0fLAhmiulkNNLFg3xpBqqeVbIl6oZ8vA0Wdo7jMjUKsfcMNzyy0NmehAg
         aRt7vsYa+h6H+6PtzNqbvpzD/10kYEdMgKZ3GBC7a+wgxNDexl6+LI2jQaMtdT5KFTg2
         XCFQ==
X-Gm-Message-State: AA+aEWYf5JQaV+myVaJkHP3dBwpSxNzdsHvouyC0RLVRG3A+U6fjFCgN
        Iv3U0aOGux4zqIESAIl7ffS6J7nOkEBNH8FWxH0gRw==
X-Google-Smtp-Source: AFSGD/UwpjATpyD8gob4B2nPNua1DpNLS9MRBTkX82VOfoLkIFDsdJ4AjcE1VYmavCLI8daXuBmi6pZMpajcQwpH0FM=
X-Received: by 2002:a24:e38f:: with SMTP id d137mr964102ith.69.1543489472272;
 Thu, 29 Nov 2018 03:04:32 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com> <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
 <20181128170302.GA12405@redhat.com> <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com> <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov>
In-Reply-To: <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 29 Nov 2018 12:04:20 +0100
Message-ID: <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
Subject: Re: overlayfs access checks on underlying layers
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 28, 2018 at 10:43 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 11/28/18 3:24 PM, Miklos Szeredi wrote:
> > On Wed, Nov 28, 2018 at 8:32 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

[...]

> >> Does the breaking commit (007ea44892e6) fix a real bug affecting users?
> >>    If not, I'd recommend just reverting it.
> >
> > That is certainly an option, but...  this is all about context=
> > mounts, right?  Which allows mounter to override MAC checks under the
> > new mount?  On any mount, not just overlay, right?  So why is overlay
> > special?
>
> With other filesystems, the files are only accessible under the context
> specified by the mounter (and you can't mount it twice with differing
> context mount options). With overlay, the file is simultaneously
> accessible under both the context specified by the mounter via the
> overlay and under its lower/upper context via the lower/upper dir.
>
> Generally we only use context mounts on other filesystems when they have
> no label information at all (no security.selinux xattrs) or when they
> are completely untrusted to provide that information; the context
> specified by the mounter is the only basis for access control.  With
> overlay, we are frequently dealing with labeled lower and upper
> directories in a filesystem we trust.
>
> It seems like overlay has a goal of preventing the mounter from
> escalating its access through an overlay mount.

Overlayfs main purpose is to bypass limited access to a read-only
filesystem by copying up on a write access.  So bypassing access is
built into the system, but it's done in a way that in the end it
doesn't permit mounter to do more than it could otherwise do.  Or at
least that's the intent, as you say.

To generalize that, we could say:  trigger a copy-up if access to
lower layer object is denied.  That would extend the scope of the
trigger from write access on file/dir to read/write on special files
and execute on regular files, all of which could theoretically be
denied on the lower object, yet allowed on the upper object without
violating the above rule.

> > I'd just like to see proper justification for why we should be doing
> > those checks on underlying layer that simply don't belong there, IMO.
> >   I'm sure you know better than I that it's not just about real bugs
> > affecting users, it's about having a clear, well defined model to base
> > the design on.   And by reverting the breaking commit, I don't see us
> > getting closer to that.
>
> It seems like the NFS folks raised a number of concerns with the overlay
> approach beyond just these two checks,

The concerns that NFS folks had was that overlayfs does not enforce
permission checks (with creds of task) on underlying objects,
resulting in possibly elevated access compared to directly accessing
the NFS mount.    But I think there's no way to reconcile server
permission checks with overlayfs, so we are left with the current
model of only verifying the permission on the server against the
mounter's creds.

> and Android has their
> override_creds=off use case.  Maybe the overlay model needs a more
> significant rethinking than just these two cases.

Yes, it would be good if that override_creds=off use case was
discussed.  AFAICS it trades less privilege in the mounter for more
privilege in the task accessing the overlay.  If, or how, that is a
good model for anything other than Android is not clear to me.

Thanks,
Miklos
