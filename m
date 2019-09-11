Return-Path: <SRS0=8iER=XG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB8CC49ED6
	for <selinux@archiver.kernel.org>; Wed, 11 Sep 2019 23:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6191120684
	for <selinux@archiver.kernel.org>; Wed, 11 Sep 2019 23:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Qm9ZsFKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfIKXxD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Sep 2019 19:53:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35294 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfIKXxD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Sep 2019 19:53:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so17782812lfl.2
        for <selinux@vger.kernel.org>; Wed, 11 Sep 2019 16:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zx1jcTcBveRMEFVLIn6q8VehBKEAgZhHGEuvh4iciA8=;
        b=Qm9ZsFKWg+8mXjiQSjreJLH0VsChF5sId+cQwwjSFu4zCH1Wtx4rvJUatan3YJnNRy
         znAVoefksok9bhGRPgqJ+ghTl866I7RUlS0eAPwR8+lyg2lIwhxPqZ5x0dT5RbiTIdJ5
         vvgsg4+l7bjpVQX6TRdMprd75N8Yn6ss7glP+wUfABu1BwTqDA+pZHLhgU+jlFc4KQ3X
         Ijq9Os9ECwHEAt4F4udr1Nn94B/ljgpiuPUsV3/KrHnCoOG1k62BnVC/t5Ag1dFRZx/+
         cxsMJEb8yGyrvYQUg6+TZF8LX3kr7xLDNjHNtzUjfy+8Mtb37uOV2qNSjEPO6unqrTcQ
         95Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zx1jcTcBveRMEFVLIn6q8VehBKEAgZhHGEuvh4iciA8=;
        b=RWmins+YRxtH0S9SOK35+9/FuccajcmBVePHXGESNceAqBahGqXceuMalqUfBbYVab
         fAsE7Dl9tkw0LfOiQyKlbe/65nERaFKwLn7C9TFD85sfGqKNbcQDjw0WSTx0Rh+L8WTY
         lfN+IwBDsqkdCeDNRttIb93drmZXRdhew0nsdTfORunJlkvWCeSuwMSpYzS5F6dS32I3
         qyuCuEL8wq1NqfFckJf6kYBuei55wttkhyBKUNuoPgNkiVfEzi5BLq9LZ7fVdX+eiUI6
         +jqiLv9fSpF0U2uxmdbUbK5gPZkzO7NDVFeBHjX+DKhRaxbREjQkSfwzzK3108OhbWsE
         hhvA==
X-Gm-Message-State: APjAAAWmHHjrtZtQyi4bahxzpRPU0003PfEDGZ5hlGCp92WvKZpFVXLJ
        KOO85KA7XVGsAzxQgFzxn6qKBPpENsLLZQ5bop05
X-Google-Smtp-Source: APXvYqxBzfzf9fBUgm7O8+innmKM61SyaO+Mkn/RSN5J7IzqIhsbcxSpfV8ZMpJttlXWLyU3Lfz9MTrj7WI2TWuwqPE=
X-Received: by 2002:a19:beca:: with SMTP id o193mr26131775lff.137.1568245979706;
 Wed, 11 Sep 2019 16:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190909180557.8093-1-joshua.brindle@crunchydata.com> <0ea96cc4-11bb-5c4a-5f0a-75411a58e546@tycho.nsa.gov>
In-Reply-To: <0ea96cc4-11bb-5c4a-5f0a-75411a58e546@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 11 Sep 2019 19:52:48 -0400
Message-ID: <CAHC9VhQXf=h2BhaWvnwdJkLMHUdEV8F5pL4TSqAu6UkL3_FWpg@mail.gmail.com>
Subject: Re: [Non-DoD Source] [PATCH v4] Add default_range glblub support
To:     jwcart2 <jwcart2@tycho.nsa.gov>,
        Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 10, 2019 at 1:27 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
> On 9/9/19 2:05 PM, Joshua Brindle wrote:
> > Policy developers can set a default_range default to glblub and
> > computed contexts will be the intersection of the ranges of the
> > source and target contexts. This can be used by MLS userspace
> > object managers to find the range of clearances that two contexts
> > have in common. An example usage is computing a transition between
> > the network context and the context of a user logging into an MLS
> > application.
> >
> > For example, one can add a default with
> > this cil:
> >
> > (defaultrange db_table glblub)
> >
> > or in te (base module only):
> >
> > default_range db_table glblub;
> >
> > and then test using the compute_create utility:
> >
> > $ ./compute_create system_u:system_r:kernel_t:s0:c1,c2,c5-s0:c1.c20 system_u:system_r:kernel_t:s0:c0.c20-s0:c0.c36 db_table
> > system_u:object_r:kernel_t:s0:c1,c2,c5-s0:c1.c20
> >
> > Some example range transitions are:
> >
> > User Permitted Range | Network Device Label | Computed Label
> > ---------------------|----------------------|----------------
> > s0-s1:c0.c12         | s0                   | s0
> > s0-s1:c0.c12         | s0-s1:c0.c1023       | s0-s1:c0.c12
> > s0-s4:c0.c512        | s1-s1:c0.c1023       | s1-s1:c0.c512
> > s0-s15:c0,c2         | s4-s6:c0.c128        | s4-s6:c0,c2
> > s0-s4                | s2-s6                | s2-s4
> > s0-s4                | s5-s8                | INVALID
> > s5-s8                | s0-s4                | INVALID
> >
> > Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
>
> Merged.
> Thanks,
> Jim

Thanks guys.  We're at -rc8 for the kernel right now so it's a little
late to pull the corresponding kernel patch, but I'll do that after
the merge window closes.

-- 
paul moore
www.paul-moore.com
