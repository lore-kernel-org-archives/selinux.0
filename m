Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C570DC433F5
	for <selinux@archiver.kernel.org>; Mon, 16 May 2022 17:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbiEPRKV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 May 2022 13:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiEPRKU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 May 2022 13:10:20 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598E12B24C
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:10:19 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y63so19361962oia.7
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FUJQB1lvcEbDXehASIHrt0KBuMZyK8ooBMr02pVRR/Y=;
        b=pg/8aiXQ1pdHxaTy4ITDddKu4O12eLxxGk9mZWdILrtGlzrFkAfNZI8iQCv3E7NkyO
         7xdotRIRPFDPUBu2VLzpTRqNWSvKjwDDqkGUY8J6FU8osTN6H8KTscvxo9jZO/2pH2Cd
         Rxu17LD2CXld+NQD1VUGZHkr3i5RmtF+nC62his8gYnFOstx0mTYzVOjB69gt01VWzXb
         aSPzQ+HLAutbWTJmK3WYLQk5+oP2U2FpVSA7VlD7C5+FCMwgE8t4ZJomn5w9tBfuwhUm
         71N3R6J7X8AAjLye4tkUy7O1WvM1PIc6DEoodixnH3Yit0HDm8PqMKo4AZcrRfM1iHib
         QrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FUJQB1lvcEbDXehASIHrt0KBuMZyK8ooBMr02pVRR/Y=;
        b=UxKyFVtQ3RQURy4CFX70iL54dK/Pmscl4VCfIM7+U204I84auKqhdQcafFgviQC+xl
         O7HdeFtHqsuuhQPFYzZ6ql6x5aRgqP9N2V6pbmkUdy6A1p/BcyVCcvPjpRA0iA9a70FR
         HweUz1IC2kJzj8HSh753TtXXtrJuFPGavpDGfIq0BpJ6LNVMkHwfK6Qd8/7hP3ri3jwU
         h0YYEKFDYarRwgOwbQbQR/ajHmb/V+hjggAPnMZgJ1xX66UnZ/cYsVG9AlchJAbf8CII
         zPuw/w6M+sRViwlKoqKV2d3d5N/QifR2d9dpftCJX2hJF9qofr/ilDj1FY4EqsqCeF7D
         Hs8w==
X-Gm-Message-State: AOAM533mBFsGUTdWbSqmu4i2fFIoYeqdZvk+rer1sqZsT062Hbs6tCbM
        0a6mvgtsUIHElx1LvgI24jxcK2VsHBJpxOsLigJRJ+Oj
X-Google-Smtp-Source: ABdhPJxE1r2lDzHp2rf7JZL3OqfZu1/rJcWlniFLd7CWoU7WfVGEJBaLfWOgsM8MK0/HYnPaRcDvXQONsGG83mhAEcs=
X-Received: by 2002:a05:6808:ec5:b0:2f9:a7fb:4dfb with SMTP id
 q5-20020a0568080ec500b002f9a7fb4dfbmr13759997oiv.156.1652721018733; Mon, 16
 May 2022 10:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220505174420.24537-1-cgzones@googlemail.com>
 <20220511184225.218062-1-cgzones@googlemail.com> <CAP+JOzRJtgXVvAFjuB1sV6C3HifnMQQNW+b0rDD=Zc0pbpt7+g@mail.gmail.com>
In-Reply-To: <CAP+JOzRJtgXVvAFjuB1sV6C3HifnMQQNW+b0rDD=Zc0pbpt7+g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 16 May 2022 13:10:07 -0400
Message-ID: <CAP+JOzTu5mwChTMnbO_W3oQOFsrB5hDuHHbqabsZza+Y9=gL0w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] libselinux: restorecon: misc tweaks
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 12, 2022 at 1:38 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, May 11, 2022 at 7:58 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > * mark read-only parameters const
> > * check for overflow when adding exclude directory
> > * use 64 bit integer for file counting
> > * avoid implicit conversions
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim


> > ---
> >  libselinux/src/selinux_restorecon.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index e6192912..c158ead8 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -44,7 +44,7 @@
> >  static struct selabel_handle *fc_sehandle =3D NULL;
> >  static bool selabel_no_digest;
> >  static char *rootpath =3D NULL;
> > -static int rootpathlen;
> > +static size_t rootpathlen;
> >
> >  /* Information on excluded fs and directories. */
> >  struct edir {
> > @@ -55,7 +55,7 @@ struct edir {
> >  };
> >  #define CALLER_EXCLUDED true
> >  static bool ignore_mounts;
> > -static int exclude_non_seclabel_mounts(void);
> > +static uint64_t exclude_non_seclabel_mounts(void);
> >  static int exclude_count =3D 0;
> >  static struct edir *exclude_lst =3D NULL;
> >  static uint64_t fc_count =3D 0;  /* Number of files processed so far *=
/
> > @@ -169,6 +169,12 @@ static int add_exclude(const char *directory, bool=
 who)
> >                 return -1;
> >         }
> >
> > +       if (exclude_count >=3D INT_MAX - 1) {
> > +               selinux_log(SELINUX_ERROR, "Too many directory excludes=
: %d.\n", exclude_count);
> > +               errno =3D EOVERFLOW;
> > +               return -1;
> > +       }
> > +
> >         tmp_list =3D realloc(exclude_lst,
> >                            sizeof(struct edir) * (exclude_count + 1));
> >         if (!tmp_list)
> > @@ -211,10 +217,10 @@ static int check_excluded(const char *file)
> >         return 0;
> >  }
> >
> > -static int file_system_count(char *name)
> > +static uint64_t file_system_count(const char *name)
> >  {
> >         struct statvfs statvfs_buf;
> > -       int nfile =3D 0;
> > +       uint64_t nfile =3D 0;
> >
> >         memset(&statvfs_buf, 0, sizeof(statvfs_buf));
> >         if (!statvfs(name, &statvfs_buf))
> > @@ -230,12 +236,13 @@ static int file_system_count(char *name)
> >   * that support security labels have the seclabel option, return
> >   * approximate total file count.
> >   */
> > -static int exclude_non_seclabel_mounts(void)
> > +static uint64_t exclude_non_seclabel_mounts(void)
> >  {
> >         struct utsname uts;
> >         FILE *fp;
> >         size_t len;
> > -       int index =3D 0, found =3D 0, nfile =3D 0;
> > +       int index =3D 0, found =3D 0;
> > +       uint64_t nfile =3D 0;
> >         char *mount_info[4];
> >         char *buf =3D NULL, *item;
> >
> > @@ -300,7 +307,8 @@ static int add_xattr_entry(const char *directory, b=
ool delete_nonmatch,
> >  {
> >         char *sha1_buf =3D NULL;
> >         size_t i, digest_len =3D 0;
> > -       int rc, digest_result;
> > +       int rc;
> > +       enum digest_result digest_result;
> >         bool match;
> >         struct dir_xattr *new_entry;
> >         uint8_t *xattr_digest =3D NULL;
> > @@ -573,7 +581,7 @@ static void filespec_destroy(void)
> >   * Called if SELINUX_RESTORECON_SET_SPECFILE_CTX is not set to check i=
f
> >   * the type components differ, updating newtypecon if so.
> >   */
> > -static int compare_types(char *curcon, char *newcon, char **newtypecon=
)
> > +static int compare_types(const char *curcon, const char *newcon, char =
**newtypecon)
> >  {
> >         int types_differ =3D 0;
> >         context_t cona;
> > @@ -1398,7 +1406,7 @@ void selinux_restorecon_set_exclude_list(const ch=
ar **exclude_list)
> >  /* selinux_restorecon_set_alt_rootpath(3) sets an alternate rootpath. =
*/
> >  int selinux_restorecon_set_alt_rootpath(const char *alt_rootpath)
> >  {
> > -       int len;
> > +       size_t len;
> >
> >         /* This should be NULL on first use */
> >         if (rootpath)
> > --
> > 2.36.1
> >
