Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F45C433EF
	for <selinux@archiver.kernel.org>; Thu, 20 Jan 2022 22:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378020AbiATWKw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jan 2022 17:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378018AbiATWKw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jan 2022 17:10:52 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DF5C061574
        for <selinux@vger.kernel.org>; Thu, 20 Jan 2022 14:10:51 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso9390955otj.8
        for <selinux@vger.kernel.org>; Thu, 20 Jan 2022 14:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8JGdG8PmsJLkcqUskIXKWF6MrAP4YAWpwcNQTDacHxU=;
        b=QgihNiGDRUY49BQnZCLAT01nankRiEuYSMxYLYtIo2NoXftaQDPbYjryOkxwc3Njqm
         rvGceSxEjnAUB5RFM30RgHzvqZHyl1CkuP+9ZzsVUUK3uTfjcCI4TbV0fM0EjY/Pp8vZ
         D+9y1ce9mBmdCCPZFWiM6fnPMcka59zFOp2mm4O4VJNDxyEoT4S8yElgl9lWYb0jAwaK
         nxcymQ6flkSq73apUw/zmIQjwq1nihuND81th4QaJCdrY0CO23GZUO+FkOUvMQjT693W
         +2xGcln0ogxJ1X0X3+af21fzs/9kpBt4RK06Cnt9xhs0jNPlUbW3RELH52ENT9b3UCbw
         /zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8JGdG8PmsJLkcqUskIXKWF6MrAP4YAWpwcNQTDacHxU=;
        b=tLaVCUVRrQx5t+WqkFEN/2Ok+uFihEikuD1r2T2bnQEsHCbUe/X56BYIAVCS/l0Rah
         7Gq4XOkrW8V0stSL03nwhVmWSyEOn7Z0ds0sWgGRK9WY/KP43r7EzJK0C0alV/CxhFwR
         IbOlYOD3qFfSYe6eYo8rF9/AcCj/0XzUje92MGR050YD6gVR/DZCAaQUyS2TIFOP5hbK
         nqqY6TR11fQ2APcOsICg2VDJZp9CgnWS3JV9yJWtM1WJX19W7vraUfRh619RWtDWQHw8
         bBn5PWmOGaHwcyE2iovhcGn3dMHTYPJybbLH2iB0y9GuKcOsI25DgLP1tPQM4P/Pv+4D
         r7oQ==
X-Gm-Message-State: AOAM532qxv/Gkn8cQ7Sxc6vVTPppjM5wdeCEz3hnPOh9DqPcvqe4PvT+
        OT53HdoaBTdAABnjuZhQZ1jMHPkMkV291Qh+6TMjFcX9
X-Google-Smtp-Source: ABdhPJwbG6Hi26QaFSCtiCcwmDFvCLCgR/9gCsDJ5ngCjMl2e1Mih27+IdRtXONF4AFLvw4WVmBnLME/4rrCTVPKBSY=
X-Received: by 2002:a05:6830:224e:: with SMTP id t14mr668800otd.154.1642716651249;
 Thu, 20 Jan 2022 14:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20220113143935.195125-1-omosnace@redhat.com> <20220113143935.195125-6-omosnace@redhat.com>
 <CAJ2a_Det151ui=84of_0B8a8HazfkySeCmMGnRy5jwE5mkM7+A@mail.gmail.com>
In-Reply-To: <CAJ2a_Det151ui=84of_0B8a8HazfkySeCmMGnRy5jwE5mkM7+A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 20 Jan 2022 17:10:40 -0500
Message-ID: <CAP+JOzR3WrqYRS8gKPD3P=k7DKy+H6D+h75j49dyuVt76hJYkA@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 5/5] semodule: add command-line option to
 detect module changes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jan 16, 2022 at 11:07 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Thu, 13 Jan 2022 at 15:39, Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> >
> > Add a new command-line option "--smart" (for the lack of a better
> > name...) to control the newly introduced check_ext_changes libsemanage
> > flag.
> >
> > For example, running `semodule -B --smart` will ensure that any
> > externally added/removed modules (e.g. by an RPM transaction) are
> > reflected in the compiled policy, while skipping the most expensive par=
t
> > of the rebuild if no module change was deteceted since the last
> > libsemanage transaction.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  policycoreutils/semodule/semodule.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semo=
dule/semodule.c
> > index a5b71fc4..638edb39 100644
> > --- a/policycoreutils/semodule/semodule.c
> > +++ b/policycoreutils/semodule/semodule.c
> > @@ -47,6 +47,7 @@ static int verbose;
> >  static int reload;
> >  static int no_reload;
> >  static int build;
> > +static int check_ext_changes;
> >  static int disable_dontaudit;
> >  static int preserve_tunables;
> >  static int ignore_module_cache;
> > @@ -149,6 +150,8 @@ static void usage(char *progname)
> >         printf("  -c, --cil extract module as cil. This only affects mo=
dule extraction.\n");
> >         printf("  -H, --hll extract module as hll. This only affects mo=
dule extraction.\n");
> >         printf("  -m, --checksum   print module checksum (SHA256).\n");
> > +       printf("      --smart      force policy rebuild if module conte=
nt changed since\n"
> > +              "                   last rebuild (based on checksum)\n")=
;
>
> Some other naming suggestions:
>
> incremental
> on-update
> on-change
> changed-only
> updated-only
>
> Also maybe describe with `force policy rebuild only if ...`, cause
> otherwise one might think without --smart modules are never rebuild.
>

I was going to suggest "--if-required" or "--if-needed". I think that
"incremental" or "on-change" would be ok as well.

Jim

> >  }
> >
> >  /* Sets the global mode variable to new_mode, but only if no other
> > @@ -180,6 +183,7 @@ static void set_mode(enum client_modes new_mode, ch=
ar *arg)
> >  static void parse_command_line(int argc, char **argv)
> >  {
> >         static struct option opts[] =3D {
> > +               {"smart", 0, NULL, '\0'},
> >                 {"store", required_argument, NULL, 's'},
> >                 {"base", required_argument, NULL, 'b'},
> >                 {"help", 0, NULL, 'h'},
> > @@ -207,15 +211,26 @@ static void parse_command_line(int argc, char **a=
rgv)
> >         };
> >         int extract_selected =3D 0;
> >         int cil_hll_set =3D 0;
> > -       int i;
> > +       int i, longind;
> >         verbose =3D 0;
> >         reload =3D 0;
> >         no_reload =3D 0;
> > +       check_ext_changes =3D 0;
> >         priority =3D 400;
> >         while ((i =3D
> > -               getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:=
S:E:cHm", opts,
> > -                           NULL)) !=3D -1) {
> > +               getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:=
S:E:cHm",
> > +                           opts, &longind)) !=3D -1) {
> >                 switch (i) {
> > +               case '\0':
> > +                       switch(longind) {
> > +                       case 0: /* --smart */
> > +                               check_ext_changes =3D 1;
> > +                               break;
> > +                       default:
> > +                               usage(argv[0]);
> > +                               exit(1);
> > +                       }
> > +                       break;
> >                 case 'b':
> >                         fprintf(stderr, "The --base option is deprecate=
d. Use --install instead.\n");
> >                         set_mode(INSTALL_M, optarg);
> > @@ -813,6 +828,8 @@ cleanup_disable:
> >                         semanage_set_reload(sh, 0);
> >                 if (build)
> >                         semanage_set_rebuild(sh, 1);
> > +               if (check_ext_changes)
> > +                       semanage_set_check_ext_changes(sh, 1);
> >                 if (disable_dontaudit)
> >                         semanage_set_disable_dontaudit(sh, 1);
> >                 else if (build)
> > --
> > 2.34.1
> >
