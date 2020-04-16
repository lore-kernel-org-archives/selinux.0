Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B90C352BE
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 09:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F1921D7A
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 09:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qr/hlcT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504219AbgDPJxR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:53:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27312 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2504377AbgDPJxK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 05:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587030788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBcoGVNEtSUv9zH5D+oYi7BXpGp5hJM5FPQVqTq2oBM=;
        b=Qr/hlcT6b8t6aB42z6ylKa+ndF6lgTAP4KHlCfp4xNswp8qiuSsmCJBp6GAxKO5p4myfep
        6iPaXaAggyuZwFmdRiDgQqXou2ENqtu5VGeL3eu6nlg6qysznLVDdHQovMfX9gOsDrzgjD
        i0IJcFYCHbkcRkS2iJXKXoCB7Cuvlrk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-jT0KwqTGPASkHfS_nht4vw-1; Thu, 16 Apr 2020 05:53:00 -0400
X-MC-Unique: jT0KwqTGPASkHfS_nht4vw-1
Received: by mail-oi1-f200.google.com with SMTP id 205so10578654oid.11
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 02:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBcoGVNEtSUv9zH5D+oYi7BXpGp5hJM5FPQVqTq2oBM=;
        b=MnvkIZxmv2eMIZZmFd7eg2FPqkLBsm3UbPfF4B7fM+EnbXohjxhCgc5AkjHOi2Z0C/
         Cp5rHuxJKaq1CE2AgeapH8a8laQn7wk8ybPJp678kFAVP2GNfAHSwbBguOKBYY1PiC7P
         jNANnfPcn06+OkbJ5n0obF0CSvyjtVNVJx2nBrSvhyTNkTK2xA7ef4IfgwSD2r+XzPJ9
         Zrgr5rXyWKxPBuyRYQWjYKKUes0B8S6S5L1Pb87TS198pbDqqkb48N+fZu5xPqC0O8iT
         vsmnpbafOptmwcsyxkkwJJwv6L2kd6KLEvu4wzmQMLCPZogUTkfxfgLl8IVvHy/LSY7O
         nmhA==
X-Gm-Message-State: AGi0PuarlSNEpdjgx9EX6Kgtn8/T/UYHgZkIGPItBCghS8Vbz3h3HJwz
        ahMIdz2gOlACwVOJczr2g0j1BjCF2boVtqqLiafrt0soSsL3FakoDgbGljRcokxVp/1s/HYnpo2
        KMAOpvUJL2RttA9S9X9JX6stLqrygoXNC1w==
X-Received: by 2002:a9d:69d5:: with SMTP id v21mr26462407oto.197.1587030779264;
        Thu, 16 Apr 2020 02:52:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypJwVI0uwukT7eG2t/oI9HVmyQCpebQ7r4toZEVeWLt/yKr7OWm1pOFs8b09Hz5MjGDeC3d/4FpWQp+Hk+nObTc=
X-Received: by 2002:a9d:69d5:: with SMTP id v21mr26462398oto.197.1587030778953;
 Thu, 16 Apr 2020 02:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200327151941.95619-1-omosnace@redhat.com> <CAHC9VhRJ5Vbz+4S_33PHf-X+3tZ-VhLSSEEJ9kRRTtOoxYnSPQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRJ5Vbz+4S_33PHf-X+3tZ-VhLSSEEJ9kRRTtOoxYnSPQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 16 Apr 2020 11:52:47 +0200
Message-ID: <CAFqZXNvQ5GTD81E9LZdHFduCuy6gTs6MSqUS4zU4sPTUWtyS1A@mail.gmail.com>
Subject: Re: [PATCH] selinux: implement new format of filename transitions
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 16, 2020 at 4:23 AM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Mar 27, 2020 at 11:19 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Implement a new, more space-efficient way of storing filename
> > transitions in the binary policy. The internal structures have already
> > been converted to this new representation; this patch just implements
> > reading/writing an equivalent represntation from/to the binary policy.
> >
> > This new format reduces the size of Fedora policy from 7.6 MB to only
> > 3.3 MB (with policy optimization enabled in both cases). With the
> > unconfined module disabled, the size is reduced from 3.3 MB to 2.4 MB.
> >
> > The time to load policy into kernel is also shorter with the new format.
> > On Fedora Rawhide x86_64 it dropped from 157 ms to 106 ms; without the
> > unconfined module from 115 ms to 105 ms.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/include/security.h |   3 +-
> >  security/selinux/ss/policydb.c      | 212 ++++++++++++++++++++++++----
> >  2 files changed, 189 insertions(+), 26 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > index d6036c018cf2..b0e02cfe3ce1 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -41,10 +41,11 @@
> >  #define POLICYDB_VERSION_XPERMS_IOCTL  30
> >  #define POLICYDB_VERSION_INFINIBAND            31
> >  #define POLICYDB_VERSION_GLBLUB                32
> > +#define POLICYDB_VERSION_COMP_FTRANS   33 /* compressed filename transitions */
> >
> >  /* Range of policy versions we understand*/
> >  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> > -#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_GLBLUB
> > +#define POLICYDB_VERSION_MAX   POcould still help in case of coredump analysisLICYDB_VERSION_COMP_FTRANS
> >
> >  /* Mask for just the mount related flags */
> >  #define SE_MNTMASK     0x0f
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index 932b2b9bcdb2..f355876ed793 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -154,6 +154,11 @@ static struct policydb_compat_info policydb_compat[] = {
> >                 .sym_num        = SYM_NUM,
> >                 .ocon_num       = OCON_NUM,
> >         },
> > +       {
> > +               .version        = POLICYDB_VERSION_COMP_FTRANS,
> > +               .sym_num        = SYM_NUM,
> > +               .ocon_num       = OCON_NUM,
> > +       },
> >  };
> >
> >  static struct policydb_compat_info *policydb_lookup_compat(int version)
> > @@ -461,23 +466,16 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
> >  /*
> >   * Initialize a policy database structure.
> >   */
> > -static int policydb_init(struct policydb *p)
> > +static void policydb_init(struct policydb *p)
> >  {
> >         memset(p, 0, sizeof(*p));
> >
> >         avtab_init(&p->te_avtab);
> >         cond_policydb_init(p);
> >
> > -       p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp,
> > -                                          (1 << 11));
> > -       if (!p->filename_trans)
> > -               return -ENOMEM;
> > -
> >         ebitmap_init(&p->filename_trans_ttypes);
> >         ebitmap_init(&p->policycaps);
> >         ebitmap_init(&p->permissive_map);
> > -
> > -       return 0;
> >  }
> >
> >  /*
> > @@ -1842,7 +1840,7 @@ out:
> >         return rc;
> >  }
> >
> > -static int filename_trans_read_one(struct policydb *p, void *fp)
> > +static int filename_trans_read_one_old(struct policydb *p, void *fp)
>
> If you have to respin this patch, please change from XXX_old(...) to
> XXX_compat(...); there is some precedence for using _compat in the
> SELinux kernel code.
>
> Same thing with the _write_ code.
>
> >  {
> >         struct filename_trans_key key, *ft = NULL;
> >         struct filename_trans_datum *last, *datum = NULL;
> > @@ -1925,6 +1923,99 @@ out:
> >         return rc;
> >  }
> >
> > +static int filename_trans_read_one_new(struct policydb *p, void *fp)
>
> No need to call this XXX_new(), just stick to the original name and
> XXX_compat().
>
> Same thing with the _write_ code.

OK, that makes sense.

>
> > +{
> > +       struct filename_trans_key *ft = NULL;
> > +       struct filename_trans_datum **dst, *datum, *first = NULL;
> > +       char *name = NULL;
> > +       u32 len, ttype, tclass, ndatum, i;
> > +       __le32 buf[3];
> > +       int rc;
> > +
> > +       /* length of the path component string */
> > +       rc = next_entry(buf, fp, sizeof(u32));
> > +       if (rc)
> > +               return rc;
> > +       len = le32_to_cpu(buf[0]);
> > +
> > +       /* path component string */
> > +       rc = str_read(&name, GFP_KERNEL, fp, len);
> > +       if (rc)
> > +               return rc;
> > +
> > +       rc = next_entry(buf, fp, sizeof(u32) * 3);
> > +       if (rc)
> > +               goto out;
> > +
> > +       ttype = le32_to_cpu(buf[0]);
> > +       tclass = le32_to_cpu(buf[1]);
> > +
> > +       rc = ebitmap_set_bit(&p->filename_trans_ttypes, ttype, 1);
> > +       if (rc)
> > +               goto out;
>
> Should we move the p->filename_trans_ttypes update to the bottom of
> the function where we increment filename_trans_count?

I think it doesn't matter in practice, since on error the whole
policydb is just thrown away anyway, but I agree it fits there a
little better.

Also, looking at the filename_trans_count increment, it should be
adding 'ndatum' instead of just 1 to match what the compat path puts
there. (Again this doesn't matter in practice, since the policyvers
will always stay the same and nothing will use that value, but it
should still be consistent.)

>
> > +       ndatum = le32_to_cpu(buf[2]);
> > +       if (ndatum == 0) {
> > +               pr_err("SELinux:  Filename transition key with no datum\n");
> > +               rc = -ENOENT;
> > +               goto out;
> > +       }
> > +
> > +       dst = &first;
> > +       for (i = 0; i < ndatum; i++) {
> > +               rc = -ENOMEM;
> > +               datum = kmalloc(sizeof(*datum), GFP_KERNEL);
> > +               if (!datum)
> > +                       goto out;
> > +
> > +               *dst = datum;
> > +
> > +               /* ebitmap_read() will at least init the bitmap */
> > +               rc = ebitmap_read(&datum->stypes, fp);
> > +               if (rc)
> > +                       goto out;
> > +
> > +               rc = next_entry(buf, fp, sizeof(u32));
> > +               if (rc)
> > +                       goto out;
> > +
> > +               datum->otype = le32_to_cpu(buf[0]);
> > +               datum->next = NULL;
> > +
> > +               dst = &datum->next;
> > +       }
> > +
> > +       rc = -ENOMEM;
> > +       ft = kmalloc(sizeof(*ft), GFP_KERNEL);
> > +       if (!ft)
> > +               goto out;
> > +
> > +       ft->ttype = ttype;
> > +       ft->tclass = tclass;
> > +       ft->name = name;
> > +
> > +       rc = hashtab_insert(p->filename_trans, ft, first);
> > +       if (rc == -EEXIST)
> > +               pr_err("SELinux:  Duplicate filename transition key\n");
> > +       if (rc)
> > +               goto out;
> > +
> > +       p->filename_trans_count++;
> > +       return 0;
> > +
> > +out:
> > +       kfree(ft);
> > +       kfree(name);
> > +       while (first) {
> > +               datum = first;
> > +               first = first->next;
> > +
> > +               ebitmap_destroy(&datum->stypes);
> > +               kfree(datum);
> > +       }
> > +       return rc;
> > +}
>
> --
> paul moore
> www.paul-moore.com
>


--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

