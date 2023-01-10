Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F4BC46467
	for <selinux@archiver.kernel.org>; Tue, 10 Jan 2023 14:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjAJOWG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Jan 2023 09:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238486AbjAJOVs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Jan 2023 09:21:48 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA525473D
        for <selinux@vger.kernel.org>; Tue, 10 Jan 2023 06:21:41 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id jn22so13283652plb.13
        for <selinux@vger.kernel.org>; Tue, 10 Jan 2023 06:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMCpzwCS7vIxc/oweq/zmeu/blQAYFGHLhBvVqIKSUE=;
        b=bYKvWZ63q2S2plE48fh7qc0Doe5MgQY528bRkztU8J+h8LSf9McTp3sFeRXgHl4qzN
         X312LmSjR40d8YAEa6YRWYVLUvBgBJe1yAz70UTaeMrG0+bEczX6vSLhOl1SnFEpc7hR
         x42J5An1H6lAuWzQ+DEa0k3idTe0pRCktfmmT5bzO4NZ5jLpyuLxbt1Yf0YJin0CssG4
         GgrKLowgV7V8tQwbUFZR++2lHwP2C4TWNzYlvwb53A90CcwAJid9Iwq6HI6yXugnSTLL
         u2NE9FeTNUPL0YqAVt0F4t+uAteCp43OnnNbt225w0IEPLfx4sz6gRJw15c0qME3hyJX
         PJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMCpzwCS7vIxc/oweq/zmeu/blQAYFGHLhBvVqIKSUE=;
        b=2ElBP59Fxe7Wt2y7/HQlShlhElgTUB1z7IeMwjLJ1ErUz9f2g+kZJUXRwDNK1fHaUa
         HTLg3RdRQh1ZrPgZElrZ4fcbPwH/hxStdw0QfofcMCOyP7SjwINTldP5HF29mP21LQjj
         +4hDryvDp19/mppvHiu2h6nMlM/X+3VnU7TahnZ+WQY1l6Xua1q+cWFSPueanS2Adtci
         au2nGrhcZswv63pm5PFcaMR/B5c0ycC4MSH6ZMlopEW0hs+U9BfDKUW4AGXk5XmUwJn2
         KOGuoX70ZB1kZ2hTjbuBdsPa4/czp03BQjC0Zn9xPInohJr8OOdsS8sD5YKlbrSetfVd
         rDJA==
X-Gm-Message-State: AFqh2kpoe1BKOjBnp3QmnW/K2vN/CPZQ8bUjZQ+qvr3IalYQMBCA6nv9
        yQEwYbmHlewrIw5LOqx7DkBPkpw/BIEVl9MYxZW0B4xy
X-Google-Smtp-Source: AMrXdXt0GzTRpR0mr2m31g4I4o8S+D5gfLkUw651XtRBRWQo0SheRvpqRUOhSJKe7EEylcVseQMdO4qfPdbeApcYY0k=
X-Received: by 2002:a17:90a:7785:b0:219:b8f8:9b80 with SMTP id
 v5-20020a17090a778500b00219b8f89b80mr3939204pjk.54.1673360501088; Tue, 10 Jan
 2023 06:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20230109170912.57887-1-cgzones@googlemail.com>
 <CAEjxPJ5acJtHwF=Gh2iNehERoJ5S5G2txwk3n7hVRGANwrZozg@mail.gmail.com> <CAJ2a_DeRPO8CKLyMYYc2MHdAnxAdFunts3YMHVG1p+i_7Fr2Tg@mail.gmail.com>
In-Reply-To: <CAJ2a_DeRPO8CKLyMYYc2MHdAnxAdFunts3YMHVG1p+i_7Fr2Tg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 10 Jan 2023 09:21:30 -0500
Message-ID: <CAEjxPJ6w__ESx2iEsjuHfp=eUAe7i9Myfqh-p9S2pzK4KcW0gw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add getpidprevcon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 10, 2023 at 9:14 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Tue, 10 Jan 2023 at 14:18, Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Jan 9, 2023 at 12:17 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Add the public interfaces getpidprevcon(3) and getpidprevcon_raw(3), =
and
> > > the utility getpidprevcon to gather the previous context before the l=
ast
> > > exec of a given process.
> >
> > Wondering if we should warn in the manual page for this and other
> > getpid*con() interfaces that they are inherently racy and therefore
> > should never be relied upon for security purposes.
>
> With "and other getpid*con() interfaces" do you mean just getpidcon(3)
> (and getpidcon_raw(3)), which is currently the only interface matching
> your regex and operating on a foreign process, or also getcon(3) and
> getprevcon(3)?
>
> With race conditions you mean the possibility of the target process
> changing its context (via setcon(3)) or querying a replaced process
> (which is mainly possible via spawning a new process after setting
> /proc/sys/kernel/ns_last_pid)?
> Or do you have others in mind?

Yes, just getpidcon/getpidcon_raw. And correct - the inherent race is
with respect to looking up a target process by pid,
when said process may potentially switch its context via setcon or
execve or exit and be replaced by a process of another context.
This was actually successfully done in Android against a service that
was using getpidcon() to obtain the context of the binder client
before support for passing contexts across binder IPC was added.


>
> p.s.:
> after the discussion has settled I'll send a v2 with the interfaces
> actually published in libselinux.map
>
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > >  libselinux/include/selinux/selinux.h    |  5 ++++
> > >  libselinux/man/man3/getcon.3            |  9 +++++++
> > >  libselinux/man/man3/getpidprevcon.3     |  1 +
> > >  libselinux/man/man3/getpidprevcon_raw.3 |  1 +
> > >  libselinux/src/procattr.c               | 18 ++++++++++++++
> > >  libselinux/utils/.gitignore             |  1 +
> > >  libselinux/utils/getpidprevcon.c        | 33 +++++++++++++++++++++++=
++
> > >  7 files changed, 68 insertions(+)
> > >  create mode 100644 libselinux/man/man3/getpidprevcon.3
> > >  create mode 100644 libselinux/man/man3/getpidprevcon_raw.3
> > >  create mode 100644 libselinux/utils/getpidprevcon.c
> > >
> > > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/includ=
e/selinux/selinux.h
> > > index 47af9953..a0948853 100644
> > > --- a/libselinux/include/selinux/selinux.h
> > > +++ b/libselinux/include/selinux/selinux.h
> > > @@ -54,6 +54,11 @@ extern int getpidcon_raw(pid_t pid, char ** con);
> > >  extern int getprevcon(char ** con);
> > >  extern int getprevcon_raw(char ** con);
> > >
> > > +/* Get previous context (prior to last exec) of process identified b=
y pid, and
> > > +   set *con to refer to it.  Caller must free via freecon. */
> > > +extern int getpidprevcon(pid_t pid, char ** con);
> > > +extern int getpidprevcon_raw(pid_t pid, char ** con);
> > > +
> > >  /* Get exec context, and set *con to refer to it.
> > >     Sets *con to NULL if no exec context has been set, i.e. using def=
ault.
> > >     If non-NULL, caller must free via freecon. */
> > > diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getco=
n.3
> > > index e7e394f3..38da958b 100644
> > > --- a/libselinux/man/man3/getcon.3
> > > +++ b/libselinux/man/man3/getcon.3
> > > @@ -23,6 +23,10 @@ setcon \- set current security context of a proces=
s
> > >  .sp
> > >  .BI "int getpidcon_raw(pid_t " pid ", char **" context );
> > >  .sp
> > > +.BI "int getpidprevcon(pid_t " pid ", char **" context );
> > > +.sp
> > > +.BI "int getpidprevcon_raw(pid_t " pid ", char **" context );
> > > +.sp
> > >  .BI "int getpeercon(int " fd ", char **" context );
> > >  .sp
> > >  .BI "int getpeercon_raw(int " fd ", char **" context );
> > > @@ -50,6 +54,11 @@ same as getcon but gets the context before the las=
t exec.
> > >  returns the process context for the specified PID, which must be fre=
e'd with
> > >  .BR freecon ().
> > >
> > > +.TP
> > > +.BR getpidprevcon ()
> > > +returns the process context before the last exec for the specified P=
ID, which must be free'd with
> > > +.BR freecon ().
> > > +
> > >  .TP
> > >  .BR getpeercon ()
> > >  retrieves the context of the peer socket, which must be free'd with
> > > diff --git a/libselinux/man/man3/getpidprevcon.3 b/libselinux/man/man=
3/getpidprevcon.3
> > > new file mode 100644
> > > index 00000000..1210b5a0
> > > --- /dev/null
> > > +++ b/libselinux/man/man3/getpidprevcon.3
> > > @@ -0,0 +1 @@
> > > +.so man3/getcon.3
> > > diff --git a/libselinux/man/man3/getpidprevcon_raw.3 b/libselinux/man=
/man3/getpidprevcon_raw.3
> > > new file mode 100644
> > > index 00000000..1210b5a0
> > > --- /dev/null
> > > +++ b/libselinux/man/man3/getpidprevcon_raw.3
> > > @@ -0,0 +1 @@
> > > +.so man3/getcon.3
> > > diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> > > index 6f4cfb82..b7a93a2b 100644
> > > --- a/libselinux/src/procattr.c
> > > +++ b/libselinux/src/procattr.c
> > > @@ -300,3 +300,21 @@ int getpidcon(pid_t pid, char **c)
> > >         }
> > >         return getprocattrcon(c, pid, "current", NULL);
> > >  }
> > > +
> > > +int getpidprevcon_raw(pid_t pid, char **c)
> > > +{
> > > +        if (pid <=3D 0) {
> > > +                errno =3D EINVAL;
> > > +                return -1;
> > > +        }
> > > +        return getprocattrcon_raw(c, pid, "prev", NULL);
> > > +}
> > > +
> > > +int getpidprevcon(pid_t pid, char **c)
> > > +{
> > > +        if (pid <=3D 0) {
> > > +                errno =3D EINVAL;
> > > +                return -1;
> > > +        }
> > > +        return getprocattrcon(c, pid, "prev", NULL);
> > > +}
> > > diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignor=
e
> > > index 3ef34374..b19b94a8 100644
> > > --- a/libselinux/utils/.gitignore
> > > +++ b/libselinux/utils/.gitignore
> > > @@ -9,6 +9,7 @@ getdefaultcon
> > >  getenforce
> > >  getfilecon
> > >  getpidcon
> > > +getpidprevcon
> > >  getsebool
> > >  getseuser
> > >  matchpathcon
> > > diff --git a/libselinux/utils/getpidprevcon.c b/libselinux/utils/getp=
idprevcon.c
> > > new file mode 100644
> > > index 00000000..662ad500
> > > --- /dev/null
> > > +++ b/libselinux/utils/getpidprevcon.c
> > > @@ -0,0 +1,33 @@
> > > +#include <unistd.h>
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +#include <errno.h>
> > > +#include <selinux/selinux.h>
> > > +
> > > +int main(int argc, char **argv)
> > > +{
> > > +       pid_t pid;
> > > +       char *buf;
> > > +       int rc;
> > > +
> > > +       if (argc !=3D 2) {
> > > +               fprintf(stderr, "usage:  %s pid\n", argv[0]);
> > > +               exit(1);
> > > +       }
> > > +
> > > +       if (sscanf(argv[1], "%d", &pid) !=3D 1) {
> > > +               fprintf(stderr, "%s:  invalid pid %s\n", argv[0], arg=
v[1]);
> > > +               exit(2);
> > > +       }
> > > +
> > > +       rc =3D getpidprevcon(pid, &buf);
> > > +       if (rc < 0) {
> > > +               fprintf(stderr, "%s:  getpidprevcon() failed:  %s\n",=
 argv[0], strerror(errno));
> > > +               exit(3);
> > > +       }
> > > +
> > > +       printf("%s\n", buf);
> > > +       freecon(buf);
> > > +       exit(EXIT_SUCCESS);
> > > +}
> > > --
> > > 2.39.0
> > >
