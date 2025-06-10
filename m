Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8286827A93A
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749541394; cv=none; b=DJ+Wiwi8EjJmHBNAKmnP9+7tdTvithZKl3mZb6KFIJ9L4uxiTXcwMH3LeH+umQSkrk5L/FsOZbhPw7z7gDc3LSKMAHQkBHaRlhgd0qljr/j7RzZDpzLiTYet3btK+qLBpyzEoNKFW32B+9dx0Y536sSXw2z+X1XrdRShuL++Cho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749541394; c=relaxed/simple;
	bh=a8eqPxp8vBOJPf/98b2fUTnDq8Nlmkc2WQ5JcSAtj3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YoLWRf3MU5O0zJvJBezIoEPAvc54gww6sAAzxdfP2QuDhjuDVehJEasSle6VSWvNASnbNPyMnGLXMb/B1a4mrHHLpZFHErJe+4t8yyXZDHgkS+JsapvaWCAN80Gv/mJum8FTAOp1eUtq2oRaaOnMHFRHf6xdQErRhDHY9L7mVmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9pnm9pA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9pnm9pA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749541391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzMrlWwfnDKYFYgE4jJbics8AJdUiXCQcqKtpZFaoew=;
	b=h9pnm9pADQ7LGVKc2eXWrKyOOAYLHUA09yNDPaqAYwIaSZBKDYGUrL+VRMUHoTrAezW/jR
	PECWyh6WImVenG1Io89KWx0yv/ElkTa9NFZop2m0a4CJkzQ/Gk8Fal9hVHJOPInz0ZTfBV
	lDGpCofBB/ObgFD4mWDofCZJ3hYGNh4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-l11gr9D-My6DVd2uweE7pQ-1; Tue,
 10 Jun 2025 03:43:05 -0400
X-MC-Unique: l11gr9D-My6DVd2uweE7pQ-1
X-Mimecast-MFC-AGG-ID: l11gr9D-My6DVd2uweE7pQ_1749541384
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 772951800295;
	Tue, 10 Jun 2025 07:43:04 +0000 (UTC)
Received: from localhost (unknown [10.44.32.151])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C826A1956087;
	Tue, 10 Jun 2025 07:43:03 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>, Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: Re: [PATCH] README: update subscribe information
In-Reply-To: <CAP+JOzTrufGGRqxbf0A1i+B9HuZ7p-WW4huutxXU2fDa_-vwJQ@mail.gmail.com>
References: <20250514070651.223058-1-lautrbach@redhat.com>
 <CAP+JOzTrufGGRqxbf0A1i+B9HuZ7p-WW4huutxXU2fDa_-vwJQ@mail.gmail.com>
Date: Tue, 10 Jun 2025 09:43:02 +0200
Message-ID: <87y0u0dou1.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

James Carter <jwcart2@gmail.com> writes:

> On Wed, May 14, 2025 at 3:07=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
>>
>> Majordomo commands are no longer supported after the migration away from
>> legacy vger infrastructure.
>>
>> https://subspace.kernel.org/vger.kernel.org.html#what-happened-to-majord=
omo
>>
>> Reported-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

merged


>> ---
>>  README.md | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/README.md b/README.md
>> index 1e16beea6536..aa98d7819b01 100644
>> --- a/README.md
>> +++ b/README.md
>> @@ -16,9 +16,8 @@ and system libraries which allow for the configuration=
 and management of an
>>  SELinux-based system.
>>
>>  Please submit all bug reports and patches to the <selinux@vger.kernel.o=
rg>
>> -mailing list. You can subscribe by sending "subscribe selinux" in the b=
ody of
>> -an email to <majordomo@vger.kernel.org>. Archives of the mailing list a=
re
>> -available at https://lore.kernel.org/selinux.
>> +mailing list. You can subscribe by sending an email to <selinux+subscri=
be@vger.kernel.org>
>> +Archives of the mailing list are available at https://lore.kernel.org/s=
elinux.
>>
>>  Installation
>>  ------------
>> --
>> 2.49.0
>>
>>

