Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78635C54EBC
	for <selinux@archiver.kernel.org>; Tue, 10 Jan 2023 14:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjAJOOd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Jan 2023 09:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbjAJOOc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Jan 2023 09:14:32 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D32D5F
        for <selinux@vger.kernel.org>; Tue, 10 Jan 2023 06:14:28 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id m2so12343501vsv.9
        for <selinux@vger.kernel.org>; Tue, 10 Jan 2023 06:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYVtPCSsm6K11vUjbYkNBN5fIa/Dc2F8+H5v2F6EEww=;
        b=iGmfcaLmtnPMjRFIBFwYoJ3O+R3Otao0FC4FooluVEjmRwyHMPi9Ei2+mwmJX5QvsO
         dbRGFkFw+qd3jmm8CJ/NXcNZM79fZJI0emuakgpvEsvB8Xjwj58P4icjU4YxQkjjV9Cf
         L/yIuUlOl/leLOYCeGac4tJdOPfDOaMH33mgY1b9g6UPgSMiuGvPHwf81178SMk9u4cs
         gUvAxaAQIEUv8Ui0hnxVNbnaDVCMAsXRSJWeSdpWJ2OKPiIAcaTXX2dRtpE6bEWJixpA
         nT9+o0iTxJYoPn/1K+p9wBuQ4zlzKiVcXLTCX5l9k78iNOHeD4s/2zFk32c/blTbYIh5
         y63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYVtPCSsm6K11vUjbYkNBN5fIa/Dc2F8+H5v2F6EEww=;
        b=a+QtQTSHwo3DsP173Rn14Ot8d571DyIramYpsPtGdBm+axe84nY3EiQP93PkVL+o6+
         +Mui/Us95pQGgEqo/hhWzHyyEKeOvBFIsQKEvfuXZ+b+WHw17FmAxaWYXYsYQVsBAQxx
         IjXrr7Dn6f1LuNvLsKx3r5P+mxP2M8wnHBT1DRi4a10K89eOlW1xwN6U0uIctXg3SFFf
         2FWs+5lYKiNrfU6NXjckpvBhDn0a8i16A2oHt3hPDaew2EO8+4JKR3GP4PPzVQlSXncR
         T1gX5oHRFtIUjFfTRwroYWNMXtqjwgfG/RlzwNgXY67GpWJW/s3ZmK7paxMBMo5bTLLj
         9bAw==
X-Gm-Message-State: AFqh2kpVma+5uE2HFM3sjCMB8+Ctl7f01NGRK00oHPPlTJDP4CLD35eF
        SuxsICqzz4qAxo0fxTNTFhPNvprc/kaVbzHCg1I=
X-Google-Smtp-Source: AMrXdXvevBoZ78NZdla0nkTQENtsiCcz6LA7VwPp66/7s+e9uBLUgEe0rpXkJVOE8861B0BgscBRTfoIsEb8PxpLR2A=
X-Received: by 2002:a05:6102:944:b0:3b0:7bc1:db3f with SMTP id
 a4-20020a056102094400b003b07bc1db3fmr8457803vsi.28.1673360066950; Tue, 10 Jan
 2023 06:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20230109170912.57887-1-cgzones@googlemail.com> <CAEjxPJ5acJtHwF=Gh2iNehERoJ5S5G2txwk3n7hVRGANwrZozg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5acJtHwF=Gh2iNehERoJ5S5G2txwk3n7hVRGANwrZozg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 10 Jan 2023 15:14:13 +0100
Message-ID: <CAJ2a_DeRPO8CKLyMYYc2MHdAnxAdFunts3YMHVG1p+i_7Fr2Tg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add getpidprevcon
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 10 Jan 2023 at 14:18, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jan 9, 2023 at 12:17 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add the public interfaces getpidprevcon(3) and getpidprevcon_raw(3), an=
d
> > the utility getpidprevcon to gather the previous context before the las=
t
> > exec of a given process.
>
> Wondering if we should warn in the manual page for this and other
> getpid*con() interfaces that they are inherently racy and therefore
> should never be relied upon for security purposes.

With "and other getpid*con() interfaces" do you mean just getpidcon(3)
(and getpidcon_raw(3)), which is currently the only interface matching
your regex and operating on a foreign process, or also getcon(3) and
getprevcon(3)?

With race conditions you mean the possibility of the target process
changing its context (via setcon(3)) or querying a replaced process
(which is mainly possible via spawning a new process after setting
/proc/sys/kernel/ns_last_pid)?
Or do you have others in mind?

p.s.:
after the discussion has settled I'll send a v2 with the interfaces
actually published in libselinux.map

> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/include/selinux/selinux.h    |  5 ++++
> >  libselinux/man/man3/getcon.3            |  9 +++++++
> >  libselinux/man/man3/getpidprevcon.3     |  1 +
> >  libselinux/man/man3/getpidprevcon_raw.3 |  1 +
> >  libselinux/src/procattr.c               | 18 ++++++++++++++
> >  libselinux/utils/.gitignore             |  1 +
> >  libselinux/utils/getpidprevcon.c        | 33 +++++++++++++++++++++++++
> >  7 files changed, 68 insertions(+)
> >  create mode 100644 libselinux/man/man3/getpidprevcon.3
> >  create mode 100644 libselinux/man/man3/getpidprevcon_raw.3
> >  create mode 100644 libselinux/utils/getpidprevcon.c
> >
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/=
selinux/selinux.h
> > index 47af9953..a0948853 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -54,6 +54,11 @@ extern int getpidcon_raw(pid_t pid, char ** con);
> >  extern int getprevcon(char ** con);
> >  extern int getprevcon_raw(char ** con);
> >
> > +/* Get previous context (prior to last exec) of process identified by =
pid, and
> > +   set *con to refer to it.  Caller must free via freecon. */
> > +extern int getpidprevcon(pid_t pid, char ** con);
> > +extern int getpidprevcon_raw(pid_t pid, char ** con);
> > +
> >  /* Get exec context, and set *con to refer to it.
> >     Sets *con to NULL if no exec context has been set, i.e. using defau=
lt.
> >     If non-NULL, caller must free via freecon. */
> > diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.=
3
> > index e7e394f3..38da958b 100644
> > --- a/libselinux/man/man3/getcon.3
> > +++ b/libselinux/man/man3/getcon.3
> > @@ -23,6 +23,10 @@ setcon \- set current security context of a process
> >  .sp
> >  .BI "int getpidcon_raw(pid_t " pid ", char **" context );
> >  .sp
> > +.BI "int getpidprevcon(pid_t " pid ", char **" context );
> > +.sp
> > +.BI "int getpidprevcon_raw(pid_t " pid ", char **" context );
> > +.sp
> >  .BI "int getpeercon(int " fd ", char **" context );
> >  .sp
> >  .BI "int getpeercon_raw(int " fd ", char **" context );
> > @@ -50,6 +54,11 @@ same as getcon but gets the context before the last =
exec.
> >  returns the process context for the specified PID, which must be free'=
d with
> >  .BR freecon ().
> >
> > +.TP
> > +.BR getpidprevcon ()
> > +returns the process context before the last exec for the specified PID=
, which must be free'd with
> > +.BR freecon ().
> > +
> >  .TP
> >  .BR getpeercon ()
> >  retrieves the context of the peer socket, which must be free'd with
> > diff --git a/libselinux/man/man3/getpidprevcon.3 b/libselinux/man/man3/=
getpidprevcon.3
> > new file mode 100644
> > index 00000000..1210b5a0
> > --- /dev/null
> > +++ b/libselinux/man/man3/getpidprevcon.3
> > @@ -0,0 +1 @@
> > +.so man3/getcon.3
> > diff --git a/libselinux/man/man3/getpidprevcon_raw.3 b/libselinux/man/m=
an3/getpidprevcon_raw.3
> > new file mode 100644
> > index 00000000..1210b5a0
> > --- /dev/null
> > +++ b/libselinux/man/man3/getpidprevcon_raw.3
> > @@ -0,0 +1 @@
> > +.so man3/getcon.3
> > diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> > index 6f4cfb82..b7a93a2b 100644
> > --- a/libselinux/src/procattr.c
> > +++ b/libselinux/src/procattr.c
> > @@ -300,3 +300,21 @@ int getpidcon(pid_t pid, char **c)
> >         }
> >         return getprocattrcon(c, pid, "current", NULL);
> >  }
> > +
> > +int getpidprevcon_raw(pid_t pid, char **c)
> > +{
> > +        if (pid <=3D 0) {
> > +                errno =3D EINVAL;
> > +                return -1;
> > +        }
> > +        return getprocattrcon_raw(c, pid, "prev", NULL);
> > +}
> > +
> > +int getpidprevcon(pid_t pid, char **c)
> > +{
> > +        if (pid <=3D 0) {
> > +                errno =3D EINVAL;
> > +                return -1;
> > +        }
> > +        return getprocattrcon(c, pid, "prev", NULL);
> > +}
> > diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> > index 3ef34374..b19b94a8 100644
> > --- a/libselinux/utils/.gitignore
> > +++ b/libselinux/utils/.gitignore
> > @@ -9,6 +9,7 @@ getdefaultcon
> >  getenforce
> >  getfilecon
> >  getpidcon
> > +getpidprevcon
> >  getsebool
> >  getseuser
> >  matchpathcon
> > diff --git a/libselinux/utils/getpidprevcon.c b/libselinux/utils/getpid=
prevcon.c
> > new file mode 100644
> > index 00000000..662ad500
> > --- /dev/null
> > +++ b/libselinux/utils/getpidprevcon.c
> > @@ -0,0 +1,33 @@
> > +#include <unistd.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +#include <selinux/selinux.h>
> > +
> > +int main(int argc, char **argv)
> > +{
> > +       pid_t pid;
> > +       char *buf;
> > +       int rc;
> > +
> > +       if (argc !=3D 2) {
> > +               fprintf(stderr, "usage:  %s pid\n", argv[0]);
> > +               exit(1);
> > +       }
> > +
> > +       if (sscanf(argv[1], "%d", &pid) !=3D 1) {
> > +               fprintf(stderr, "%s:  invalid pid %s\n", argv[0], argv[=
1]);
> > +               exit(2);
> > +       }
> > +
> > +       rc =3D getpidprevcon(pid, &buf);
> > +       if (rc < 0) {
> > +               fprintf(stderr, "%s:  getpidprevcon() failed:  %s\n", a=
rgv[0], strerror(errno));
> > +               exit(3);
> > +       }
> > +
> > +       printf("%s\n", buf);
> > +       freecon(buf);
> > +       exit(EXIT_SUCCESS);
> > +}
> > --
> > 2.39.0
> >
