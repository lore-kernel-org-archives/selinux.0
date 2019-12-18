Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2113C43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 00:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64B7206D3
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 00:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dmpn0I2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfLRAQs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:16:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36521 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLRAQs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 19:16:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id k3so225734pgc.3
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2019 16:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IGL4fd8C8Hu11pTZhYBouIj6zzVdoq+/g+bsQeH8muI=;
        b=dmpn0I2ei3R8ke6JeAO8SaimdgS+F2CMSFN4Y9naLR3OQl9LzFKH7K141kdHOre8hi
         kK4FpYna116+db6LOTAFhfTcWEgstNPwNNLdVoAZm/rrbeqaYro3ezuJPI1Vh48gkI1R
         CIiFFMKdPrT4Tmnz01o6otKSYy+S5lPNbi9AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IGL4fd8C8Hu11pTZhYBouIj6zzVdoq+/g+bsQeH8muI=;
        b=Ioe6TEkLP1mXuI/RntVE7h/VB2WIXGclHRasVAwQ88atuCJzcRB4w21eEn/B0LwF2r
         3xfn/Fah0lTk9bRsFbNqeuIrx18AczaLammZFpweifc8fIh8Efm/igS+Y+pIUrtOHqSR
         R445RooXMB5NI2aI89h2cgXZ0n1fJxG5WBi5EG1IyeMs5EboKIz9e2hIinUh1DZr13ES
         lc2wq+Re1/kLPLPGnS4Ae+F33RTjoIfbWirOVGfB7VZajZsPAEz1LZLC4zcVVl5NsF5U
         2FwGKXEK2bhJ8ezLN5enLL7MSgXFqKEKnT4Uk3R2n4Hr9nxLD/e9JfDH0psK//pGWKXj
         5z6w==
X-Gm-Message-State: APjAAAWqwT48iCnqVh/ZgAwNVHTJcDtuP/TouO3nSb33CVorjW2BElOP
        PVbeVysBuK/pfLzG6ltena2RlA==
X-Google-Smtp-Source: APXvYqyPJwPvIMtChY1qGy8NpJmcRIqdWC52QhjINSIKD3tQMLfkS6DZXFlPXcHfMHzoxrhy0VmZAQ==
X-Received: by 2002:aa7:9556:: with SMTP id w22mr550885pfq.198.1576628205849;
        Tue, 17 Dec 2019 16:16:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u123sm199007pfb.109.2019.12.17.16.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 16:16:45 -0800 (PST)
Date:   Tue, 17 Dec 2019 16:16:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Wenhui Zhang <wenhui@gwmail.gwu.edu>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Subject: Re: [RFC PATCH] selinux: randomize layout of key structures
Message-ID: <201912171616.616C9C9990@keescook>
References: <20191213202838.7323-1-sds@tycho.nsa.gov>
 <201912171550.C731CA1C@keescook>
 <CAOSEQ1qFpLX5hTyNZ+QZuhunH3gr+KAB5PDgcoFjUcyNojEVMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSEQ1qFpLX5hTyNZ+QZuhunH3gr+KAB5PDgcoFjUcyNojEVMQ@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 17, 2019 at 07:12:28PM -0500, Wenhui Zhang wrote:
> Hi, Sorry for bothering you again.
> 
> However I came into some *evm code* in LSM, which calculates HMAC for data
> structures.
> It looks like HMAC could protect integrity of LSM data structures.
> 
> IMHO, __randomize_layout and evm might duplicate the work, any instructions
> on this please?

When does the EVM code perform the checking? I would assume these are
complimentary features rather than duplicate.

-Kees

> 
> 
> On Tue, Dec 17, 2019 at 6:50 PM Kees Cook <keescook@chromium.org> wrote:
> 
> > On Fri, Dec 13, 2019 at 03:28:38PM -0500, Stephen Smalley wrote:
> > > Randomize the layout of key selinux data structures.
> > > Initially this is applied to the selinux_state, selinux_ss,
> > > policydb, and task_security_struct data structures.
> > >
> > > NB To test/use this mechanism, one must install the
> > > necessary build-time dependencies, e.g. gcc-plugin-devel on Fedora,
> > > and enable CONFIG_GCC_PLUGIN_RANDSTRUCT in the kernel configuration.
> > >
> > > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > -Kees
> >
> > > ---
> > > I would have expected that two kernels built with the same config
> > > with this enabled would have yielded different struct layouts in
> > > pahole vmlinux output, but that doesn't appear to be the case. They
> > > do have different seeds.  Am I doing something wrong?
> > > Also, does DEBUG_INFO_BTF effectively undermine/negate the benefits of
> > this
> > > change if enabled?
> > >
> > >  security/selinux/include/objsec.h   | 2 +-
> > >  security/selinux/include/security.h | 2 +-
> > >  security/selinux/ss/policydb.h      | 2 +-
> > >  security/selinux/ss/services.h      | 2 +-
> > >  4 files changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/security/selinux/include/objsec.h
> > b/security/selinux/include/objsec.h
> > > index a4a86cbcfb0a..330b7b6d44e0 100644
> > > --- a/security/selinux/include/objsec.h
> > > +++ b/security/selinux/include/objsec.h
> > > @@ -35,7 +35,7 @@ struct task_security_struct {
> > >       u32 create_sid;         /* fscreate SID */
> > >       u32 keycreate_sid;      /* keycreate SID */
> > >       u32 sockcreate_sid;     /* fscreate SID */
> > > -};
> > > +} __randomize_layout;
> > >
> > >  enum label_initialized {
> > >       LABEL_INVALID,          /* invalid or not initialized */
> > > diff --git a/security/selinux/include/security.h
> > b/security/selinux/include/security.h
> > > index 49737087ad33..3ea406ad91b6 100644
> > > --- a/security/selinux/include/security.h
> > > +++ b/security/selinux/include/security.h
> > > @@ -110,7 +110,7 @@ struct selinux_state {
> > >       bool policycap[__POLICYDB_CAPABILITY_MAX];
> > >       struct selinux_avc *avc;
> > >       struct selinux_ss *ss;
> > > -};
> > > +} __randomize_layout;
> > >
> > >  void selinux_ss_init(struct selinux_ss **ss);
> > >  void selinux_avc_init(struct selinux_avc **avc);
> > > diff --git a/security/selinux/ss/policydb.h
> > b/security/selinux/ss/policydb.h
> > > index bc56b14e2216..98afe52a3d19 100644
> > > --- a/security/selinux/ss/policydb.h
> > > +++ b/security/selinux/ss/policydb.h
> > > @@ -307,7 +307,7 @@ struct policydb {
> > >
> > >       u16 process_class;
> > >       u32 process_trans_perms;
> > > -};
> > > +} __randomize_layout;;
> > >
> > >  extern void policydb_destroy(struct policydb *p);
> > >  extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
> > > diff --git a/security/selinux/ss/services.h
> > b/security/selinux/ss/services.h
> > > index fc40640a9725..c5896f39e8f6 100644
> > > --- a/security/selinux/ss/services.h
> > > +++ b/security/selinux/ss/services.h
> > > @@ -31,7 +31,7 @@ struct selinux_ss {
> > >       struct selinux_map map;
> > >       struct page *status_page;
> > >       struct mutex status_lock;
> > > -};
> > > +} __randomize_layout;
> > >
> > >  void services_compute_xperms_drivers(struct extended_perms *xperms,
> > >                               struct avtab_node *node);
> > > --
> > > 2.23.0
> > >
> >
> > --
> > Kees Cook
> >
> 
> 
> -- 
> V/R,
> 
> Wenhui Zhang
> 
> Email: wenhui@gwmail.gwu.edu
>            Telephone: 1-(703) 424 3193

-- 
Kees Cook
