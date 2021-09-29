Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992ABC433F5
	for <selinux@archiver.kernel.org>; Wed, 29 Sep 2021 07:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D47E61357
	for <selinux@archiver.kernel.org>; Wed, 29 Sep 2021 07:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244596AbhI2HWW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Sep 2021 03:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244594AbhI2HWV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Sep 2021 03:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632900040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AassI4AZfxSJMU2eANsbPQnOq0iJK/ltT2dJF1DXjfc=;
        b=Up986QWN0oK1BonlNlFT8l28yDTnsAOsWI8UOW8HVTC3w3jodnFVIE/Ikg5xY62thekTm0
        DKPqB0fGvLLKPvok3XwSQOeSMLyEKY2t4ayJV1v7t8m7iQ5GwgQcoWh/6CPa6c3MFdkkoT
        qTAjCih1zya8JvICnf3JoNm8RCmK+ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-ot5fS67lP9SLcaiBZE0LQg-1; Wed, 29 Sep 2021 03:20:38 -0400
X-MC-Unique: ot5fS67lP9SLcaiBZE0LQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDB0210168CB;
        Wed, 29 Sep 2021 07:20:36 +0000 (UTC)
Received: from localhost (unknown [10.40.192.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8342F109B6E8;
        Wed, 29 Sep 2021 07:20:36 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] Correct some typos
In-Reply-To: <20210928154405.10722-1-cgzones@googlemail.com>
References: <20210928154405.10722-1-cgzones@googlemail.com>
Date:   Wed, 29 Sep 2021 09:20:35 +0200
Message-ID: <87r1d7u9to.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Found by codespell
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks!



> ---
>  policycoreutils/newrole/Makefile          | 2 +-
>  policycoreutils/newrole/newrole.c         | 2 +-
>  python/semanage/semanage                  | 6 +++---
>  python/sepolgen/src/sepolgen/refpolicy.py | 2 +-
>  python/sepolgen/src/sepolgen/yacc.py      | 2 +-
>  python/sepolicy/sepolicy/manpage.py       | 2 +-
>  secilc/docs/cil_access_vector_rules.md    | 2 +-
>  secilc/docs/secil.xml                     | 2 +-
>  secilc/test/block_test.cil                | 2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/M=
akefile
> index 0e7ebce3..4dedb7dd 100644
> --- a/policycoreutils/newrole/Makefile
> +++ b/policycoreutils/newrole/Makefile
> @@ -12,7 +12,7 @@ AUDITH ?=3D $(shell test -f $(INCLUDEDIR)/libaudit.h &&=
 echo y)
>  # This will make newrole a setuid root program.
>  # The capabilities used are: CAP_AUDIT_WRITE.
>  AUDIT_LOG_PRIV ?=3D n
> -# Enable capabilities to permit newrole to utilitize the pam_namespace m=
odule.
> +# Enable capabilities to permit newrole to utilize the pam_namespace mod=
ule.
>  # This will make newrole a setuid root program.
>  # The capabilities used are: CAP_SYS_ADMIN, CAP_CHOWN, CAP_FOWNER and
>  # CAP_DAC_OVERRIDE.=20
> diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/=
newrole.c
> index 7c1f062f..31b51c5a 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -1022,7 +1022,7 @@ static int set_signal_handles(void)
>  int main(int argc, char *argv[])
>  {
>  	char *new_context =3D NULL;	/* target security context */
> -	char *old_context =3D NULL;	/* original securiy context */
> +	char *old_context =3D NULL;	/* original security context */
>  	char *tty_context =3D NULL;	/* current context of tty */
>  	char *new_tty_context =3D NULL;	/* new context of tty */
>=20=20
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index 18a27105..ff9fb66b 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -129,7 +129,7 @@ class SetImportFile(argparse.Action):
>                  sys.exit(1)
>          setattr(namespace, self.dest, values)
>=20=20
> -# define dictonary for seobject OBEJCTS
> +# define dictionary for seobject OBEJCTS
>  object_dict =3D {
>      'login': seobject.loginRecords,
>      'user': seobject.seluserRecords,
> @@ -146,7 +146,7 @@ object_dict =3D {
>  }
>=20=20
>  def generate_custom_usage(usage_text, usage_dict):
> -    # generate custom usage from given text and dictonary
> +    # generate custom usage from given text and dictionary
>      sorted_keys =3D []
>      for i in usage_dict.keys():
>          sorted_keys.append(i)
> @@ -160,7 +160,7 @@ def generate_custom_usage(usage_text, usage_dict):
>=20=20
>=20=20
>  def handle_opts(args, dict, target_key):
> -    # handle conflict and required options for given dictonary
> +    # handle conflict and required options for given dictionary
>      # {action:[conflict_opts,require_opts]}
>=20=20
>      # first we need to catch conflicts
> diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/=
src/sepolgen/refpolicy.py
> index 74763687..3e907e91 100644
> --- a/python/sepolgen/src/sepolgen/refpolicy.py
> +++ b/python/sepolgen/src/sepolgen/refpolicy.py
> @@ -42,7 +42,7 @@ PERMS     =3D 3
>  ROLE      =3D 4
>  DEST_TYPE =3D 5
>=20=20
> -# String represenations of the above constants
> +# String representations of the above constants
>  field_to_str =3D ["source", "target", "object", "permission", "role", "d=
estination" ]
>  str_to_field =3D { "source" : SRC_TYPE, "target" : TGT_TYPE, "object" : =
OBJ_CLASS,
>                  "permission" : PERMS, "role" : ROLE, "destination" : DES=
T_TYPE }
> diff --git a/python/sepolgen/src/sepolgen/yacc.py b/python/sepolgen/src/s=
epolgen/yacc.py
> index 55c1ef7d..c1c79880 100644
> --- a/python/sepolgen/src/sepolgen/yacc.py
> +++ b/python/sepolgen/src/sepolgen/yacc.py
> @@ -1502,7 +1502,7 @@ class Grammar(object):
>          self.Precedence   =3D {}      # Precedence rules for each termin=
al. Contains tuples of the
>                                      # form ('right',level) or ('nonassoc=
', level) or ('left',level)
>=20=20
> -        self.UsedPrecedence =3D set() # Precedence rules that were actua=
lly used by the grammer.
> +        self.UsedPrecedence =3D set() # Precedence rules that were actua=
lly used by the grammar.
>                                      # This is only used to provide error=
 checking and to generate
>                                      # a warning about unused precedence =
rules.
>=20=20
> diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepoli=
cy/manpage.py
> index 2f847abb..3e61e333 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -797,7 +797,7 @@ SELinux %(domainname)s policy is very flexible allowi=
ng users to setup their %(d
>  .B STANDARD FILE CONTEXT
>=20=20
>  SELinux defines the file context types for the %(domainname)s, if you wa=
nted to
> -store files with these types in a diffent paths, you need to execute the=
 semanage command to sepecify alternate labeling and then use restorecon to=
 put the labels on disk.
> +store files with these types in a diffent paths, you need to execute the=
 semanage command to specify alternate labeling and then use restorecon to =
put the labels on disk.
>=20=20
>  .B semanage fcontext -a -t %(type)s '/srv/%(domainname)s/content(/.*)?'
>  .br
> diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_acc=
ess_vector_rules.md
> index fa68609e..f0ba4a90 100644
> --- a/secilc/docs/cil_access_vector_rules.md
> +++ b/secilc/docs/cil_access_vector_rules.md
> @@ -360,7 +360,7 @@ dontauditx
>=20=20
>  Do not audit the access rights defined when access denied. This stops ex=
cessive log entries for known events.
>=20=20
> -Note that for this to work there must *also* be atleast one [`allowx`](c=
il_access_vector_rules.md#allowx) rule associated with the target type.
> +Note that for this to work there must *also* be at least one [`allowx`](=
cil_access_vector_rules.md#allowx) rule associated with the target type.
>=20=20
>  Note that these rules can be omitted by the CIL compiler command line pa=
rameter `-D` or `--disable-dontaudit` flags.
>=20=20
> diff --git a/secilc/docs/secil.xml b/secilc/docs/secil.xml
> index daa80ded..b015490d 100644
> --- a/secilc/docs/secil.xml
> +++ b/secilc/docs/secil.xml
> @@ -208,7 +208,7 @@
>              <context name=3D"String" attribute=3D"String" lineEndContext=
=3D"#stay">
>                  <RegExpr attribute=3D"Char" context=3D"#stay" String=3D"=
#\\."/>
>=20=20
> -                <!-- allow escaping " or similiar -->
> +                <!-- allow escaping " or similar -->
>                  <HlCStringChar attribute=3D"String Char" context=3D"#sta=
y"/>
>=20=20
>                  <DetectChar attribute=3D"String" context=3D"#pop" char=
=3D"&quot;"/>
> diff --git a/secilc/test/block_test.cil b/secilc/test/block_test.cil
> index 2dfcb899..2dd30c23 100644
> --- a/secilc/test/block_test.cil
> +++ b/secilc/test/block_test.cil
> @@ -84,7 +84,7 @@
>  )
>=20=20
>=20=20
> -;; Inherting the abstract block causes the allow rule to be in the policy
> +;; Inheriting the abstract block causes the allow rule to be in the poli=
cy
>  (type t5)
>  (block b5
>    (blockabstract b5)
> --=20
> 2.33.0

