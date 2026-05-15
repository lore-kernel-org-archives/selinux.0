Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81D320A04
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854143; cv=none; b=hut0Ov/jCBeOj9Oyb8SvLkREEACVAZEJvLTtI8/Z0iu/KZY4IKVWE7p5Y4BGd8hxHRE5bb65TX+rwodhxxzwuwErnqFMZ/G877iT+C3hxe3l3jRfKPH7cx1iuIWUkH29/uPHCHfRlfC/Vl9x4GPpUFLeDar2a6e/Gwv52myt/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854143; c=relaxed/simple;
	bh=RoWwY86l4sGnjIKg7vS8BEmXsABNvdp47mOA/4dsR3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=deDbghfVkSSDr/vX/fY3Zzq3ymV9Mqchl/vVXw/96A0pKS3Ka4hLRUt1vbBI9l89Wuu0jYAApFFIUh23CWBcSVIygRVJNj2kzrXbznmAAJWcd6vj7AjsEby2321ONTs3d/MrCd0Q7y6FSxSqi5uoPYDyE/CbS4w3n4B+dY82fdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0mFvfma; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0mFvfma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778854141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v8BDUXVcq3m9k7G7EP+Y8Vkxw0hydF+Wo9EaBSmXpJE=;
	b=e0mFvfmaytIT5j38NQW0Xxwkr9zjq7MT0OiUQGCmUjnaz7HdWLc5ETauXW2beAsuScJ3KG
	U+oW2q0ycqZQtHQQI/qtw9lULMFit0OztXdgCehzmyNlaOLCpDe5myjRajUwyvYQiUJBc+
	De0UZW55HPbJ1LRCL8ED59/xg7uVQQI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-m80iBkwTNPm_3UWF9ScCTw-1; Fri,
 15 May 2026 10:08:57 -0400
X-MC-Unique: m80iBkwTNPm_3UWF9ScCTw-1
X-Mimecast-MFC-AGG-ID: m80iBkwTNPm_3UWF9ScCTw_1778854136
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B905195608B;
	Fri, 15 May 2026 14:08:56 +0000 (UTC)
Received: from localhost (unknown [10.44.49.163])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E64801800240;
	Fri, 15 May 2026 14:08:55 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, omosnace@redhat.com, paul@paul-moore.com,
 perfinion@gentoo.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: fix error checking for setfsuid()
In-Reply-To: <87y0hm6tyw.fsf@redhat.com>
References: <20260512193553.752163-1-stephen.smalley.work@gmail.com>
 <87y0hm6tyw.fsf@redhat.com>
Date: Fri, 15 May 2026 16:08:54 +0200
Message-ID: <878q9khiix.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Petr Lautrbach <plautrba@redhat.com> writes:

> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
>> setfsuid() doesn't reliably set errno or return anything indicating
>> an error.
>>
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>

Merged, thanks!


>> ---
>>  sandbox/seunshare.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
>> index 17a727e7..b9c85bf2 100644
>> --- a/sandbox/seunshare.c
>> +++ b/sandbox/seunshare.c
>> @@ -858,8 +858,8 @@ int main(int argc, char **argv) {
>>  	/* Changing fsuid is usually required when user-specified directory is
>>  	 * on an NFS mount.  It's also desired to avoid leaking info about
>>  	 * existence of the files not accessible to the user. */
>> -	if (((uid_t)setfsuid(uid) != 0)   && (errno != 0)) {
>> -		fprintf(stderr, _("Error: unable to setfsuid %m\n"));
>> +	if ((uid_t)setfsuid(uid) != 0) {
>> +		fprintf(stderr, _("Error: unable to setfsuid\n"));
>>  
>>  		return -1;
>>  	}
>> -- 
>> 2.54.0

