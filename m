Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2EDC7EE29
	for <selinux@archiver.kernel.org>; Thu,  8 Jun 2023 19:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjFHTwK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjFHTwJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Jun 2023 15:52:09 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B016F210C
        for <selinux@vger.kernel.org>; Thu,  8 Jun 2023 12:52:06 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b1aecef94fso10029261fa.3
        for <selinux@vger.kernel.org>; Thu, 08 Jun 2023 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686253925; x=1688845925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRDNCzC5hCBW/W4Obq7niQQBLc6sCz5jmFa5rQ7eVx0=;
        b=kzuOZ4AhDY0z4yGfIFm1yzDMn8nvAM7wnWlXtlS8Gp0IBBRbCR4IaY2/AHxaB18MBE
         H5zrDp3DI8TI+doZXMNDMoNk1rVt8Iu3vr9iGINGN/cvHZzd9nOvkbsxJzLMhR/AoRGx
         vRoogotKt+DBRO+TFwOAfPcQZVSgA75Erk6qjCaBb3dDZrBXntk/WwwN7ECg2xbMcI3D
         PDdcjk1dPiAQAB/b2VQwgtLLd3xisFtwaSrOhlHVlsJSli41fgt4nguOCqX6ek2QY7TB
         kbaPijh25SNND1at8F9Q3A+Csq7YQDixjp95zmgNi+4BOIGs3bvAOuePlN2EdjeX4+dQ
         xuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686253925; x=1688845925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRDNCzC5hCBW/W4Obq7niQQBLc6sCz5jmFa5rQ7eVx0=;
        b=ggc09X9CFq0M3dA9jeYmA2obxrfGvhcmp0Rif1bD5Q2yzFf09jaZZ3u6J2G3ZGWC3e
         zUDatEvuM32BzgmIS//2bXOmEUj6O2t0QLpg/UnxR4VfQ11qydNN75JU3jGSzBb1WYm6
         3K55D8I8TDjW13Fu+RbNoPTKUPlA5pRIQzkba8jYRAiJ4jOdPGSFb/uLkLzhQX6zf9Cz
         JRmUqt0bfUId5hzXCGURe1ncM07YFf7Vh2XOb1quYa3AWnrhSLRo4WkpxyEsC8fbB2vY
         NzqXhB2J3WlzOb+nu1hFxibKKanyApqas5wXV0rNRG/Qy/AnfzauHnOisp9I43DSO92T
         q6/g==
X-Gm-Message-State: AC+VfDxOvE1Vni3JEgguXjENQfG87ClkMgtXJ/QrAY9TR4pNA1t/hOt6
        QGfiw5++SY77YMhNkCVdO5S3tOmd2oI3qY0vcU2hbOlm
X-Google-Smtp-Source: ACHHUZ6NyB+8xgGK8OXCow+BD1FWYSDb2OKuHd9ZkBAQxuaaptZoVRYG89s+m2fiuUX/NAWyRuFLesO7Te9Nf+Nz2KQ=
X-Received: by 2002:a2e:b011:0:b0:2ad:996f:5d11 with SMTP id
 y17-20020a2eb011000000b002ad996f5d11mr4650712ljk.28.1686253924573; Thu, 08
 Jun 2023 12:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <87ttvsk0qx.fsf@redhat.com> <20230601143915.2051922-1-vmojzis@redhat.com>
 <87sfb5hv06.fsf@redhat.com>
In-Reply-To: <87sfb5hv06.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 8 Jun 2023 15:51:53 -0400
Message-ID: <CAP+JOzRJVk-5F5x3QRqwyjKAh3FACGJnhgzhEZ=a9-mMhB7HZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] policycoreutils: Add examples to man pages
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 6, 2023 at 4:19=E2=80=AFAM Petr Lautrbach <plautrba@redhat.com>=
 wrote:
>
> Vit Mojzis <vmojzis@redhat.com> writes:
>
> > While at it, remove trailing whitespaces.
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> >
>
> For these five patches:
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>
>
These five patches have been merged.
Thanks,
Jim

>
> > ---
> >  policycoreutils/scripts/fixfiles.8          | 34 +++++++++++++--------
> >  policycoreutils/secon/secon.1               | 12 ++++++--
> >  policycoreutils/semodule/semodule.8         | 14 ++++-----
> >  policycoreutils/setfiles/restorecon.8       |  9 ++++++
> >  policycoreutils/setfiles/restorecon_xattr.8 |  7 +++++
> >  policycoreutils/setfiles/setfiles.8         |  9 ++++++
> >  policycoreutils/setsebool/setsebool.8       | 16 +++++++---
> >  7 files changed, 74 insertions(+), 27 deletions(-)
> >
> > diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scrip=
ts/fixfiles.8
> > index 9a317d91..928b8200 100644
> > --- a/policycoreutils/scripts/fixfiles.8
> > +++ b/policycoreutils/scripts/fixfiles.8
> > @@ -14,7 +14,7 @@ fixfiles \- fix file SELinux security contexts.
> >  .B fixfiles
> >  .I [\-v] [\-F] [\-B | \-N time ] [\-T nthreads] { check | restore | ve=
rify }
> >
> > -.B fixfiles
> > +.B fixfiles
> >  .I [\-v] [\-F] [\-T nthreads] \-R rpmpackagename[,rpmpackagename...] {=
 check | restore | verify }
> >
> >  .B fixfiles
> > @@ -31,7 +31,7 @@ This manual page describes the
> >  script.
> >  .P
> >  This script is primarily used to correct the security context
> > -database (extended attributes) on filesystems.
> > +database (extended attributes) on filesystems.
> >  .P
> >  It can also be run at any time to relabel when adding support for
> >  new policy, or  just check whether the file contexts are all
> > @@ -41,29 +41,29 @@ option.  You can use the \-R flag to use rpmpackage=
s as an alternative.
> >  The file /etc/selinux/fixfiles_exclude_dirs can contain a list of dire=
ctories
> >  excluded from relabeling.
> >  .P
> > -.B fixfiles onboot
> > +.B fixfiles onboot
> >  will setup the machine to relabel on the next reboot.
> >
> >  .SH "OPTIONS"
> > -.TP
> > +.TP
> >  .B \-B
> >  If specified with onboot, this fixfiles will record the current date i=
n the /.autorelabel file, so that it can be used later to speed up labeling=
. If used with restore, the restore will only affect files that were modifi=
ed today.
> >  .TP
> >  .B \-F
> >  Force reset of context to match file_context for customizable files
> >
> > -.TP
> > +.TP
> >  .B \-f
> >  Clear /tmp directory with out prompt for removal.
> >
> > -.TP
> > +.TP
> >  .B \-R rpmpackagename[,rpmpackagename...]
> >  Use the rpm database to discover all files within the specified packag=
es and restore the file contexts.
> >  .TP
> >  .B \-C PREVIOUS_FILECONTEXT
> >  Run a diff on  the PREVIOUS_FILECONTEXT file to the currently installe=
d one, and restore the context of all affected files.
> >
> > -.TP
> > +.TP
> >  .B \-N time
> >  Only act on files created after the specified date.  Date must be spec=
ified in
> >  "YYYY\-MM\-DD HH:MM" format.  Date field will be passed to find \-\-ne=
wermt command.
> > @@ -83,19 +83,28 @@ Use parallel relabeling, see
> >
> >  .SH "ARGUMENTS"
> >  One of:
> > -.TP
> > +.TP
> >  .B check | verify
> >  print any incorrect file context labels, showing old and new context, =
but do not change them.
> > -.TP
> > +.TP
> >  .B restore
> >  change any incorrect file context labels.
> > -.TP
> > +.TP
> >  .B relabel
> >  Prompt for removal of contents of /tmp directory and then change any i=
ncorrect file context labels to match the install file_contexts file.
> > -.TP
> > -.B [[dir/file] ... ]
> > +.TP
> > +.B [[dir/file] ... ]
> >  List of files or directories trees that you wish to check file context=
 on.
> >
> > +.SH EXAMPLE
> > +.nf
> > +Relabel the whole filesystem, except paths listed in /etc/selinux/fixf=
iles_exclude_dirs
> > +# fixfiles relabel
> > +Schedule the machine to relabel on the next boot and force relabeling =
of customizable types
> > +# fixfiles -F onboot
> > +Check labeling of all files from the samba package (while not changing=
 any labels)
> > +# fixfiles -R samba check
> > +
> >  .SH "AUTHOR"
> >  This man page was written by Richard Hally <rhally@mindspring.com>.
> >  The script  was written by Dan Walsh <dwalsh@redhat.com>
> > @@ -103,4 +112,3 @@ The script  was written by Dan Walsh <dwalsh@redhat=
.com>
> >  .SH "SEE ALSO"
> >  .BR setfiles (8),
> >  .BR restorecon (8)
> > -
> > diff --git a/policycoreutils/secon/secon.1 b/policycoreutils/secon/seco=
n.1
> > index 501b5cb8..c0e8b05a 100644
> > --- a/policycoreutils/secon/secon.1
> > +++ b/policycoreutils/secon/secon.1
> > @@ -107,16 +107,24 @@ then the context will be read from stdin.
> >  .br
> >  If there is no argument,
> >  .B secon
> > -will try reading a context from stdin, if that is not a tty, otherwise
> > +will try reading a context from stdin, if that is not a tty, otherwise
> >  .B secon
> >  will act as though \fB\-\-self\fR had been passed.
> >  .PP
> >  If none of \fB\-\-user\fR, \fB\-\-role\fR, \fB\-\-type\fR, \fB\-\-leve=
l\fR or
> >  \fB\-\-mls\-range\fR is passed.
> >  Then all of them will be output.
> > +
> > +.SH EXAMPLE
> > +.nf
> > +Show SElinux context of the init process
> > +# secon --pid 1
> > +Parse the type portion of given security context
> > +# secon -t system_u:object_r:httpd_sys_rw_content_t:s0
> > +
> >  .PP
> >  .SH SEE ALSO
> >  .BR chcon (1)
> >  .SH AUTHORS
> >  .nf
> > -James Antill (james.antill@redhat.com)
> > +James Antill (james.antill@redhat.com)
> > diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semo=
dule/semodule.8
> > index c56e580f..01757b00 100644
> > --- a/policycoreutils/semodule/semodule.8
> > +++ b/policycoreutils/semodule/semodule.8
> > @@ -1,5 +1,5 @@
> >  .TH SEMODULE "8" "Nov 2005" "Security Enhanced Linux" NSA
> > -.SH NAME
> > +.SH NAME
> >  semodule \- Manage SELinux policy modules.
> >
> >  .SH SYNOPSIS
> > @@ -8,7 +8,7 @@ semodule \- Manage SELinux policy modules.
> >  .SH DESCRIPTION
> >  .PP
> >  semodule is the tool used to manage SELinux policy modules,
> > -including installing, upgrading, listing and removing modules.
> > +including installing, upgrading, listing and removing modules.
> >  semodule may also be used to force a rebuild of policy from the
> >  module store and/or to force a reload of policy without performing
> >  any other transaction.  semodule acts on module packages created
> > @@ -39,7 +39,7 @@ install/replace a module package
> >  .B  \-u,\-\-upgrade=3DMODULE_PKG
> >  deprecated, alias for --install
> >  .TP
> > -.B  \-b,\-\-base=3DMODULE_PKG
> > +.B  \-b,\-\-base=3DMODULE_PKG
> >  deprecated, alias for --install
> >  .TP
> >  .B  \-r,\-\-remove=3DMODULE_NAME
> > @@ -77,7 +77,7 @@ name of the store to operate on
> >  .B  \-n,\-\-noreload,\-N
> >  do not reload policy after commit
> >  .TP
> > -.B  \-h,\-\-help
> > +.B  \-h,\-\-help
> >  prints help message and quit
> >  .TP
> >  .B \-P,\-\-preserve_tunables
> > @@ -92,7 +92,7 @@ Use an alternate path for the policy root
> >  .B \-S,\-\-store-path
> >  Use an alternate path for the policy store root
> >  .TP
> > -.B  \-v,\-\-verbose
> > +.B  \-v,\-\-verbose
> >  be verbose
> >  .TP
> >  .B  \-c,\-\-cil
> > @@ -131,8 +131,6 @@ $ semodule \-B
> >  $ semodule \-d alsa
> >  # Install a module at a specific priority.
> >  $ semodule \-X 100 \-i alsa.pp
> > -# List all modules.
> > -$ semodule \-\-list=3Dfull
> >  # Set an alternate path for the policy root
> >  $ semodule \-B \-p "/tmp"
> >  # Set an alternate path for the policy store root
> > @@ -143,6 +141,8 @@ $ semodule \-X 400 \-\-hll \-E puppet \-\-cil \-E w=
ireshark
> >  # Check whether a module in "localmodule.pp" file is same as installed=
 module "localmodule"
> >  $ /usr/libexec/selinux/hll/pp localmodule.pp | sha256sum
> >  $ semodule -l -m | grep localmodule
> > +# Translate binary module file into CIL (useful for debugging installa=
tion errors)
> > +$ /usr/libexec/selinux/hll/pp alsa.pp > alsa.cil
> >  .fi
> >
> >  .SH SEE ALSO
> > diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/se=
tfiles/restorecon.8
> > index e07db2c8..c3cc5c9b 100644
> > --- a/policycoreutils/setfiles/restorecon.8
> > +++ b/policycoreutils/setfiles/restorecon.8
> > @@ -224,6 +224,15 @@ and provided the
> >  option is NOT set and recursive mode is set, files will be relabeled a=
s
> >  required with the digests then being updated provided there are no err=
ors.
> >
> > +.SH EXAMPLE
> > +.nf
> > +Fix labeling of /var/www/ including all sub-directories and list all c=
ontext changes
> > +# restorecon -rv /var/www/
> > +List mislabeled files in user home directory and what the correct labe=
l should be
> > +# restorecon -nvr ~
> > +Fix labeling of files listed in file_list file, ignoring any that do n=
ot exist
> > +# restorecon -vif file_list
> > +
> >  .SH "AUTHOR"
> >  This man page was written by Dan Walsh <dwalsh@redhat.com>.
> >  Some of the content of this man page was taken from the setfiles
> > diff --git a/policycoreutils/setfiles/restorecon_xattr.8 b/policycoreut=
ils/setfiles/restorecon_xattr.8
> > index e04528e6..51d12a4d 100644
> > --- a/policycoreutils/setfiles/restorecon_xattr.8
> > +++ b/policycoreutils/setfiles/restorecon_xattr.8
> > @@ -112,6 +112,13 @@ If the option is not specified, then the default f=
ile_contexts will be used.
> >  .br
> >  the pathname of the directory tree to be searched.
> >
> > +.SH EXAMPLE
> > +.nf
> > +List all paths that where assigned a checksum by "restorecon/setfiles =
-D"
> > +# restorecon_xattr -r /
> > +Remove all non-matching checksums
> > +# restorecon_xattr -rd /
> > +
> >  .SH "SEE ALSO"
> >  .BR restorecon (8),
> >  .BR setfiles (8)
> > diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setf=
iles/setfiles.8
> > index bf26e161..892a5062 100644
> > --- a/policycoreutils/setfiles/setfiles.8
> > +++ b/policycoreutils/setfiles/setfiles.8
> > @@ -289,6 +289,15 @@ and provided the
> >  option is NOT set, files will be relabeled as required with the digest=
s then
> >  being updated provided there are no errors.
> >
> > +.SH EXAMPLE
> > +.nf
> > +Fix labeling of /var/www/ including all sub-directories, using targete=
d policy file context definitions and list all context changes
> > +# setfiles -v /etc/selinux/targeted/contexts/files/file_contexts /var/=
www/
> > +List mislabeled files in user home directory and what the label should=
 be based on targeted policy file context definitions
> > +# setfiles -nv /etc/selinux/targeted/contexts/files/file_contexts ~
> > +Fix labeling of files listed in file_list file, ignoring any that do n=
ot exist
> > +# setfiles -vif file_list /etc/selinux/targeted/contexts/files/file_co=
ntexts
> > +
> >  .SH "AUTHOR"
> >  This man page was written by Russell Coker <russell@coker.com.au>.
> >  The program was written by Stephen Smalley <sds@tycho.nsa.gov>
> > diff --git a/policycoreutils/setsebool/setsebool.8 b/policycoreutils/se=
tsebool/setsebool.8
> > index 52936f5a..f54664fb 100644
> > --- a/policycoreutils/setsebool/setsebool.8
> > +++ b/policycoreutils/setsebool/setsebool.8
> > @@ -7,13 +7,13 @@ setsebool \- set SELinux boolean value
> >  .I "[ \-PNV ] boolean value | bool1=3Dval1 bool2=3Dval2 ..."
> >
> >  .SH "DESCRIPTION"
> > -.B setsebool
> > -sets the current state of a particular SELinux boolean or a list of bo=
oleans
> > -to a given value. The value may be 1 or true or on to enable the boole=
an, or 0 or false or off to disable it.
> > +.B setsebool
> > +sets the current state of a particular SELinux boolean or a list of bo=
oleans
> > +to a given value. The value may be 1 or true or on to enable the boole=
an, or 0 or false or off to disable it.
> >
> >  Without the \-P option, only the current boolean value is
> > -affected; the boot-time default settings
> > -are not changed.
> > +affected; the boot-time default settings
> > +are not changed.
> >
> >  If the \-P option is given, all pending values are written to
> >  the policy file on disk. So they will be persistent across reboots.
> > @@ -22,6 +22,12 @@ If the \-N option is given, the policy on disk is no=
t reloaded into the kernel.
> >
> >  If the \-V option is given, verbose error messages will be printed fro=
m semanage libraries.
> >
> > +.SH EXAMPLE
> > +.nf
> > +Enable container_use_devices boolean (will return to persistent value =
after reboot)
> > +# setsebool container_use_devices 1
> > +Persistently enable samba_create_home_dirs and samba_enable_home_dirs =
booleans
> > +# setsebool -P samba_create_home_dirs=3Don samba_enable_home_dirs=3Don
> >
> >  .SH AUTHOR
> >  This manual page was written by Dan Walsh <dwalsh@redhat.com>.
> > --
> > 2.40.0
>
