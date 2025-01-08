Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9A1FF608
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355212; cv=none; b=HgFgP9oKuEHnxtQ8l4b6nSlENouHsTxXb2tbmEVtbL2lYZu03yzgO4RmZbfL9qGKrxQxbdQR8WI5EGRgQHae6UmyW9JIlTqCWX/vjvJrPro8vJb+zuCJdOWF//bpdQXSBiF12Zq80Po+EXCpk+BluRBJ4uo2u+e9M9LwYWfrCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355212; c=relaxed/simple;
	bh=96yB7Wczivxq2+IB3gL0t689+nQ8AighEfX9xNtgRdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTWWNSR20mxd+q6GvUHNvw/NRCVMxi/AQkdwVvUwk17L2viSVtx2Tx7V5aGbaOZK8dv+2UIgo1+vg7XJU5wpUaajKcWm7ul3+ueESdJgzpgYFqAYOwXoNxJNn7GeroIw7dmq1uoOHw440p4GGmTC73PNgSnGx5f3xONlBAstTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QtinMMQ0; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QtinMMQ0"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e4419a47887so21728050276.0
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2025 08:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736355209; x=1736960009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INYoDQ0ILuSXwsp31V+eRjv0ngd3Nzzm+GAtqryqFWA=;
        b=QtinMMQ0lVkffDlF6m5Z78OACKx7NNgPFhmQpqJp0yNMIvI2Mo8vI46oZ7JpGtiG+l
         0Au05teeGiY8Gy8L2pTvw8CcKbx4CxU5CdLBsZ14u0Ie8haQBBqMcZOIfUSICsu06A6Y
         BC5tWygY90+4fRZvAlxuQ4bEDsQCqFUq53VJg3PO1+hpsydYeDRusR/5Hd0kQHQItM9I
         6QNKH0buw810Rknc7N12QTMJO1JTjjV30BszcoTiNAjWw8BelJ5yaClu6uWQFdRUJ8c8
         iBlcCxOnIHctyeEXpEjUomBNwJgHqvMkJkAsl4XOnQuiCedvORQqjh4M/yZ5SJQ1mL3c
         Dpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736355209; x=1736960009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INYoDQ0ILuSXwsp31V+eRjv0ngd3Nzzm+GAtqryqFWA=;
        b=TlarhpP5c6iBMqoRIzwA2fUO2Oqr3hd96sPfl/qcRdbBnWSV0mbvzsUCPW/ShoMxZY
         zP0ZCb4nOlcWwSWqYqTkMu4Qmoxp/gcogQCf8CdnOgAreHONVVun6ymUST+5mpXET8dM
         XeOWQMbY2B6nhmleOkPHsoy0IpEO+dsmDxxfLpKhhora+8YljQT+oJrL8OhUp+svNSVX
         3nuzYum1/OxWHGyi7xTlMBC8p0PSSlVlg90960drPC2KxdMF47D/eUyLvYAR7eZJ1GmK
         JqNtv/nad8OMmoD4LbBSyIuJ/mrf151hXcQ2JXZEVpzNWqExJ7Gie5/wgwDipbv3Ffuy
         xRnA==
X-Forwarded-Encrypted: i=1; AJvYcCU7u3lNXXlREBHAxjpRD/7TwnN9w2J4BHvAeY3CGimLyPu1OdjEa9soVVJDVQnaq//Qn09ONVCi@vger.kernel.org
X-Gm-Message-State: AOJu0YzU314/ncaA1xOPZNyMnzcCM6g+cOFd1VEuzoM8wnN/4Had5rye
	5Bqd7/fko8+rsF/KPc/uCE2aWOK4lgrhCEiXyX+czmAIjtCN3uYmPgJaCs3PpQOfoNK5FSw8e54
	f816wbec5cSHYXk98FxncZjfA1K4=
X-Gm-Gg: ASbGncs+qNp9SWmNZA8GZadOEDUKsvom0h+fBsW6LPYsnG+wVE6sjJeNx2kO0+fC7/e
	9EyGoIswSUEyUBHY8VbqEgobfQ2N8k12NmuTb
X-Google-Smtp-Source: AGHT+IE+9RrkzFMfDGtTWRpyr37vte/is1IqdBp81tbWoJBEIovL/iciXSlQuVOGaEkWxaGz4DFUOAqlWD42QRDkgLY=
X-Received: by 2002:a05:690c:b91:b0:6ef:e390:1d4a with SMTP id
 00721157ae682-6f531216ce1mr22735197b3.11.1736355208991; Wed, 08 Jan 2025
 08:53:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230135033.41492-1-cgoettsche@seltendoof.de> <87y0zlxo9y.fsf@redhat.com>
In-Reply-To: <87y0zlxo9y.fsf@redhat.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 8 Jan 2025 17:53:18 +0100
X-Gm-Features: AbW1kvaLd6JwlMSbtI-4tcphEOekFV57mqNXkK4RNC0rhboKzSm6lDFbEypHBnI
Message-ID: <CAJ2a_DdpLiN_=BC6_dTfbpHsbdXSec=4YQQNnmwpAeVw=aGWzA@mail.gmail.com>
Subject: Re: [PATCH] semanage: improve -e documentation and fix delete operation
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2025 at 17:29, Petr Lautrbach <lautrbach@redhat.com> wrote:
>
> Christian G=C3=B6ttsche <cgoettsche@seltendoof.de> writes:
>
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Improve the documentation around the -e/--equal option for semanage
> > fcontext.
> >
> > Add support for entry deletion.
> >
> > Closes: https://github.com/SELinuxProject/selinux/issues/457
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  python/semanage/semanage            | 15 ++++++++-------
> >  python/semanage/semanage-fcontext.8 |  6 +++---
> >  python/semanage/seobject.py         | 13 +++++++++++++
> >  3 files changed, 24 insertions(+), 10 deletions(-)
> >
> > diff --git a/python/semanage/semanage b/python/semanage/semanage
> > index b269b9fc..ec6fa2dd 100644
> > --- a/python/semanage/semanage
> > +++ b/python/semanage/semanage
> > @@ -54,7 +54,7 @@ usage_login =3D "semanage login [-h] [-n] [-N] [-S ST=
ORE] ["
> >  usage_login_dict =3D {' --add': ('-s SEUSER', '-r RANGE', 'LOGIN',), '=
 --modify': ('-s SEUSER', '-r RANGE', 'LOGIN',), ' --delete': ('LOGIN',), '=
 --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
> >
> >  usage_fcontext =3D "semanage fcontext [-h] [-n] [-N] [-S STORE] ["
> > -usage_fcontext_dict =3D {' --add': ('(', '-t TYPE', '-f FTYPE', '-r RA=
NGE', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --delete': ('(', =
'-t TYPE', '-f FTYPE', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --modify': ('=
(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', '=
FILE_SPEC',), ' --list': ('[-C]',), ' --extract': ('',), ' --deleteall': ('=
',)}
> > +usage_fcontext_dict =3D {' --add': ('(', '-t TYPE', '-f FTYPE', '-r RA=
NGE', '-s SEUSER', '|', '-e TARGET_PATH', ')', 'FILE_SPEC',), ' --delete': =
('(', '-t TYPE', '-f FTYPE', '|', '-e TARGET_PATH', ')', 'FILE_SPEC',), ' -=
-modify': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e TA=
RGET_PATH', ')', 'FILE_SPEC',), ' --list': ('[-C]',), ' --extract': ('',), =
' --deleteall': ('',)}
> >
> >  usage_user =3D "semanage user [-h] [-n] [-N] [-S STORE] ["
> >  usage_user_dict =3D {' --add': ('(', '-L LEVEL', '-R ROLES', '-r RANGE=
', 'SEUSER', ')'), ' --delete': ('SEUSER',), ' --modify': ('(', '-L LEVEL',=
 '-R ROLES', '-r RANGE', '-s SEUSER', 'SEUSER', ')'), ' --list': ('-C',), '=
 --extract': ('',), ' --deleteall': ('',)}
> > @@ -306,7 +306,7 @@ def setupLoginParser(subparsers):
> >  def handleFcontext(args):
> >      fcontext_args =3D {'list': [('equal', 'ftype', 'seuser', 'type'), =
('')], 'add': [('locallist'), ('type', 'file_spec')], 'modify': [('locallis=
t'), ('type', 'file_spec')], 'delete': [('locallist'), ('file_spec')], 'ext=
ract': [('locallist', 'equal', 'ftype', 'seuser', 'type'), ('')], 'deleteal=
l': [('locallist'), ('')]}
> >      # we can not use mutually for equal because we can define some act=
ions together with equal
> > -    fcontext_equal_args =3D {'equal': [('list', 'locallist', 'type', '=
ftype', 'seuser', 'deleteall', 'extract'), ()]}
> > +    fcontext_equal_args =3D {'equal': [('list', 'locallist', 'type', '=
ftype', 'seuser', 'deleteall', 'extract'), ('file_spec')]}
> >
> >      if args.action and args.equal:
> >          handle_opts(args, fcontext_equal_args, "equal")
> > @@ -327,7 +327,7 @@ def handleFcontext(args):
> >              OBJECT.modify(args.file_spec, args.type, args.ftype, args.=
range, args.seuser)
> >      if args.action =3D=3D "delete":
> >          if args.equal:
> > -            OBJECT.delete(args.file_spec, args.equal)
> > +            OBJECT.delete_equal(args.file_spec, args.equal)
> >          else:
> >              OBJECT.delete(args.file_spec, args.ftype)
> >      if args.action =3D=3D "list":
> > @@ -355,9 +355,10 @@ def setupFcontextParser(subparsers):
> >      parser_add_extract(fcontext_action, "fcontext")
> >      parser_add_deleteall(fcontext_action, "fcontext")
> >
> > -    fcontextParser.add_argument('-e', '--equal', help=3D_(
> > -        'Substitute target path with sourcepath when generating defaul=
t label. This is used with fcontext. Requires source and target \
> > -path arguments. The context labeling for the target subtree is made eq=
uivalent to that defined for the source.'
> > +    fcontextParser.add_argument('-e', '--equal', metavar=3D'TARGET_PAT=
H' help=3D_(
> > +        'Substitute FILE_SPEC with TARGET_PATH for file label lookup. =
This is used with fcontext. Requires source and target \
> > +path arguments to be path prefixes and does not support regular expres=
sions. \
> > +The context labeling for the target subtree is made equivalent to that=
 defined for the source.'
> >      ))
> >      fcontextParser.add_argument('-f', '--ftype', default=3D"", choices=
=3D["a", "f", "d", "c", "b", "s", "l", "p"], help=3D_(
> >          'File Type. This is used with fcontext. Requires a file type a=
s shown in the mode field by ls, e.g. use d to match only \
> > @@ -368,7 +369,7 @@ If you do not specify a file type, the file type wi=
ll default to "all files".'
> >      parser_add_seuser(fcontextParser, "fcontext")
> >      parser_add_type(fcontextParser, "fcontext")
> >      parser_add_range(fcontextParser, "fcontext")
> > -    fcontextParser.add_argument('file_spec', nargs=3D'?', default=3DNo=
ne, help=3D_('Path to be labeled (may be in the form of a Perl compatible r=
egular expression)'))
> > +    fcontextParser.add_argument('file_spec', nargs=3D'?', default=3DNo=
ne, metavar=3D'FILE_SPEC', help=3D_('Path to be labeled (may be in the form=
 of a Perl compatible regular expression)'))
> >      fcontextParser.set_defaults(func=3DhandleFcontext)
> >
> >
> > diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/sema=
nage-fcontext.8
> > index 3e327d88..3a96c62f 100644
> > --- a/python/semanage/semanage-fcontext.8
> > +++ b/python/semanage/semanage-fcontext.8
> > @@ -3,7 +3,7 @@
> >  semanage\-fcontext \- SELinux Policy Management file context tool
> >
> >  .SH "SYNOPSIS"
> > -.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYP=
E \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC | \-\-delete ( \-t=
 TYPE \-f FTYPE | \-e EQUAL ) FILE_SPEC | \-\-deleteall  | \-\-extract  | \=
-\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e =
EQUAL ) FILE_SPEC ]
> > +.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYP=
E \-f FTYPE \-r RANGE \-s SEUSER | \-e TARGET_PATH ) FILE_SPEC | \-\-delete=
 ( \-t TYPE \-f FTYPE | \-e TARGET_PATH ) FILE_SPEC | \-\-deleteall  | \-\-=
extract  | \-\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s S=
EUSER | \-e TARGET_PATH ) FILE_SPEC ]
> >
> >  .SH "DESCRIPTION"
> >  semanage is used to configure certain elements of
> > @@ -66,8 +66,8 @@ Extract customizable commands, for use within a trans=
action
> >  .I   \-D, \-\-deleteall
> >  Remove all local customizations
> >  .TP
> > -.I   \-e EQUAL, \-\-equal EQUAL
> > -Substitute target path with sourcepath when generating default label. =
This is used with fcontext. Requires source and target path arguments. The =
context labeling for the target subtree is made equivalent to that defined =
for the source.
> > +.I   \-e TARGET_PATH, \-\-equal TARGET_PATH
> > +Substitute FILE_SPEC with TARGET_PATH for file label lookup. This is u=
sed with fcontext. Requires source and target path arguments to be path pre=
fixes and does not support regular expressions. The context labeling for th=
e target subtree is made equivalent to that defined for the source.
> >  .TP
> >  .I   \-f [{a,f,d,c,b,s,l,p}], \-\-ftype [{a,f,d,c,b,s,l,p}]
> >  File Type. This is used with fcontext. Requires a file type as shown i=
n the mode field by ls, e.g. use 'd' to match only directories or 'f' to ma=
tch only regular files. The following file type options can be passed: f (r=
egular file),d (directory),c (character device), b (block device),s (socket=
),l (symbolic link),p (named pipe).  If you do not specify a file type, the=
 file type will default to "all files".
> > diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> > index 10963e81..854381d4 100644
> > --- a/python/semanage/seobject.py
> > +++ b/python/semanage/seobject.py
> > @@ -2453,6 +2453,19 @@ class fcontextRecords(semanageRecords):
> >
> >          self.commit()
> >
> > +    def delete_equal(self, target, substitute):
> > +        self.begin()
> > +        if target not in self.equiv.keys():
> > +            raise ValueError(_("Equivalence class for %s does not exis=
t") % target)
> > +        if substitute !=3D self.equiv[target]:
> > +            raise ValueError(_("Equivalence class for %s does not matc=
h %s but %s") % (target, substitute, self.equiv[target]))
> > +        del self.equiv[target]
> > +        self.equal_ind =3D True
> > +
> > +        self.mylog.log_change("resrc=3Dfcontext op=3Ddelete-equal %s %=
s" % (audit.audit_encode_nv_string("sglob", target, 0), audit.audit_encode_=
nv_string("tglob", substitute, 0)))
> > +
> > +        self.commit()
> > +
>
> Why is this necessary?
>
> It seems to work in current version:
>
> [root@localhost ~]# semanage fcontext -a -e /home /domov
> [root@localhost ~]# semanage fcontext -l | grep domov
> /domov =3D /home
> [root@localhost ~]# semanage fcontext -d -e /home /domov
> [root@localhost ~]# semanage fcontext -l | grep domov
> [root@localhost ~]#

True, I somehow only tried `semanage fcontext -d -e /home`, which
fails with a spare error message of `KeyError: /home`.

> >      def createcon(self, target, seuser=3D"system_u"):
> >          (rc, con) =3D semanage_context_create(self.sh)
> >          if rc < 0:
> > --
> > 2.45.2
>
