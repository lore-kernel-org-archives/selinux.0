Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E33152E14
	for <selinux@vger.kernel.org>; Wed, 28 Feb 2024 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130350; cv=none; b=cD6b2zAm5LlPzeYa5/LTRU8y5pobbW0WAUmC0bOuo91BoaLRKwFrz1bLXaKVWkH+45pFTY2WI5NoUeVptr3eLTPZ6KIrR/TBkt+7hnQ3vB5LMrZ03lC3p/Zgio6iCNwhQDtAd9v4Q/Bm/UmYfWzLMu/H9Vubci/Lq57fGgTb/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130350; c=relaxed/simple;
	bh=7dECY6kLws3FmjdvNPYb5dg0F7XEEBC1d7v/jI84aOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmtEZuU46jWhjPwnnyHzrwNjcCavqeaBXIyAMqyY6zY2S2RP/e6wOjVtMNNi8mXm7erbFGxKZn6nUOZcnRoFVfaHA/3IH5r0Fo+3wyroQSm1zgjBAE4g5+DdUN9y9zsPBarKrjHd+OT/cPdfV3oDPwo7DxbRnAvvORjX5NTuWhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BshGjESd; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BshGjESd"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d698a8d93cso3234376241.3
        for <selinux@vger.kernel.org>; Wed, 28 Feb 2024 06:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709130347; x=1709735147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URwS6/FOIcbNnnIgKxSCHxbwgH3gEPgZgwohD0S8Hds=;
        b=BshGjESdcv3/0CIPx49TXyKwQ2q1TMbu+QLieQT+EbZtW3cvOAUTLMZq5fXQNohTxI
         EVgTAtj0mVd/y++uM1j8KcKSxosxduTXykb0JS3XHeQWh7lo2Q6QsDT+b9J/WZo52xQc
         dPs23x20CYFowWN9R4XLIg4ye6fk6jvEvHbteMbj94WRt8pFdIOrQgIRFIZXnq/HMFTj
         CiBVoslTCdMHnbdf7cKz80MjZOi8+mifoEMoWHKUgCA0tmsF9v3pZMntEJeB7BSttUce
         kWNB/P7yvKa5p5HoN8TrIjLsLmL/EtLWzxpKHQ51jqzv9/S35/ozn/YSlWqvIOUoo560
         DbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709130347; x=1709735147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URwS6/FOIcbNnnIgKxSCHxbwgH3gEPgZgwohD0S8Hds=;
        b=LDqIA6a8xjIjM6Tj+a/PjJqVUFwN8wC/8Szcj1k6oVywBIbrjSbvBiQHXgcLgr/P+O
         zFlBrHFKtMZt6+cwRmJJTfYOtREUA5we7gCE6GXVpBx9lYLkS6jtEkikYS2/RnR/MgY6
         n408B4lN6S04dyGtwmFrXgxCQw6KaHNjDHXJkHMp/XlaxC3V8hXJDfUid5LBRm7CMW1Q
         CI481dgSO66IeXNUK468aazJOWwzMTqbtkjSD5CYLQ2ISC7OCxafjESExAxycrbluy6v
         p45D+tKU9dvcBnRjOcEF7g05xBg7X4oufKmlRodmTarDnaqvMlyvtVscICZq8RAcrMq1
         ANXg==
X-Gm-Message-State: AOJu0YzGgoy+FOOfwod1AT6EeKMHr8+/juUKxiDU44xf120lKK7p2Qok
	PngrLYOPOrOBjiilXS2Qtxh95hmRiaWWXKJ2F8WmnxrEdd55Amj77O0EDdPzDbpg3+bNKCzKtN/
	YhpGIDAm1Sq/kWobLKH/a+N7XnCn2Yi5i
X-Google-Smtp-Source: AGHT+IFoefXIOpVk5y8IuxhRgxdfemtMjcp1G+ZPEY21xJCvYhXxA0MtcjL29s0TmBI/BGJ2Sy/GvUyfSfnzspkkQGQ=
X-Received: by 2002:a67:ee07:0:b0:470:5515:d8f4 with SMTP id
 f7-20020a67ee07000000b004705515d8f4mr10403389vsp.31.1709130346583; Wed, 28
 Feb 2024 06:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218205130.92063-2-toiwoton@gmail.com>
In-Reply-To: <20240218205130.92063-2-toiwoton@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 28 Feb 2024 09:25:35 -0500
Message-ID: <CAP+JOzScoNXm9ByFnN+QX-K7CN7yweBUtmXnCSTk9DQvn5zAww@mail.gmail.com>
Subject: Re: [PATCH PR#420] audit2allow: CIL output mode
To: Topi Miettinen <toiwoton@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 3:52=E2=80=AFPM Topi Miettinen <toiwoton@gmail.com>=
 wrote:
>
> New flag -C for audit2allow sets output format to CIL instead of
> Policy Language.
>
> Example:
> ;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D mozilla_t =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
> ;!!!! This avc is allowed in the current policy
> (allow mozilla_t user_sudo_t (fd (use)))
>
> ;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D user_t =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> ;!!!! This avc can be allowed using the boolean 'allow_execmem'
> (allow user_t self (process (execmem)))
> (allow user_t chromium_t (process (noatsecure rlimitinh siginh)))
>
> ;!!!! This avc is a constraint violation.  You would need to modify the a=
ttributes of either the source or target types to allow this access.
> ;Constraint rule:
> ;       constrain dir { ioctl read write create getattr setattr lock rela=
belfrom relabelto append map unlink link rename execute quotaon mounton aud=
it_access open execmod watch watch_mount watch_sb watch_with_perm watch_rea=
ds add_name remove_name reparent search rmdir } ((u1 =3D=3D u2 -Fail-)  or =
(u1 =3D=3D system_u -Fail-)  or (u1 =3D=3D unconfined_u -Fail-)  or (u1 =3D=
=3D sysadm_u -Fail-)  or (u2 =3D=3D system_u -Fail-)  or (t1 !=3D ubac_cons=
trained_type -Fail-)  or (t2 !=3D ubac_constrained_type -Fail-)  or (t1 =3D=
=3D ubacfile -Fail-) ); Constraint DENIED
>
> ;       Possible cause is the source user (user_u) and target user (sysad=
m_u) are different.
> (allow user_t user_home_dir_t (dir (getattr relabelto)))
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  python/audit2allow/audit2allow            |  14 +-
>  python/audit2allow/audit2allow.1          |   3 +
>  python/sepolgen/src/sepolgen/output.py    |   5 +
>  python/sepolgen/src/sepolgen/policygen.py |  29 ++-
>  python/sepolgen/src/sepolgen/refpolicy.py | 300 ++++++++++++++++------
>  5 files changed, 265 insertions(+), 86 deletions(-)
>
> diff --git a/python/audit2allow/audit2allow b/python/audit2allow/audit2al=
low
> index 35b0b151..b5927ec1 100644
> --- a/python/audit2allow/audit2allow
> +++ b/python/audit2allow/audit2allow
> @@ -75,6 +75,7 @@ class AuditToPolicy:
>                            help=3D"generate policy with dontaudit rules")
>          parser.add_option("-R", "--reference", action=3D"store_true", de=
st=3D"refpolicy",
>                            default=3DTrue, help=3D"generate refpolicy sty=
le output")
> +        parser.add_option("-C", "--cil", action=3D"store_true", dest=3D"=
cil", help=3D"generate CIL output")
>
>          parser.add_option("-N", "--noreference", action=3D"store_false",=
 dest=3D"refpolicy",
>                            default=3DFalse, help=3D"do not generate refpo=
licy style output")
> @@ -114,7 +115,7 @@ class AuditToPolicy:
>                  sys.stderr.write('error: module names must begin with a =
letter, optionally followed by letters, numbers, "-", "_", "."\n')
>                  sys.exit(2)
>
> -        # Make -M and -o conflict
> +        # Make -M and -o or -C conflict
>          if options.module_package:
>              if options.output:
>                  sys.stderr.write("error: --module-package conflicts with=
 --output\n")
> @@ -122,6 +123,9 @@ class AuditToPolicy:
>              if options.module:
>                  sys.stderr.write("error: --module-package conflicts with=
 --module\n")
>                  sys.exit(2)
> +            if options.cil:
> +                sys.stderr.write("error: --module-package conflicts with=
 --cil\n")
> +                sys.exit(2)
>
>          self.__options =3D options
>
> @@ -341,6 +345,10 @@ semodule -i {packagename}
>          if self.__options.requires:
>              g.set_gen_requires(True)
>
> +        # CIL output
> +        if self.__options.cil:
> +            g.set_gen_cil(True)
> +
>          # Generate the policy
>          g.add_access(self.__avs)
>          g.add_role_types(self.__role_types)
> @@ -348,6 +356,10 @@ semodule -i {packagename}
>          # Output
>          writer =3D output.ModuleWriter()
>
> +        # CIL output
> +        if self.__options.cil:
> +            writer.set_gen_cil(True)
> +
>          # Module package
>          if self.__options.module_package:
>              self.__output_modulepackage(writer, g)
> diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2=
allow.1
> index c208b3b2..2834234d 100644
> --- a/python/audit2allow/audit2allow.1
> +++ b/python/audit2allow/audit2allow.1
> @@ -74,6 +74,9 @@ Generate module/require output <modulename>
>  .B "\-M <modulename>"
>  Generate loadable module package, conflicts with \-o
>  .TP
> +.B "\-C"
> +Generate CIL output, conflicts with \-M
> +.TP
>  .B "\-p <policyfile>"  | "\-\-policy <policyfile>"
>  Policy file to use for analysis
>  .TP
> diff --git a/python/sepolgen/src/sepolgen/output.py b/python/sepolgen/src=
/sepolgen/output.py
> index aeeaafc8..57380cad 100644
> --- a/python/sepolgen/src/sepolgen/output.py
> +++ b/python/sepolgen/src/sepolgen/output.py
> @@ -40,6 +40,7 @@ class ModuleWriter:
>          self.module =3D None
>          self.sort =3D True
>          self.requires =3D True
> +        self.gen_cil =3D False
>
>      def write(self, module, fd):
>          self.module =3D module
> @@ -49,8 +50,12 @@ class ModuleWriter:
>
>          # FIXME - make this handle nesting
>          for node, depth in refpolicy.walktree(self.module, showdepth=3DT=
rue):
> +            node.set_gen_cil(self.gen_cil)
>              fd.write("%s\n" % str(node))
>
> +    def set_gen_cil(self, gen_cil):
> +        self.gen_cil =3D gen_cil
> +
>  # Helper functions for sort_filter - this is all done old school
>  # C style rather than with polymorphic methods because this sorting
>  # is specific to output. It is not necessarily the comparison you
> diff --git a/python/sepolgen/src/sepolgen/policygen.py b/python/sepolgen/=
src/sepolgen/policygen.py
> index 183b41a9..93d02cf0 100644
> --- a/python/sepolgen/src/sepolgen/policygen.py
> +++ b/python/sepolgen/src/sepolgen/policygen.py
> @@ -86,6 +86,8 @@ class PolicyGenerator:
>          self.xperms =3D False
>
>          self.domains =3D None
> +        self.gen_cil =3D False
> +        self.comment_start =3D '#'
>      def set_gen_refpol(self, if_set=3DNone, perm_maps=3DNone):
>          """Set whether reference policy interfaces are generated.
>
> @@ -128,6 +130,10 @@ class PolicyGenerator:
>          """
>          self.xperms =3D xperms
>
> +    def set_gen_cil(self, gen_cil):
> +        self.gen_cil =3D gen_cil
> +        self.comment_start =3D ';'
> +
>      def __set_module_style(self):
>          if self.ifgen:
>              refpolicy =3D True
> @@ -173,26 +179,27 @@ class PolicyGenerator:
>              rule.comment =3D str(refpolicy.Comment(explain_access(av, ve=
rbosity=3Dself.explain)))
>
>          if av.type =3D=3D audit2why.ALLOW:
> -            rule.comment +=3D "\n#!!!! This avc is allowed in the curren=
t policy"
> +            rule.comment +=3D "\n%s!!!! This avc is allowed in the curre=
nt policy" % self.comment_start
>
>              if av.xperms:
> -                rule.comment +=3D "\n#!!!! This av rule may have been ov=
erridden by an extended permission av rule"
> +                rule.comment +=3D "\n%s!!!! This av rule may have been o=
verridden by an extended permission av rule" % self.comment_start
>
>          if av.type =3D=3D audit2why.DONTAUDIT:
> -            rule.comment +=3D "\n#!!!! This avc has a dontaudit rule in =
the current policy"
> +            rule.comment +=3D "\n%s!!!! This avc has a dontaudit rule in=
 the current policy" % self.comment_start
>
>          if av.type =3D=3D audit2why.BOOLEAN:
>              if len(av.data) > 1:
> -                rule.comment +=3D "\n#!!!! This avc can be allowed using=
 one of the these booleans:\n#     %s" % ", ".join([x[0] for x in av.data])
> +                rule.comment +=3D "\n%s!!!! This avc can be allowed usin=
g one of the these booleans:\n%s     %s" % (self.comment_start, self.commen=
t_start, ", ".join([x[0] for x in av.data]))
>              else:
> -                rule.comment +=3D "\n#!!!! This avc can be allowed using=
 the boolean '%s'" % av.data[0][0]
> +                rule.comment +=3D "\n%s!!!! This avc can be allowed usin=
g the boolean '%s'" % (self.comment_start, av.data[0][0])
>
>          if av.type =3D=3D audit2why.CONSTRAINT:
> -            rule.comment +=3D "\n#!!!! This avc is a constraint violatio=
n.  You would need to modify the attributes of either the source or target =
types to allow this access."
> -            rule.comment +=3D "\n#Constraint rule: "
> -            rule.comment +=3D "\n#\t" + av.data[0]
> +            rule.comment +=3D "\n%s!!!! This avc is a constraint violati=
on.  You would need to modify the attributes of either the source or target=
 types to allow this access." % self.comment_start
> +            rule.comment +=3D "\n%sConstraint rule: " % self.comment_sta=
rt
> +            rule.comment +=3D "\n%s\t" % self.comment_start + av.data[0]
>              for reason in av.data[1:]:
> -                rule.comment +=3D "\n#\tPossible cause is the source %s =
and target %s are different." % reason
> +                rule.comment +=3D "\n%s" % self.comment_start
> +                rule.comment +=3D "\tPossible cause is the source %s and=
 target %s are different." % reason
>
>          try:
>              if ( av.type =3D=3D audit2why.TERULE and
> @@ -206,9 +213,9 @@ class PolicyGenerator:
>                      if i not in self.domains:
>                          types.append(i)
>                  if len(types) =3D=3D 1:
> -                    rule.comment +=3D "\n#!!!! The source type '%s' can =
write to a '%s' of the following type:\n# %s\n" % ( av.src_type, av.obj_cla=
ss, ", ".join(types))
> +                    rule.comment +=3D "\n%s!!!! The source type '%s' can=
 write to a '%s' of the following type:\n# %s\n" % (self.comment_start, av.=
src_type, av.obj_class, ", ".join(types))
>                  elif len(types) >=3D 1:
> -                    rule.comment +=3D "\n#!!!! The source type '%s' can =
write to a '%s' of the following types:\n# %s\n" % ( av.src_type, av.obj_cl=
ass, ", ".join(types))
> +                    rule.comment +=3D "\n%s!!!! The source type '%s' can=
 write to a '%s' of the following types:\n# %s\n" % (self.comment_start, av=
.src_type, av.obj_class, ", ".join(types))
>          except:
>              pass
>
> diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/=
src/sepolgen/refpolicy.py
> index 9cac1b95..19aecb66 100644
> --- a/python/sepolgen/src/sepolgen/refpolicy.py
> +++ b/python/sepolgen/src/sepolgen/refpolicy.py
> @@ -53,6 +53,7 @@ class PolicyBase:
>      def __init__(self, parent=3DNone):
>          self.parent =3D None
>          self.comment =3D None
> +        self.gen_cil =3D False
>
>  class Node(PolicyBase):
>      """Base class objects produced from parsing the reference policy.
> @@ -150,6 +151,8 @@ class Node(PolicyBase):
>      def to_string(self):
>          return ""
>
> +    def set_gen_cil(self, gen_cil):
> +        self.gen_cil =3D gen_cil
>
>  class Leaf(PolicyBase):
>      def __init__(self, parent=3DNone):
> @@ -167,6 +170,8 @@ class Leaf(PolicyBase):
>      def to_string(self):
>          return ""
>
> +    def set_gen_cil(self, gen_cil):
> +        self.gen_cil =3D gen_cil
>
>
>  # Utility functions
> @@ -426,7 +431,13 @@ class TypeAttribute(Leaf):
>          self.attributes =3D IdSet()
>
>      def to_string(self):
> -        return "typeattribute %s %s;" % (self.type, self.attributes.to_c=
omma_str())
> +        if self.gen_cil:
> +            s =3D ""
> +            for a in self.attributes:
> +                s +=3D "(typeattribute %s %s)" % (self.type, a)
> +            return s
> +        else:
> +            return "typeattribute %s %s;" % (self.type, self.attributes.=
to_comma_str())
>
>  class RoleAttribute(Leaf):
>      """SElinux roleattribute statement.
> @@ -451,7 +462,10 @@ class Role(Leaf):
>      def to_string(self):
>          s =3D ""
>          for t in self.types:
> -            s +=3D "role %s types %s;\n" % (self.role, t)
> +            if self.gen_cil:
> +                s +=3D "(roletype %s %s)\n" % (self.role, t)
> +            else:
> +                s +=3D "role %s types %s;\n" % (self.role, t)
>          return s
>
>  class Type(Leaf):
> @@ -462,12 +476,20 @@ class Type(Leaf):
>          self.aliases =3D IdSet()
>
>      def to_string(self):
> -        s =3D "type %s" % self.name
> -        if len(self.aliases) > 0:
> -            s =3D s + "alias %s" % self.aliases.to_space_str()
> -        if len(self.attributes) > 0:
> -            s =3D s + ", %s" % self.attributes.to_comma_str()
> -        return s + ";"
> +        if self.gen_cil:
> +            s =3D "(type %s)" % self.name
> +            for a in self.aliases:
> +                s +=3D "(typealiasactual %s %s)\n" % (self.name, a)
> +            for a in self.attributes:
> +                s +=3D "(typeattributeset %s %s)\n" % (self.name, a)
> +            return s
> +        else:
> +            s =3D "type %s" % self.name
> +            if len(self.aliases) > 0:
> +                s =3D s + "alias %s" % self.aliases.to_space_str()
> +            if len(self.attributes) > 0:
> +                s =3D s + ", %s" % self.attributes.to_comma_str()
> +            return s + ";"
>
>  class TypeAlias(Leaf):
>      def __init__(self, parent=3DNone):
> @@ -476,7 +498,13 @@ class TypeAlias(Leaf):
>          self.aliases =3D IdSet()
>
>      def to_string(self):
> -        return "typealias %s alias %s;" % (self.type, self.aliases.to_sp=
ace_str())
> +        if self.gen_cil:
> +            s =3D ""
> +            for a in self.aliases:
> +                s +=3D "(typealias %s %s)\n" % (self.type, a)
> +            return s
> +        else:
> +            return "typealias %s alias %s;" % (self.type, self.aliases.t=
o_space_str())
>
>  class Attribute(Leaf):
>      def __init__(self, name=3D"", parent=3DNone):
> @@ -484,7 +512,10 @@ class Attribute(Leaf):
>          self.name =3D name
>
>      def to_string(self):
> -        return "attribute %s;" % self.name
> +        if self.gen_cil:
> +            return "attribute %s;" % self.name
> +        else:
> +            return "(typeattribute %s)" % self.name
>
>  class Attribute_Role(Leaf):
>      def __init__(self, name=3D"", parent=3DNone):
> @@ -492,7 +523,10 @@ class Attribute_Role(Leaf):
>          self.name =3D name
>
>      def to_string(self):
> -        return "attribute_role %s;" % self.name
> +        if self.gen_cil:
> +            return "(roleattribute %s)" % self.name
> +        else:
> +            return "attribute_role %s;" % self.name
>
>
>  # Classes representing rules
> @@ -555,11 +589,21 @@ class AVRule(Leaf):
>          that is a valid policy language representation (assuming
>          that the types, object class, etc. are valie).
>          """
> -        return "%s %s %s:%s %s;" % (self.__rule_type_str(),
> -                                     self.src_types.to_space_str(),
> -                                     self.tgt_types.to_space_str(),
> -                                     self.obj_classes.to_space_str(),
> -                                     self.perms.to_space_str())
> +        if self.gen_cil:
> +            s =3D ""
> +            for src in self.src_types:
> +                for tgt in self.tgt_types:
> +                    for obj in self.obj_classes:
> +                        s +=3D "(%s %s %s (%s (%s)))" % (self.__rule_typ=
e_str(),
> +                                                       src, tgt, obj,
> +                                                       " ".join(self.per=
ms))
> +            return s
> +        else:
> +            return "%s %s %s:%s %s;" % (self.__rule_type_str(),
> +                                        self.src_types.to_space_str(),
> +                                        self.tgt_types.to_space_str(),
> +                                        self.obj_classes.to_space_str(),
> +                                        self.perms.to_space_str())
>
>  class AVExtRule(Leaf):
>      """Extended permission access vector rule.
> @@ -597,6 +641,16 @@ class AVExtRule(Leaf):
>          elif self.rule_type =3D=3D self.NEVERALLOWXPERM:
>              return "neverallowxperm"
>
> +    def __rule_type_str_cil(self):
> +        if self.rule_type =3D=3D self.ALLOWXPERM:
> +            return "allowx"
> +        elif self.rule_type =3D=3D self.DONTAUDITXPERM:
> +            return "dontauditx"
> +        elif self.rule_type =3D=3D self.AUDITALLOWXPERM:
> +            return "auditallowx"
> +        elif self.rule_type =3D=3D self.NEVERALLOWXPERM:
> +            return "neverallowx"
> +
>      def from_av(self, av, op):
>          self.src_types.add(av.src_type)
>          if av.src_type =3D=3D av.tgt_type:
> @@ -612,12 +666,22 @@ class AVExtRule(Leaf):
>          a valid policy language representation (assuming that
>          the types, object class, etc. are valid).
>          """
> -        return "%s %s %s:%s %s %s;" % (self.__rule_type_str(),
> -                                     self.src_types.to_space_str(),
> -                                     self.tgt_types.to_space_str(),
> -                                     self.obj_classes.to_space_str(),
> -                                     self.operation,
> -                                     self.xperms.to_string())
> +        if self.gen_cil:
> +            for src in self.src_types:
> +                for tgt in self.tgt_types:
> +                    for obj in self.obj_classes:
> +                        s +=3D "(%s %s %s (%s (%s)))" % (self.__rule_typ=
e_str_cil(),
> +                                                       src, tgt, obj,
> +                                                       " ".join(self.xpe=
rms))

Should be:
s +=3D "%s %s %s (ioctl %s (%s)))" % ...

> +            return s
> +        else:
> +            return "%s %s %s:%s %s %s;" % (self.__rule_type_str(),
> +                                           self.src_types.to_space_str()=
,
> +                                           self.tgt_types.to_space_str()=
,
> +                                           self.obj_classes.to_space_str=
(),
> +                                           self.operation,
> +                                           self.xperms.to_string())
> +
>
>  class TypeRule(Leaf):
>      """SELinux type rules.
> @@ -646,12 +710,28 @@ class TypeRule(Leaf):
>          else:
>              return "type_member"
>
> +    def __rule_type_str_cil(self):
> +        if self.rule_type =3D=3D self.TYPE_TRANSITION:
> +            return "typetransition"
> +        elif self.rule_type =3D=3D self.TYPE_CHANGE:
> +            return "typechange"
> +        else:
> +            return "typemember"
> +
>      def to_string(self):
> -        return "%s %s %s:%s %s;" % (self.__rule_type_str(),
> -                                     self.src_types.to_space_str(),
> -                                     self.tgt_types.to_space_str(),
> -                                     self.obj_classes.to_space_str(),
> -                                     self.dest_type)
> +        if self.gen_cil:
> +            return "(%s %s %s %s %s)" % (self.__rule_type_str_cil(),
> +                                         self.src_types.to_space_str(),
> +                                         self.tgt_types.to_space_str(),
> +                                         self.obj_classes.to_space_str()=
,
> +                                         self.dest_type)

I assume filename type transitions are not generated by audit2allow.
It might be nice to have a comment here saying that.

Thanks,
Jim

> +        else:
> +            return "%s %s %s:%s %s;" % (self.__rule_type_str(),
> +                                        self.src_types.to_space_str(),
> +                                        self.tgt_types.to_space_str(),
> +                                        self.obj_classes.to_space_str(),
> +                                        self.dest_type)
> +
>  class TypeBound(Leaf):
>      """SElinux typebound statement.
>
> @@ -663,8 +743,13 @@ class TypeBound(Leaf):
>          self.tgt_types =3D IdSet()
>
>      def to_string(self):
> -        return "typebounds %s %s;" % (self.type, self.tgt_types.to_comma=
_str())
> -
> +        if self.gen_cil:
> +            s =3D ""
> +            for t in self.tgt_types:
> +                s +=3D "(typebounds %s %s)" % (self.type, t)
> +            return s
> +        else:
> +            return "typebounds %s %s;" % (self.type, self.tgt_types.to_c=
omma_str())
>
>  class RoleAllow(Leaf):
>      def __init__(self, parent=3DNone):
> @@ -673,8 +758,15 @@ class RoleAllow(Leaf):
>          self.tgt_roles =3D IdSet()
>
>      def to_string(self):
> -        return "allow %s %s;" % (self.src_roles.to_comma_str(),
> -                                 self.tgt_roles.to_comma_str())
> +        if self.gen_cil:
> +            s =3D ""
> +            for src in self.src_roles:
> +                for tgt in self.tgt_roles:
> +                    s +=3D "(roleallow %s %s)" % (src, tgt)
> +            return s
> +        else:
> +            return "allow %s %s;" % (self.src_roles.to_comma_str(),
> +                                     self.tgt_roles.to_comma_str())
>
>  class RoleType(Leaf):
>      def __init__(self, parent=3DNone):
> @@ -685,7 +777,10 @@ class RoleType(Leaf):
>      def to_string(self):
>          s =3D ""
>          for t in self.types:
> -            s +=3D "role %s types %s;\n" % (self.role, t)
> +            if self.gen_cil:
> +                s +=3D "(roletype %s %s)\n" % (self.role, t)
> +            else:
> +                s +=3D "role %s types %s;\n" % (self.role, t)
>          return s
>
>  class ModuleDeclaration(Leaf):
> @@ -696,10 +791,13 @@ class ModuleDeclaration(Leaf):
>          self.refpolicy =3D False
>
>      def to_string(self):
> -        if self.refpolicy:
> -            return "policy_module(%s, %s)" % (self.name, self.version)
> +        if self.gen_cil:
> +            return ""
>          else:
> -            return "module %s %s;" % (self.name, self.version)
> +            if self.refpolicy:
> +                return "policy_module(%s, %s)" % (self.name, self.versio=
n)
> +            else:
> +                return "module %s %s;" % (self.name, self.version)
>
>  class Conditional(Node):
>      def __init__(self, parent=3DNone):
> @@ -729,7 +827,10 @@ class InitialSid(Leaf):
>          self.context =3D None
>
>      def to_string(self):
> -        return "sid %s %s" % (self.name, str(self.context))
> +        if self.gen_cil:
> +            return "(sid %s %s)" % (self.name, str(self.context))
> +        else:
> +            return "sid %s %s" % (self.name, str(self.context))
>
>  class GenfsCon(Leaf):
>      def __init__(self, parent=3DNone):
> @@ -739,7 +840,10 @@ class GenfsCon(Leaf):
>          self.context =3D None
>
>      def to_string(self):
> -        return "genfscon %s %s %s" % (self.filesystem, self.path, str(se=
lf.context))
> +        if self.gen_cil:
> +            return "(genfscon %s %s %s)" % (self.filesystem, self.path, =
str(self.context))
> +        else:
> +            return "genfscon %s %s %s" % (self.filesystem, self.path, st=
r(self.context))
>
>  class FilesystemUse(Leaf):
>      XATTR =3D 1
> @@ -754,14 +858,24 @@ class FilesystemUse(Leaf):
>
>      def to_string(self):
>          s =3D ""
> -        if self.type =3D=3D self.XATTR:
> -            s =3D "fs_use_xattr "
> -        elif self.type =3D=3D self.TRANS:
> -            s =3D "fs_use_trans "
> -        elif self.type =3D=3D self.TASK:
> -            s =3D "fs_use_task "
> +        if self.gen_cil:
> +            if self.type =3D=3D self.XATTR:
> +                s =3D "fsuse xattr "
> +            elif self.type =3D=3D self.TRANS:
> +                s =3D "fsuse trans "
> +            elif self.type =3D=3D self.TASK:
> +                s =3D "fsuse task "
> +
> +            return "(%s %s %s)" % (s, self.filesystem, str(self.context)=
)
> +        else:
> +            if self.type =3D=3D self.XATTR:
> +                s =3D "fs_use_xattr "
> +            elif self.type =3D=3D self.TRANS:
> +                s =3D "fs_use_trans "
> +            elif self.type =3D=3D self.TASK:
> +                s =3D "fs_use_task "
>
> -        return "%s %s %s;" % (s, self.filesystem, str(self.context))
> +            return "%s %s %s;" % (s, self.filesystem, str(self.context))
>
>  class PortCon(Leaf):
>      def __init__(self, parent=3DNone):
> @@ -771,7 +885,10 @@ class PortCon(Leaf):
>          self.context =3D None
>
>      def to_string(self):
> -        return "portcon %s %s %s" % (self.port_type, self.port_number, s=
tr(self.context))
> +        if self.gen_cil:
> +            return "(portcon %s %s %s)" % (self.port_type, self.port_num=
ber, str(self.context))
> +        else:
> +            return "portcon %s %s %s" % (self.port_type, self.port_numbe=
r, str(self.context))
>
>  class NodeCon(Leaf):
>      def __init__(self, parent=3DNone):
> @@ -781,7 +898,10 @@ class NodeCon(Leaf):
>          self.context =3D None
>
>      def to_string(self):
> -        return "nodecon %s %s %s" % (self.start, self.end, str(self.cont=
ext))
> +        if self.gen_cil:
> +            return "(nodecon %s %s %s)" % (self.start, self.end, str(sel=
f.context))
> +        else:
> +            return "nodecon %s %s %s" % (self.start, self.end, str(self.=
context))
>
>  class NetifCon(Leaf):
>      def __init__(self, parent=3DNone):
> @@ -791,8 +911,13 @@ class NetifCon(Leaf):
>          self.packet_context =3D None
>
>      def to_string(self):
> -        return "netifcon %s %s %s" % (self.interface, str(self.interface=
_context),
> -                                   str(self.packet_context))
> +        if self.gen_cil:
> +            return "(netifcon %s %s %s)" % (self.interface, str(self.int=
erface_context),
> +                                            str(self.packet_context))
> +        else:
> +            return "netifcon %s %s %s" % (self.interface, str(self.inter=
face_context),
> +                                          str(self.packet_context))
> +
>  class PirqCon(Leaf):
>      def __init__(self, parent=3DNone):
>          Leaf.__init__(self, parent)
> @@ -800,7 +925,10 @@ class PirqCon(Leaf):
>          self.context =3D None
>
>      def to_string(self):
> -        return "pirqcon %s %s" % (self.pirq_number, str(self.context))
> +        if self.gen_cil:
> +            return "(pirqcon %s %s)" % (self.pirq_number, str(self.conte=
xt))
> +        else:
> +            return "pirqcon %s %s" % (self.pirq_number, str(self.context=
))
>
>  class IomemCon(Leaf):
>      def __init__(self, parent=3DNone):
> @@ -809,7 +937,10 @@ class IomemCon(Leaf):
>          self.context =3D None
>
>      def to_string(self):
> -        return "iomemcon %s %s" % (self.device_mem, str(self.context))
> +        if self.gen_cil:
> +            return "(iomemcon %s %s)" % (self.device_mem, str(self.conte=
xt))
> +        else:
> +            return "iomemcon %s %s" % (self.device_mem, str(self.context=
))
>
>  class IoportCon(Leaf):
>      def __init__(self, parent=3DNone):
> @@ -818,7 +949,10 @@ class IoportCon(Leaf):
>          self.context =3D None
>
>      def to_string(self):
> -        return "ioportcon %s %s" % (self.ioport, str(self.context))
> +        if self.gen_cil:
> +            return "(ioportcon %s %s)" % (self.ioport, str(self.context)=
)
> +        else:
> +            return "ioportcon %s %s" % (self.ioport, str(self.context))
>
>  class PciDeviceCon(Leaf):
>      def __init__(self, parent=3DNone):
> @@ -827,7 +961,10 @@ class PciDeviceCon(Leaf):
>          self.context =3D None
>
>      def to_string(self):
> -        return "pcidevicecon %s %s" % (self.device, str(self.context))
> +        if self.gen_cil:
> +            return "(pcidevicecon %s %s)" % (self.device, str(self.conte=
xt))
> +        else:
> +            return "pcidevicecon %s %s" % (self.device, str(self.context=
))
>
>  class DeviceTreeCon(Leaf):
>      def __init__(self, parent=3DNone):
> @@ -836,7 +973,10 @@ class DeviceTreeCon(Leaf):
>          self.context =3D None
>
>      def to_string(self):
> -        return "devicetreecon %s %s" % (self.path, str(self.context))
> +        if self.gen_cil:
> +            return "(devicetreecon %s %s)" % (self.path, str(self.contex=
t))
> +        else:
> +            return "devicetreecon %s %s" % (self.path, str(self.context)=
)
>
>  # Reference policy specific types
>
> @@ -993,25 +1133,33 @@ class Require(Leaf):
>
>      def to_string(self):
>          s =3D []
> -        s.append("require {")
> -        for type in self.types:
> -            s.append("\ttype %s;" % type)
> -        for obj_class, perms in self.obj_classes.items():
> -            s.append("\tclass %s %s;" % (obj_class, perms.to_space_str()=
))
> -        for role in self.roles:
> -            s.append("\trole %s;" % role)
> -        for bool in self.data:
> -            s.append("\tbool %s;" % bool)
> -        for user in self.users:
> -            s.append("\tuser %s;" % user)
> -        s.append("}")
> -
> -        # Handle empty requires
> -        if len(s) =3D=3D 2:
> -            return ""
> -
> -        return "\n".join(s)
> -
> +        if self.gen_cil:
> +            # Can't require classes, perms, booleans, users
> +            for type in self.types:
> +                s.append("(typeattributeset cil_gen_require %s)" % type)
> +            for role in self.roles:
> +                s.append("(roleattributeset cil_gen_require %s)" % role)
> +
> +            return "\n".join(s)
> +        else:
> +            s.append("require {")
> +            for type in self.types:
> +                s.append("\ttype %s;" % type)
> +            for obj_class, perms in self.obj_classes.items():
> +                s.append("\tclass %s %s;" % (obj_class, perms.to_space_s=
tr()))
> +            for role in self.roles:
> +                s.append("\trole %s;" % role)
> +            for bool in self.data:
> +                s.append("\tbool %s;" % bool)
> +            for user in self.users:
> +                s.append("\tuser %s;" % user)
> +            s.append("}")
> +
> +            # Handle empty requires
> +            if len(s) =3D=3D 2:
> +                return ""
> +
> +            return "\n".join(s)
>
>  class ObjPermSet:
>      def __init__(self, name):
> @@ -1044,7 +1192,10 @@ class Comment:
>          else:
>              out =3D []
>              for line in self.lines:
> -                out.append("#" + line)
> +                if self.gen_cil:
> +                    out.append(";" + line)
> +                else:
> +                    out.append("#" + line)
>              return "\n".join(out)
>
>      def merge(self, other):
> @@ -1056,4 +1207,5 @@ class Comment:
>      def __str__(self):
>          return self.to_string()
>
> -
> +    def set_gen_cil(self, gen_cil):
> +        self.gen_cil =3D gen_cil
>
> base-commit: 82195e77e317d322dd9b5fc31d402462d6845357
> --
> 2.43.0
>
>
