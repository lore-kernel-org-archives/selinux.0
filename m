Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0071EC282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98422072E
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BelwyRgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgAJOoH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:44:07 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42386 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgAJOoH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 09:44:07 -0500
Received: by mail-ua1-f68.google.com with SMTP id u17so794445uap.9
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 06:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JnbpFn6v3p0QqofrMX4Z914uP7FOJebU03XatNFBCg4=;
        b=BelwyRgzoghgB9ADYTv3Ap1omboLfFONmjPaueWaL5L7Xxf9iTj3ZxP7IsfSLmZmLj
         Mai70SUfosont4ddkVB4rXeZk0wVJDS+Hc57jYVphkvHxGUHnsvrtq7XFK+gQQ567dkD
         A9SlEsixLt9bQ5z4dhkLfSPlKGuDuUH6J/yzEcmGMKmTECst+yzbmVQalKGHDKsYX4N4
         YyadWTWmZ7LwsFCMj5huvC5ZrJ88Q9MeBwncZ0pi65FMSI67V4SLLmuXjNEgsaYHXTc5
         1VONMSfOM4TyrLh1PFBJiyQaTWz0hDvNjXizip2H5uz/DvmZuSW5y+o9FBvVTqP4zofi
         H9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JnbpFn6v3p0QqofrMX4Z914uP7FOJebU03XatNFBCg4=;
        b=Ii9q3r7eHOvHev5r3rLFFkeJpzkPz4bQuXg64hs3AdwOiXfktNMATnAlw1mhNMZRbi
         LHw1H/h74WFR7SGONXr/YAA0h1Gs8L/hbbwUEF7TwcLdGLQFDcub26fwhCDwa1T1w4SB
         DJGHlMFqwpNHPouH5nsMQfryur5HbhI9WdA/nwXJTWE0Gc05TYDfWTx0YD8vnplxS4GU
         +SzXMebCGQ5Nl+QBlrIhVDobrtXSgzH2shY36plFtb8KpYelzIXSboYIC/iWGts6lOLP
         WJ1Ue4FD3iJCLdcjHoIjW2zj9R6bLIn9DuCFOheu1Fvf/VfmlYUaG1ludear9oCVZSM0
         w79w==
X-Gm-Message-State: APjAAAWzVOYZxKRCsiyPy1tlHxvvVQjujk0ub6myzKEtwugTj4L6CS83
        oKN3VDhdls+ty439U+up0lEuWTxyjJG9+5HMtWZFjaHpx1I=
X-Google-Smtp-Source: APXvYqwetErhbX4bjx9IrVCuKbKTe4I3vfHtTjIhL3d8aXC/nJphV7GphndqW2dqPfW80aClY07Xx+/dCXUyfRduBVY=
X-Received: by 2002:ab0:74ce:: with SMTP id f14mr2192961uaq.118.1578667446063;
 Fri, 10 Jan 2020 06:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20200110141509.21098-1-cgzones@googlemail.com>
 <20200110141509.21098-3-cgzones@googlemail.com> <7a4f539c-496d-ad3b-f937-604fda594ee3@tycho.nsa.gov>
In-Reply-To: <7a4f539c-496d-ad3b-f937-604fda594ee3@tycho.nsa.gov>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 10 Jan 2020 15:43:55 +0100
Message-ID: <CAJ2a_DfK4BjJOmQfjbg0zXcFxWB2B+7_p9gvp6tEKd=fzOuS+g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] libselinux: add security_is_policy_capabilty_enabled()
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Fr., 10. Jan. 2020 um 15:29 Uhr schrieb Stephen Smalley <sds@tycho.nsa.g=
ov>:
>
> On 1/10/20 9:15 AM, Christian G=C3=B6ttsche wrote:
> > Allow userspace (e.g. object managers like systemd) to obtain the state=
 of a policy capability via a library call.
> > ---
> >   libselinux/include/selinux/selinux.h          |  3 +
> >   .../security_is_policy_capability_enabled.3   | 27 ++++++++
> >   libselinux/src/polcap.c                       | 64 ++++++++++++++++++=
+
> >   libselinux/src/selinux_internal.h             |  1 +
> >   libselinux/src/selinuxswig_python_exception.i |  9 +++
> >   5 files changed, 104 insertions(+)
> >   create mode 100644 libselinux/man/man3/security_is_policy_capability_=
enabled.3
> >   create mode 100644 libselinux/src/polcap.c
> >
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/=
selinux/selinux.h
> > index fe46e681..b46f152d 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -354,6 +354,9 @@ extern int security_disable(void);
> >   /* Get the policy version number. */
> >   extern int security_policyvers(void);
> >
> > +/* Get the state of a policy capability. */
> > +extern int security_is_policy_capability_enabled(const char *name);
>
> Not sure if this should be security_ or selinux_.  Historically, we
> originally used security_ as the prefix for security server interfaces
> (e.g. security_compute_av), avc_ as the prefix for AVC interfaces, and
> no prefix at all for various other interfaces (e.g. getcon, getfilecon).
>   Then people pointed out the potential for name collisions (even more
> so in a multi-LSM world) and we started using selinux_ prefixes (but not
> consistently).  I'm ok either way but thought I'd mention it.
>

I'll think about it..

> > +
> >   /* Get the boolean names */
> >   extern int security_get_boolean_names(char ***names, int *len);
> >
> > diff --git a/libselinux/man/man3/security_is_policy_capability_enabled.=
3 b/libselinux/man/man3/security_is_policy_capability_enabled.3
> > new file mode 100644
> > index 00000000..18c53b67
> > --- /dev/null
> > +++ b/libselinux/man/man3/security_is_policy_capability_enabled.3
> > @@ -0,0 +1,27 @@
> > +.TH "security_is_policy_capability_enabled" "3" "9 January 2020" "cgzo=
nes@googlemail.com" "SELinux API documentation"
> > +.SH "NAME"
> > +security_is_policy_capability_enabled \- get the state of a SELinux po=
licy
> > +capability
> > +.
> > +.SH "SYNOPSIS"
> > +.B #include <selinux/selinux.h>
> > +.sp
> > +.BI "int security_is_policy_capability_enabled(const char *" name ");"
> > +.
> > +.SH "DESCRIPTION"
> > +.BR security_is_policy_capability_enabled ()
> > +returns 1 if the SELinux policy capability with the given name is enab=
led,
> > +0 if it is disabled, and \-1 on error.
> > +.SH "NOTES"
> > +The parameter
> > +.IR name
> > +is case insensitive.
>
> Why support case-insensitivity?  It complicates the implementation and
> seems unnecessary.
>

sepol_polcap_getnum() does it:
https://github.com/SELinuxProject/selinux/blob/5bbe32a7e585dcd403739ea55a2f=
b25cbd184383/libsepol/src/polcaps.c#L25

>
> > +
> > +If the the current kernel does not support the given policy capability=
 \-1 is returned and
> > +.BR errno
> > +is set to
> > +.BR ENOTSUP
> > +\&.
> > +.
> > +.SH "SEE ALSO"
> > +.BR selinux "(8)"
> > diff --git a/libselinux/src/polcap.c b/libselinux/src/polcap.c
> > new file mode 100644
> > index 00000000..801231cf
> > --- /dev/null
> > +++ b/libselinux/src/polcap.c
> > @@ -0,0 +1,64 @@
> > +#include <dirent.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <limits.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <sys/types.h>
> > +#include <unistd.h>
> > +
> > +#include "policy.h"
> > +#include "selinux_internal.h"
> > +
> > +int security_is_policy_capability_enabled(const char *name)
> > +{
> > +     int fd, enabled;
> > +     ssize_t ret;
> > +     char path[PATH_MAX];
> > +     char buf[20];
> > +     DIR *polcapdir;
> > +     struct dirent *dentry;
> > +
> > +     if (!selinux_mnt) {
> > +             errno =3D ENOENT;
> > +             return -1;
> > +     }
> > +
> > +     snprintf(path, sizeof path, "%s/policy_capabilities", selinux_mnt=
);
> > +     polcapdir =3D opendir(path);
> > +     if (!polcapdir)
> > +             return -1;
> > +
> > +     while ((dentry =3D readdir(polcapdir)) !=3D NULL) {
> > +             if (strcmp(dentry->d_name, ".") =3D=3D 0 || strcmp(dentry=
->d_name, "..") =3D=3D 0)
> > +                     continue;
> > +
> > +             if (strcasecmp(name, dentry->d_name) !=3D 0)
> > +                     continue;
> > +
> > +             snprintf(path, sizeof path, "%s/policy_capabilities/%s", =
selinux_mnt, dentry->d_name);
> > +             fd =3D open(path, O_RDONLY | O_CLOEXEC);
> > +             if (fd < 0)
> > +                 goto err;
>
> If you weren't trying to support case-insensitivity, you could just
> directly open() the capability file and be done with it.
>

Would we need to check for directory traversals in that case?
char *tainted_userdata =3D "../../../../etc/passwd"
security_is_policy_capability_enabled(tainted_userdata)

>
> > +
> > +             memset(buf, 0, sizeof buf);
> > +             ret =3D read(fd, buf, sizeof buf - 1);
> > +             close(fd);
> > +             if (ret < 0)
> > +                     goto err;
> > +
> > +             if (sscanf(buf, "%d", &enabled) !=3D 1)
> > +                     goto err;
> > +
> > +             closedir(polcapdir);
> > +             return !!enabled;
> > +     }
> > +
> > +     if (errno =3D=3D 0)
> > +             errno =3D ENOTSUP;
> > +err:
> > +     closedir(polcapdir);
> > +     return -1;
> > +}
> > +
> > +hidden_def(security_is_policy_capability_enabled)
>
> The hidden_proto/hidden_def declarations are for libselinux functions
> that are called by libselinux itself, to provide an internal symbol for
> it and thereby avoid the cost and confusion of supporting libselinux
> using some other .so's definition of it.  So unless you put a call to it
> somewhere inside libselinux, you don't need this.
>

Ok, I'll drop it.

> > diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux=
_internal.h
> > index 8b4bed2f..7ca1c329 100644
> > --- a/libselinux/src/selinux_internal.h
> > +++ b/libselinux/src/selinux_internal.h
> > @@ -9,6 +9,7 @@ hidden_proto(selinux_mkload_policy)
> >       hidden_proto(security_disable)
> >       hidden_proto(security_policyvers)
> >       hidden_proto(security_load_policy)
> > +    hidden_proto(security_is_policy_capability_enabled)
>
> Ditto
>
> >       hidden_proto(security_get_boolean_active)
> >       hidden_proto(security_get_boolean_names)
> >       hidden_proto(security_set_boolean)
> > diff --git a/libselinux/src/selinuxswig_python_exception.i b/libselinux=
/src/selinuxswig_python_exception.i
> > index cf658259..bd107295 100644
> > --- a/libselinux/src/selinuxswig_python_exception.i
> > +++ b/libselinux/src/selinuxswig_python_exception.i
> > @@ -665,6 +665,15 @@
> >   }
> >
> >
> > +%exception security_is_policy_capability_enabled {
> > +  $action
> > +  if (result < 0) {
> > +     PyErr_SetFromErrno(PyExc_OSError);
> > +     SWIG_fail;
> > +  }
> > +}
> > +
> > +
> >   %exception security_get_boolean_names {
> >     $action
> >     if (result < 0) {
> >
>
