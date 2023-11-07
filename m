Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F966C4332F
	for <selinux@archiver.kernel.org>; Tue,  7 Nov 2023 21:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjKGVmC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Nov 2023 16:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjKGVmB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Nov 2023 16:42:01 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66F310E4
        for <selinux@vger.kernel.org>; Tue,  7 Nov 2023 13:41:58 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507a62d4788so8390215e87.0
        for <selinux@vger.kernel.org>; Tue, 07 Nov 2023 13:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699393317; x=1699998117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRgE4aEcL4TQwa44rnP8J1K1SjR7nctfkuDNj7QFvvQ=;
        b=fW9OLPRRDKLB4Ri1Mpa6dvXGp1xUxX4MC8O462psvCVHuLWJXIxFouZsw+4Zn4jy8H
         mMcXCLjJoY8k6dZaiVFvgMAgEqZSfkVrdiEehF1o8iS5FK6MXSmF9gxx2DDcoXlqhoH7
         GmzWNhCkFybsSCAWC6cz1PolSnbndb4gYb7hm0IG3jGSaMC3HSABhIivw8pyu3ixw7jK
         rjmribcYSFjRqSew7046rzbRBJrv+OgNxn8mY5VFklojWR1wOfzBhrxJoudehMJEhg/Y
         glVEHxpZQXAF3tyGqzHerINDUs7uQbX7Rqgfb/DEZxbWkm+IZ2svSNdpRWDGsccdK5Rf
         Xowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393317; x=1699998117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRgE4aEcL4TQwa44rnP8J1K1SjR7nctfkuDNj7QFvvQ=;
        b=cP35Os+4mV8PnMANauJOnTGYTgfBRTw+MmWum4PNiLClidHFIbvTWnYgWN1CLcyRUn
         3aGlCoQUhqr+p/i+aPmFyB3y9jgmbzfs7JPJ1Pe/TAbloxpExhWYE5xcz+yKVsrY1IKF
         eZjtz3ZSVzOAYIYDn2ey7wxIwTkRBPBT7zDBGkM1dCP+2mVq+pjpI5vhUWbvMFQL1zWj
         B5hfiNnQwJSOwGVOHDmYesv7fPUW7LrOnYtE2L1LgDUu1e0a9nDHWYRddHoP+LAedh6U
         4H2eUCYTpXiV+duFf7ReaULWfQxDKzXCNeReKBNDhbVa6imyKhZWlulQ7S4j9kRjUo/7
         5FaA==
X-Gm-Message-State: AOJu0Yyb+1kaiO0ytNKn0Yw0xz3RwXPVWk9C0T3u96nM2iyEZ46lOazb
        Tp/ybBMn5ow3+aYsjbjxH3/nZn2/7kHtC00OOuVZPz6Q
X-Google-Smtp-Source: AGHT+IHCa+XfLQnBvbMMq0mT961aHgJ80BejffjVKJbP3yEMyHNgoZ75QxSYHCYm93Cepol3O0LuVQ5qmX2G2nmpUf8=
X-Received: by 2002:a05:6512:3b08:b0:509:494d:c3d5 with SMTP id
 f8-20020a0565123b0800b00509494dc3d5mr18772044lfv.26.1699393316628; Tue, 07
 Nov 2023 13:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20231101163700.176931-1-cgzones@googlemail.com> <CAP+JOzSwV70dX=J==DJp7FBNu8DUybUK0-NaHznCrH2kNXrO_w@mail.gmail.com>
In-Reply-To: <CAP+JOzSwV70dX=J==DJp7FBNu8DUybUK0-NaHznCrH2kNXrO_w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 7 Nov 2023 16:41:45 -0500
Message-ID: <CAP+JOzTOYu+ts-2R4Mw0jjVehkALKDdiNSMwZ+8kO=OkfOW5Vg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy: add round-trip tests
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 2, 2023 at 10:39=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Nov 1, 2023 at 12:37=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add round-trip tests for checkpolicy(8).
> > Test standard and MLS minimal policies as well as SELinux and Xen
> > policies with each available statement.
> > The output is checked against an expected result and then then checked
> > for idempotence.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > v2:
> >    drop usage of removed role dominance rules
> > ---
> >  checkpolicy/.gitignore                        |  2 +
> >  checkpolicy/Makefile                          |  6 +-
> >  checkpolicy/tests/policy_allonce.conf         | 79 ++++++++++++++++
> >  .../tests/policy_allonce.expected.conf        | 76 ++++++++++++++++
> >  .../tests/policy_allonce.expected_opt.conf    | 76 ++++++++++++++++
> >  checkpolicy/tests/policy_allonce_mls.conf     | 91 +++++++++++++++++++
> >  .../tests/policy_allonce_mls.expected.conf    | 88 ++++++++++++++++++
> >  .../policy_allonce_mls.expected_opt.conf      | 88 ++++++++++++++++++
> >  checkpolicy/tests/policy_allonce_xen.conf     | 62 +++++++++++++
> >  .../tests/policy_allonce_xen.expected.conf    | 65 +++++++++++++
> >  .../policy_allonce_xen.expected_opt.conf      | 61 +++++++++++++
> >  checkpolicy/tests/policy_minimal.conf         | 10 ++
> >  checkpolicy/tests/policy_minimal_mls.conf     | 15 +++
> >  checkpolicy/tests/test_roundtrip.sh           | 41 +++++++++
> >  14 files changed, 759 insertions(+), 1 deletion(-)
> >  create mode 100644 checkpolicy/tests/policy_allonce.conf
> >  create mode 100644 checkpolicy/tests/policy_allonce.expected.conf
> >  create mode 100644 checkpolicy/tests/policy_allonce.expected_opt.conf
> >  create mode 100644 checkpolicy/tests/policy_allonce_mls.conf
> >  create mode 100644 checkpolicy/tests/policy_allonce_mls.expected.conf
> >  create mode 100644 checkpolicy/tests/policy_allonce_mls.expected_opt.c=
onf
> >  create mode 100644 checkpolicy/tests/policy_allonce_xen.conf
> >  create mode 100644 checkpolicy/tests/policy_allonce_xen.expected.conf
> >  create mode 100644 checkpolicy/tests/policy_allonce_xen.expected_opt.c=
onf
> >  create mode 100644 checkpolicy/tests/policy_minimal.conf
> >  create mode 100644 checkpolicy/tests/policy_minimal_mls.conf
> >  create mode 100755 checkpolicy/tests/test_roundtrip.sh
> >
> > diff --git a/checkpolicy/.gitignore b/checkpolicy/.gitignore
> > index a7bd076d..01a694d4 100644
> > --- a/checkpolicy/.gitignore
> > +++ b/checkpolicy/.gitignore
> > @@ -3,3 +3,5 @@ checkpolicy
> >  lex.yy.c
> >  y.tab.c
> >  y.tab.h
> > +tests/testpol.bin
> > +tests/testpol.conf
> > diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> > index c37e0310..281d15be 100644
> > --- a/checkpolicy/Makefile
> > +++ b/checkpolicy/Makefile
> > @@ -50,6 +50,10 @@ y.tab.c: policy_parse.y
> >  lex.yy.c: policy_scan.l y.tab.c
> >         $(LEX) policy_scan.l
> >
> > +.PHONY: test
> > +test: checkpolicy
> > +       ./tests/test_roundtrip.sh
> > +
> >  install: all
> >         -mkdir -p $(DESTDIR)$(BINDIR)
> >         -mkdir -p $(DESTDIR)$(MANDIR)/man8
> > @@ -68,7 +72,7 @@ relabel: install
> >         /sbin/restorecon $(DESTDIR)$(BINDIR)/checkmodule
> >
> >  clean:
> > -       -rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab=
.h lex.yy.c
> > +       -rm -f $(TARGETS) $(CHECKPOLOBJS) $(CHECKMODOBJS) y.tab.c y.tab=
.h lex.yy.c tests/testpol.conf tests/testpol.bin
> >         $(MAKE) -C test clean
> >
> >  indent:
> > diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/=
policy_allonce.conf
> > new file mode 100644
> > index 00000000..34e6402d
> > --- /dev/null
> > +++ b/checkpolicy/tests/policy_allonce.conf
> > @@ -0,0 +1,79 @@
> > +# handle_unknown deny
> > +class CLASS1
> > +class CLASS2
> > +class CLASS3
> > +class dir
> > +class file
> > +class process
> > +sid kernel
> > +common COMMON1 { CPERM1 }
> > +class CLASS1 { PERM1 ioctl }
> > +class CLASS2 inherits COMMON1
> > +class CLASS3 inherits COMMON1 { PERM1 }
> > +default_user { CLASS1 } source;
> > +default_role { CLASS2 } target;
> > +default_type { CLASS3 } source;
> > +policycap open_perms;
> > +attribute ATTR1;
> > +attribute ATTR2;
> > +expandattribute ATTR1 true;
> > +expandattribute ATTR2 false;
> > +type TYPE1;
> > +type TYPE2, ATTR1;
> > +type TYPE3 alias { TYPEALIAS3A TYPEALIAS3B };
> > +type TYPE4 alias TYPEALIAS4, ATTR2;
> > +typealias TYPE1 alias TYPEALIAS1;
> > +typeattribute TYPE1 ATTR1;
> > +typebounds TYPE4 TYPE3;
> > +bool BOOL1 true;
> > +tunable TUNABLE1 false;
> > +tunable TUNABLE2 true;
> > +type_transition TYPE1 TYPE2 : CLASS1 TYPE3;
> > +type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENA=
ME";
> > +type_member TYPE1 TYPE2 : CLASS1 TYPE2;
> > +type_change TYPE1 TYPE2 : CLASS1 TYPE3;
> > +allow TYPE1 self : CLASS1 { PERM1 };
> > +auditallow { TYPE1 TYPE2 } TYPE3 : CLASS1 { PERM1 };
> > +dontaudit TYPE1 { TYPE2 TYPE3 } : CLASS3 { PERM1 CPERM1 };
> > +neverallow TYPE1 TYPE2 : { CLASS2 CLASS3 } { CPERM1 };
> > +allowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x1;
> > +auditallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x2;
> > +dontauditxperm TYPE1 TYPE2 : CLASS1 ioctl 0x3;
> > +neverallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x4;
> > +permissive TYPE1;
> > +attribute_role ROLE_ATTR1;
> > +role ROLE1;
> > +role ROLE3;
> > +role ROLE2, ROLE_ATTR1;
> > +role_transition ROLE1 TYPE1 ROLE2;
> > +role_transition ROLE1 TYPE1 : CLASS1 ROLE2;
> > +allow ROLE1 ROLE2;
> > +roleattribute ROLE3 ROLE_ATTR1;
> > +role ROLE1 types { TYPE1 };
> > +if ! BOOL1 { allow TYPE1 self: CLASS1 *; }
> > +if TUNABLE1 xor TUNABLE2 { allow TYPE1 self: CLASS2 *; } else { allow =
TYPE1 self: CLASS3 *; }
> > +optional { require { class CLASS2 { CPERM1 }; } allow TYPE1 self: CLAS=
S2 *; }
> > +user USER1 roles ROLE1;
> > +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=
=3D t2));
> > +# sameuser will be turned into (u1 =3D=3D u2)
> > +validatetrans CLASS2 sameuser and t3 =3D=3D ATTR1;
> > +sid kernel USER1:ROLE1:TYPE1
> > +# fscon statements are not dumped
> > +fscon 2 3 USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +fs_use_xattr btrfs USER1:ROLE1:TYPE1;
> > +fs_use_trans devpts USER1:ROLE1:TYPE1;
> > +fs_use_task pipefs USER1:ROLE1:TYPE1;
> > +# paths will be turned into quoted strings
> > +genfscon proc / -d USER1:ROLE1:TYPE1
> > +genfscon proc "/file1" -- USER1:ROLE1:TYPE1
> > +genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
> > +portcon tcp 80 USER1:ROLE1:TYPE1
> > +portcon udp 100-200 USER1:ROLE1:TYPE1
> > +netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
> > +nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1=
:ROLE1:TYPE1
> > +# hex numbers will be turned in decimal ones
> > +ibpkeycon fe80:: 0xFFFF USER1:ROLE1:TYPE1
> > +ibpkeycon fe80:: 0-0x10 USER1:ROLE1:TYPE1
> > +ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
> > +ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1
> > diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpoli=
cy/tests/policy_allonce.expected.conf
> > new file mode 100644
> > index 00000000..63739e1f
> > --- /dev/null
> > +++ b/checkpolicy/tests/policy_allonce.expected.conf
> > @@ -0,0 +1,76 @@
> > +# handle_unknown deny
> > +class CLASS1
> > +class CLASS2
> > +class CLASS3
> > +class dir
> > +class file
> > +class process
> > +sid kernel
> > +common COMMON1 { CPERM1 }
> > +class CLASS1 { PERM1 ioctl }
> > +class CLASS2 inherits COMMON1
> > +class CLASS3 inherits COMMON1 { PERM1 }
> > +default_user { CLASS1 } source;
> > +default_role { CLASS2 } target;
> > +default_type { CLASS3 } source;
> > +policycap open_perms;
> > +attribute ATTR1;
> > +attribute ATTR2;
> > +bool BOOL1 true;
> > +type TYPE1;
> > +type TYPE2;
> > +type TYPE3;
> > +type TYPE4;
> > +typealias TYPE1 alias TYPEALIAS1;
> > +typealias TYPE3 alias TYPEALIAS3A;
> > +typealias TYPE3 alias TYPEALIAS3B;
> > +typealias TYPE4 alias TYPEALIAS4;
> > +typebounds TYPE4 TYPE3;
> > +typeattribute TYPE4 ATTR2;
> > +permissive TYPE1;
> > +allow TYPE1 self:CLASS1 { PERM1 };
> > +allow TYPE1 self:CLASS2 { CPERM1 };
> > +auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
> > +auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
> > +dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
> > +dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
> > +allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x1 };
> > +auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
> > +dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
> > +type_transition TYPE1 TYPE2:CLASS1 TYPE3;
> > +type_member TYPE1 TYPE2:CLASS1 TYPE2;
> > +type_change TYPE1 TYPE2:CLASS1 TYPE3;
> > +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
> > +if (BOOL1) {
> > +} else {
> > +    allow TYPE1 self:CLASS1 { PERM1 ioctl };
> > +}
> > +role ROLE1;
> > +role ROLE2;
> > +role ROLE3;
> > +role ROLE1 types { TYPE1 };
> > +role_transition ROLE1 TYPE1:CLASS1 ROLE2;
> > +role_transition ROLE1 TYPE1:process ROLE2;
> > +allow ROLE1 ROLE2;
> > +user USER1 roles ROLE1;
> > +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=
=3D t2));
> > +validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
> > +sid kernel USER1:ROLE1:TYPE1
> > +fs_use_xattr btrfs USER1:ROLE1:TYPE1;
> > +fs_use_trans devpts USER1:ROLE1:TYPE1;
> > +fs_use_task pipefs USER1:ROLE1:TYPE1;
> > +genfscon proc "/" -d USER1:ROLE1:TYPE1
> > +genfscon proc "/file1" -- USER1:ROLE1:TYPE1
> > +genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
> > +portcon tcp 80 USER1:ROLE1:TYPE1
> > +portcon udp 100-200 USER1:ROLE1:TYPE1
> > +netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
> > +nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1=
:ROLE1:TYPE1
> > +ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1
> > +ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1
> > +ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
> > +ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1
> > diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/check=
policy/tests/policy_allonce.expected_opt.conf
> > new file mode 100644
> > index 00000000..1c969961
> > --- /dev/null
> > +++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
> > @@ -0,0 +1,76 @@
> > +# handle_unknown deny
> > +class CLASS1
> > +class CLASS2
> > +class CLASS3
> > +class dir
> > +class file
> > +class process
> > +sid kernel
> > +common COMMON1 { CPERM1 }
> > +class CLASS1 { PERM1 ioctl }
> > +class CLASS2 inherits COMMON1
> > +class CLASS3 inherits COMMON1 { PERM1 }
> > +default_user { CLASS1 } source;
> > +default_role { CLASS2 } target;
> > +default_type { CLASS3 } source;
> > +policycap open_perms;
> > +attribute ATTR1;
> > +attribute ATTR2;
> > +bool BOOL1 true;
> > +type TYPE1;
> > +type TYPE2;
> > +type TYPE3;
> > +type TYPE4;
> > +typealias TYPE1 alias TYPEALIAS1;
> > +typealias TYPE3 alias TYPEALIAS3A;
> > +typealias TYPE3 alias TYPEALIAS3B;
> > +typealias TYPE4 alias TYPEALIAS4;
> > +typebounds TYPE4 TYPE3;
> > +typeattribute TYPE4 ATTR2;
> > +permissive TYPE1;
> > +allow TYPE1 self:CLASS1 { PERM1 };
> > +allow TYPE1 self:CLASS2 { CPERM1 };
> > +auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
> > +auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
> > +dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
> > +dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
> > +allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x1 };
> > +auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
> > +dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
> > +type_transition TYPE1 TYPE2:CLASS1 TYPE3;
> > +type_member TYPE1 TYPE2:CLASS1 TYPE2;
> > +type_change TYPE1 TYPE2:CLASS1 TYPE3;
> > +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
> > +if (BOOL1) {
> > +} else {
> > +    allow TYPE1 self:CLASS1 { ioctl };
> > +}
> > +role ROLE1;
> > +role ROLE2;
> > +role ROLE3;
> > +role ROLE1 types { TYPE1 };
> > +role_transition ROLE1 TYPE1:CLASS1 ROLE2;
> > +role_transition ROLE1 TYPE1:process ROLE2;
> > +allow ROLE1 ROLE2;
> > +user USER1 roles ROLE1;
> > +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=
=3D t2));
> > +validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
> > +sid kernel USER1:ROLE1:TYPE1
> > +fs_use_xattr btrfs USER1:ROLE1:TYPE1;
> > +fs_use_trans devpts USER1:ROLE1:TYPE1;
> > +fs_use_task pipefs USER1:ROLE1:TYPE1;
> > +genfscon proc "/" -d USER1:ROLE1:TYPE1
> > +genfscon proc "/file1" -- USER1:ROLE1:TYPE1
> > +genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
> > +portcon tcp 80 USER1:ROLE1:TYPE1
> > +portcon udp 100-200 USER1:ROLE1:TYPE1
> > +netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> > +nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
> > +nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1=
:ROLE1:TYPE1
> > +ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1
> > +ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1
> > +ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1
> > +ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1
> > diff --git a/checkpolicy/tests/policy_allonce_mls.conf b/checkpolicy/te=
sts/policy_allonce_mls.conf
> > new file mode 100644
> > index 00000000..c88616b3
> > --- /dev/null
> > +++ b/checkpolicy/tests/policy_allonce_mls.conf
> > @@ -0,0 +1,91 @@
> > +# handle_unknown deny
> > +class CLASS1
> > +class CLASS2
> > +class CLASS3
> > +class dir
> > +class file
> > +class process
> > +sid kernel
> > +common COMMON1 { CPERM1 }
> > +class CLASS1 { PERM1 ioctl }
> > +class CLASS2 inherits COMMON1
> > +class CLASS3 inherits COMMON1 { PERM1 }
> > +default_user { CLASS1 } source;
> > +default_role { CLASS2 } target;
> > +default_type { CLASS3 } source;
> > +sensitivity s0;
> > +sensitivity s1;
> > +sensitivity s2 alias SENSALIAS;
> > +dominance { s0 s1 SENSALIAS }
> > +category c0;
> > +category c1 alias CATALIAS;
> > +level s0:c0;
> > +level s1:c0,c1;
> > +level s2;
> > +mlsconstrain CLASS1 { PERM1 } l1 =3D=3D l2;
> > +mlsvalidatetrans CLASS1 r1 domby r2 and l1 incomp h2;
> > +policycap open_perms;
> > +attribute ATTR1;
> > +attribute ATTR2;
> > +expandattribute ATTR1 true;
> > +expandattribute ATTR2 false;
> > +type TYPE1;
> > +type TYPE2, ATTR1;
> > +type TYPE3 alias { TYPEALIAS3A TYPEALIAS3B };
> > +type TYPE4 alias TYPEALIAS4, ATTR2;
> > +typealias TYPE1 alias TYPEALIAS1;
> > +typeattribute TYPE1 ATTR1;
> > +typebounds TYPE4 TYPE3;
> > +bool BOOL1 true;
> > +tunable TUNABLE1 false;
> > +tunable TUNABLE2 true;
> > +type_transition TYPE1 TYPE2 : CLASS1 TYPE3;
> > +type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENA=
ME";
> > +type_member TYPE1 TYPE2 : CLASS1 TYPE2;
> > +type_change TYPE1 TYPE2 : CLASS1 TYPE3;
> > +range_transition TYPE1 TYPE2 : CLASS1 s1:c0.c1;
> > +allow TYPE1 self : CLASS1 { PERM1 };
> > +auditallow { TYPE1 TYPE2 } TYPE3 : CLASS1 { PERM1 };
> > +dontaudit TYPE1 { TYPE2 TYPE3 } : CLASS3 { PERM1 CPERM1 };
> > +neverallow TYPE1 TYPE2 : { CLASS2 CLASS3 } { CPERM1 };
> > +allowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x1;
> > +auditallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x2;
> > +dontauditxperm TYPE1 TYPE2 : CLASS1 ioctl 0x3;
> > +neverallowxperm TYPE1 TYPE2 : CLASS1 ioctl 0x4;
> > +permissive TYPE1;
> > +attribute_role ROLE_ATTR1;
> > +role ROLE1;
> > +role ROLE3;
> > +role ROLE2, ROLE_ATTR1;
> > +role_transition ROLE1 TYPE1 ROLE2;
> > +role_transition ROLE1 TYPE1 : CLASS1 ROLE2;
> > +allow ROLE1 ROLE2;
> > +roleattribute ROLE3 ROLE_ATTR1;
> > +role ROLE1 types { TYPE1 };
> > +if ! BOOL1 { allow TYPE1 self: CLASS1 *; }
> > +if TUNABLE1 xor TUNABLE2 { allow TYPE1 self: CLASS2 *; } else { allow =
TYPE1 self: CLASS3 *; }
> > +optional { require { class CLASS2 { CPERM1 }; } allow TYPE1 self: CLAS=
S2 *; }
> > +user USER1 roles ROLE1 level s0 range s0 - s1:c0.c1;
> > +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=
=3D t2));
> > +# sameuser will be turned into (u1 =3D=3D u2)
> > +validatetrans CLASS2 sameuser and t3 =3D=3D ATTR1;
> > +sid kernel USER1:ROLE1:TYPE1:s0 - s1:c0.c1
> > +# fscon statements are not dumped
> > +fscon 2 3 USER1:ROLE1:TYPE1:s0 USER1:ROLE1:TYPE1:s0
> > +fs_use_xattr btrfs USER1:ROLE1:TYPE1:s0 - s1:c0.CATALIAS;
> > +fs_use_trans devpts USER1:ROLE1:TYPE1:s0 - s0;
> > +fs_use_task pipefs USER1:ROLE1:TYPE1:s0 - s1;
> > +# paths will be turned into quoted strings
> > +genfscon proc / -d USER1:ROLE1:TYPE1:s0
> > +genfscon proc "/file1" -- USER1:ROLE1:TYPE1:s0
> > +genfscon proc "/path/to/file" USER1:ROLE1:TYPE1:s0
> > +portcon tcp 80 USER1:ROLE1:TYPE1:s0
> > +portcon udp 100-200 USER1:ROLE1:TYPE1:s0
> > +netifcon lo USER1:ROLE1:TYPE1:s0 USER1:ROLE1:TYPE1:s0
> > +nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1:s0
> > +nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1=
:ROLE1:TYPE1:s0
> > +# hex numbers will be turned in decimal ones
> > +ibpkeycon fe80:: 0xFFFF USER1:ROLE1:TYPE1:s0
> > +ibpkeycon fe80:: 0-0x10 USER1:ROLE1:TYPE1:s0
> > +ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1:s0
> > +ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1:s0
> > diff --git a/checkpolicy/tests/policy_allonce_mls.expected.conf b/check=
policy/tests/policy_allonce_mls.expected.conf
> > new file mode 100644
> > index 00000000..87c36f92
> > --- /dev/null
> > +++ b/checkpolicy/tests/policy_allonce_mls.expected.conf
> > @@ -0,0 +1,88 @@
> > +# handle_unknown deny
> > +class CLASS1
> > +class CLASS2
> > +class CLASS3
> > +class dir
> > +class file
> > +class process
> > +sid kernel
> > +common COMMON1 { CPERM1 }
> > +class CLASS1 { PERM1 ioctl }
> > +class CLASS2 inherits COMMON1
> > +class CLASS3 inherits COMMON1 { PERM1 }
> > +default_user { CLASS1 } source;
> > +default_role { CLASS2 } target;
> > +default_type { CLASS3 } source;
> > +sensitivity s0;
> > +sensitivity s1;
> > +sensitivity s2 alias SENSALIAS;
> > +dominance { s0 s1 s2 }
> > +category c0;
> > +category c1 alias CATALIAS;
> > +level s0:c0;
> > +level s1:c0,c1;
> > +level s2;
> > +mlsconstrain CLASS1 { PERM1 } l1 =3D=3D l2;
> > +mlsvalidatetrans CLASS1 (r1 domby r2 and l1 incomp h2);
> > +policycap open_perms;
> > +attribute ATTR1;
> > +attribute ATTR2;
> > +bool BOOL1 true;
> > +type TYPE1;
> > +type TYPE2;
> > +type TYPE3;
> > +type TYPE4;
> > +typealias TYPE1 alias TYPEALIAS1;
> > +typealias TYPE3 alias TYPEALIAS3A;
> > +typealias TYPE3 alias TYPEALIAS3B;
> > +typealias TYPE4 alias TYPEALIAS4;
> > +typebounds TYPE4 TYPE3;
> > +typeattribute TYPE4 ATTR2;
> > +permissive TYPE1;
> > +allow TYPE1 self:CLASS1 { PERM1 };
> > +allow TYPE1 self:CLASS2 { CPERM1 };
> > +auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
> > +auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
> > +dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
> > +dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
> > +allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x1 };
> > +auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
> > +dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
> > +type_transition TYPE1 TYPE2:CLASS1 TYPE3;
> > +type_member TYPE1 TYPE2:CLASS1 TYPE2;
> > +type_change TYPE1 TYPE2:CLASS1 TYPE3;
> > +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
> > +range_transition TYPE1 TYPE2:CLASS1 s1:c0,c1 - s1:c0,c1;
> > +if (BOOL1) {
> > +} else {
> > +    allow TYPE1 self:CLASS1 { PERM1 ioctl };
> > +}
> > +role ROLE1;
> > +role ROLE2;
> > +role ROLE3;
> > +role ROLE1 types { TYPE1 };
> > +role_transition ROLE1 TYPE1:CLASS1 ROLE2;
> > +role_transition ROLE1 TYPE1:process ROLE2;
> > +allow ROLE1 ROLE2;
> > +user USER1 roles ROLE1 level s0 range s0 - s1:c0,c1;
> > +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=
=3D t2));
> > +validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
> > +sid kernel USER1:ROLE1:TYPE1:s0 - s1:c0,c1
> > +fs_use_xattr btrfs USER1:ROLE1:TYPE1:s0 - s1:c0,c1;
> > +fs_use_trans devpts USER1:ROLE1:TYPE1:s0 - s0;
> > +fs_use_task pipefs USER1:ROLE1:TYPE1:s0 - s1;
> > +genfscon proc "/" -d USER1:ROLE1:TYPE1:s0 - s0
> > +genfscon proc "/file1" -- USER1:ROLE1:TYPE1:s0 - s0
> > +genfscon proc "/path/to/file" USER1:ROLE1:TYPE1:s0 - s0
> > +portcon tcp 80 USER1:ROLE1:TYPE1:s0 - s0
> > +portcon udp 100-200 USER1:ROLE1:TYPE1:s0 - s0
> > +netifcon lo USER1:ROLE1:TYPE1:s0 - s0 USER1:ROLE1:TYPE1:s0 - s0
> > +nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1:s0 - s0
> > +nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1=
:ROLE1:TYPE1:s0 - s0
> > +ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1:s0 - s0
> > +ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1:s0 - s0
> > +ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1:s0 - s0
> > +ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1:s0 - s0
> > diff --git a/checkpolicy/tests/policy_allonce_mls.expected_opt.conf b/c=
heckpolicy/tests/policy_allonce_mls.expected_opt.conf
> > new file mode 100644
> > index 00000000..38176166
> > --- /dev/null
> > +++ b/checkpolicy/tests/policy_allonce_mls.expected_opt.conf
> > @@ -0,0 +1,88 @@
> > +# handle_unknown deny
> > +class CLASS1
> > +class CLASS2
> > +class CLASS3
> > +class dir
> > +class file
> > +class process
> > +sid kernel
> > +common COMMON1 { CPERM1 }
> > +class CLASS1 { PERM1 ioctl }
> > +class CLASS2 inherits COMMON1
> > +class CLASS3 inherits COMMON1 { PERM1 }
> > +default_user { CLASS1 } source;
> > +default_role { CLASS2 } target;
> > +default_type { CLASS3 } source;
> > +sensitivity s0;
> > +sensitivity s1;
> > +sensitivity s2 alias SENSALIAS;
> > +dominance { s0 s1 s2 }
> > +category c0;
> > +category c1 alias CATALIAS;
> > +level s0:c0;
> > +level s1:c0,c1;
> > +level s2;
> > +mlsconstrain CLASS1 { PERM1 } l1 =3D=3D l2;
> > +mlsvalidatetrans CLASS1 (r1 domby r2 and l1 incomp h2);
> > +policycap open_perms;
> > +attribute ATTR1;
> > +attribute ATTR2;
> > +bool BOOL1 true;
> > +type TYPE1;
> > +type TYPE2;
> > +type TYPE3;
> > +type TYPE4;
> > +typealias TYPE1 alias TYPEALIAS1;
> > +typealias TYPE3 alias TYPEALIAS3A;
> > +typealias TYPE3 alias TYPEALIAS3B;
> > +typealias TYPE4 alias TYPEALIAS4;
> > +typebounds TYPE4 TYPE3;
> > +typeattribute TYPE4 ATTR2;
> > +permissive TYPE1;
> > +allow TYPE1 self:CLASS1 { PERM1 };
> > +allow TYPE1 self:CLASS2 { CPERM1 };
> > +auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
> > +auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
> > +dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
> > +dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
> > +allowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x1 };
> > +auditallowxperm TYPE1 TYPE2:CLASS1 ioctl { 0x2 };
> > +dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
> > +type_transition TYPE1 TYPE2:CLASS1 TYPE3;
> > +type_member TYPE1 TYPE2:CLASS1 TYPE2;
> > +type_change TYPE1 TYPE2:CLASS1 TYPE3;
> > +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
> > +range_transition TYPE1 TYPE2:CLASS1 s1:c0,c1 - s1:c0,c1;
> > +if (BOOL1) {
> > +} else {
> > +    allow TYPE1 self:CLASS1 { ioctl };
> > +}
> > +role ROLE1;
> > +role ROLE2;
> > +role ROLE3;
> > +role ROLE1 types { TYPE1 };
> > +role_transition ROLE1 TYPE1:CLASS1 ROLE2;
> > +role_transition ROLE1 TYPE1:process ROLE2;
> > +allow ROLE1 ROLE2;
> > +user USER1 roles ROLE1 level s0 range s0 - s1:c0,c1;
> > +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=
=3D t2));
> > +validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
> > +sid kernel USER1:ROLE1:TYPE1:s0 - s1:c0,c1
> > +fs_use_xattr btrfs USER1:ROLE1:TYPE1:s0 - s1:c0,c1;
> > +fs_use_trans devpts USER1:ROLE1:TYPE1:s0 - s0;
> > +fs_use_task pipefs USER1:ROLE1:TYPE1:s0 - s1;
> > +genfscon proc "/" -d USER1:ROLE1:TYPE1:s0 - s0
> > +genfscon proc "/file1" -- USER1:ROLE1:TYPE1:s0 - s0
> > +genfscon proc "/path/to/file" USER1:ROLE1:TYPE1:s0 - s0
> > +portcon tcp 80 USER1:ROLE1:TYPE1:s0 - s0
> > +portcon udp 100-200 USER1:ROLE1:TYPE1:s0 - s0
> > +netifcon lo USER1:ROLE1:TYPE1:s0 - s0 USER1:ROLE1:TYPE1:s0 - s0
> > +nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1:s0 - s0
> > +nodecon ::ffff:127.0.0.1 ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff USER1=
:ROLE1:TYPE1:s0 - s0
> > +ibpkeycon fe80:: 65535 USER1:ROLE1:TYPE1:s0 - s0
> > +ibpkeycon fe80:: 0-16 USER1:ROLE1:TYPE1:s0 - s0
> > +ibendportcon mlx4_0 2 USER1:ROLE1:TYPE1:s0 - s0
> > +ibendportcon mlx5_0 1 USER1:ROLE1:TYPE1:s0 - s0
> > diff --git a/checkpolicy/tests/policy_allonce_xen.conf b/checkpolicy/te=
sts/policy_allonce_xen.conf
> > new file mode 100644
> > index 00000000..6402683a
> > --- /dev/null
> > +++ b/checkpolicy/tests/policy_allonce_xen.conf
> > @@ -0,0 +1,62 @@
> > +# handle_unknown deny
> > +class CLASS1
> > +class CLASS2
> > +class CLASS3
> > +class dir
> > +class file
> > +class process
> > +sid kernel
> > +common COMMON1 { CPERM1 }
> > +class CLASS1 { PERM1 }
> > +class CLASS2 inherits COMMON1
> > +class CLASS3 inherits COMMON1 { PERM1 }
> > +default_user { CLASS1 } source;
> > +default_role { CLASS2 } target;
> > +default_type { CLASS3 } source;
> > +attribute ATTR1;
> > +attribute ATTR2;
> > +expandattribute ATTR1 true;
> > +expandattribute ATTR2 false;
> > +type TYPE1;
> > +type TYPE2, ATTR1;
> > +type TYPE3 alias { TYPEALIAS3A TYPEALIAS3B };
> > +type TYPE4 alias TYPEALIAS4, ATTR2;
> > +typealias TYPE1 alias TYPEALIAS1;
> > +typeattribute TYPE1 ATTR1;
> > +typebounds TYPE4 TYPE3;
> > +bool BOOL1 true;
> > +tunable TUNABLE1 false;
> > +tunable TUNABLE2 true;
> > +type_transition TYPE1 TYPE2 : CLASS1 TYPE3;
> > +type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENA=
ME";
> > +type_member TYPE1 TYPE2 : CLASS1 TYPE2;
> > +type_change TYPE1 TYPE2 : CLASS1 TYPE3;
> > +allow TYPE1 self : CLASS1 { PERM1 };
> > +auditallow { TYPE1 TYPE2 } TYPE3 : CLASS1 { PERM1 };
> > +dontaudit TYPE1 { TYPE2 TYPE3 } : CLASS3 { PERM1 CPERM1 };
> > +neverallow TYPE1 TYPE2 : { CLASS2 CLASS3 } { CPERM1 };
> > +permissive TYPE1;
> > +attribute_role ROLE_ATTR1;
> > +role ROLE1;
> > +role ROLE3;
> > +role ROLE2, ROLE_ATTR1;
> > +role_transition ROLE1 TYPE1 ROLE2;
> > +role_transition ROLE1 TYPE1 : CLASS1 ROLE2;
> > +allow ROLE1 ROLE2;
> > +roleattribute ROLE3 ROLE_ATTR1;
> > +role ROLE1 types { TYPE1 };
> > +if ! BOOL1 { allow TYPE1 self: CLASS1 *; }
> > +if TUNABLE1 xor TUNABLE2 { allow TYPE1 self: CLASS2 *; } else { allow =
TYPE1 self: CLASS3 *; }
> > +optional { require { class CLASS2 { CPERM1 }; } allow TYPE1 self: CLAS=
S2 *; }
> > +policycap open_perms;
> > +user USER1 roles ROLE1;
> > +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=
=3D t2));
> > +validatetrans CLASS2 sameuser and t3 =3D=3D ATTR1;
> > +sid kernel USER1:ROLE1:TYPE1
> > +pirqcon 13 USER1:ROLE1:TYPE1
> > +iomemcon 13 USER1:ROLE1:TYPE1
> > +iomemcon 23-31 USER1:ROLE1:TYPE1
> > +ioportcon 13 USER1:ROLE1:TYPE1
> > +ioportcon 23-31 USER1:ROLE1:TYPE1
> > +pcidevicecon 13 USER1:ROLE1:TYPE1
> > +devicetreecon "/path/to/device" USER1:ROLE1:TYPE1
> > diff --git a/checkpolicy/tests/policy_allonce_xen.expected.conf b/check=
policy/tests/policy_allonce_xen.expected.conf
> > new file mode 100644
> > index 00000000..a4573ccb
> > --- /dev/null
> > +++ b/checkpolicy/tests/policy_allonce_xen.expected.conf
> > @@ -0,0 +1,65 @@
> > +# handle_unknown deny
> > +class CLASS1
> > +class CLASS2
> > +class CLASS3
> > +class dir
> > +class file
> > +class process
> > +sid xen
> > +common COMMON1 { CPERM1 }
> > +class CLASS1 { PERM1 }
> > +class CLASS2 inherits COMMON1
> > +class CLASS3 inherits COMMON1 { PERM1 }
> > +default_user { CLASS1 } source;
> > +default_role { CLASS2 } target;
> > +default_type { CLASS3 } source;
> > +policycap open_perms;
> > +attribute ATTR1;
> > +attribute ATTR2;
> > +bool BOOL1 true;
> > +type TYPE1;
> > +type TYPE2;
> > +type TYPE3;
> > +type TYPE4;
> > +typealias TYPE1 alias TYPEALIAS1;
> > +typealias TYPE3 alias TYPEALIAS3A;
> > +typealias TYPE3 alias TYPEALIAS3B;
> > +typealias TYPE4 alias TYPEALIAS4;
> > +typebounds TYPE4 TYPE3;
> > +typeattribute TYPE4 ATTR2;
> > +permissive TYPE1;
> > +allow TYPE1 self:CLASS1 { PERM1 };
> > +allow TYPE1 self:CLASS2 { CPERM1 };
> > +auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
> > +auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
> > +dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
> > +dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
> > +type_transition TYPE1 TYPE2:CLASS1 TYPE3;
> > +type_member TYPE1 TYPE2:CLASS1 TYPE2;
> > +type_change TYPE1 TYPE2:CLASS1 TYPE3;
> > +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
> > +if (BOOL1) {
> > +} else {
> > +    allow TYPE1 self:CLASS1 { PERM1 };
> > +}
> > +role ROLE1;
> > +role ROLE2;
> > +role ROLE3;
> > +role ROLE1 types { TYPE1 };
> > +role_transition ROLE1 TYPE1:CLASS1 ROLE2;
> > +role_transition ROLE1 TYPE1:process ROLE2;
> > +allow ROLE1 ROLE2;
> > +user USER1 roles ROLE1;
> > +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=
=3D t2));
> > +validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
> > +sid xen USER1:ROLE1:TYPE1
> > +pirqcon 13 USER1:ROLE1:TYPE1
> > +iomemcon 0xd USER1:ROLE1:TYPE1
> > +iomemcon 0x17-0x1f USER1:ROLE1:TYPE1
> > +ioportcon 0xd USER1:ROLE1:TYPE1
> > +ioportcon 0x17-0x1f USER1:ROLE1:TYPE1
> > +pcidevicecon 0xd USER1:ROLE1:TYPE1
> > +devicetreecon "/path/to/device" USER1:ROLE1:TYPE1
> > diff --git a/checkpolicy/tests/policy_allonce_xen.expected_opt.conf b/c=
heckpolicy/tests/policy_allonce_xen.expected_opt.conf
> > new file mode 100644
> > index 00000000..8fd3b226
> > --- /dev/null
> > +++ b/checkpolicy/tests/policy_allonce_xen.expected_opt.conf
> > @@ -0,0 +1,61 @@
> > +# handle_unknown deny
> > +class CLASS1
> > +class CLASS2
> > +class CLASS3
> > +class dir
> > +class file
> > +class process
> > +sid xen
> > +common COMMON1 { CPERM1 }
> > +class CLASS1 { PERM1 }
> > +class CLASS2 inherits COMMON1
> > +class CLASS3 inherits COMMON1 { PERM1 }
> > +default_user { CLASS1 } source;
> > +default_role { CLASS2 } target;
> > +default_type { CLASS3 } source;
> > +policycap open_perms;
> > +attribute ATTR1;
> > +attribute ATTR2;
> > +bool BOOL1 true;
> > +type TYPE1;
> > +type TYPE2;
> > +type TYPE3;
> > +type TYPE4;
> > +typealias TYPE1 alias TYPEALIAS1;
> > +typealias TYPE3 alias TYPEALIAS3A;
> > +typealias TYPE3 alias TYPEALIAS3B;
> > +typealias TYPE4 alias TYPEALIAS4;
> > +typebounds TYPE4 TYPE3;
> > +typeattribute TYPE4 ATTR2;
> > +permissive TYPE1;
> > +allow TYPE1 self:CLASS1 { PERM1 };
> > +allow TYPE1 self:CLASS2 { CPERM1 };
> > +auditallow TYPE1 TYPE3:CLASS1 { PERM1 };
> > +auditallow TYPE2 TYPE3:CLASS1 { PERM1 };
> > +dontaudit TYPE1 TYPE2:CLASS3 { CPERM1 PERM1 };
> > +dontaudit TYPE1 TYPE3:CLASS3 { CPERM1 PERM1 };
> > +type_transition TYPE1 TYPE2:CLASS1 TYPE3;
> > +type_member TYPE1 TYPE2:CLASS1 TYPE2;
> > +type_change TYPE1 TYPE2:CLASS1 TYPE3;
> > +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> > +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
> > +role ROLE1;
> > +role ROLE2;
> > +role ROLE3;
> > +role ROLE1 types { TYPE1 };
> > +role_transition ROLE1 TYPE1:CLASS1 ROLE2;
> > +role_transition ROLE1 TYPE1:process ROLE2;
> > +allow ROLE1 ROLE2;
> > +user USER1 roles ROLE1;
> > +constrain CLASS1 { PERM1 } (u1 =3D=3D u2 or (r1 =3D=3D r2 and t1 =3D=
=3D t2));
> > +validatetrans CLASS2 (u1 =3D=3D u2 and t3 =3D=3D ATTR1);
> > +sid xen USER1:ROLE1:TYPE1
> > +pirqcon 13 USER1:ROLE1:TYPE1
> > +iomemcon 0xd USER1:ROLE1:TYPE1
> > +iomemcon 0x17-0x1f USER1:ROLE1:TYPE1
> > +ioportcon 0xd USER1:ROLE1:TYPE1
> > +ioportcon 0x17-0x1f USER1:ROLE1:TYPE1
> > +pcidevicecon 0xd USER1:ROLE1:TYPE1
> > +devicetreecon "/path/to/device" USER1:ROLE1:TYPE1
> > diff --git a/checkpolicy/tests/policy_minimal.conf b/checkpolicy/tests/=
policy_minimal.conf
> > new file mode 100644
> > index 00000000..e8cff6df
> > --- /dev/null
> > +++ b/checkpolicy/tests/policy_minimal.conf
> > @@ -0,0 +1,10 @@
> > +# handle_unknown deny
> > +class CLASS1
> > +sid kernel
> > +class CLASS1 { PERM1 }
> > +type TYPE1;
> > +allow TYPE1 self:CLASS1 { PERM1 };
> > +role ROLE1;
> > +role ROLE1 types { TYPE1 };
> > +user USER1 roles ROLE1;
> > +sid kernel USER1:ROLE1:TYPE1
> > diff --git a/checkpolicy/tests/policy_minimal_mls.conf b/checkpolicy/te=
sts/policy_minimal_mls.conf
> > new file mode 100644
> > index 00000000..9ea65169
> > --- /dev/null
> > +++ b/checkpolicy/tests/policy_minimal_mls.conf
> > @@ -0,0 +1,15 @@
> > +# handle_unknown deny
> > +class CLASS1
> > +sid kernel
> > +class CLASS1 { PERM1 }
> > +sensitivity s0;
> > +dominance { s0 }
> > +category c0;
> > +level s0:c0;
> > +mlsconstrain CLASS1 { PERM1 } l1 =3D=3D l2;
> > +type TYPE1;
> > +allow TYPE1 self:CLASS1 { PERM1 };
> > +role ROLE1;
> > +role ROLE1 types { TYPE1 };
> > +user USER1 roles ROLE1 level s0 range s0 - s0:c0;
> > +sid kernel USER1:ROLE1:TYPE1:s0 - s0
> > diff --git a/checkpolicy/tests/test_roundtrip.sh b/checkpolicy/tests/te=
st_roundtrip.sh
> > new file mode 100755
> > index 00000000..d05b36bb
> > --- /dev/null
> > +++ b/checkpolicy/tests/test_roundtrip.sh
> > @@ -0,0 +1,41 @@
> > +#!/bin/sh
> > +
> > +set -eu
> > +
> > +BASEDIR=3D$(dirname "$0")
> > +CHECKPOLICY=3D"${BASEDIR}/../checkpolicy"
> > +
> > +check_policy() {
> > +       POLICY=3D$1
> > +       EXPECTED=3D$2
> > +       OPTS=3D$3
> > +
> > +       echo "=3D=3D=3D=3D Testing ${1}"
> > +
> > +       ${CHECKPOLICY} ${OPTS} "${BASEDIR}/${POLICY}" -o "${BASEDIR}/te=
stpol.bin"
> > +       ${CHECKPOLICY} ${OPTS} -b -F "${BASEDIR}/testpol.bin" -o "${BAS=
EDIR}/testpol.conf"
> > +       diff -u "${BASEDIR}/${EXPECTED}" "${BASEDIR}/testpol.conf"
> > +
> > +       ${CHECKPOLICY} ${OPTS} "${BASEDIR}/${EXPECTED}" -o "${BASEDIR}/=
testpol.bin"
> > +       ${CHECKPOLICY} ${OPTS} -b -F "${BASEDIR}/testpol.bin" -o "${BAS=
EDIR}/testpol.conf"
> > +       diff -u "${BASEDIR}/${EXPECTED}" "${BASEDIR}/testpol.conf"
> > +
> > +       echo "=3D=3D=3D=3D ${1} success"
> > +       echo ""
> > +}
> > +
> > +
> > +check_policy  policy_minimal.conf      policy_minimal.conf            =
       '-E'
> > +check_policy  policy_minimal.conf      policy_minimal.conf            =
       '-E -S -O'
> > +
> > +check_policy  policy_minimal_mls.conf  policy_minimal_mls.conf        =
       '-M -E'
> > +check_policy  policy_minimal_mls.conf  policy_minimal_mls.conf        =
       '-M -E -S -O'
> > +
> > +check_policy  policy_allonce.conf      policy_allonce.expected.conf   =
       ''
> > +check_policy  policy_allonce.conf      policy_allonce.expected_opt.con=
f      '-S -O'
> > +
> > +check_policy  policy_allonce_mls.conf  policy_allonce_mls.expected.con=
f      '-M'
> > +check_policy  policy_allonce_mls.conf  policy_allonce_mls.expected_opt=
.conf  '-M -S -O'
> > +
> > +check_policy  policy_allonce_xen.conf  policy_allonce_xen.expected.con=
f      '--target xen -c 30 -E'
> > +check_policy  policy_allonce_xen.conf  policy_allonce_xen.expected_opt=
.conf  '--target xen -c 30 -E -S -O'
> > --
> > 2.42.0
> >
