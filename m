Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0848BD45
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853987; cv=none; b=JLpV5aprfljq5uUDPf8TfeDXzlCXR4OIN3jAN9KRKMEI6DD5yaC3+X6NRtZP5OrakW0KLLiQx6V6vs5pk+jUDwtymR8SKS9BUOIMgiw7vu6vU1dmVchqOes2Ih31W7haRQiNsIlIqIrHelyCQGh4nFyymQd3BHHYSXILoprb8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853987; c=relaxed/simple;
	bh=pdasrObGHkFwU5oObLbvEbtIUiNxLsNK+a1q8Get4wU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VPyticwS5FNoOQCq5KZFdsizv+MKAFgjTE6YRFlhHe9Swk9oqaKBm8TxgTh9WkQEzwrakLZtybQPlgj/QfajMtUetu6FYXjktXBAcDVxReRId4prHgXDlG0Hpqnb5MADYzNEY8zvKzgFSZNJL7A65KMitOnMAAmUqSZUtCH6kaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxSx+1Jm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxSx+1Jm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778853983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjsbNv1i3xdkvGaiCdxhLjxa/oL+949ASXqPrraQHE0=;
	b=dxSx+1JmJJkQ50EtlG77epiE384ASjGRcrmY3s3nGHHXmbuYK1QwHDFLbmQFp4TM1ebtMb
	UVc+XTrHLD4sHnLPMzcOp51SNIiAeBd/a99en6/ofnddWuYm5ER9gU6sBzWhEeimTdXduZ
	m8Fu6NsaIWdZ08X6RV7GxjeySwZpvlw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-Y6e9dC28MKySTOa_5Y1OGg-1; Fri,
 15 May 2026 10:06:19 -0400
X-MC-Unique: Y6e9dC28MKySTOa_5Y1OGg-1
X-Mimecast-MFC-AGG-ID: Y6e9dC28MKySTOa_5Y1OGg_1778853978
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A152B1800616;
	Fri, 15 May 2026 14:06:18 +0000 (UTC)
Received: from localhost (unknown [10.44.49.163])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 311891800240;
	Fri, 15 May 2026 14:06:17 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: James Carter <jwcart2@gmail.com>, Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] checkpolicy/test: Show all options for dispol and
 dismod in -h
In-Reply-To: <CAP+JOzTSxCP9LASNMKS=QT4TdKpb3ri9NKsu09hdtE5++UV=fw@mail.gmail.com>
References: <20260420124124.324404-1-vmojzis@redhat.com>
 <CAP+JOzTSxCP9LASNMKS=QT4TdKpb3ri9NKsu09hdtE5++UV=fw@mail.gmail.com>
Date: Fri, 15 May 2026 16:06:17 +0200
Message-ID: <87h5o8hina.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

James Carter <jwcart2@gmail.com> writes:

> On Mon, Apr 20, 2026 at 8:41=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> w=
rote:
>>
>> Show the following options, which were hidden in the usage message,
>> because they require additional input:
>>
>> dispol:
>>   7    change a boolean value
>>   f    set output file
>>   m    display menu
>>   q    quit
>>
>> dismod:
>>   l    Link in a module
>>   f    set output file
>>   m    display menu
>>   q    quit
>>
>> Fixes:
>>   $dispol -h
>>   Usage:
>>    sedispol [OPTIONS] binary_pol_file
>>
>>   Options:
>>    -h, --help   print this help message
>>    -a, --actions ACTIONS   run non-interactively
>>
>>   Actions:
>>     1    display unconditional AVTAB
>>     2    display conditional AVTAB (entirely)
>>     3    display conditional AVTAB (only ENABLED rules)
>>     4    display conditional AVTAB (only DISABLED rules)
>>     5    display booleans
>>     6    display conditional expressions
>>     8    display role transitions
>>     c    display policy capabilities
>>     C    display classes
>>     u    display users
>>     r    display roles
>>     t    display types
>>     a    display type attributes
>>     p    display the list of permissive types
>>     U    display unknown handling setting
>>     F    display filename_trans rules
>>
>>   With the patch:
>>
>>   Actions:
>>     1    display unconditional AVTAB
>>     2    display conditional AVTAB (entirely)
>>     3    display conditional AVTAB (only ENABLED rules)
>>     4    display conditional AVTAB (only DISABLED rules)
>>     5    display booleans
>>     6    display conditional expressions
>>     7    change a boolean value
>>     8    display role transitions
>>     c    display policy capabilities
>>     C    display classes
>>     u    display users
>>     r    display roles
>>     t    display types
>>     a    display type attributes
>>     p    display the list of permissive types
>>     U    display unknown handling setting
>>     F    display filename_trans rules
>>     f    set output file
>>     m    display menu
>>     q    quit
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged, thanks!

>> ---
>>  checkpolicy/test/dismod.c | 3 +--
>>  checkpolicy/test/dispol.c | 3 +--
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
>> index 4868190f..ed5aaa45 100644
>> --- a/checkpolicy/test/dismod.c
>> +++ b/checkpolicy/test/dismod.c
>> @@ -106,8 +106,7 @@ static __attribute__((__noreturn__)) void usage(cons=
t char *progname)
>>         puts("");
>>         puts("Actions:");
>>         for (unsigned int i =3D 0; commands[i].meta !=3D EOL; i++) {
>> -               if (commands[i].meta =3D=3D HEADER
>> -                   || commands[i].meta & NOOPT)
>> +               if (!(commands[i].meta & CMD))
>>                         continue;
>>                 printf("  %c    %s\n", commands[i].cmd, commands[i].desc=
);
>>         }
>> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
>> index 3f80c1a2..c3339b88 100644
>> --- a/checkpolicy/test/dispol.c
>> +++ b/checkpolicy/test/dispol.c
>> @@ -79,8 +79,7 @@ static __attribute__((__noreturn__)) void usage(const =
char *progname)
>>         puts("");
>>         puts("Actions:");
>>         for (unsigned int i =3D 0; commands[i].meta !=3D EOL; i++) {
>> -               if (commands[i].meta =3D=3D HEADER
>> -                   || commands[i].meta & NOOPT)
>> +               if (!(commands[i].meta & CMD))
>>                         continue;
>>                 printf("  %c    %s\n", commands[i].cmd, commands[i].desc=
);
>>         }
>> --
>> 2.53.0
>>
>>

