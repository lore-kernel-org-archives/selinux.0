Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9481A3155
	for <selinux@vger.kernel.org>; Wed, 14 May 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747217081; cv=none; b=r5q7yWQoEaAo7s8QoLcIRWoXyWfDS8geYNqxML44xhrwonMcR5bCcF4dEMrtri1BI1GWF8+q9nKK8yS4M8PoqmCKDVoo0k88XIcFg0+NTxuqEllKunncqXnDPQH6393ia8jrmcuYTAi/cv5CIsoDQ1xHvh/TuM9N7TJjX9NYZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747217081; c=relaxed/simple;
	bh=w+AFaSY3wT8nsGn5c14XynLo7iHC6+w2EjE7jw/HLlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G5PIpt+fJEgUMKuW+I7kVchrLk8/Crybb3OwERY/jCx49OoiyLq5fcmqdJeQJfzqg7pSlv6q6iJIomdP2KumAKCfx+ECT9y3NBSqJ92XgZIhdZ7FSTF+56iVe28/sFKG06fhQfxqGEy3FWqgkO2uVc7vcUKPQRYKQggf9mnN8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eL3rL7rN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eL3rL7rN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747217077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dl2ado8xAXYeC92iyZvkO6n6i0gTfFbBVukji5OqW0M=;
	b=eL3rL7rNGwHaLjXiXMHYYwB9D0qdpn0oIjVJ3Ks9lqtPe1oAEnJ53YExJMjVAO12UsoVE9
	/GeHACMY2aCPpgI/JvPaE0n+09LEaPDucefs12vuvbdxY+a1ei/fzgsx8UdX5PbBRB7iHb
	wBab4z4/8KMrvkwad313dk9m/HoKEnM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-UD13HZfvMv6VrBzLReNZEA-1; Wed,
 14 May 2025 06:04:34 -0400
X-MC-Unique: UD13HZfvMv6VrBzLReNZEA-1
X-Mimecast-MFC-AGG-ID: UD13HZfvMv6VrBzLReNZEA_1747217073
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CC7B180048E;
	Wed, 14 May 2025 10:04:33 +0000 (UTC)
Received: from localhost (unknown [10.45.224.64])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBA73180035C;
	Wed, 14 May 2025 10:04:32 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 selinux@vger.kernel.org
Cc: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH v2] semanage: improve -e documentation and fix delete
 operation
In-Reply-To: <20250114155228.72450-1-cgoettsche@seltendoof.de>
References: <20250114155228.72450-1-cgoettsche@seltendoof.de>
Date: Wed, 14 May 2025 12:04:31 +0200
Message-ID: <87sel733v4.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Christian G=C3=B6ttsche <cgoettsche@seltendoof.de> writes:

> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Improve the documentation around the -e/--equal option for semanage
> fcontext.
>
> Closes: https://github.com/SELinuxProject/selinux/issues/457
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2: drop delete_equal() addition
> ---
>  python/semanage/semanage            | 13 +++++++------
>  python/semanage/semanage-fcontext.8 |  6 +++---
>  2 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index b269b9fc..dd5066bf 100644
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

# semanage fcontext -h
  File "/usr/sbin/semanage", line 358
    fcontextParser.add_argument('-e', '--equal', metavar=3D'TARGET_PATH' he=
lp=3D_(
                                                         ^^^^^^^^^^^^^^^^^^
SyntaxError: invalid syntax. Perhaps you forgot a comma?




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
> --=20
> 2.47.1

