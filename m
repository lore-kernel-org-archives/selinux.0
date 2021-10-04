Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618A0C433EF
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 13:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4443961184
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 13:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbhJDNy0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbhJDNyY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Oct 2021 09:54:24 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A80C0C0000
        for <selinux@vger.kernel.org>; Mon,  4 Oct 2021 06:35:46 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id l8-20020a4ae2c8000000b002b5ec765d9fso5331713oot.13
        for <selinux@vger.kernel.org>; Mon, 04 Oct 2021 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WtGEPZcQTnx2+SuaOIELzUv3DP8nQA7Z15/yJ0H1Xvs=;
        b=W4/UoHOKQyBwbsRDntBo//poq8qB4+D7dfpeyMx4YtzuRD8vd5B8CB2lNtm3bM8aaH
         EySsHJIzpQwQFlecE8ePXRnlI4/H8a7VTQg2MGujlogHPcTo0voCCvFsoCY0gXG5Lax0
         YvgNNNKW/BY00sVKSMLLQ7zN+ZliVaiam43fGW2sSa6Lx7znswGUyp4zvLctBImy24AP
         XVm3uDqWosoVFbRjXHSqH50qPHas16OyzwJvWSOqfrxfRXPe3qAL5QrQUqrywDkusEW2
         EpsdO/TxnlQOoGN3qzdXS2m9IDA2Ipmnw0EFjSflX5LzxLCZwwgDWT4dHI9Vn1BvMNgl
         mGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WtGEPZcQTnx2+SuaOIELzUv3DP8nQA7Z15/yJ0H1Xvs=;
        b=F6xnan1TrLIrmLhTPvCkCPg+t1o0FxMN3emiVPTdQ+lX9/C809+kKXPMRg//CwpSTP
         v8pnNySEZOeugxi6WPK9cefLG8t1WuQGsnECpBW8hJoSyso6a54F4QPpUJ8ZhQaOaG1+
         j8B2oM6SK1ac1NM1+0U6BXYpZ8s1u/X+BPCK2+cns7fkbxVa+zlTcl8rynhzdIOl/W4L
         teenhGY5TaZhOTtgo+piQK9wxw1FYPnhCdxxNlKj/3z0VKBQMdteIDn0InhSrIhbrgmN
         e70dMEXRPWJPJ5lF1cPQd2ELPuPgOvBkX4ePifMtvaOJ7Up7lwdLWv8Ugk1TKDoCjI8j
         Ge3Q==
X-Gm-Message-State: AOAM532RWau0iHtTeXDIJm7N/fIT2JmbgRRfqwe82Zpi9p23eYwHr5hV
        qLmpHlG45wvvvDOoJeFwQSi/h7rE5471861k6GyCXLsG
X-Google-Smtp-Source: ABdhPJyJ75APJMYBYvatp5acz0Fbgf875dDotyQkUv7Pd7+6aNEBvmJUhUHxDFyBXk4xIq1qqaTS2seBy2ZZGcsnRYw=
X-Received: by 2002:a4a:c3c2:: with SMTP id e2mr9012785ooq.8.1633354545621;
 Mon, 04 Oct 2021 06:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210928154405.10722-1-cgzones@googlemail.com> <87r1d7u9to.fsf@redhat.com>
In-Reply-To: <87r1d7u9to.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Oct 2021 09:35:34 -0400
Message-ID: <CAP+JOzTvN8N=eeFEJdr28j6sPFbx1uN_J9iaWk83-o1Y=NLqGQ@mail.gmail.com>
Subject: Re: [PATCH] Correct some typos
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 29, 2021 at 3:22 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
>
> > Found by codespell
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>

This patch has been merged.
Thanks,
Jim

> Thanks!
>
>
>
> > ---
> >  policycoreutils/newrole/Makefile          | 2 +-
> >  policycoreutils/newrole/newrole.c         | 2 +-
> >  python/semanage/semanage                  | 6 +++---
> >  python/sepolgen/src/sepolgen/refpolicy.py | 2 +-
> >  python/sepolgen/src/sepolgen/yacc.py      | 2 +-
> >  python/sepolicy/sepolicy/manpage.py       | 2 +-
> >  secilc/docs/cil_access_vector_rules.md    | 2 +-
> >  secilc/docs/secil.xml                     | 2 +-
> >  secilc/test/block_test.cil                | 2 +-
> >  9 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole=
/Makefile
> > index 0e7ebce3..4dedb7dd 100644
> > --- a/policycoreutils/newrole/Makefile
> > +++ b/policycoreutils/newrole/Makefile
> > @@ -12,7 +12,7 @@ AUDITH ?=3D $(shell test -f $(INCLUDEDIR)/libaudit.h =
&& echo y)
> >  # This will make newrole a setuid root program.
> >  # The capabilities used are: CAP_AUDIT_WRITE.
> >  AUDIT_LOG_PRIV ?=3D n
> > -# Enable capabilities to permit newrole to utilitize the pam_namespace=
 module.
> > +# Enable capabilities to permit newrole to utilize the pam_namespace m=
odule.
> >  # This will make newrole a setuid root program.
> >  # The capabilities used are: CAP_SYS_ADMIN, CAP_CHOWN, CAP_FOWNER and
> >  # CAP_DAC_OVERRIDE.
> > diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrol=
e/newrole.c
> > index 7c1f062f..31b51c5a 100644
> > --- a/policycoreutils/newrole/newrole.c
> > +++ b/policycoreutils/newrole/newrole.c
> > @@ -1022,7 +1022,7 @@ static int set_signal_handles(void)
> >  int main(int argc, char *argv[])
> >  {
> >       char *new_context =3D NULL;       /* target security context */
> > -     char *old_context =3D NULL;       /* original securiy context */
> > +     char *old_context =3D NULL;       /* original security context */
> >       char *tty_context =3D NULL;       /* current context of tty */
> >       char *new_tty_context =3D NULL;   /* new context of tty */
> >
> > diff --git a/python/semanage/semanage b/python/semanage/semanage
> > index 18a27105..ff9fb66b 100644
> > --- a/python/semanage/semanage
> > +++ b/python/semanage/semanage
> > @@ -129,7 +129,7 @@ class SetImportFile(argparse.Action):
> >                  sys.exit(1)
> >          setattr(namespace, self.dest, values)
> >
> > -# define dictonary for seobject OBEJCTS
> > +# define dictionary for seobject OBEJCTS
> >  object_dict =3D {
> >      'login': seobject.loginRecords,
> >      'user': seobject.seluserRecords,
> > @@ -146,7 +146,7 @@ object_dict =3D {
> >  }
> >
> >  def generate_custom_usage(usage_text, usage_dict):
> > -    # generate custom usage from given text and dictonary
> > +    # generate custom usage from given text and dictionary
> >      sorted_keys =3D []
> >      for i in usage_dict.keys():
> >          sorted_keys.append(i)
> > @@ -160,7 +160,7 @@ def generate_custom_usage(usage_text, usage_dict):
> >
> >
> >  def handle_opts(args, dict, target_key):
> > -    # handle conflict and required options for given dictonary
> > +    # handle conflict and required options for given dictionary
> >      # {action:[conflict_opts,require_opts]}
> >
> >      # first we need to catch conflicts
> > diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolge=
n/src/sepolgen/refpolicy.py
> > index 74763687..3e907e91 100644
> > --- a/python/sepolgen/src/sepolgen/refpolicy.py
> > +++ b/python/sepolgen/src/sepolgen/refpolicy.py
> > @@ -42,7 +42,7 @@ PERMS     =3D 3
> >  ROLE      =3D 4
> >  DEST_TYPE =3D 5
> >
> > -# String represenations of the above constants
> > +# String representations of the above constants
> >  field_to_str =3D ["source", "target", "object", "permission", "role", =
"destination" ]
> >  str_to_field =3D { "source" : SRC_TYPE, "target" : TGT_TYPE, "object" =
: OBJ_CLASS,
> >                  "permission" : PERMS, "role" : ROLE, "destination" : D=
EST_TYPE }
> > diff --git a/python/sepolgen/src/sepolgen/yacc.py b/python/sepolgen/src=
/sepolgen/yacc.py
> > index 55c1ef7d..c1c79880 100644
> > --- a/python/sepolgen/src/sepolgen/yacc.py
> > +++ b/python/sepolgen/src/sepolgen/yacc.py
> > @@ -1502,7 +1502,7 @@ class Grammar(object):
> >          self.Precedence   =3D {}      # Precedence rules for each term=
inal. Contains tuples of the
> >                                      # form ('right',level) or ('nonass=
oc', level) or ('left',level)
> >
> > -        self.UsedPrecedence =3D set() # Precedence rules that were act=
ually used by the grammer.
> > +        self.UsedPrecedence =3D set() # Precedence rules that were act=
ually used by the grammar.
> >                                      # This is only used to provide err=
or checking and to generate
> >                                      # a warning about unused precedenc=
e rules.
> >
> > diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepo=
licy/manpage.py
> > index 2f847abb..3e61e333 100755
> > --- a/python/sepolicy/sepolicy/manpage.py
> > +++ b/python/sepolicy/sepolicy/manpage.py
> > @@ -797,7 +797,7 @@ SELinux %(domainname)s policy is very flexible allo=
wing users to setup their %(d
> >  .B STANDARD FILE CONTEXT
> >
> >  SELinux defines the file context types for the %(domainname)s, if you =
wanted to
> > -store files with these types in a diffent paths, you need to execute t=
he semanage command to sepecify alternate labeling and then use restorecon =
to put the labels on disk.
> > +store files with these types in a diffent paths, you need to execute t=
he semanage command to specify alternate labeling and then use restorecon t=
o put the labels on disk.
> >
> >  .B semanage fcontext -a -t %(type)s '/srv/%(domainname)s/content(/.*)?=
'
> >  .br
> > diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_a=
ccess_vector_rules.md
> > index fa68609e..f0ba4a90 100644
> > --- a/secilc/docs/cil_access_vector_rules.md
> > +++ b/secilc/docs/cil_access_vector_rules.md
> > @@ -360,7 +360,7 @@ dontauditx
> >
> >  Do not audit the access rights defined when access denied. This stops =
excessive log entries for known events.
> >
> > -Note that for this to work there must *also* be atleast one [`allowx`]=
(cil_access_vector_rules.md#allowx) rule associated with the target type.
> > +Note that for this to work there must *also* be at least one [`allowx`=
](cil_access_vector_rules.md#allowx) rule associated with the target type.
> >
> >  Note that these rules can be omitted by the CIL compiler command line =
parameter `-D` or `--disable-dontaudit` flags.
> >
> > diff --git a/secilc/docs/secil.xml b/secilc/docs/secil.xml
> > index daa80ded..b015490d 100644
> > --- a/secilc/docs/secil.xml
> > +++ b/secilc/docs/secil.xml
> > @@ -208,7 +208,7 @@
> >              <context name=3D"String" attribute=3D"String" lineEndConte=
xt=3D"#stay">
> >                  <RegExpr attribute=3D"Char" context=3D"#stay" String=
=3D"#\\."/>
> >
> > -                <!-- allow escaping " or similiar -->
> > +                <!-- allow escaping " or similar -->
> >                  <HlCStringChar attribute=3D"String Char" context=3D"#s=
tay"/>
> >
> >                  <DetectChar attribute=3D"String" context=3D"#pop" char=
=3D"&quot;"/>
> > diff --git a/secilc/test/block_test.cil b/secilc/test/block_test.cil
> > index 2dfcb899..2dd30c23 100644
> > --- a/secilc/test/block_test.cil
> > +++ b/secilc/test/block_test.cil
> > @@ -84,7 +84,7 @@
> >  )
> >
> >
> > -;; Inherting the abstract block causes the allow rule to be in the pol=
icy
> > +;; Inheriting the abstract block causes the allow rule to be in the po=
licy
> >  (type t5)
> >  (block b5
> >    (blockabstract b5)
> > --
> > 2.33.0
>
