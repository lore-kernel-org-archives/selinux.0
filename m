Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD59C2905
	for <selinux@vger.kernel.org>; Wed,  8 Jan 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353761; cv=none; b=lb15fJAfNXxyBDcGhu6xZ83kDeWdh9flLYlA54cpDrrBZzNDPaCFSS9sqH0f1WjlRz47nkR81NaI3GwfvVV6FTTXkckmSgt2NVup7zeVENDbve/7+xI/nZxZzuqL4vUbiuo2ziPaMMKAe6c1rgSBLddO5mWdA25HRIcUbm8R6JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353761; c=relaxed/simple;
	bh=hUwjKO5IJvXI20o300/KHs012/HovAz/eW9RChXQCvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=COSxkJnQLg5yTcJklAMwPN+2LWAbfcjNOXUIbddS3pYt2KgoPU/e5tKt8zN6ZrjX6zKojXoj+1zosqf0AEyjjTu8FePKhHhGa2xSunUYsvP+/Lgq2MMw7vhIh7gzyg0TT4j+nBlmGBaOm8L6ta75QgmRIuknGfuOPWXLGJVZc7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNS7+coU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNS7+coU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736353758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Axn/AftznvRKodOm0jayetydL+bzpp9wnCKsr7KSew8=;
	b=KNS7+coUh58S1SVYl3cDbHufv7N9YTbzzMkEkQqs0mRmOrdk0l8uknl95Ph/tK3Uu9xRE3
	PYUUC899FBeOuGJNkRw1IDZlucenPc1Miuuq5aAbOcl7hMWj34XEEybzynSmujBQVmTZ7S
	ls1ENw2Gz6Xh1W5hf/Q8EyV2u4NPnWo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-3PWZbKK6MJa0cUnu60nDnA-1; Wed,
 08 Jan 2025 11:29:16 -0500
X-MC-Unique: 3PWZbKK6MJa0cUnu60nDnA-1
X-Mimecast-MFC-AGG-ID: 3PWZbKK6MJa0cUnu60nDnA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 749BF19560B7;
	Wed,  8 Jan 2025 16:29:15 +0000 (UTC)
Received: from localhost (unknown [10.45.224.210])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D48B31956054;
	Wed,  8 Jan 2025 16:29:14 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 selinux@vger.kernel.org
Cc: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH] semanage: improve -e documentation and fix delete
 operation
In-Reply-To: <20241230135033.41492-1-cgoettsche@seltendoof.de>
References: <20241230135033.41492-1-cgoettsche@seltendoof.de>
Date: Wed, 08 Jan 2025 17:29:13 +0100
Message-ID: <87y0zlxo9y.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Christian G=C3=B6ttsche <cgoettsche@seltendoof.de> writes:

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Improve the documentation around the -e/--equal option for semanage
> fcontext.
>
> Add support for entry deletion.
>
> Closes: https://github.com/SELinuxProject/selinux/issues/457
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  python/semanage/semanage            | 15 ++++++++-------
>  python/semanage/semanage-fcontext.8 |  6 +++---
>  python/semanage/seobject.py         | 13 +++++++++++++
>  3 files changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index b269b9fc..ec6fa2dd 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -54,7 +54,7 @@ usage_login =3D "semanage login [-h] [-n] [-N] [-S STOR=
E] ["
>  usage_login_dict =3D {' --add': ('-s SEUSER', '-r RANGE', 'LOGIN',), ' -=
-modify': ('-s SEUSER', '-r RANGE', 'LOGIN',), ' --delete': ('LOGIN',), ' -=
-list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
>=20=20
>  usage_fcontext =3D "semanage fcontext [-h] [-n] [-N] [-S STORE] ["
> -usage_fcontext_dict =3D {' --add': ('(', '-t TYPE', '-f FTYPE', '-r RANG=
E', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --delete': ('(', '-=
t TYPE', '-f FTYPE', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --modify': ('('=
, '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', 'FI=
LE_SPEC',), ' --list': ('[-C]',), ' --extract': ('',), ' --deleteall': ('',=
)}
> +usage_fcontext_dict =3D {' --add': ('(', '-t TYPE', '-f FTYPE', '-r RANG=
E', '-s SEUSER', '|', '-e TARGET_PATH', ')', 'FILE_SPEC',), ' --delete': ('=
(', '-t TYPE', '-f FTYPE', '|', '-e TARGET_PATH', ')', 'FILE_SPEC',), ' --m=
odify': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e TARG=
ET_PATH', ')', 'FILE_SPEC',), ' --list': ('[-C]',), ' --extract': ('',), ' =
--deleteall': ('',)}
>=20=20
>  usage_user =3D "semanage user [-h] [-n] [-N] [-S STORE] ["
>  usage_user_dict =3D {' --add': ('(', '-L LEVEL', '-R ROLES', '-r RANGE',=
 'SEUSER', ')'), ' --delete': ('SEUSER',), ' --modify': ('(', '-L LEVEL', '=
-R ROLES', '-r RANGE', '-s SEUSER', 'SEUSER', ')'), ' --list': ('-C',), ' -=
-extract': ('',), ' --deleteall': ('',)}
> @@ -306,7 +306,7 @@ def setupLoginParser(subparsers):
>  def handleFcontext(args):
>      fcontext_args =3D {'list': [('equal', 'ftype', 'seuser', 'type'), ('=
')], 'add': [('locallist'), ('type', 'file_spec')], 'modify': [('locallist'=
), ('type', 'file_spec')], 'delete': [('locallist'), ('file_spec')], 'extra=
ct': [('locallist', 'equal', 'ftype', 'seuser', 'type'), ('')], 'deleteall'=
: [('locallist'), ('')]}
>      # we can not use mutually for equal because we can define some actio=
ns together with equal
> -    fcontext_equal_args =3D {'equal': [('list', 'locallist', 'type', 'ft=
ype', 'seuser', 'deleteall', 'extract'), ()]}
> +    fcontext_equal_args =3D {'equal': [('list', 'locallist', 'type', 'ft=
ype', 'seuser', 'deleteall', 'extract'), ('file_spec')]}
>=20=20
>      if args.action and args.equal:
>          handle_opts(args, fcontext_equal_args, "equal")
> @@ -327,7 +327,7 @@ def handleFcontext(args):
>              OBJECT.modify(args.file_spec, args.type, args.ftype, args.ra=
nge, args.seuser)
>      if args.action =3D=3D "delete":
>          if args.equal:
> -            OBJECT.delete(args.file_spec, args.equal)
> +            OBJECT.delete_equal(args.file_spec, args.equal)
>          else:
>              OBJECT.delete(args.file_spec, args.ftype)
>      if args.action =3D=3D "list":
> @@ -355,9 +355,10 @@ def setupFcontextParser(subparsers):
>      parser_add_extract(fcontext_action, "fcontext")
>      parser_add_deleteall(fcontext_action, "fcontext")
>=20=20
> -    fcontextParser.add_argument('-e', '--equal', help=3D_(
> -        'Substitute target path with sourcepath when generating default =
label. This is used with fcontext. Requires source and target \
> -path arguments. The context labeling for the target subtree is made equi=
valent to that defined for the source.'
> +    fcontextParser.add_argument('-e', '--equal', metavar=3D'TARGET_PATH'=
 help=3D_(
> +        'Substitute FILE_SPEC with TARGET_PATH for file label lookup. Th=
is is used with fcontext. Requires source and target \
> +path arguments to be path prefixes and does not support regular expressi=
ons. \
> +The context labeling for the target subtree is made equivalent to that d=
efined for the source.'
>      ))
>      fcontextParser.add_argument('-f', '--ftype', default=3D"", choices=
=3D["a", "f", "d", "c", "b", "s", "l", "p"], help=3D_(
>          'File Type. This is used with fcontext. Requires a file type as =
shown in the mode field by ls, e.g. use d to match only \
> @@ -368,7 +369,7 @@ If you do not specify a file type, the file type will=
 default to "all files".'
>      parser_add_seuser(fcontextParser, "fcontext")
>      parser_add_type(fcontextParser, "fcontext")
>      parser_add_range(fcontextParser, "fcontext")
> -    fcontextParser.add_argument('file_spec', nargs=3D'?', default=3DNone=
, help=3D_('Path to be labeled (may be in the form of a Perl compatible reg=
ular expression)'))
> +    fcontextParser.add_argument('file_spec', nargs=3D'?', default=3DNone=
, metavar=3D'FILE_SPEC', help=3D_('Path to be labeled (may be in the form o=
f a Perl compatible regular expression)'))
>      fcontextParser.set_defaults(func=3DhandleFcontext)
>=20=20
>=20=20
> diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semana=
ge-fcontext.8
> index 3e327d88..3a96c62f 100644
> --- a/python/semanage/semanage-fcontext.8
> +++ b/python/semanage/semanage-fcontext.8
> @@ -3,7 +3,7 @@
>  semanage\-fcontext \- SELinux Policy Management file context tool
>=20=20
>  .SH "SYNOPSIS"
> -.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYPE =
\-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC | \-\-delete ( \-t T=
YPE \-f FTYPE | \-e EQUAL ) FILE_SPEC | \-\-deleteall  | \-\-extract  | \-\=
-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e EQ=
UAL ) FILE_SPEC ]
> +.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYPE =
\-f FTYPE \-r RANGE \-s SEUSER | \-e TARGET_PATH ) FILE_SPEC | \-\-delete (=
 \-t TYPE \-f FTYPE | \-e TARGET_PATH ) FILE_SPEC | \-\-deleteall  | \-\-ex=
tract  | \-\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEU=
SER | \-e TARGET_PATH ) FILE_SPEC ]
>=20=20
>  .SH "DESCRIPTION"
>  semanage is used to configure certain elements of
> @@ -66,8 +66,8 @@ Extract customizable commands, for use within a transac=
tion
>  .I   \-D, \-\-deleteall
>  Remove all local customizations
>  .TP
> -.I   \-e EQUAL, \-\-equal EQUAL
> -Substitute target path with sourcepath when generating default label. Th=
is is used with fcontext. Requires source and target path arguments. The co=
ntext labeling for the target subtree is made equivalent to that defined fo=
r the source.
> +.I   \-e TARGET_PATH, \-\-equal TARGET_PATH
> +Substitute FILE_SPEC with TARGET_PATH for file label lookup. This is use=
d with fcontext. Requires source and target path arguments to be path prefi=
xes and does not support regular expressions. The context labeling for the =
target subtree is made equivalent to that defined for the source.
>  .TP
>  .I   \-f [{a,f,d,c,b,s,l,p}], \-\-ftype [{a,f,d,c,b,s,l,p}]
>  File Type. This is used with fcontext. Requires a file type as shown in =
the mode field by ls, e.g. use 'd' to match only directories or 'f' to matc=
h only regular files. The following file type options can be passed: f (reg=
ular file),d (directory),c (character device), b (block device),s (socket),=
l (symbolic link),p (named pipe).  If you do not specify a file type, the f=
ile type will default to "all files".
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 10963e81..854381d4 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -2453,6 +2453,19 @@ class fcontextRecords(semanageRecords):
>=20=20
>          self.commit()
>=20=20
> +    def delete_equal(self, target, substitute):
> +        self.begin()
> +        if target not in self.equiv.keys():
> +            raise ValueError(_("Equivalence class for %s does not exist"=
) % target)
> +        if substitute !=3D self.equiv[target]:
> +            raise ValueError(_("Equivalence class for %s does not match =
%s but %s") % (target, substitute, self.equiv[target]))
> +        del self.equiv[target]
> +        self.equal_ind =3D True
> +
> +        self.mylog.log_change("resrc=3Dfcontext op=3Ddelete-equal %s %s"=
 % (audit.audit_encode_nv_string("sglob", target, 0), audit.audit_encode_nv=
_string("tglob", substitute, 0)))
> +
> +        self.commit()
> +

Why is this necessary?

It seems to work in current version:

[root@localhost ~]# semanage fcontext -a -e /home /domov
[root@localhost ~]# semanage fcontext -l | grep domov
/domov =3D /home
[root@localhost ~]# semanage fcontext -d -e /home /domov
[root@localhost ~]# semanage fcontext -l | grep domov
[root@localhost ~]#



>      def createcon(self, target, seuser=3D"system_u"):
>          (rc, con) =3D semanage_context_create(self.sh)
>          if rc < 0:
> --=20
> 2.45.2

