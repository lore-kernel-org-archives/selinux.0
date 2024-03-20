Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7BD6BFBA
	for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965069; cv=none; b=GVcabdg3LhbSPLUdyXsJW6rl/0noospfyXjw9SpOg1WtJAvsr/egrNuYKSanlH0NFFrNtadtbHt/2/O0SjGsMfy2ARpsacG/XI0zfXfvuM7sahTmvH8b5oBag0mINGL9e3Zqy4txpq15c4YiCFzNIJI2u6gX5TJCQrY/miLkLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965069; c=relaxed/simple;
	bh=FqAZLwHIFGhdP+HM+mbfB2nQfOFYlJqWq9+/XnWV08Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9EIW5V7kBQUI1+IFLjNXw7l7QD4Ux4mgQbgE2kiCgcqWL7e/1pEtBiDVkLATQSycMpSmho2V8bM3QThjube1Wgt3TDX98sNCu/6Rnn06b93cyN2Bbzzth/kA3wC1eAHvncCwpilqvgmWMB4T1T1rg74q2pYDJpJElICix4kMb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dun+scwX; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dun+scwX"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c387e02f23so181665b6e.3
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 13:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710965066; x=1711569866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1figXGarvFqPqPU6WPJsqkeuPfWHVHGKvYrFbP7NX2w=;
        b=dun+scwX4WKvIk5ybKyCPLuVFeiu5B2/tAf7y3PdJHLP0flrDfl90BYkmBLtOtUUAl
         8ps5uCZ9DfxfPRJpwI14O8uhGJ0FasyihEJzI+pE0kl2X0lWgPb7nrdwgrHsVOJsIfAJ
         Xfi3xSAS+N0nBVWGFvpqPH+7TTyk4HGNpKG50t5A47lfBpf61XjiR3Z9E6/U3NT/NMvb
         6CYgEKCbJQGHdSzgGY0CfYjMl78LofDi/eYcksMZyH2jCv02yv6Wkwb7yH9s0l/CjmYU
         AO7Tix5saBPTbgME8VjEE/jwuzPXTKRP3mV4O4/ty5XGa5+2JHJWlozVd9CUFxQAOotZ
         Msig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965066; x=1711569866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1figXGarvFqPqPU6WPJsqkeuPfWHVHGKvYrFbP7NX2w=;
        b=W17gq4EGVe7VEPfbb4BhPjcGxv4nc0hqD7mI8/B4wep9vAdO5EqCJGWv/5Fs1yDIlq
         zsbCHjlcewWlf9JIR1X07JJ0VfeSbCYl8rnG2RuDdh63sjCTpvHKlg6bUg233FWr6GHp
         znY2Z/jfw7YZ8bt2IRfAldlUEJCpKW3c4FrOXAoklDYxZxcvVjPrx+PX1+XQoyBOlO1I
         f4UJwz2QXwogMkckJ+pKD3/lZFkuzAIVbF/IfwcEdoCf1Q+AoPTh/r2Eakj+m/ZowQ3d
         ajEAboQexuyer1mDh1b+22N1agoWjWWyTZHn7/EAYwg5VxMDGHw9eB8hWIxm1CcLtuBB
         bWAw==
X-Gm-Message-State: AOJu0Yzr0NYHnxh41FRCc05zkk0Ewxd9YgDepaf6pF3Yd9gNfWbkInwm
	vrr3Y/430NcTInw3JY2bTT6DOcrZvV+bbGxBRYTD2Fs8E+BfaeZTkBTZ8YROPOqT8aCyObMo3G/
	rSRMiS7m+cX6j0mtG9N+9aYMPpe4=
X-Google-Smtp-Source: AGHT+IFRYqOBlXHwA7nxjLuPRxhNK0J29/4mndKNfrhE9oZim0HrQh/DiB4wm5S2sUVw+lz/PndkQYl10A80gR2rc/M=
X-Received: by 2002:a05:6808:bcd:b0:3c3:7e7a:8236 with SMTP id
 o13-20020a0568080bcd00b003c37e7a8236mr3488805oik.18.1710965066286; Wed, 20
 Mar 2024 13:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222193117.17539-1-cgzones@googlemail.com> <CAP+JOzQriUQ-mzJRCmCfApriJ_VQqOp26VE4z0krs8K1S59RBw@mail.gmail.com>
In-Reply-To: <CAP+JOzQriUQ-mzJRCmCfApriJ_VQqOp26VE4z0krs8K1S59RBw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 Mar 2024 16:04:15 -0400
Message-ID: <CAP+JOzT8PPGNZqJNZdr708UsCZBJOkyx2i47_MVwAazP9sksVg@mail.gmail.com>
Subject: Re: [PATCH] sepolgen: adjust parse for refpolicy
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 2:01=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Feb 22, 2024 at 2:31=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Currently sepolgen fails to parse the reference policy:
> >
> >     Parsing interface files:
> >     %--10---20---30---40---50---60---70---80---90--100
> >     #############/tmp/destdir/usr/share/selinux/refpolicy/include/kerne=
l/kernel.if: Syntax error on line 1737 - [type=3DMINUS]
> >     /tmp/destdir/usr/share/selinux/refpolicy/include/kernel/kernel.if: =
Syntax error on line 1755 - [type=3DMINUS]
> >     error parsing file /tmp/destdir/usr/share/selinux/refpolicy/include=
/kernel/kernel.if: could not parse text: "/tmp/destdir/usr/share/selinux/re=
fpolicy/include/kernel/kernel.if: Syntax error on line 1755 - [type=3DMINUS=
]"
> >     /tmp/destdir/usr/share/selinux/refpolicy/include/kernel/selinux.if:=
 Syntax error on line 43 - [type=3DMINUS]
> >     error parsing file /tmp/destdir/usr/share/selinux/refpolicy/include=
/kernel/selinux.if: could not parse text: "/tmp/destdir/usr/share/selinux/r=
efpolicy/include/kernel/selinux.if: Syntax error on line 43 - [type=3DMINUS=
]"
> >     ############################/tmp/destdir/usr/share/selinux/refpolic=
y/include/services/ssh.if: Syntax error on line 183 $1_port_forwarding [typ=
e=3DIDENTIFIER]
> >     /tmp/destdir/usr/share/selinux/refpolicy/include/services/ssh.if: S=
yntax error on line 293 ' [type=3DSQUOTE]
> >     error parsing file /tmp/destdir/usr/share/selinux/refpolicy/include=
/services/ssh.if: could not parse text: "/tmp/destdir/usr/share/selinux/ref=
policy/include/services/ssh.if: Syntax error on line 293 ' [type=3DSQUOTE]"
> >     ######/tmp/destdir/usr/share/selinux/refpolicy/include/system/init.=
if: Syntax error on line 2137 true [type=3DTRUE]
> >     /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: Sy=
ntax error on line 2148 ' [type=3DSQUOTE]
> >     /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: Sy=
ntax error on line 2152 ' [type=3DSQUOTE]
> >     /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: Sy=
ntax error on line 2163 ' [type=3DSQUOTE]
> >     /tmp/destdir/usr/share/selinux/refpolicy/include/system/init.if: Sy=
ntax error on line 2167 ' [type=3DSQUOTE]
> >     error parsing file /tmp/destdir/usr/share/selinux/refpolicy/include=
/system/init.if: could not parse text: "/tmp/destdir/usr/share/selinux/refp=
olicy/include/system/init.if: Syntax error on line 2167 ' [type=3DSQUOTE]"
> >     ##failed to parse some headers: /tmp/destdir/usr/share/selinux/refp=
olicy/include/kernel/kernel.if, /tmp/destdir/usr/share/selinux/refpolicy/in=
clude/kernel/selinux.if, /tmp/destdir/usr/share/selinux/refpolicy/include/s=
ervices/ssh.if, /tmp/destdir/usr/share/selinux/refpolicy/include/system/ini=
t.if
> >     Missing interface definition for init_startstop_service
> >     Missing interface definition for init_startstop_service
> >     ...
> >
> > Accept chained ifelse blocks, genfscon statements with file specifiers,
> > and booleans with unquoted identifiers.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  python/sepolgen/src/sepolgen/refparser.py | 74 +++++++++++++++++------
> >  python/sepolgen/src/sepolgen/refpolicy.py |  8 +++
> >  2 files changed, 65 insertions(+), 17 deletions(-)
> >
> > diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolge=
n/src/sepolgen/refparser.py
> > index 1bb90564..e261d3f7 100644
> > --- a/python/sepolgen/src/sepolgen/refparser.py
> > +++ b/python/sepolgen/src/sepolgen/refparser.py
> > @@ -418,19 +418,41 @@ def p_tunable_policy(p):
> >          collect(p[12], x, val=3DFalse)
> >      p[0] =3D [x]
> >
> > -def p_ifelse(p):
> > -    '''ifelse : IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA COMMA TICK =
IDENTIFIER SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN optional_semi
> > -              | IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK IDENTI=
FIER SQUOTE COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQ=
UOTE CPAREN optional_semi
> > -              | IFELSE OPAREN TICK IDENTIFIER SQUOTE COMMA TICK SQUOTE=
 COMMA TICK interface_stmts SQUOTE COMMA TICK interface_stmts SQUOTE CPAREN=
 optional_semi
> > +def p_ifelse_compare_value(p):
> > +    '''ifelse_compare_value : TICK IDENTIFIER SQUOTE
> > +                            | TICK TRUE       SQUOTE
> > +                            | TICK FALSE      SQUOTE
> > +                            | TICK            SQUOTE
> > +                            | empty
> >      '''
> > -#    x =3D refpolicy.IfDef(p[4])
> > -#    v =3D True
> > -#    collect(p[8], x, val=3Dv)
> > -#    if len(p) > 12:
> > -#        collect(p[12], x, val=3DFalse)
> > -#    p[0] =3D [x]
> > -    pass
> > +    if len(p) =3D=3D 4:
> > +        p[0] =3D p[2]
> > +    else:
> > +        p[0] =3D None
> > +
> > +def p_ifelse_section(p):
> > +    '''ifelse_section : TICK IDENTIFIER SQUOTE COMMA ifelse_compare_va=
lue COMMA TICK interface_stmts SQUOTE
> > +    '''
> > +    x =3D refpolicy.IfElse(p[2])
> > +    collect(p[8], x, val=3DTrue)
> > +    p[0] =3D [x]
> > +
> > +def p_ifelse_sections(p):
> > +    '''ifelse_sections : ifelse_sections COMMA ifelse_section
> > +                       | ifelse_section
> > +    '''
> > +    if len(p) =3D=3D 4:
> > +        p[0] =3D p[1] + p[3]
> > +    else:
> > +        p[0] =3D p[1]
> >
> > +def p_ifelse(p):
> > +    '''ifelse : IFELSE OPAREN ifelse_sections COMMA TICK interface_stm=
ts SQUOTE CPAREN optional_semi
> > +    '''
> > +    x =3D refpolicy.IfElse(p[3])
> > +    collect(p[3], x, val=3DTrue)
> > +    collect(p[6], x, val=3DFalse)
> > +    p[0] =3D [x]
> >
> >  def p_ifdef(p):
> >      '''ifdef : IFDEF OPAREN TICK IDENTIFIER SQUOTE COMMA TICK statemen=
ts SQUOTE CPAREN optional_semi
> > @@ -460,6 +482,7 @@ def p_interface_call(p):
> >  def p_interface_call_param(p):
> >      '''interface_call_param : IDENTIFIER
> >                              | IDENTIFIER MINUS IDENTIFIER
> > +                            | MINUS IDENTIFIER
> >                              | nested_id_set
> >                              | TRUE
> >                              | FALSE
> > @@ -469,6 +492,8 @@ def p_interface_call_param(p):
> >      # List means set, non-list identifier
> >      if len(p) =3D=3D 2:
> >          p[0] =3D p[1]
> > +    elif len(p) =3D=3D 3:
> > +        p[0] =3D "-" + p[2]
> >      else:
> >          p[0] =3D [p[1], "-" + p[3]]
> >
> > @@ -558,6 +583,8 @@ def p_requires(p):
> >                  | requires require
> >                  | ifdef
> >                  | requires ifdef
> > +                | ifelse
> > +                | requires ifelse
> >      '''
> >      pass
> >
> > @@ -609,12 +636,17 @@ def p_initial_sid(p):
> >      p[0] =3D s
> >
> >  def p_genfscon(p):
> > -    '''genfscon : GENFSCON IDENTIFIER PATH context'''
> > -
> > +    '''genfscon : GENFSCON IDENTIFIER PATH context
> > +                | GENFSCON IDENTIFIER PATH MINUS IDENTIFIER context
> > +                | GENFSCON IDENTIFIER PATH MINUS MINUS context
> > +    '''
> >      g =3D refpolicy.GenfsCon()
> >      g.filesystem =3D p[2]
> >      g.path =3D p[3]
> > -    g.context =3D p[4]
> > +    if len(p) =3D=3D 5:
> > +        g.context =3D p[4]
> > +    else:
> > +        g.context =3D p[6]
> >
> >      p[0] =3D g
> >
> > @@ -848,11 +880,19 @@ def p_bool(p):
> >      p[0] =3D b
> >
> >  def p_gen_tunable(p):
> > -    '''gen_tunable : GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA T=
RUE CPAREN
> > +    '''gen_tunable : GEN_TUNABLE OPAREN IDENTIFIER COMMA TRUE CPAREN
> > +                   | GEN_TUNABLE OPAREN IDENTIFIER COMMA FALSE CPAREN
> > +                   | GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA T=
RUE CPAREN
> >                     | GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA F=
ALSE CPAREN'''
> >      b =3D refpolicy.Bool()
> > -    b.name =3D p[4]
> > -    if p[7] =3D=3D "true":
> > +    if len(p) =3D=3D 7:
> > +        id_pos =3D 3
> > +        state_pos =3D 5
> > +    else:
> > +        id_pos =3D 4
> > +        state_pos =3D 7
> > +    b.name =3D p[id_pos]
> > +    if p[state_pos] =3D=3D "true":
> >          b.state =3D True
> >      else:
> >          b.state =3D False
> > diff --git a/python/sepolgen/src/sepolgen/refpolicy.py b/python/sepolge=
n/src/sepolgen/refpolicy.py
> > index 9cac1b95..f139dde4 100644
> > --- a/python/sepolgen/src/sepolgen/refpolicy.py
> > +++ b/python/sepolgen/src/sepolgen/refpolicy.py
> > @@ -899,6 +899,14 @@ class IfDef(Node):
> >      def to_string(self):
> >          return "[Ifdef name: %s]" % self.name
> >
> > +class IfElse(Node):
> > +    def __init__(self, name=3D"", parent=3DNone):
> > +        Node.__init__(self, parent)
> > +        self.name =3D name
> > +
> > +    def to_string(self):
> > +        return "[Ifelse name: %s]" % self.name
> > +
> >  class InterfaceCall(Leaf):
> >      def __init__(self, ifname=3D"", parent=3DNone):
> >          Leaf.__init__(self, parent)
> > --
> > 2.43.0
> >
> >
