Return-Path: <SRS0=riLa=NQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393CAC0044C
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 20:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35432081C
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 20:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ufZtH8Pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35432081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbeKFGIy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:08:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33370 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbeKFGIy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Nov 2018 01:08:54 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so3145218ljd.0
        for <selinux@vger.kernel.org>; Mon, 05 Nov 2018 12:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hHxtnBvyiD9e/B0oTaFnAMd59penzOhTSt/Fk/dhlI=;
        b=ufZtH8PdbvY9QaNYs8inR9BvQ8j20TdhuN6icU3z/2e2M+1HkiI61kvXFwBt74ONsM
         gSpTTt5SP17I119Yq3aTkuKrXu2As2QzEq0XSsVfeH5YHz5uXzGHhsNG1bVcRuOIxnL6
         i8PugBWvGluaLXcQ0U63GEcbHHmv6DyKHdJKz4YsGc7dFoGwf6AV2wWsRBKubyoDlDeD
         EWV36756rI22ahjksZblqeD+vs2p28gDi7NVAHRhb9TpB/f9cTdHezSUzUi++VeBAyjP
         nAKxb0vg/Le1Y16jMr/KqBtMjV8DVCLW9Sedfh3QSW0IoL8/B/tLROszQgTvkQI0I4wS
         L/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hHxtnBvyiD9e/B0oTaFnAMd59penzOhTSt/Fk/dhlI=;
        b=d+90++b0+CEYRjn+NKxK7KX4X/j+g0wd5UPCAuNXILe0oNR5PsrqlDkkxFa+MJRmQD
         oXS1CwWlxHi5xU83QRfws3kKXz2kF60zTXO/l9Vg7OKzhZUgO6jP5/SGRnBXNAKm02Zj
         MtI6UOjv+0F+uoTl/NQlxycUovqsjoGyQEt4Wg6nicGPi43oZfRwY3li+2nfqUjdKACJ
         UuM4ws7i35l1Kw3BqcH9VpeLRiHeUjK7isvCIPrjF0wF0c/Lm5lDmbhHF4gtU6no+hjr
         090arl885Ov0NKS5Izvt3/q9/PKOyK62iYKdvCDnPXeeMlaj3vZGTplc2PAFDWKUIPW5
         q7IQ==
X-Gm-Message-State: AGRZ1gKIEkinyRf17XVYlqlicYsAgPoLeCEWF694hefeoaf/Jixpmhw4
        e3THf5ncE6Bp54cEuatYzFb9YkiOxCcArK9DNdbM
X-Google-Smtp-Source: AJdET5eh/6WraIp16gSl1enjwChKd8jjLtoIC8GO0BOtJx+u3pZTdFcDxnyPmCWvHwS8V7AvqtFvGSNRfdW/hlXYKgs=
X-Received: by 2002:a2e:8945:: with SMTP id b5-v6mr15694945ljk.55.1541450841138;
 Mon, 05 Nov 2018 12:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20181031122718.18735-1-omosnace@redhat.com> <20181031122718.18735-2-omosnace@redhat.com>
 <0d74125f-35bd-4713-3dfd-b15dfc9e731a@tycho.nsa.gov> <CAFqZXNvDiQekJTm=4dLx93BWEouiqxWFCc_207oEuaSFuV3BfA@mail.gmail.com>
In-Reply-To: <CAFqZXNvDiQekJTm=4dLx93BWEouiqxWFCc_207oEuaSFuV3BfA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 5 Nov 2018 15:47:09 -0500
Message-ID: <CAHC9VhTLvAYg7oi9pyRuDSQ1ht5L8seCdjKf=0BZ0nsQFSypxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: use separate table for initial SID lookup
To:     omosnace@redhat.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 2, 2018 at 11:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Oct 31, 2018 at 6:09 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 10/31/2018 08:27 AM, Ondrej Mosnacek wrote:
> > > This patch separates the lookup of the initial SIDs into a separate
> > > lookup table (implemented simply by a fixed-size array), in order to
> > > pave the way for improving the process of converting the sidtab to a new
> > > policy during a policy reload.
> > >
> > > The initial SIDs are loaded directly and are skipped during sidtab
> > > conversion, so handling them separately makes things somewhat simpler.
> > > Since there is only a small fixed number of them, they can be stored in
> > > a simple lookup table.
> > >
> > > This patch also moves the fallback-to-unlabeled logic from sidtab.c to
> > > the new helper functions in services.c that now handle the unified
> > > lookup in both sidtab and isidtab, simplifying the sidtab interface.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >   security/selinux/include/security.h |   3 +
> > >   security/selinux/ss/mls.c           |   6 +-
> > >   security/selinux/ss/mls.h           |   2 +-
> > >   security/selinux/ss/policydb.c      |  24 ++-
> > >   security/selinux/ss/policydb.h      |  26 ++-
> > >   security/selinux/ss/services.c      | 238 +++++++++++++++-------------
> > >   security/selinux/ss/services.h      |   1 +
> > >   security/selinux/ss/sidtab.c        |  29 +---
> > >   security/selinux/ss/sidtab.h        |   3 +-
> > >   9 files changed, 187 insertions(+), 145 deletions(-)
> > >
> > > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > > index 23e762d529fa..a1b4b13c2300 100644
> > > --- a/security/selinux/include/security.h
> > > +++ b/security/selinux/include/security.h
> > > @@ -221,6 +221,9 @@ struct extended_perms {
> > >   /* definitions of av_decision.flags */
> > >   #define AVD_FLAGS_PERMISSIVE        0x0001
> > >
> > > +struct context *security_sid_to_context_struct(struct selinux_state *state,
> > > +                                            u32 sid, int force);
> >
> > This header is for interfaces exposed by the security server (i.e. the
> > policy engine) to the AVC, hooks, and other policy enforcement code. The
> > context structure is private to the security server in order to
> > encapsulate the policy logic and should never be returned directly to
> > code outside of the security server.  Technically you aren't actually
> > exposing the structure definition but this interface isn't useful
> > without doing so, so it shouldn't live here.
>
> Another option could be to refine mls_context_to_sid() so it doesn't
> need the sidtab lookup at all, moving that part to the call sites.
> That function has two callers and only one of them can really trigger
> the path with the lookup. I planned to look into doing this later (I
> didn't want to include unnecessary changes in this patchset), but now
> I actually tried doing it and it seems like a good simplification. I
> will fold it under these two patches in v2. After this change the
> helper function won't be needed outside services.c.
>
> >
> > You could make this a services_sid_to_context_struct() interface defined
> > in security/selinux/ss/services.h instead.  Or you could keep all of
> > this within the sidtab, just making the isidtab part of its internal
> > state, and moving this logic inside of sidtab_search() instead of
> > splitting it out.
>
> My intention was to not hide too much complexity under sidtab, but
> rethinking it now I agree it would probably make sense to just hide
> isidtab under sidtab. It would need to have a separate insert function
> for initial SIDs (and in the second patch also some logic to switch to
> the new isidtab), but I guess that is less ugly than keeping it
> outside... I'll see if I can make it all a bit nicer.

FWIW, I agree with Stephen about managing the initial sids within the
context of the sidtab; conceptually it just makes sense.

-- 
paul moore
www.paul-moore.com
