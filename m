Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A41A76B6
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633610; cv=none; b=XdUcujfKf4Av5E0Dx6T17VWQwPwaHO93T+yWBRgvLw35fwkmJxxUY5ebXerJ31CHb7qei34JCo2QKaHZHtXewam+kIT5D/F/On9Z2C5W1FglHkDBjb0STR7TBonrD2c74AoxixkCunGwq/wPHoceexfkWeJ5ccLCa5owGMgkoa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633610; c=relaxed/simple;
	bh=DyNGeIbTj4bx2Q5L8mRYh42cYdStV1T0Set7sfM+g00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ifAhFd48kSQYfaX5SIjAl2QzEalV9rbF5DEdr2Qi+fF1wbJv8Xc7MZZSjNB/pa9Ov6mB75GpbTsMqNCZqwbHSRoFOwnM/Cl0Hlj+v5IAXSfbwPd8evhdrBrwVx8pHdRwPD5uhHyfHVxNom9QXaaJ5nLvMA+k7PCMacecGst0w50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KY4O9oG+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KY4O9oG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723633607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DyNGeIbTj4bx2Q5L8mRYh42cYdStV1T0Set7sfM+g00=;
	b=KY4O9oG+LrWKjCejZuyAoK6LchbVrLD78p0bjpaVDjBt4LKcRRunZAjEAnaVv5bqBuS7SM
	pwOIA8SrVmtWec5L8FfvHxqJEfLMCycNglXw3bO7Re0xjf3Y6kSx8+oUJ5beR0uvi5l3TY
	g/GADGeCL1hHOfl80jW4C4S3hxvM8ko=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-AFP1RDA0MISdsIDUoe-5WA-1; Wed,
 14 Aug 2024 07:06:43 -0400
X-MC-Unique: AFP1RDA0MISdsIDUoe-5WA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B43001954B10;
	Wed, 14 Aug 2024 11:06:41 +0000 (UTC)
Received: from localhost (unknown [10.45.226.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 284E7300019C;
	Wed, 14 Aug 2024 11:06:40 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, Dominick Grift
 <dominick.grift@defensec.nl>
Cc: selinux@vger.kernel.org
Subject: Re: monolithic policy on a volatile root
In-Reply-To: <CAEjxPJ63KtgNc-FVBwkRJup5Qh022An21n=TsCsLP9L1bYyfoQ@mail.gmail.com>
References: <87y15fe3iy.fsf@defensec.nl>
 <CAEjxPJ63KtgNc-FVBwkRJup5Qh022An21n=TsCsLP9L1bYyfoQ@mail.gmail.com>
Date: Wed, 14 Aug 2024 13:06:39 +0200
Message-ID: <87v803fjnk.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Fri, Aug 2, 2024 at 4:27=E2=80=AFAM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>>
>> I think this question was already asked but I could not find the
>> discussion.
>>
>> What would be the challenges to support a monolitic policy on a volatile
>> root?
>>
>> In a volatile root scenario there is only a non-volatile readonly
>> /usr. Would it be possible to teach libselinux that if there is a
>> /usr/selinux and not a /etc/selinux and/or /var/lib/selinux that it would
>> use that instead?
>>
>> The challenge I am currently facing with systemd.volatile=3Dyes is that
>> when the policy is loaded from initramfs that systemd-tmpfiles (and
>> systemd-sysusers) cannot properly populate root from /usr/share/factory
>> (or created) because they rely on libselinux,get/setfilecon and thus on
>> /etc/selinux/contexts/files. There is a slight chicken and egg situation=
 there.
>>
>> Often times its not a probable because one can do with automatic type
>> transitions but some of these files get created atomically (/etc/passwd
>> and /etc/shadow for example) and not to mention that these libselinux
>> linked components might get confused and noisy if selinux is enabled and
>> enforcing but there is no /etc/selinux.
>>
>> Duplicating policy in initramfs and /etc, /var/lib would invite
>> inconsistencies and is not feasible but if the policy is readonly and
>> thus monolitic then this might be feasible if it is not too
>> ugly. Actually in such a scenario we would probably not need a policy in
>> initramfs at all since systemd would just load it from /usr instead of /=
etc.
>
> I've seen a similar concern raised previously even for modular/managed po=
licy.
> It's all just software so I don't think it would be hard to modify
> libselinux to fall back to /usr/selinux if there is no file in
> /etc/selinux; it just requires someone to write a patch for it. May
> have policy implications (i.e. anything that currently accesses
> /etc/selinux now also may need search access to usr_t) but that's
> pretty common anyway.

Using /usr for factory policy files has been on my todo list for a long
time.

Files from /usr/etc/selinux and /usr/lib/selinux would be used as
default but they would be overridden by files in /etc/selinux resp
/var/lib/selinux. i.e. libselinux would first look into /etc/selinux and
if a file does not exist, look into /usr/etc/selinux. likewise for
libsemanage. It would also use modules from /usr/lib/selinux but
these modules would be overridden by modules from /var/lib/selinux

Policy rebuild (`semodule -R`) would install new policy and modules into
/etc and /var as it's now.









