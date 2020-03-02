Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AD7C3F2D1
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 20:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3405A21739
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 20:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAfPuXSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgCBUW3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:22:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42086 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgCBUW2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 15:22:28 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so598810otd.9
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECZeviEwmuxgU6snhUEEjJvtI4unDXHxB7ZEtePVkeo=;
        b=nAfPuXSBmbPwqQj/tR+vZ/L4DfXbGuuoikjSRM5MK1GZBXsrPfEt48PLx+WymRuuL5
         wpgjyjzC0emKm83diFloVPlU6Y4ObtRVFfU1P8Quy6hfTGG3orkO737x/spaQgJXCSlo
         q4xUurMt83thAqs7Ewb5ZgllQDVew4sqgp3UPtllFjdfnf0rN+9k0gXkvrEg2Hxl9vcn
         okeMzTBuGsibSaSwgH3/LdyguTpqJNnhxQ511/d+Y6hiBoiXvrh4u5odpoG5DFjMiS5y
         Bdrr33l9LAVx7wFJERxCcKtS9Bq5GgrrB/aQXCw9CCgEqSD9UFXSmM15Aja7z9feLdrm
         jgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECZeviEwmuxgU6snhUEEjJvtI4unDXHxB7ZEtePVkeo=;
        b=TAmFwi943v2hMtkX6dLFtkBumkcUlSnRav6NYCFPU3gyGiLWwmB5CLy+/qv5SQIQaB
         A7KN+JddJmQ5hWd4Berz7urcoi2dR74CxCFZ88jQx9Il+o69KVSCYunDDC9Q1XRTcfj1
         w81sgDvJqfvnq5vn5jYKXvaMEWf+bUzpvxC0CP3BYeCoQRRrL208lGl3gvoe20Qo7fLo
         xmTv3eLsT4btUqi5os+9PNX3XpDdazQJLqyNJjLg+f7T5NkMv7pFLdyCIDBlRE+Kj3CN
         MPqDAgFbqbJu+e6GZd/iqpalvtX9HVBl60ElLUR6AD65pygQTH4t2ll1oYi0DrWNZ9HQ
         /4hg==
X-Gm-Message-State: ANhLgQ3l0wYolfJ3toq+NQHkHnG3I4FxhI5senpVAgzxIBhuXD1RsK2I
        cXBp49ZgcJORwkm3HlQ8bMtIjN4R1I6tSj2cGsw=
X-Google-Smtp-Source: ADFU+vsZYst4VmU3tByJo1iP//m6OPgLEo8FU39+QHoIcO4JQQFFWhTeYxXamBl34P9CEsIvKrf6MsHBCni1X7hPHqw=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr762000otl.162.1583180547812;
 Mon, 02 Mar 2020 12:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <CAEjxPJ76uFc62tPhH_2FLN58kwh_7kbA356QzDR8T-gogGiW=w@mail.gmail.com>
 <CAEjxPJ4rjrtgDSZh163oNrXf3uX0uo+rNzreZ7M7py7MOwN8gw@mail.gmail.com>
 <CAEjxPJ7mEu2E76Z=nVvZLtpFr6kDz449F+XCuO=RdUjScz3auw@mail.gmail.com>
 <CAFqZXNt477qLVy-5B+MRy_Bvw5fqLWMeOFQDfkGfXD_i=SYghQ@mail.gmail.com> <CAEjxPJ66CZL6-+KbRKwicYuj50uvcTjr-O81LC+BhQGO-jaKew@mail.gmail.com>
In-Reply-To: <CAEjxPJ66CZL6-+KbRKwicYuj50uvcTjr-O81LC+BhQGO-jaKew@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 2 Mar 2020 15:24:15 -0500
Message-ID: <CAEjxPJ5VMy5aRX_2_OB_4gwDmKAve+TMu-BJeSmqsWmM-PxRCg@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol: Speed up policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 2, 2020 at 1:45 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Mar 2, 2020 at 10:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > Hm... this is probably a consequence of the second patch. Types are no
> > longer considered a superset of an attribute containing a single type,
> > so the single-type rule gets removed instead of the attribute one...
> > But even before it picked the first rule only by chance (it was first
> > in order). I would say that picking a single-type rule over an
> > attribute rule in this case is outside of the scope of the algorithm.
> > Shouldn't the compiler automatically expand each attribute that has
> > less than 5 types in it? I recall seeing something in the code that
> > did this. I think this was in the CIL part of libsepol, so maybe it
> > applies only when compiling from CIL?
>
> secilc has -G and -X options for controlling expansion of attributes, but
> there aren't equivalent settings in semanage.conf to control when
> building modular policies.
> Internally it all uses the libsepol CIL support so it ought to be fixable.
> Looks like the default is 1 in cil_db_init() so it only happens when
> the attribute has no types by default?

Apparently that was to eliminate attributes that have no types at all.
Seems like we could add new options to semanage.conf to provide equivalents
to secilc -G and -X, and have semanage_direct_commit() call
cil_set_attrs_expand_generated()
and cil_set_attrs_expand_size() in the same manner as secilc does based on those
semanage.conf settings.

Could also look at increasing the default size to 5 or something and
see what impact that has on
Fedora policies.
