Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028BC280317
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749541008; cv=none; b=CF934BPwmfKgYbrB9LdXJbNmLXfZnlqixYM6QuI+lTykrlspbaUsF9Wi2lrAm/UIHmFlouqAh72qSxRtlVQwTDhIZ8EQxHN/x+hOdwbm9+TuTU6mvWN9Y6Eo7RQV8uZRdG8ppYFEknkfkKwSuIiINPn9pZjVLg68qknNi/uoU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749541008; c=relaxed/simple;
	bh=HVg+jnCAPQSX3Q8mde+U8fzRAmQCUePD7KF++JalfXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OC10S31OfFvjEzFl5mp7ffhzGyf7OMMEmpq2v5i8uXC29oEv4GEBQp01Keo4zjXgcZKa8xIxNTnGqCCPF24le0uMEeGwR+D7cC3yjFxE/1eOdQh2LwNgXqnw+GSFrKyUV2YHo7DDbxWfsDUq+646b/SIiEKkpCnB++tuYM2PlqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DgeR8k2Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgeR8k2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749541004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azV7MDc2Ihi5hMLNsPLlNi04jm/obRV9L7FdEHTEf/M=;
	b=DgeR8k2ZDRtfuygkXAGkHa4wMTFLNrNpuGJ271CYV3DQlSV9Q1pEu+QGK2LTbcyOj3IwN8
	uo9XDPk8i3V+YY2jh8PKUqVntPMpWz7ff3lS5eSWBQt7gesqY1H3cNGycNcHBHOVmoB9fx
	fIE0zrB0l78iA1QsChQE7QfP7WppAzo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-6pZRD4WaNeWabXp1bzb-Uw-1; Tue,
 10 Jun 2025 03:36:43 -0400
X-MC-Unique: 6pZRD4WaNeWabXp1bzb-Uw-1
X-Mimecast-MFC-AGG-ID: 6pZRD4WaNeWabXp1bzb-Uw_1749541002
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D467180135B;
	Tue, 10 Jun 2025 07:36:42 +0000 (UTC)
Received: from localhost (unknown [10.44.32.151])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7E8B18003FC;
	Tue, 10 Jun 2025 07:36:41 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 selinux@vger.kernel.org
Cc: Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH v2] semanage: improve -e documentation and fix delete
 operation
In-Reply-To: <87sel733v4.fsf@redhat.com>
References: <20250114155228.72450-1-cgoettsche@seltendoof.de>
 <87sel733v4.fsf@redhat.com>
Date: Tue, 10 Jun 2025 09:36:40 +0200
Message-ID: <871prsf3p3.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Petr Lautrbach <lautrbach@redhat.com> writes:

> Christian G=C3=B6ttsche <cgoettsche@seltendoof.de> writes:
>
>> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>>
>> Improve the documentation around the -e/--equal option for semanage
>> fcontext.
>>
>> Closes: https://github.com/SELinuxProject/selinux/issues/457
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

Merged with the missing ','

Thanks.

>> ---
>> v2: drop delete_equal() addition
>> ---
>>  python/semanage/semanage            | 13 +++++++------
>>  python/semanage/semanage-fcontext.8 |  6 +++---
>>  2 files changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/python/semanage/semanage b/python/semanage/semanage
>> index b269b9fc..dd5066bf 100644
>> --- a/python/semanage/semanage
>> +++ b/python/semanage/semanage
>> @@ -54,7 +54,7 @@ usage_login =3D "semanage login [-h] [-n] [-N] [-S STO=
RE] ["
>>  usage_login_dict =3D {' --add': ('-s SEUSER', '-r RANGE', 'LOGIN',), ' =
--modify': ('-s SEUSER', '-r RANGE', 'LOGIN',), ' --delete': ('LOGIN',), ' =
--list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
>>=20=20
>>  usage_fcontext =3D "semanage fcontext [-h] [-n] [-N] [-S STORE] ["
>> -usage_fcontext_dict =3D {' --add': ('(', '-t TYPE', '-f FTYPE', '-r RAN=
GE', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --delete': ('(', '=
-t TYPE', '-f FTYPE', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --modify': ('(=
', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', 'F=
ILE_SPEC',), ' --list': ('[-C]',), ' --extract': ('',), ' --deleteall': (''=
,)}
>> +usage_fcontext_dict =3D {' --add': ('(', '-t TYPE', '-f FTYPE', '-r RAN=
GE', '-s SEUSER', '|', '-e TARGET_PATH', ')', 'FILE_SPEC',), ' --delete': (=
'(', '-t TYPE', '-f FTYPE', '|', '-e TARGET_PATH', ')', 'FILE_SPEC',), ' --=
modify': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e TAR=
GET_PATH', ')', 'FILE_SPEC',), ' --list': ('[-C]',), ' --extract': ('',), '=
 --deleteall': ('',)}
>>=20=20
>>  usage_user =3D "semanage user [-h] [-n] [-N] [-S STORE] ["
>>  usage_user_dict =3D {' --add': ('(', '-L LEVEL', '-R ROLES', '-r RANGE'=
, 'SEUSER', ')'), ' --delete': ('SEUSER',), ' --modify': ('(', '-L LEVEL', =
'-R ROLES', '-r RANGE', '-s SEUSER', 'SEUSER', ')'), ' --list': ('-C',), ' =
--extract': ('',), ' --deleteall': ('',)}
>> @@ -306,7 +306,7 @@ def setupLoginParser(subparsers):
>>  def handleFcontext(args):
>>      fcontext_args =3D {'list': [('equal', 'ftype', 'seuser', 'type'), (=
'')], 'add': [('locallist'), ('type', 'file_spec')], 'modify': [('locallist=
'), ('type', 'file_spec')], 'delete': [('locallist'), ('file_spec')], 'extr=
act': [('locallist', 'equal', 'ftype', 'seuser', 'type'), ('')], 'deleteall=
': [('locallist'), ('')]}
>>      # we can not use mutually for equal because we can define some acti=
ons together with equal
>> -    fcontext_equal_args =3D {'equal': [('list', 'locallist', 'type', 'f=
type', 'seuser', 'deleteall', 'extract'), ()]}
>> +    fcontext_equal_args =3D {'equal': [('list', 'locallist', 'type', 'f=
type', 'seuser', 'deleteall', 'extract'), ('file_spec')]}
>>=20=20
>>      if args.action and args.equal:
>>          handle_opts(args, fcontext_equal_args, "equal")
>> @@ -355,9 +355,10 @@ def setupFcontextParser(subparsers):
>>      parser_add_extract(fcontext_action, "fcontext")
>>      parser_add_deleteall(fcontext_action, "fcontext")
>>=20=20
>> -    fcontextParser.add_argument('-e', '--equal', help=3D_(
>> -        'Substitute target path with sourcepath when generating default=
 label. This is used with fcontext. Requires source and target \
>> -path arguments. The context labeling for the target subtree is made equ=
ivalent to that defined for the source.'
>> +    fcontextParser.add_argument('-e', '--equal', metavar=3D'TARGET_PATH=
' help=3D_(
>> +        'Substitute FILE_SPEC with TARGET_PATH for file label lookup. T=
his is used with fcontext. Requires source and target \
>> +path arguments to be path prefixes and does not support regular express=
ions. \
>> +The context labeling for the target subtree is made equivalent to that =
defined for the source.'
>>      ))
>>      fcontextParser.add_argument('-f', '--ftype', default=3D"", choices=
=3D["a", "f", "d", "c", "b", "s", "l", "p"], help=3D_(
>>          'File Type. This is used with fcontext. Requires a file type as=
 shown in the mode field by ls, e.g. use d to match only \
>
> # semanage fcontext -h
>   File "/usr/sbin/semanage", line 358
>     fcontextParser.add_argument('-e', '--equal', metavar=3D'TARGET_PATH' =
help=3D_(
>                                                          ^^^^^^^^^^^^^^^^=
^^
> SyntaxError: invalid syntax. Perhaps you forgot a comma?
>
>
>
>
>> @@ -368,7 +369,7 @@ If you do not specify a file type, the file type wil=
l default to "all files".'
>>      parser_add_seuser(fcontextParser, "fcontext")
>>      parser_add_type(fcontextParser, "fcontext")
>>      parser_add_range(fcontextParser, "fcontext")
>> -    fcontextParser.add_argument('file_spec', nargs=3D'?', default=3DNon=
e, help=3D_('Path to be labeled (may be in the form of a Perl compatible re=
gular expression)'))
>> +    fcontextParser.add_argument('file_spec', nargs=3D'?', default=3DNon=
e, metavar=3D'FILE_SPEC', help=3D_('Path to be labeled (may be in the form =
of a Perl compatible regular expression)'))
>>      fcontextParser.set_defaults(func=3DhandleFcontext)
>>=20=20
>>=20=20
>> diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/seman=
age-fcontext.8
>> index 3e327d88..3a96c62f 100644
>> --- a/python/semanage/semanage-fcontext.8
>> +++ b/python/semanage/semanage-fcontext.8
>> @@ -3,7 +3,7 @@
>>  semanage\-fcontext \- SELinux Policy Management file context tool
>>=20=20
>>  .SH "SYNOPSIS"
>> -.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYPE=
 \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC | \-\-delete ( \-t =
TYPE \-f FTYPE | \-e EQUAL ) FILE_SPEC | \-\-deleteall  | \-\-extract  | \-=
\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e E=
QUAL ) FILE_SPEC ]
>> +.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYPE=
 \-f FTYPE \-r RANGE \-s SEUSER | \-e TARGET_PATH ) FILE_SPEC | \-\-delete =
( \-t TYPE \-f FTYPE | \-e TARGET_PATH ) FILE_SPEC | \-\-deleteall  | \-\-e=
xtract  | \-\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SE=
USER | \-e TARGET_PATH ) FILE_SPEC ]
>>=20=20
>>  .SH "DESCRIPTION"
>>  semanage is used to configure certain elements of
>> @@ -66,8 +66,8 @@ Extract customizable commands, for use within a transa=
ction
>>  .I   \-D, \-\-deleteall
>>  Remove all local customizations
>>  .TP
>> -.I   \-e EQUAL, \-\-equal EQUAL
>> -Substitute target path with sourcepath when generating default label. T=
his is used with fcontext. Requires source and target path arguments. The c=
ontext labeling for the target subtree is made equivalent to that defined f=
or the source.
>> +.I   \-e TARGET_PATH, \-\-equal TARGET_PATH
>> +Substitute FILE_SPEC with TARGET_PATH for file label lookup. This is us=
ed with fcontext. Requires source and target path arguments to be path pref=
ixes and does not support regular expressions. The context labeling for the=
 target subtree is made equivalent to that defined for the source.
>>  .TP
>>  .I   \-f [{a,f,d,c,b,s,l,p}], \-\-ftype [{a,f,d,c,b,s,l,p}]
>>  File Type. This is used with fcontext. Requires a file type as shown in=
 the mode field by ls, e.g. use 'd' to match only directories or 'f' to mat=
ch only regular files. The following file type options can be passed: f (re=
gular file),d (directory),c (character device), b (block device),s (socket)=
,l (symbolic link),p (named pipe).  If you do not specify a file type, the =
file type will default to "all files".
>> --=20
>> 2.47.1

