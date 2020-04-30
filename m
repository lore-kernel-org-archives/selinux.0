Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4117C47247
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 15:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F52920731
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 15:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URnuspk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgD3P11 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726545AbgD3P10 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 11:27:26 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90B7C035494
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 08:27:26 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id z17so5226626oto.4
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 08:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TctWxU8o/piwoCWtUDg18knvaFYdHGNk7PCJNC82YoM=;
        b=URnuspk4NL70gjmuLLNqiWr3+P71mUS5lngHcG9bca/fJpCFfulAyiERDVLTbz+hAq
         RjxouHvmS8WFpjfsK+ZBoKil6VbU+AlF+iECXOXeTRB7jiI+JpPsXzzCxlo8zrYdRimx
         Wfn07s4pNJkq7pvCG1mRpon4Hg7hAkIyR0hH5SHG7WT0Mjrl/iqAdt1+AHQcS6LpRYC4
         FLfbPDR0HZ+g20Z5RQxA+w8E6QdZv3GY+lQi7NLFmvC6rwIrS28moRkyo7dnuJsJq0/u
         hlSVKBquNu10XFfYnwZNj86C+WXyACoKSvPtMcxhgYakiQ+EPtfepxCq1itJTeI1ys+Z
         0ZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TctWxU8o/piwoCWtUDg18knvaFYdHGNk7PCJNC82YoM=;
        b=k2hUhM9pZO1TCiIEMMVrx3s8FUKSafRoIpw20AP6ggSN2NkkkgsWcqdNjesgsNdhsh
         sF45ZXomfB50f7N3RJaZIAWY3Jz8Jq5GoUHgZEGS3YYsneV/1OS1SkFiJWqrh35WONy3
         g6Cu7QcRHmk2tMz2BdQBSORlRphLwHZKK+O/jz49HsNfySq6F7bzFBgiUZx1f1XEmVoC
         +OXVkiPWLV2sz1wM5PrGmQww73bkIjIQb18ruGB3Z+H3Y+57BtyZOP3XIEaSsFKWuBaJ
         XGpswrU6nFJfeUw9SmVOaDbO+gcgeejxWluheV+Hmv+y+YENdrWUqttPSDqGW0A8yjiR
         1cOg==
X-Gm-Message-State: AGi0Puap7HGSDD3M5pbu1cwyY3PIdKX3jSVJ3hwdVZPyiLDuJWZrY57S
        BTh1s1E68dxqZz7pnfJA//EeN8Ov6NcsQUDatIE=
X-Google-Smtp-Source: APiQypI4MZ0gRq2DGo7klJbgWX09WmMYog47dYmAon/Vd3BiOQknXwAnjXem6YFbw3PD1QA2ZrisS1tvWWH57Xspk0g=
X-Received: by 2002:a05:6830:1c2b:: with SMTP id f11mr3146522ote.196.1588260446026;
 Thu, 30 Apr 2020 08:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200327152107.95915-1-omosnace@redhat.com> <daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov>
 <7549b0e2-f845-1c3a-d9d5-314cb2b9225f@ieee.org> <CAP+JOzRqVNLY67_FdP6MyaKqr=L0phaLEhjb=T4mtb+Dwwhhrg@mail.gmail.com>
 <CAEjxPJ5f9Lj8ZizfSYk6MwRamYAj=qAUa_dkc3fdV-a2S0ugXw@mail.gmail.com>
 <121c1c0d-da7b-681a-ae6e-121228a046af@ieee.org> <CAFqZXNuYPWWwcMeerzH1ZNzJPifuiNEE5im1JNgzZQLTmx9pAw@mail.gmail.com>
 <b36f82d5-d502-edfe-cde5-eb1e4bf76641@ieee.org>
In-Reply-To: <b36f82d5-d502-edfe-cde5-eb1e4bf76641@ieee.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 30 Apr 2020 11:27:14 -0400
Message-ID: <CAP+JOzQD9RGspJYSUvWoP3ugXzw=7RDh814=imq8LCJDH3W69Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] userspace: Implement new format of filename trans rules
To:     Chris PeBenito <pebenito@ieee.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 30, 2020 at 11:20 AM Chris PeBenito <pebenito@ieee.org> wrote:
>
> On 4/30/20 10:34 AM, Ondrej Mosnacek wrote:
> > On Thu, Apr 30, 2020 at 4:24 PM Chris PeBenito <pebenito@ieee.org> wrote:
> >> On 4/30/20 9:22 AM, Stephen Smalley wrote:
> >>> On Wed, Apr 29, 2020 at 3:01 PM James Carter <jwcart2@gmail.com> wrote:
> >>>> I think the fact that the CIL, kernel to CIL, kernel to conf, and
> >>>> module to CIL code is all in libsepol speaks to the fact of how
> >>>> tightly integrated they are to the rest of libsepol. One argument that
> >>>> could be made is that the policyrep stuff in setools really belongs in
> >>>> libsepol.
> >>>>
> >>>> Thinking about how libsepol could be encapsulated leads me to a couple
> >>>> of possibilities. One way would be functions that could return lists
> >>>> of rules. The policy module code gives us avrule_t, role_trans_rule_t,
> >>>> role_allow_t, filename_trans_rule_t, range_trans_rule_t, and others.
> >>>> Those structures are probably unlikely to change and, at least in this
> >>>> case, creating a function that walks the filename_trans hashtable and
> >>>> returns a list of filename_trans_rule_t certainly seems like it
> >>>> wouldn't be too hard. Another possible way to encapsulate would be
> >>>> create a way to walk the various hashtables element by element (I
> >>>> think hashtab_map() requires too much knowledge of the internal
> >>>> structures), returning an opaque structure to track where you are in
> >>>> the hashtable and functions that allow you to get each part of the
> >>>> rule being stored. There are other ways that it could be done, but I
> >>>> could rewrite kernel to and module to stuff with either of those. CIL
> >>>> itself would require some functions to insert rules into the policydb
> >>>> which probably wouldn't be too hard. None of this would be too hard,
> >>>> but it would take some time. The real question is would it really be
> >>>> valuable?
> >>>
> >>> I don't think we want to directly expose the existing data structures
> >>> from include/sepol/policydb/*.h (or at least not without a careful
> >>> audit) since those are often tightly coupled to policy compiler
> >>> internals and/or the kernel or module policy formats. Creating an
> >>> abstraction for each with a proper API in new definitions in
> >>> include/sepol/*.h would be preferable albeit more work. There was a
> >>> proposal a long time ago from the setools developers to create an
> >>> iterator interface and accessor functions for each data type, see
> >>> https://lore.kernel.org/selinux/200603212246.k2LMkRNq028071@gotham.columbia.tresys.com/.
> >>
> >> I agree.  The hardest thing with writing the policyrep in setools was stuff like
> >> the value_to_datum indirections, type_attr_map, etc. and knowing when to use
> >> value vs value-1.  An API that has a new set of structs would be ideal.
> >>
> >> Unfortunately, since setools policyrep is now written in Cython, we can't simply
> >> move the code over to libsepol.  My guess is dispol has the most useful building
> >> blocks for making a new API.
> >
> > Since you mention dispol... I also had the idea that setools could
> > just use the existing public interface to convert the whole policydb
> > to CIL and simply parse that as a string (this should be pretty
> > straightforward even in pure Python). However, based on my experiments
> > this would likely make setools a lot slower...
>
> This is an interesting idea.  I'm not familiar with the CIL API; secilc.c looks
> like it uses public API.  Can I use the existing CIL library functions to parse
> it, or does the resultant db lack public accessor functions?
>

The resultant db does, in fact, lack public assessor functions. They
could be created, but since there is already a way to convert the
cil_db to a policydb, the general solution would be to create the
functions for the policydb.

Jim
