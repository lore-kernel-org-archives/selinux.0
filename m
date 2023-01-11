Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781D7C677F1
	for <selinux@archiver.kernel.org>; Wed, 11 Jan 2023 15:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjAKPxy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjAKPxb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Jan 2023 10:53:31 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51695B57
        for <selinux@vger.kernel.org>; Wed, 11 Jan 2023 07:53:28 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id tz12so37916697ejc.9
        for <selinux@vger.kernel.org>; Wed, 11 Jan 2023 07:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEIBReN4wbkneWwKWcv/qDNRtrkTtGQAg3n8MbwYV7c=;
        b=gVUxcLQys3vbzUD4r8x3vlMPn8bv7msmRzHB9VGhQI/T+VfpFMCvyAEdDepJ2BMejB
         f+quDAI3AlD2H1KFyeEYRQKPTV+bUFfSm9cXCAG5r6ZQKFRRYWKdjOjDT4Pz9GT5LIII
         g4qfKXh6WRc48qblrOl6jxm/LTNkXpzzNW+L23g9mQSIxyDqGvG1kn+K/sCrXF4WcBQN
         W0jgmX9x0aOxQGWk5Qz8W+W/H9rUG+EoUFmlongKljAzbLQ36ITffqGlKBRVY5bNNvfR
         4nY6FIB+ErmqnOa/jEYiEr0aB7CJSvkvSLIEAx5JJT26rTRLrt7e2V8MJybU9livc0bJ
         TnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEIBReN4wbkneWwKWcv/qDNRtrkTtGQAg3n8MbwYV7c=;
        b=zOSaFIW3PKdeYpNN34DYSKkdcNBUDyeNLTBfnFFNUEK5cbHbHLW8G4mTZgxvFMTIcm
         E7XgydEsPZBzuu5iwhKyDf9NGUFIWEVuDxKEXEt8tExyPXnB6UtgRLxgsYmkpaNBkDcH
         ASd3JiX/Bl6Ztbpzkq+C3OtkxPvyB67yAkKdxF90ivplZtlJGqzsxU+fc4EdRuZHjvSg
         Ih5Byc02gpdoBM0k88dHWVD/3CMKlleKupf6S6HyPnOZ6eMo3wvexenDAZwDwo2JBrlw
         4qyl1LrRo9qLfhZOcM3sy+XImUI0Z+hDqTaVpwKwZQRggiUKgQzsiZhoqBPLsUhJ5Yaw
         lA+A==
X-Gm-Message-State: AFqh2kpcSX3fxMjDhKhWgrKP8ACaAUvMTEjOW77JyCwqSKSKL6+SBdsN
        ZxJ5AsFuEMr2RR1mIAOXK9Y4ELB5M+yG6mENvL8=
X-Google-Smtp-Source: AMrXdXuDmVxHr/dVZ4+6Z2poLhe4Cm4Kw8Zszmt8oMXLlAN0dYu84+ncBSR46/DOAdYfrfS7WzlCeeL7hkCYa2Vzvlc=
X-Received: by 2002:a17:907:584:b0:7b2:b992:694d with SMTP id
 vw4-20020a170907058400b007b2b992694dmr4714236ejb.651.1673452406782; Wed, 11
 Jan 2023 07:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20230105171320.18349-1-cgzones@googlemail.com> <CAP+JOzQRqWJg19nnvYd-TW21nfbAOdxAZDbiw-8N3JFE6F9Mnw@mail.gmail.com>
In-Reply-To: <CAP+JOzQRqWJg19nnvYd-TW21nfbAOdxAZDbiw-8N3JFE6F9Mnw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 Jan 2023 10:53:15 -0500
Message-ID: <CAP+JOzQVPkkuTcM+opY=tThVN0+9Xm0JTfPxBmCGsikwm4cm0A@mail.gmail.com>
Subject: Re: [PATCH] Correct misc typos
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 9, 2023 at 10:53 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Jan 5, 2023 at 12:26 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Found by codespell(1) and typos[1].
> >
> > [1]: https://github.com/crate-ci/typos
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/label_db.c                             | 2 +-
> >  libselinux/src/regex.c                                | 2 +-
> >  libselinux/src/sha1.c                                 | 2 +-
> >  libsepol/cil/src/cil_post.c                           | 2 +-
> >  libsepol/cil/src/cil_resolve_ast.c                    | 2 +-
> >  libsepol/src/module_to_cil.c                          | 2 +-
> >  libsepol/tests/policies/test-deps/base-metreq.conf    | 2 +-
> >  libsepol/tests/policies/test-deps/base-notmetreq.conf | 2 +-
> >  libsepol/tests/policies/test-deps/small-base.conf     | 2 +-
> >  libsepol/tests/policies/test-expander/alias-base.conf | 2 +-
> >  libsepol/tests/policies/test-expander/role-base.conf  | 2 +-
> >  libsepol/tests/policies/test-expander/small-base.conf | 2 +-
> >  libsepol/tests/policies/test-expander/user-base.conf  | 2 +-
> >  libsepol/tests/policies/test-hooks/cmp_policy.conf    | 2 +-
> >  libsepol/tests/policies/test-hooks/small-base.conf    | 2 +-
> >  libsepol/tests/policies/test-linker/small-base.conf   | 2 +-
> >  policycoreutils/newrole/newrole.c                     | 2 +-
> >  python/semanage/semanage                              | 2 +-
> >  python/sepolicy/sepolicy/manpage.py                   | 2 +-
> >  19 files changed, 19 insertions(+), 19 deletions(-)
> >
> > diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
> > index bd73201c..3f803037 100644
> > --- a/libselinux/src/label_db.c
> > +++ b/libselinux/src/label_db.c
> > @@ -31,7 +31,7 @@
> >   * For example:
> >   * ----------------------------------------
> >   * #
> > - * # It is an example specfile for database obejcts
> > + * # It is an example specfile for database objects
> >   * #
> >   * db_database  template1           system_u:object_r:sepgsql_db_t:s0
> >   *
> > diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> > index 149a7973..ae7ad690 100644
> > --- a/libselinux/src/regex.c
> > +++ b/libselinux/src/regex.c
> > @@ -167,7 +167,7 @@ int regex_writef(struct regex_data *regex, FILE *fp=
, int do_write_precompregex)
> >         PCRE2_UCHAR *bytes =3D NULL;
> >
> >         if (do_write_precompregex) {
> > -               /* encode the patter for serialization */
> > +               /* encode the pattern for serialization */
> >                 rc =3D pcre2_serialize_encode((const pcre2_code **)&reg=
ex->regex,
> >                                             1, &bytes, &serialized_size=
, NULL);
> >                 if (rc !=3D 1) {
> > diff --git a/libselinux/src/sha1.c b/libselinux/src/sha1.c
> > index a8484677..9d51e04a 100644
> > --- a/libselinux/src/sha1.c
> > +++ b/libselinux/src/sha1.c
> > @@ -11,7 +11,7 @@
> >  //  Modified to:
> >  //    - stop symbols being exported for libselinux shared library - Oc=
tober 2015
> >  //                                                                    =
Richard Haines <richard_c_haines@btinternet.com>
> > -//    - Not cast the workspace from a byte array to a CHAR64LONG16 due=
 to alignment isses.
> > +//    - Not cast the workspace from a byte array to a CHAR64LONG16 due=
 to alignment issues.
> >  //      Fixes:
> >  //        sha1.c:73:33: error: cast from 'uint8_t *' (aka 'unsigned ch=
ar *') to 'CHAR64LONG16 *' increases required alignment from 1 to 4 [-Werro=
r,-Wcast-align]
> >  //             CHAR64LONG16*       block =3D (CHAR64LONG16*) workspace=
;
> > diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> > index 11e572e2..a7c66ead 100644
> > --- a/libsepol/cil/src/cil_post.c
> > +++ b/libsepol/cil/src/cil_post.c
> > @@ -1193,7 +1193,7 @@ static int __cil_cat_expr_range_to_bitmap_helper(=
struct cil_list_item *i1, struc
> >         struct cil_cat *c2 =3D (struct cil_cat *)d2;
> >
> >         if (n1->flavor =3D=3D CIL_CATSET || n2->flavor =3D=3D CIL_CATSE=
T) {
> > -               cil_log(CIL_ERR, "Category sets cannont be used in a ca=
tegory range\n");
> > +               cil_log(CIL_ERR, "Category sets cannot be used in a cat=
egory range\n");
> >                 goto exit;
> >         }
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_=
resolve_ast.c
> > index f5e22c97..d2bfdc81 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -778,7 +778,7 @@ int cil_resolve_classcommon(struct cil_tree_node *c=
urrent, void *extra_args)
> >         class =3D (struct cil_class *)class_datum;
> >         common =3D (struct cil_class *)common_datum;
> >         if (class->common !=3D NULL) {
> > -               cil_log(CIL_ERR, "class cannot be associeated with more=
 than one common\n");
> > +               cil_log(CIL_ERR, "class cannot be associated with more =
than one common\n");
> >                 rc =3D SEPOL_ERR;
> >                 goto exit;
> >         }
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index b900290a..2b24d33e 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -2330,7 +2330,7 @@ static int user_to_cil(int indent, struct policyd=
b *pdb, struct avrule_block *bl
> >         }
> >
> >         if (block->flags & AVRULE_OPTIONAL) {
> > -               // sensitivites in user statements in optionals do not =
have the
> > +               // sensitivities in user statements in optionals do not=
 have the
> >                 // standard -1 offset
> >                 sens_offset =3D 0;
> >         }
> > diff --git a/libsepol/tests/policies/test-deps/base-metreq.conf b/libse=
pol/tests/policies/test-deps/base-metreq.conf
> > index b7528dde..d8e1f40b 100644
> > --- a/libsepol/tests/policies/test-deps/base-metreq.conf
> > +++ b/libsepol/tests/policies/test-deps/base-metreq.conf
> > @@ -33,7 +33,7 @@ class key_socket
> >  class unix_stream_socket
> >  class unix_dgram_socket
> >
> > -# sysv-ipc-related clases
> > +# sysv-ipc-related classes
> >  class sem
> >  class msg
> >  class msgq
> > diff --git a/libsepol/tests/policies/test-deps/base-notmetreq.conf b/li=
bsepol/tests/policies/test-deps/base-notmetreq.conf
> > index eee36dca..ecd92f6f 100644
> > --- a/libsepol/tests/policies/test-deps/base-notmetreq.conf
> > +++ b/libsepol/tests/policies/test-deps/base-notmetreq.conf
> > @@ -33,7 +33,7 @@ class key_socket
> >  class unix_stream_socket
> >  class unix_dgram_socket
> >
> > -# sysv-ipc-related clases
> > +# sysv-ipc-related classes
> >  class msg
> >  class msgq
> >  class shm
> > diff --git a/libsepol/tests/policies/test-deps/small-base.conf b/libsep=
ol/tests/policies/test-deps/small-base.conf
> > index 98f49c23..848d1741 100644
> > --- a/libsepol/tests/policies/test-deps/small-base.conf
> > +++ b/libsepol/tests/policies/test-deps/small-base.conf
> > @@ -33,7 +33,7 @@ class key_socket
> >  class unix_stream_socket
> >  class unix_dgram_socket
> >
> > -# sysv-ipc-related clases
> > +# sysv-ipc-related classes
> >  class sem
> >  class msg
> >  class msgq
> > diff --git a/libsepol/tests/policies/test-expander/alias-base.conf b/li=
bsepol/tests/policies/test-expander/alias-base.conf
> > index b950039d..34955924 100644
> > --- a/libsepol/tests/policies/test-expander/alias-base.conf
> > +++ b/libsepol/tests/policies/test-expander/alias-base.conf
> > @@ -33,7 +33,7 @@ class key_socket
> >  class unix_stream_socket
> >  class unix_dgram_socket
> >
> > -# sysv-ipc-related clases
> > +# sysv-ipc-related classes
> >  class sem
> >  class msg
> >  class msgq
> > diff --git a/libsepol/tests/policies/test-expander/role-base.conf b/lib=
sepol/tests/policies/test-expander/role-base.conf
> > index 8e88b4be..a387c8c0 100644
> > --- a/libsepol/tests/policies/test-expander/role-base.conf
> > +++ b/libsepol/tests/policies/test-expander/role-base.conf
> > @@ -33,7 +33,7 @@ class key_socket
> >  class unix_stream_socket
> >  class unix_dgram_socket
> >
> > -# sysv-ipc-related clases
> > +# sysv-ipc-related classes
> >  class sem
> >  class msg
> >  class msgq
> > diff --git a/libsepol/tests/policies/test-expander/small-base.conf b/li=
bsepol/tests/policies/test-expander/small-base.conf
> > index 055ea054..ac180f35 100644
> > --- a/libsepol/tests/policies/test-expander/small-base.conf
> > +++ b/libsepol/tests/policies/test-expander/small-base.conf
> > @@ -33,7 +33,7 @@ class key_socket
> >  class unix_stream_socket
> >  class unix_dgram_socket
> >
> > -# sysv-ipc-related clases
> > +# sysv-ipc-related classes
> >  class sem
> >  class msg
> >  class msgq
> > diff --git a/libsepol/tests/policies/test-expander/user-base.conf b/lib=
sepol/tests/policies/test-expander/user-base.conf
> > index b31ee8cd..789a59a2 100644
> > --- a/libsepol/tests/policies/test-expander/user-base.conf
> > +++ b/libsepol/tests/policies/test-expander/user-base.conf
> > @@ -33,7 +33,7 @@ class key_socket
> >  class unix_stream_socket
> >  class unix_dgram_socket
> >
> > -# sysv-ipc-related clases
> > +# sysv-ipc-related classes
> >  class sem
> >  class msg
> >  class msgq
> > diff --git a/libsepol/tests/policies/test-hooks/cmp_policy.conf b/libse=
pol/tests/policies/test-hooks/cmp_policy.conf
> > index 9082b333..3c510bc4 100644
> > --- a/libsepol/tests/policies/test-hooks/cmp_policy.conf
> > +++ b/libsepol/tests/policies/test-hooks/cmp_policy.conf
> > @@ -33,7 +33,7 @@ class key_socket
> >  class unix_stream_socket
> >  class unix_dgram_socket
> >
> > -# sysv-ipc-related clases
> > +# sysv-ipc-related classes
> >  class sem
> >  class msg
> >  class msgq
> > diff --git a/libsepol/tests/policies/test-hooks/small-base.conf b/libse=
pol/tests/policies/test-hooks/small-base.conf
> > index 9082b333..3c510bc4 100644
> > --- a/libsepol/tests/policies/test-hooks/small-base.conf
> > +++ b/libsepol/tests/policies/test-hooks/small-base.conf
> > @@ -33,7 +33,7 @@ class key_socket
> >  class unix_stream_socket
> >  class unix_dgram_socket
> >
> > -# sysv-ipc-related clases
> > +# sysv-ipc-related classes
> >  class sem
> >  class msg
> >  class msgq
> > diff --git a/libsepol/tests/policies/test-linker/small-base.conf b/libs=
epol/tests/policies/test-linker/small-base.conf
> > index 890ebbeb..15ced459 100644
> > --- a/libsepol/tests/policies/test-linker/small-base.conf
> > +++ b/libsepol/tests/policies/test-linker/small-base.conf
> > @@ -33,7 +33,7 @@ class key_socket
> >  class unix_stream_socket
> >  class unix_dgram_socket
> >
> > -# sysv-ipc-related clases
> > +# sysv-ipc-related classes
> >  class sem
> >  class msg
> >  class msgq
> > diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrol=
e/newrole.c
> > index c2afa37e..d9efa68a 100644
> > --- a/policycoreutils/newrole/newrole.c
> > +++ b/policycoreutils/newrole/newrole.c
> > @@ -1289,7 +1289,7 @@ int main(int argc, char *argv[])
> >         /*
> >          * Step 5:  Execute a new shell with the new context in `new_co=
ntext'.
> >          *
> > -        * Establish context, namesapce and any options for the new she=
ll
> > +        * Establish context, namespace and any options for the new she=
ll
> >          */
> >         if (optind < 1)
> >                 optind =3D 1;
> > diff --git a/python/semanage/semanage b/python/semanage/semanage
> > index b21d1484..e0bd98a9 100644
> > --- a/python/semanage/semanage
> > +++ b/python/semanage/semanage
> > @@ -130,7 +130,7 @@ class SetImportFile(argparse.Action):
> >                  sys.exit(1)
> >          setattr(namespace, self.dest, values)
> >
> > -# define dictionary for seobject OBEJCTS
> > +# define dictionary for seobject OBJECTS
> >  object_dict =3D {
> >      'login': seobject.loginRecords,
> >      'user': seobject.seluserRecords,
> > diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepo=
licy/manpage.py
> > index 1bff8f9a..a488dcbf 100755
> > --- a/python/sepolicy/sepolicy/manpage.py
> > +++ b/python/sepolicy/sepolicy/manpage.py
> > @@ -739,7 +739,7 @@ SELinux %(domainname)s policy is very flexible allo=
wing users to setup their %(d
> >  .B STANDARD FILE CONTEXT
> >
> >  SELinux defines the file context types for the %(domainname)s, if you =
wanted to
> > -store files with these types in a diffent paths, you need to execute t=
he semanage command to specify alternate labeling and then use restorecon t=
o put the labels on disk.
> > +store files with these types in a different paths, you need to execute=
 the semanage command to specify alternate labeling and then use restorecon=
 to put the labels on disk.
> >
> >  .B semanage fcontext -a -t %(type)s '/srv/%(domainname)s/content(/.*)?=
'
> >  .br
> > --
> > 2.39.0
> >
