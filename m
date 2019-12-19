Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDCAC43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 18:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E8624672
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 18:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i74zbOUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSS3Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:29:24 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51265 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfLSS3X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 13:29:23 -0500
Received: by mail-pj1-f68.google.com with SMTP id j11so2912358pjs.1
        for <selinux@vger.kernel.org>; Thu, 19 Dec 2019 10:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4hMuTDWZsbv52j0RYJUZw8XCLhp2o7L2nrrQ2Usef9c=;
        b=i74zbOUqSbk093GI6BFGe8HG4vbuDJblkpIjc46OuB+1ZH/C/jGvohKz74cJD5XdfI
         06J/vu/B9RfsoAEah1Pd+EqkLs6p8EIgX5HviJb3SwxxDSBccyEELG4Vh+PaR5VSiaVo
         icUxuXZsTErL5kA1hWEfl3k/6V2SP0Wkq83U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4hMuTDWZsbv52j0RYJUZw8XCLhp2o7L2nrrQ2Usef9c=;
        b=aYklvgd0eaYPKLqxcW/khZ3Zq1XHxLrAM3e1lc3d75cxG003znRaw3D7L36Br9yKim
         lfOymylldzpAMKy0snKpoe96PtJOZFw+6Gie1GIF/W+PHy9AP8HWdSKuYBIaLmwCcVw1
         KT4aQ3yUnLvv3+1MiHMhBTQzsW6zt99LjjV9j04JtIXoj/pfedMsHoPh+ynISQtNNg2c
         jRIT2MFFveJQ7752tUrHB30GgVc4k7tUXac4rDirwPCePgLBJhcM8NNOwUnB4nP0VdDM
         UTaO9bh0Qv3dTPSyMWIkXhQ49SWecvTKwPnYOMbsEXV+GZRIukyU8aMsC2PGj8bju2Zb
         AsgA==
X-Gm-Message-State: APjAAAXvCef8L2+eMobaln03qgOm7BXpNGu4zwyvHcV2XSX5s+1GN1s4
        LJYcIKAH2cP0Cn8rQbWCaxFG4w==
X-Google-Smtp-Source: APXvYqxkTvFAm1BFWCO4dTed6j+HCsiI4CQIProlD+qBUtXwFMsTOTDgJyL6Ft+Hre9Ncf66WYwFsA==
X-Received: by 2002:a17:902:6906:: with SMTP id j6mr5057843plk.321.1576780162720;
        Thu, 19 Dec 2019 10:29:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 199sm9710449pfv.81.2019.12.19.10.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 10:29:21 -0800 (PST)
Date:   Thu, 19 Dec 2019 10:29:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Wenhui Zhang <wenhui@gwmail.gwu.edu>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Subject: Re: [RFC PATCH] selinux: randomize layout of key structures
Message-ID: <201912191028.549604D@keescook>
References: <20191213202838.7323-1-sds@tycho.nsa.gov>
 <201912171550.C731CA1C@keescook>
 <CAOSEQ1qFpLX5hTyNZ+QZuhunH3gr+KAB5PDgcoFjUcyNojEVMQ@mail.gmail.com>
 <201912171616.616C9C9990@keescook>
 <CAOSEQ1ow2XGQ4faoFekK9s3HfmfcvnVKZgGC6tPm0ChJ0F+-vw@mail.gmail.com>
 <201912171645.663C28F0@keescook>
 <CAOSEQ1quzmnB4700JdOob=DNgbF5ma2rt7O-ayZwWeWBjymcjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSEQ1quzmnB4700JdOob=DNgbF5ma2rt7O-ayZwWeWBjymcjw@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 17, 2019 at 08:02:58PM -0500, Wenhui Zhang wrote:
> EVM protects while security attributes data in memory and disk.
> structrand protects security attributes data in memory.
> 
> It seem like EVM introduces higher overhead than trampoline based
> structrand in general.
> 
> So, if we know our disks are reliable,  does it make sense if we add some
> ifdef options for disabling EVM please?
> 
> However this really depends on which one is faster,  the trampoline
> function or the encryption hash function.

There is no trampoline. It's just a per-compile re-ordering of the
structures. It makes attack that depend on knowing structure layouts
less reliable. EVM does not check these at memory access times, so they
are complimentary.

-Kees

> 
> 
> On Tue, Dec 17, 2019 at 7:47 PM Kees Cook <keescook@chromium.org> wrote:
> 
> > On Tue, Dec 17, 2019 at 07:21:49PM -0500, Wenhui Zhang wrote:
> > > In my understanding, evm is called whenever a security related attribute
> > is
> > > committed to VFS.
> > > It is set as enabled  by default.
> > > (ref.
> > >
> > https://github.com/torvalds/linux/blob/8b68150883ca466a23e90902dd4113b22e692f04/security/integrity/evm/evm_main.c
> > > )
> >
> > Okay, so yes, complimentary. randstruct means attackers need use bugs to
> > expose enough memory from the kernel to determine the order of structure
> > members before they can manipulate them with a kernel bug.
> >
> > -Kees
> >
> > >
> > > On Tue, Dec 17, 2019 at 7:16 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > > On Tue, Dec 17, 2019 at 07:12:28PM -0500, Wenhui Zhang wrote:
> > > > > Hi, Sorry for bothering you again.
> > > > >
> > > > > However I came into some *evm code* in LSM, which calculates HMAC for
> > > > data
> > > > > structures.
> > > > > It looks like HMAC could protect integrity of LSM data structures.
> > > > >
> > > > > IMHO, __randomize_layout and evm might duplicate the work, any
> > > > instructions
> > > > > on this please?
> > > >
> > > > When does the EVM code perform the checking? I would assume these are
> > > > complimentary features rather than duplicate.
> > > >
> > > > -Kees
> > > >
> > > > >
> > > > >
> > > > > On Tue, Dec 17, 2019 at 6:50 PM Kees Cook <keescook@chromium.org>
> > wrote:
> > > > >
> > > > > > On Fri, Dec 13, 2019 at 03:28:38PM -0500, Stephen Smalley wrote:
> > > > > > > Randomize the layout of key selinux data structures.
> > > > > > > Initially this is applied to the selinux_state, selinux_ss,
> > > > > > > policydb, and task_security_struct data structures.
> > > > > > >
> > > > > > > NB To test/use this mechanism, one must install the
> > > > > > > necessary build-time dependencies, e.g. gcc-plugin-devel on
> > Fedora,
> > > > > > > and enable CONFIG_GCC_PLUGIN_RANDSTRUCT in the kernel
> > configuration.
> > > > > > >
> > > > > > > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > > > > >
> > > > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > > > >
> > > > > > -Kees
> > > > > >
> > > > > > > ---
> > > > > > > I would have expected that two kernels built with the same config
> > > > > > > with this enabled would have yielded different struct layouts in
> > > > > > > pahole vmlinux output, but that doesn't appear to be the case.
> > They
> > > > > > > do have different seeds.  Am I doing something wrong?
> > > > > > > Also, does DEBUG_INFO_BTF effectively undermine/negate the
> > benefits
> > > > of
> > > > > > this
> > > > > > > change if enabled?
> > > > > > >
> > > > > > >  security/selinux/include/objsec.h   | 2 +-
> > > > > > >  security/selinux/include/security.h | 2 +-
> > > > > > >  security/selinux/ss/policydb.h      | 2 +-
> > > > > > >  security/selinux/ss/services.h      | 2 +-
> > > > > > >  4 files changed, 4 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/security/selinux/include/objsec.h
> > > > > > b/security/selinux/include/objsec.h
> > > > > > > index a4a86cbcfb0a..330b7b6d44e0 100644
> > > > > > > --- a/security/selinux/include/objsec.h
> > > > > > > +++ b/security/selinux/include/objsec.h
> > > > > > > @@ -35,7 +35,7 @@ struct task_security_struct {
> > > > > > >       u32 create_sid;         /* fscreate SID */
> > > > > > >       u32 keycreate_sid;      /* keycreate SID */
> > > > > > >       u32 sockcreate_sid;     /* fscreate SID */
> > > > > > > -};
> > > > > > > +} __randomize_layout;
> > > > > > >
> > > > > > >  enum label_initialized {
> > > > > > >       LABEL_INVALID,          /* invalid or not initialized */
> > > > > > > diff --git a/security/selinux/include/security.h
> > > > > > b/security/selinux/include/security.h
> > > > > > > index 49737087ad33..3ea406ad91b6 100644
> > > > > > > --- a/security/selinux/include/security.h
> > > > > > > +++ b/security/selinux/include/security.h
> > > > > > > @@ -110,7 +110,7 @@ struct selinux_state {
> > > > > > >       bool policycap[__POLICYDB_CAPABILITY_MAX];
> > > > > > >       struct selinux_avc *avc;
> > > > > > >       struct selinux_ss *ss;
> > > > > > > -};
> > > > > > > +} __randomize_layout;
> > > > > > >
> > > > > > >  void selinux_ss_init(struct selinux_ss **ss);
> > > > > > >  void selinux_avc_init(struct selinux_avc **avc);
> > > > > > > diff --git a/security/selinux/ss/policydb.h
> > > > > > b/security/selinux/ss/policydb.h
> > > > > > > index bc56b14e2216..98afe52a3d19 100644
> > > > > > > --- a/security/selinux/ss/policydb.h
> > > > > > > +++ b/security/selinux/ss/policydb.h
> > > > > > > @@ -307,7 +307,7 @@ struct policydb {
> > > > > > >
> > > > > > >       u16 process_class;
> > > > > > >       u32 process_trans_perms;
> > > > > > > -};
> > > > > > > +} __randomize_layout;;
> > > > > > >
> > > > > > >  extern void policydb_destroy(struct policydb *p);
> > > > > > >  extern int policydb_load_isids(struct policydb *p, struct sidtab
> > > > *s);
> > > > > > > diff --git a/security/selinux/ss/services.h
> > > > > > b/security/selinux/ss/services.h
> > > > > > > index fc40640a9725..c5896f39e8f6 100644
> > > > > > > --- a/security/selinux/ss/services.h
> > > > > > > +++ b/security/selinux/ss/services.h
> > > > > > > @@ -31,7 +31,7 @@ struct selinux_ss {
> > > > > > >       struct selinux_map map;
> > > > > > >       struct page *status_page;
> > > > > > >       struct mutex status_lock;
> > > > > > > -};
> > > > > > > +} __randomize_layout;
> > > > > > >
> > > > > > >  void services_compute_xperms_drivers(struct extended_perms
> > *xperms,
> > > > > > >                               struct avtab_node *node);
> > > > > > > --
> > > > > > > 2.23.0
> > > > > > >
> > > > > >
> > > > > > --
> > > > > > Kees Cook
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > V/R,
> > > > >
> > > > > Wenhui Zhang
> > > > >
> > > > > Email: wenhui@gwmail.gwu.edu
> > > > >            Telephone: 1-(703) 424 3193
> > > >
> > > > --
> > > > Kees Cook
> > > >
> > >
> > >
> > > --
> > > V/R,
> > >
> > > Wenhui Zhang
> > >
> > > Email: wenhui@gwmail.gwu.edu
> > >            Telephone: 1-(703) 424 3193
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
