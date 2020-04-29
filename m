Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD3FC83000
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 19:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE81205C9
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 19:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJcLcNRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgD2T0W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2T0W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 15:26:22 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B26BC03C1AE
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 12:26:22 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g14so2721233otg.10
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CViCHD8+r2PFRJ8EsbspoY+PfdFHCfBHtk9/2RP3O8=;
        b=GJcLcNRtKbEjOojZ/I+qpcRddXV0aVgwfF4trbiXnLiXhv0ruLGFmW1F6YXQRhufyE
         XOnwBd/UPHXx85WMSg34VxHyvqdD3ntrcQJPNFRcKWuwYJ+uu2s0LxYKaVuQM0cTrmcw
         BwogR+5Gc4Sl7/FvnABCp+qotIwrrU+XgornfhsW2aMPBxlINh74k42VNh+LVSMiv39/
         RBQc1R8x2VRbOB9oIvJejcboR1LsKOeuZ4901IX5p415mH7A65DEEOPyqLFPhmLwQQju
         i3Z1XwlpD+AiuzLMWBxifSu2ogUSMUm6uZ/JopW/UDWZ+GgUDv4eilcSdHQOBAUW4kAu
         Aypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CViCHD8+r2PFRJ8EsbspoY+PfdFHCfBHtk9/2RP3O8=;
        b=MeujYzjZAi27nvO8T0OzLD8Y3pKGg1FAZYqtvxyQNFFK2oDUDdyvqiQfIApSbyyAqS
         ytbXmaKOOhM3wT0mZGUK9fJBPxhNNjmwKkvujr+JvyBRo2I91jQis2oDHx7sATuKkuHF
         vPUN9zxCuhmGcRw5RgesVE2CnpCI3rG6UXa2yTB5ZG9krXpm1GSlDrqYNA1/a6aOjmYm
         pGIHmj1yeTDyO6B2/QjxCPeWPSyDyPYOBcGynwrfnfpzmeatBQh0e48z4jIk6i4oIf5q
         ISXnYtFkRB7d1UUXWhf0HU33fMpxEVsEF9d3Fqb65Xpybl0cma4+RigwGaiwerCvZEPe
         Pjuw==
X-Gm-Message-State: AGi0PubZ5NuyU1PnMEGG/Hk/ojNtMN+CNiOJtO2uBM12ajYITwjU6gh0
        XEfFxLc0psi7WorCeCF2Ces1swRIl3bEWGUgosg=
X-Google-Smtp-Source: APiQypJ9qtej6RhYs6OS0TC3ULE9PLXmRz1he+ZEDk/zvBPccYpbq/jexK4OCDDPFVAi0NediJopVC8Yq5IY3RSrB7E=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr14170731otb.162.1588188381884;
 Wed, 29 Apr 2020 12:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200327152107.95915-1-omosnace@redhat.com> <daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov>
 <7549b0e2-f845-1c3a-d9d5-314cb2b9225f@ieee.org> <CAP+JOzRqVNLY67_FdP6MyaKqr=L0phaLEhjb=T4mtb+Dwwhhrg@mail.gmail.com>
In-Reply-To: <CAP+JOzRqVNLY67_FdP6MyaKqr=L0phaLEhjb=T4mtb+Dwwhhrg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 29 Apr 2020 15:26:10 -0400
Message-ID: <CAEjxPJ6p_6W7kHmaVsZCWvEg0MRbRRifSuxVKPyYZdrQgw42mA@mail.gmail.com>
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
>
> On Mon, Mar 30, 2020 at 9:06 AM Chris PeBenito <pebenito@ieee.org> wrote:
> >
> > On 3/27/20 3:21 PM, Stephen Smalley wrote:
> > > On 3/27/20 11:21 AM, Ondrej Mosnacek wrote:
> > >> These patches are the userspace side of the kernel change posted at [1].
> > >>
> > >> The first patch changes libsepol's internal representation of filename
> > >> transition rules in a way similar to kernel commit c3a276111ea2
> > >> ("selinux: optimize storage of filename transitions") [2].
> > >>
> > >> The second patch then builds upon that and implements reading and
> > >> writing of a new binary policy format that uses this representation also
> > >> in the data layout.
> > >>
> > >> See individual patches for more details.
> > >>
> > >> NOTE: This series unfortunately breaks the build of setools. Moreover,
> > >> when an existing build of setools dynamically links against the new
> > >> libsepol, it segfaults. Sadly, there doesn't seem to be a nice way of
> > >> handling this, since setools relies on non-public libsepol policydb
> > >> API/ABI.
> > >
> > > I think this has happened before a few years ago when we made a
> > > different change to those structures, and required updates on the
> > > setools side.
> > >
> > > Maybe we need to figure out what setools needs to be encapsulated and
> > > exported as part of the libsepol public ABI/API, and then stop having it
> > > peer into libsepol internals?
> >
> > I'd be fine with that :)
> >
>
> I am a little confused. I would consider peering into the libsepol
> internals to be something like assuming the memory layout of
> structures and pulling things out based on those assumptions, but
> setools is just using public header files and functions. It seems to
> me to be using the public API. Now I think that too much of the
> internals are being exposed, but I am not sure we can do anything
> about that now.

The sepol/policydb/*.h files are considered private and are only for
static users of libsepol
like checkpolicy.  Only the top-level sepol/*.h headers are part of
the shared library API/ABI.

> It doesn't seem like it would be too hard to update setools to work
> with this change, unless there is a requirement that it still work
> with older versions of libsepol. I am not very familiar with cython
> and I don't know how to make it work differently depending on what
> version of libsepol is on the system.
>
> Speaking of versions, since we are actually modifying structs in the
> header files instead of just adding new things, don't we need change
> the version of libsepol or something?
>
> > Ultimately SETools does 2 thing for the policy access:
> > * iterate over the entire policy, reading data out of the various objects
> > * use linkages between objects in the policy, e.g. get the
> > type/attributes from an AV rule, get types from an attribute, etc. using
> > the stuff like class_val_to_struct as needed.
> >
> > So if sufficient functionality to do dispol was exported, that would get
> > close to all that was needed.  There are some optimizations I made by
> > digging at the structs a bit more than the above, but that could
> > potentially be dropped if libsepol has sufficient support.  See
> > <https://github.com/SELinuxProject/setools/blob/master/setools/policyrep/selinuxpolicy.pxi#L673>
> > for the policy loading code.
> >
>
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
