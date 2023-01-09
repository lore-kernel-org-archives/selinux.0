Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94220C5479D
	for <selinux@archiver.kernel.org>; Mon,  9 Jan 2023 15:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbjAIPxX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Jan 2023 10:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjAIPxS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Jan 2023 10:53:18 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BE81AD
        for <selinux@vger.kernel.org>; Mon,  9 Jan 2023 07:53:16 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id jo4so21217584ejb.7
        for <selinux@vger.kernel.org>; Mon, 09 Jan 2023 07:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx2pSgGPtRZdEJPnygnGNAiL79AAoMsZ0EB+YzyXy5c=;
        b=Jwic12tNn3fVLrIupWk/Wsa7mNx7/yfGOYLIHXIEhDxKUinjWKEAqHezkF9rvwtsmX
         9WiHtekBrxCwYaYIoThiPYAYZ+TzurpQpsZBHBeV27w+eagAoDP5pj+7F5hpkvzlTBBL
         fbBJ8Pq6oEBNGw/etDEq2sTTw3Ea/2XDvx3RRPkrZw8aRM4qhW7ta/iVs2RNKHwdrpiY
         C+bIE4HLLEtx1P4u65zzOfFsmx/nDXxnJ4FRB48ctHox96CED1SP6fQQv+AozuiGyWlE
         OleImEcz64aXKWHXMLxiiwYKa+dHMD3XgAMR/TS9nqg2iztY/0n9y2TF7CkSLZqwcsj8
         3dOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx2pSgGPtRZdEJPnygnGNAiL79AAoMsZ0EB+YzyXy5c=;
        b=1ZqOkN6PibwR+q//VUdqlrXf78mGZ3v9LIXvJYmbf0O8sqYTEuCvaUCExr5XY/wWTQ
         MeQsn/Q/XBSbGvuRbDSSz2mh52OE+C7OzKPP5i/74WzMf6NTP2wfRruY1Owdb8oF+/Qu
         cCvnnTw4lSY/MPJAYqtzRoTksqADvVbASq6wa89neYzpU/uxOeT9P7iHJKCWg0841ztj
         T+TwwRc3B0/ZvBlwzTFc7zXw5E6l7UBVPctuAMgsHo/XNfa8jtKLnp3N/pWFwxxmmA4x
         jsThWZOJja8Krvs3Uj78JfLjd6LpZhOLml1FW10K3MvJQDx5586bLhAX6regqIqgycfc
         FRLQ==
X-Gm-Message-State: AFqh2kpKd9Udf2rttM/jOaeBSTa0IzHqZhs6xE8kblUsq8k+okJoZTwP
        FbmqUSOLXUVniqpKcEtDK+LGaCEyVRaSnK9uYixBfJY34Kk=
X-Google-Smtp-Source: AMrXdXtZYY8l4URIYHHWjjEqpwDwP1hZ7BLKyt4e5jWgnth5mKNbE3Q+tmCHRZ+JD92LsF166FtpxClxB2N1B1hiEno=
X-Received: by 2002:a17:907:8024:b0:84d:df2:81f5 with SMTP id
 ft36-20020a170907802400b0084d0df281f5mr1089293ejc.406.1673279595226; Mon, 09
 Jan 2023 07:53:15 -0800 (PST)
MIME-Version: 1.0
References: <20230105171320.18349-1-cgzones@googlemail.com>
In-Reply-To: <20230105171320.18349-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 9 Jan 2023 10:53:04 -0500
Message-ID: <CAP+JOzQRqWJg19nnvYd-TW21nfbAOdxAZDbiw-8N3JFE6F9Mnw@mail.gmail.com>
Subject: Re: [PATCH] Correct misc typos
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
> Found by codespell(1) and typos[1].
>
> [1]: https://github.com/crate-ci/typos
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/label_db.c                             | 2 +-
>  libselinux/src/regex.c                                | 2 +-
>  libselinux/src/sha1.c                                 | 2 +-
>  libsepol/cil/src/cil_post.c                           | 2 +-
>  libsepol/cil/src/cil_resolve_ast.c                    | 2 +-
>  libsepol/src/module_to_cil.c                          | 2 +-
>  libsepol/tests/policies/test-deps/base-metreq.conf    | 2 +-
>  libsepol/tests/policies/test-deps/base-notmetreq.conf | 2 +-
>  libsepol/tests/policies/test-deps/small-base.conf     | 2 +-
>  libsepol/tests/policies/test-expander/alias-base.conf | 2 +-
>  libsepol/tests/policies/test-expander/role-base.conf  | 2 +-
>  libsepol/tests/policies/test-expander/small-base.conf | 2 +-
>  libsepol/tests/policies/test-expander/user-base.conf  | 2 +-
>  libsepol/tests/policies/test-hooks/cmp_policy.conf    | 2 +-
>  libsepol/tests/policies/test-hooks/small-base.conf    | 2 +-
>  libsepol/tests/policies/test-linker/small-base.conf   | 2 +-
>  policycoreutils/newrole/newrole.c                     | 2 +-
>  python/semanage/semanage                              | 2 +-
>  python/sepolicy/sepolicy/manpage.py                   | 2 +-
>  19 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
> index bd73201c..3f803037 100644
> --- a/libselinux/src/label_db.c
> +++ b/libselinux/src/label_db.c
> @@ -31,7 +31,7 @@
>   * For example:
>   * ----------------------------------------
>   * #
> - * # It is an example specfile for database obejcts
> + * # It is an example specfile for database objects
>   * #
>   * db_database  template1           system_u:object_r:sepgsql_db_t:s0
>   *
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index 149a7973..ae7ad690 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -167,7 +167,7 @@ int regex_writef(struct regex_data *regex, FILE *fp, =
int do_write_precompregex)
>         PCRE2_UCHAR *bytes =3D NULL;
>
>         if (do_write_precompregex) {
> -               /* encode the patter for serialization */
> +               /* encode the pattern for serialization */
>                 rc =3D pcre2_serialize_encode((const pcre2_code **)&regex=
->regex,
>                                             1, &bytes, &serialized_size, =
NULL);
>                 if (rc !=3D 1) {
> diff --git a/libselinux/src/sha1.c b/libselinux/src/sha1.c
> index a8484677..9d51e04a 100644
> --- a/libselinux/src/sha1.c
> +++ b/libselinux/src/sha1.c
> @@ -11,7 +11,7 @@
>  //  Modified to:
>  //    - stop symbols being exported for libselinux shared library - Octo=
ber 2015
>  //                                                                    Ri=
chard Haines <richard_c_haines@btinternet.com>
> -//    - Not cast the workspace from a byte array to a CHAR64LONG16 due t=
o alignment isses.
> +//    - Not cast the workspace from a byte array to a CHAR64LONG16 due t=
o alignment issues.
>  //      Fixes:
>  //        sha1.c:73:33: error: cast from 'uint8_t *' (aka 'unsigned char=
 *') to 'CHAR64LONG16 *' increases required alignment from 1 to 4 [-Werror,=
-Wcast-align]
>  //             CHAR64LONG16*       block =3D (CHAR64LONG16*) workspace;
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 11e572e2..a7c66ead 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -1193,7 +1193,7 @@ static int __cil_cat_expr_range_to_bitmap_helper(st=
ruct cil_list_item *i1, struc
>         struct cil_cat *c2 =3D (struct cil_cat *)d2;
>
>         if (n1->flavor =3D=3D CIL_CATSET || n2->flavor =3D=3D CIL_CATSET)=
 {
> -               cil_log(CIL_ERR, "Category sets cannont be used in a cate=
gory range\n");
> +               cil_log(CIL_ERR, "Category sets cannot be used in a categ=
ory range\n");
>                 goto exit;
>         }
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index f5e22c97..d2bfdc81 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -778,7 +778,7 @@ int cil_resolve_classcommon(struct cil_tree_node *cur=
rent, void *extra_args)
>         class =3D (struct cil_class *)class_datum;
>         common =3D (struct cil_class *)common_datum;
>         if (class->common !=3D NULL) {
> -               cil_log(CIL_ERR, "class cannot be associeated with more t=
han one common\n");
> +               cil_log(CIL_ERR, "class cannot be associated with more th=
an one common\n");
>                 rc =3D SEPOL_ERR;
>                 goto exit;
>         }
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index b900290a..2b24d33e 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2330,7 +2330,7 @@ static int user_to_cil(int indent, struct policydb =
*pdb, struct avrule_block *bl
>         }
>
>         if (block->flags & AVRULE_OPTIONAL) {
> -               // sensitivites in user statements in optionals do not ha=
ve the
> +               // sensitivities in user statements in optionals do not h=
ave the
>                 // standard -1 offset
>                 sens_offset =3D 0;
>         }
> diff --git a/libsepol/tests/policies/test-deps/base-metreq.conf b/libsepo=
l/tests/policies/test-deps/base-metreq.conf
> index b7528dde..d8e1f40b 100644
> --- a/libsepol/tests/policies/test-deps/base-metreq.conf
> +++ b/libsepol/tests/policies/test-deps/base-metreq.conf
> @@ -33,7 +33,7 @@ class key_socket
>  class unix_stream_socket
>  class unix_dgram_socket
>
> -# sysv-ipc-related clases
> +# sysv-ipc-related classes
>  class sem
>  class msg
>  class msgq
> diff --git a/libsepol/tests/policies/test-deps/base-notmetreq.conf b/libs=
epol/tests/policies/test-deps/base-notmetreq.conf
> index eee36dca..ecd92f6f 100644
> --- a/libsepol/tests/policies/test-deps/base-notmetreq.conf
> +++ b/libsepol/tests/policies/test-deps/base-notmetreq.conf
> @@ -33,7 +33,7 @@ class key_socket
>  class unix_stream_socket
>  class unix_dgram_socket
>
> -# sysv-ipc-related clases
> +# sysv-ipc-related classes
>  class msg
>  class msgq
>  class shm
> diff --git a/libsepol/tests/policies/test-deps/small-base.conf b/libsepol=
/tests/policies/test-deps/small-base.conf
> index 98f49c23..848d1741 100644
> --- a/libsepol/tests/policies/test-deps/small-base.conf
> +++ b/libsepol/tests/policies/test-deps/small-base.conf
> @@ -33,7 +33,7 @@ class key_socket
>  class unix_stream_socket
>  class unix_dgram_socket
>
> -# sysv-ipc-related clases
> +# sysv-ipc-related classes
>  class sem
>  class msg
>  class msgq
> diff --git a/libsepol/tests/policies/test-expander/alias-base.conf b/libs=
epol/tests/policies/test-expander/alias-base.conf
> index b950039d..34955924 100644
> --- a/libsepol/tests/policies/test-expander/alias-base.conf
> +++ b/libsepol/tests/policies/test-expander/alias-base.conf
> @@ -33,7 +33,7 @@ class key_socket
>  class unix_stream_socket
>  class unix_dgram_socket
>
> -# sysv-ipc-related clases
> +# sysv-ipc-related classes
>  class sem
>  class msg
>  class msgq
> diff --git a/libsepol/tests/policies/test-expander/role-base.conf b/libse=
pol/tests/policies/test-expander/role-base.conf
> index 8e88b4be..a387c8c0 100644
> --- a/libsepol/tests/policies/test-expander/role-base.conf
> +++ b/libsepol/tests/policies/test-expander/role-base.conf
> @@ -33,7 +33,7 @@ class key_socket
>  class unix_stream_socket
>  class unix_dgram_socket
>
> -# sysv-ipc-related clases
> +# sysv-ipc-related classes
>  class sem
>  class msg
>  class msgq
> diff --git a/libsepol/tests/policies/test-expander/small-base.conf b/libs=
epol/tests/policies/test-expander/small-base.conf
> index 055ea054..ac180f35 100644
> --- a/libsepol/tests/policies/test-expander/small-base.conf
> +++ b/libsepol/tests/policies/test-expander/small-base.conf
> @@ -33,7 +33,7 @@ class key_socket
>  class unix_stream_socket
>  class unix_dgram_socket
>
> -# sysv-ipc-related clases
> +# sysv-ipc-related classes
>  class sem
>  class msg
>  class msgq
> diff --git a/libsepol/tests/policies/test-expander/user-base.conf b/libse=
pol/tests/policies/test-expander/user-base.conf
> index b31ee8cd..789a59a2 100644
> --- a/libsepol/tests/policies/test-expander/user-base.conf
> +++ b/libsepol/tests/policies/test-expander/user-base.conf
> @@ -33,7 +33,7 @@ class key_socket
>  class unix_stream_socket
>  class unix_dgram_socket
>
> -# sysv-ipc-related clases
> +# sysv-ipc-related classes
>  class sem
>  class msg
>  class msgq
> diff --git a/libsepol/tests/policies/test-hooks/cmp_policy.conf b/libsepo=
l/tests/policies/test-hooks/cmp_policy.conf
> index 9082b333..3c510bc4 100644
> --- a/libsepol/tests/policies/test-hooks/cmp_policy.conf
> +++ b/libsepol/tests/policies/test-hooks/cmp_policy.conf
> @@ -33,7 +33,7 @@ class key_socket
>  class unix_stream_socket
>  class unix_dgram_socket
>
> -# sysv-ipc-related clases
> +# sysv-ipc-related classes
>  class sem
>  class msg
>  class msgq
> diff --git a/libsepol/tests/policies/test-hooks/small-base.conf b/libsepo=
l/tests/policies/test-hooks/small-base.conf
> index 9082b333..3c510bc4 100644
> --- a/libsepol/tests/policies/test-hooks/small-base.conf
> +++ b/libsepol/tests/policies/test-hooks/small-base.conf
> @@ -33,7 +33,7 @@ class key_socket
>  class unix_stream_socket
>  class unix_dgram_socket
>
> -# sysv-ipc-related clases
> +# sysv-ipc-related classes
>  class sem
>  class msg
>  class msgq
> diff --git a/libsepol/tests/policies/test-linker/small-base.conf b/libsep=
ol/tests/policies/test-linker/small-base.conf
> index 890ebbeb..15ced459 100644
> --- a/libsepol/tests/policies/test-linker/small-base.conf
> +++ b/libsepol/tests/policies/test-linker/small-base.conf
> @@ -33,7 +33,7 @@ class key_socket
>  class unix_stream_socket
>  class unix_dgram_socket
>
> -# sysv-ipc-related clases
> +# sysv-ipc-related classes
>  class sem
>  class msg
>  class msgq
> diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/=
newrole.c
> index c2afa37e..d9efa68a 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -1289,7 +1289,7 @@ int main(int argc, char *argv[])
>         /*
>          * Step 5:  Execute a new shell with the new context in `new_cont=
ext'.
>          *
> -        * Establish context, namesapce and any options for the new shell
> +        * Establish context, namespace and any options for the new shell
>          */
>         if (optind < 1)
>                 optind =3D 1;
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index b21d1484..e0bd98a9 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -130,7 +130,7 @@ class SetImportFile(argparse.Action):
>                  sys.exit(1)
>          setattr(namespace, self.dest, values)
>
> -# define dictionary for seobject OBEJCTS
> +# define dictionary for seobject OBJECTS
>  object_dict =3D {
>      'login': seobject.loginRecords,
>      'user': seobject.seluserRecords,
> diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepoli=
cy/manpage.py
> index 1bff8f9a..a488dcbf 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -739,7 +739,7 @@ SELinux %(domainname)s policy is very flexible allowi=
ng users to setup their %(d
>  .B STANDARD FILE CONTEXT
>
>  SELinux defines the file context types for the %(domainname)s, if you wa=
nted to
> -store files with these types in a diffent paths, you need to execute the=
 semanage command to specify alternate labeling and then use restorecon to =
put the labels on disk.
> +store files with these types in a different paths, you need to execute t=
he semanage command to specify alternate labeling and then use restorecon t=
o put the labels on disk.
>
>  .B semanage fcontext -a -t %(type)s '/srv/%(domainname)s/content(/.*)?'
>  .br
> --
> 2.39.0
>
