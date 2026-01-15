Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F32C028F
	for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496525; cv=none; b=eX8QtRWaT2D3l8Iush9a8cal5duXNwJIJWCZNYl1oLbntsjwJFzhJfzj8YLu5HiYd1lQHJvuw8z3s5ODgFTl6ljAHTj6tYH6UKEKXl3uaLFk+2lMzuj8kazy4dBQU8nV8VjK7vlumAK5VpRW1Mj+vPfjwJrdpYGtundfs2UaovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496525; c=relaxed/simple;
	bh=WR8pcxlcqN2uspbT4UutBk0CmJ7DfFWtIMh5e1/jKeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oZLvZX2E4xE7nuzJHc9U0ouDxmcR20gRi3o1N1FPWFDpmU85KyC2n+rhXc4CRP0XVGPyvmwmayS2tY3+3iXBWptV0yVh49D2duS07HKnnmNAGl1P5czpGFkWncGzjxWbtAiZuRrIAoNyV2gnI7HSwOKXJXDXrhjM25svw8ZBexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WdBwTnIh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdBwTnIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768496522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10lMOvc/m0GUoSTUVm8irnB0p4aTqZIRPwTlIr0Zp4Q=;
	b=WdBwTnIhwZlV0Jtfh30tCkXqM5mtW4Oa+TmZHM0IS93zHZpQp8I8/H0/fqx7icbRgecT79
	oRmNXXv1h/K/X+BHN2Opknb4JH5Sxw2OkjnD55zjoF0gWRPu8tB+tKmgJWObjOoQO4ja2x
	kkZ2GZxiPMX+71lHBhye+p1Imz7TLME=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-H8R1Gbu8MPaORGgbqu4jFA-1; Thu,
 15 Jan 2026 12:02:01 -0500
X-MC-Unique: H8R1Gbu8MPaORGgbqu4jFA-1
X-Mimecast-MFC-AGG-ID: H8R1Gbu8MPaORGgbqu4jFA_1768496520
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 467A41956070;
	Thu, 15 Jan 2026 17:02:00 +0000 (UTC)
Received: from localhost (unknown [10.45.224.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5C303001DB9;
	Thu, 15 Jan 2026 17:01:59 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] SECURITY.md: add lautrbach@redhat.com gpg fingerprint
In-Reply-To: <CAHC9VhQHrnkMO0JMtDyEnsmgMJisSU5bs76bzLYXGirc8uDYmA@mail.gmail.com>
References: <20260105174020.887724-1-lautrbach@redhat.com>
 <CAHC9VhRaKE2fuXik5xxaw5i1f9QgveFj0_FgzMVyRCHebueZGQ@mail.gmail.com>
 <87h5sxvd52.fsf@redhat.com>
 <CAHC9VhQmYLMqFzytgauijn_C6TXksBVsptEdNb2ZcyKFT8fsCg@mail.gmail.com>
 <87cy3kv5w2.fsf@redhat.com>
 <CAHC9VhTcEFHNJcTSbvWFU4gKpAUBg-8cLAfushX8CrhnT41SbQ@mail.gmail.com>
 <873448ujz1.fsf@redhat.com>
 <CAHC9VhSBGr=6izQCmWwOcg85S3G02aDMgSrQ-bGEf-sR9RYtVg@mail.gmail.com>
 <87pl7b1f0n.fsf@redhat.com>
 <CAHC9VhQHrnkMO0JMtDyEnsmgMJisSU5bs76bzLYXGirc8uDYmA@mail.gmail.com>
Date: Thu, 15 Jan 2026 18:01:58 +0100
Message-ID: <87jyxi24jd.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Paul Moore <paul@paul-moore.com> writes:

> On Thu, Jan 15, 2026 at 3:01=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
>>
>> "68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E" is not a subkey.
>
> Okay, in this case you need to get this new key signed by other
> individuals trusted by the SELinux community before we can consider
> including it in the SECURITY.md file.
>

My idea was:

Before this patch my address was there without gpg fingerprint. It means
that I could be contacted directly via un-encrypted email.

The key I used in this patch was already used for SELinux userspace
release, public key is available at 2 different locations connected to
me - github (I'm part of SELinux organization) and
plautrba.fedorapeople.org (I'm a packager for 15+ years) and it's also
used in Fedora [1] and RHEL [2] - only Red Hat employees can push there and=
 it
was me who pushed [3]. That being said I expected that the key is
already trusted due to all the records.


But I see your point. I'll send another patch which will remove my address =
from SECURITY.md
and when the key is signed, I'll return it back.


[1] https://src.fedoraproject.org/rpms/policycoreutils/blob/rawhide/f/bachr=
adsusi.gpg
[2] https://gitlab.com/redhat/centos-stream/rpms/policycoreutils/-/blob/c10=
s/bachradsusi.gpg?ref_type=3Dheads
[3] https://gitlab.com/redhat/centos-stream/rpms/policycoreutils/-/commit/0=
2af42ef7ea24c279708ea83cc2698b738bdee8c

Petr

