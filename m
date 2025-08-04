Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48157165F13
	for <selinux@vger.kernel.org>; Mon,  4 Aug 2025 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325266; cv=none; b=iN6+ZPIdvIADdY8t0Bmnljam2mF3WE0El5G3j8VxEp311HvYUhqNXTmsdA4oyE21PSVrjSt8iygLkcSgeGQXfJup5kmot1QAF2vqgstUXrsMjMi/hEwyLrcSRQJFI67Dx2DPXDFIYrvaqqCqM8OD/jYCkE96YRwdPndXk7PmGcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325266; c=relaxed/simple;
	bh=lCYVwcr0GSszPQqL1o0v2dp0nKEFL1bkliIT/LTGdFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqpnonSikfcM+JKTKkIKQ2YHwKje7Vr20FgzQ6w6LVoag8eEUw++Xf4YtLb78GJ2LtHDi+jPeObu1jewf6KGNxd2LAkXq/8BbTKUdp43QfVzpb3RkSIlSEybSUwQnCSESb5yOYfNlSeKWKXdeGhswbUY9Vw1BX/9FTpVsgjD6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQ2Qxvet; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQ2Qxvet"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754325263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8o4DudD8XmgPsu+4yR+R7vwaS7YkOb3ssqHtIPpcME=;
	b=eQ2QxvetCpyqz9iTbok7uaPgnC+H6QJUhaY9/Y141uMgpZgszFrP7+2AtV/+TxGoyP6l8W
	CvoW6AVgLuo3zaFdX02Sqy2Ji6tLucWD2z98Tu7Xln8XnO0t305+sVz8OZz2B0W+Iy2h08
	e0sN/gMpl4fa5oew1jz6HMueg0TozDo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-bfpVle_ON62GafQb-4P_5Q-1; Mon,
 04 Aug 2025 12:34:19 -0400
X-MC-Unique: bfpVle_ON62GafQb-4P_5Q-1
X-Mimecast-MFC-AGG-ID: bfpVle_ON62GafQb-4P_5Q_1754325258
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBAED19560BD;
	Mon,  4 Aug 2025 16:34:17 +0000 (UTC)
Received: from localhost (unknown [10.44.33.56])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D4471800EED;
	Mon,  4 Aug 2025 16:34:17 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com
Subject: Re: [PATCH userspace] SECURITY.md: add my email address and GPG key
 fingerprint
In-Reply-To: <CAHC9VhSUbZrbV06hzzu5kNwrgojjYVYaUL_Yto+stWD1C=XZ5A@mail.gmail.com>
References: <20250723182550.1065144-2-stephen.smalley.work@gmail.com>
 <CAHC9VhSUbZrbV06hzzu5kNwrgojjYVYaUL_Yto+stWD1C=XZ5A@mail.gmail.com>
Date: Mon, 04 Aug 2025 18:34:15 +0200
Message-ID: <87o6sv11x4.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Paul Moore <paul@paul-moore.com> writes:

> On Wed, Jul 23, 2025 at 2:27=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> This key can be downloaded from https://github.com/stephensmalley.gpg
>> or
>> https://keyserver.ubuntu.com/pks/lookup?op=3Dget&search=3D0x578c4211832f=
0a7ea2c5a7c221a46e603f744ecf
>>
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> ---
>>  SECURITY.md | 2 ++
>>  1 file changed, 2 insertions(+)
>
> I have verified that the GPG key identified by the fingerprint in the
> patch belongs to Stephen.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

