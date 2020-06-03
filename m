Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205E1C433E1
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 23:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E68D52077D
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 23:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY+mnY8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgFCXih (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgFCXig (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jun 2020 19:38:36 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EA4C08C5C0;
        Wed,  3 Jun 2020 16:38:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so2338046pfe.4;
        Wed, 03 Jun 2020 16:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SUOSMdyRcBZ5Xy8FVna5RTAeLBpLZtiqmspjCBJ9jr0=;
        b=EY+mnY8rdtsWINgGun3b/e+EpjZjihsmGQpwkUGb1yukgTpop7At2xrJtCGfl++U/4
         cPvPL1WbZyVfxgWtuUxwnhi5oBPCLYPjKQJfo8RQuDePxevFbybMtCOfeewgLXFg22AG
         0zZrMstt1mbrl9xUo2MCHqJT2r0DyeY7wfxgo6tcrGezn2B30LaF+gvMtRpmvDqs8otF
         v+u5pQ3+QHQb2O6X/MukWUB3YW70CHHiIqR390WopWQZMBEEOcVQ1lML4tlNWCeFJL8N
         ywaal83ZXX+K8LsE8m9Iz2c4UVu01QPyJrCwNnC8G7Xv0ttm2trlUJ3LQn3UMOsOTTCO
         /gLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SUOSMdyRcBZ5Xy8FVna5RTAeLBpLZtiqmspjCBJ9jr0=;
        b=aPRlHUo3DN+u9TTDAm9iWP0Q7swWgTLrs1CC2S0wiRXqhXkkQcZDxyCb2ZsnTLqUna
         AbOkhFpsn3OfeggdyjYZG1Ar3rLAlsX2/Info5KAYiBvoOH9+fYTg0udg0VIM+oN2+R+
         P7wzdo/BAOvRUFsGDuxO0Xs/KRB11g/y1EHMGEuRkVyRWL3StxaAdTDMNpzXs1Jy0knb
         d3Cb43oNBenuOEHsNtxldsUup9m/m0FX2rPVzJRi60sHVJIvOwbgGM+u0YRXXm3QrpZP
         y0IMvbC7uE6fzDn1Ge6q8kJn9nXAQSGYMGS4DYt4WiPtq+PYiRDyhthPB1HV0Kc/mgVB
         PIlw==
X-Gm-Message-State: AOAM533bj6Y+LZD2BINfQefUS3pLobkMk3GLBQ8ghWc+jgmGHTNFfAyo
        iZYGr/z9JxlxvHqyqlrURvY=
X-Google-Smtp-Source: ABdhPJyCrU53Sgx/T0I/gCbu00L6R2xyVW+WwO6d/guvguxvEGVU2X639wYa5rkp4DgqzK9CsYsQ+Q==
X-Received: by 2002:aa7:9052:: with SMTP id n18mr1521387pfo.319.1591227515336;
        Wed, 03 Jun 2020 16:38:35 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:514a])
        by smtp.gmail.com with ESMTPSA id t4sm2335943pgp.2.2020.06.03.16.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 16:38:34 -0700 (PDT)
Date:   Wed, 3 Jun 2020 16:38:32 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] SELinux patches for v5.8
Message-ID: <20200603233832.n6lgfyp7t36nmxpd@ast-mbp.dhcp.thefacebook.com>
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
 <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
 <290017a8-d943-570f-1f90-acecf1c075a1@schaufler-ca.com>
 <CAHk-=wgkZROyMpBa8EKPDVK=SvurnrzJXgphQ8Fstx8rrfO6MQ@mail.gmail.com>
 <20200603210202.thwuv2ye672ifwim@ast-mbp.dhcp.thefacebook.com>
 <d0ce1c02-4838-4299-457e-bf5e63875873@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0ce1c02-4838-4299-457e-bf5e63875873@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 03, 2020 at 03:00:05PM -0700, Casey Schaufler wrote:
> On 6/3/2020 2:02 PM, Alexei Starovoitov wrote:
> > On Wed, Jun 03, 2020 at 10:37:47AM -0700, Linus Torvalds wrote:
> >> On Wed, Jun 3, 2020 at 10:20 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>> We could have inode->i_security be the blob, rather than a pointer to it.
> >>> That will have its own performance issues.
> >> It wouldn't actually really fix anything, because the inode is so big
> >> and sparsely accessed that it doesn't even really help the cache
> >> density issue. Yeah, it gets rid of the pointer access, but that's
> >> pretty much it. The fact that we randomize the order means that we
> >> can't even really try to aim for any cache density.
> >>
> >> And it would actually not be possible with the current layered
> >> security model anyway, since those blob sizes are dynamic at runtime.
> >>
> >> If we had _only_ SELinux, we could perhaps have hidden the
> >> sid/sclass/task_sid directly in the inode (it would be only slightly
> >> larger than the pointer is, anyway), but even that ship sailed long
> >> long ago due to the whole "no security person can ever agree with
> >> another one on fundamentals".
> > Also there is bpf_lsm now that we're going to run it in production, 
> > so performance is as important as ever.
> > Traditional lsm-s have per-lsm per-inode blob.
> > For bpf that doesn't work, since progs come and go at run-time and
> > independent from each other.
> 
> The inode blob is for attributes associated with the filesystem object.
> There are cred and task blobs for program information.
> If you need separate per-task data you should put it there.

task_struct will have its own member for bpf local storage as I explained.
For most structs we won't be adding new member or even reusing lsm's security
blob pointer, because existing bpf hash table approach is fast enough and
flexible, since it can key based on anything. Any pointer and any struct can
have additional scratch area available to bpf progs. We're adding
*_local_storage only to kernel objects where performance is critical. Like
'struct sock'.

> > So we need per-program per-inode blob.
> > To maintain good performance we've proposed:
> > @@ -740,6 +741,10 @@  struct inode {
> >  	struct fsverity_info	*i_verity_info;
> >  #endif
> >  
> > +#ifdef CONFIG_BPF_SYSCALL
> > +	struct bpf_local_storage __rcu	*inode_bpf_storage;
> > +#endif
> >
> > https://patchwork.ozlabs.org/project/netdev/patch/20200526163336.63653-3-kpsingh@chromium.org/
> >
> > but got pushback, so we're going to use lsm style for now:
> > +static inline struct bpf_lsm_storage *bpf_inode(const struct inode *inode)
> > +{
> > +       if (unlikely(!inode->i_security))
> > +               return NULL;
> > +
> > +       return inode->i_security + bpf_lsm_blob_sizes.lbs_inode;
> > +}
> >
> > which means extra kmalloc for every inode, extra pointer deref, global var
> > access, and additional math just to get to 'inode_bpf_storage' pointer.
> >
> > We have similar pointer in 'struct sock' already:
> > #ifdef CONFIG_BPF_SYSCALL
> >         struct bpf_sk_storage __rcu     *sk_bpf_storage;
> > #endif
> > that is used by variety of networking bpf programs.
> > The commit 6ac99e8f23d4 ("bpf: Introduce bpf sk local storage")
> > has benchmarking data for it:
> >   hash table with 8-byte key -> 152ns per bpf run 
> >   sk_bpf_storage -> 66ns per bpf run
> > Hashtable suppose to be O(1) with L1$ hit, but it turned out
> > to be noticeably slower than sk_bpf_storage.
> > We expect to see similar performance gains for inode_bpf_storage
> > vs hashtable approach that people use now.
> > Eventually we'll add task_bpf_storage as well.
> > Right now every other bpf tracing script is using pid as a key
> > in a separate hash table to store per-task data. For high frequency
> > events that adds up. task_bpf_storage will accelerate that.
> 
> Why aren't you using a task blob? We have support for what
> you need. 
> 
> > Another way to look at it is shared inode->i_security across
> > different inodes won't work for us. We need something really
> > cheap like single 'inode_bpf_storage' pointer that is zero
> > most of the time and for few inodes bpf progs will keep their
> > scratch data in there.
> > For now lsm style bpf_inode() approach is ok-ish.
> > But we will come back when we collect perf numbers to justify
> > why direct pointer in the 'struct inode' is a win.
> 
> It would be really helpful if instead of "the regular mechanism
> is too slow, so we abandoned it" we could do "the regular mechanism
> was to slow, so we made it better". I appreciate that every bit of
> performance matters. That's true for all of the security modules,
> which is why I object to special case tricks to boost the performance
> of one module at the expense of everything else.

It's not about lsm and not about bpf_lsm.
The *_local_storage infrastructure is generic and available to
bpf program types where it can be done safely.
Like sk_local_storage is avaiable to ~25% of networking bpf prog types.
(not to 100% because bpf progs run in a many different contexts
and in some sock pointer is not accessibly safely).
Similarly inode_local_storage will be available to different types
of progs. Including tracing progs where it's safe.

To rephrase bpf's *_local_storage could have been used by selinux
and other lsm instead of current infra and likely would have been
faster. In that sense selinux would be seen as another bpf program.
It's not a program, of course, but it could have accessed it through
the same mechanism.
So, no, we're not "abandoning existing mechanism because it's too slow"
we've created a new mechanism because it's generic (not related
to lsm-s and security) and made it faster for all, so other kernel
bits (including lsm-s) are welcome to use it.
