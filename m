Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26E8C54EBC
	for <selinux@archiver.kernel.org>; Tue, 10 Jan 2023 15:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjAJPhe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Jan 2023 10:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbjAJPhO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Jan 2023 10:37:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55814D94
        for <selinux@vger.kernel.org>; Tue, 10 Jan 2023 07:36:37 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jo4so29689141ejb.7
        for <selinux@vger.kernel.org>; Tue, 10 Jan 2023 07:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHkEDbyrBWdgfEYWDvKwhpEWzzp7hO8KeE9Bc5B7tu4=;
        b=nIv/BIwKE9MaTLBp8MVq733+A3o3jZ2/ubcba2uRKbindE06Asczi2UBGyUQtYcxJF
         3AIu4CuEt1+UHw2VAbDs692kc15v9aqye6BAdtvf7XCHhA0hwY6xu0I6Ul/c3T/73cws
         FdxW3TduOBQ6fxxbkhc0MJSQcbHo4vMfjwewZvG4vl5b71NvJb2QUDeOccu3fP4dmirM
         rzofYmHaP9LPMjJUQZa22jBgJ7/nw7i2eYCX369PQJOUYoa/zrW6LJd56W6oodh6LKhP
         3FhMlvLvZAsoPTcC1b9ZJabZGSnIVZtfGY5ogmRphJ617Sqk4s6wiwMPXHircpaAf+qs
         e2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHkEDbyrBWdgfEYWDvKwhpEWzzp7hO8KeE9Bc5B7tu4=;
        b=OQDBqoQmJz1RckMU/gp+lz3pZBouZAVO/AlYzI4LDG0VyWOELVGVE18v8/SFkpwqom
         9T4Qw3TazOxxE8G52iitpPAq7DcD+RB0k1fq0Hm16ZNr19+aHeFUqINX2oTxPDYmxLqA
         c9eAWGqdaPn5Bq/5aMZs4aOhkz5PTMU3Klp1JCBYdXXAzj1kdcwWi7kgKsAew+sa+110
         VPuGHYtbRFHbSu3U4WoxElQ+97PcZZ8Tsxt8wcIBCMVnbMJnLEBOEXoiB8aB5LJzNvuh
         JjByr2LSugDdq6KQzgYirMfOUabqss8lVJSh9/YyYHFPGRpyacmB5sr8tZi1O71De7Yf
         5JBQ==
X-Gm-Message-State: AFqh2kp2gGQKKQdr20zWvM8L/KmQsRbgMXainE6TMxRfHExaE7+FS6av
        NSPArY5mMYW6u8YZpz3L87XfztblxnabOS80IUWC2Kg8HEg=
X-Google-Smtp-Source: AMrXdXut8OazvmCMDOncVKUe88Pxbuf/DWw82D33zRQcYiWEV/7WlbQSznIWazAMmDrpl1N9Twi88qALbtIPyFPxRZk=
X-Received: by 2002:a17:907:2d92:b0:84d:236c:842b with SMTP id
 gt18-20020a1709072d9200b0084d236c842bmr1168547ejc.424.1673364995573; Tue, 10
 Jan 2023 07:36:35 -0800 (PST)
MIME-Version: 1.0
References: <20230105171340.18444-1-cgzones@googlemail.com> <20230105171340.18444-2-cgzones@googlemail.com>
In-Reply-To: <20230105171340.18444-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 10 Jan 2023 10:36:24 -0500
Message-ID: <CAP+JOzRME2qF51YQUqf82a8cNsYoDJzkq_PyPL+VabpKXeggcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkpolicy: add simple round-trip test
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 5, 2023 at 12:26 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add simple round-trip tests on a minimal standard and MLS policy.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  checkpolicy/.gitignore              |  2 +
>  checkpolicy/Makefile                |  6 +-
>  checkpolicy/tests/polmin.conf       | 81 +++++++++++++++++++++++++++
>  checkpolicy/tests/polmin.mls.conf   | 85 +++++++++++++++++++++++++++++
>  checkpolicy/tests/test_roundtrip.sh | 33 +++++++++++
>  5 files changed, 206 insertions(+), 1 deletion(-)
>  create mode 100644 checkpolicy/tests/polmin.conf
>  create mode 100644 checkpolicy/tests/polmin.mls.conf
>  create mode 100755 checkpolicy/tests/test_roundtrip.sh
>
> diff --git a/checkpolicy/.gitignore b/checkpolicy/.gitignore
> index a7bd076d..01a694d4 100644
> --- a/checkpolicy/.gitignore
> +++ b/checkpolicy/.gitignore
> @@ -3,3 +3,5 @@ checkpolicy
>  lex.yy.c
>  y.tab.c
>  y.tab.h
> +tests/testpol.bin
> +tests/testpol.conf
> diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> index f9e1fc7c..86c4a197 100644
> --- a/checkpolicy/Makefile
> +++ b/checkpolicy/Makefile
> @@ -50,6 +50,10 @@ y.tab.c: policy_parse.y
>  lex.yy.c: policy_scan.l y.tab.c
>         $(LEX) policy_scan.l
>
> +.PHONY: test
> +test: checkpolicy
> +       ./tests/test_roundtrip.sh
> +
>  install: all
>         -mkdir -p $(DESTDIR)$(BINDIR)
>         -mkdir -p $(DESTDIR)$(MANDIR)/man8
> @@ -68,7 +72,7 @@ relabel: install
>         /sbin/restorecon $(DESTDIR)$(BINDIR)/checkmodule
>
>  clean:
> -       -rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h=
 lex.yy.c
> +       -rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab.h=
 lex.yy.c tests/testpol.conf tests/testpol.bin
>         $(MAKE) -C test clean
>
>  indent:
> diff --git a/checkpolicy/tests/polmin.conf b/checkpolicy/tests/polmin.con=
f
> new file mode 100644
> index 00000000..7a652de8
> --- /dev/null
> +++ b/checkpolicy/tests/polmin.conf
> @@ -0,0 +1,81 @@
> +# handle_unknown deny
> +class process
> +class blk_file
> +class chr_file
> +class dir
> +class fifo_file
> +class file
> +class lnk_file
> +class sock_file

I am not sure why you are defining so many classes that are not being used.

> +sid kernel
> +sid security
> +sid unlabeled
> +sid fs
> +sid file
> +sid file_labels
> +sid init
> +sid any_socket
> +sid port
> +sid netif
> +sid netmsg
> +sid node
> +sid igmp_packet
> +sid icmp_socket
> +sid tcp_socket
> +sid sysctl_modprobe
> +sid sysctl
> +sid sysctl_fs
> +sid sysctl_kernel
> +sid sysctl_net
> +sid sysctl_net_unix
> +sid sysctl_vm
> +sid sysctl_dev
> +sid kmod
> +sid policy
> +sid scmp_packet
> +sid devnull

The policy is not being loaded into the kernel, so you don't need to
have all of the sid rules.

This is the absolute minimum policy (I think):

# handle_unknown deny
class CLASS1
sid kernel
class CLASS1 { PERM1 }
type TYPE1;
allow TYPE1 self:CLASS1 { PERM1 };
role ROLE1;
role ROLE1 types { TYPE1 };
user USER1 roles ROLE1;
sid kernel USER1:ROLE1:TYPE1

There would also be merit in having a very minimum policy that uses every r=
ule.

> +class process { dyntransition transition }
> +default_role { blk_file } source;
> +default_role { chr_file } source;
> +default_role { dir } source;
> +default_role { fifo_file } source;
> +default_role { file } source;
> +default_role { lnk_file } source;
> +default_role { sock_file } source;
> +type sys_isid;
> +typealias sys_isid alias dpkg_script_t;
> +typealias sys_isid alias rpm_script_t;
> +allow sys_isid self:process { dyntransition transition };
> +role sys_role;
> +role sys_role types { sys_isid };
> +user sys_user roles sys_role;
> +constrain process { transition } u1 =3D=3D u2;
> +sid kernel sys_user:sys_role:sys_isid
> +sid security sys_user:sys_role:sys_isid
> +sid unlabeled sys_user:sys_role:sys_isid
> +sid fs sys_user:sys_role:sys_isid
> +sid file sys_user:sys_role:sys_isid
> +sid file_labels sys_user:sys_role:sys_isid
> +sid init sys_user:sys_role:sys_isid
> +sid any_socket sys_user:sys_role:sys_isid
> +sid port sys_user:sys_role:sys_isid
> +sid netif sys_user:sys_role:sys_isid
> +sid netmsg sys_user:sys_role:sys_isid
> +sid node sys_user:sys_role:sys_isid
> +sid igmp_packet sys_user:sys_role:sys_isid
> +sid icmp_socket sys_user:sys_role:sys_isid
> +sid tcp_socket sys_user:sys_role:sys_isid
> +sid sysctl_modprobe sys_user:sys_role:sys_isid
> +sid sysctl sys_user:sys_role:sys_isid
> +sid sysctl_fs sys_user:sys_role:sys_isid
> +sid sysctl_kernel sys_user:sys_role:sys_isid
> +sid sysctl_net sys_user:sys_role:sys_isid
> +sid sysctl_net_unix sys_user:sys_role:sys_isid
> +sid sysctl_vm sys_user:sys_role:sys_isid
> +sid sysctl_dev sys_user:sys_role:sys_isid
> +sid kmod sys_user:sys_role:sys_isid
> +sid policy sys_user:sys_role:sys_isid
> +sid scmp_packet sys_user:sys_role:sys_isid
> +sid devnull sys_user:sys_role:sys_isid

Even if you are loading the policy into the kernel you only need to
assign contexts to the sids that are going to be used (kernel, file,
unlabeled, any_socket).

Eventually, we want dynamic loading of sids, so I would prefer to
minimize their usage.

Thanks,
Jim


> +fs_use_trans devpts sys_user:sys_role:sys_isid;
> +fs_use_trans devtmpfs sys_user:sys_role:sys_isid;
> diff --git a/checkpolicy/tests/polmin.mls.conf b/checkpolicy/tests/polmin=
.mls.conf
> new file mode 100644
> index 00000000..b045a60f
> --- /dev/null
> +++ b/checkpolicy/tests/polmin.mls.conf
> @@ -0,0 +1,85 @@
> +# handle_unknown deny
> +class process
> +class blk_file
> +class chr_file
> +class dir
> +class fifo_file
> +class file
> +class lnk_file
> +class sock_file
> +sid kernel
> +sid security
> +sid unlabeled
> +sid fs
> +sid file
> +sid file_labels
> +sid init
> +sid any_socket
> +sid port
> +sid netif
> +sid netmsg
> +sid node
> +sid igmp_packet
> +sid icmp_socket
> +sid tcp_socket
> +sid sysctl_modprobe
> +sid sysctl
> +sid sysctl_fs
> +sid sysctl_kernel
> +sid sysctl_net
> +sid sysctl_net_unix
> +sid sysctl_vm
> +sid sysctl_dev
> +sid kmod
> +sid policy
> +sid scmp_packet
> +sid devnull
> +class process { dyntransition transition }
> +default_role { blk_file } source;
> +default_role { chr_file } source;
> +default_role { dir } source;
> +default_role { fifo_file } source;
> +default_role { file } source;
> +default_role { lnk_file } source;
> +default_role { sock_file } source;
> +sensitivity s0;
> +dominance { s0 }
> +category c0;
> +level s0:c0;
> +mlsconstrain process { transition } l1 =3D=3D l2;
> +type sys_isid;
> +typealias sys_isid alias dpkg_script_t;
> +typealias sys_isid alias rpm_script_t;
> +allow sys_isid self:process { dyntransition transition };
> +role sys_role;
> +role sys_role types { sys_isid };
> +user sys_user roles sys_role level s0 range s0 - s0:c0;
> +sid kernel sys_user:sys_role:sys_isid:s0 - s0
> +sid security sys_user:sys_role:sys_isid:s0 - s0
> +sid unlabeled sys_user:sys_role:sys_isid:s0 - s0
> +sid fs sys_user:sys_role:sys_isid:s0 - s0
> +sid file sys_user:sys_role:sys_isid:s0 - s0
> +sid file_labels sys_user:sys_role:sys_isid:s0 - s0
> +sid init sys_user:sys_role:sys_isid:s0 - s0
> +sid any_socket sys_user:sys_role:sys_isid:s0 - s0
> +sid port sys_user:sys_role:sys_isid:s0 - s0
> +sid netif sys_user:sys_role:sys_isid:s0 - s0
> +sid netmsg sys_user:sys_role:sys_isid:s0 - s0
> +sid node sys_user:sys_role:sys_isid:s0 - s0
> +sid igmp_packet sys_user:sys_role:sys_isid:s0 - s0
> +sid icmp_socket sys_user:sys_role:sys_isid:s0 - s0
> +sid tcp_socket sys_user:sys_role:sys_isid:s0 - s0
> +sid sysctl_modprobe sys_user:sys_role:sys_isid:s0 - s0
> +sid sysctl sys_user:sys_role:sys_isid:s0 - s0
> +sid sysctl_fs sys_user:sys_role:sys_isid:s0 - s0
> +sid sysctl_kernel sys_user:sys_role:sys_isid:s0 - s0
> +sid sysctl_net sys_user:sys_role:sys_isid:s0 - s0
> +sid sysctl_net_unix sys_user:sys_role:sys_isid:s0 - s0
> +sid sysctl_vm sys_user:sys_role:sys_isid:s0 - s0
> +sid sysctl_dev sys_user:sys_role:sys_isid:s0 - s0
> +sid kmod sys_user:sys_role:sys_isid:s0 - s0
> +sid policy sys_user:sys_role:sys_isid:s0 - s0
> +sid scmp_packet sys_user:sys_role:sys_isid:s0 - s0
> +sid devnull sys_user:sys_role:sys_isid:s0 - s0
> +fs_use_trans devpts sys_user:sys_role:sys_isid:s0 - s0;
> +fs_use_trans devtmpfs sys_user:sys_role:sys_isid:s0 - s0;
> diff --git a/checkpolicy/tests/test_roundtrip.sh b/checkpolicy/tests/test=
_roundtrip.sh
> new file mode 100755
> index 00000000..15b1b3bc
> --- /dev/null
> +++ b/checkpolicy/tests/test_roundtrip.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +
> +set -eu
> +
> +BASEDIR=3D$(dirname "$0")
> +CHECKPOLICY=3D"${BASEDIR}/../checkpolicy"
> +
> +check_policy() {
> +       POLICY=3D$1
> +       MLS=3D$2
> +
> +       if [ "$MLS" =3D 'mls' ]; then
> +               OPT=3D'-M'
> +       else
> +               OPT=3D
> +       fi
> +
> +       echo "=3D=3D=3D=3D Testing ${1}"
> +
> +       ${CHECKPOLICY} ${OPT} -E "${BASEDIR}/${POLICY}" -o "${BASEDIR}/te=
stpol.bin"
> +       ${CHECKPOLICY} ${OPT} -E -b -F "${BASEDIR}/testpol.bin" -o "${BAS=
EDIR}/testpol.conf"
> +       diff -u "${BASEDIR}/${POLICY}" "${BASEDIR}/testpol.conf"
> +
> +       ${CHECKPOLICY} ${OPT} -S -O -E "${BASEDIR}/${POLICY}" -o "${BASED=
IR}/testpol.bin"
> +       ${CHECKPOLICY} ${OPT} -S -O -E -b -F "${BASEDIR}/testpol.bin" -o =
"${BASEDIR}/testpol.conf"
> +       diff -u "${BASEDIR}/${POLICY}" "${BASEDIR}/testpol.conf"
> +
> +       echo "=3D=3D=3D=3D ${1} success"
> +}
> +
> +
> +check_policy polmin.conf std
> +check_policy polmin.mls.conf mls
> --
> 2.39.0
>
