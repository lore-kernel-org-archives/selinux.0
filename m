Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1B06A8BF
	for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957702; cv=none; b=MvUcA7gmsNy5t1xOcxokUB24i3O/ItglpE1IZxY9juQxzx/n47di5m5KOwIICmqczx2Z5Yw30BTW14iBFGi/Pz1lP0JVyp1PfJHgyBSey8IOpz8hjczBTuiq3wfU3u14lFZdCOKjcOs0D0ZSUseCqGiFv+Ff2+XouYonayLkKe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957702; c=relaxed/simple;
	bh=LBmbAZYJN9YkxOya1MmSiLSG6EPwsv63weNnfHPa8uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ke13GKkQSFNPAhMI1XBj44WhXjTI8njHcyPx98oGz60lTH9Llh8NF4mYiJSTv2i2W7yjFZwPrEhRXNQQYbPMB28X/RUJr7SNa+ngQnNGoV88Q6fDDnoXKIZgJ3dRAkKxY2qqOopczs1PEpjpFmP0XIRY5PT4h7njxldiBaIkKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS3WYMLd; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS3WYMLd"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbbc6e51d0so110845b6e.3
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710957699; x=1711562499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKoYRj0YY00CRCXVKvn0N2BAXapG3oKU5U0R4eFSHc4=;
        b=VS3WYMLdgN9EuowgcBPKxLbBeXq2e0eyWP93ICeGhIm36w/UqdnEEcZQAJ2/gjOufg
         FWaJRZTGx2RPf2xor9mbR4GbsdkJREY0Rt5fG9LNO0GgVsiAakzn/rDjeu9GjVN9wlmf
         1o7y5W/znVA8HohmfnYXP/FiOSLfdEH+DJPeA/KVYbgFnwW9INCg/rz1txKj4/Lus7N9
         E1vymfPIQOWmVDj/ft5eDr7pAcqGGewVR6L38On4VOMgpn4lS+clbr2tqwRco5oDMpfJ
         wNC0HtNiWUx1kW6ZdXN4/qG1zVibRQ5JmFQPc1yScqNF2aJf92Nhpc9o0Z3KznFFRwmE
         GpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957699; x=1711562499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKoYRj0YY00CRCXVKvn0N2BAXapG3oKU5U0R4eFSHc4=;
        b=lCGM4Qv6yKHSGpsmfGT+1UBdOfNq7FQvSIzaQF+c8j2W+UMb1Z6mTahpz2HHJZRojg
         Ugz6uNVzgZz9OVfifLyMJgv2H3ht2HSh2fT+nKhXd5EywXpAexOWMUpBwRb9ie+WQ6IJ
         GiM860lwaUolQpSichwCCRU/xYRkJmvnDfQjRuhu5vz4Cv8Mtk+IRBCJAFyZoPs9ZExQ
         WNLg5CsbqaCakMC3y8VMjX3bCNM8BBr12U6baL1w4OcDup+LRZL6S/Ojo96kZVeyyaH4
         VZhBd0RVigsgP6hG759nuseMvGHv9I5tDi+ApqzRySQU39GgE47WtaDVs1phDaCM8cAL
         9/dg==
X-Gm-Message-State: AOJu0Yy6ymoEhbzhNuQw3yDDxDG4PiZiLWnb1Pj5aBF8EBOodZrCRHix
	s4/uLZFPBS7BU1znT8HbXi3qUsL5RXjSbuobn0Fo077akzgkbxinTcnjvGpCz9jls94nICnJ19g
	Kt8k4w+WYPHcJV5cuxNWRJQDK1+PEc/J8q+o=
X-Google-Smtp-Source: AGHT+IHiys8/wkBHRWXTmocWpA1Sp1PV5N8FlV8cKt8bX1eqmRLtlWW4D/ao7DnhlvSnheiAVwELGouzG+bZFyiw9CA=
X-Received: by 2002:a05:6808:301e:b0:3c2:fef:391 with SMTP id
 ay30-20020a056808301e00b003c20fef0391mr19993315oib.35.1710957699495; Wed, 20
 Mar 2024 11:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222193117.17539-1-cgzones@googlemail.com>
In-Reply-To: <20240222193117.17539-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 Mar 2024 14:01:28 -0400
Message-ID: <CAP+JOzQriUQ-mzJRCmCfApriJ_VQqOp26VE4z0krs8K1S59RBw@mail.gmail.com>
Subject: Re: [PATCH] sepolgen: adjust parse for refpolicy
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 2:31=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Currently sepolgen fails to parse the reference policy:
>
>     Parsing interface files:
>     %--10---20---30---40---50---60---70---80---90--100
>     #############/tmp/destdir/usr/share/selinux/refpolicy/include/kernel/=
kernel.if: Syntax error on line 1737 - [type=3DMINUS]
>     /tmp/destdir/usr/share/selinux/refpolicy/include/kernel/kernel.if: Sy=
ntax error on line 1755 - [type=3DMINUS]
>     error parsing file /tmp/destdir/usr/share/selinux/refpolicy/include/k=
ernel/kernel.if: could not parse text: "/tmp/destdir/usr/share/selinux/refp=
olicy/include/kernel/kernel.if: Syntax error on line 1755 - [type=3DMINUS]"
>     /tmp/destdir/usr/share/selinux/refpolicy/include/kernel/selinux.if: S=
yntax error on line 43 - [type=3DMINUS]
>     error parsing file /tmp/destdir/usr/share/selinux/refpolicy/include/k=
ernel/selinux.if: could not parse text: "/tmp/destdir/usr/share/selinux/ref=
policy/include/kernel/selinux.if: Syntax error on line 43 - [type=3DMINUS]"
>     ############################/tmp/destdir/usr/share/selinux/refpolicy/=
include/services/ssh.if: Syntax error on line 183 $1_port_forwarding [type=
=3DIDENTIFIER]
>     /tmp/destdir/usr/share/selinux/refpolicy/include/services/ssh.if: Syn=
tax error on line 293 ' [type=3DSQUOTE]
>     error parsing file /tmp/destdir/usr/share/selinux/refpolicy/include/s=
ervices/ssh.if: could not parse text: "/tmp/destdir/usr/share/selinux/refpo=
licy/include/services/ssh.if: Syntax error on line 293 ' [type=3DSQUOTE]"
>     ######/tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if=
: Syntax error on line 2137 true [type=3DTRUE]
>     /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: Synt=
ax error on line 2148 ' [type=3DSQUOTE]
>     /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: Synt=
ax error on line 2152 ' [type=3DSQUOTE]
>     /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: Synt=
ax error on line 2163 ' [type=3DSQUOTE]
>     /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: Synt=
ax error on line 2167 ' [type=3DSQUOTE]
>     error parsing file /tmp/destdir/usr/share/selinux/refpolicy/include/s=
ystem/init.if: could not parse text: "/tmp/destdir/usr/share/selinux/refpol=
icy/include/system/init.if: Syntax error on line 2167 ' [type=3DSQUOTE]"
>     ##failed to parse some headers: /tmp/destdir/usr/share/selinux/refpol=
icy/include/kernel/kernel.if, /tmp/destdir/usr/share/selinux/refpolicy/incl=
ude/kernel/selinux.if, /tmp/destdir/usr/share/selinux/refpolicy/include/ser=
vices/ssh.if, /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.=
if
>     Missing interface definition for init_startstop_service
>     Missing interface definition for init_startstop_service
>     ...
>
> Accept chained ifelse blocks, genfscon statements with file specifiers,
> and booleans with unquoted identifiers.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/sepolgen/src/sepolgen/refparser.py | 74 +++++++++++++++++------
>  python/sepolgen/src/sepolgen/refpolicy.py |  8 +++
>  2 files changed, 65 insertions(+), 17 deletions(-)
>
> diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/=
src/sepolgen/refparser.py
> index 1bb90564..e261d3f7 100644
> --- a/python/sepolgen/src/sepolgen/refparser.py
> +++ b/python/sepolgen/src/sepolgen/refparser.py
> @@ -418,19 +418,41 @@ def p_tunable_policy(p):
>          collect(p[12], x, val=3DFalse)
>      p[0] =3D [x]
>
> -def p_ifelse(p):
> -    '''ifelse : IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA COMMA TICK ID=
ENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
> -              | IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK IDENTIFI=
ER SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUO=
TE CPAREN optional_semi
> -              | IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK SQUOTE C=
OMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN o=
ptional_semi
> +def p_ifelse_compare_value(p):
> +    '''ifelse_compare_value : TICK IDENTIFIER SQUOTE
> +                            | TICK TRUE       SQUOTE
> +                            | TICK FALSE      SQUOTE
> +                            | TICK            SQUOTE
> +                            | empty
>      '''
> -#    x =3D refpolicy.IfDef(p[4])
> -#    v =3D True
> -#    collect(p[8], x, val=3Dv)
> -#    if len(p) > 12:
> -#        collect(p[12], x, val=3DFalse)
> -#    p[0] =3D [x]
> -    pass
> +    if len(p) =3D=3D 4:
> +        p[0] =3D p[2]
> +    else:
> +        p[0] =3D None
> +
> +def p_ifelse_section(p):
> +    '''ifelse_section : TICK IDENTIFIER SQUOTE COMMA ifelse_compare_valu=
e COMMA TICK interface_stmts SQUOTE
> +    '''
> +    x =3D refpolicy.IfElse(p[2])
> +    collect(p[8], x, val=3DTrue)
> +    p[0] =3D [x]
> +
> +def p_ifelse_sections(p):
> +    '''ifelse_sections : ifelse_sections COMMA ifelse_section
> +                       | ifelse_section
> +    '''
> +    if len(p) =3D=3D 4:
> +        p[0] =3D p[1] + p[3]
> +    else:
> +        p[0] =3D p[1]
>
> +def p_ifelse(p):
> +    '''ifelse : IFELSE OPAREN ifelse_sections COMMA TICK interface_stmts=
 SQUOTE CPAREN optional_semi
> +    '''
> +    x =3D refpolicy.IfElse(p[3])
> +    collect(p[3], x, val=3DTrue)
> +    collect(p[6], x, val=3DFalse)
> +    p[0] =3D [x]
>
>  def p_ifdef(p):
>      '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK statements=
 SQUOTE CPAREN optional_semi
> @@ -460,6 +482,7 @@ def p_interface_call(p):
>  def p_interface_call_param(p):
>      '''interface_call_param : IDENTIFIER
>                              | IDENTIFIER MINUS IDENTIFIER
> +                            | MINUS IDENTIFIER
>                              | nested_id_set
>                              | TRUE
>                              | FALSE
> @@ -469,6 +492,8 @@ def p_interface_call_param(p):
>      # List means set, non-list identifier
>      if len(p) =3D=3D 2:
>          p[0] =3D p[1]
> +    elif len(p) =3D=3D 3:
> +        p[0] =3D "-" + p[2]
>      else:
>          p[0] =3D [p[1], "-" + p[3]]
>
> @@ -558,6 +583,8 @@ def p_requires(p):
>                  | requires require
>                  | ifdef
>                  | requires ifdef
> +                | ifelse
> +                | requires ifelse
>      '''
>      pass
>
> @@ -609,12 +636,17 @@ def p_initial_sid(p):
>      p[0] =3D s
>
>  def p_genfscon(p):
> -    '''genfscon : GENFSCON IDENTIFIER PATH context'''
> -
> +    '''genfscon : GENFSCON IDENTIFIER PATH context
> +                | GENFSCON IDENTIFIER PATH MINUS IDENTIFIER context
> +                | GENFSCON IDENTIFIER PATH MINUS MINUS context
> +    '''
>      g =3D refpolicy.GenfsCon()
>      g.filesystem =3D p[2]
>      g.path =3D p[3]
> -    g.context =3D p[4]
> +    if len(p) =3D=3D 5:
> +        g.context =3D p[4]
> +    else:
> +        g.context =3D p[6]
>
>      p[0] =3D g
>
> @@ -848,11 +880,19 @@ def p_bool(p):
>      p[0] =3D b
>
>  def p_gen_tunable(p):
> -    '''gen_tunable : GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA TRU=
E CPAREN
> +    '''gen_tunable : GEN_TUNABLE OPAREN IDENTIFIER COMMA TRUE CPAREN
> +                   | GEN_TUNABLE OPAREN IDENTIFIER COMMA FALSE CPAREN
> +                   | GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA TRU=
E CPAREN
>                     | GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA FAL=
SE CPAREN'''
>      b =3D refpolicy.Bool()
> -    b.name =3D p[4]
> -    if p[7] =3D=3D "true":
> +    if len(p) =3D=3D 7:
> +        id_pos =3D 3
> +        state_pos =3D 5
> +    else:
> +        id_pos =3D 4
> +        state_pos =3D 7
> +    b.name =3D p[id_pos]
> +    if p[state_pos] =3D=3D "true":
>          b.state =3D True
>      else:
>          b.state =3D False
> diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolgen/=
src/sepolgen/refpolicy.py
> index 9cac1b95..f139dde4 100644
> --- a/python/sepolgen/src/sepolgen/refpolicy.py
> +++ b/python/sepolgen/src/sepolgen/refpolicy.py
> @@ -899,6 +899,14 @@ class IfDef(Node):
>      def to_string(self):
>          return "[Ifdef name: %s]" % self.name
>
> +class IfElse(Node):
> +    def __init__(self, name=3D"", parent=3DNone):
> +        Node.__init__(self, parent)
> +        self.name =3D name
> +
> +    def to_string(self):
> +        return "[Ifelse name: %s]" % self.name
> +
>  class InterfaceCall(Leaf):
>      def __init__(self, ifname=3D"", parent=3DNone):
>          Leaf.__init__(self, parent)
> --
> 2.43.0
>
>
