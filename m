Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6A9C8300B
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 13:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5790C20870
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 13:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3vJEkbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgD3NXO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726770AbgD3NXN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 09:23:13 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5E9C035494
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 06:23:12 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a2so5156758oia.11
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 06:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gaBADu+B7IzEPbZNsHSx8ZdkPSNkQ7ZSrzuFujQz+BA=;
        b=d3vJEkbs6XrgZLNH040EFPZ7rcOY7ppv5dfv9hY6yhxpv0rMF6tKphSM/xei1XXmCZ
         8NIQKmItZA9H+9jx1+LHcKfG9STuxmIHBpXUzfw6ixsNO15Yit/Mr5jS7CjcgV3ImtOp
         sxiFnOhivukxOOJTs//lo/2fKsUWDJxNbhp1OAObnyObOoxT4n6iDMTbXIKVOLTXglNE
         xWwySK0ympH/IrXDyxXAHp7ZXuFwe+rOlv7cmnuWdAA4ySSfn1GCkGuelGxdjztqmSFK
         0beJYVa114jNqnHKzmF4Dczkp0GJbPrm8tO2bCedhoMXEaXB0KPKgdmMnCGkk9h73XMY
         ziwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaBADu+B7IzEPbZNsHSx8ZdkPSNkQ7ZSrzuFujQz+BA=;
        b=H+HI52uDR6nhFs3+Fn403JqDAOL6O0jXqtLS7mWIRgcapDYQEEH32a/2mEfnJG4PLB
         RozByBAC9ByZOcAc1QVW0ndmecPFyOmfsEKHT30Ob3W6FgF4j/ycyiVV639HOoDCLxpq
         wgv0/lfJ1RbFNAvpfK9RmGvN9ractlyC9dd97vTXqbUTGbCRCvVjuWxLYO8qqrbXd40z
         d8b6qJsFBcAlR+jlvFBtxIxm14Tm3/RyezwL9ae7LLWPKxFB62FaOk6bVIpFT33Py6Qw
         pL9eGl1b3ymKSgXci/WoaZBMtxj6dkLlUxfRlbyjyiCL5TjS+OEbFh5v/vC/nVjDM+mA
         rH0Q==
X-Gm-Message-State: AGi0PuZ57Sr/7JUT970rjyUWymlGiHa2tOlSh1owcq+u9hCQcG/PUHKD
        gdOsnKQGSpEMCnNGLVu4QrrEJTWO/uzJU8j7f1k=
X-Google-Smtp-Source: APiQypL86DwY/8PUkWzlX5KUjZZ1OR99hDSWWfH2PKjn72TfZwrJcv8pQ68pCZ0zkGjci0xqatmSVTC/WUj/jz3e7jg=
X-Received: by 2002:aca:4c0b:: with SMTP id z11mr1661787oia.92.1588252991558;
 Thu, 30 Apr 2020 06:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200327152107.95915-1-omosnace@redhat.com> <daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov>
 <7549b0e2-f845-1c3a-d9d5-314cb2b9225f@ieee.org> <CAP+JOzRqVNLY67_FdP6MyaKqr=L0phaLEhjb=T4mtb+Dwwhhrg@mail.gmail.com>
In-Reply-To: <CAP+JOzRqVNLY67_FdP6MyaKqr=L0phaLEhjb=T4mtb+Dwwhhrg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 30 Apr 2020 09:22:59 -0400
Message-ID: <CAEjxPJ5f9Lj8ZizfSYk6MwRamYAj=qAUa_dkc3fdV-a2S0ugXw@mail.gmail.com>
Subject: Re: [PATCH 0/2] userspace: Implement new format of filename trans rules
To:     James Carter <jwcart2@gmail.com>
Cc:     Chris PeBenito <pebenito@ieee.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 29, 2020 at 3:01 PM James Carter <jwcart2@gmail.com> wrote:
> I think the fact that the CIL, kernel to CIL, kernel to conf, and
> module to CIL code is all in libsepol speaks to the fact of how
> tightly integrated they are to the rest of libsepol. One argument that
> could be made is that the policyrep stuff in setools really belongs in
> libsepol.
>
> Thinking about how libsepol could be encapsulated leads me to a couple
> of possibilities. One way would be functions that could return lists
> of rules. The policy module code gives us avrule_t, role_trans_rule_t,
> role_allow_t, filename_trans_rule_t, range_trans_rule_t, and others.
> Those structures are probably unlikely to change and, at least in this
> case, creating a function that walks the filename_trans hashtable and
> returns a list of filename_trans_rule_t certainly seems like it
> wouldn't be too hard. Another possible way to encapsulate would be
> create a way to walk the various hashtables element by element (I
> think hashtab_map() requires too much knowledge of the internal
> structures), returning an opaque structure to track where you are in
> the hashtable and functions that allow you to get each part of the
> rule being stored. There are other ways that it could be done, but I
> could rewrite kernel to and module to stuff with either of those. CIL
> itself would require some functions to insert rules into the policydb
> which probably wouldn't be too hard. None of this would be too hard,
> but it would take some time. The real question is would it really be
> valuable?

I don't think we want to directly expose the existing data structures
from include/sepol/policydb/*.h (or at least not without a careful
audit) since those are often tightly coupled to policy compiler
internals and/or the kernel or module policy formats. Creating an
abstraction for each with a proper API in new definitions in
include/sepol/*.h would be preferable albeit more work. There was a
proposal a long time ago from the setools developers to create an
iterator interface and accessor functions for each data type, see
https://lore.kernel.org/selinux/200603212246.k2LMkRNq028071@gotham.columbia.tresys.com/.
