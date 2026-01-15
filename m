Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A8309EFB
	for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505403; cv=none; b=J4KP+T02zKo5ZiU2NhlhYWqKfOevyAFoBxFdhLw3jrw3uMqwgE/ngpVbjyMbqxrBxac7LO6XuKtAsXPOyo1kL+mLufAFqVeCpJwq662nZc3jYXm66lSFc81KqQlE/YoNEwGbi+3bN+1wnz/ZAcU6jtw0MlGdgh0+p+GhBJ9cL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505403; c=relaxed/simple;
	bh=n8VxPysbZ0u5xKCIn6w5IkF601T1IK0J4X6Lg437rXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HaijPN/VgbO55SJWJDv8qxxPqd/+Ks2sd43tvWrsOj9TAgS/H9OJMBctz0BDfL9KPd6/JmTwgg3m99z7pYnrvCRWUeoMViah4Jz4JqFtwD4yDJYZ8l3syKSKUct0Na7JxwcjfbUlLbrM87IMGtY2RbJeageVj24qApBv2rlt7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boTbUC9k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boTbUC9k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768505397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AdtRFqhnj2lQZHVoU8YSvj5WXAdq+S4Lxo7i4UTl4Gw=;
	b=boTbUC9kDSR6YrB6cY1mBBLbFBMdb5pU0ukRjdAyh43fvGApR66WSkzTGkYG/Q6mDxRgSH
	K4dYAk6dteQvGkf237Xs4VbaSEqRadFr4PZSCm8ZYI1dxhsjVVKrmrbjJDvOpt4JGIbV4J
	pfdyf26M51rlontx0IJUXewqq77HTUA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-bhJWnd2BOQOYWgsothoF_w-1; Thu,
 15 Jan 2026 14:29:56 -0500
X-MC-Unique: bhJWnd2BOQOYWgsothoF_w-1
X-Mimecast-MFC-AGG-ID: bhJWnd2BOQOYWgsothoF_w_1768505395
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 743FC180034D;
	Thu, 15 Jan 2026 19:29:55 +0000 (UTC)
Received: from localhost (unknown [10.45.224.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9A9119560A7;
	Thu, 15 Jan 2026 19:29:54 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] SECURITY.md: add lautrbach@redhat.com gpg fingerprint
In-Reply-To: <CAHC9VhSeoyDPyK=Ph6_ksTwW3YrCaoHSztfPDnEGAxSsCYNPLw@mail.gmail.com>
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
 <87jyxi24jd.fsf@redhat.com>
 <CAHC9VhS=LNhFxHjxdeiCD2nThXPeCUibcos5wNTqox4uvVO5ug@mail.gmail.com>
 <CAHC9VhSeoyDPyK=Ph6_ksTwW3YrCaoHSztfPDnEGAxSsCYNPLw@mail.gmail.com>
Date: Thu, 15 Jan 2026 20:29:53 +0100
Message-ID: <87h5sm1xou.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Paul Moore <paul@paul-moore.com> writes:

> On Thu, Jan 15, 2026 at 1:30=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
>> On Thu, Jan 15, 2026 at 12:02=E2=80=AFPM Petr Lautrbach <lautrbach@redha=
t.com> wrote:
>> > Paul Moore <paul@paul-moore.com> writes:
>> >
>> > > On Thu, Jan 15, 2026 at 3:01=E2=80=AFAM Petr Lautrbach <lautrbach@re=
dhat.com> wrote:
>> > >>
>> > >> "68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E" is not a subke=
y.
>> > >
>> > > Okay, in this case you need to get this new key signed by other
>> > > individuals trusted by the SELinux community before we can consider
>> > > including it in the SECURITY.md file.
>> > >
>> >
>> > My idea was:
>> >
>> > Before this patch my address was there without gpg fingerprint. It mea=
ns
>> > that I could be contacted directly via un-encrypted email.
>>
>> Yes.  However, I believe there are usually different levels of trust
>> associated with plaintext and encrypted email.
>>
>> > The key I used in this patch was already used for SELinux userspace
>> > release ...
>>
>> I think the understanding was that release signing would be done by
>> individuals with a GPG key signed by others in the SELinux community
>> to help establish trust.  However, as you pointed out I don't think we
>> documented that requirement or enforced it properly, we should do so
>> in the future.
>>
>> > ... public key is available at 2 different locations connected to
>> > me - github (I'm part of SELinux organization) and
>> > plautrba.fedorapeople.org (I'm a packager for 15+ years) and it's also
>> > used in Fedora [1] and RHEL [2] - only Red Hat employees can push ther=
e and it
>> > was me who pushed [3]. That being said I expected that the key is
>> > already trusted due to all the records.
>>
>> While that demonstrates some level of trust between that user/key and
>> those organizations (GH, Fedora, IBM/RH), it doesn't establish a level
>> of trust between that user/key and the SELinux community.
>
> ... and I should say that I have no reason to believe you are not the
> Good Petr who is a valued member of the SELinux community, but there
> are rumors of an Evil Petr and I just want to make sure we do the
> right thing from a community perspective ;)
>
> Apologies for what may seem like excessive pedantry on this.
>

You should probably consider to remove bachradsusi account from Github
SELinuxProject org and remove them commit rights. They provided
https://github.com/bachradsusi.gpg with public keys they can't confirm
that private keys are really in hands of Petr:

E853C1848B0185CF42864DF363A8AD4B982C4373 - uses SHA1 and private keys
are lost - according to me, so it would be better to contact Petr with
encrypted message and ask him to sign a response. But it could take some
time to get a response for him.

68D21823342A13683AEB3E4EFB4C685B5DC1C13E - not signed by any SELinux
team member.

There's a risk that they'll change released files and files signatures.

Petr

