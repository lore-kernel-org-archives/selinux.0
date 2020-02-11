Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC69C3B187
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 21:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDE320708
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 21:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nl9p0PI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgBKVc2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:32:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52177 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727710AbgBKVc1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 16:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581456746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u/KWRrMhAZ+CXcbcfaq5+Iu6UOne0020/p2FjLKJwzc=;
        b=Nl9p0PI1Vg+hojOqHRChS8S0YqNFSAzKHZV3vhdOT9uAVlIc3C4rUygmvUBgl3qRA/SFuV
        TwCvZvWWK+1ke+JxF2+3e3Vzhu0CF5hJs/aD08svuM0RWpykGGQ5porVdbzEkYPgeCwQfG
        JMJXzg1cctD4WJOeiVz0Enml76MICzQ=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-8VBE2Q0KMMeisjhgYhKfrA-1; Tue, 11 Feb 2020 16:32:20 -0500
X-MC-Unique: 8VBE2Q0KMMeisjhgYhKfrA-1
Received: by mail-ot1-f69.google.com with SMTP id m18so7748692otp.20
        for <selinux@vger.kernel.org>; Tue, 11 Feb 2020 13:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u/KWRrMhAZ+CXcbcfaq5+Iu6UOne0020/p2FjLKJwzc=;
        b=OaBgrJatH88oc9Nt5knSfmJrkLV8W3wQyTkensEIDplGvyXplMsbrqc3uBDSQ8eufb
         aPjicyB+SNVPlyA5DYOoQTgIG/s9nU0jWJX5fMbnDuxpW2b6fmYms6jGk4vPDTxS/Xpu
         sJAs4pvp7R3t8IOQpPNxBecsM6H/7VaGK3kna1a1bITxu54ybyzAsa6DQBHI1bELrY+G
         UyudN+E9PYjSNjsTXcrSOQL6AhcqwgQEF1b4zqUbLJx2ZktUC3jbX2OdhXtuUNS8aKe0
         jpoEm4cYzACwXOka1bJ89LuwovDnVROcHCgybK8ZcIdmMnNjUC8YHjNgMniLgfNnHTxL
         SRaA==
X-Gm-Message-State: APjAAAX2MdZKGFbIFHEf2Kfu+Jwtgee2faVtVhFSFi9V0P5WSlFZ6D7q
        rhnrUGqklKYOlOIAZJl7vFaaVHJINaCGeM2P6OYXDVduIdfB3xDhGZzchOjvOXK+lh5WOiPHSoj
        /JzUtTQqt+fdmnowwJGV5jEK6b4rTODlWAw==
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr7090727otn.22.1581456738873;
        Tue, 11 Feb 2020 13:32:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCIM6ttzH3ssYb7UaPKV55jHNBwKcVqnJlOYvk58+TuNopJtWuLt4+xn6XN661IEEweFedFwwozqkgZ8LM9BQ=
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr7090711otn.22.1581456738473;
 Tue, 11 Feb 2020 13:32:18 -0800 (PST)
MIME-Version: 1.0
References: <20200211163953.12231-1-omosnace@redhat.com> <20200211163953.12231-3-omosnace@redhat.com>
 <19a1cea7-42d5-8cbe-722a-dc05cc6a38a3@tycho.nsa.gov>
In-Reply-To: <19a1cea7-42d5-8cbe-722a-dc05cc6a38a3@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 11 Feb 2020 22:32:07 +0100
Message-ID: <CAFqZXNv2ymj9UKr-P=QFaCKGJW2T9ve4gC=1-72Uq_K2rZDhnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: optimize storage of filename transitions
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 11, 2020 at 9:51 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 2/11/20 11:39 AM, Ondrej Mosnacek wrote:
> > In these rules, each rule with the same (target type, target class,
> > filename) values is (in practice) always mapped to the same result type.
> > Therefore, it is much more efficient to group the rules by (ttype,
> > tclass, filename).
> >
> > Thus, this patch drops the stype field from the key and changes the
> > datum to be a linked list of one or more structures that contain a
> > result type and an ebitmap of source types that map the given target to
> > the given result type under the given filename. The size of the hash
> > table is also incremented to 2048 to be more optimal for Fedora policy
> > (which currently has ~2500 unique (ttype, tclass, filename) tuples,
> > regardless of whether the 'unconfined' module is enabled).
> >
> > Not only does this dramtically reduce memory usage when the policy
> > contains a lot of unconfined domains (ergo a lot of filename based
> > transitions), but it also slightly reduces memory usage of strongly
> > confined policies (modeled on Fedora policy with 'unconfined' module
> > disabled) and significantly reduces lookup times of these rules on
> > Fedora (roughly matches the performance of the rhashtable conversion
> > patch [1] posted recently to selinux@vger.kernel.org).
> >
> > An obvious next step is to change binary policy format to match this
> > layout, so that disk space is also saved. However, since that requires
> > more work (including matching userspace changes) and this patch is
> > already beneficial on its own, I'm posting it separately.
> >
> > Performance/memory usage comparison:
> >
> > Kernel           | Policy load | Policy load   | Mem usage | Mem usage     | openbench
> >                   |             | (-unconfined) |           | (-unconfined) | (createfiles)
> > -----------------|-------------|---------------|-----------|---------------|--------------
> > reference        |       1,30s |         0,91s |      90MB |          77MB | 55 us/file
> > rhashtable patch |       0.98s |         0,85s |      85MB |          75MB | 38 us/file
> > this patch       |       0,95s |         0,87s |      75MB |          75MB | 40 us/file
> >
> > (Memory usage is measured after boot. With SELinux disabled the memory
> > usage was ~60MB on the same system.)
> >
> > [1] https://lore.kernel.org/selinux/20200116213937.77795-1-dev@lynxeye.de/T/
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   security/selinux/ss/policydb.c | 175 ++++++++++++++++++++-------------
> >   security/selinux/ss/policydb.h |   8 +-
> >   security/selinux/ss/services.c |  16 +--
> >   3 files changed, 120 insertions(+), 79 deletions(-)
> >
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index 981797bfc547..62283033bb7d 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -1882,64 +1884,93 @@ out:
> >
> >   static int filename_trans_read_one(struct policydb *p, void *fp)
> >   {
> <snip>
> > +     exists = false;
> > +     last = NULL;
> > +     datum = hashtab_search(p->filename_trans, &key);
> > +     while (datum) {
> > +             if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
> > +                     exists = true;
> > +                     break;
> > +             }
> > +             if (datum->otype == otype) {
> > +                     last = NULL;
>
> Why set last to NULL here?  Seemingly unused afterward if datum is non-NULL?

Good point. I don't like unnecessary code, so I'll wait a while for
possible other comments and then do a v2.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

