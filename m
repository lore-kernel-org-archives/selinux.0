Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E1148AE1A
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854108; cv=none; b=bJ1NiYD/QVIe8fHmM1M2W8gCRG2saRbsT9Ta9UPF8fUZNy4iHvjCOHXe8z4HAdgUD8mCn7VV4ETH7J3Xko+bhmmUVPOcGNI1QMY2PHH5tffGhCUf9fZvc5J1dzmU+nwlYNW1lIZTrcwTjkE/tz/o+mc9gQkr5+TAWd49BzRQS3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854108; c=relaxed/simple;
	bh=F1u4ID2K1A03Z0XCm9CUKRZcFOkHM2Rs/VMcDdzb8HM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SZL5lwrkivnNrNonB1MXyjiAsS7aXWod2k4crH5yuhSO/Juc4vGiN/zIfnZ2zuQH2manduj3GGrR2vehgEOxqPKK1KsKcvSE4NMvMV1xu92pD7mNnJ+bEaUuS3myp1RkpN7DoHVSeT2UBIx197n38Be13yXNm0myCrXwiG2/JxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkeKKvQZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkeKKvQZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778854106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQRQ1ZZQ8zzsdAIvbpoZW1AzOqwwAIFXFPxiwI8l7yo=;
	b=SkeKKvQZTKFHi8tBCylrmBpx6ndSYL81QNsjGpmS8YOrrqJAAgEDEmCat4dZo2s5R1zO7V
	TBZ2Hyap6kcHFHn37m7O7dhglu0OcP1TdjKL+2QMNkk5JDJhaK3tHfLzD1/uLYPeX1u8QQ
	bqYMULF5nm3Mz2LxR+y0f5WXc6v5g7Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-7iFFugXdPOu1Rzez05y9mw-1; Fri,
 15 May 2026 10:08:22 -0400
X-MC-Unique: 7iFFugXdPOu1Rzez05y9mw-1
X-Mimecast-MFC-AGG-ID: 7iFFugXdPOu1Rzez05y9mw_1778854101
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 557DF1800618;
	Fri, 15 May 2026 14:08:21 +0000 (UTC)
Received: from localhost (unknown [10.44.49.163])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C44851956053;
	Fri, 15 May 2026 14:08:20 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, omosnace@redhat.com, paul@paul-moore.com,
 perfinion@gentoo.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: switch seunshare_mount_file() to use
 open()
In-Reply-To: <871pfe88k6.fsf@redhat.com>
References: <20260512192631.751908-1-stephen.smalley.work@gmail.com>
 <871pfe88k6.fsf@redhat.com>
Date: Fri, 15 May 2026 16:08:19 +0200
Message-ID: <87bjeghijw.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Petr Lautrbach <plautrba@redhat.com> writes:

> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
>> seunshare_mount_file() currently uses fopen() to create the dst
>> if it doesn't already exist. Switch to using open() with
>> explicitly specified flags including O_NOFOLLOW and an explicitly
>> specified mode for the new file.
>>
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>

Merged, thanks!


>> ---
>>  sandbox/seunshare.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
>> index a1900eaa..17a727e7 100644
>> --- a/sandbox/seunshare.c
>> +++ b/sandbox/seunshare.c
>> @@ -304,18 +304,20 @@ static int seunshare_mount(const char *src, const char *dst, struct stat *src_st
>>   */
>>  static int seunshare_mount_file(const char *src, const char *dst)
>>  {
>> -	int flags = 0;
>> -
>>  	if (verbose)
>>  		printf(_("Mounting %s on %s\n"), src, dst);
>>  
>>  	if (access(dst, F_OK) == -1) {
>> -		 FILE *fptr;
>> -         fptr = fopen(dst, "w");
>> -		 fclose(fptr);
>> +		int fd = open(dst, O_WRONLY | O_CREAT | O_NOFOLLOW | O_CLOEXEC, 0600);
>> +		if (fd < 0) {
>> +			fprintf(stderr, _("Failed to create mount point %s: %m\n"), dst);
>> +			return -1;
>> +		}
>> +		close(fd);
>>  	}
>> +
>>  	/* mount file */
>> -	if (mount(src, dst, NULL, MS_BIND | flags, NULL) < 0) {
>> +	if (mount(src, dst, NULL, MS_BIND, NULL) < 0) {
>>  		fprintf(stderr, _("Failed to mount %s on %s: %s\n"), src, dst, strerror(errno));
>>  		return -1;
>>  	}
>> -- 
>> 2.54.0

