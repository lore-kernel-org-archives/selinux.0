Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F1B1DDA17
	for <selinux@vger.kernel.org>; Thu, 16 Jan 2025 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043514; cv=none; b=Fbp9mjKTpa2k5SoIS1ZqsM5Con83cbxfGWbKQgXWUV/35qxDb6ta0PinR2Z/XLzn2Yp7umoSiCKi17gEbgqrfBHdOxSQvoxtbSpLQMyDG6ScjR+Hmykt34MJRNbep1FTks86QeMxhWelQ3Gv0sDIVTHiXxLwWJp+yyJ5YIcY1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043514; c=relaxed/simple;
	bh=Xrw6ue5sTuu57PbFXSeQ/k4Z0pH8Ch4a5PJBPNZrrcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JkxXQD49NiVOUHZyqr4zDBFcdfHkQLhFwVnvN0I2VbVrv7GEM2K6qRP+PPhaIu9ksBEA4jp0xPh2vu86uM4WW9msv7e8XbZL6PfZgqDgqfMY1y+ApuIotP4vDoCmqSvadnBzhhHfbc/TBRZUZTRykn6qXfDTbTsnSCFdjbeybxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMuJIiAs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMuJIiAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737043511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9Snoea0/gtBRv3npvj3DiGheCoWOpuf/xn5NCnd8Z8=;
	b=EMuJIiAswLYI5bf13RdvCFWvFq3VJ2yDBxO1sgddw9kYgtTsvoQMXj8FaWUM9bYHtXyEoo
	EA2ihVfGoiBZ4pLs7xHvUTuZ4hn1x5uN+0idBsFL1YyJPl55vvJI4OPva9LO/V4oA2VKEg
	ph61N4WDQD+ScaXS/8+AMsqyFnAnmeg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-y0L3_gZTOfOQHFkXzoURBg-1; Thu,
 16 Jan 2025 11:05:08 -0500
X-MC-Unique: y0L3_gZTOfOQHFkXzoURBg-1
X-Mimecast-MFC-AGG-ID: y0L3_gZTOfOQHFkXzoURBg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 107C8195396D;
	Thu, 16 Jan 2025 16:05:07 +0000 (UTC)
Received: from localhost (unknown [10.39.196.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 85F4B19560A3;
	Thu, 16 Jan 2025 16:05:06 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: James Carter <jwcart2@gmail.com>, Daniel Burgener
 <dburgener@linux.microsoft.com>, selinux@vger.kernel.org
Cc: 
Subject: Re: [PATCH] CONTRIBUTING.md: Drop dependency and build instructions
In-Reply-To: <CAP+JOzQPqG6DXH5025tpK9AG=MNoa-uALOBPjGkq7nmLrW3bAA@mail.gmail.com>
References: <20250113213824.26000-1-dburgener@linux.microsoft.com>
 <CAP+JOzQPqG6DXH5025tpK9AG=MNoa-uALOBPjGkq7nmLrW3bAA@mail.gmail.com>
Date: Thu, 16 Jan 2025 17:05:05 +0100
Message-ID: <87cygmwxqm.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

James Carter <jwcart2@gmail.com> writes:

> On Mon, Jan 13, 2025 at 4:38=E2=80=AFPM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
>>
>> They are redundant with README.md, and haven't been kept up to date.
>> For example, the CONTRIBUTING.md dependencies are missing the xmlto
>> dependency.  Rather than try to maintain this information in two places,
>> just refer contributors to the README and keep the CONTRIBUTING doc
>> focused on high level process.
>>
>> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged. Thanks!


>> ---
>>  CONTRIBUTING.md | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
>> index 7c548e58..e6a677a0 100644
>> --- a/CONTRIBUTING.md
>> +++ b/CONTRIBUTING.md
>> @@ -23,14 +23,7 @@ using a custom policy please include it as well.
>>
>>  ## Compiling
>>
>> -There are a number of dependencies required to build the userspace
>> -tools/libraries. On a Fedora system you can install them with yum:
>> -
>> -    # yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-gl=
ib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-dev=
el pam-devel pcre2-devel python-devel setools-devel swig ustr-devel
>> -
>> -The tools and libraries can be built and installed under a private dire=
ctory from the top level with make, e.g.
>> -
>> -    $ make DESTDIR=3D~/obj install install-pywrap
>> +See README.md for instructions on how to compile and test this project.
>>
>>  ## Contributing Code
>>
>> --
>> 2.34.1
>>
>>

