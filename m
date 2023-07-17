Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C06FEB64DC
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 12:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjGQMvC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 08:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGQMvA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 08:51:00 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797C0DA
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 05:50:56 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b708e49059so67374881fa.3
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 05:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689598255; x=1692190255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/Bd2ClCjzYzpg7uL+ZuSAeEgElFXPEmRkmtrid7dxI=;
        b=TRIoO1b0ZO+4sYcACA2QBp3SUpo3TI/AI2o9gi1rP1z7SfLxiGVU+DagOqKOOtHcP3
         1SNxckYLdCr+YcNTMqGc3uB8IEyPetwhgQvzmvuNJhcwghKVcxJBcaZQkPn17SkmGg5A
         lbn74vs4v6wZbe5C9W79c5ScuGAvziDSN1aWX0HzkXDcTAzCjtw/Th9eN5i+WQRx/0/0
         lFuRm6g5fMvGXi3TqUKkLX64aAorKdNZ/8sLu0Of5DMm/KFFeN46HGWpqiBvsk7Q780t
         sYTc0xcca+521siz8gypifUfBbo+InQ9y+i2S/QilWQWvOwn+P/sGHJovCMMDB50e7QD
         kAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689598255; x=1692190255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/Bd2ClCjzYzpg7uL+ZuSAeEgElFXPEmRkmtrid7dxI=;
        b=MMFF6i3dG4eyhprLaBZwxeNXCcJ4Xu8xR0Atp/R+ooFQgun0cHBuBjE7hD+lkX1bX2
         2w4FO6lSo2sDPJuHim7fViOErnKCQjikWI3P7zMLCz32oje8K/xeXmOuwhnfeKBf2ckI
         FC9SLKAFRCkxoY4iE3yjHBaU8mM4w4Bmyl6CJGBvHAxj8UV+gwSZEy13UQsle5PI+ion
         +UCxPv+FLqZ3nV34kHfU3G1oInUZLXht4hO467Phz0RHGgdI0LWlTxfPSuJt7lZESpSl
         fFg0tM0A2P3moIs/DPLpmKbrqfpntPUbP6miggElvTzuThDFqTEWfQ7za+W7VAAI+sZ6
         jvKA==
X-Gm-Message-State: ABy/qLaR19EsmqqQkiJOPwBI+NFovtJAQGIc8sKKG1MQfd1gbPDcQBSG
        XmTngYhd0Ss2DnBgPIkR/7pGKGbVGq5PeM9SURHpW7Ve
X-Google-Smtp-Source: APBJJlFI7xtUQ9Sxvc3KLjdMZTnXI0Nl1AbuU2MFiVsTSVqbIdgOAMt3PJ0vwL42zoyPfddEcAnu5c7F9/k07wDP2Ms=
X-Received: by 2002:a2e:700b:0:b0:2b6:cff1:cd1c with SMTP id
 l11-20020a2e700b000000b002b6cff1cd1cmr8258969ljc.34.1689598254193; Mon, 17
 Jul 2023 05:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230706154108.89846-1-cgzones@googlemail.com>
In-Reply-To: <20230706154108.89846-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 17 Jul 2023 08:50:42 -0400
Message-ID: <CAP+JOzSQnVr7aoom=dSKij4WaJcrnCeSpmLMNZpqLGmsewexwQ@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy: add round-trip tests
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 6, 2023 at 11:49=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add round-trip tests for checkpolicy(8).
> Test standard and MLS minimal policies as well as SELinux and Xen
> policies with each available statement.
> The output is checked against an expected result and then then checked
> for idempotence.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  checkpolicy/.gitignore                        |  2 +
>  checkpolicy/Makefile                          |  6 +-
>  checkpolicy/tests/policy_allonce.conf         | 80 ++++++++++++++++
>  .../tests/policy_allonce.expected.conf        | 76 +++++++++++++++
>  .../tests/policy_allonce.expected_opt.conf    | 76 +++++++++++++++
>  checkpolicy/tests/policy_allonce_mls.conf     | 92 +++++++++++++++++++
>  .../tests/policy_allonce_mls.expected.conf    | 88 ++++++++++++++++++
>  .../policy_allonce_mls.expected_opt.conf      | 88 ++++++++++++++++++
>  checkpolicy/tests/policy_allonce_xen.conf     | 62 +++++++++++++
>  .../tests/policy_allonce_xen.expected.conf    | 65 +++++++++++++
>  .../policy_allonce_xen.expected_opt.conf      | 61 ++++++++++++
>  checkpolicy/tests/policy_minimal.conf         | 10 ++
>  checkpolicy/tests/policy_minimal_mls.conf     | 15 +++
>  checkpolicy/tests/test_roundtrip.sh           | 41 +++++++++
>  14 files changed, 761 insertions(+), 1 deletion(-)
>  create mode 100644 checkpolicy/tests/policy_allonce.conf
>  create mode 100644 checkpolicy/tests/policy_allonce.expected.conf
>  create mode 100644 checkpolicy/tests/policy_allonce.expected_opt.conf
>  create mode 100644 checkpolicy/tests/policy_allonce_mls.conf
>  create mode 100644 checkpolicy/tests/policy_allonce_mls.expected.conf
>  create mode 100644 checkpolicy/tests/policy_allonce_mls.expected_opt.con=
f
>  create mode 100644 checkpolicy/tests/policy_allonce_xen.conf
>  create mode 100644 checkpolicy/tests/policy_allonce_xen.expected.conf
>  create mode 100644 checkpolicy/tests/policy_allonce_xen.expected_opt.con=
f
>  create mode 100644 checkpolicy/tests/policy_minimal.conf
>  create mode 100644 checkpolicy/tests/policy_minimal_mls.conf
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
> diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/po=
licy_allonce.conf
> new file mode 100644
> index 00000000..ae0fe9b5
> --- /dev/null
> +++ b/checkpolicy/tests/policy_allonce.conf
> @@ -0,0 +1,80 @@
> +# handle_unknown deny
> +class CLASS1
> +class CLASS2
> +class CLASS3
> +class dir
> +class file
> +class process
> +sid kernel
> +common COMMON1 { CPERM1 }
> +class CLASS1 { PERM1 ioctl }
> +class CLASS2 inherits COMMON1
> +class CLASS3 inherits COMMON1 { PERM1 }
> +default_user { CLASS1 } source;
> +default_role { CLASS2 } target;
> +default_type { CLASS3 } source;
> +policycap open_perms;
> +attribute ATTR1;
> +attribute ATTR2;
> +expandattribute ATTR1 true;
> +expandattribute ATTR2 false;
> +type TYPE1;
> +type TYPE2, ATTR1;
> +type TYPE3 alias { TYPEALIAS3A TYPEALIAS3B };
> +type TYPE4 alias TYPEALIAS4, ATTR2;
> +typealias TYPE1 alias TYPEALIAS1;
> +typeattribute TYPE1 ATTR1;
> +typebounds TYPE4 TYPE3;
> +bool BOOL1 true;
> +tunable TUNABLE1 false;
> +tunable TUNABLE2 true;
> +type_transition TYPE1 TYPE2 : CLASS1 TYPE3;
> +type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
";
> +type_member TYPE1 TYPE2 : CLASS1 TYPE2;
> +type_change TYPE1 TYPE2 : CLASS1 TYPE3;
> +allow TYPE1 self : CLASS1 { PERM1 };
> +auditallow { TYPE1 TYPE2 } TYPE3 : CLASS1 { PERM1 };
> +dontaudit TYPE1 { TYPE2 TYPE3 } : CLASS3 { PERM1 CPERM1 };
> +neverallow TYPE1 TYPE2 : { CLASS2 CLASS3 } { CPERM1 };
> +allowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x1;
> +auditallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x2;
> +dontauditxperm TYPE1 TYPE2 : CLASS1 ioctl 0x3;
> +neverallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x4;
> +permissive TYPE1;
> +attribute_role ROLE_ATTR1;
> +role ROLE1;
> +role ROLE3;
> +role ROLE2, ROLE_ATTR1;
> +dominance { role ROLE1 { role ROLE3; } }

I believe this is the first role dominance rule that I have ever seen.
That is how long they have been deprecated.
I want to remove support from checkpolicy, so it is best to get rid of
the role dominance rule in each policy.

> +role_transition ROLE1 TYPE1 ROLE2;
> +role_transition ROLE1 TYPE1 : CLASS1 ROLE2;
> +allow ROLE1 ROLE2;
> +roleattribute ROLE3 ROLE_ATTR1;
> +role ROLE1 types { TYPE1 };
> +if ! BOOL1 { allow TYPE1 self: CLASS1 *; }
> +if TUNABLE1 xor TUNABLE2 { allow TYPE1 self: CLASS2 *; } else { allow TY=
PE1 self: CLASS3 *; }
> +optional { require { class CLASS2 { CPERM1 }; } allow TYPE1 self: CLASS2=
 *; }
> +user USER1 roles ROLE1;
> +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=3D =
t2));
> +# sameuser will be turned into (u1 =3D=3D u2)
> +validatetrans CLASS2 sameuser and t3 =3D=3D ATTR1;
> +sid kernel USER1:ROLE1:TYPE1
> +# fscon statements are not dumped
> +fscon 2 3 USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +fs_use_xattr btrfs USER1:ROLE1:TYPE1;
> +fs_use_trans devpts USER1:ROLE1:TYPE1;
> +fs_use_task pipefs USER1:ROLE1:TYPE1;
> +# paths will be turned into quoted strings
> +genfscon proc / -d USER1:ROLE1:TYPE1
> +genfscon proc "/file1" -- USER1:ROLE1:TYPE1
> +genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
> +portcon tcp 80 USER1:ROLE1:TYPE1
> +portcon udp 100-200 USER1:ROLE1:TYPE1
> +netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
> +nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:R=
OLE1:TYPE1
> +# hex numbers will be turned in decimal ones
> +ibpkeycon fe80:: 0xFFFF USER1:ROLE1:TYPE1
> +ibpkeycon fe80:: 0-0x10 USER1:ROLE1:TYPE1
> +ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
> +ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1
> diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy=
/tests/policy_allonce.expected.conf
> new file mode 100644
> index 00000000..63739e1f
> --- /dev/null
> +++ b/checkpolicy/tests/policy_allonce.expected.conf
> @@ -0,0 +1,76 @@
> +# handle_unknown deny
> +class CLASS1
> +class CLASS2
> +class CLASS3
> +class dir
> +class file
> +class process
> +sid kernel
> +common COMMON1 { CPERM1 }
> +class CLASS1 { PERM1 ioctl }
> +class CLASS2 inherits COMMON1
> +class CLASS3 inherits COMMON1 { PERM1 }
> +default_user { CLASS1 } source;
> +default_role { CLASS2 } target;
> +default_type { CLASS3 } source;
> +policycap open_perms;
> +attribute ATTR1;
> +attribute ATTR2;
> +bool BOOL1 true;
> +type TYPE1;
> +type TYPE2;
> +type TYPE3;
> +type TYPE4;
> +typealias TYPE1 alias TYPEALIAS1;
> +typealias TYPE3 alias TYPEALIAS3A;
> +typealias TYPE3 alias TYPEALIAS3B;
> +typealias TYPE4 alias TYPEALIAS4;
> +typebounds TYPE4 TYPE3;
> +typeattribute TYPE4 ATTR2;
> +permissive TYPE1;
> +allow TYPE1 self:CLASS1 { PERM1 };
> +allow TYPE1 self:CLASS2 { CPERM1 };
> +auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
> +auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
> +dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
> +dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
> +allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x1 };
> +auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
> +dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
> +type_transition TYPE1 TYPE2:CLASS1 TYPE3;
> +type_member TYPE1 TYPE2:CLASS1 TYPE2;
> +type_change TYPE1 TYPE2:CLASS1 TYPE3;

With the recent patch moving filename transitions into the avtab, the
filename type_transition rules below come before the type_member and
type_change rules above. This goes for all of the other policies as
well.

Everything else looks good.

Thanks,
Jim


> +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
> +if (BOOL1) {
> +} else {
> +    allow TYPE1 self:CLASS1 { PERM1 ioctl };
> +}
> +role ROLE1;
> +role ROLE2;
> +role ROLE3;
> +role ROLE1 types { TYPE1 };
> +role_transition ROLE1 TYPE1:CLASS1 ROLE2;
> +role_transition ROLE1 TYPE1:process ROLE2;
> +allow ROLE1 ROLE2;
> +user USER1 roles ROLE1;
> +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=3D =
t2));
> +validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
> +sid kernel USER1:ROLE1:TYPE1
> +fs_use_xattr btrfs USER1:ROLE1:TYPE1;
> +fs_use_trans devpts USER1:ROLE1:TYPE1;
> +fs_use_task pipefs USER1:ROLE1:TYPE1;
> +genfscon proc "/" -d USER1:ROLE1:TYPE1
> +genfscon proc "/file1" -- USER1:ROLE1:TYPE1
> +genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
> +portcon tcp 80 USER1:ROLE1:TYPE1
> +portcon udp 100-200 USER1:ROLE1:TYPE1
> +netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
> +nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:R=
OLE1:TYPE1
> +ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1
> +ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1
> +ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
> +ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1
> diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpo=
licy/tests/policy_allonce.expected_opt.conf
> new file mode 100644
> index 00000000..1c969961
> --- /dev/null
> +++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
> @@ -0,0 +1,76 @@
> +# handle_unknown deny
> +class CLASS1
> +class CLASS2
> +class CLASS3
> +class dir
> +class file
> +class process
> +sid kernel
> +common COMMON1 { CPERM1 }
> +class CLASS1 { PERM1 ioctl }
> +class CLASS2 inherits COMMON1
> +class CLASS3 inherits COMMON1 { PERM1 }
> +default_user { CLASS1 } source;
> +default_role { CLASS2 } target;
> +default_type { CLASS3 } source;
> +policycap open_perms;
> +attribute ATTR1;
> +attribute ATTR2;
> +bool BOOL1 true;
> +type TYPE1;
> +type TYPE2;
> +type TYPE3;
> +type TYPE4;
> +typealias TYPE1 alias TYPEALIAS1;
> +typealias TYPE3 alias TYPEALIAS3A;
> +typealias TYPE3 alias TYPEALIAS3B;
> +typealias TYPE4 alias TYPEALIAS4;
> +typebounds TYPE4 TYPE3;
> +typeattribute TYPE4 ATTR2;
> +permissive TYPE1;
> +allow TYPE1 self:CLASS1 { PERM1 };
> +allow TYPE1 self:CLASS2 { CPERM1 };
> +auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
> +auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
> +dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
> +dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
> +allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x1 };
> +auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
> +dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
> +type_transition TYPE1 TYPE2:CLASS1 TYPE3;
> +type_member TYPE1 TYPE2:CLASS1 TYPE2;
> +type_change TYPE1 TYPE2:CLASS1 TYPE3;
> +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
> +if (BOOL1) {
> +} else {
> +    allow TYPE1 self:CLASS1 { ioctl };
> +}
> +role ROLE1;
> +role ROLE2;
> +role ROLE3;
> +role ROLE1 types { TYPE1 };
> +role_transition ROLE1 TYPE1:CLASS1 ROLE2;
> +role_transition ROLE1 TYPE1:process ROLE2;
> +allow ROLE1 ROLE2;
> +user USER1 roles ROLE1;
> +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=3D =
t2));
> +validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
> +sid kernel USER1:ROLE1:TYPE1
> +fs_use_xattr btrfs USER1:ROLE1:TYPE1;
> +fs_use_trans devpts USER1:ROLE1:TYPE1;
> +fs_use_task pipefs USER1:ROLE1:TYPE1;
> +genfscon proc "/" -d USER1:ROLE1:TYPE1
> +genfscon proc "/file1" -- USER1:ROLE1:TYPE1
> +genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
> +portcon tcp 80 USER1:ROLE1:TYPE1
> +portcon udp 100-200 USER1:ROLE1:TYPE1
> +netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
> +nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:R=
OLE1:TYPE1
> +ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1
> +ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1
> +ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
> +ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1
> diff --git a/checkpolicy/tests/policy_allonce_mls.conf b/checkpolicy/test=
s/policy_allonce_mls.conf
> new file mode 100644
> index 00000000..eeeaa6e9
> --- /dev/null
> +++ b/checkpolicy/tests/policy_allonce_mls.conf
> @@ -0,0 +1,92 @@
> +# handle_unknown deny
> +class CLASS1
> +class CLASS2
> +class CLASS3
> +class dir
> +class file
> +class process
> +sid kernel
> +common COMMON1 { CPERM1 }
> +class CLASS1 { PERM1 ioctl }
> +class CLASS2 inherits COMMON1
> +class CLASS3 inherits COMMON1 { PERM1 }
> +default_user { CLASS1 } source;
> +default_role { CLASS2 } target;
> +default_type { CLASS3 } source;
> +sensitivity s0;
> +sensitivity s1;
> +sensitivity s2 alias SENSALIAS;
> +dominance { s0 s1 SENSALIAS }
> +category c0;
> +category c1 alias CATALIAS;
> +level s0:c0;
> +level s1:c0,c1;
> +level s2;
> +mlsconstrain CLASS1 { PERM1 } l1 =3D=3D l2;
> +mlsvalidatetrans CLASS1 r1 domby r2 and l1 incomp h2;
> +policycap open_perms;
> +attribute ATTR1;
> +attribute ATTR2;
> +expandattribute ATTR1 true;
> +expandattribute ATTR2 false;
> +type TYPE1;
> +type TYPE2, ATTR1;
> +type TYPE3 alias { TYPEALIAS3A TYPEALIAS3B };
> +type TYPE4 alias TYPEALIAS4, ATTR2;
> +typealias TYPE1 alias TYPEALIAS1;
> +typeattribute TYPE1 ATTR1;
> +typebounds TYPE4 TYPE3;
> +bool BOOL1 true;
> +tunable TUNABLE1 false;
> +tunable TUNABLE2 true;
> +type_transition TYPE1 TYPE2 : CLASS1 TYPE3;
> +type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
";
> +type_member TYPE1 TYPE2 : CLASS1 TYPE2;
> +type_change TYPE1 TYPE2 : CLASS1 TYPE3;
> +range_transition TYPE1 TYPE2 : CLASS1 s1:c0.c1;
> +allow TYPE1 self : CLASS1 { PERM1 };
> +auditallow { TYPE1 TYPE2 } TYPE3 : CLASS1 { PERM1 };
> +dontaudit TYPE1 { TYPE2 TYPE3 } : CLASS3 { PERM1 CPERM1 };
> +neverallow TYPE1 TYPE2 : { CLASS2 CLASS3 } { CPERM1 };
> +allowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x1;
> +auditallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x2;
> +dontauditxperm TYPE1 TYPE2 : CLASS1 ioctl 0x3;
> +neverallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x4;
> +permissive TYPE1;
> +attribute_role ROLE_ATTR1;
> +role ROLE1;
> +role ROLE3;
> +role ROLE2, ROLE_ATTR1;
> +dominance { role ROLE1 { role ROLE3; } }
> +role_transition ROLE1 TYPE1 ROLE2;
> +role_transition ROLE1 TYPE1 : CLASS1 ROLE2;
> +allow ROLE1 ROLE2;
> +roleattribute ROLE3 ROLE_ATTR1;
> +role ROLE1 types { TYPE1 };
> +if ! BOOL1 { allow TYPE1 self: CLASS1 *; }
> +if TUNABLE1 xor TUNABLE2 { allow TYPE1 self: CLASS2 *; } else { allow TY=
PE1 self: CLASS3 *; }
> +optional { require { class CLASS2 { CPERM1 }; } allow TYPE1 self: CLASS2=
 *; }
> +user USER1 roles ROLE1 level s0 range s0 - s1:c0.c1;
> +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=3D =
t2));
> +# sameuser will be turned into (u1 =3D=3D u2)
> +validatetrans CLASS2 sameuser and t3 =3D=3D ATTR1;
> +sid kernel USER1:ROLE1:TYPE1:s0 - s1:c0.c1
> +# fscon statements are not dumped
> +fscon 2 3 USER1:ROLE1:TYPE1:s0 USER1:ROLE1:TYPE1:s0
> +fs_use_xattr btrfs USER1:ROLE1:TYPE1:s0 - s1:c0.CATALIAS;
> +fs_use_trans devpts USER1:ROLE1:TYPE1:s0 - s0;
> +fs_use_task pipefs USER1:ROLE1:TYPE1:s0 - s1;
> +# paths will be turned into quoted strings
> +genfscon proc / -d USER1:ROLE1:TYPE1:s0
> +genfscon proc "/file1" -- USER1:ROLE1:TYPE1:s0
> +genfscon proc "/path/to/file" USER1:ROLE1:TYPE1:s0
> +portcon tcp 80 USER1:ROLE1:TYPE1:s0
> +portcon udp 100-200 USER1:ROLE1:TYPE1:s0
> +netifcon lo USER1:ROLE1:TYPE1:s0 USER1:ROLE1:TYPE1:s0
> +nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1:s0
> +nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:R=
OLE1:TYPE1:s0
> +# hex numbers will be turned in decimal ones
> +ibpkeycon fe80:: 0xFFFF USER1:ROLE1:TYPE1:s0
> +ibpkeycon fe80:: 0-0x10 USER1:ROLE1:TYPE1:s0
> +ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1:s0
> +ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1:s0
> diff --git a/checkpolicy/tests/policy_allonce_mls.expected.conf b/checkpo=
licy/tests/policy_allonce_mls.expected.conf
> new file mode 100644
> index 00000000..87c36f92
> --- /dev/null
> +++ b/checkpolicy/tests/policy_allonce_mls.expected.conf
> @@ -0,0 +1,88 @@
> +# handle_unknown deny
> +class CLASS1
> +class CLASS2
> +class CLASS3
> +class dir
> +class file
> +class process
> +sid kernel
> +common COMMON1 { CPERM1 }
> +class CLASS1 { PERM1 ioctl }
> +class CLASS2 inherits COMMON1
> +class CLASS3 inherits COMMON1 { PERM1 }
> +default_user { CLASS1 } source;
> +default_role { CLASS2 } target;
> +default_type { CLASS3 } source;
> +sensitivity s0;
> +sensitivity s1;
> +sensitivity s2 alias SENSALIAS;
> +dominance { s0 s1 s2 }
> +category c0;
> +category c1 alias CATALIAS;
> +level s0:c0;
> +level s1:c0,c1;
> +level s2;
> +mlsconstrain CLASS1 { PERM1 } l1 =3D=3D l2;
> +mlsvalidatetrans CLASS1 (r1 domby r2 and l1 incomp h2);
> +policycap open_perms;
> +attribute ATTR1;
> +attribute ATTR2;
> +bool BOOL1 true;
> +type TYPE1;
> +type TYPE2;
> +type TYPE3;
> +type TYPE4;
> +typealias TYPE1 alias TYPEALIAS1;
> +typealias TYPE3 alias TYPEALIAS3A;
> +typealias TYPE3 alias TYPEALIAS3B;
> +typealias TYPE4 alias TYPEALIAS4;
> +typebounds TYPE4 TYPE3;
> +typeattribute TYPE4 ATTR2;
> +permissive TYPE1;
> +allow TYPE1 self:CLASS1 { PERM1 };
> +allow TYPE1 self:CLASS2 { CPERM1 };
> +auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
> +auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
> +dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
> +dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
> +allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x1 };
> +auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
> +dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
> +type_transition TYPE1 TYPE2:CLASS1 TYPE3;
> +type_member TYPE1 TYPE2:CLASS1 TYPE2;
> +type_change TYPE1 TYPE2:CLASS1 TYPE3;
> +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
> +range_transition TYPE1 TYPE2:CLASS1 s1:c0,c1 - s1:c0,c1;
> +if (BOOL1) {
> +} else {
> +    allow TYPE1 self:CLASS1 { PERM1 ioctl };
> +}
> +role ROLE1;
> +role ROLE2;
> +role ROLE3;
> +role ROLE1 types { TYPE1 };
> +role_transition ROLE1 TYPE1:CLASS1 ROLE2;
> +role_transition ROLE1 TYPE1:process ROLE2;
> +allow ROLE1 ROLE2;
> +user USER1 roles ROLE1 level s0 range s0 - s1:c0,c1;
> +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=3D =
t2));
> +validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
> +sid kernel USER1:ROLE1:TYPE1:s0 - s1:c0,c1
> +fs_use_xattr btrfs USER1:ROLE1:TYPE1:s0 - s1:c0,c1;
> +fs_use_trans devpts USER1:ROLE1:TYPE1:s0 - s0;
> +fs_use_task pipefs USER1:ROLE1:TYPE1:s0 - s1;
> +genfscon proc "/" -d USER1:ROLE1:TYPE1:s0 - s0
> +genfscon proc "/file1" -- USER1:ROLE1:TYPE1:s0 - s0
> +genfscon proc "/path/to/file" USER1:ROLE1:TYPE1:s0 - s0
> +portcon tcp 80 USER1:ROLE1:TYPE1:s0 - s0
> +portcon udp 100-200 USER1:ROLE1:TYPE1:s0 - s0
> +netifcon lo USER1:ROLE1:TYPE1:s0 - s0 USER1:ROLE1:TYPE1:s0 - s0
> +nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1:s0 - s0
> +nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:R=
OLE1:TYPE1:s0 - s0
> +ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1:s0 - s0
> +ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1:s0 - s0
> +ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1:s0 - s0
> +ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1:s0 - s0
> diff --git a/checkpolicy/tests/policy_allonce_mls.expected_opt.conf b/che=
ckpolicy/tests/policy_allonce_mls.expected_opt.conf
> new file mode 100644
> index 00000000..38176166
> --- /dev/null
> +++ b/checkpolicy/tests/policy_allonce_mls.expected_opt.conf
> @@ -0,0 +1,88 @@
> +# handle_unknown deny
> +class CLASS1
> +class CLASS2
> +class CLASS3
> +class dir
> +class file
> +class process
> +sid kernel
> +common COMMON1 { CPERM1 }
> +class CLASS1 { PERM1 ioctl }
> +class CLASS2 inherits COMMON1
> +class CLASS3 inherits COMMON1 { PERM1 }
> +default_user { CLASS1 } source;
> +default_role { CLASS2 } target;
> +default_type { CLASS3 } source;
> +sensitivity s0;
> +sensitivity s1;
> +sensitivity s2 alias SENSALIAS;
> +dominance { s0 s1 s2 }
> +category c0;
> +category c1 alias CATALIAS;
> +level s0:c0;
> +level s1:c0,c1;
> +level s2;
> +mlsconstrain CLASS1 { PERM1 } l1 =3D=3D l2;
> +mlsvalidatetrans CLASS1 (r1 domby r2 and l1 incomp h2);
> +policycap open_perms;
> +attribute ATTR1;
> +attribute ATTR2;
> +bool BOOL1 true;
> +type TYPE1;
> +type TYPE2;
> +type TYPE3;
> +type TYPE4;
> +typealias TYPE1 alias TYPEALIAS1;
> +typealias TYPE3 alias TYPEALIAS3A;
> +typealias TYPE3 alias TYPEALIAS3B;
> +typealias TYPE4 alias TYPEALIAS4;
> +typebounds TYPE4 TYPE3;
> +typeattribute TYPE4 ATTR2;
> +permissive TYPE1;
> +allow TYPE1 self:CLASS1 { PERM1 };
> +allow TYPE1 self:CLASS2 { CPERM1 };
> +auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
> +auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
> +dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
> +dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
> +allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x1 };
> +auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
> +dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
> +type_transition TYPE1 TYPE2:CLASS1 TYPE3;
> +type_member TYPE1 TYPE2:CLASS1 TYPE2;
> +type_change TYPE1 TYPE2:CLASS1 TYPE3;
> +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
> +range_transition TYPE1 TYPE2:CLASS1 s1:c0,c1 - s1:c0,c1;
> +if (BOOL1) {
> +} else {
> +    allow TYPE1 self:CLASS1 { ioctl };
> +}
> +role ROLE1;
> +role ROLE2;
> +role ROLE3;
> +role ROLE1 types { TYPE1 };
> +role_transition ROLE1 TYPE1:CLASS1 ROLE2;
> +role_transition ROLE1 TYPE1:process ROLE2;
> +allow ROLE1 ROLE2;
> +user USER1 roles ROLE1 level s0 range s0 - s1:c0,c1;
> +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=3D =
t2));
> +validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
> +sid kernel USER1:ROLE1:TYPE1:s0 - s1:c0,c1
> +fs_use_xattr btrfs USER1:ROLE1:TYPE1:s0 - s1:c0,c1;
> +fs_use_trans devpts USER1:ROLE1:TYPE1:s0 - s0;
> +fs_use_task pipefs USER1:ROLE1:TYPE1:s0 - s1;
> +genfscon proc "/" -d USER1:ROLE1:TYPE1:s0 - s0
> +genfscon proc "/file1" -- USER1:ROLE1:TYPE1:s0 - s0
> +genfscon proc "/path/to/file" USER1:ROLE1:TYPE1:s0 - s0
> +portcon tcp 80 USER1:ROLE1:TYPE1:s0 - s0
> +portcon udp 100-200 USER1:ROLE1:TYPE1:s0 - s0
> +netifcon lo USER1:ROLE1:TYPE1:s0 - s0 USER1:ROLE1:TYPE1:s0 - s0
> +nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1:s0 - s0
> +nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1:R=
OLE1:TYPE1:s0 - s0
> +ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1:s0 - s0
> +ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1:s0 - s0
> +ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1:s0 - s0
> +ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1:s0 - s0
> diff --git a/checkpolicy/tests/policy_allonce_xen.conf b/checkpolicy/test=
s/policy_allonce_xen.conf
> new file mode 100644
> index 00000000..6402683a
> --- /dev/null
> +++ b/checkpolicy/tests/policy_allonce_xen.conf
> @@ -0,0 +1,62 @@
> +# handle_unknown deny
> +class CLASS1
> +class CLASS2
> +class CLASS3
> +class dir
> +class file
> +class process
> +sid kernel
> +common COMMON1 { CPERM1 }
> +class CLASS1 { PERM1 }
> +class CLASS2 inherits COMMON1
> +class CLASS3 inherits COMMON1 { PERM1 }
> +default_user { CLASS1 } source;
> +default_role { CLASS2 } target;
> +default_type { CLASS3 } source;
> +attribute ATTR1;
> +attribute ATTR2;
> +expandattribute ATTR1 true;
> +expandattribute ATTR2 false;
> +type TYPE1;
> +type TYPE2, ATTR1;
> +type TYPE3 alias { TYPEALIAS3A TYPEALIAS3B };
> +type TYPE4 alias TYPEALIAS4, ATTR2;
> +typealias TYPE1 alias TYPEALIAS1;
> +typeattribute TYPE1 ATTR1;
> +typebounds TYPE4 TYPE3;
> +bool BOOL1 true;
> +tunable TUNABLE1 false;
> +tunable TUNABLE2 true;
> +type_transition TYPE1 TYPE2 : CLASS1 TYPE3;
> +type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
";
> +type_member TYPE1 TYPE2 : CLASS1 TYPE2;
> +type_change TYPE1 TYPE2 : CLASS1 TYPE3;
> +allow TYPE1 self : CLASS1 { PERM1 };
> +auditallow { TYPE1 TYPE2 } TYPE3 : CLASS1 { PERM1 };
> +dontaudit TYPE1 { TYPE2 TYPE3 } : CLASS3 { PERM1 CPERM1 };
> +neverallow TYPE1 TYPE2 : { CLASS2 CLASS3 } { CPERM1 };
> +permissive TYPE1;
> +attribute_role ROLE_ATTR1;
> +role ROLE1;
> +role ROLE3;
> +role ROLE2, ROLE_ATTR1;
> +role_transition ROLE1 TYPE1 ROLE2;
> +role_transition ROLE1 TYPE1 : CLASS1 ROLE2;
> +allow ROLE1 ROLE2;
> +roleattribute ROLE3 ROLE_ATTR1;
> +role ROLE1 types { TYPE1 };
> +if ! BOOL1 { allow TYPE1 self: CLASS1 *; }
> +if TUNABLE1 xor TUNABLE2 { allow TYPE1 self: CLASS2 *; } else { allow TY=
PE1 self: CLASS3 *; }
> +optional { require { class CLASS2 { CPERM1 }; } allow TYPE1 self: CLASS2=
 *; }
> +policycap open_perms;
> +user USER1 roles ROLE1;
> +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=3D =
t2));
> +validatetrans CLASS2 sameuser and t3 =3D=3D ATTR1;
> +sid kernel USER1:ROLE1:TYPE1
> +pirqcon 13 USER1:ROLE1:TYPE1
> +iomemcon 13 USER1:ROLE1:TYPE1
> +iomemcon 23-31 USER1:ROLE1:TYPE1
> +ioportcon 13 USER1:ROLE1:TYPE1
> +ioportcon 23-31 USER1:ROLE1:TYPE1
> +pcidevicecon 13 USER1:ROLE1:TYPE1
> +devicetreecon "/path/to/device" USER1:ROLE1:TYPE1
> diff --git a/checkpolicy/tests/policy_allonce_xen.expected.conf b/checkpo=
licy/tests/policy_allonce_xen.expected.conf
> new file mode 100644
> index 00000000..a4573ccb
> --- /dev/null
> +++ b/checkpolicy/tests/policy_allonce_xen.expected.conf
> @@ -0,0 +1,65 @@
> +# handle_unknown deny
> +class CLASS1
> +class CLASS2
> +class CLASS3
> +class dir
> +class file
> +class process
> +sid xen
> +common COMMON1 { CPERM1 }
> +class CLASS1 { PERM1 }
> +class CLASS2 inherits COMMON1
> +class CLASS3 inherits COMMON1 { PERM1 }
> +default_user { CLASS1 } source;
> +default_role { CLASS2 } target;
> +default_type { CLASS3 } source;
> +policycap open_perms;
> +attribute ATTR1;
> +attribute ATTR2;
> +bool BOOL1 true;
> +type TYPE1;
> +type TYPE2;
> +type TYPE3;
> +type TYPE4;
> +typealias TYPE1 alias TYPEALIAS1;
> +typealias TYPE3 alias TYPEALIAS3A;
> +typealias TYPE3 alias TYPEALIAS3B;
> +typealias TYPE4 alias TYPEALIAS4;
> +typebounds TYPE4 TYPE3;
> +typeattribute TYPE4 ATTR2;
> +permissive TYPE1;
> +allow TYPE1 self:CLASS1 { PERM1 };
> +allow TYPE1 self:CLASS2 { CPERM1 };
> +auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
> +auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
> +dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
> +dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
> +type_transition TYPE1 TYPE2:CLASS1 TYPE3;
> +type_member TYPE1 TYPE2:CLASS1 TYPE2;
> +type_change TYPE1 TYPE2:CLASS1 TYPE3;
> +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
> +if (BOOL1) {
> +} else {
> +    allow TYPE1 self:CLASS1 { PERM1 };
> +}
> +role ROLE1;
> +role ROLE2;
> +role ROLE3;
> +role ROLE1 types { TYPE1 };
> +role_transition ROLE1 TYPE1:CLASS1 ROLE2;
> +role_transition ROLE1 TYPE1:process ROLE2;
> +allow ROLE1 ROLE2;
> +user USER1 roles ROLE1;
> +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=3D =
t2));
> +validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
> +sid xen USER1:ROLE1:TYPE1
> +pirqcon 13 USER1:ROLE1:TYPE1
> +iomemcon 0xd USER1:ROLE1:TYPE1
> +iomemcon 0x17-0x1f USER1:ROLE1:TYPE1
> +ioportcon 0xd USER1:ROLE1:TYPE1
> +ioportcon 0x17-0x1f USER1:ROLE1:TYPE1
> +pcidevicecon 0xd USER1:ROLE1:TYPE1
> +devicetreecon "/path/to/device" USER1:ROLE1:TYPE1
> diff --git a/checkpolicy/tests/policy_allonce_xen.expected_opt.conf b/che=
ckpolicy/tests/policy_allonce_xen.expected_opt.conf
> new file mode 100644
> index 00000000..8fd3b226
> --- /dev/null
> +++ b/checkpolicy/tests/policy_allonce_xen.expected_opt.conf
> @@ -0,0 +1,61 @@
> +# handle_unknown deny
> +class CLASS1
> +class CLASS2
> +class CLASS3
> +class dir
> +class file
> +class process
> +sid xen
> +common COMMON1 { CPERM1 }
> +class CLASS1 { PERM1 }
> +class CLASS2 inherits COMMON1
> +class CLASS3 inherits COMMON1 { PERM1 }
> +default_user { CLASS1 } source;
> +default_role { CLASS2 } target;
> +default_type { CLASS3 } source;
> +policycap open_perms;
> +attribute ATTR1;
> +attribute ATTR2;
> +bool BOOL1 true;
> +type TYPE1;
> +type TYPE2;
> +type TYPE3;
> +type TYPE4;
> +typealias TYPE1 alias TYPEALIAS1;
> +typealias TYPE3 alias TYPEALIAS3A;
> +typealias TYPE3 alias TYPEALIAS3B;
> +typealias TYPE4 alias TYPEALIAS4;
> +typebounds TYPE4 TYPE3;
> +typeattribute TYPE4 ATTR2;
> +permissive TYPE1;
> +allow TYPE1 self:CLASS1 { PERM1 };
> +allow TYPE1 self:CLASS2 { CPERM1 };
> +auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
> +auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
> +dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
> +dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
> +type_transition TYPE1 TYPE2:CLASS1 TYPE3;
> +type_member TYPE1 TYPE2:CLASS1 TYPE2;
> +type_change TYPE1 TYPE2:CLASS1 TYPE3;
> +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
> +role ROLE1;
> +role ROLE2;
> +role ROLE3;
> +role ROLE1 types { TYPE1 };
> +role_transition ROLE1 TYPE1:CLASS1 ROLE2;
> +role_transition ROLE1 TYPE1:process ROLE2;
> +allow ROLE1 ROLE2;
> +user USER1 roles ROLE1;
> +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=3D =
t2));
> +validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
> +sid xen USER1:ROLE1:TYPE1
> +pirqcon 13 USER1:ROLE1:TYPE1
> +iomemcon 0xd USER1:ROLE1:TYPE1
> +iomemcon 0x17-0x1f USER1:ROLE1:TYPE1
> +ioportcon 0xd USER1:ROLE1:TYPE1
> +ioportcon 0x17-0x1f USER1:ROLE1:TYPE1
> +pcidevicecon 0xd USER1:ROLE1:TYPE1
> +devicetreecon "/path/to/device" USER1:ROLE1:TYPE1
> diff --git a/checkpolicy/tests/policy_minimal.conf b/checkpolicy/tests/po=
licy_minimal.conf
> new file mode 100644
> index 00000000..e8cff6df
> --- /dev/null
> +++ b/checkpolicy/tests/policy_minimal.conf
> @@ -0,0 +1,10 @@
> +# handle_unknown deny
> +class CLASS1
> +sid kernel
> +class CLASS1 { PERM1 }
> +type TYPE1;
> +allow TYPE1 self:CLASS1 { PERM1 };
> +role ROLE1;
> +role ROLE1 types { TYPE1 };
> +user USER1 roles ROLE1;
> +sid kernel USER1:ROLE1:TYPE1
> diff --git a/checkpolicy/tests/policy_minimal_mls.conf b/checkpolicy/test=
s/policy_minimal_mls.conf
> new file mode 100644
> index 00000000..9ea65169
> --- /dev/null
> +++ b/checkpolicy/tests/policy_minimal_mls.conf
> @@ -0,0 +1,15 @@
> +# handle_unknown deny
> +class CLASS1
> +sid kernel
> +class CLASS1 { PERM1 }
> +sensitivity s0;
> +dominance { s0 }
> +category c0;
> +level s0:c0;
> +mlsconstrain CLASS1 { PERM1 } l1 =3D=3D l2;
> +type TYPE1;
> +allow TYPE1 self:CLASS1 { PERM1 };
> +role ROLE1;
> +role ROLE1 types { TYPE1 };
> +user USER1 roles ROLE1 level s0 range s0 - s0:c0;
> +sid kernel USER1:ROLE1:TYPE1:s0 - s0
> diff --git a/checkpolicy/tests/test_roundtrip.sh b/checkpolicy/tests/test=
_roundtrip.sh
> new file mode 100755
> index 00000000..d05b36bb
> --- /dev/null
> +++ b/checkpolicy/tests/test_roundtrip.sh
> @@ -0,0 +1,41 @@
> +#!/bin/sh
> +
> +set -eu
> +
> +BASEDIR=3D$(dirname "$0")
> +CHECKPOLICY=3D"${BASEDIR}/../checkpolicy"
> +
> +check_policy() {
> +       POLICY=3D$1
> +       EXPECTED=3D$2
> +       OPTS=3D$3
> +
> +       echo "=3D=3D=3D=3D Testing ${1}"
> +
> +       ${CHECKPOLICY} ${OPTS} "${BASEDIR}/${POLICY}" -o "${BASEDIR}/test=
pol.bin"
> +       ${CHECKPOLICY} ${OPTS} -b -F "${BASEDIR}/testpol.bin" -o "${BASED=
IR}/testpol.conf"
> +       diff -u "${BASEDIR}/${EXPECTED}" "${BASEDIR}/testpol.conf"
> +
> +       ${CHECKPOLICY} ${OPTS} "${BASEDIR}/${EXPECTED}" -o "${BASEDIR}/te=
stpol.bin"
> +       ${CHECKPOLICY} ${OPTS} -b -F "${BASEDIR}/testpol.bin" -o "${BASED=
IR}/testpol.conf"
> +       diff -u "${BASEDIR}/${EXPECTED}" "${BASEDIR}/testpol.conf"
> +
> +       echo "=3D=3D=3D=3D ${1} success"
> +       echo ""
> +}
> +
> +
> +check_policy  policy_minimal.conf      policy_minimal.conf              =
     '-E'
> +check_policy  policy_minimal.conf      policy_minimal.conf              =
     '-E -S -O'
> +
> +check_policy  policy_minimal_mls.conf  policy_minimal_mls.conf          =
     '-M -E'
> +check_policy  policy_minimal_mls.conf  policy_minimal_mls.conf          =
     '-M -E -S -O'
> +
> +check_policy  policy_allonce.conf      policy_allonce.expected.conf     =
     ''
> +check_policy  policy_allonce.conf      policy_allonce.expected_opt.conf =
     '-S -O'
> +
> +check_policy  policy_allonce_mls.conf  policy_allonce_mls.expected.conf =
     '-M'
> +check_policy  policy_allonce_mls.conf  policy_allonce_mls.expected_opt.c=
onf  '-M -S -O'
> +
> +check_policy  policy_allonce_xen.conf  policy_allonce_xen.expected.conf =
     '--target xen -c 30 -E'
> +check_policy  policy_allonce_xen.conf  policy_allonce_xen.expected_opt.c=
onf  '--target xen -c 30 -E -S -O'
> --
> 2.40.1
>
