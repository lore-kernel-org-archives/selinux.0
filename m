Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC463B27E3
	for <selinux@vger.kernel.org>; Mon, 10 Aug 2026 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355269; cv=none; b=isIC7k2BIvOM95AIoxg+M+AxXP+PWhtzqrqCY+DrxDdPTZbLz7EGCuipYDtVvGtIUUFEp/nUJl8aV4Sa1+bl0quv0RfppUZMVDnb2E0pSa6GXhYHVWt+7V1SUdh2K/UaB6MWznulfakw7gqCCGbRCpnrio5nsQKksrLecKo7e6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355269; c=relaxed/simple;
	bh=wXEpZU/0kstEU71/xtRpv2wxJVBJ6/nHeJmR4Q7Zp9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OmzTqvK7P3huoZQjFY05RsboATv7goL5fVd6tjkPAI6aIuXlggiB1hoOS5AFjRDs/MxMjLqZ3kSH1GNfKGSDPeAQ8bX4YMLPfdHeBFOiCPeotnxCYT8jeGQ6Ve3XRSg60NggvwwmRXLWVGOUAfz7+lGT5x4ERZFOGQaNEK9lMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cs0rxWsw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cs0rxWsw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786355266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLvLojsUrdIzNEcten8ZntpPdMfeGN79JWPiz9zfZOs=;
	b=cs0rxWswG4WLNcYyYA2vv1WmURaBzp1dTNT8EECwPiP/nnD8+NLnZnvrPqInZ04vb3fCiu
	VdxDJEH7bqxmOlym/2SrA3fFf963l5fYhMjFSOGhH94L9bRTDoO30nZrWSQTncf6geyfSC
	W7p6oH2zL6eomfjhiXOKTyA6vBccAh8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-s-i2Y0sbNGOwaQnPVNsbOg-1; Mon,
 10 Aug 2026 05:47:43 -0400
X-MC-Unique: s-i2Y0sbNGOwaQnPVNsbOg-1
X-Mimecast-MFC-AGG-ID: s-i2Y0sbNGOwaQnPVNsbOg_1786355262
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EBC0195609F;
	Mon, 10 Aug 2026 09:47:41 +0000 (UTC)
Received: from localhost (unknown [10.44.32.165])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 34E943001D38;
	Mon, 10 Aug 2026 09:47:40 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, omosnace@redhat.com, jason@perfinion.com,
 paul@paul-moore.com, jgsegitz@suse.de
Subject: Re: [PATCH v2] SECURITY.md: Codify the maintainer process
In-Reply-To: <CAEjxPJ6a6d3+SDgq+9BV3Z7in0odjWxdZ7_c757yRY_EU4HMbQ@mail.gmail.com>
References: <20260803173951.46352-2-stephen.smalley.work@gmail.com>
 <CAEjxPJ6a6d3+SDgq+9BV3Z7in0odjWxdZ7_c757yRY_EU4HMbQ@mail.gmail.com>
Date: Mon, 10 Aug 2026 11:47:39 +0200
Message-ID: <87mruucnno.fsf@redhat.com>
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

> On Mon, Aug 3, 2026 at 1:40=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> From: Jason Zaman <jason@perfinion.com>
>>
>> Since security issues are quite rare, best to codify the processes so
>> when they come along we can fall back to this and don't forget any
>> steps.
>>
>> Signed-off-by: Jason Zaman <jason@perfinion.com>
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

>
> Sorry to nag but would like at least one other selinux maintainer to
> ack this before merging.
>
>> ---
>> v2 makes the changes suggested by reviewers and drops the RFC/draft
>> language.
>>
>>  SECURITY.md | 44 +++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 39 insertions(+), 5 deletions(-)
>>
>> diff --git a/SECURITY.md b/SECURITY.md
>> index 49c40e97..52ab863c 100644
>> --- a/SECURITY.md
>> +++ b/SECURITY.md
>> @@ -13,16 +13,23 @@ involved.
>>
>>  ### Reporting Problems
>>
>> +Note that issues that depend on attacker-controlled policy can be
>> +reported as regular bugs to the public selinux@vger.kernel.org mailing
>> +list and do not need to follow this process.
>> +
>>  For serious problems or security vulnerabilities in the SELinux kernel =
code
>>  please refer to the SELinux Kernel Subsystem Security Policy in the lin=
k below:
>>
>>  * https://github.com/SELinuxProject/selinux-kernel/blob/main/SECURITY.md
>>
>> -Problems with the SELinux userspace that are not suitable for immediate=
 public
>> -disclosure should be emailed to the current SELinux userspace maintaine=
rs, the
>> -list is below. We typically request at most a 90 day time period to add=
ress
>> -the issue before it is made public, but we will make every effort to ad=
dress
>> -the issue as quickly as possible and shorten the disclosure window.
>> +Problems with the SELinux userspace that are not suitable for
>> +immediate public disclosure should be reported using
>> +[GitHub private vulnerability reporting](https://github.com/SELinuxProj=
ect/selinux/security)
>> +or emailed to the current SELinux userspace maintainers - the list is
>> +below. We typically request at most a 90 day time period to address
>> +the issue before it is made public, but we will make every effort to
>> +address the issue as quickly as possible and shorten the disclosure
>> +window.
>>
>>  * Petr Lautrbach, plautrba@redhat.com
>>  * James Carter, jwcart2@gmail.com
>> @@ -35,6 +42,10 @@ the issue as quickly as possible and shorten the disc=
losure window.
>>    *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0E=
AF
>>  * Ondrej Mosnacek, omosnace@redhat.com
>>
>> +If unsure about whether an issue is in kernel or userspace, feel free
>> +to send it to both the kernel and userspace maintainers and the
>> +maintainers will handle it internally.
>> +
>>  ### Resolving Sensitive Security Issues
>>
>>  Upon disclosure of a bug, the maintainers should work together to inves=
tigate
>> @@ -57,3 +68,26 @@ lists.
>>
>>  * https://oss-security.openwall.org/wiki/mailing-lists/distros
>>  * https://oss-security.openwall.org/wiki/mailing-lists/oss-security
>> +
>> +### Maintainer Process
>> +
>> +This is the process maintainers will follow upon receiving a security n=
otification.
>> +
>> +1. Make sure all appropriate SELinux maintainers are notified. Regardle=
ss of
>> +   which maintainer was initially contacted, others should be looped in=
. This
>> +   may also include the kernel maintainers if relevant to the issue.
>> +2. After an initial review of the issue, maintainers will agree on one =
person
>> +   to be main point of contact. The response to the initial mail may co=
me from a
>> +   different maintainer. If the initial mail was PGP signed/encrypted, =
the
>> +   replies will also be PGP signed/encrypted with one of the above keys.
>> +3. Maintainers will work together in private to verify and fix the issu=
e. For
>> +   larger fixes, this might involve a github private fork within a draf=
t github
>> +   security advisory.
>> +4. Maintainers will prepare the fix as soon as reasonable. Maintainers =
may
>> +   invite the reporter to the draft security advisory or private fork t=
o help
>> +   verifying the fix.
>> +5. We will aim to release the fix publicly quickly, but may request an =
embargo
>> +   period up to 90 days if the complexity of the issue requires it or if
>> +   severity of the issue requires coordinated rollout amongst distros.
>> +6. Public disclosure will involve pushing the fix to the public repo and
>> +   publishing the security advisory on Github and to the mailing list.
>> --
>> 2.55.0
>>

