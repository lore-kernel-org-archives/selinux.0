Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560554EB34
	for <selinux@vger.kernel.org>; Mon, 18 Mar 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768287; cv=none; b=lTfFOvHOIesdzlychkETzbWm5lLKl3J8frn4IY3ejfwY0qAivCgkDdn5S100HFsxxWdu7PI96AzsCO6OMIn4AOF32n6ysx3KKcbh0OiXH2LPX57KMZM4WIWdq/9KWySnNjUgZGE2/R+yZsLyGv8SHSS0RBMUBX9REefQiRG0n+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768287; c=relaxed/simple;
	bh=eSmYcDNbhV0aGXMBFfiFDZsW6SiWLLZ359UrbcXPBkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLfrhVk5OeT6E9RfOawvqJu3y9/+567gskGWeg/v/UmuojW9Ao462o6aKBlubdxy+sERgVwcx7kSe7mtdyb3D+dXCUZHENgw+hD1jFvda1jj5icUQLIzOPQXeMT+J4+5GrML/iS0d8bnD8kLmQcbwwD+U8EFowqV5R6uandEbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZbgwkPa; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZbgwkPa"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4739b6ddc94so508210137.0
        for <selinux@vger.kernel.org>; Mon, 18 Mar 2024 06:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710768283; x=1711373083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O02mo7JP9EStnQagMKPPZB1XFsy19lG9DuHE3SnXR+w=;
        b=EZbgwkPaCQ1ZwxlH8Szsi0vF1LjUxT8fgoCaHNSjzjZsinr+2wqCSguoudGx/U2uwm
         svquJchnD0kvFX+ewl78ePEFnVwpP5e9pemrwqzQRbk/nT91bUx8ZnkeltuMAipBbDgX
         S0vmk1SZn9arYLbVdv4LCjaZ9cT4D3lsFbyLPj2RB86bPMq8XS0T4iY72G65ZL0W1Iwz
         EFx3zSHo82DxxZ7k29EXRWnITovUZ9o2Gld5rB3NDv2V3csOrNT7ztYBSAwBFPPD0OJu
         nO0O+guQVzbXtt5LFhWVzISczi1y9tmOq4TGF0uzkq3i/g7ADivdtry7H+vtyNevCK+X
         RLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710768283; x=1711373083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O02mo7JP9EStnQagMKPPZB1XFsy19lG9DuHE3SnXR+w=;
        b=WOmMRBbnzrqd0Y1HlHnBtx1UuppIfL37PS+FI2fLTm4ulY5HBtyEsaB+OTDewlb1Zz
         naKXjSOlDt7gOCGGdi6VL9Fuc2s/jTpvt/z15xcGKn6FJ8ZNw4A+iPw8tjUeWVR8eSXT
         lT7KRDcSGM2z8PLSS88//hBvXi6tYRWnyZWlCxTd/8M4r2bpwkuB5biMtMRbQD6A+Pkl
         es2NC5KGfmQRRWBghNGhsrKIB7AAzToyl3ypO7gaS1aXr8kYwqlu7E5xnZzRpt9gRCCg
         zYQUfhwdT0w44J8jlJFNeZ5KW+iq1dc+ccHjSovJECXy/fHm6gNUM9xlH+jfOxqOnT/r
         vnWA==
X-Gm-Message-State: AOJu0YxSqSbc71DjC+tU48EM/ixPtq3BtaclaRp3lIno6cmmdUSt/2YE
	alhWaY6gmHuYDWdeRfVfWoWAoGWYcTNci8qeA8lRXW+xDONE/Eeq0zAt3EVkPU8vYKCnbuSl2x0
	/fbamwUpHinWTFVzjufvdqaWEQQE=
X-Google-Smtp-Source: AGHT+IHU9Oz9X/0dYNByWOON57YdWv01N6s/v7P7xsulMmlkD6s19svhkKMo2T2bbDskVgM4ft+nxLbugTboDWq1n00=
X-Received: by 2002:a05:6102:233a:b0:476:58f8:63ee with SMTP id
 b26-20020a056102233a00b0047658f863eemr7115357vsa.35.1710768282904; Mon, 18
 Mar 2024 06:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302205546.5706-2-toiwoton@gmail.com>
In-Reply-To: <20240302205546.5706-2-toiwoton@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 18 Mar 2024 09:24:31 -0400
Message-ID: <CAP+JOzSo5O0z_n2C7z2o3BDYOL1KuzZebRNS36jhWygY2_euRA@mail.gmail.com>
Subject: Re: [PATCH PR#420 v3] audit2allow: CIL output mode
To: Topi Miettinen <toiwoton@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 3:56=E2=80=AFPM Topi Miettinen <toiwoton@gmail.com> =
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
>
> ---
> v3: fixed extended permissions syntax
> v2: fix uninitialized variable detected by CI
> ---
>  python/audit2allow/audit2allow            |  14 +-
>  python/audit2allow/audit2allow.1          |   3 +
>  python/sepolgen/src/sepolgen/output.py    |   5 +
>  python/sepolgen/src/sepolgen/policygen.py |  29 +-
>  python/sepolgen/src/sepolgen/refpolicy.py | 314 +++++++++++++++++-----
>  5 files changed, 279 insertions(+), 86 deletions(-)
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

If gen_cil is false, then I think you want to set
self.comment_start=3D"#". You seem to be assuming that gen_cil is always
true.

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

The '#' near the end of both of these lines are comments and need to
be replaced like in the previous chunk.

>          except:
>              pass
>
> diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/=
src/sepolgen/refpolicy.py
> index 9cac1b95..e7fa5645 100644
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
> @@ -413,6 +418,16 @@ class XpermSet():
>
>          return "%s{ %s }" % (compl, " ".join(vals))
>
> +    def to_string_cil(self):
> +        if not self.ranges:
> +            return ""
> +
> +        compl =3D ("not (", ")") if self.complement else ("", "")
> +
> +        vals =3D map(lambda x: hex(x[0]) if x[0] =3D=3D x[1] else "(rang=
e %s %s)" % (hex(x[0]), hex(x[1]), ), self.ranges)
> +
> +        return "(%s%s%s)" % (compl[0], " ".join(vals), compl[1])
> +
>  # Basic statements
>
>  class TypeAttribute(Leaf):
> @@ -426,7 +441,13 @@ class TypeAttribute(Leaf):
>          self.attributes =3D IdSet()
>
>      def to_string(self):
> -        return "typeattribute %s %s;" % (self.type, self.attributes.to_c=
omma_str())
> +        if self.gen_cil:
> +            s =3D ""
> +            for a in self.attributes:
> +                s +=3D "(typeattribute %s %s)" % (self.type, a)

The typeattribute statement just declares the attribute, so you need
two statements (also, don't you want a '\n' at the end):
s +=3D "(typeattribute %s)\n" % a
s +=3D "typeattributeset %s %s)\n" % (a, self.type)

> +            return s
> +        else:
> +            return "typeattribute %s %s;" % (self.type, self.attributes.=
to_comma_str())
>
>  class RoleAttribute(Leaf):
>      """SElinux roleattribute statement.

Role attributes in CIL are just like type attributes, just replace
"type" with "role"

> @@ -451,7 +472,10 @@ class Role(Leaf):
>      def to_string(self):
>          s =3D ""
>          for t in self.types:
> -            s +=3D "role %s types %s;\n" % (self.role, t)
> +            if self.gen_cil:
> +                s +=3D "(roletype %s %s)\n" % (self.role, t)

This works for associating types to a role, but the role needs to be
declared as well. It should be similar to what is done for types
below.

if self.gen_cil:
  s =3D "(role %s)" % self.role
  for t in self.types:
    s +=3D "(roletype %s %s)\n" % (self.role, t)

Unless it is assumed the role is declared elsewhere.

> +            else:
> +                s +=3D "role %s types %s;\n" % (self.role, t)
>          return s
>
>  class Type(Leaf):
> @@ -462,12 +486,20 @@ class Type(Leaf):
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

The type alias comes first, so "(a, self.name)"

> +            for a in self.attributes:
> +                s +=3D "(typeattributeset %s %s)\n" % (self.name, a)

Like above, the type attribute comes first.

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
> @@ -476,7 +508,13 @@ class TypeAlias(Leaf):
>          self.aliases =3D IdSet()
>
>      def to_string(self):
> -        return "typealias %s alias %s;" % (self.type, self.aliases.to_sp=
ace_str())
> +        if self.gen_cil:
> +            s =3D ""
> +            for a in self.aliases:
> +                s +=3D "(typealias %s %s)\n" % (self.type, a)

The typealias statement declares the alias.

You need:
s +=3D "(typealias %s)\n" % a
s +=3D "(typealiasactual %s %s)\n" % (a, self.type)

Thank you for doing this. Sorry I didn't catch some of these earlier.
Jim

> +            return s
> +        else:
> +            return "typealias %s alias %s;" % (self.type, self.aliases.t=
o_space_str())
>
>  class Attribute(Leaf):
>      def __init__(self, name=3D"", parent=3DNone):
> @@ -484,7 +522,10 @@ class Attribute(Leaf):
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
> @@ -492,7 +533,10 @@ class Attribute_Role(Leaf):
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
> @@ -555,11 +599,21 @@ class AVRule(Leaf):
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
> @@ -597,6 +651,16 @@ class AVExtRule(Leaf):
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
> @@ -612,12 +676,25 @@ class AVExtRule(Leaf):
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
> +            s =3D ""
> +            for src in self.src_types:
> +                for tgt in self.tgt_types:
> +                    for obj in self.obj_classes:
> +                        s +=3D "(%s %s %s (%s %s %s))" % (self.__rule_ty=
pe_str_cil(),
> +                                                        src, tgt,
> +                                                        self.operation,
> +                                                        obj,
> +                                                        self.xperms.to_s=
tring_cil())
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
> @@ -630,6 +707,7 @@ class TypeRule(Leaf):
>      TYPE_CHANGE =3D 1
>      TYPE_MEMBER =3D 2
>
> +    # NB. Filename type transitions are not generated by audit2allow.
>      def __init__(self, parent=3DNone):
>          Leaf.__init__(self, parent)
>          self.src_types =3D IdSet()
> @@ -646,12 +724,28 @@ class TypeRule(Leaf):
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
> @@ -663,8 +757,13 @@ class TypeBound(Leaf):
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
> @@ -673,8 +772,15 @@ class RoleAllow(Leaf):
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
> @@ -685,7 +791,10 @@ class RoleType(Leaf):
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
> @@ -696,10 +805,13 @@ class ModuleDeclaration(Leaf):
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
> @@ -729,7 +841,10 @@ class InitialSid(Leaf):
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
> @@ -739,7 +854,10 @@ class GenfsCon(Leaf):
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
> @@ -754,14 +872,24 @@ class FilesystemUse(Leaf):
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
> @@ -771,7 +899,10 @@ class PortCon(Leaf):
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
> @@ -781,7 +912,10 @@ class NodeCon(Leaf):
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
> @@ -791,8 +925,13 @@ class NetifCon(Leaf):
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
> @@ -800,7 +939,10 @@ class PirqCon(Leaf):
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
> @@ -809,7 +951,10 @@ class IomemCon(Leaf):
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
> @@ -818,7 +963,10 @@ class IoportCon(Leaf):
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
> @@ -827,7 +975,10 @@ class PciDeviceCon(Leaf):
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
> @@ -836,7 +987,10 @@ class DeviceTreeCon(Leaf):
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
> @@ -993,25 +1147,33 @@ class Require(Leaf):
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
> @@ -1044,7 +1206,10 @@ class Comment:
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
> @@ -1056,4 +1221,5 @@ class Comment:
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
