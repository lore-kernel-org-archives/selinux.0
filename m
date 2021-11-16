Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F9DC433F5
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 09:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E2061ABF
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 09:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhKPJUu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhKPJUt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Nov 2021 04:20:49 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399B1C061570
        for <selinux@vger.kernel.org>; Tue, 16 Nov 2021 01:17:52 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b40so51392410lfv.10
        for <selinux@vger.kernel.org>; Tue, 16 Nov 2021 01:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0bi8THyIlpiH/rfNtgC+JbqnGfXhfn6GvWqKb6PV2nI=;
        b=s5xXkQkkDVgcskIVGzXO7p0lcorss/x5xeLL2n9+gbAq5aRNF3vvuBAeX3BZiwdJGG
         X14K8J2+dZF27YFviGQgWJf1dGc86nkOhf80nl88xsJoJ6P/4+/BNHrDgpCVLE3t0Jw4
         qeThe+KWzJqOVVl6yf1cry3YT5luKz3MJ5gFtxvz4BrFTW2mslQwEFX2MZh5rwKrAemc
         rIX+S3Bt/DTuXUwu7YVDO+EZCaoFebIiiZhGFiU0OEXWFuohsQwVqJ2MRDjOxrRkmNhg
         rV7z7iBrS62xtj5gMt26tYjolwoWlbYVGUDKBf9MvuwNDvGbFr6qcRUFHEZymeiFEZOT
         lFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0bi8THyIlpiH/rfNtgC+JbqnGfXhfn6GvWqKb6PV2nI=;
        b=aKP5PIXPnMQKXUbrXr7ltGuOxOX/9iIjPNNgitD+HITTjSXZmZuwsRbLgn3OAaOmd7
         XcgX8S5As6Ape3Ftb1lSD6BQ184/uihWKG/G05ZKEiA1cqawc0zE7rWl2fCJE1hg07wT
         KntsGrDYEhVRo+bL164cRF3f3pLKHa3TNiAMpL1gapNxwulm1q6/Bblk7ZSvQoIchIsj
         a/2zju7NutNhmKDBVy8scUuTQLyuZ252n2hF/T5t6QQKrAWyEQHftiY4BYrTiuwL+2Tr
         ZG33B6Q49xojhAI1VIR+XfZrIvjf80Pa6SipFkrTeVovAiqCsEjLQfiCd9T7aE8EnFWm
         FVVA==
X-Gm-Message-State: AOAM533HqkMrcNjiRtAcDO3YlYZpOo20nq+AIo/yYDVcdRXf7Wm3ItW8
        YivkjOCJhE7179zaR01I5ZC3c5QFTGRjGxkif3whgQ==
X-Google-Smtp-Source: ABdhPJyx8IB0rL5CBe1HPVpGe7TMx85tb28iiEhavqY6YKqcLrpt1p8M+A3qY+kOWRjqZVHdzSZM9jJXdTK2tGQz21c=
X-Received: by 2002:a05:6512:398b:: with SMTP id j11mr5303141lfu.461.1637054269834;
 Tue, 16 Nov 2021 01:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20211110111146.3461631-1-brambonne@google.com>
 <CAP+JOzQss7ADw=o-TBx5t_2LaaNF_5TM=Lf5_f2tf_EQzWdGUw@mail.gmail.com> <CABWXKLy5SD8_4Abh7DbboC5aTVNc5KnxuZkhQr+30WQHMG367g@mail.gmail.com>
In-Reply-To: <CABWXKLy5SD8_4Abh7DbboC5aTVNc5KnxuZkhQr+30WQHMG367g@mail.gmail.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Tue, 16 Nov 2021 10:17:38 +0100
Message-ID: <CABXk95ANb5d6jP2R+_-bsEc0x3F9KhvLjaush8YjnBVmZ7ypKw@mail.gmail.com>
Subject: Re: [RFC PATCH] libsepol,checkpolicy: Add netlink xperm support
To:     =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>
Cc:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 16, 2021 at 10:11 AM Bram Bonn=C3=A9 <brambonne@google.com> wro=
te:
>
> On Mon, Nov 15, 2021 at 9:08 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Wed, Nov 10, 2021 at 6:12 AM Bram Bonne <brambonne@google.com> wrote=
:
> > >
> > > Reuse the existing extended permissions infrastructure to support
> > > sepolicy for different netlink message types.
> > >
> > > When individual netlink message types are omitted only the existing
> > > permissions are checked. As is the case for ioctl xperms, this featur=
e
> > > is intended to provide finer granularity for nlmsg_read and nlmsg_wri=
te
> > > permissions, as they may be too imprecise. For example, a single
> > > NETLINK_ROUTE socket may provide access to both an interface's IP
> > > address and to its ARP table, which might have different privacy
> > > implications. In addition, the set of message types has grown over ti=
me,
> > > so even if the current list is acceptable, future additions might not=
 be.
> > > It was suggested before on the mailing list [1] that extended permiss=
ions
> > > would be a good fit for this purpose.
> > >
> > > Existing policy using the nlmsg_read and nlmsg_write permissions will
> > > continue to work as-is. Similar to ioctl xperms, netlink xperms allow
> > > for a more fine-grained policy where needed.
> > >
> > > Example policy on Android, preventing regular apps from accessing the
> > > device's MAC address and ARP table, but allowing this access to
> > > privileged apps, looks as follows:
> > >
> > > allow netdomain self:netlink_route_socket {
> > >         create read getattr write setattr lock append connect getopt
> > >         setopt shutdown nlmsg_read
> > > };
> > > allowxperm netdomain self:netlink_route_socket nlmsg ~{
> > >         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> >
> > Where are these defined? What are the valid values for userspace?
>
> These values need to be defined in sepolicy, similar to what is the
> case for ioctls. [2] has an example of such defines for Android.
>
> Kind regards,
> Bram
>
> [2] https://android-review.googlesource.com/c/platform/system/sepolicy/+/=
1786189/4/public/nlmsg_defines

This is how we currently handle individual ioctls on Android.

https://cs.android.com/android/platform/superproject/+/master:system/sepoli=
cy/public/ioctl_defines?q=3Dioctl_defines
>
> >
> > Thanks,
> > Jim
> >
> >
> > > };
> > > allowxperm priv_app self:netlink_route_socket nlmsg {
> > >         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> > > };
> > >
> > > Android currently uses code similar to [1] as a temporary workaround =
to
> > > limit access to certain netlink message types; our hope is that this =
patch
> > > will allow us to move back to upstream code with an approach that wor=
ks for
> > > everyone.
> > >
> > > [1] https://lore.kernel.org/selinux/CAHC9VhRSUhozBycHMZcMaJsibJDxNMsT=
sKVT2zOnW=3D5H4R4mdg@mail.gmail.com/
> > >
> > > Signed-off-by: Bram Bonne <brambonne@google.com>
> > > ---
> > >  checkpolicy/policy_define.c                | 124 +++++++++++------
> > >  checkpolicy/test/dismod.c                  |   2 +
> > >  libsepol/cil/src/cil.c                     |   2 +
> > >  libsepol/cil/src/cil_binary.c              | 154 ++++++++++++++++++-=
--
> > >  libsepol/cil/src/cil_build_ast.c           |   4 +-
> > >  libsepol/cil/src/cil_internal.h            |   2 +
> > >  libsepol/cil/src/cil_policy.c              |   2 +
> > >  libsepol/cil/src/cil_verify.c              |   3 +
> > >  libsepol/cil/src/cil_write_ast.c           |  16 ++-
> > >  libsepol/include/sepol/policydb/avtab.h    |   1 +
> > >  libsepol/include/sepol/policydb/policydb.h |   1 +
> > >  libsepol/src/assertion.c                   |  15 +-
> > >  libsepol/src/expand.c                      |   3 +
> > >  libsepol/src/kernel_to_cil.c               |  23 ++-
> > >  libsepol/src/module_to_cil.c               |  29 +++-
> > >  libsepol/src/optimize.c                    |   6 +
> > >  libsepol/src/util.c                        |  11 +-
> > >  17 files changed, 321 insertions(+), 77 deletions(-)
> > >
> > > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.=
c
> > > index d3eb6111..8ca22993 100644
> > > --- a/checkpolicy/policy_define.c
> > > +++ b/checkpolicy/policy_define.c
> > > @@ -1818,27 +1818,27 @@ avrule_t *define_cond_pol_list(avrule_t * avl=
ist, avrule_t * sl)
> > >         return sl;
> > >  }
> > >
> > > -typedef struct av_ioctl_range {
> > > +typedef struct av_xperm_range {
> > >         uint16_t low;
> > >         uint16_t high;
> > > -} av_ioctl_range_t;
> > > +} av_xperm_range_t;
> > >
> > > -struct av_ioctl_range_list {
> > > +struct av_xperm_range_list {
> > >         uint8_t omit;
> > > -       av_ioctl_range_t range;
> > > -       struct av_ioctl_range_list *next;
> > > +       av_xperm_range_t range;
> > > +       struct av_xperm_range_list *next;
> > >  };
> > >
> > > -static int avrule_sort_ioctls(struct av_ioctl_range_list **rangehead=
)
> > > +static int avrule_sort_xperms(struct av_xperm_range_list **rangehead=
)
> > >  {
> > > -       struct av_ioctl_range_list *r, *r2, *sorted, *sortedhead =3D =
NULL;
> > > +       struct av_xperm_range_list *r, *r2, *sorted, *sortedhead =3D =
NULL;
> > >
> > >         /* order list by range.low */
> > >         for (r =3D *rangehead; r !=3D NULL; r =3D r->next) {
> > > -               sorted =3D malloc(sizeof(struct av_ioctl_range_list))=
;
> > > +               sorted =3D malloc(sizeof(struct av_xperm_range_list))=
;
> > >                 if (sorted =3D=3D NULL)
> > >                         goto error;
> > > -               memcpy(sorted, r, sizeof(struct av_ioctl_range_list))=
;
> > > +               memcpy(sorted, r, sizeof(struct av_xperm_range_list))=
;
> > >                 sorted->next =3D NULL;
> > >                 if (sortedhead =3D=3D NULL) {
> > >                         sortedhead =3D sorted;
> > > @@ -1877,9 +1877,9 @@ error:
> > >         return -1;
> > >  }
> > >
> > > -static int avrule_merge_ioctls(struct av_ioctl_range_list **rangehea=
d)
> > > +static int avrule_merge_xperms(struct av_xperm_range_list **rangehea=
d)
> > >  {
> > > -       struct av_ioctl_range_list *r, *tmp;
> > > +       struct av_xperm_range_list *r, *tmp;
> > >         r =3D *rangehead;
> > >         while (r !=3D NULL && r->next !=3D NULL) {
> > >                 /* merge */
> > > @@ -1897,15 +1897,15 @@ static int avrule_merge_ioctls(struct av_ioct=
l_range_list **rangehead)
> > >         return 0;
> > >  }
> > >
> > > -static int avrule_read_ioctls(struct av_ioctl_range_list **rangehead=
)
> > > +static int avrule_read_xperm_ranges(struct av_xperm_range_list **ran=
gehead)
> > >  {
> > >         char *id;
> > > -       struct av_ioctl_range_list *rnew, *r =3D NULL;
> > > +       struct av_xperm_range_list *rnew, *r =3D NULL;
> > >         uint8_t omit =3D 0;
> > >
> > >         *rangehead =3D NULL;
> > >
> > > -       /* read in all the ioctl commands */
> > > +       /* read in all the netlink ranges / ioctl commands */
> > >         while ((id =3D queue_remove(id_queue))) {
> > >                 if (strcmp(id,"~") =3D=3D 0) {
> > >                         /* these are values to be omitted */
> > > @@ -1917,13 +1917,13 @@ static int avrule_read_ioctls(struct av_ioctl=
_range_list **rangehead)
> > >                         id =3D queue_remove(id_queue);
> > >                         r->range.high =3D (uint16_t) strtoul(id,NULL,=
0);
> > >                         if (r->range.high < r->range.low) {
> > > -                               yyerror("Ioctl ranges must be in asce=
nding order.");
> > > +                               yyerror("xperm ranges must be in asce=
nding order.");
> > >                                 return -1;
> > >                         }
> > >                         free(id);
> > >                 } else {
> > >                         /* read in new low value */
> > > -                       rnew =3D malloc(sizeof(struct av_ioctl_range_=
list));
> > > +                       rnew =3D malloc(sizeof(struct av_xperm_range_=
list));
> > >                         if (rnew =3D=3D NULL)
> > >                                 goto error;
> > >                         rnew->next =3D NULL;
> > > @@ -1950,11 +1950,11 @@ error:
> > >  }
> > >
> > >  /* flip to included ranges */
> > > -static int avrule_omit_ioctls(struct av_ioctl_range_list **rangehead=
)
> > > +static int avrule_omit_xperms(struct av_xperm_range_list **rangehead=
)
> > >  {
> > > -       struct av_ioctl_range_list *rnew, *r, *newhead, *r2;
> > > +       struct av_xperm_range_list *rnew, *r, *newhead, *r2;
> > >
> > > -       rnew =3D calloc(1, sizeof(struct av_ioctl_range_list));
> > > +       rnew =3D calloc(1, sizeof(struct av_xperm_range_list));
> > >         if (!rnew)
> > >                 goto error;
> > >
> > > @@ -1972,7 +1972,7 @@ static int avrule_omit_ioctls(struct av_ioctl_r=
ange_list **rangehead)
> > >
> > >         while (r) {
> > >                 r2->range.high =3D r->range.low - 1;
> > > -               rnew =3D calloc(1, sizeof(struct av_ioctl_range_list)=
);
> > > +               rnew =3D calloc(1, sizeof(struct av_xperm_range_list)=
);
> > >                 if (!rnew)
> > >                         goto error;
> > >                 r2->next =3D rnew;
> > > @@ -1998,27 +1998,27 @@ error:
> > >         return -1;
> > >  }
> > >
> > > -static int avrule_ioctl_ranges(struct av_ioctl_range_list **rangelis=
t)
> > > +static int avrule_xperm_ranges(struct av_xperm_range_list **rangelis=
t)
> > >  {
> > > -       struct av_ioctl_range_list *rangehead;
> > > +       struct av_xperm_range_list *rangehead;
> > >         uint8_t omit;
> > >
> > >         /* read in ranges to include and omit */
> > > -       if (avrule_read_ioctls(&rangehead))
> > > +       if (avrule_read_xperm_ranges(&rangehead))
> > >                 return -1;
> > >         if (rangehead =3D=3D NULL) {
> > > -               yyerror("error processing ioctl commands");
> > > +               yyerror("error processing ioctl/netlink commands");
> > >                 return -1;
> > >         }
> > >         omit =3D rangehead->omit;
> > > -       /* sort and merge the input ioctls */
> > > -       if (avrule_sort_ioctls(&rangehead))
> > > +       /* sort and merge the input ranges */
> > > +       if (avrule_sort_xperms(&rangehead))
> > >                 return -1;
> > > -       if (avrule_merge_ioctls(&rangehead))
> > > +       if (avrule_merge_xperms(&rangehead))
> > >                 return -1;
> > >         /* flip ranges if these are omitted */
> > >         if (omit) {
> > > -               if (avrule_omit_ioctls(&rangehead))
> > > +               if (avrule_omit_xperms(&rangehead))
> > >                         return -1;
> > >         }
> > >
> > > @@ -2189,11 +2189,11 @@ static int avrule_xperms_used(const av_extend=
ed_perms_t *xperms)
> > >  #define IOC_DRIV(x) ((x) >> 8)
> > >  #define IOC_FUNC(x) ((x) & 0xff)
> > >  #define IOC_CMD(driver, func) (((driver) << 8) + (func))
> > > -static int avrule_ioctl_partialdriver(struct av_ioctl_range_list *ra=
ngelist,
> > > +static int avrule_ioctl_partialdriver(struct av_xperm_range_list *ra=
ngelist,
> > >                                 av_extended_perms_t *complete_driver,
> > >                                 av_extended_perms_t **extended_perms)
> > >  {
> > > -       struct av_ioctl_range_list *r;
> > > +       struct av_xperm_range_list *r;
> > >         av_extended_perms_t *xperms;
> > >         uint8_t low, high;
> > >
> > > @@ -2228,10 +2228,10 @@ static int avrule_ioctl_partialdriver(struct =
av_ioctl_range_list *rangelist,
> > >
> > >  }
> > >
> > > -static int avrule_ioctl_completedriver(struct av_ioctl_range_list *r=
angelist,
> > > +static int avrule_ioctl_completedriver(struct av_xperm_range_list *r=
angelist,
> > >                         av_extended_perms_t **extended_perms)
> > >  {
> > > -       struct av_ioctl_range_list *r;
> > > +       struct av_xperm_range_list *r;
> > >         av_extended_perms_t *xperms;
> > >         uint16_t low, high;
> > >         xperms =3D calloc(1, sizeof(av_extended_perms_t));
> > > @@ -2270,10 +2270,10 @@ static int avrule_ioctl_completedriver(struct=
 av_ioctl_range_list *rangelist,
> > >         return 0;
> > >  }
> > >
> > > -static int avrule_ioctl_func(struct av_ioctl_range_list *rangelist,
> > > +static int avrule_xperms_single_driver(struct av_xperm_range_list *r=
angelist,
> > >                 av_extended_perms_t **extended_perms, unsigned int dr=
iver)
> > >  {
> > > -       struct av_ioctl_range_list *r;
> > > +       struct av_xperm_range_list *r;
> > >         av_extended_perms_t *xperms;
> > >         uint16_t low, high;
> > >
> > > @@ -2307,7 +2307,6 @@ static int avrule_ioctl_func(struct av_ioctl_ra=
nge_list *rangelist,
> > >                 high =3D IOC_FUNC(high);
> > >                 avrule_xperm_setrangebits(low, high, xperms);
> > >                 xperms->driver =3D driver;
> > > -               xperms->specified =3D AVRULE_XPERMS_IOCTLFUNCTION;
> > >                 r =3D r->next;
> > >         }
> > >
> > > @@ -2320,6 +2319,18 @@ static int avrule_ioctl_func(struct av_ioctl_r=
ange_list *rangelist,
> > >         return 0;
> > >  }
> > >
> > > +void avrule_ioctl_freeranges(struct av_xperm_range_list *rangelist)
> > > +{
> > > +       struct av_xperm_range_list *r, *tmp;
> > > +
> > > +       r =3D rangelist;
> > > +       while (r) {
> > > +               tmp =3D r;
> > > +               r =3D r->next;
> > > +               free(tmp);
> > > +       }
> > > +}
> > > +
> > >  static unsigned int xperms_for_each_bit(unsigned int *bit, av_extend=
ed_perms_t *xperms)
> > >  {
> > >         unsigned int i;
> > > @@ -2384,13 +2395,13 @@ static int avrule_cpy(avrule_t *dest, const a=
vrule_t *src)
> > >  static int define_te_avtab_ioctl(const avrule_t *avrule_template)
> > >  {
> > >         avrule_t *avrule;
> > > -       struct av_ioctl_range_list *rangelist, *r;
> > > +       struct av_xperm_range_list *rangelist, *r;
> > >         av_extended_perms_t *complete_driver, *partial_driver, *xperm=
s;
> > >         unsigned int i;
> > >
> > >
> > >         /* organize ioctl ranges */
> > > -       if (avrule_ioctl_ranges(&rangelist))
> > > +       if (avrule_xperm_ranges(&rangelist))
> > >                 return -1;
> > >
> > >         /* create rule for ioctl driver types that are entirely enabl=
ed */
> > > @@ -2422,10 +2433,11 @@ static int define_te_avtab_ioctl(const avrule=
_t *avrule_template)
> > >          */
> > >         i =3D 0;
> > >         while (xperms_for_each_bit(&i, partial_driver)) {
> > > -               if (avrule_ioctl_func(rangelist, &xperms, i))
> > > +               if (avrule_xperms_single_driver(rangelist, &xperms, i=
))
> > >                         return -1;
> > >
> > >                 if (xperms) {
> > > +                       xperms->specified =3D AVRULE_XPERMS_IOCTLFUNC=
TION;
> > >                         avrule =3D (avrule_t *) calloc(1, sizeof(avru=
le_t));
> > >                         if (!avrule) {
> > >                                 yyerror("out of memory");
> > > @@ -2451,6 +2463,38 @@ done:
> > >         return 0;
> > >  }
> > >
> > > +int define_te_avtab_netlink(avrule_t *avrule_template)
> > > +{
> > > +       avrule_t *avrule;
> > > +       struct av_xperm_range_list *range_list;
> > > +       av_extended_perms_t *xperms =3D NULL;
> > > +
> > > +       /* organize message ranges */
> > > +       if (avrule_xperm_ranges(&range_list))
> > > +               return -1;
> > > +
> > > +       /* Netlink message types comfortably fit into a single driver
> > > +        * (see RTM_MAX in uapi/linux/rtnetlink.h)
> > > +        */
> > > +       avrule_xperms_single_driver(range_list, &xperms, 0);
> > > +
> > > +       if (xperms && avrule_xperms_used(xperms)) {
> > > +               xperms->specified =3D AVRULE_XPERMS_NLMSG;
> > > +               avrule =3D (avrule_t *) calloc(1, sizeof(avrule_t));
> > > +               if (!avrule) {
> > > +                       yyerror("out of memory");
> > > +                       return -1;
> > > +               }
> > > +               if (avrule_cpy(avrule, avrule_template))
> > > +                       return -1;
> > > +               avrule->xperms =3D xperms;
> > > +               append_avrule(avrule);
> > > +       } else {
> > > +               free(xperms);
> > > +       }
> > > +       return 0;
> > > +}
> > > +
> > >  int define_te_avtab_extended_perms(int which)
> > >  {
> > >         char *id;
> > > @@ -2473,8 +2517,10 @@ int define_te_avtab_extended_perms(int which)
> > >         id =3D queue_remove(id_queue);
> > >         if (strcmp(id,"ioctl") =3D=3D 0) {
> > >                 rc =3D define_te_avtab_ioctl(avrule_template);
> > > +       } else if (strcmp(id, "nlmsg") =3D=3D 0) {
> > > +               rc =3D define_te_avtab_netlink(avrule_template);
> > >         } else {
> > > -               yyerror("only ioctl extended permissions are supporte=
d");
> > > +               yyerror("only ioctl / nlmsg extended permissions are =
supported");
> > >                 rc =3D -1;
> > >         }
> > >
> > > diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> > > index ec2a3e9a..f8652ec5 100644
> > > --- a/checkpolicy/test/dismod.c
> > > +++ b/checkpolicy/test/dismod.c
> > > @@ -296,6 +296,8 @@ static int display_avrule(avrule_t * avrule, poli=
cydb_t * policy,
> > >                         xperms.specified =3D AVTAB_XPERMS_IOCTLFUNCTI=
ON;
> > >                 else if (avrule->xperms->specified =3D=3D AVRULE_XPER=
MS_IOCTLDRIVER)
> > >                         xperms.specified =3D AVTAB_XPERMS_IOCTLDRIVER=
;
> > > +               else if (avrule->xperms->specified =3D=3D AVRULE_XPER=
MS_NLMSG)
> > > +                       xperms.specified =3D AVTAB_XPERMS_NLMSG;
> > >                 else {
> > >                         fprintf(fp, "     ERROR: no valid xperms spec=
ified\n");
> > >                         return -1;
> > > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > > index 4cc7f87f..fbdb005a 100644
> > > --- a/libsepol/cil/src/cil.c
> > > +++ b/libsepol/cil/src/cil.c
> > > @@ -219,6 +219,7 @@ char *CIL_KEY_DONTAUDITX;
> > >  char *CIL_KEY_NEVERALLOWX;
> > >  char *CIL_KEY_PERMISSIONX;
> > >  char *CIL_KEY_IOCTL;
> > > +char *CIL_KEY_NLMSG;
> > >  char *CIL_KEY_UNORDERED;
> > >  char *CIL_KEY_SRC_INFO;
> > >  char *CIL_KEY_SRC_CIL;
> > > @@ -388,6 +389,7 @@ static void cil_init_keys(void)
> > >         CIL_KEY_NEVERALLOWX =3D cil_strpool_add("neverallowx");
> > >         CIL_KEY_PERMISSIONX =3D cil_strpool_add("permissionx");
> > >         CIL_KEY_IOCTL =3D cil_strpool_add("ioctl");
> > > +       CIL_KEY_NLMSG =3D cil_strpool_add("nlmsg");
> > >         CIL_KEY_UNORDERED =3D cil_strpool_add("unordered");
> > >         CIL_KEY_SRC_INFO =3D cil_strpool_add("<src_info>");
> > >         CIL_KEY_SRC_CIL =3D cil_strpool_add("cil");
> > > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_bin=
ary.c
> > > index d8aa495a..f9938d66 100644
> > > --- a/libsepol/cil/src/cil_binary.c
> > > +++ b/libsepol/cil/src/cil_binary.c
> > > @@ -66,6 +66,7 @@ struct cil_args_binary {
> > >         int pass;
> > >         hashtab_t role_trans_table;
> > >         hashtab_t avrulex_ioctl_table;
> > > +       hashtab_t avrulex_nlmsg_table;
> > >         void **type_value_to_cil;
> > >  };
> > >
> > > @@ -1553,7 +1554,7 @@ void __avrule_xperm_setrangebits(uint16_t low, =
uint16_t high, struct avtab_exten
> > >  #define IOC_DRIV(x) (x >> 8)
> > >  #define IOC_FUNC(x) (x & 0xff)
> > >
> > > -int __cil_permx_bitmap_to_sepol_xperms_list(ebitmap_t *xperms, struc=
t cil_list **xperms_list)
> > > +int __cil_permx_ioctl_bitmap_to_sepol_xperms_list(ebitmap_t *xperms,=
 struct cil_list **xperms_list)
> > >  {
> > >         ebitmap_node_t *node;
> > >         unsigned int i;
> > > @@ -1618,13 +1619,53 @@ int __cil_permx_bitmap_to_sepol_xperms_list(e=
bitmap_t *xperms, struct cil_list *
> > >         return SEPOL_OK;
> > >  }
> > >
> > > -int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t=
 datum, void *args)
> > > +int __cil_permx_nlmsg_bitmap_to_sepol_xperms_list(ebitmap_t *xperms,=
 struct cil_list **xperms_list)
> > > +{
> > > +       ebitmap_node_t *node;
> > > +       uint16_t i;
> > > +       uint16_t low;
> > > +       struct avtab_extended_perms *avtab =3D NULL;
> > > +       int start_new_range =3D 1;
> > > +
> > > +       cil_list_init(xperms_list, CIL_NONE);
> > > +
> > > +       ebitmap_for_each_positive_bit(xperms, node, i) {
> > > +               if (start_new_range) {
> > > +                       low =3D i;
> > > +                       start_new_range =3D 0;
> > > +               }
> > > +
> > > +               // Continue if the current bit isn't the end of the d=
river range
> > > +               // or the next bit is set
> > > +               if (ebitmap_get_bit(xperms, i + 1)) {
> > > +                       continue;
> > > +               }
> > > +
> > > +               start_new_range =3D 1;
> > > +
> > > +               if (!avtab) {
> > > +                       avtab =3D cil_calloc(1, sizeof(*avtab));
> > > +                       // Netlink message types all fit in driver 0
> > > +                       avtab->driver =3D 0;
> > > +                       avtab->specified =3D AVTAB_XPERMS_NLMSG;
> > > +               }
> > > +
> > > +               __avrule_xperm_setrangebits(low, i, avtab);
> > > +       }
> > > +
> > > +       if (avtab) {
> > > +               cil_list_append(*xperms_list, CIL_NONE, avtab);
> > > +       }
> > > +
> > > +       return SEPOL_OK;
> > > +}
> > > +
> > > +int __cil_avrulex_to_policydb(hashtab_key_t k, struct cil_list* xper=
ms_list, char* cil_key, void *args)
> > >  {
> > >         int rc =3D SEPOL_OK;
> > >         struct policydb *pdb;
> > >         avtab_key_t *avtab_key;
> > >         avtab_datum_t avtab_datum;
> > > -       struct cil_list *xperms_list =3D NULL;
> > >         struct cil_list_item *item;
> > >         class_datum_t *sepol_obj;
> > >         uint32_t data =3D 0;
> > > @@ -1637,17 +1678,12 @@ int __cil_avrulex_ioctl_to_policydb(hashtab_k=
ey_t k, hashtab_datum_t datum, void
> > >         // setting the data for an extended avtab isn't really necess=
ary because
> > >         // it is ignored by the kernel. However, neverallow checking =
requires that
> > >         // the data value be set, so set it for that to work.
> > > -       rc =3D __perm_str_to_datum(CIL_KEY_IOCTL, sepol_obj, &data);
> > > +       rc =3D __perm_str_to_datum(cil_key, sepol_obj, &data);
> > >         if (rc !=3D SEPOL_OK) {
> > >                 goto exit;
> > >         }
> > >         avtab_datum.data =3D data;
> > >
> > > -       rc =3D __cil_permx_bitmap_to_sepol_xperms_list(datum, &xperms=
_list);
> > > -       if (rc !=3D SEPOL_OK) {
> > > -               goto exit;
> > > -       }
> > > -
> > >         cil_list_for_each(item, xperms_list) {
> > >                 avtab_datum.xperms =3D item->data;
> > >                 rc =3D avtab_insert(&pdb->te_avtab, avtab_key, &avtab=
_datum);
> > > @@ -1659,16 +1695,57 @@ int __cil_avrulex_ioctl_to_policydb(hashtab_k=
ey_t k, hashtab_datum_t datum, void
> > >         rc =3D SEPOL_OK;
> > >
> > >  exit:
> > > +       return rc;
> > > +}
> > > +
> > > +void __cil_cleanup_xperms(struct cil_list *xperms_list)
> > > +{
> > > +       struct cil_list_item *item;
> > > +
> > >         if (xperms_list !=3D NULL) {
> > >                 cil_list_for_each(item, xperms_list) {
> > >                         free(item->data);
> > > +                       item->data =3D NULL;
> > >                 }
> > >                 cil_list_destroy(&xperms_list, CIL_FALSE);
> > >         }
> > > +}
> > > +
> > > +int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t=
 datum, void *args)
> > > +{
> > > +       struct cil_list *xperms_list =3D NULL;
> > > +       int rc;
> > > +
> > > +       rc =3D __cil_permx_ioctl_bitmap_to_sepol_xperms_list(datum, &=
xperms_list);
> > > +       if (rc !=3D SEPOL_OK) {
> > > +               goto exit;
> > > +       }
> > > +       rc =3D __cil_avrulex_to_policydb(k, xperms_list, CIL_KEY_IOCT=
L, args);
> > > +
> > > +exit:
> > > +       __cil_cleanup_xperms(xperms_list);
> > > +
> > >         return rc;
> > >  }
> > >
> > > -int __cil_avrulex_ioctl_to_hashtable(hashtab_t h, uint16_t kind, uin=
t32_t src, uint32_t tgt, uint32_t obj, ebitmap_t *xperms)
> > > +int __cil_avrulex_nlmsg_to_policydb(hashtab_key_t k, hashtab_datum_t=
 datum, void *args)
> > > +{
> > > +       struct cil_list *xperms_list =3D NULL;
> > > +       int rc;
> > > +
> > > +       rc =3D __cil_permx_nlmsg_bitmap_to_sepol_xperms_list(datum, &=
xperms_list);
> > > +       if (rc !=3D SEPOL_OK) {
> > > +               goto exit;
> > > +       }
> > > +       rc =3D __cil_avrulex_to_policydb(k, xperms_list, CIL_KEY_NLMS=
G, args);
> > > +
> > > +exit:
> > > +       __cil_cleanup_xperms(xperms_list);
> > > +
> > > +       return rc;
> > > +}
> > > +
> > > +int __cil_avrulex_to_hashtable(hashtab_t h, uint16_t kind, uint32_t =
src, uint32_t tgt, uint32_t obj, ebitmap_t *xperms)
> > >  {
> > >         uint16_t specified;
> > >         avtab_key_t *avtab_key;
> > > @@ -1747,8 +1824,12 @@ int __cil_avrulex_to_hashtable_helper(policydb=
_t *pdb, uint16_t kind, struct cil
> > >                 if (rc !=3D SEPOL_OK) goto exit;
> > >
> > >                 switch (permx->kind) {
> > > -               case  CIL_PERMX_KIND_IOCTL:
> > > -                       rc =3D __cil_avrulex_ioctl_to_hashtable(args-=
>avrulex_ioctl_table, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_o=
bj->s.value, permx->perms);
> > > +               case CIL_PERMX_KIND_IOCTL:
> > > +                       rc =3D __cil_avrulex_to_hashtable(args->avrul=
ex_ioctl_table, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->s.=
value, permx->perms);
> > > +                       if (rc !=3D SEPOL_OK) goto exit;
> > > +                       break;
> > > +               case CIL_PERMX_KIND_NLMSG:
> > > +                       rc =3D __cil_avrulex_to_hashtable(args->avrul=
ex_nlmsg_table, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->s.=
value, permx->perms);
> > >                         if (rc !=3D SEPOL_OK) goto exit;
> > >                         break;
> > >                 default:
> > > @@ -4417,6 +4498,9 @@ static int __cil_permx_to_sepol_class_perms(pol=
icydb_t *pdb, struct cil_permissi
> > >                         case CIL_PERMX_KIND_IOCTL:
> > >                                 perm_str =3D CIL_KEY_IOCTL;
> > >                                 break;
> > > +                       case CIL_PERMX_KIND_NLMSG:
> > > +                               perm_str =3D CIL_KEY_NLMSG;
> > > +                               break;
> > >                         default:
> > >                                 rc =3D SEPOL_ERR;
> > >                                 goto exit;
> > > @@ -4563,6 +4647,9 @@ static void __cil_print_permissionx(struct cil_=
permissionx *px)
> > >                 case CIL_PERMX_KIND_IOCTL:
> > >                         kind_str =3D CIL_KEY_IOCTL;
> > >                         break;
> > > +               case CIL_PERMX_KIND_NLMSG:
> > > +                       kind_str =3D CIL_KEY_NLMSG;
> > > +                       break;
> > >                 default:
> > >                         kind_str =3D "unknown";
> > >                         break;
> > > @@ -4696,8 +4783,21 @@ static int cil_check_neverallow(const struct c=
il_db *db, policydb_t *pdb, struct
> > >                         goto exit;
> > >                 }
> > >
> > > -               rc =3D __cil_permx_bitmap_to_sepol_xperms_list(cil_ru=
le->perms.x.permx->perms, &xperms);
> > > -               if (rc !=3D SEPOL_OK) {
> > > +               switch (cil_rule->perms.x.permx->kind) {
> > > +               case CIL_PERMX_KIND_IOCTL:
> > > +                       rc =3D __cil_permx_ioctl_bitmap_to_sepol_xper=
ms_list(cil_rule->perms.x.permx->perms, &xperms);
> > > +                       if (rc !=3D SEPOL_OK) {
> > > +                               goto exit;
> > > +                       }
> > > +                       break;
> > > +               case CIL_PERMX_KIND_NLMSG:
> > > +                       rc =3D __cil_permx_nlmsg_bitmap_to_sepol_xper=
ms_list(cil_rule->perms.x.permx->perms, &xperms);
> > > +                       if (rc !=3D SEPOL_OK) {
> > > +                               goto exit;
> > > +                       }
> > > +                       break;
> > > +               default:
> > > +                       rc =3D SEPOL_ERR;
> > >                         goto exit;
> > >                 }
> > >
> > > @@ -4715,13 +4815,7 @@ static int cil_check_neverallow(const struct c=
il_db *db, policydb_t *pdb, struct
> > >         }
> > >
> > >  exit:
> > > -       if (xperms !=3D NULL) {
> > > -               cil_list_for_each(item, xperms) {
> > > -                       free(item->data);
> > > -                       item->data =3D NULL;
> > > -               }
> > > -               cil_list_destroy(&xperms, CIL_FALSE);
> > > -       }
> > > +       __cil_cleanup_xperms(xperms);
> > >
> > >         rule->xperms =3D NULL;
> > >         __cil_destroy_sepol_avrules(rule);
> > > @@ -4904,6 +4998,7 @@ int cil_binary_create_allocated_pdb(const struc=
t cil_db *db, sepol_policydb_t *p
> > >         struct cil_list *neverallows =3D NULL;
> > >         hashtab_t role_trans_table =3D NULL;
> > >         hashtab_t avrulex_ioctl_table =3D NULL;
> > > +       hashtab_t avrulex_nlmsg_table =3D NULL;
> > >         void **type_value_to_cil =3D NULL;
> > >         struct cil_class **class_value_to_cil =3D NULL;
> > >         struct cil_perm ***perm_value_to_cil =3D NULL;
> > > @@ -4947,7 +5042,13 @@ int cil_binary_create_allocated_pdb(const stru=
ct cil_db *db, sepol_policydb_t *p
> > >
> > >         avrulex_ioctl_table =3D hashtab_create(avrulex_hash, avrulex_=
compare, AVRULEX_TABLE_SIZE);
> > >         if (!avrulex_ioctl_table) {
> > > -               cil_log(CIL_INFO, "Failure to create hashtab for avru=
lex\n");
> > > +               cil_log(CIL_INFO, "Failure to create hashtab for ioct=
l\n");
> > > +               goto exit;
> > > +       }
> > > +
> > > +       avrulex_nlmsg_table =3D hashtab_create(avrulex_hash, avrulex_=
compare, AVRULEX_TABLE_SIZE);
> > > +       if (!avrulex_nlmsg_table) {
> > > +               cil_log(CIL_INFO, "Failure to create hashtab for nlms=
g\n");
> > >                 goto exit;
> > >         }
> > >
> > > @@ -4958,6 +5059,7 @@ int cil_binary_create_allocated_pdb(const struc=
t cil_db *db, sepol_policydb_t *p
> > >         extra_args.neverallows =3D neverallows;
> > >         extra_args.role_trans_table =3D role_trans_table;
> > >         extra_args.avrulex_ioctl_table =3D avrulex_ioctl_table;
> > > +       extra_args.avrulex_nlmsg_table =3D avrulex_nlmsg_table;
> > >         extra_args.type_value_to_cil =3D type_value_to_cil;
> > >
> > >         for (i =3D 1; i <=3D 3; i++) {
> > > @@ -4980,7 +5082,12 @@ int cil_binary_create_allocated_pdb(const stru=
ct cil_db *db, sepol_policydb_t *p
> > >                 if (i =3D=3D 3) {
> > >                         rc =3D hashtab_map(avrulex_ioctl_table, __cil=
_avrulex_ioctl_to_policydb, pdb);
> > >                         if (rc !=3D SEPOL_OK) {
> > > -                               cil_log(CIL_INFO, "Failure creating a=
vrulex rules\n");
> > > +                               cil_log(CIL_INFO, "Failure creating i=
octl avrulex rules\n");
> > > +                               goto exit;
> > > +                       }
> > > +                       rc =3D hashtab_map(avrulex_nlmsg_table, __cil=
_avrulex_nlmsg_to_policydb, pdb);
> > > +                       if (rc !=3D SEPOL_OK) {
> > > +                               cil_log(CIL_INFO, "Failure creating n=
lmsg avrulex rules\n");
> > >                                 goto exit;
> > >                         }
> > >                 }
> > > @@ -5056,6 +5163,7 @@ exit:
> > >         hashtab_destroy(role_trans_table);
> > >         hashtab_map(avrulex_ioctl_table, __cil_avrulex_ioctl_destroy,=
 NULL);
> > >         hashtab_destroy(avrulex_ioctl_table);
> > > +       hashtab_destroy(avrulex_nlmsg_table);
> > >         free(type_value_to_cil);
> > >         free(class_value_to_cil);
> > >         if (perm_value_to_cil !=3D NULL) {
> > > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_=
build_ast.c
> > > index 9c34be23..b1cfb4f0 100644
> > > --- a/libsepol/cil/src/cil_build_ast.c
> > > +++ b/libsepol/cil/src/cil_build_ast.c
> > > @@ -2159,8 +2159,10 @@ int cil_fill_permissionx(struct cil_tree_node =
*parse_current, struct cil_permiss
> > >
> > >         if (parse_current->data =3D=3D CIL_KEY_IOCTL) {
> > >                 permx->kind =3D CIL_PERMX_KIND_IOCTL;
> > > +       } else if (parse_current->data =3D=3D CIL_KEY_NLMSG) {
> > > +               permx->kind =3D CIL_PERMX_KIND_NLMSG;
> > >         } else {
> > > -               cil_log(CIL_ERR, "Unknown permissionx kind, %s. Must =
be \"ioctl\"\n", (char *)parse_current->data);
> > > +               cil_log(CIL_ERR, "Unknown permissionx kind, %s. Must =
be one of [%s, %s]\n", (char *)parse_current->data, CIL_KEY_IOCTL, CIL_KEY_=
NLMSG);
> > >                 rc =3D SEPOL_ERR;
> > >                 goto exit;
> > >         }
> > > diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_i=
nternal.h
> > > index 6f1d3cb5..c968cf1e 100644
> > > --- a/libsepol/cil/src/cil_internal.h
> > > +++ b/libsepol/cil/src/cil_internal.h
> > > @@ -236,6 +236,7 @@ extern char *CIL_KEY_DONTAUDITX;
> > >  extern char *CIL_KEY_NEVERALLOWX;
> > >  extern char *CIL_KEY_PERMISSIONX;
> > >  extern char *CIL_KEY_IOCTL;
> > > +extern char *CIL_KEY_NLMSG;
> > >  extern char *CIL_KEY_UNORDERED;
> > >  extern char *CIL_KEY_SRC_INFO;
> > >  extern char *CIL_KEY_SRC_CIL;
> > > @@ -623,6 +624,7 @@ struct cil_avrule {
> > >  };
> > >
> > >  #define CIL_PERMX_KIND_IOCTL 1
> > > +#define CIL_PERMX_KIND_NLMSG 2
> > >  struct cil_permissionx {
> > >         struct cil_symtab_datum datum;
> > >         uint32_t kind;
> > > diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_pol=
icy.c
> > > index 7c543c47..2703d764 100644
> > > --- a/libsepol/cil/src/cil_policy.c
> > > +++ b/libsepol/cil/src/cil_policy.c
> > > @@ -1112,6 +1112,8 @@ static void cil_xperms_to_policy(FILE *out, str=
uct cil_permissionx *permx)
> > >
> > >         if (permx->kind =3D=3D CIL_PERMX_KIND_IOCTL) {
> > >                 kind =3D "ioctl";
> > > +       } else if (permx->kind =3D=3D CIL_PERMX_KIND_NLMSG) {
> > > +               kind =3D CIL_KEY_NLMSG;
> > >         } else {
> > >                 kind =3D "???";
> > >         }
> > > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_ver=
ify.c
> > > index d994d717..67bdb0e9 100644
> > > --- a/libsepol/cil/src/cil_verify.c
> > > +++ b/libsepol/cil/src/cil_verify.c
> > > @@ -1427,6 +1427,9 @@ int __cil_verify_permissionx(struct cil_permiss=
ionx *permx, struct cil_tree_node
> > >                 case CIL_PERMX_KIND_IOCTL:
> > >                         kind_str =3D CIL_KEY_IOCTL;
> > >                         break;
> > > +               case CIL_PERMX_KIND_NLMSG:
> > > +                       kind_str =3D CIL_KEY_NLMSG;
> > > +                       break;
> > >                 default:
> > >                         cil_tree_log(node, CIL_ERR, "Invalid permissi=
onx kind (%d)", permx->kind);
> > >                         rc =3D SEPOL_ERR;
> > > diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_=
write_ast.c
> > > index d7f00bcc..b93a4fa1 100644
> > > --- a/libsepol/cil/src/cil_write_ast.c
> > > +++ b/libsepol/cil/src/cil_write_ast.c
> > > @@ -303,7 +303,13 @@ static void write_permx(FILE *out, struct cil_pe=
rmissionx *permx)
> > >                 fprintf(out, "%s", datum_to_str(DATUM(permx)));
> > >         } else {
> > >                 fprintf(out, "(");
> > > -               fprintf(out, "%s ", permx->kind =3D=3D CIL_PERMX_KIND=
_IOCTL ? "ioctl" : "<?KIND>");
> > > +               if (permx->kind =3D=3D CIL_PERMX_KIND_IOCTL) {
> > > +                       fprintf(out, "%s ", "ioctl");
> > > +               } else if (permx->kind =3D=3D CIL_PERMX_KIND_NLMSG) {
> > > +                       fprintf(out, "%s ", "nlmsg");
> > > +               } else {
> > > +                       fprintf(out, "%s ", "<?KIND>");
> > > +               }
> > >                 fprintf(out, "%s ", datum_or_str(DATUM(permx->obj), p=
ermx->obj_str));
> > >                 write_expr(out, permx->expr_str);
> > >                 fprintf(out, ")");
> > > @@ -812,7 +818,13 @@ void cil_write_ast_node(FILE *out, struct cil_tr=
ee_node *node)
> > >         case CIL_PERMISSIONX: {
> > >                 struct cil_permissionx *permx =3D node->data;
> > >                 fprintf(out, "(permissionx %s (", datum_to_str(DATUM(=
permx)));
> > > -               fprintf(out, "%s ", permx->kind =3D=3D CIL_PERMX_KIND=
_IOCTL ? "ioctl" : "<?KIND>");
> > > +               if (permx->kind =3D=3D CIL_PERMX_KIND_IOCTL) {
> > > +                       fprintf(out, "%s ", "ioctl");
> > > +               } else if (permx->kind =3D=3D CIL_PERMX_KIND_NLMSG) {
> > > +                       fprintf(out, "%s ", "nlmsg");
> > > +               } else {
> > > +                       fprintf(out, "%s ", "<?KIND>");
> > > +               }
> > >                 fprintf(out, "%s ", datum_or_str(DATUM(permx->obj), p=
ermx->obj_str));
> > >                 write_expr(out, permx->expr_str);
> > >                 fprintf(out, "))\n");
> > > diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/inclu=
de/sepol/policydb/avtab.h
> > > index 10ecde9a..aa7481d3 100644
> > > --- a/libsepol/include/sepol/policydb/avtab.h
> > > +++ b/libsepol/include/sepol/policydb/avtab.h
> > > @@ -74,6 +74,7 @@ typedef struct avtab_extended_perms {
> > >
> > >  #define AVTAB_XPERMS_IOCTLFUNCTION     0x01
> > >  #define AVTAB_XPERMS_IOCTLDRIVER       0x02
> > > +#define AVTAB_XPERMS_NLMSG             0x03
> > >         /* extension of the avtab_key specified */
> > >         uint8_t specified;
> > >         uint8_t driver;
> > > diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/in=
clude/sepol/policydb/policydb.h
> > > index 4bf9f05d..55918e1d 100644
> > > --- a/libsepol/include/sepol/policydb/policydb.h
> > > +++ b/libsepol/include/sepol/policydb/policydb.h
> > > @@ -259,6 +259,7 @@ typedef struct class_perm_node {
> > >  typedef struct av_extended_perms {
> > >  #define AVRULE_XPERMS_IOCTLFUNCTION    0x01
> > >  #define AVRULE_XPERMS_IOCTLDRIVER      0x02
> > > +#define AVRULE_XPERMS_NLMSG            0x03
> > >         uint8_t specified;
> > >         uint8_t driver;
> > >         /* 256 bits of permissions */
> > > diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> > > index dd2749a0..47e45713 100644
> > > --- a/libsepol/src/assertion.c
> > > +++ b/libsepol/src/assertion.c
> > > @@ -101,6 +101,9 @@ static int check_extended_permissions(av_extended=
_perms_t *neverallow, avtab_ext
> > >         } else if ((neverallow->specified =3D=3D AVRULE_XPERMS_IOCTLD=
RIVER)
> > >                         && (allow->specified =3D=3D AVTAB_XPERMS_IOCT=
LDRIVER)) {
> > >                 rc =3D extended_permissions_and(neverallow->perms, al=
low->perms);
> > > +       } else if ((neverallow->specified =3D=3D AVRULE_XPERMS_NLMSG)
> > > +                       && (allow->specified =3D=3D AVTAB_XPERMS_NLMS=
G)) {
> > > +               rc =3D extended_permissions_and(neverallow->perms, al=
low->perms);
> > >         }
> > >
> > >         return rc;
> > > @@ -133,6 +136,12 @@ static void extended_permissions_violated(avtab_=
extended_perms_t *result,
> > >                 result->specified =3D AVTAB_XPERMS_IOCTLDRIVER;
> > >                 for (i =3D 0; i < EXTENDED_PERMS_LEN; i++)
> > >                         result->perms[i] =3D neverallow->perms[i] & a=
llow->perms[i];
> > > +       } else if ((neverallow->specified =3D=3D AVRULE_XPERMS_NLMSG)
> > > +                       && (allow->specified =3D=3D AVTAB_XPERMS_NLMS=
G)) {
> > > +               result->specified =3D AVTAB_XPERMS_NLMSG;
> > > +               result->driver =3D 0;
> > > +               for (i =3D 0; i < EXTENDED_PERMS_LEN; i++)
> > > +                       result->perms[i] =3D neverallow->perms[i] & a=
llow->perms[i];
> > >         }
> > >  }
> > >
> > > @@ -166,7 +175,8 @@ static int report_assertion_extended_permissions(=
sepol_handle_t *handle,
> > >                              node =3D avtab_search_node_next(node, tm=
p_key.specified)) {
> > >                                 xperms =3D node->datum.xperms;
> > >                                 if ((xperms->specified !=3D AVTAB_XPE=
RMS_IOCTLFUNCTION)
> > > -                                               && (xperms->specified=
 !=3D AVTAB_XPERMS_IOCTLDRIVER))
> > > +                                               && (xperms->specified=
 !=3D AVTAB_XPERMS_IOCTLDRIVER)
> > > +                                               && (xperms->specified=
 !=3D AVTAB_XPERMS_NLMSG))
> > >                                         continue;
> > >
> > >                                 rc =3D check_extended_permissions(avr=
ule->xperms, xperms);
> > > @@ -346,7 +356,8 @@ static int check_assertion_extended_permissions_a=
vtab(avrule_t *avrule, avtab_t
> > >                                 xperms =3D node->datum.xperms;
> > >
> > >                                 if ((xperms->specified !=3D AVTAB_XPE=
RMS_IOCTLFUNCTION)
> > > -                                               && (xperms->specified=
 !=3D AVTAB_XPERMS_IOCTLDRIVER))
> > > +                                               && (xperms->specified=
 !=3D AVTAB_XPERMS_IOCTLDRIVER)
> > > +                                               && (xperms->specified=
 !=3D AVTAB_XPERMS_NLMSG))
> > >                                         continue;
> > >                                 rc =3D check_extended_permissions(nev=
erallow_xperms, xperms);
> > >                                 if (rc)
> > > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > > index a6a466f7..959e6eb2 100644
> > > --- a/libsepol/src/expand.c
> > > +++ b/libsepol/src/expand.c
> > > @@ -1796,6 +1796,9 @@ static int allocate_xperms(sepol_handle_t * han=
dle, avtab_datum_t * avdatump,
> > >         case AVRULE_XPERMS_IOCTLDRIVER:
> > >                 xperms->specified =3D AVTAB_XPERMS_IOCTLDRIVER;
> > >                 break;
> > > +       case AVRULE_XPERMS_NLMSG:
> > > +               xperms->specified =3D AVTAB_XPERMS_NLMSG;
> > > +               break;
> > >         default:
> > >                 return -1;
> > >         }
> > > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_ci=
l.c
> > > index 305567a5..090d4e43 100644
> > > --- a/libsepol/src/kernel_to_cil.c
> > > +++ b/libsepol/src/kernel_to_cil.c
> > > @@ -1617,7 +1617,8 @@ static char *xperms_to_str(avtab_extended_perms=
_t *xperms)
> > >         remaining =3D sizeof(xpermsbuf);
> > >
> > >         if ((xperms->specified !=3D AVTAB_XPERMS_IOCTLFUNCTION)
> > > -               && (xperms->specified !=3D AVTAB_XPERMS_IOCTLDRIVER))=
 {
> > > +               && (xperms->specified !=3D AVTAB_XPERMS_IOCTLDRIVER)
> > > +               && (xperms->specified !=3D AVTAB_XPERMS_NLMSG)) {
> > >                 return NULL;
> > >         }
> > >
> > > @@ -1637,7 +1638,8 @@ static char *xperms_to_str(avtab_extended_perms=
_t *xperms)
> > >                         continue;
> > >                 }
> > >
> > > -               if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
> > > +               if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION
> > > +                       || xperms->specified & AVTAB_XPERMS_NLMSG) {
> > >                         value =3D xperms->driver<<8 | bit;
> > >                         if (in_range) {
> > >                                 low_value =3D xperms->driver<<8 | low=
_bit;
> > > @@ -1679,7 +1681,7 @@ static char *avtab_node_to_str(struct policydb =
*pdb, avtab_key_t *key, avtab_dat
> > >  {
> > >         uint32_t data =3D datum->data;
> > >         type_datum_t *type;
> > > -       const char *flavor, *tgt;
> > > +       const char *flavor, *tgt, *func;
> > >         char *src, *class, *perms, *new;
> > >         char *rule =3D NULL;
> > >
> > > @@ -1742,8 +1744,21 @@ static char *avtab_node_to_str(struct policydb=
 *pdb, avtab_key_t *key, avtab_dat
> > >                         goto exit;
> > >                 }
> > >
> > > +               switch (datum->xperms->specified) {
> > > +               case AVRULE_XPERMS_IOCTLDRIVER:
> > > +               case AVRULE_XPERMS_IOCTLFUNCTION:
> > > +                       func =3D "ioctl";
> > > +                       break;
> > > +               case AVRULE_XPERMS_NLMSG:
> > > +                       func =3D "nlmsg";
> > > +                       break;
> > > +               default:
> > > +                       sepol_log_err("Unexpected xperm spec: %hhu", =
datum->xperms->specified);
> > > +                       goto exit;
> > > +               }
> > > +
> > >                 rule =3D create_str("(%s %s %s (%s %s (%s)))", 6,
> > > -                                 flavor, src, tgt, "ioctl", class, p=
erms);
> > > +                                 flavor, src, tgt, func, class, perm=
s);
> > >         } else {
> > >                 new =3D pdb->p_type_val_to_name[data - 1];
> > >
> > > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_ci=
l.c
> > > index 16e4004e..47d9b171 100644
> > > --- a/libsepol/src/module_to_cil.c
> > > +++ b/libsepol/src/module_to_cil.c
> > > @@ -627,14 +627,15 @@ exit:
> > >  static int xperms_to_cil(const av_extended_perms_t *xperms)
> > >  {
> > >         uint16_t value;
> > > -       uint16_t low_bit;
> > > +       uint16_t low_bit =3D 0;
> > >         uint16_t low_value;
> > >         unsigned int bit;
> > >         unsigned int in_range =3D 0;
> > >         int first =3D 1;
> > >
> > >         if ((xperms->specified !=3D AVTAB_XPERMS_IOCTLFUNCTION)
> > > -               && (xperms->specified !=3D AVTAB_XPERMS_IOCTLDRIVER))
> > > +               && (xperms->specified !=3D AVTAB_XPERMS_IOCTLDRIVER)
> > > +               && (xperms->specified !=3D AVTAB_XPERMS_NLMSG))
> > >                 return -1;
> > >
> > >         for (bit =3D 0; bit < sizeof(xperms->perms)*8; bit++) {
> > > @@ -674,6 +675,13 @@ static int xperms_to_cil(const av_extended_perms=
_t *xperms)
> > >                         } else {
> > >                                 cil_printf("(range 0x%hx 0x%hx)", val=
ue, (uint16_t) (value|0xff));
> > >                         }
> > > +               } else if (xperms->specified & AVTAB_XPERMS_NLMSG) {
> > > +                       if (in_range) {
> > > +                               cil_printf("(range 0x%hx 0x%hx)", low=
_bit, (uint16_t) bit);
> > > +                               in_range =3D 0;
> > > +                       } else {
> > > +                               cil_printf("0x%hx", (uint16_t) bit);
> > > +                       }
> > >                 }
> > >         }
> > >
> > > @@ -683,7 +691,7 @@ static int xperms_to_cil(const av_extended_perms_=
t *xperms)
> > >  static int avrulex_to_cil(int indent, struct policydb *pdb, uint32_t=
 type, const char *src, const char *tgt, const class_perm_node_t *classperm=
s, const av_extended_perms_t *xperms)
> > >  {
> > >         int rc =3D -1;
> > > -       const char *rule;
> > > +       const char *rule, *func;
> > >         const struct class_perm_node *classperm;
> > >
> > >         switch (type) {
> > > @@ -705,10 +713,23 @@ static int avrulex_to_cil(int indent, struct po=
licydb *pdb, uint32_t type, const
> > >                 goto exit;
> > >         }
> > >
> > > +       switch (xperms->specified) {
> > > +       case AVRULE_XPERMS_IOCTLDRIVER:
> > > +       case AVRULE_XPERMS_IOCTLFUNCTION:
> > > +               func =3D "ioctl";
> > > +               break;
> > > +       case AVRULE_XPERMS_NLMSG:
> > > +               func =3D "nlmsg";
> > > +               break;
> > > +       default:
> > > +               log_err("Unexpected xperm spec for %s, %s, %s: %hhu",=
 rule, src, tgt, xperms->specified);
> > > +               goto exit;
> > > +       }
> > > +
> > >         for (classperm =3D classperms; classperm !=3D NULL; classperm=
 =3D classperm->next) {
> > >                 cil_indent(indent);
> > >                 cil_printf("(%s %s %s (%s %s (", rule, src, tgt,
> > > -                          "ioctl", pdb->p_class_val_to_name[classper=
m->tclass - 1]);
> > > +                          func, pdb->p_class_val_to_name[classperm->=
tclass - 1]);
> > >                 xperms_to_cil(xperms);
> > >                 cil_printf(")))\n");
> > >         }
> > > diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> > > index 6826155c..f23cfd17 100644
> > > --- a/libsepol/src/optimize.c
> > > +++ b/libsepol/src/optimize.c
> > > @@ -180,6 +180,12 @@ static int process_avtab_datum(uint16_t specifie=
d,
> > >
> > >                         if (x2->specified =3D=3D AVTAB_XPERMS_IOCTLDR=
IVER)
> > >                                 return process_xperms(x1->perms, x2->=
perms);
> > > +               } else if (x1->specified =3D=3D AVTAB_XPERMS_NLMSG) {
> > > +                       if (x2->specified =3D=3D AVTAB_XPERMS_NLMSG) =
{
> > > +                               if (x1->driver !=3D x2->driver)
> > > +                                       return 0;
> > > +                               return process_xperms(x1->perms, x2->=
perms);
> > > +                       }
> > >                 }
> > >                 return 0;
> > >         }
> > > diff --git a/libsepol/src/util.c b/libsepol/src/util.c
> > > index 902c63c5..b5b41f87 100644
> > > --- a/libsepol/src/util.c
> > > +++ b/libsepol/src/util.c
> > > @@ -124,7 +124,7 @@ char *sepol_av_to_string(policydb_t * policydbp, =
uint32_t tclass,
> > >  char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
> > >  {
> > >         uint16_t value;
> > > -       uint16_t low_bit;
> > > +       uint16_t low_bit =3D 0;
> > >         uint16_t low_value;
> > >         unsigned int bit;
> > >         unsigned int in_range =3D 0;
> > > @@ -135,7 +135,8 @@ char *sepol_extended_perms_to_string(avtab_extend=
ed_perms_t *xperms)
> > >         p =3D xpermsbuf;
> > >
> > >         if ((xperms->specified !=3D AVTAB_XPERMS_IOCTLFUNCTION)
> > > -               && (xperms->specified !=3D AVTAB_XPERMS_IOCTLDRIVER))
> > > +               && (xperms->specified !=3D AVTAB_XPERMS_IOCTLDRIVER)
> > > +               && (xperms->specified !=3D AVTAB_XPERMS_NLMSG))
> > >                 return NULL;
> > >
> > >         len =3D snprintf(p, sizeof(xpermsbuf) - xpermslen, "ioctl { "=
);
> > > @@ -173,6 +174,12 @@ char *sepol_extended_perms_to_string(avtab_exten=
ded_perms_t *xperms)
> > >                                 len =3D snprintf(p, sizeof(xpermsbuf)=
 - xpermslen, "0x%hx-0x%hx ", value, (uint16_t) (value|0xff));
> > >                         }
> > >
> > > +               } else if (xperms->specified & AVTAB_XPERMS_NLMSG) {
> > > +                       if (in_range) {
> > > +                               len =3D snprintf(p, sizeof(xpermsbuf)=
 - xpermslen, "0x%hx-0x%hx ", low_bit, (uint16_t) bit);
> > > +                       } else {
> > > +                               len =3D snprintf(p, sizeof(xpermsbuf)=
 - xpermslen, "0x%hx ", (uint16_t) bit);
> > > +                       }
> > >                 }
> > >
> > >                 if (len < 0 || (size_t) len >=3D (sizeof(xpermsbuf) -=
 xpermslen))
> > > --
> > > 2.34.0.rc0.344.g81b53c2807-goog
> > >
