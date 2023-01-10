Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D52C54EBC
	for <selinux@archiver.kernel.org>; Tue, 10 Jan 2023 14:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjAJO3C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Jan 2023 09:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238610AbjAJO2y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Jan 2023 09:28:54 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE1CC1C
        for <selinux@vger.kernel.org>; Tue, 10 Jan 2023 06:28:53 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o13so9055313pjg.2
        for <selinux@vger.kernel.org>; Tue, 10 Jan 2023 06:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXLq/kYkLjS3ssTafsFlqZIO4Wm/+EAU8B1worNMQoc=;
        b=ZQwoY3bJGsVweY0dQ6YlNxmFd2M/M25/5gRSh/Ac+/hZChbqiGF/LMnGvlM+/Pw66M
         2Qb2Ijp91G3cChADInOqLqyjdF41F/K9Y6+n0amotsfMN9a2ULyshn1HRJAyV54eHk3J
         9F38t5o/29mZMEymDPXvRGDJDhmKlAIJ3cdIWzGtXr7QKs6RuIbAFw10E5XVPgj9VrQn
         iEY9eN1Zi6obfT62aRgaW7i6PLW8nZRjVHYrRCKt5VMVbuaeGFhiyshRc+7g/VnRdXCs
         RJ6fqc1kICrqkKcN1UJC6rJ0ZbNkcCOGdBgN67wPYwx6X+mpq7h8X34GyHtJ6FAFJbl5
         JEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXLq/kYkLjS3ssTafsFlqZIO4Wm/+EAU8B1worNMQoc=;
        b=Ms0xIfuICjtKZeexPD6Go40eGXIi8/DrGaujqAd2bDpUzrSPsiL6ashYX6SFhuUaO7
         r9QPCmeD0KU6H5xj9fV2sSHSZGh5chUA+kBT44VgWlJmbClxkKE9MOGWRlpPAkl69MM7
         3f+4RgHhGAZ2HzQzcYwenJIaWpR2NVvnRvi+sDudIge04KQKsJFrztM1bx6vcqsdF3Sd
         dqMuyT3wleKySaqO41jLDMcTrbgzz3uc+Z2I79ddRDDKl1LGbYXAf29mZgl0PH/Rik8I
         OPxYBzwHE+MmMzRLkQpp8SirLyGAWGvniQPALEnxjzsb5k658giIIv/BvFsuHQgMaxrv
         AYEw==
X-Gm-Message-State: AFqh2krX1QVnrMxoYole8wauDlfuXVcZIiEk6GyaboUyYbZo5gMkh77p
        wq3mRHtV+wNEBzuDORkygfcGIUHjAqSJ34mnDxXuCg2wlAM=
X-Google-Smtp-Source: AMrXdXuzRtsnnhJBoRw1srm1/Wovx/x1f1MJ0Wrrz4bVqeB6C32NX5E0H7kamjlLlM7Fwb/v4qSjNwi1fYHQPbdrBno=
X-Received: by 2002:a17:903:3302:b0:193:794:ba9 with SMTP id
 jk2-20020a170903330200b0019307940ba9mr1174734plb.22.1673360932531; Tue, 10
 Jan 2023 06:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20230109170912.57887-1-cgzones@googlemail.com>
 <CAEjxPJ5acJtHwF=Gh2iNehERoJ5S5G2txwk3n7hVRGANwrZozg@mail.gmail.com>
 <CAJ2a_DeRPO8CKLyMYYc2MHdAnxAdFunts3YMHVG1p+i_7Fr2Tg@mail.gmail.com> <CAEjxPJ6w__ESx2iEsjuHfp=eUAe7i9Myfqh-p9S2pzK4KcW0gw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6w__ESx2iEsjuHfp=eUAe7i9Myfqh-p9S2pzK4KcW0gw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 10 Jan 2023 09:28:41 -0500
Message-ID: <CAEjxPJ4G4JLUVxi624Uvze2Ew2KBOPA4TzPeXtNoYP_gN-Tbfg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add getpidprevcon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 10, 2023 at 9:21 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jan 10, 2023 at 9:14 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On Tue, 10 Jan 2023 at 14:18, Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Mon, Jan 9, 2023 at 12:17 PM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > > >
> > > > Add the public interfaces getpidprevcon(3) and getpidprevcon_raw(3)=
, and
> > > > the utility getpidprevcon to gather the previous context before the=
 last
> > > > exec of a given process.
> > >
> > > Wondering if we should warn in the manual page for this and other
> > > getpid*con() interfaces that they are inherently racy and therefore
> > > should never be relied upon for security purposes.
> >
> > With "and other getpid*con() interfaces" do you mean just getpidcon(3)
> > (and getpidcon_raw(3)), which is currently the only interface matching
> > your regex and operating on a foreign process, or also getcon(3) and
> > getprevcon(3)?
> >
> > With race conditions you mean the possibility of the target process
> > changing its context (via setcon(3)) or querying a replaced process
> > (which is mainly possible via spawning a new process after setting
> > /proc/sys/kernel/ns_last_pid)?
> > Or do you have others in mind?
>
> Yes, just getpidcon/getpidcon_raw. And correct - the inherent race is
> with respect to looking up a target process by pid,
> when said process may potentially switch its context via setcon or
> execve or exit and be replaced by a process of another context.
> This was actually successfully done in Android against a service that
> was using getpidcon() to obtain the context of the binder client
> before support for passing contexts across binder IPC was added.

See https://bugs.chromium.org/p/project-zero/issues/detail?id=3D1741

>
>
> >
> > p.s.:
> > after the discussion has settled I'll send a v2 with the interfaces
> > actually published in libselinux.map
> >
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > ---
> > > >  libselinux/include/selinux/selinux.h    |  5 ++++
> > > >  libselinux/man/man3/getcon.3            |  9 +++++++
> > > >  libselinux/man/man3/getpidprevcon.3     |  1 +
> > > >  libselinux/man/man3/getpidprevcon_raw.3 |  1 +
> > > >  libselinux/src/procattr.c               | 18 ++++++++++++++
> > > >  libselinux/utils/.gitignore             |  1 +
> > > >  libselinux/utils/getpidprevcon.c        | 33 +++++++++++++++++++++=
++++
> > > >  7 files changed, 68 insertions(+)
> > > >  create mode 100644 libselinux/man/man3/getpidprevcon.3
> > > >  create mode 100644 libselinux/man/man3/getpidprevcon_raw.3
> > > >  create mode 100644 libselinux/utils/getpidprevcon.c
> > > >
> > > > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/incl=
ude/selinux/selinux.h
> > > > index 47af9953..a0948853 100644
> > > > --- a/libselinux/include/selinux/selinux.h
> > > > +++ b/libselinux/include/selinux/selinux.h
> > > > @@ -54,6 +54,11 @@ extern int getpidcon_raw(pid_t pid, char ** con)=
;
> > > >  extern int getprevcon(char ** con);
> > > >  extern int getprevcon_raw(char ** con);
> > > >
> > > > +/* Get previous context (prior to last exec) of process identified=
 by pid, and
> > > > +   set *con to refer to it.  Caller must free via freecon. */
> > > > +extern int getpidprevcon(pid_t pid, char ** con);
> > > > +extern int getpidprevcon_raw(pid_t pid, char ** con);
> > > > +
> > > >  /* Get exec context, and set *con to refer to it.
> > > >     Sets *con to NULL if no exec context has been set, i.e. using d=
efault.
> > > >     If non-NULL, caller must free via freecon. */
> > > > diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/get=
con.3
> > > > index e7e394f3..38da958b 100644
> > > > --- a/libselinux/man/man3/getcon.3
> > > > +++ b/libselinux/man/man3/getcon.3
> > > > @@ -23,6 +23,10 @@ setcon \- set current security context of a proc=
ess
> > > >  .sp
> > > >  .BI "int getpidcon_raw(pid_t " pid ", char **" context );
> > > >  .sp
> > > > +.BI "int getpidprevcon(pid_t " pid ", char **" context );
> > > > +.sp
> > > > +.BI "int getpidprevcon_raw(pid_t " pid ", char **" context );
> > > > +.sp
> > > >  .BI "int getpeercon(int " fd ", char **" context );
> > > >  .sp
> > > >  .BI "int getpeercon_raw(int " fd ", char **" context );
> > > > @@ -50,6 +54,11 @@ same as getcon but gets the context before the l=
ast exec.
> > > >  returns the process context for the specified PID, which must be f=
ree'd with
> > > >  .BR freecon ().
> > > >
> > > > +.TP
> > > > +.BR getpidprevcon ()
> > > > +returns the process context before the last exec for the specified=
 PID, which must be free'd with
> > > > +.BR freecon ().
> > > > +
> > > >  .TP
> > > >  .BR getpeercon ()
> > > >  retrieves the context of the peer socket, which must be free'd wit=
h
> > > > diff --git a/libselinux/man/man3/getpidprevcon.3 b/libselinux/man/m=
an3/getpidprevcon.3
> > > > new file mode 100644
> > > > index 00000000..1210b5a0
> > > > --- /dev/null
> > > > +++ b/libselinux/man/man3/getpidprevcon.3
> > > > @@ -0,0 +1 @@
> > > > +.so man3/getcon.3
> > > > diff --git a/libselinux/man/man3/getpidprevcon_raw.3 b/libselinux/m=
an/man3/getpidprevcon_raw.3
> > > > new file mode 100644
> > > > index 00000000..1210b5a0
> > > > --- /dev/null
> > > > +++ b/libselinux/man/man3/getpidprevcon_raw.3
> > > > @@ -0,0 +1 @@
> > > > +.so man3/getcon.3
> > > > diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> > > > index 6f4cfb82..b7a93a2b 100644
> > > > --- a/libselinux/src/procattr.c
> > > > +++ b/libselinux/src/procattr.c
> > > > @@ -300,3 +300,21 @@ int getpidcon(pid_t pid, char **c)
> > > >         }
> > > >         return getprocattrcon(c, pid, "current", NULL);
> > > >  }
> > > > +
> > > > +int getpidprevcon_raw(pid_t pid, char **c)
> > > > +{
> > > > +        if (pid <=3D 0) {
> > > > +                errno =3D EINVAL;
> > > > +                return -1;
> > > > +        }
> > > > +        return getprocattrcon_raw(c, pid, "prev", NULL);
> > > > +}
> > > > +
> > > > +int getpidprevcon(pid_t pid, char **c)
> > > > +{
> > > > +        if (pid <=3D 0) {
> > > > +                errno =3D EINVAL;
> > > > +                return -1;
> > > > +        }
> > > > +        return getprocattrcon(c, pid, "prev", NULL);
> > > > +}
> > > > diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitign=
ore
> > > > index 3ef34374..b19b94a8 100644
> > > > --- a/libselinux/utils/.gitignore
> > > > +++ b/libselinux/utils/.gitignore
> > > > @@ -9,6 +9,7 @@ getdefaultcon
> > > >  getenforce
> > > >  getfilecon
> > > >  getpidcon
> > > > +getpidprevcon
> > > >  getsebool
> > > >  getseuser
> > > >  matchpathcon
> > > > diff --git a/libselinux/utils/getpidprevcon.c b/libselinux/utils/ge=
tpidprevcon.c
> > > > new file mode 100644
> > > > index 00000000..662ad500
> > > > --- /dev/null
> > > > +++ b/libselinux/utils/getpidprevcon.c
> > > > @@ -0,0 +1,33 @@
> > > > +#include <unistd.h>
> > > > +#include <stdio.h>
> > > > +#include <stdlib.h>
> > > > +#include <string.h>
> > > > +#include <errno.h>
> > > > +#include <selinux/selinux.h>
> > > > +
> > > > +int main(int argc, char **argv)
> > > > +{
> > > > +       pid_t pid;
> > > > +       char *buf;
> > > > +       int rc;
> > > > +
> > > > +       if (argc !=3D 2) {
> > > > +               fprintf(stderr, "usage:  %s pid\n", argv[0]);
> > > > +               exit(1);
> > > > +       }
> > > > +
> > > > +       if (sscanf(argv[1], "%d", &pid) !=3D 1) {
> > > > +               fprintf(stderr, "%s:  invalid pid %s\n", argv[0], a=
rgv[1]);
> > > > +               exit(2);
> > > > +       }
> > > > +
> > > > +       rc =3D getpidprevcon(pid, &buf);
> > > > +       if (rc < 0) {
> > > > +               fprintf(stderr, "%s:  getpidprevcon() failed:  %s\n=
", argv[0], strerror(errno));
> > > > +               exit(3);
> > > > +       }
> > > > +
> > > > +       printf("%s\n", buf);
> > > > +       freecon(buf);
> > > > +       exit(EXIT_SUCCESS);
> > > > +}
> > > > --
> > > > 2.39.0
> > > >
