Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB016C46467
	for <selinux@archiver.kernel.org>; Tue, 10 Jan 2023 13:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjAJNSm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjAJNSI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Jan 2023 08:18:08 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067961012
        for <selinux@vger.kernel.org>; Tue, 10 Jan 2023 05:18:07 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so16481178pjq.1
        for <selinux@vger.kernel.org>; Tue, 10 Jan 2023 05:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGpQm2VL/txkcEYC2SwEnnMTl/2Klis64AlkIKJICgs=;
        b=A1zbmPpFQ6QzxoPKuIZjHTnWxj2Mpzy819jGwB7JTv0xEKa4DWP1THA9ENc77beWos
         mfQCiAuAxTQTaBo+VtFltvge7EAUTMgOv7lo9PMP3uW9RHvI7IXy2MIeC0IuzGo58CaY
         vX5VXyzYjVXjgLz75hwhOo8W45aoOoIPKdWjcalqZk/LkL/dYgSMStu7pSI6Xj4JDCRZ
         A7ntOkgXfauF9blwzuWrBRf0VpUH/76ScR5Eqe9hE5fT7TyYyKWJda07tEIhnqJ2C2Cf
         4tHjhI0213yKQOb4TLkHMuw4lldSuEY0uWshZlYdthB1W9ZXVJx029at+6CUaFGyZyaW
         Qciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGpQm2VL/txkcEYC2SwEnnMTl/2Klis64AlkIKJICgs=;
        b=a65dql13HrwsHZce1BG81DpSCNICnlCEflsZxVjoeBaczQgGEcv6CHo+1L24bJcF3+
         rwB+gHE1b+wHuZXE0qjm9fztYi84GBXDqPIoSEZkxrNAKQeD8Z9GN19LxbcQd8lh5oYV
         VZm07ITQi6aWZLTb+aP6ku0HImEJD/479iF3a0pCnx/c93cHaDpWA1MtWRLSShBxVYmt
         rk/OGOSckesqmfQz2pIxur2d/xZUcAINySy2Dr4B93TV4SYk5wj9Yxv1d3P66uqK4rZ8
         vrgAU7RRrGK7Rkidjgaw8mmbVpMoRXqFGDwTM2/h7cypgugu/YeV7pr5qMxHGo5YW9GM
         qXHg==
X-Gm-Message-State: AFqh2kowzlD8Un7b+TUmh0aXCZD21VsFj2qUymrLFKBO8edqPMZ8tN1S
        9atdJB1jhFPghFEiDwaADtz0KqASydsG5LeRoO2gLam8
X-Google-Smtp-Source: AMrXdXvHS4FybSUZovWx8ArVpg/7P8Rf1DlsnwltgehCxip7TYi1p3opqeaOC7SXH0PcWN5MVePFaSPcC+WcblR9V/E=
X-Received: by 2002:a17:902:f813:b0:193:3a9b:8290 with SMTP id
 ix19-20020a170902f81300b001933a9b8290mr330252plb.144.1673356686347; Tue, 10
 Jan 2023 05:18:06 -0800 (PST)
MIME-Version: 1.0
References: <20230109170912.57887-1-cgzones@googlemail.com>
In-Reply-To: <20230109170912.57887-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 10 Jan 2023 08:17:55 -0500
Message-ID: <CAEjxPJ5acJtHwF=Gh2iNehERoJ5S5G2txwk3n7hVRGANwrZozg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add getpidprevcon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 9, 2023 at 12:17 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add the public interfaces getpidprevcon(3) and getpidprevcon_raw(3), and
> the utility getpidprevcon to gather the previous context before the last
> exec of a given process.

Wondering if we should warn in the manual page for this and other
getpid*con() interfaces that they are inherently racy and therefore
should never be relied upon for security purposes.

>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/include/selinux/selinux.h    |  5 ++++
>  libselinux/man/man3/getcon.3            |  9 +++++++
>  libselinux/man/man3/getpidprevcon.3     |  1 +
>  libselinux/man/man3/getpidprevcon_raw.3 |  1 +
>  libselinux/src/procattr.c               | 18 ++++++++++++++
>  libselinux/utils/.gitignore             |  1 +
>  libselinux/utils/getpidprevcon.c        | 33 +++++++++++++++++++++++++
>  7 files changed, 68 insertions(+)
>  create mode 100644 libselinux/man/man3/getpidprevcon.3
>  create mode 100644 libselinux/man/man3/getpidprevcon_raw.3
>  create mode 100644 libselinux/utils/getpidprevcon.c
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index 47af9953..a0948853 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -54,6 +54,11 @@ extern int getpidcon_raw(pid_t pid, char ** con);
>  extern int getprevcon(char ** con);
>  extern int getprevcon_raw(char ** con);
>
> +/* Get previous context (prior to last exec) of process identified by pi=
d, and
> +   set *con to refer to it.  Caller must free via freecon. */
> +extern int getpidprevcon(pid_t pid, char ** con);
> +extern int getpidprevcon_raw(pid_t pid, char ** con);
> +
>  /* Get exec context, and set *con to refer to it.
>     Sets *con to NULL if no exec context has been set, i.e. using default=
.
>     If non-NULL, caller must free via freecon. */
> diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
> index e7e394f3..38da958b 100644
> --- a/libselinux/man/man3/getcon.3
> +++ b/libselinux/man/man3/getcon.3
> @@ -23,6 +23,10 @@ setcon \- set current security context of a process
>  .sp
>  .BI "int getpidcon_raw(pid_t " pid ", char **" context );
>  .sp
> +.BI "int getpidprevcon(pid_t " pid ", char **" context );
> +.sp
> +.BI "int getpidprevcon_raw(pid_t " pid ", char **" context );
> +.sp
>  .BI "int getpeercon(int " fd ", char **" context );
>  .sp
>  .BI "int getpeercon_raw(int " fd ", char **" context );
> @@ -50,6 +54,11 @@ same as getcon but gets the context before the last ex=
ec.
>  returns the process context for the specified PID, which must be free'd =
with
>  .BR freecon ().
>
> +.TP
> +.BR getpidprevcon ()
> +returns the process context before the last exec for the specified PID, =
which must be free'd with
> +.BR freecon ().
> +
>  .TP
>  .BR getpeercon ()
>  retrieves the context of the peer socket, which must be free'd with
> diff --git a/libselinux/man/man3/getpidprevcon.3 b/libselinux/man/man3/ge=
tpidprevcon.3
> new file mode 100644
> index 00000000..1210b5a0
> --- /dev/null
> +++ b/libselinux/man/man3/getpidprevcon.3
> @@ -0,0 +1 @@
> +.so man3/getcon.3
> diff --git a/libselinux/man/man3/getpidprevcon_raw.3 b/libselinux/man/man=
3/getpidprevcon_raw.3
> new file mode 100644
> index 00000000..1210b5a0
> --- /dev/null
> +++ b/libselinux/man/man3/getpidprevcon_raw.3
> @@ -0,0 +1 @@
> +.so man3/getcon.3
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index 6f4cfb82..b7a93a2b 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -300,3 +300,21 @@ int getpidcon(pid_t pid, char **c)
>         }
>         return getprocattrcon(c, pid, "current", NULL);
>  }
> +
> +int getpidprevcon_raw(pid_t pid, char **c)
> +{
> +        if (pid <=3D 0) {
> +                errno =3D EINVAL;
> +                return -1;
> +        }
> +        return getprocattrcon_raw(c, pid, "prev", NULL);
> +}
> +
> +int getpidprevcon(pid_t pid, char **c)
> +{
> +        if (pid <=3D 0) {
> +                errno =3D EINVAL;
> +                return -1;
> +        }
> +        return getprocattrcon(c, pid, "prev", NULL);
> +}
> diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> index 3ef34374..b19b94a8 100644
> --- a/libselinux/utils/.gitignore
> +++ b/libselinux/utils/.gitignore
> @@ -9,6 +9,7 @@ getdefaultcon
>  getenforce
>  getfilecon
>  getpidcon
> +getpidprevcon
>  getsebool
>  getseuser
>  matchpathcon
> diff --git a/libselinux/utils/getpidprevcon.c b/libselinux/utils/getpidpr=
evcon.c
> new file mode 100644
> index 00000000..662ad500
> --- /dev/null
> +++ b/libselinux/utils/getpidprevcon.c
> @@ -0,0 +1,33 @@
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <selinux/selinux.h>
> +
> +int main(int argc, char **argv)
> +{
> +       pid_t pid;
> +       char *buf;
> +       int rc;
> +
> +       if (argc !=3D 2) {
> +               fprintf(stderr, "usage:  %s pid\n", argv[0]);
> +               exit(1);
> +       }
> +
> +       if (sscanf(argv[1], "%d", &pid) !=3D 1) {
> +               fprintf(stderr, "%s:  invalid pid %s\n", argv[0], argv[1]=
);
> +               exit(2);
> +       }
> +
> +       rc =3D getpidprevcon(pid, &buf);
> +       if (rc < 0) {
> +               fprintf(stderr, "%s:  getpidprevcon() failed:  %s\n", arg=
v[0], strerror(errno));
> +               exit(3);
> +       }
> +
> +       printf("%s\n", buf);
> +       freecon(buf);
> +       exit(EXIT_SUCCESS);
> +}
> --
> 2.39.0
>
