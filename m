Return-Path: <SRS0=cHrg=RV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C068C43381
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 16:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6104420989
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 16:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="u+z5hMth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfCRQaB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:30:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43230 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfCRQaB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Mar 2019 12:30:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id p20so1796420lji.10
        for <selinux@vger.kernel.org>; Mon, 18 Mar 2019 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OokwICR1EaMWxSspcBrfTFPwSLwxOUmEBWakGxJZAeM=;
        b=u+z5hMthuOFWRC0ETyNeEsu/8cMIWgAeFK21iQsly94vMe5cqovPCTWUYFIB9x2ALb
         4BT/XOdfojAeow+1lk9aLElY+hPqyDq4yJbkzfr7+lmzygZeBYNZDWMrjQli5LDFP6bu
         L2D4DiCUdE4+Drhpkeu4qEBA7Z178HdJoeBa+MVojG+OD6rPMWEUeynGH0mWJPlcgDDf
         T2O+YKXD9WpbrYthSFxrooxO87PXNy9M7KFzzQrHAtJFrxM61i8D7vDSY9kXE/TyIg9P
         kONxW6Vwsf0H2Q233cyjXrFxOFGJ358VN/skTOgQPMCRryasdBMyTGnECoc5lu0OP4aW
         G7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OokwICR1EaMWxSspcBrfTFPwSLwxOUmEBWakGxJZAeM=;
        b=TryUMOWSeqfnfS0amuPEh01gJovy4s/cz5BnNKnOzJIQq0OTg2dkf0Hcpnm54UCzzo
         j2Cec9Xoi1iuFT0e06lCvf3C22iZoraF0qEb1jFbPewNUfBQk285W9f9xIl22N22ZhCm
         Z+RcN4+56wrMrWZrPH8q/+ZZKPDygNtjeQ2e1vHy/976cjCLkaNnLcbF8xbroPipe6ND
         I596e/5fhDnHMcr8GNj4TNam5sLnwD+2eE14uoHM0KLQYZVnQ5fkcDmJ9rVwIi0Ox2tv
         rZiTo9dvAkWVhJK2vD82ER/14aSQcU11ZsVmdC7rmVD9t+RYaRjSgaXmsAra2diq4NGd
         lOJw==
X-Gm-Message-State: APjAAAXvAYO2VrfC+vhQzgocyYXUI63AWp3vzLqNukbyQ66cKcoA3FT3
        CVi6do82Hgs/G8eOx5j/zq0WwMa5fGBRzYwQZJ35
X-Google-Smtp-Source: APXvYqxy02BwkfP0ynSz3MUJUgC3Lc9lYU951CuozLyYfifV3mTJv4jUb0EBd8UXKohL9C4zuw2R/Y8A5S+d5wK/ctA=
X-Received: by 2002:a2e:500d:: with SMTP id e13mr8141965ljb.169.1552926599221;
 Mon, 18 Mar 2019 09:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190317134653.26824-1-omosnace@redhat.com>
In-Reply-To: <20190317134653.26824-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 18 Mar 2019 12:29:48 -0400
Message-ID: <CAHC9VhSkXF+u+k9b3=753GrFyhfjJNdZ0Mh8uT4j5_iJWyNTbQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix NULL dereference in policydb_destroy()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        syzbot+a57b2aff60832666fc28@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 17, 2019 at 9:47 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The conversion to kvmalloc() forgot to account for the possibility that
> p->type_attr_map_array might be null in policydb_destroy().
>
> Fix this by destroying its contents only if it is not NULL.
>
> Also make sure ebitmap_init() is called on all entries before
> policydb_destroy() can be called. Right now this is a no-op, because
> both kvcalloc() and ebitmap_init() just zero out the whole struct, but
> let's rather not rely on a specific implementation.
>
> Reported-by: syzbot+a57b2aff60832666fc28@syzkaller.appspotmail.com
> Fixes: acdf52d97f82 ("selinux: convert to kvmalloc")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> NOTE: This applies directly on top of current Linus' tree, since the
> problematic commit is not present in the selinux/stable-5.1 branch.

Thanks for fixing this; I was busy getting the libseccomp v2.4 release
out towards the end of last week and hadn't had a chance to look at
this yet.

The patch looks good to me.  I just merged it into selinux/stable-5.1
and I'll send that up to Linus later this week once I've finished
merging/testing stuff that was waiting on the merge window to close.

For those on the To/CC line who haven't followed this very closely;
the kvmalloc() patches were posted a while ago, but I never merged the
SELinux portions as I there were some concerns brought up that were
never addressed (concerns around small systems and difficulty in an
RCU conversion).  Evidently the higher ups felt these concerns were
not significant enough and they merged the kvmalloc() changes anyway;
this is why a non-trivial SELinux patch ended up in Linus' tree
without going through the SELinux tree.  I'm not sure I feel strongly
enough about the kvmalloc() change and the objections at this point to
object to the kvmalloc() conversion now that it is in Linus' tree, so
this is really just a FYI.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 6b576e588725..daecdfb15a9c 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -828,9 +828,11 @@ void policydb_destroy(struct policydb *p)
>         hashtab_map(p->range_tr, range_tr_destroy, NULL);
>         hashtab_destroy(p->range_tr);
>
> -       for (i = 0; i < p->p_types.nprim; i++)
> -               ebitmap_destroy(&p->type_attr_map_array[i]);
> -       kvfree(p->type_attr_map_array);
> +       if (p->type_attr_map_array) {
> +               for (i = 0; i < p->p_types.nprim; i++)
> +                       ebitmap_destroy(&p->type_attr_map_array[i]);
> +               kvfree(p->type_attr_map_array);
> +       }
>
>         ebitmap_destroy(&p->filename_trans_ttypes);
>         ebitmap_destroy(&p->policycaps);
> @@ -2496,10 +2498,13 @@ int policydb_read(struct policydb *p, void *fp)
>         if (!p->type_attr_map_array)
>                 goto bad;
>
> +       /* just in case ebitmap_init() becomes more than just a memset(0): */
> +       for (i = 0; i < p->p_types.nprim; i++)
> +               ebitmap_init(&p->type_attr_map_array[i]);
> +
>         for (i = 0; i < p->p_types.nprim; i++) {
>                 struct ebitmap *e = &p->type_attr_map_array[i];
>
> -               ebitmap_init(e);
>                 if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
>                         rc = ebitmap_read(e, fp);
>                         if (rc)
> --
> 2.20.1
>


-- 
paul moore
www.paul-moore.com
