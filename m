Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6568FC001DE
	for <selinux@archiver.kernel.org>; Mon, 24 Jul 2023 09:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjGXJnY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jul 2023 05:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGXJnX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jul 2023 05:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04E01A1
        for <selinux@vger.kernel.org>; Mon, 24 Jul 2023 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690191755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6CrOptvT7yMh88PuhHkUHdLez1F8QhYP5zlV0GVmgh8=;
        b=QYJt3lw/+pMROk9bf4JBCNpbVOqkcMNhMw4i4mJWNZcjVKpWKISWo/BFTJr3hYn9Vx03pb
        3zWewF8kgwYIHPFIGCe2+p4htHfrBazrC4I7NEpOMSs/kTQIXCOpBQr1E4AQ4D5gwtBP3w
        vaX2TdqkzF0HOreJUnbhC4It5AuWhT4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-zHmYCKsLMqWTkb_aqNiptg-1; Mon, 24 Jul 2023 05:42:31 -0400
X-MC-Unique: zHmYCKsLMqWTkb_aqNiptg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4704E3806703;
        Mon, 24 Jul 2023 09:42:31 +0000 (UTC)
Received: from localhost (unknown [10.45.224.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCCEA1121315;
        Mon, 24 Jul 2023 09:42:30 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: RFC: remove /ru/ man pages from the repo
In-Reply-To: <20230719165716.18285-1-stephen.smalley.work@gmail.com>
References: <20230719165716.18285-1-stephen.smalley.work@gmail.com>
Date:   Mon, 24 Jul 2023 11:42:30 +0200
Message-ID: <874jltzlvd.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> Change "NSA SELinux" to just "SELinux" and remove NSA from the
> SELinux manual pages.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

FTR
Acked-by: Petr Lautrbach <lautrbach@redhat.com>

My proposal to drop "ru" is bellow.

> ---
>  libselinux/man/man8/selinux.8                           | 4 ++--
>  libselinux/man/ru/man8/selinux.8                        | 4 ++--
>  policycoreutils/load_policy/load_policy.8               | 2 +-
>  policycoreutils/load_policy/ru/load_policy.8            | 2 +-
>  policycoreutils/newrole/newrole.1                       | 2 +-
>  policycoreutils/newrole/ru/newrole.1                    | 2 +-
>  policycoreutils/run_init/open_init_pty.8                | 2 +-
>  policycoreutils/run_init/ru/open_init_pty.8             | 2 +-
>  policycoreutils/run_init/ru/run_init.8                  | 2 +-
>  policycoreutils/run_init/run_init.8                     | 2 +-
>  policycoreutils/secon/ru/secon.1                        | 2 +-
>  policycoreutils/secon/secon.1                           | 2 +-
>  policycoreutils/semodule/ru/semodule.8                  | 2 +-
>  policycoreutils/semodule/semodule.8                     | 2 +-
>  python/audit2allow/audit2allow.1                        | 2 +-
>  python/audit2allow/ru/audit2allow.1                     | 2 +-
>  semodule-utils/semodule_expand/ru/semodule_expand.8     | 2 +-
>  semodule-utils/semodule_expand/semodule_expand.8        | 2 +-
>  semodule-utils/semodule_link/ru/semodule_link.8         | 2 +-
>  semodule-utils/semodule_link/semodule_link.8            | 2 +-
>  semodule-utils/semodule_package/ru/semodule_package.8   | 2 +-
>  semodule-utils/semodule_package/ru/semodule_unpackage.8 | 2 +-
>  semodule-utils/semodule_package/semodule_package.8      | 2 +-
>  semodule-utils/semodule_package/semodule_unpackage.8    | 2 +-
>  24 files changed, 26 insertions(+), 26 deletions(-)

..

> --- a/libselinux/man/ru/man8/selinux.8
> +++ b/libselinux/man/ru/man8/selinux.8
> @@ -1,9 +1,9 @@
>  .TH  "selinux"  "8"  "29 =D0=B0=D0=BF=D1=80=D0=B5=D0=BB=D1=8F 2005" "dwa=
lsh@redhat.com" "=D0=94=D0=BE=D0=BA=D1=83=D0=BC=D0=B5=D0=BD=D1=82=D0=B0=D1=
=86=D0=B8=D1=8F =D0=BF=D0=BE =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=BD=D0=
=BE=D0=B9 =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B5 SELinux"
>  .SH "=D0=98=D0=9C=D0=AF"
> -SELinux \- Linux =D1=81 =D1=83=D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=B9 =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=D1=81=
=D1=82=D1=8C=D1=8E =D0=BE=D1=82 NSA (SELinux)
> +SELinux \- Linux =D1=81 =D1=83=D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=BD=D0=BD=
=D0=BE=D0=B9 =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=D1=81=
=D1=82=D1=8C=D1=8E =D0=BE=D1=82 (SELinux)
>  .


This translates to "Linux with improved security from (SELinux)".

Since 2019, the majority of modifications made to the man pages have not
been implemented to "ru" part. I guess that these pages will become
obsolete with time.

I think we should drop the ru translation from this repository and  if
there's a demand, start a new project that would be connected to a
translation platform like https://translate.fedoraproject.org/. This would
make it possible to translate into other languages too.=20

Petr


>  .SH "=D0=9E=D0=9F=D0=98=D0=A1=D0=90=D0=9D=D0=98=D0=95"
> -Linux =D1=81 =D1=83=D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=BD=D0=BD=D0=BE=D0=
=B9 =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=D1=81=D1=82=D1=
=8C=D1=8E =D0=BE=D1=82 NSA - =D1=8D=D1=82=D0=BE =D1=80=D0=B5=D0=B0=D0=BB=D0=
=B8=D0=B7=D0=B0=D1=86=D0=B8=D1=8F =D0=B3=D0=B8=D0=B1=D0=BA=D0=BE=D0=B9 =D0=
=B0=D1=80=D1=85=D0=B8=D1=82=D0=B5=D0=BA=D1=82=D1=83=D1=80=D1=8B =D0=BC=D0=
=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=BD=D0=BE=D0=B3=D0=BE
> +Linux =D1=81 =D1=83=D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=BD=D0=BD=D0=BE=D0=
=B9 =D0=B1=D0=B5=D0=B7=D0=BE=D0=BF=D0=B0=D1=81=D0=BD=D0=BE=D1=81=D1=82=D1=
=8C=D1=8E =D0=BE=D1=82 - =D1=8D=D1=82=D0=BE =D1=80=D0=B5=D0=B0=D0=BB=D0=B8=
=D0=B7=D0=B0=D1=86=D0=B8=D1=8F =D0=B3=D0=B8=D0=B1=D0=BA=D0=BE=D0=B9 =D0=B0=
=D1=80=D1=85=D0=B8=D1=82=D0=B5=D0=BA=D1=82=D1=83=D1=80=D1=8B =D0=BC=D0=B0=
=D0=BD=D0=B4=D0=B0=D1=82=D0=BD=D0=BE=D0=B3=D0=BE
>  =D1=83=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=
=BE=D1=81=D1=82=D1=83=D0=BF=D0=BE=D0=BC =D0=B2 =D0=BE=D0=BF=D0=B5=D1=80=D0=
=B0=D1=86=D0=B8=D0=BE=D0=BD=D0=BD=D0=BE=D0=B9 =D1=81=D0=B8=D1=81=D1=82=D0=
=B5=D0=BC=D0=B5 Linux. =D0=90=D1=80=D1=85=D0=B8=D1=82=D0=B5=D0=BA=D1=82=D1=
=83=D1=80=D0=B0 SELinux =D0=BF=D1=80=D0=B5=D0=B4=D0=BE=D1=81=D1=82=D0=B0=D0=
=B2=D0=BB=D1=8F=D0=B5=D1=82
>  =D0=BE=D0=B1=D1=89=D1=83=D1=8E =D0=BF=D0=BE=D0=B4=D0=B4=D0=B5=D1=80=D0=
=B6=D0=BA=D1=83 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=
=B0=D0=BD=D0=B8=D1=8F =D1=80=D0=B0=D0=B7=D0=BB=D0=B8=D1=87=D0=BD=D1=8B=D1=
=85 =D0=B2=D0=B8=D0=B4=D0=BE=D0=B2 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=
=BA =D0=BC=D0=B0=D0=BD=D0=B4=D0=B0=D1=82=D0=BD=D0=BE=D0=B3=D0=BE =D1=83=D0=
=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=B4=D0=BE=D1=81=D1=
=82=D1=83=D0=BF=D0=BE=D0=BC,
>  =D0=B2=D0=BA=D0=BB=D1=8E=D1=87=D0=B0=D1=8F =D0=BE=D1=81=D0=BD=D0=BE=D0=
=B2=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BD=D1=86=D0=
=B5=D0=BF=D1=86=D0=B8=D1=8F=D1=85 Type Enforcement=C2=AE (=D0=BF=D1=80=D0=
=B8=D0=BD=D1=83=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE=D0=B5 =D0=
=BF=D1=80=D0=B8=D1=81=D0=B2=D0=BE=D0=B5=D0=BD=D0=B8=D0=B5 =D1=82=D0=B8=D0=
=BF=D0=BE=D0=B2),
> diff --git a/policycoreutils/load_policy/load_policy.8 b/policycoreutils/=
load_policy/load_policy.8
> index 0810995c..867c35e4 100644
> --- a/policycoreutils/load_policy/load_policy.8
> +++ b/policycoreutils/load_policy/load_policy.8
> @@ -1,4 +1,4 @@
> -.TH LOAD_POLICY "8" "May 2003" "Security Enhanced Linux" NSA
> +.TH LOAD_POLICY "8" "May 2003" "Security Enhanced Linux"
>  .SH NAME
>  load_policy \- load a new SELinux policy into the kernel
>=20=20
> diff --git a/policycoreutils/load_policy/ru/load_policy.8 b/policycoreuti=
ls/load_policy/ru/load_policy.8
> index db3d9f65..25140b2e 100644
> --- a/policycoreutils/load_policy/ru/load_policy.8
> +++ b/policycoreutils/load_policy/ru/load_policy.8
> @@ -1,4 +1,4 @@
> -.TH LOAD_POLICY "8" "=D0=9C=D0=B0=D0=B9 2003" "Security Enhanced Linux" =
NSA
> +.TH LOAD_POLICY "8" "=D0=9C=D0=B0=D0=B9 2003" "Security Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  load_policy \- =D0=B7=D0=B0=D0=B3=D1=80=D1=83=D0=B7=D0=B8=D1=82=D1=8C =
=D0=BD=D0=BE=D0=B2=D1=83=D1=8E =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=
=D1=83 SELinux =D0=B2 =D1=8F=D0=B4=D1=80=D0=BE
>=20=20
> diff --git a/policycoreutils/newrole/newrole.1 b/policycoreutils/newrole/=
newrole.1
> index 893c42f7..544274d7 100644
> --- a/policycoreutils/newrole/newrole.1
> +++ b/policycoreutils/newrole/newrole.1
> @@ -1,4 +1,4 @@
> -.TH NEWROLE "1" "October 2000" "Security Enhanced Linux" NSA
> +.TH NEWROLE "1" "October 2000" "Security Enhanced Linux"
>  .SH NAME
>  newrole \- run a shell with a new SELinux role
>  .SH SYNOPSIS
> diff --git a/policycoreutils/newrole/ru/newrole.1 b/policycoreutils/newro=
le/ru/newrole.1
> index c4078789..6d9c6dd0 100644
> --- a/policycoreutils/newrole/ru/newrole.1
> +++ b/policycoreutils/newrole/ru/newrole.1
> @@ -1,4 +1,4 @@
> -.TH NEWROLE "1" "=D0=9E=D0=BA=D1=82=D1=8F=D0=B1=D1=80=D1=8C 2000" "Secur=
ity Enhanced Linux" NSA
> +.TH NEWROLE "1" "=D0=9E=D0=BA=D1=82=D1=8F=D0=B1=D1=80=D1=8C 2000" "Secur=
ity Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  newrole \- =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C =D0=BE=
=D0=B1=D0=BE=D0=BB=D0=BE=D1=87=D0=BA=D1=83 =D1=81 =D0=BD=D0=BE=D0=B2=D0=BE=
=D0=B9 =D1=80=D0=BE=D0=BB=D1=8C=D1=8E SELinux
>  .SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
> diff --git a/policycoreutils/run_init/open_init_pty.8 b/policycoreutils/r=
un_init/open_init_pty.8
> index 4b0a2f3c..8bfb9d69 100644
> --- a/policycoreutils/run_init/open_init_pty.8
> +++ b/policycoreutils/run_init/open_init_pty.8
> @@ -22,7 +22,7 @@
>  .\" USA.
>  .\"
>  .\"
> -.TH OPEN_INIT_PTY "8" "January 2005" "Security Enhanced Linux" NSA
> +.TH OPEN_INIT_PTY "8" "January 2005" "Security Enhanced Linux"
>  .SH NAME
>  open_init_pty \- run an program under a pseudo terminal
>  .SH SYNOPSIS
> diff --git a/policycoreutils/run_init/ru/open_init_pty.8 b/policycoreutil=
s/run_init/ru/open_init_pty.8
> index bac4fd94..143941e1 100644
> --- a/policycoreutils/run_init/ru/open_init_pty.8
> +++ b/policycoreutils/run_init/ru/open_init_pty.8
> @@ -22,7 +22,7 @@
>  .\" USA.
>  .\"
>  .\"
> -.TH OPEN_INIT_PTY "8" "=D0=AF=D0=BD=D0=B2=D0=B0=D1=80=D1=8C 2005" "Secur=
ity Enhanced Linux" NSA
> +.TH OPEN_INIT_PTY "8" "=D0=AF=D0=BD=D0=B2=D0=B0=D1=80=D1=8C 2005" "Secur=
ity Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  open_init_pty \- =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C =
=D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=83 =D0=BF=D0=BE=D0=B4 =
=D0=BF=D1=81=D0=B5=D0=B2=D0=B4=D0=BE=D1=82=D0=B5=D1=80=D0=BC=D0=B8=D0=BD=D0=
=B0=D0=BB=D0=BE=D0=BC
>  .SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
> diff --git a/policycoreutils/run_init/ru/run_init.8 b/policycoreutils/run=
_init/ru/run_init.8
> index 174d9c53..26b767ce 100644
> --- a/policycoreutils/run_init/ru/run_init.8
> +++ b/policycoreutils/run_init/ru/run_init.8
> @@ -1,4 +1,4 @@
> -.TH RUN_INIT "8" "=D0=9C=D0=B0=D0=B9 2003" "Security Enhanced Linux" NSA
> +.TH RUN_INIT "8" "=D0=9C=D0=B0=D0=B9 2003" "Security Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  run_init \- =D0=B7=D0=B0=D0=BF=D1=83=D1=81=D1=82=D0=B8=D1=82=D1=8C =D1=
=81=D1=86=D0=B5=D0=BD=D0=B0=D1=80=D0=B8=D0=B9 init =D0=B2 =D0=BF=D1=80=D0=
=B0=D0=B2=D0=B8=D0=BB=D1=8C=D0=BD=D0=BE=D0=BC =D0=BA=D0=BE=D0=BD=D1=82=D0=
=B5=D0=BA=D1=81=D1=82=D0=B5 SELinux
>  .SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
> diff --git a/policycoreutils/run_init/run_init.8 b/policycoreutils/run_in=
it/run_init.8
> index a031d5d2..d7ff45d0 100644
> --- a/policycoreutils/run_init/run_init.8
> +++ b/policycoreutils/run_init/run_init.8
> @@ -1,4 +1,4 @@
> -.TH RUN_INIT "8" "May 2003" "Security Enhanced Linux" NSA
> +.TH RUN_INIT "8" "May 2003" "Security Enhanced Linux"
>  .SH NAME
>  run_init \- run an init script in the proper SELinux context
>  .SH SYNOPSIS
> diff --git a/policycoreutils/secon/ru/secon.1 b/policycoreutils/secon/ru/=
secon.1
> index acbc14fb..3c9aa535 100644
> --- a/policycoreutils/secon/ru/secon.1
> +++ b/policycoreutils/secon/ru/secon.1
> @@ -1,4 +1,4 @@
> -.TH SECON "1" "=D0=90=D0=BF=D1=80=D0=B5=D0=BB=D1=8C 2006" "Security Enha=
nced Linux" NSA
> +.TH SECON "1" "=D0=90=D0=BF=D1=80=D0=B5=D0=BB=D1=8C 2006" "Security Enha=
nced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  secon \- =D0=BF=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=BA=D0=BE=
=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82 SELinux =D0=B4=D0=BB=D1=8F =D1=84=D0=
=B0=D0=B9=D0=BB=D0=B0, =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D1=
=8B =D0=B8=D0=BB=D0=B8 =D0=B2=D0=B2=D0=BE=D0=B4=D0=B0 =D0=BF=D0=BE=D0=BB=D1=
=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8F.
>  .SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
> diff --git a/policycoreutils/secon/secon.1 b/policycoreutils/secon/secon.1
> index c0e8b05a..1a454edc 100644
> --- a/policycoreutils/secon/secon.1
> +++ b/policycoreutils/secon/secon.1
> @@ -1,4 +1,4 @@
> -.TH SECON "1" "April 2006" "Security Enhanced Linux" NSA
> +.TH SECON "1" "April 2006" "Security Enhanced Linux"
>  .SH NAME
>  secon \- See an SELinux context, from a file, program or user input.
>  .SH SYNOPSIS
> diff --git a/policycoreutils/semodule/ru/semodule.8 b/policycoreutils/sem=
odule/ru/semodule.8
> index 26515201..d7ff9b56 100644
> --- a/policycoreutils/semodule/ru/semodule.8
> +++ b/policycoreutils/semodule/ru/semodule.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Security E=
nhanced Linux" NSA
> +.TH SEMODULE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Security E=
nhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF=20
>  semodule \- =D1=83=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5=
 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F=D0=BC=D0=B8 =D0=BF=D0=BE=D0=BB=D0=B8=
=D1=82=D0=B8=D0=BA=D0=B8 SELinux.
>=20=20
> diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodu=
le/semodule.8
> index 01757b00..00c60c1e 100644
> --- a/policycoreutils/semodule/semodule.8
> +++ b/policycoreutils/semodule/semodule.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE "8" "Nov 2005" "Security Enhanced Linux" NSA
> +.TH SEMODULE "8" "Nov 2005" "Security Enhanced Linux"
>  .SH NAME
>  semodule \- Manage SELinux policy modules.
>=20=20
> diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2=
allow.1
> index c31021d3..c208b3b2 100644
> --- a/python/audit2allow/audit2allow.1
> +++ b/python/audit2allow/audit2allow.1
> @@ -23,7 +23,7 @@
>  .\" USA.
>  .\"
>  .\"
> -.TH AUDIT2ALLOW "1" "October 2010" "Security Enhanced Linux" NSA
> +.TH AUDIT2ALLOW "1" "October 2010" "Security Enhanced Linux"
>  .SH NAME
>  .BR audit2allow
>  \- generate SELinux policy allow/dontaudit rules from logs of denied ope=
rations
> diff --git a/python/audit2allow/ru/audit2allow.1 b/python/audit2allow/ru/=
audit2allow.1
> index 1633fa3b..b631895d 100644
> --- a/python/audit2allow/ru/audit2allow.1
> +++ b/python/audit2allow/ru/audit2allow.1
> @@ -23,7 +23,7 @@
>  .\" USA.
>  .\"
>  .\"
> -.TH AUDIT2ALLOW "1" "=D0=9E=D0=BA=D1=82=D1=8F=D0=B1=D1=80=D1=8C 2010" "S=
ecurity Enhanced Linux" NSA
> +.TH AUDIT2ALLOW "1" "=D0=9E=D0=BA=D1=82=D1=8F=D0=B1=D1=80=D1=8C 2010" "S=
ecurity Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  .BR audit2allow
>  \- =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D1=91=D1=82 =D0=BF=D1=80=D0=B0=D0=B2=
=D0=B8=D0=BB=D0=B0 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux=
 allow/dontaudit =D0=B8=D0=B7 =D0=B6=D1=83=D1=80=D0=BD=D0=B0=D0=BB=D0=BE=D0=
=B2 =D0=BE=D1=82=D0=BA=D0=BB=D0=BE=D0=BD=D1=91=D0=BD=D0=BD=D1=8B=D1=85 =D0=
=BE=D0=BF=D0=B5=D1=80=D0=B0=D1=86=D0=B8=D0=B9
> diff --git a/semodule-utils/semodule_expand/ru/semodule_expand.8 b/semodu=
le-utils/semodule_expand/ru/semodule_expand.8
> index afdc129e..28b381af 100644
> --- a/semodule-utils/semodule_expand/ru/semodule_expand.8
> +++ b/semodule-utils/semodule_expand/ru/semodule_expand.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_EXPAND "8" "=D0=BD=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Sec=
urity Enhanced Linux" NSA
> +.TH SEMODULE_EXPAND "8" "=D0=BD=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Sec=
urity Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF=20
>  semodule_expand \- =D1=80=D0=B0=D1=81=D1=88=D0=B8=D1=80=D0=B8=D1=82=D1=
=8C =D0=BF=D0=B0=D0=BA=D0=B5=D1=82 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=
=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux
>=20=20
> diff --git a/semodule-utils/semodule_expand/semodule_expand.8 b/semodule-=
utils/semodule_expand/semodule_expand.8
> index 1b482a1f..eba7b40e 100644
> --- a/semodule-utils/semodule_expand/semodule_expand.8
> +++ b/semodule-utils/semodule_expand/semodule_expand.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_EXPAND "8" "Nov 2005" "Security Enhanced Linux" NSA
> +.TH SEMODULE_EXPAND "8" "Nov 2005" "Security Enhanced Linux"
>  .SH NAME=20
>  semodule_expand \- Expand a SELinux policy module package.
>=20=20
> diff --git a/semodule-utils/semodule_link/ru/semodule_link.8 b/semodule-u=
tils/semodule_link/ru/semodule_link.8
> index 31d81206..4a8f414e 100644
> --- a/semodule-utils/semodule_link/ru/semodule_link.8
> +++ b/semodule-utils/semodule_link/ru/semodule_link.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_LINK "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Secur=
ity Enhanced Linux" NSA
> +.TH SEMODULE_LINK "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Secur=
ity Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF=20
>  semodule_link \- =D1=81=D0=B2=D1=8F=D0=B7=D0=B0=D1=82=D1=8C =D0=B2=D0=BC=
=D0=B5=D1=81=D1=82=D0=B5 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D1=8B =D0=BC=D0=BE=
=D0=B4=D1=83=D0=BB=D0=B5=D0=B9 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=
=D0=B8 SELinux
>=20=20
> diff --git a/semodule-utils/semodule_link/semodule_link.8 b/semodule-util=
s/semodule_link/semodule_link.8
> index a2bda3f9..95a9ba19 100644
> --- a/semodule-utils/semodule_link/semodule_link.8
> +++ b/semodule-utils/semodule_link/semodule_link.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_LINK "8" "Nov 2005" "Security Enhanced Linux" NSA
> +.TH SEMODULE_LINK "8" "Nov 2005" "Security Enhanced Linux"
>  .SH NAME=20
>  semodule_link \- Link SELinux policy module packages together
>=20=20
> diff --git a/semodule-utils/semodule_package/ru/semodule_package.8 b/semo=
dule-utils/semodule_package/ru/semodule_package.8
> index 6af67b29..3f4b16a9 100644
> --- a/semodule-utils/semodule_package/ru/semodule_package.8
> +++ b/semodule-utils/semodule_package/ru/semodule_package.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_PACKAGE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Se=
curity Enhanced Linux" NSA
> +.TH SEMODULE_PACKAGE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Se=
curity Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF=20
>  semodule_package \- =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BF=D0=
=B0=D0=BA=D0=B5=D1=82 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=BF=D0=BE=D0=
=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux
>=20=20
> diff --git a/semodule-utils/semodule_package/ru/semodule_unpackage.8 b/se=
module-utils/semodule_package/ru/semodule_unpackage.8
> index 910fee02..6c7e234b 100644
> --- a/semodule-utils/semodule_package/ru/semodule_unpackage.8
> +++ b/semodule-utils/semodule_package/ru/semodule_unpackage.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_PACKAGE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Se=
curity Enhanced Linux" NSA
> +.TH SEMODULE_PACKAGE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Se=
curity Enhanced Linux"
>  .SH =D0=98=D0=9C=D0=AF
>  semodule_unpackage \- =D0=B8=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D1=8C =D0=BC=
=D0=BE=D0=B4=D1=83=D0=BB=D1=8C =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=
=D0=B8 =D0=B8 =D1=84=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=
=D1=81=D1=82=D0=BE=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D0=B8=D0=B7 =
=D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B0 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =
=D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux
>=20=20
> diff --git a/semodule-utils/semodule_package/semodule_package.8 b/semodul=
e-utils/semodule_package/semodule_package.8
> index 9697cc55..1d64bad3 100644
> --- a/semodule-utils/semodule_package/semodule_package.8
> +++ b/semodule-utils/semodule_package/semodule_package.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_PACKAGE "8" "Nov 2005" "Security Enhanced Linux" NSA
> +.TH SEMODULE_PACKAGE "8" "Nov 2005" "Security Enhanced Linux"
>  .SH NAME=20
>  semodule_package \- Create a SELinux policy module package.
>=20=20
> diff --git a/semodule-utils/semodule_package/semodule_unpackage.8 b/semod=
ule-utils/semodule_package/semodule_unpackage.8
> index 5c92bf51..0432f7a1 100644
> --- a/semodule-utils/semodule_package/semodule_unpackage.8
> +++ b/semodule-utils/semodule_package/semodule_unpackage.8
> @@ -1,4 +1,4 @@
> -.TH SEMODULE_PACKAGE "8" "Nov 2005" "Security Enhanced Linux" NSA
> +.TH SEMODULE_PACKAGE "8" "Nov 2005" "Security Enhanced Linux"
>  .SH NAME
>  semodule_unpackage \- Extract policy module and file context file from a=
n SELinux policy module package.
>=20=20
> --=20
> 2.40.1

