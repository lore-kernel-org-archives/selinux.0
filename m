Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764B7C433F5
	for <selinux@archiver.kernel.org>; Tue, 12 Apr 2022 18:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbiDLSEJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Apr 2022 14:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbiDLSEJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Apr 2022 14:04:09 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A43580ED
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 11:01:51 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id p34-20020a4a95e5000000b003248d73d460so3400725ooi.1
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 11:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8PyhgUkI8j/S60KKVoEq8iXdfZnBI4LL690fXrmufHA=;
        b=j4K+68ACH/vR/iC/C8Vfx/v8r4LLuVD+UoPIHNMXNat496MRupGdjUJxJgKjz60Too
         8O0cYRgDafljIFqJ4/5DY0iXkkMs3Lah0WzvKCy7gbdrlJYCh+v5IIrV6DDGSV7oAxNI
         FN+sLDg2Aj0tueOFOELHbU/42Skq8+/cmUpLUARVagEaLpniR1x5csmBAjdbMUXnFJXM
         5a1QsQeW8WleAx38KGABGHCigsuVIpFxhab95nTASLImCKHo8q5/MkWFpc5M0iZG1Iu7
         j0Rp2okIYinvDS4eePWQ84ld8KlEfwYtccSfzpaULiAexNX8PemEaTnER4AVo7IGjI+F
         7M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8PyhgUkI8j/S60KKVoEq8iXdfZnBI4LL690fXrmufHA=;
        b=GW+/bwydTF2PAT7SyKxtaVeUe1+SapYMs91HN4qShvGVfVsOMDekE3JrHNI3dP0UT6
         5G3JizgN6ysARVUNVmgEQwbyNhuxR3/49uG7d3+xtnJu/9aLa/OxMJplyOL914hniOVa
         MgNXQTdYfYYGd3ZPCs2GqHEG/ZEHoqivn4ytm58Uw2ojx9igjAPBgiN09kLKWdqzwsBP
         +fHA49L9BI3EzSrrNdAbMkNzEmzRLsS+jMs/X9ZVHXVVEvx+Bz8r8+W+L5/0pL4qV78k
         julDtJeD/ixB5H/t9JYrjMvigt+LVOveMDlIczEW2/gPdENGkoDeHb5xC39jdwr3PT8M
         h75Q==
X-Gm-Message-State: AOAM5310WPhojFBvUz3lbbsF96H9OejFvotrFKqa3nx/148FvJBQDAvG
        GeKaAPctJjTsRN/3cxlT00JLXXYROJti0GfCaVwObrxH
X-Google-Smtp-Source: ABdhPJy43R8dGeeCMfFbEwKm7iF3zHdVk2wP/1CHxZ4swZkd44sZ4fLgvHEqAjQmhETO39M817LrMUGeRTwbGPiyaek=
X-Received: by 2002:a4a:3f56:0:b0:324:bc64:6713 with SMTP id
 x22-20020a4a3f56000000b00324bc646713mr12018367ooe.50.1649786510197; Tue, 12
 Apr 2022 11:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220408131031.7825-1-cgzones@googlemail.com> <CAP+JOzS24L6zOSY8oBzAdN_z0+A8bterqLk0Nj1OiOdHY6YQjw@mail.gmail.com>
In-Reply-To: <CAP+JOzS24L6zOSY8oBzAdN_z0+A8bterqLk0Nj1OiOdHY6YQjw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 12 Apr 2022 14:01:39 -0400
Message-ID: <CAP+JOzQty9cY4YDjeLN0_u8oRiDdCVSNc_oHBjp9s92TYTCRrQ@mail.gmail.com>
Subject: Re: [PATCH] Correct misc typos
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 12, 2022 at 9:45 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Apr 8, 2022 at 11:24 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Found by typos[1].
> >
> > [1]: https://github.com/crate-ci/typos
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
thanks,
Jim

> > ---
> >  libsemanage/src/genhomedircon.c             | 2 +-
> >  libsemanage/src/handle.h                    | 2 +-
> >  libsemanage/src/semanage_store.c            | 2 +-
> >  libsemanage/tests/test_iface.c              | 2 +-
> >  policycoreutils/newrole/newrole.pamd        | 2 +-
> >  policycoreutils/run_init/run_init.pamd      | 2 +-
> >  python/sepolgen/src/sepolgen/objectmodel.py | 2 +-
> >  python/sepolgen/src/sepolgen/refpolicy.py   | 2 +-
> >  python/sepolgen/tests/test_audit.py         | 2 +-
> >  python/sepolgen/tests/test_refpolicy.py     | 2 +-
> >  python/sepolicy/sepolicy-bash-completion.sh | 6 +++---
> >  python/sepolicy/sepolicy/gui.py             | 4 ++--
> >  12 files changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomed=
ircon.c
> > index 7ca9afc3..8f8774d3 100644
> > --- a/libsemanage/src/genhomedircon.c
> > +++ b/libsemanage/src/genhomedircon.c
> > @@ -490,7 +490,7 @@ static int STR_COMPARATOR(const void *a, const void=
 *b)
> >         return strcmp((const char *) a, (const char *) b);
> >  }
> >
> > -/* make_tempate
> > +/* make_template
> >   * @param      s         the settings holding the paths to various fil=
es
> >   * @param      pred    function pointer to function to use as filter f=
or slurp
> >   *                                     file filter
> > diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
> > index 4d2aae8f..c7f4e903 100644
> > --- a/libsemanage/src/handle.h
> > +++ b/libsemanage/src/handle.h
> > @@ -72,7 +72,7 @@ struct semanage_handle {
> >         int do_check_contexts;  /* whether to run setfiles check the fi=
le contexts file */
> >
> >         /* This timeout is used for transactions and waiting for lock
> > -          -1 means wait indefinetely
> > +          -1 means wait indefinitely
> >            0 means return immediately
> >            >0 means wait that many seconds */
> >         int timeout;
> > diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanag=
e_store.c
> > index c6d2c5e7..14a0957a 100644
> > --- a/libsemanage/src/semanage_store.c
> > +++ b/libsemanage/src/semanage_store.c
> > @@ -1327,7 +1327,7 @@ static char **split_args(const char *arg0, char *=
arg_string,
> >                 goto cleanup;
> >         s =3D arg_string;
> >         /* parse the argument string one character at a time,
> > -        * repsecting quotes and other special characters */
> > +        * respecting quotes and other special characters */
> >         while (s !=3D NULL && *s !=3D '\0') {
> >                 switch (*s) {
> >                 case '\\':{
> > diff --git a/libsemanage/tests/test_iface.c b/libsemanage/tests/test_if=
ace.c
> > index 434372f8..46937e10 100644
> > --- a/libsemanage/tests/test_iface.c
> > +++ b/libsemanage/tests/test_iface.c
> > @@ -47,7 +47,7 @@ void test_iface_get_set_msgcon(void);
> >  void test_iface_create(void);
> >  void test_iface_clone(void);
> >
> > -/* iterfaces_policy.h */
> > +/* interfaces_policy.h */
> >  void test_iface_query(void);
> >  void test_iface_exists(void);
> >  void test_iface_count(void);
> > diff --git a/policycoreutils/newrole/newrole.pamd b/policycoreutils/new=
role/newrole.pamd
> > index de3582f3..683c5441 100644
> > --- a/policycoreutils/newrole/newrole.pamd
> > +++ b/policycoreutils/newrole/newrole.pamd
> > @@ -1,5 +1,5 @@
> >  #%PAM-1.0
> > -# Uncomment the next line if you do not want to enter your passwd ever=
ytime
> > +# Uncomment the next line if you do not want to enter your passwd ever=
y time
> >  # auth       sufficient   pam_rootok.so
> >  auth       include     system-auth
> >  account    include     system-auth
> > diff --git a/policycoreutils/run_init/run_init.pamd b/policycoreutils/r=
un_init/run_init.pamd
> > index 1c323d20..ef460134 100644
> > --- a/policycoreutils/run_init/run_init.pamd
> > +++ b/policycoreutils/run_init/run_init.pamd
> > @@ -1,5 +1,5 @@
> >  #%PAM-1.0
> > -# Uncomment the next line if you do not want to enter your passwd ever=
ytime
> > +# Uncomment the next line if you do not want to enter your passwd ever=
y time
> >  #auth       sufficient   pam_rootok.so
> >  auth       include     system-auth
> >  account    include     system-auth
> > diff --git a/python/sepolgen/src/sepolgen/objectmodel.py b/python/sepol=
gen/src/sepolgen/objectmodel.py
> > index 84955f7c..ccce86c1 100644
> > --- a/python/sepolgen/src/sepolgen/objectmodel.py
> > +++ b/python/sepolgen/src/sepolgen/objectmodel.py
> > @@ -95,7 +95,7 @@ class PermMappings:
> >      """The information flow properties of a set of object classes and =
permissions.
> >
> >      PermMappings maps one or more classes and permissions to their Per=
mMap objects
> > -    describing their information flow charecteristics.
> > +    describing their information flow characteristics.
> >      """
> >      def __init__(self):
> >          self.classes =3D { }
> > diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolge=
n/src/sepolgen/refpolicy.py
> > index 3e907e91..9cac1b95 100644
> > --- a/python/sepolgen/src/sepolgen/refpolicy.py
> > +++ b/python/sepolgen/src/sepolgen/refpolicy.py
> > @@ -34,7 +34,7 @@ import selinux
> >  # the data structures that we need for policy generation.
> >  #
> >
> > -# Constans for referring to fields
> > +# Constants for referring to fields
> >  SRC_TYPE  =3D 0
> >  TGT_TYPE  =3D 1
> >  OBJ_CLASS =3D 2
> > diff --git a/python/sepolgen/tests/test_audit.py b/python/sepolgen/test=
s/test_audit.py
> > index dbe6be2a..b659bf3b 100644
> > --- a/python/sepolgen/tests/test_audit.py
> > +++ b/python/sepolgen/tests/test_audit.py
> > @@ -230,7 +230,7 @@ class TestGeneration(unittest.TestCase):
> >
> >          self.assertEqual(len(avs), 1)
> >
> > -    def test_genaration_granted(self):
> > +    def test_generation_granted(self):
> >          parser =3D sepolgen.audit.AuditParser()
> >          parser.parse_string(granted1)
> >          avs =3D parser.to_access()
> > diff --git a/python/sepolgen/tests/test_refpolicy.py b/python/sepolgen/=
tests/test_refpolicy.py
> > index c7219fd5..a24381a6 100644
> > --- a/python/sepolgen/tests/test_refpolicy.py
> > +++ b/python/sepolgen/tests/test_refpolicy.py
> > @@ -144,7 +144,7 @@ class TestSecurityContext(unittest.TestCase):
> >          self.assertNotEqual(sc1, sc3)
> >          self.assertNotEqual(sc1, sc4)
> >
> > -class TestObjecClass(unittest.TestCase):
> > +class TestObjectClass(unittest.TestCase):
> >      def test_init(self):
> >          o =3D refpolicy.ObjectClass(name=3D"file")
> >          self.assertEqual(o.name, "file")
> > diff --git a/python/sepolicy/sepolicy-bash-completion.sh b/python/sepol=
icy/sepolicy-bash-completion.sh
> > index 779fd75b..13638e4d 100644
> > --- a/python/sepolicy/sepolicy-bash-completion.sh
> > +++ b/python/sepolicy/sepolicy-bash-completion.sh
> > @@ -36,10 +36,10 @@ __get_all_booleans () {
> >  __get_all_types () {
> >      seinfo -t 2> /dev/null | tail -n +3
> >  }
> > -__get_all_admin_interaces () {
> > +__get_all_admin_interfaces () {
> >      awk '/InterfaceVector.*_admin /{ print $2 }' /var/lib/sepolgen/int=
erface_info | awk -F '_admin' '{ print $1 }'
> >  }
> > -__get_all_user_role_interaces () {
> > +__get_all_user_role_interfaces () {
> >      awk '/InterfaceVector.*_role /{ print $2 }' /var/lib/sepolgen/inte=
rface_info | awk -F '_role' '{ print $1 }'
> >  }
> >  __get_all_user_domains () {
> > @@ -139,7 +139,7 @@ _sepolicy () {
> >                  COMPREPLY=3D( $(compgen -W "-n --name -t --type" -- "$=
cur") )
> >                  return 0
> >              elif [ "$prev" =3D "--admin" -o "$prev" =3D "-a" ]; then
> > -                COMPREPLY=3D( $(compgen -W "$( __get_all_admin_interac=
es ) " -- "$cur") )
> > +                COMPREPLY=3D( $(compgen -W "$( __get_all_admin_interfa=
ces ) " -- "$cur") )
> >                  return 0
> >              elif [ "$prev" =3D "--user" -o "$prev" =3D "-u" ]; then
> >                  COMPREPLY=3D( $(compgen -W "$( __get_all_users )" -- "=
$cur") )
> > diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy=
/gui.py
> > index c9ca158d..4f892f82 100644
> > --- a/python/sepolicy/sepolicy/gui.py
> > +++ b/python/sepolicy/sepolicy/gui.py
> > @@ -1309,9 +1309,9 @@ class SELinuxGui():
> >                  filename =3D i['filename']
> >              else:
> >                  filename =3D None
> > -            self.transitions_files_inital_data_insert(i['target'], i['=
class'], i['transtype'], filename)
> > +            self.transitions_files_initial_data_insert(i['target'], i[=
'class'], i['transtype'], filename)
> >
> > -    def transitions_files_inital_data_insert(self, path, tclass, dest,=
 name):
> > +    def transitions_files_initial_data_insert(self, path, tclass, dest=
, name):
> >          iter =3D self.transitions_file_liststore.append()
> >          self.transitions_file_liststore.set_value(iter, 0, path)
> >          self.transitions_file_liststore.set_value(iter, 1, tclass)
> > --
> > 2.35.1
> >
