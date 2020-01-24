Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD11C2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 19:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3BA20709
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 19:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aUKY0OXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbgAXTI5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:08:57 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40367 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387966AbgAXTI5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 14:08:57 -0500
Received: by mail-vs1-f68.google.com with SMTP id g23so1919180vsr.7;
        Fri, 24 Jan 2020 11:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JykckUs2gCxAmF14L/8LuyMZHmH7QFoL3RGP2bW/Tt8=;
        b=aUKY0OXuOle2jrNxqk97t6NpgtVKyG+qEd80lI/bg62cNijzvPTOKTiL4kgMkYfe3K
         PhNQXTIMBokTfCBK3IUcnEQP+3jWgb40gzVq7JcFHKvLza0H4a+hpB88uNxnK5fESjfh
         vu/h7qRIkMVk1MCmzVZeqxkYF9yySOMmuyv8X/fkorgsbjbF4ARTMFsUo5ghDrMsVhyd
         vCoWTjkojC1v5fF67frWzdBNeSu7n4WsTVp97ueInoMFRd/OGexTeF1ClHuicE5YuTLv
         ejGkRkFSf18jhQzPDqwLMzDBt6MWkoD46urSQgQH8b2p4RVrPnZRA30QSfyBgwVmx/dE
         dT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JykckUs2gCxAmF14L/8LuyMZHmH7QFoL3RGP2bW/Tt8=;
        b=sVKRJ21PoOegC9vdAf5Ua6dMW2Fdw1LhyAo3LvLaLZ1gD1WSk8kiIb51Auw56JfuZk
         WPryb35vvPFxzstciJhw8A9iTQ2JAJDAFtn81bC8R+c6ND66WjXq1Xv3oVm5C1Wxplu4
         61DYiUMzQHTEItZotO0HDDgySV038o22MzYnenESDfBGOLq0C5FEsaNSZCA0XvRy2+Yt
         tntl4lkIubxBxPGn0h3l+TbJYeb9phNKVOlj/gssZzLII1DN2bHyiKynF2fzemG0A9F5
         gTAr6/4+LJVZ24zXWwYXRKtAmypERVpm3on3ZXQKzz526uedtPvSDhA2b1oft3oBwYRs
         beqg==
X-Gm-Message-State: APjAAAXL9p1JO5JKUc/RN6/ItQDfJUDjvEvQkv4yfgt4u69kCjM+JMWF
        xIB6pQjLfqCRPO0dxTShrMG5rpHijpKS/+894mI=
X-Google-Smtp-Source: APXvYqxN9nZ8wc+edVahAZ0+Qr+drZJHfLjnhca8QE04Bd4K25mmrvVo2/OCFIVsQSB4qUgWCIvsm7dzlBMZQu1tRos=
X-Received: by 2002:a67:cc3:: with SMTP id 186mr3373215vsm.200.1579892935648;
 Fri, 24 Jan 2020 11:08:55 -0800 (PST)
MIME-Version: 1.0
References: <20200124184221.322248-1-cgzones@googlemail.com> <6e33cbcd-31fd-2d50-5d0f-70eb475f9811@tycho.nsa.gov>
In-Reply-To: <6e33cbcd-31fd-2d50-5d0f-70eb475f9811@tycho.nsa.gov>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 24 Jan 2020 20:08:44 +0100
Message-ID: <CAJ2a_DcS8e8OjRRHjbYhCphsLi3u=KxX5XorCEA_=5vfN+5q8g@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow kernfs symlinks to inherit parent
 directory context
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Fr., 24. Jan. 2020 um 19:53 Uhr schrieb Stephen Smalley <sds@tycho.nsa.g=
ov>:
>
> On 1/24/20 1:42 PM, Christian G=C3=B6ttsche wrote:
> > Currently symlinks on kernel filesystems, like sysfs, are labeled on
> > creation with the parent fs root sid.
> >
> > Allow symlinks to inherit the parent directory context, so fine-grained
> > kernfs labeling can be applied to symlinks too and checking contexts
> > doesn't complain about them.
> >
> > For backward-compatibility this behavior is contained in a new policy
> > capability: kernfs_sovereign_symlinks
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >   security/selinux/hooks.c            | 5 ++++-
> >   security/selinux/include/security.h | 8 ++++++++
> >   security/selinux/ss/services.c      | 3 ++-
> >   3 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index d9e8b2131..1303bc8c4 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -1475,7 +1475,10 @@ static int inode_doinit_with_dentry(struct inode=
 *inode, struct dentry *opt_dent
> >               /* Default to the fs superblock SID. */
> >               sid =3D sbsec->sid;
> >
> > -             if ((sbsec->flags & SE_SBGENFS) && !S_ISLNK(inode->i_mode=
)) {
> > +             if (((sbsec->flags & SE_SBGENFS) &&
> > +                  (!S_ISLNK(inode->i_mode))) ||
> > +                 (selinux_policycap_kernfs_sovereign_symlinks() &&
>
> Not fond of the name.  1) kernfs is a kernel implementation detail,
> shouldn't be exposed to policy; genfs is the policy construct 2)
> sovereign doesn't seem to fit the meaning of this capability; seclabel
> would be more appropriate.

Something like genfs_seclabel_symlinks?

> > +                  (sbsec->flags & SE_SBGENFS_XATTR))) {
>
> Why limit this to SE_SBGENFS_XATTR filesystems?  Why not just make the te=
st:
>         if ((sbsec->flags & SE_SBGENFS) && (!S_ISLNK(inode->i_mode) ||
> selinux_policycap_genfs_symlinkseclabel()))
> or similar.

I somehow thought that this functionality is limited to filesystems
with SE_SBGENFS_XATTR;
so I can expand the check to SE_SBGENFS.

> >                       /* We must have a dentry to determine the label o=
n
> >                        * procfs inodes */
> >                       if (opt_dentry) {
> > diff --git a/security/selinux/include/security.h b/security/selinux/inc=
lude/security.h
> > index a39f9565d..cc8217848 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -79,6 +79,7 @@ enum {
> >       POLICYDB_CAPABILITY_ALWAYSNETWORK,
> >       POLICYDB_CAPABILITY_CGROUPSECLABEL,
> >       POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> > +     POLICYDB_CAPABILITY_KERNFS_SOVEREIGN_SYMLINKS,
> >       __POLICYDB_CAPABILITY_MAX
> >   };
> >   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> > @@ -209,6 +210,13 @@ static inline bool selinux_policycap_nnp_nosuid_tr=
ansition(void)
> >       return state->policycap[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION=
];
> >   }
> >
> > +static inline bool selinux_policycap_kernfs_sovereign_symlinks(void)
> > +{
> > +     struct selinux_state *state =3D &selinux_state;
> > +
> > +     return state->policycap[POLICYDB_CAPABILITY_KERNFS_SOVEREIGN_SYML=
INKS];
> > +}
> > +
> >   int security_mls_enabled(struct selinux_state *state);
> >   int security_load_policy(struct selinux_state *state,
> >                        void *data, size_t len);
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 216ce602a..b70380947 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -73,7 +73,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABI=
LITY_MAX] =3D {
> >       "extended_socket_class",
> >       "always_check_network",
> >       "cgroup_seclabel",
> > -     "nnp_nosuid_transition"
> > +     "nnp_nosuid_transition",
> > +     "kernfs_sovereign_symlinks"
> >   };
> >
> >   static struct selinux_ss selinux_ss;
> >
>
