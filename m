Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B22685929
	for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965276; cv=none; b=koAG8csC67y4+en9gcjVQrBnLeKN1zCMBdAWTCr1gn4b96wqtY+Jr8uaHk/6DWxAMJNlZt2WN9j92VVdJJyawRM8AnrBowHy2McrUyjCwHsAvQQ49lTHRavI+Y3YYkK65+CFkYIAQ/JABm9Qw6DdzDBDIrCI094lzeq04Pe48c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965276; c=relaxed/simple;
	bh=9smz8RGwSlw/W4yLWUhV1hDYXpoEzjW+KGpplrqAfkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2tku86GK3E8YTnext9XARapL1MkBMn5qXRQ7+BILEOX10+iLosFFJv51tV5wgefw+zv4Qq8vCrr1d+8uIo8pzK6J5C3700+FHbGcIxjblikZ2SouahZaTkLF3svAQzoF7BjzWAo910zoIO40aMJhGr1J6m70RxBIJ3rAScOtxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+VOF9Ks; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+VOF9Ks"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-476025fde0aso44023137.1
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710965272; x=1711570072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zegO+jzbE/B/haTVw3YgEQzf7qKTX59537FwLKzj9QQ=;
        b=F+VOF9KsJ4Qhu3VQbk0RDTMgSGZNDUajz1LEg1HF2vNPqL/t0vws+528INnM4PFB2D
         99JlbwefdckSMVSMdxmP80qWIWedX5p6vWsQ7ImNpV/MdSL5qD8xKvreET2js3nKbHIE
         UrTuegCXdUbAZWKOwwJGCzRimuSmC45K6FX5sqcPzYyeW2rI1EfxHxiuswpI/7CF8eNe
         0iwuu6IP3Sva5jSgq0kY+z9A2f7OlXiipir8N3E00v9P/T/jccAc1oFuPOILJfqYt+eL
         SvDVbumcYEpFUqqWUuQ1be54GKRk350GAiD7i1vzP/nSnkVAQ3+ZyNaCTmuXUOfLjdSs
         /ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965272; x=1711570072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zegO+jzbE/B/haTVw3YgEQzf7qKTX59537FwLKzj9QQ=;
        b=UNiN9cghPvHJOeCOA9ZvRubkQT7cNhaaZavwP3Bz69PtDYUYJreKW5MqvMJJHaGwES
         9ujWiwLuIaGhUhbiag8xalz7dyQcYle1rb24lvlSJVpwxval3tB2acebzipzJLYE7KK+
         fSftY4ZnxsEtiEoZzCEwIlbietEfoLje/eusImZV9OlQVLlm2vjwi1+vfQLU99i5HJqz
         2JrbBaCGp6mKKM8qrV8tw+HhuOpv4mcE0SGdVIu4yL8282MnHXJ5FSBYGResNzuiWVSp
         otKCmm+vAh4ofDXxGc7pZRtk4C/Js35Lwlss+nbAJBptXHMlfpVzdzshfFmQboGill/V
         iglg==
X-Gm-Message-State: AOJu0YxO59Rm9wWl2bRF7Xi/6nRqCNG3xLDlgeEwwBltM5C1YU0lpQV4
	Gi6QZns1SwKcPDYV60TvteshQkVU6x1hOXFiWw0cGu0xUPaHPo+Q5n07BcQd9ohmQaGTpBgeynx
	RtWrm4NWVIUhiWmymFoDsDGDYFkk=
X-Google-Smtp-Source: AGHT+IHimQoWuqF/3DO2ZRsr2+WkC16FPEMTHTN11phUnQ3BbdlmrORmcOGgz/S56Rp2iM4f7MI9dJj2VuJivH0cgcQ=
X-Received: by 2002:a05:6102:11e2:b0:474:cdd0:2c42 with SMTP id
 e2-20020a05610211e200b00474cdd02c42mr17477564vsg.4.1710965272046; Wed, 20 Mar
 2024 13:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319185321.12794-2-toiwoton@gmail.com> <CAP+JOzT6SPpiVBNfsUT1YtQvk_mRvo_YNCn61SCCY2x5xmscvA@mail.gmail.com>
In-Reply-To: <CAP+JOzT6SPpiVBNfsUT1YtQvk_mRvo_YNCn61SCCY2x5xmscvA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 Mar 2024 16:07:41 -0400
Message-ID: <CAP+JOzQ9qLU2TDJ9qK74p+3=OJWHmSqLeM8NGF_vZs8EZFp0_A@mail.gmail.com>
Subject: Re: [PATCH PR#420 v4] audit2allow: CIL output mode
To: Topi Miettinen <toiwoton@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 10:38=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Tue, Mar 19, 2024 at 2:59=E2=80=AFPM Topi Miettinen <toiwoton@gmail.co=
m> wrote:
> >
> > New flag -C for audit2allow sets output format to CIL instead of
> > Policy Language.
> >
> > Example:
> > ;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D mozilla_t =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > ;!!!! This avc is allowed in the current policy
> > (allow mozilla_t user_sudo_t (fd (use)))
> >
> > ;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D user_t =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >
> > ;!!!! This avc can be allowed using the boolean 'allow_execmem'
> > (allow user_t self (process (execmem)))
> > (allow user_t chromium_t (process (noatsecure rlimitinh siginh)))
> >
> > ;!!!! This avc is a constraint violation.  You would need to modify the=
 attributes of either the source or target types to allow this access.
> > ;Constraint rule:
> > ;       constrain dir { ioctl read write create getattr setattr lock re=
labelfrom relabelto append map unlink link rename execute quotaon mounton a=
udit_access open execmod watch watch_mount watch_sb watch_with_perm watch_r=
eads add_name remove_name reparent search rmdir } ((u1 =3D=3D u2 -Fail-)  o=
r (u1 =3D=3D system_u -Fail-)  or (u1 =3D=3D unconfined_u -Fail-)  or (u1 =
=3D=3D sysadm_u -Fail-)  or (u2 =3D=3D system_u -Fail-)  or (t1 !=3D ubac_c=
onstrained_type -Fail-)  or (t2 !=3D ubac_constrained_type -Fail-)  or (t1 =
=3D=3D ubacfile -Fail-) ); Constraint DENIED
> >
> > ;       Possible cause is the source user (user_u) and target user (sys=
adm_u) are different.
> > (allow user_t user_home_dir_t (dir (getattr relabelto)))
> >
> > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>
> Everything looks good. Thanks!
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

This patch has been merged.
Thanks,
Jim

> >
> > ---
> > v4: several fixes to issues found by James Carter
> > v3: fixed extended permissions syntax
> > v2: fix uninitialized variable detected by CI
> > ---
> >  python/audit2allow/audit2allow            |  14 +-
> >  python/audit2allow/audit2allow.1          |   3 +
> >  python/sepolgen/src/sepolgen/output.py    |   5 +
> >  python/sepolgen/src/sepolgen/policygen.py |  32 ++-
> >  python/sepolgen/src/sepolgen/refpolicy.py | 334 +++++++++++++++++-----
> >  5 files changed, 298 insertions(+), 90 deletions(-)
> >
> > diff --git a/python/audit2allow/audit2allow b/python/audit2allow/audit2=
allow
> > index 35b0b151..b5927ec1 100644
> > --- a/python/audit2allow/audit2allow
> > +++ b/python/audit2allow/audit2allow
> > @@ -75,6 +75,7 @@ class AuditToPolicy:
> >                            help=3D"generate policy with dontaudit rules=
")
> >          parser.add_option("-R", "--reference", action=3D"store_true", =
dest=3D"refpolicy",
> >                            default=3DTrue, help=3D"generate refpolicy s=
tyle output")
> > +        parser.add_option("-C", "--cil", action=3D"store_true", dest=
=3D"cil", help=3D"generate CIL output")
> >
> >          parser.add_option("-N", "--noreference", action=3D"store_false=
", dest=3D"refpolicy",
> >                            default=3DFalse, help=3D"do not generate ref=
policy style output")
> > @@ -114,7 +115,7 @@ class AuditToPolicy:
> >                  sys.stderr.write('error: module names must begin with =
a letter, optionally followed by letters, numbers, "-", "_", "."\n')
> >                  sys.exit(2)
> >
> > -        # Make -M and -o conflict
> > +        # Make -M and -o or -C conflict
> >          if options.module_package:
> >              if options.output:
> >                  sys.stderr.write("error: --module-package conflicts wi=
th --output\n")
> > @@ -122,6 +123,9 @@ class AuditToPolicy:
> >              if options.module:
> >                  sys.stderr.write("error: --module-package conflicts wi=
th --module\n")
> >                  sys.exit(2)
> > +            if options.cil:
> > +                sys.stderr.write("error: --module-package conflicts wi=
th --cil\n")
> > +                sys.exit(2)
> >
> >          self.__options =3D options
> >
> > @@ -341,6 +345,10 @@ semodule -i {packagename}
> >          if self.__options.requires:
> >              g.set_gen_requires(True)
> >
> > +        # CIL output
> > +        if self.__options.cil:
> > +            g.set_gen_cil(True)
> > +
> >          # Generate the policy
> >          g.add_access(self.__avs)
> >          g.add_role_types(self.__role_types)
> > @@ -348,6 +356,10 @@ semodule -i {packagename}
> >          # Output
> >          writer =3D output.ModuleWriter()
> >
> > +        # CIL output
> > +        if self.__options.cil:
> > +            writer.set_gen_cil(True)
> > +
> >          # Module package
> >          if self.__options.module_package:
> >              self.__output_modulepackage(writer, g)
> > diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audi=
t2allow.1
> > index c208b3b2..2834234d 100644
> > --- a/python/audit2allow/audit2allow.1
> > +++ b/python/audit2allow/audit2allow.1
> > @@ -74,6 +74,9 @@ Generate module/require output <modulename>
> >  .B "\-M <modulename>"
> >  Generate loadable module package, conflicts with \-o
> >  .TP
> > +.B "\-C"
> > +Generate CIL output, conflicts with \-M
> > +.TP
> >  .B "\-p <policyfile>"  | "\-\-policy <policyfile>"
> >  Policy file to use for analysis
> >  .TP
> > diff --git a/python/sepolgen/src/sepolgen/output.py b/python/sepolgen/s=
rc/sepolgen/output.py
> > index aeeaafc8..57380cad 100644
> > --- a/python/sepolgen/src/sepolgen/output.py
> > +++ b/python/sepolgen/src/sepolgen/output.py
> > @@ -40,6 +40,7 @@ class ModuleWriter:
> >          self.module =3D None
> >          self.sort =3D True
> >          self.requires =3D True
> > +        self.gen_cil =3D False
> >
> >      def write(self, module, fd):
> >          self.module =3D module
> > @@ -49,8 +50,12 @@ class ModuleWriter:
> >
> >          # FIXME - make this handle nesting
> >          for node, depth in refpolicy.walktree(self.module, showdepth=
=3DTrue):
> > +            node.set_gen_cil(self.gen_cil)
> >              fd.write("%s\n" % str(node))
> >
> > +    def set_gen_cil(self, gen_cil):
> > +        self.gen_cil =3D gen_cil
> > +
> >  # Helper functions for sort_filter - this is all done old school
> >  # C style rather than with polymorphic methods because this sorting
> >  # is specific to output. It is not necessarily the comparison you
> > diff --git a/python/sepolgen/src/sepolgen/policygen.py b/python/sepolge=
n/src/sepolgen/policygen.py
> > index 183b41a9..5d59dad7 100644
> > --- a/python/sepolgen/src/sepolgen/policygen.py
> > +++ b/python/sepolgen/src/sepolgen/policygen.py
> > @@ -86,6 +86,8 @@ class PolicyGenerator:
> >          self.xperms =3D False
> >
> >          self.domains =3D None
> > +        self.gen_cil =3D False
> > +        self.comment_start =3D '#'
> >      def set_gen_refpol(self, if_set=3DNone, perm_maps=3DNone):
> >          """Set whether reference policy interfaces are generated.
> >
> > @@ -128,6 +130,13 @@ class PolicyGenerator:
> >          """
> >          self.xperms =3D xperms
> >
> > +    def set_gen_cil(self, gen_cil):
> > +        self.gen_cil =3D gen_cil
> > +        if gen_cil:
> > +            self.comment_start =3D ';'
> > +        else:
> > +            self.comment_start =3D '#'
> > +
> >      def __set_module_style(self):
> >          if self.ifgen:
> >              refpolicy =3D True
> > @@ -173,26 +182,27 @@ class PolicyGenerator:
> >              rule.comment =3D str(refpolicy.Comment(explain_access(av, =
verbosity=3Dself.explain)))
> >
> >          if av.type =3D=3D audit2why.ALLOW:
> > -            rule.comment +=3D "\n#!!!! This avc is allowed in the curr=
ent policy"
> > +            rule.comment +=3D "\n%s!!!! This avc is allowed in the cur=
rent policy" % self.comment_start
> >
> >              if av.xperms:
> > -                rule.comment +=3D "\n#!!!! This av rule may have been =
overridden by an extended permission av rule"
> > +                rule.comment +=3D "\n%s!!!! This av rule may have been=
 overridden by an extended permission av rule" % self.comment_start
> >
> >          if av.type =3D=3D audit2why.DONTAUDIT:
> > -            rule.comment +=3D "\n#!!!! This avc has a dontaudit rule i=
n the current policy"
> > +            rule.comment +=3D "\n%s!!!! This avc has a dontaudit rule =
in the current policy" % self.comment_start
> >
> >          if av.type =3D=3D audit2why.BOOLEAN:
> >              if len(av.data) > 1:
> > -                rule.comment +=3D "\n#!!!! This avc can be allowed usi=
ng one of the these booleans:\n#     %s" % ", ".join([x[0] for x in av.data=
])
> > +                rule.comment +=3D "\n%s!!!! This avc can be allowed us=
ing one of the these booleans:\n%s     %s" % (self.comment_start, self.comm=
ent_start, ", ".join([x[0] for x in av.data]))
> >              else:
> > -                rule.comment +=3D "\n#!!!! This avc can be allowed usi=
ng the boolean '%s'" % av.data[0][0]
> > +                rule.comment +=3D "\n%s!!!! This avc can be allowed us=
ing the boolean '%s'" % (self.comment_start, av.data[0][0])
> >
> >          if av.type =3D=3D audit2why.CONSTRAINT:
> > -            rule.comment +=3D "\n#!!!! This avc is a constraint violat=
ion.  You would need to modify the attributes of either the source or targe=
t types to allow this access."
> > -            rule.comment +=3D "\n#Constraint rule: "
> > -            rule.comment +=3D "\n#\t" + av.data[0]
> > +            rule.comment +=3D "\n%s!!!! This avc is a constraint viola=
tion.  You would need to modify the attributes of either the source or targ=
et types to allow this access." % self.comment_start
> > +            rule.comment +=3D "\n%sConstraint rule: " % self.comment_s=
tart
> > +            rule.comment +=3D "\n%s\t" % self.comment_start + av.data[=
0]
> >              for reason in av.data[1:]:
> > -                rule.comment +=3D "\n#\tPossible cause is the source %=
s and target %s are different." % reason
> > +                rule.comment +=3D "\n%s" % self.comment_start
> > +                rule.comment +=3D "\tPossible cause is the source %s a=
nd target %s are different." % reason
> >
> >          try:
> >              if ( av.type =3D=3D audit2why.TERULE and
> > @@ -206,9 +216,9 @@ class PolicyGenerator:
> >                      if i not in self.domains:
> >                          types.append(i)
> >                  if len(types) =3D=3D 1:
> > -                    rule.comment +=3D "\n#!!!! The source type '%s' ca=
n write to a '%s' of the following type:\n# %s\n" % ( av.src_type, av.obj_c=
lass, ", ".join(types))
> > +                    rule.comment +=3D "\n%s!!!! The source type '%s' c=
an write to a '%s' of the following type:\n%s %s\n" % (self.comment_start, =
av.src_type, av.obj_class, self.comment_start, ", ".join(types))
> >                  elif len(types) >=3D 1:
> > -                    rule.comment +=3D "\n#!!!! The source type '%s' ca=
n write to a '%s' of the following types:\n# %s\n" % ( av.src_type, av.obj_=
class, ", ".join(types))
> > +                    rule.comment +=3D "\n%s!!!! The source type '%s' c=
an write to a '%s' of the following types:\n%s %s\n" % (self.comment_start,=
 av.src_type, av.obj_class, self.comment_start, ", ".join(types))
> >          except:
> >              pass
> >
> > diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolge=
n/src/sepolgen/refpolicy.py
> > index 9cac1b95..ae5450d7 100644
> > --- a/python/sepolgen/src/sepolgen/refpolicy.py
> > +++ b/python/sepolgen/src/sepolgen/refpolicy.py
> > @@ -53,6 +53,7 @@ class PolicyBase:
> >      def __init__(self, parent=3DNone):
> >          self.parent =3D None
> >          self.comment =3D None
> > +        self.gen_cil =3D False
> >
> >  class Node(PolicyBase):
> >      """Base class objects produced from parsing the reference policy.
> > @@ -150,6 +151,8 @@ class Node(PolicyBase):
> >      def to_string(self):
> >          return ""
> >
> > +    def set_gen_cil(self, gen_cil):
> > +        self.gen_cil =3D gen_cil
> >
> >  class Leaf(PolicyBase):
> >      def __init__(self, parent=3DNone):
> > @@ -167,6 +170,8 @@ class Leaf(PolicyBase):
> >      def to_string(self):
> >          return ""
> >
> > +    def set_gen_cil(self, gen_cil):
> > +        self.gen_cil =3D gen_cil
> >
> >
> >  # Utility functions
> > @@ -413,6 +418,16 @@ class XpermSet():
> >
> >          return "%s{ %s }" % (compl, " ".join(vals))
> >
> > +    def to_string_cil(self):
> > +        if not self.ranges:
> > +            return ""
> > +
> > +        compl =3D ("not (", ")") if self.complement else ("", "")
> > +
> > +        vals =3D map(lambda x: hex(x[0]) if x[0] =3D=3D x[1] else "(ra=
nge %s %s)" % (hex(x[0]), hex(x[1]), ), self.ranges)
> > +
> > +        return "(%s%s%s)" % (compl[0], " ".join(vals), compl[1])
> > +
> >  # Basic statements
> >
> >  class TypeAttribute(Leaf):
> > @@ -426,7 +441,14 @@ class TypeAttribute(Leaf):
> >          self.attributes =3D IdSet()
> >
> >      def to_string(self):
> > -        return "typeattribute %s %s;" % (self.type, self.attributes.to=
_comma_str())
> > +        if self.gen_cil:
> > +            s =3D ""
> > +            for a in self.attributes:
> > +                s +=3D "(typeattribute %s)\n" % a
> > +                s +=3D "(typeattributeset %s %s)\n" % (a, self.type)
> > +            return s
> > +        else:
> > +            return "typeattribute %s %s;" % (self.type, self.attribute=
s.to_comma_str())
> >
> >  class RoleAttribute(Leaf):
> >      """SElinux roleattribute statement.
> > @@ -439,7 +461,14 @@ class RoleAttribute(Leaf):
> >          self.roleattributes =3D IdSet()
> >
> >      def to_string(self):
> > -        return "roleattribute %s %s;" % (self.role, self.roleattribute=
s.to_comma_str())
> > +        if self.gen_cil:
> > +            s =3D ""
> > +            for a in self.roleattributes:
> > +                s +=3D "(roleattribute %s)\n" % a
> > +                s +=3D "(roleattributeset %s %s)\n" % (a, self.type)
> > +            return s
> > +        else:
> > +            return "roleattribute %s %s;" % (self.role, self.roleattri=
butes.to_comma_str())
> >
> >
> >  class Role(Leaf):
> > @@ -449,10 +478,16 @@ class Role(Leaf):
> >          self.types =3D IdSet()
> >
> >      def to_string(self):
> > -        s =3D ""
> > -        for t in self.types:
> > -            s +=3D "role %s types %s;\n" % (self.role, t)
> > -        return s
> > +        if self.gen_cil:
> > +            s =3D "(role %s)\n" % self.role
> > +            for t in self.types:
> > +                s +=3D "(roletype %s %s)\n" % (self.role, t)
> > +            return s
> > +        else:
> > +            s =3D ""
> > +            for t in self.types:
> > +                s +=3D "role %s types %s;\n" % (self.role, t)
> > +            return s
> >
> >  class Type(Leaf):
> >      def __init__(self, name=3D"", parent=3DNone):
> > @@ -462,12 +497,20 @@ class Type(Leaf):
> >          self.aliases =3D IdSet()
> >
> >      def to_string(self):
> > -        s =3D "type %s" % self.name
> > -        if len(self.aliases) > 0:
> > -            s =3D s + "alias %s" % self.aliases.to_space_str()
> > -        if len(self.attributes) > 0:
> > -            s =3D s + ", %s" % self.attributes.to_comma_str()
> > -        return s + ";"
> > +        if self.gen_cil:
> > +            s =3D "(type %s)\n" % self.name
> > +            for a in self.aliases:
> > +                s +=3D "(typealiasactual %s %s)\n" % (a, self.name)
> > +            for a in self.attributes:
> > +                s +=3D "(typeattributeset %s %s)\n" % (a, self.name)
> > +            return s
> > +        else:
> > +            s =3D "type %s" % self.name
> > +            if len(self.aliases) > 0:
> > +                s =3D s + "alias %s" % self.aliases.to_space_str()
> > +            if len(self.attributes) > 0:
> > +                s =3D s + ", %s" % self.attributes.to_comma_str()
> > +            return s + ";"
> >
> >  class TypeAlias(Leaf):
> >      def __init__(self, parent=3DNone):
> > @@ -476,7 +519,14 @@ class TypeAlias(Leaf):
> >          self.aliases =3D IdSet()
> >
> >      def to_string(self):
> > -        return "typealias %s alias %s;" % (self.type, self.aliases.to_=
space_str())
> > +        if self.gen_cil:
> > +            s =3D ""
> > +            for a in self.aliases:
> > +                s +=3D "(typealias %s)\n" % a
> > +                s +=3D "(typealiasactual %s %s)\n" % (a, self.type)
> > +            return s
> > +        else:
> > +            return "typealias %s alias %s;" % (self.type, self.aliases=
.to_space_str())
> >
> >  class Attribute(Leaf):
> >      def __init__(self, name=3D"", parent=3DNone):
> > @@ -484,7 +534,10 @@ class Attribute(Leaf):
> >          self.name =3D name
> >
> >      def to_string(self):
> > -        return "attribute %s;" % self.name
> > +        if self.gen_cil:
> > +            return "attribute %s;" % self.name
> > +        else:
> > +            return "(typeattribute %s)" % self.name
> >
> >  class Attribute_Role(Leaf):
> >      def __init__(self, name=3D"", parent=3DNone):
> > @@ -492,7 +545,10 @@ class Attribute_Role(Leaf):
> >          self.name =3D name
> >
> >      def to_string(self):
> > -        return "attribute_role %s;" % self.name
> > +        if self.gen_cil:
> > +            return "(roleattribute %s)" % self.name
> > +        else:
> > +            return "attribute_role %s;" % self.name
> >
> >
> >  # Classes representing rules
> > @@ -555,11 +611,21 @@ class AVRule(Leaf):
> >          that is a valid policy language representation (assuming
> >          that the types, object class, etc. are valie).
> >          """
> > -        return "%s %s %s:%s %s;" % (self.__rule_type_str(),
> > -                                     self.src_types.to_space_str(),
> > -                                     self.tgt_types.to_space_str(),
> > -                                     self.obj_classes.to_space_str(),
> > -                                     self.perms.to_space_str())
> > +        if self.gen_cil:
> > +            s =3D ""
> > +            for src in self.src_types:
> > +                for tgt in self.tgt_types:
> > +                    for obj in self.obj_classes:
> > +                        s +=3D "(%s %s %s (%s (%s)))" % (self.__rule_t=
ype_str(),
> > +                                                       src, tgt, obj,
> > +                                                       " ".join(self.p=
erms))
> > +            return s
> > +        else:
> > +            return "%s %s %s:%s %s;" % (self.__rule_type_str(),
> > +                                        self.src_types.to_space_str(),
> > +                                        self.tgt_types.to_space_str(),
> > +                                        self.obj_classes.to_space_str(=
),
> > +                                        self.perms.to_space_str())
> >
> >  class AVExtRule(Leaf):
> >      """Extended permission access vector rule.
> > @@ -597,6 +663,16 @@ class AVExtRule(Leaf):
> >          elif self.rule_type =3D=3D self.NEVERALLOWXPERM:
> >              return "neverallowxperm"
> >
> > +    def __rule_type_str_cil(self):
> > +        if self.rule_type =3D=3D self.ALLOWXPERM:
> > +            return "allowx"
> > +        elif self.rule_type =3D=3D self.DONTAUDITXPERM:
> > +            return "dontauditx"
> > +        elif self.rule_type =3D=3D self.AUDITALLOWXPERM:
> > +            return "auditallowx"
> > +        elif self.rule_type =3D=3D self.NEVERALLOWXPERM:
> > +            return "neverallowx"
> > +
> >      def from_av(self, av, op):
> >          self.src_types.add(av.src_type)
> >          if av.src_type =3D=3D av.tgt_type:
> > @@ -612,12 +688,25 @@ class AVExtRule(Leaf):
> >          a valid policy language representation (assuming that
> >          the types, object class, etc. are valid).
> >          """
> > -        return "%s %s %s:%s %s %s;" % (self.__rule_type_str(),
> > -                                     self.src_types.to_space_str(),
> > -                                     self.tgt_types.to_space_str(),
> > -                                     self.obj_classes.to_space_str(),
> > -                                     self.operation,
> > -                                     self.xperms.to_string())
> > +        if self.gen_cil:
> > +            s =3D ""
> > +            for src in self.src_types:
> > +                for tgt in self.tgt_types:
> > +                    for obj in self.obj_classes:
> > +                        s +=3D "(%s %s %s (%s %s %s))" % (self.__rule_=
type_str_cil(),
> > +                                                        src, tgt,
> > +                                                        self.operation=
,
> > +                                                        obj,
> > +                                                        self.xperms.to=
_string_cil())
> > +            return s
> > +        else:
> > +            return "%s %s %s:%s %s %s;" % (self.__rule_type_str(),
> > +                                           self.src_types.to_space_str=
(),
> > +                                           self.tgt_types.to_space_str=
(),
> > +                                           self.obj_classes.to_space_s=
tr(),
> > +                                           self.operation,
> > +                                           self.xperms.to_string())
> > +
> >
> >  class TypeRule(Leaf):
> >      """SELinux type rules.
> > @@ -630,6 +719,7 @@ class TypeRule(Leaf):
> >      TYPE_CHANGE =3D 1
> >      TYPE_MEMBER =3D 2
> >
> > +    # NB. Filename type transitions are not generated by audit2allow.
> >      def __init__(self, parent=3DNone):
> >          Leaf.__init__(self, parent)
> >          self.src_types =3D IdSet()
> > @@ -646,12 +736,28 @@ class TypeRule(Leaf):
> >          else:
> >              return "type_member"
> >
> > +    def __rule_type_str_cil(self):
> > +        if self.rule_type =3D=3D self.TYPE_TRANSITION:
> > +            return "typetransition"
> > +        elif self.rule_type =3D=3D self.TYPE_CHANGE:
> > +            return "typechange"
> > +        else:
> > +            return "typemember"
> > +
> >      def to_string(self):
> > -        return "%s %s %s:%s %s;" % (self.__rule_type_str(),
> > -                                     self.src_types.to_space_str(),
> > -                                     self.tgt_types.to_space_str(),
> > -                                     self.obj_classes.to_space_str(),
> > -                                     self.dest_type)
> > +        if self.gen_cil:
> > +            return "(%s %s %s %s %s)" % (self.__rule_type_str_cil(),
> > +                                         self.src_types.to_space_str()=
,
> > +                                         self.tgt_types.to_space_str()=
,
> > +                                         self.obj_classes.to_space_str=
(),
> > +                                         self.dest_type)
> > +        else:
> > +            return "%s %s %s:%s %s;" % (self.__rule_type_str(),
> > +                                        self.src_types.to_space_str(),
> > +                                        self.tgt_types.to_space_str(),
> > +                                        self.obj_classes.to_space_str(=
),
> > +                                        self.dest_type)
> > +
> >  class TypeBound(Leaf):
> >      """SElinux typebound statement.
> >
> > @@ -663,8 +769,13 @@ class TypeBound(Leaf):
> >          self.tgt_types =3D IdSet()
> >
> >      def to_string(self):
> > -        return "typebounds %s %s;" % (self.type, self.tgt_types.to_com=
ma_str())
> > -
> > +        if self.gen_cil:
> > +            s =3D ""
> > +            for t in self.tgt_types:
> > +                s +=3D "(typebounds %s %s)" % (self.type, t)
> > +            return s
> > +        else:
> > +            return "typebounds %s %s;" % (self.type, self.tgt_types.to=
_comma_str())
> >
> >  class RoleAllow(Leaf):
> >      def __init__(self, parent=3DNone):
> > @@ -673,8 +784,15 @@ class RoleAllow(Leaf):
> >          self.tgt_roles =3D IdSet()
> >
> >      def to_string(self):
> > -        return "allow %s %s;" % (self.src_roles.to_comma_str(),
> > -                                 self.tgt_roles.to_comma_str())
> > +        if self.gen_cil:
> > +            s =3D ""
> > +            for src in self.src_roles:
> > +                for tgt in self.tgt_roles:
> > +                    s +=3D "(roleallow %s %s)" % (src, tgt)
> > +            return s
> > +        else:
> > +            return "allow %s %s;" % (self.src_roles.to_comma_str(),
> > +                                     self.tgt_roles.to_comma_str())
> >
> >  class RoleType(Leaf):
> >      def __init__(self, parent=3DNone):
> > @@ -685,7 +803,10 @@ class RoleType(Leaf):
> >      def to_string(self):
> >          s =3D ""
> >          for t in self.types:
> > -            s +=3D "role %s types %s;\n" % (self.role, t)
> > +            if self.gen_cil:
> > +                s +=3D "(roletype %s %s)\n" % (self.role, t)
> > +            else:
> > +                s +=3D "role %s types %s;\n" % (self.role, t)
> >          return s
> >
> >  class ModuleDeclaration(Leaf):
> > @@ -696,10 +817,13 @@ class ModuleDeclaration(Leaf):
> >          self.refpolicy =3D False
> >
> >      def to_string(self):
> > -        if self.refpolicy:
> > -            return "policy_module(%s, %s)" % (self.name, self.version)
> > +        if self.gen_cil:
> > +            return ""
> >          else:
> > -            return "module %s %s;" % (self.name, self.version)
> > +            if self.refpolicy:
> > +                return "policy_module(%s, %s)" % (self.name, self.vers=
ion)
> > +            else:
> > +                return "module %s %s;" % (self.name, self.version)
> >
> >  class Conditional(Node):
> >      def __init__(self, parent=3DNone):
> > @@ -729,7 +853,10 @@ class InitialSid(Leaf):
> >          self.context =3D None
> >
> >      def to_string(self):
> > -        return "sid %s %s" % (self.name, str(self.context))
> > +        if self.gen_cil:
> > +            return "(sid %s %s)" % (self.name, str(self.context))
> > +        else:
> > +            return "sid %s %s" % (self.name, str(self.context))
> >
> >  class GenfsCon(Leaf):
> >      def __init__(self, parent=3DNone):
> > @@ -739,7 +866,10 @@ class GenfsCon(Leaf):
> >          self.context =3D None
> >
> >      def to_string(self):
> > -        return "genfscon %s %s %s" % (self.filesystem, self.path, str(=
self.context))
> > +        if self.gen_cil:
> > +            return "(genfscon %s %s %s)" % (self.filesystem, self.path=
, str(self.context))
> > +        else:
> > +            return "genfscon %s %s %s" % (self.filesystem, self.path, =
str(self.context))
> >
> >  class FilesystemUse(Leaf):
> >      XATTR =3D 1
> > @@ -754,14 +884,24 @@ class FilesystemUse(Leaf):
> >
> >      def to_string(self):
> >          s =3D ""
> > -        if self.type =3D=3D self.XATTR:
> > -            s =3D "fs_use_xattr "
> > -        elif self.type =3D=3D self.TRANS:
> > -            s =3D "fs_use_trans "
> > -        elif self.type =3D=3D self.TASK:
> > -            s =3D "fs_use_task "
> > +        if self.gen_cil:
> > +            if self.type =3D=3D self.XATTR:
> > +                s =3D "fsuse xattr "
> > +            elif self.type =3D=3D self.TRANS:
> > +                s =3D "fsuse trans "
> > +            elif self.type =3D=3D self.TASK:
> > +                s =3D "fsuse task "
> > +
> > +            return "(%s %s %s)" % (s, self.filesystem, str(self.contex=
t))
> > +        else:
> > +            if self.type =3D=3D self.XATTR:
> > +                s =3D "fs_use_xattr "
> > +            elif self.type =3D=3D self.TRANS:
> > +                s =3D "fs_use_trans "
> > +            elif self.type =3D=3D self.TASK:
> > +                s =3D "fs_use_task "
> >
> > -        return "%s %s %s;" % (s, self.filesystem, str(self.context))
> > +            return "%s %s %s;" % (s, self.filesystem, str(self.context=
))
> >
> >  class PortCon(Leaf):
> >      def __init__(self, parent=3DNone):
> > @@ -771,7 +911,10 @@ class PortCon(Leaf):
> >          self.context =3D None
> >
> >      def to_string(self):
> > -        return "portcon %s %s %s" % (self.port_type, self.port_number,=
 str(self.context))
> > +        if self.gen_cil:
> > +            return "(portcon %s %s %s)" % (self.port_type, self.port_n=
umber, str(self.context))
> > +        else:
> > +            return "portcon %s %s %s" % (self.port_type, self.port_num=
ber, str(self.context))
> >
> >  class NodeCon(Leaf):
> >      def __init__(self, parent=3DNone):
> > @@ -781,7 +924,10 @@ class NodeCon(Leaf):
> >          self.context =3D None
> >
> >      def to_string(self):
> > -        return "nodecon %s %s %s" % (self.start, self.end, str(self.co=
ntext))
> > +        if self.gen_cil:
> > +            return "(nodecon %s %s %s)" % (self.start, self.end, str(s=
elf.context))
> > +        else:
> > +            return "nodecon %s %s %s" % (self.start, self.end, str(sel=
f.context))
> >
> >  class NetifCon(Leaf):
> >      def __init__(self, parent=3DNone):
> > @@ -791,8 +937,13 @@ class NetifCon(Leaf):
> >          self.packet_context =3D None
> >
> >      def to_string(self):
> > -        return "netifcon %s %s %s" % (self.interface, str(self.interfa=
ce_context),
> > -                                   str(self.packet_context))
> > +        if self.gen_cil:
> > +            return "(netifcon %s %s %s)" % (self.interface, str(self.i=
nterface_context),
> > +                                            str(self.packet_context))
> > +        else:
> > +            return "netifcon %s %s %s" % (self.interface, str(self.int=
erface_context),
> > +                                          str(self.packet_context))
> > +
> >  class PirqCon(Leaf):
> >      def __init__(self, parent=3DNone):
> >          Leaf.__init__(self, parent)
> > @@ -800,7 +951,10 @@ class PirqCon(Leaf):
> >          self.context =3D None
> >
> >      def to_string(self):
> > -        return "pirqcon %s %s" % (self.pirq_number, str(self.context))
> > +        if self.gen_cil:
> > +            return "(pirqcon %s %s)" % (self.pirq_number, str(self.con=
text))
> > +        else:
> > +            return "pirqcon %s %s" % (self.pirq_number, str(self.conte=
xt))
> >
> >  class IomemCon(Leaf):
> >      def __init__(self, parent=3DNone):
> > @@ -809,7 +963,10 @@ class IomemCon(Leaf):
> >          self.context =3D None
> >
> >      def to_string(self):
> > -        return "iomemcon %s %s" % (self.device_mem, str(self.context))
> > +        if self.gen_cil:
> > +            return "(iomemcon %s %s)" % (self.device_mem, str(self.con=
text))
> > +        else:
> > +            return "iomemcon %s %s" % (self.device_mem, str(self.conte=
xt))
> >
> >  class IoportCon(Leaf):
> >      def __init__(self, parent=3DNone):
> > @@ -818,7 +975,10 @@ class IoportCon(Leaf):
> >          self.context =3D None
> >
> >      def to_string(self):
> > -        return "ioportcon %s %s" % (self.ioport, str(self.context))
> > +        if self.gen_cil:
> > +            return "(ioportcon %s %s)" % (self.ioport, str(self.contex=
t))
> > +        else:
> > +            return "ioportcon %s %s" % (self.ioport, str(self.context)=
)
> >
> >  class PciDeviceCon(Leaf):
> >      def __init__(self, parent=3DNone):
> > @@ -827,7 +987,10 @@ class PciDeviceCon(Leaf):
> >          self.context =3D None
> >
> >      def to_string(self):
> > -        return "pcidevicecon %s %s" % (self.device, str(self.context))
> > +        if self.gen_cil:
> > +            return "(pcidevicecon %s %s)" % (self.device, str(self.con=
text))
> > +        else:
> > +            return "pcidevicecon %s %s" % (self.device, str(self.conte=
xt))
> >
> >  class DeviceTreeCon(Leaf):
> >      def __init__(self, parent=3DNone):
> > @@ -836,7 +999,10 @@ class DeviceTreeCon(Leaf):
> >          self.context =3D None
> >
> >      def to_string(self):
> > -        return "devicetreecon %s %s" % (self.path, str(self.context))
> > +        if self.gen_cil:
> > +            return "(devicetreecon %s %s)" % (self.path, str(self.cont=
ext))
> > +        else:
> > +            return "devicetreecon %s %s" % (self.path, str(self.contex=
t))
> >
> >  # Reference policy specific types
> >
> > @@ -993,25 +1159,33 @@ class Require(Leaf):
> >
> >      def to_string(self):
> >          s =3D []
> > -        s.append("require {")
> > -        for type in self.types:
> > -            s.append("\ttype %s;" % type)
> > -        for obj_class, perms in self.obj_classes.items():
> > -            s.append("\tclass %s %s;" % (obj_class, perms.to_space_str=
()))
> > -        for role in self.roles:
> > -            s.append("\trole %s;" % role)
> > -        for bool in self.data:
> > -            s.append("\tbool %s;" % bool)
> > -        for user in self.users:
> > -            s.append("\tuser %s;" % user)
> > -        s.append("}")
> > -
> > -        # Handle empty requires
> > -        if len(s) =3D=3D 2:
> > -            return ""
> > -
> > -        return "\n".join(s)
> > -
> > +        if self.gen_cil:
> > +            # Can't require classes, perms, booleans, users
> > +            for type in self.types:
> > +                s.append("(typeattributeset cil_gen_require %s)" % typ=
e)
> > +            for role in self.roles:
> > +                s.append("(roleattributeset cil_gen_require %s)" % rol=
e)
> > +
> > +            return "\n".join(s)
> > +        else:
> > +            s.append("require {")
> > +            for type in self.types:
> > +                s.append("\ttype %s;" % type)
> > +            for obj_class, perms in self.obj_classes.items():
> > +                s.append("\tclass %s %s;" % (obj_class, perms.to_space=
_str()))
> > +            for role in self.roles:
> > +                s.append("\trole %s;" % role)
> > +            for bool in self.data:
> > +                s.append("\tbool %s;" % bool)
> > +            for user in self.users:
> > +                s.append("\tuser %s;" % user)
> > +            s.append("}")
> > +
> > +            # Handle empty requires
> > +            if len(s) =3D=3D 2:
> > +                return ""
> > +
> > +            return "\n".join(s)
> >
> >  class ObjPermSet:
> >      def __init__(self, name):
> > @@ -1044,7 +1218,10 @@ class Comment:
> >          else:
> >              out =3D []
> >              for line in self.lines:
> > -                out.append("#" + line)
> > +                if self.gen_cil:
> > +                    out.append(";" + line)
> > +                else:
> > +                    out.append("#" + line)
> >              return "\n".join(out)
> >
> >      def merge(self, other):
> > @@ -1056,4 +1233,5 @@ class Comment:
> >      def __str__(self):
> >          return self.to_string()
> >
> > -
> > +    def set_gen_cil(self, gen_cil):
> > +        self.gen_cil =3D gen_cil
> >
> > base-commit: 82195e77e317d322dd9b5fc31d402462d6845357
> > --
> > 2.43.0
> >
> >
