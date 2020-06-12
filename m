Return-Path: <SRS0=GKMn=7Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3C0C433DF
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 08:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF0D20578
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 08:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1QP0cOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgFLICB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:02:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35443 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726262AbgFLICA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jun 2020 04:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591948918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zFV5q/tNv+oXc5JuBy2ztRIX+iFtdAsbYIzI6VMlHtM=;
        b=L1QP0cOD9ClXhqALrDnNl434CutvqEXv8n3PwhQNLQaqvfmcIHUOlyKoE/au9t37/PeqWO
        SS7NNLn4NZJvuLDEN+8FNGueQk3A0YIqdUkBAOcsD9LmLMzdgbjoHv7QUp3oBvSOklwJzv
        BFhB2o2hmmMHQyYptYnk31lSfsF0PCM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-gF9jiy1KMemQaYxwXQDoYw-1; Fri, 12 Jun 2020 04:01:53 -0400
X-MC-Unique: gF9jiy1KMemQaYxwXQDoYw-1
Received: by mail-lf1-f70.google.com with SMTP id a17so2405619lfr.9
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 01:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFV5q/tNv+oXc5JuBy2ztRIX+iFtdAsbYIzI6VMlHtM=;
        b=CS0NJ2XRBwbFp8MDoarMURIjSDPRYf+u089GpGJE2U2s4+up5Tq92rthS0xNkgoY3v
         oqqR/ROXl1Ii1NO8im1HIozFtn3BuGTDCjkoC55fV6Bv6aoVrY+98CP3qAirWQ9yWYpr
         06mVv/ZBlnLe00Blmbzs65wX3dPOBqc5O+//hx6wo7OyLlX3f0ffjSsF3YW5A+lRm8z9
         ictNW62txJr0RJBzeg/dnatLBdk6ro50td7gVlMygXfDadtY9Ei/Kbd3aibyFzNgTV25
         Q5Z9IM+pVBxFGmaA+GyHJQpZ39thZLm0RQQtL0GEYCvS3hZmsWxjMwu4+pZJ1RA0D+6v
         pLzA==
X-Gm-Message-State: AOAM531yN+ldRXlMA6097dFixG8WvVVYM9fK/Pgcs+QXYd+hDjmMimOq
        6LtHK7z5LASsFNX8B3d/6uz8SRAs9Gnemnp9iM2i2obBSDYbXd4wyg8o72pw/d+W7qwXsF1YvI+
        vMcXdBaYBhYF8NtQNlrx1B5/35LE0XTXMPA==
X-Received: by 2002:a05:651c:1126:: with SMTP id e6mr6205517ljo.123.1591948912217;
        Fri, 12 Jun 2020 01:01:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgPk3fFoP16ga9S+l/Fq6iJDO3J+vleOTImQgKQw9EjoBMbPNYFSQq3fvFAoYR9jqtbw6BD5CZoffhGjAp85c=
X-Received: by 2002:a05:651c:1126:: with SMTP id e6mr6205500ljo.123.1591948911907;
 Fri, 12 Jun 2020 01:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200611204746.6370-1-trix@redhat.com> <20200611204746.6370-2-trix@redhat.com>
 <CAHC9VhSyo9GZKVZ04w3d3bLV9-_61W0KznATZPmqZBYXT2J=xw@mail.gmail.com>
 <d8cee44a-316f-d1be-9893-428598ada2d8@redhat.com> <CAHC9VhSPygyQAiWuaAWViuraCP6A9KTqmQeEt2_Rxta_WFsu5Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSPygyQAiWuaAWViuraCP6A9KTqmQeEt2_Rxta_WFsu5Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 12 Jun 2020 10:01:41 +0200
Message-ID: <CAFqZXNuVevzXLhCBujJKTPL+HBhOxkUv6a-J1NGY9BzTJ7aWCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux: fix another double free
To:     Paul Moore <paul@paul-moore.com>
Cc:     Tom Rix <trix@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 12, 2020 at 1:27 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jun 11, 2020 at 6:41 PM Tom Rix <trix@redhat.com> wrote:
> > On 6/11/20 3:30 PM, Paul Moore wrote:
> > > On Thu, Jun 11, 2020 at 4:48 PM <trix@redhat.com> wrote:
> > >> From: Tom Rix <trix@redhat.com>
> > >>
> > >> Clang static analysis reports this double free error
> > >>
> > >> security/selinux/ss/conditional.c:139:2: warning: Attempt to free released memory [unix.Malloc]
> > >>         kfree(node->expr.nodes);
> > >>         ^~~~~~~~~~~~~~~~~~~~~~~
> > >>
> > >> When cond_read_node fails, it calls cond_node_destroy which frees the
> > >> node but does not poison the entry in the node list.  So when it
> > >> returns to its caller cond_read_list, cond_read_list deletes the
> > >> partial list.  The latest entry in the list will be deleted twice.
> > >>
> > >> So instead of freeing the node in cond_read_node, let list freeing in
> > >> code_read_list handle the freeing the problem node along with all of the
> > >> earlier nodes.
> > >>
> > >> Because cond_read_node no longer does any error handling, the goto's
> > >> the error case are redundant.  Instead just return the error code.
> > >>
> > >> Fixes a problem was introduced by commit
> > >>
> > >>   selinux: convert cond_list to array
> > >>
> > >> Signed-off-by: Tom Rix <trix@redhat.com>
> > >> ---
> > >>  security/selinux/ss/conditional.c | 11 +++--------
> > >>  1 file changed, 3 insertions(+), 8 deletions(-)
> > > Hi Tom,
> > >
> > > Thanks for the patch!  A few more notes, in no particular order:
> > >
> > > * There is no need to send a cover letter for just a single patch.
> > > Typically cover letters are reserved for large patchsets that require
> > > some additional explanation and/or instructions beyond the individual
> > > commit descriptions.
> >
> > I was doing this to carry the repo name and tag info.
> >
> > So how do folks know which repo and commit the change applies to ?
>
> We read your mind ;)
>
> Generally it's pretty obvious, and in the rare occasion when it isn't,
> we ask.  Most of the time you can deduce the destination repo by the
> files changed and the mailing lists on the To/CC line.  From there it
> is then just a matter of -next vs -stable and that is something that
> is usually sorted out based on the context of the patch, and if
> needed, a discussion on-list.

Yes, it is normally not necessary, but I wouldn't discourage people
from providing the info if they want to / are used to do that. It can
be really useful in some situations, especially in case of
cross-subsystem changes that are sent to many mailing lists. But of
course this information belongs either to the cover letter or in case
of single patches to the "informational" section between "---" and
"diff --git [...]".

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

