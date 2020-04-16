Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77820C2BA19
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 02:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A68020737
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 02:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MKd7MYCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgDPCXD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731031AbgDPCXB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Apr 2020 22:23:01 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605FAC061A0C
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 19:22:59 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id r7so788959edo.11
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 19:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYtUEBdC5Ifp+xVzbYO1cqqWJgLSKbWtq3IBXSraMTs=;
        b=MKd7MYCGjqM4NIn8C8szRZtQyrI5PerMq9ynQgyBp6OfMY3NMC9RMFS/33YJtbqYcB
         4e34AQfNnYVG7gB0epOwnTm2NbFP4JBlAJrkmmGQWIVX84ebePQPflBsXazKjtEriCll
         GkCFjJ5y93tDT7RfxpcIhEbHjpU5zXK6o5wUBJIkWWRwFLBhMdSVT6X4AWFFS9RgRVcN
         e47lyPqPiJjMvRlAo1Q96YmjwaNLekcE0WG+1rwECdAd8ffKEOIoOopECApkY8+VYRqP
         ZRWol+/lpZ1AV6Qbr+oTE866dtvhNHWVy/WOz4Ed9RQTml0do5gpUyvuribhC6pPd6Y+
         iO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYtUEBdC5Ifp+xVzbYO1cqqWJgLSKbWtq3IBXSraMTs=;
        b=rKr13CqIGloRYQLoWZpaAFZFHYpe6ZfZHSF5TyOkkQC3/MhCuLYX0F/ms4RTaptMY1
         p/lSZ+3JGAwjV4QXtLpMK9E06KwwlDS/iObjr7Exa/cOPopoO280gDuqYFCFDreaROgN
         C0i408tzxYjOwZVvpA8WgPGCQDfvMGHaV2dJYKzkrMJDqMmnVjnFCc8QC4GIAR08KH3P
         lhim+XtRbKnUZEIsKD9YuTTkq7JZbQ8Idt4QLLnYJE/z9AGYPiZHMIjIjpjO6BMkoa0F
         Lx1xy4RN8dpumOp8yr/zC2c4wzjJfAA7V1N5RXX++VmmlZRM6+jV0DdzvCjx7tgaBgOq
         ESRw==
X-Gm-Message-State: AGi0Puaf4f2OdCfOdlaHqgcJyr6w8d6Q7rlGscS3wBO4JBWxqG5b9PpZ
        M4X6YmWTsLpJGK5BfhB7nyYyq5qv7sA5ALW5nzUj
X-Google-Smtp-Source: APiQypIOB+rI4TCwxmxw/bxmnnq2wK2LkMyg8VZYovW/FNSQ0yZOFJ0Oj5b0PxwDIOR6HFW1MQE8Yn1B2MMdMT9D1A8=
X-Received: by 2002:aa7:cb0f:: with SMTP id s15mr1291705edt.164.1587003777880;
 Wed, 15 Apr 2020 19:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200327151941.95619-1-omosnace@redhat.com>
In-Reply-To: <20200327151941.95619-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Apr 2020 22:22:46 -0400
Message-ID: <CAHC9VhRJ5Vbz+4S_33PHf-X+3tZ-VhLSSEEJ9kRRTtOoxYnSPQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: implement new format of filename transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 27, 2020 at 11:19 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Implement a new, more space-efficient way of storing filename
> transitions in the binary policy. The internal structures have already
> been converted to this new representation; this patch just implements
> reading/writing an equivalent represntation from/to the binary policy.
>
> This new format reduces the size of Fedora policy from 7.6 MB to only
> 3.3 MB (with policy optimization enabled in both cases). With the
> unconfined module disabled, the size is reduced from 3.3 MB to 2.4 MB.
>
> The time to load policy into kernel is also shorter with the new format.
> On Fedora Rawhide x86_64 it dropped from 157 ms to 106 ms; without the
> unconfined module from 115 ms to 105 ms.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/include/security.h |   3 +-
>  security/selinux/ss/policydb.c      | 212 ++++++++++++++++++++++++----
>  2 files changed, 189 insertions(+), 26 deletions(-)

...

> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index d6036c018cf2..b0e02cfe3ce1 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -41,10 +41,11 @@
>  #define POLICYDB_VERSION_XPERMS_IOCTL  30
>  #define POLICYDB_VERSION_INFINIBAND            31
>  #define POLICYDB_VERSION_GLBLUB                32
> +#define POLICYDB_VERSION_COMP_FTRANS   33 /* compressed filename transitions */
>
>  /* Range of policy versions we understand*/
>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> -#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_GLBLUB
> +#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_COMP_FTRANS
>
>  /* Mask for just the mount related flags */
>  #define SE_MNTMASK     0x0f
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 932b2b9bcdb2..f355876ed793 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -154,6 +154,11 @@ static struct policydb_compat_info policydb_compat[] = {
>                 .sym_num        = SYM_NUM,
>                 .ocon_num       = OCON_NUM,
>         },
> +       {
> +               .version        = POLICYDB_VERSION_COMP_FTRANS,
> +               .sym_num        = SYM_NUM,
> +               .ocon_num       = OCON_NUM,
> +       },
>  };
>
>  static struct policydb_compat_info *policydb_lookup_compat(int version)
> @@ -461,23 +466,16 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
>  /*
>   * Initialize a policy database structure.
>   */
> -static int policydb_init(struct policydb *p)
> +static void policydb_init(struct policydb *p)
>  {
>         memset(p, 0, sizeof(*p));
>
>         avtab_init(&p->te_avtab);
>         cond_policydb_init(p);
>
> -       p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp,
> -                                          (1 << 11));
> -       if (!p->filename_trans)
> -               return -ENOMEM;
> -
>         ebitmap_init(&p->filename_trans_ttypes);
>         ebitmap_init(&p->policycaps);
>         ebitmap_init(&p->permissive_map);
> -
> -       return 0;
>  }
>
>  /*
> @@ -1842,7 +1840,7 @@ out:
>         return rc;
>  }
>
> -static int filename_trans_read_one(struct policydb *p, void *fp)
> +static int filename_trans_read_one_old(struct policydb *p, void *fp)

If you have to respin this patch, please change from XXX_old(...) to
XXX_compat(...); there is some precedence for using _compat in the
SELinux kernel code.

Same thing with the _write_ code.

>  {
>         struct filename_trans_key key, *ft = NULL;
>         struct filename_trans_datum *last, *datum = NULL;
> @@ -1925,6 +1923,99 @@ out:
>         return rc;
>  }
>
> +static int filename_trans_read_one_new(struct policydb *p, void *fp)

No need to call this XXX_new(), just stick to the original name and
XXX_compat().

Same thing with the _write_ code.

> +{
> +       struct filename_trans_key *ft = NULL;
> +       struct filename_trans_datum **dst, *datum, *first = NULL;
> +       char *name = NULL;
> +       u32 len, ttype, tclass, ndatum, i;
> +       __le32 buf[3];
> +       int rc;
> +
> +       /* length of the path component string */
> +       rc = next_entry(buf, fp, sizeof(u32));
> +       if (rc)
> +               return rc;
> +       len = le32_to_cpu(buf[0]);
> +
> +       /* path component string */
> +       rc = str_read(&name, GFP_KERNEL, fp, len);
> +       if (rc)
> +               return rc;
> +
> +       rc = next_entry(buf, fp, sizeof(u32) * 3);
> +       if (rc)
> +               goto out;
> +
> +       ttype = le32_to_cpu(buf[0]);
> +       tclass = le32_to_cpu(buf[1]);
> +
> +       rc = ebitmap_set_bit(&p->filename_trans_ttypes, ttype, 1);
> +       if (rc)
> +               goto out;

Should we move the p->filename_trans_ttypes update to the bottom of
the function where we increment filename_trans_count?

> +       ndatum = le32_to_cpu(buf[2]);
> +       if (ndatum == 0) {
> +               pr_err("SELinux:  Filename transition key with no datum\n");
> +               rc = -ENOENT;
> +               goto out;
> +       }
> +
> +       dst = &first;
> +       for (i = 0; i < ndatum; i++) {
> +               rc = -ENOMEM;
> +               datum = kmalloc(sizeof(*datum), GFP_KERNEL);
> +               if (!datum)
> +                       goto out;
> +
> +               *dst = datum;
> +
> +               /* ebitmap_read() will at least init the bitmap */
> +               rc = ebitmap_read(&datum->stypes, fp);
> +               if (rc)
> +                       goto out;
> +
> +               rc = next_entry(buf, fp, sizeof(u32));
> +               if (rc)
> +                       goto out;
> +
> +               datum->otype = le32_to_cpu(buf[0]);
> +               datum->next = NULL;
> +
> +               dst = &datum->next;
> +       }
> +
> +       rc = -ENOMEM;
> +       ft = kmalloc(sizeof(*ft), GFP_KERNEL);
> +       if (!ft)
> +               goto out;
> +
> +       ft->ttype = ttype;
> +       ft->tclass = tclass;
> +       ft->name = name;
> +
> +       rc = hashtab_insert(p->filename_trans, ft, first);
> +       if (rc == -EEXIST)
> +               pr_err("SELinux:  Duplicate filename transition key\n");
> +       if (rc)
> +               goto out;
> +
> +       p->filename_trans_count++;
> +       return 0;
> +
> +out:
> +       kfree(ft);
> +       kfree(name);
> +       while (first) {
> +               datum = first;
> +               first = first->next;
> +
> +               ebitmap_destroy(&datum->stypes);
> +               kfree(datum);
> +       }
> +       return rc;
> +}

-- 
paul moore
www.paul-moore.com
