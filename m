Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106068;
	b=YFz0337XwyRrtNS89ObZTUv3FwgeMj5HAiZIPQmUQDY/cUlmT0rmXWt1ymsiUyFyNHQg
	 ZKd9qfQ9w4lzgPRniGgTJ0Zr1OnAiijaERQm79g/t5FAR/ae7u32sfdxBjBM60d02KIKf
	 p76nrPY+JnqaMpU8k7AhMUfdJnZDUfoGa54fK/0sw2dvDQHJxB9UgdIvi8MrKj8E+X6Y4
	 MQpCuvhifA4ypySVYVc4Clrar6eOoW3pgF2IwhebOg/sWG5OToZ9c7r9hcwgF3RU0XZ2n
	 ix9dgl3oRz1WO3nkZaYtnEDNM49D0uD/0tAOH7NZLYLXtA0v3955qA8FIfNXpW6DwuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106068;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
	 X-Scanned-By;
	bh=c9lc76iJ3AsCR+4clsqHxjTs7GQ6ul3X7WImPmTBNS8=;
	b=TPAIXoyAIfaCXXaDqWsf6S9CNCfk/7o1ye1JMhjsL2rODAOQYDNfalOG/NMiYJadnEcI
	 WdVBuXUWomSlvab9pW12JDmkgf3wTg22bZMYkeOCP7zKbBuuajQZbCWPwA9NnE/DgAvLK
	 GrfSUqrmpTLG4jMwtogUKpsEr1xvSYQ89E2Xz/iWTaBgQ5tERfDFzN97rghxcvH8lpFbD
	 gir3G1oUaZpLhfJA6a5BMvtFtX7s8BgC5L/QG7XZ5b2gblGWT0TX2A7uJgf0N9XVBh289
	 1ausXstPMPYhoFeAutoT9zBqf2UbVlJCVy6q2PvGS3C0sVL76sEdsVATlFC+YGi++Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E4IRBWiv;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD07606A324
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 16:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FD07606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E4IRBWiv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795106067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c9lc76iJ3AsCR+4clsqHxjTs7GQ6ul3X7WImPmTBNS8=;
	b=E4IRBWiv7C7NxNV39odeDgdCSeHIRGpo0nxTVuYj2XsbjpofVGidnNIuuQedZfJA4YuOo9
	MTuZU4eezlusD3t7YS5Eg7mpI0OcfIsNF10qSBR3ZkvcKiQbJHZLAIdVBqo5UBgpFnR3E/
	1yFm6I30wIpDZOn4syApL5qsFGkLsjo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-2DQNFFYIO0mbtJADvhq7-w-1; Thu,
 19 Nov 2026 16:34:20 +0000
X-MC-Unique: 2DQNFFYIO0mbtJADvhq7-w-1
X-Mimecast-MFC-AGG-ID: 2DQNFFYIO0mbtJADvhq7-w_1795106058
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F01AD1956060;
	Thu, 19 Nov 2026 16:34:16 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67C00342;
	Thu, 19 Nov 2026 16:34:13 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnacek@gmail.com, jwcart2@gmail.com, paul@paul-moore.com,
 jason@perfinion.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] libselinux: prevent path traversal via crafted username
 in getseuser()
In-Reply-To: <pjda4n5vsxu.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
References: <20261119130718.783-1-stephen.smalley.work@gmail.com>
 <pjda4n5vsxu.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
Date: Thu, 19 Nov 2026 17:34:10 +0100
Message-ID: <pjdwlq8vkzh.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Petr Lautrbach <lautrbach@redhat.com> writes:

> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
>> getseuser() builds "<policy_root>/logins/<username>" and reads the
>> per-user seuser mapping from that file. The username is whatever NSS
>> resolved for the login and is passed straight through by pam_selinux;
>> Linux imposes no character-set restriction on NSS names, and directory
>> backends (LDAP/AD) can serve names containing "/".
>>
>> A crafted username can make a root-running PAM stack read a file the
>> user controls and take that user's SELinux user and MLS range from it,
>> i.e. the confinement decision is delegated to whoever named the account.
>> Fall through to the ordinary seusers lookup for such names instead.
>>
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>

Merged.

>> ---
>>  libselinux/src/seusers.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/libselinux/src/seusers.c b/libselinux/src/seusers.c
>> index ea542392..df9385eb 100644
>> --- a/libselinux/src/seusers.c
>> +++ b/libselinux/src/seusers.c
>> @@ -293,6 +293,14 @@ int getseuser(const char *username, const char *service, char **r_seuser,
>>  	char *rec = NULL;
>>  	char *path = NULL;
>>  	FILE *fp = NULL;
>> +
>> +	/*
>> +	 * Prevent path traversal via crafted username; no valid username
>> +	 * should be NULL, start with ".", or contain a '/'.
>> +	 */
>> +	if (!username || username[0] == '.' || strchr(username, '/'))
>> +		goto err;
>> +
>>  	if (asprintf(&path, "%s/logins/%s", selinux_policy_root(), username) <
>>  	    0)
>>  		goto err;
>> -- 
>> 2.47.3

