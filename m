Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512603DA7EE
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806656; cv=none; b=dHv8q/zPT+xSqFz929QQfKvnLMC5PLUZqPWQLTHLVWa/REBSvKiT0DWmbGy30JaLO4pIAZB5mbJPl41BSqql93bLqoXS2y1OUmjc/29Tq4vT/wQPCFqJfgvuA+k5VfujzqAfIIgrJ4C7IySYZE/WSE/D+6wlg7wKpAhtnyh0qOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806656; c=relaxed/simple;
	bh=PWQO653K4TnoxT7DWwlL99RLP5w+5zNRXRfjv1LLGD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hAryVUJkwzezNU9LIPgeQv8bSTU1yMXnROPC3h9dSEWzJgrQ4L45hBPv7Hw1i3UW4JAg7HXNmYCa7P1RVK4GE0HbXmt433rUkyU9iRH31ac2+mjo+RQNy1cz/K5pzWPX6wbmrCmqVR4B4B00MQswW7d26JJQvolyhLzZLhSus3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDfxBS0R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDfxBS0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779806654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9tF0jiboFDzbyq15nXyH4DxQ3zl/8HhGY77V9qiSbmg=;
	b=DDfxBS0RIhlls8KfaBAaPbePj5IKt4XX0SlwT53kN9WhLtOqcoftiUi/ncu2H5biSvHGhn
	DNKJgqJZS1C6ibTvcJ/UMyx4qTvS+V64pY4eXm9LB/AnVgnJRRpz+zt3snTZAJMmt9oKNd
	XtJ+nVwdYg7pMbhTWij4qib2kdgPsGo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-6LPLw-7zPDe9hRWRtacWOQ-1; Tue,
 26 May 2026 10:44:11 -0400
X-MC-Unique: 6LPLw-7zPDe9hRWRtacWOQ-1
X-Mimecast-MFC-AGG-ID: 6LPLw-7zPDe9hRWRtacWOQ_1779806650
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C47FE19560AA;
	Tue, 26 May 2026 14:44:10 +0000 (UTC)
Received: from localhost (unknown [10.44.33.146])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53874180056E;
	Tue, 26 May 2026 14:44:10 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] restorecond: Do not unlink pidfile if not used
In-Reply-To: <CAEjxPJ4qTxikR_RrMMwnG2YJv1qtOtQpu3UBNCRPN6xbM1x7GA@mail.gmail.com>
References: <20260525161704.228092-1-lautrbach@redhat.com>
 <CAEjxPJ4qTxikR_RrMMwnG2YJv1qtOtQpu3UBNCRPN6xbM1x7GA@mail.gmail.com>
Date: Tue, 26 May 2026 16:44:09 +0200
Message-ID: <87pl2inscm.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Mon, May 25, 2026 at 12:17=E2=80=AFPM Petr Lautrbach <lautrbach@redhat=
.com> wrote:
>>
>> With -F or -d, restorecond does not create nor use pidfile and therefore
>> it should not try to remove it.
>>
>> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Is there a reason we are using 0 instead of NULL for pidfile despite
> it being a pointer?

I wanted to be consistent with the rest of the code in in write_pid():

	if (len < 0) {
		syslog(LOG_ERR, "Pid error (%s)", strerror(errno));
		pidfile =3D 0;
		return 1;
	}
	pidfd =3D open(pidfile, O_CREAT | O_TRUNC | O_NOFOLLOW | O_WRONLY, 0644);
	if (pidfd < 0) {
		syslog(LOG_ERR, "Unable to set pidfile (%s)", strerror(errno));
		pidfile =3D 0;
		return 1;
	}





> Otherwise,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
>> ---
>>  restorecond/restorecond.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
>> index 36f82ae5e9cb..6353b3b72798 100644
>> --- a/restorecond/restorecond.c
>> +++ b/restorecond/restorecond.c
>> @@ -217,6 +217,8 @@ int main(int argc, char **argv)
>>                 if (daemon(0, 0) < 0)
>>                         exitApp("daemon");
>>                 write_pid_file();
>> +       } else {
>> +               pidfile =3D 0;
>>         }
>>
>>         while (watch(master_fd, watch_file) =3D=3D 0) {
>> --
>> 2.54.0
>>
>>

