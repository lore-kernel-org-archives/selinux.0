Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD94325485
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949445; cv=none; b=nAtMQVIFb27pMcmkUgB/YFgvLsWDBos960a1EHKhcHKAZ2sCu7HjCxvNgonl5NAwislX5E5iwZfu0Te/dEWEswjHyhIyloD3ynph/KdYqkTNQOwAbklK5xQO61F5ok98leGNWrY8rGH82bWO1pXWSEAeoUeJLaxAzemdpTBjRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949445; c=relaxed/simple;
	bh=q7uBSSU2V93TMAL8Qx7Ux9A6ENTDnQ9AHOgYZJ7wtas=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pmbtT6glPI48yh1UOSi+wlKbtFUgZzSSDjHZn28pnnbfAJ7Oyg0KYMvuZcIUjSJavxGpotDHUEbDyXwdoVPdw8XyYpF6VoPEymO266nxNXpACkXkgjw0q6q9a8LF+4MAn9oKFP8yJmC3L0TkTVG0g1Umhdnt7SICYOX+uGVPupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OidAlqZN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OidAlqZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779949442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q7uBSSU2V93TMAL8Qx7Ux9A6ENTDnQ9AHOgYZJ7wtas=;
	b=OidAlqZNNRrhYsGWHrHCYaAbOzECgYL8X1Qz2IPb3WbAVG9y7JTvU25oxrXUQ7Onj+877/
	ua/mXaqIXa701cBk8VbzbZBERmHS5gSZqsd2WcqBbqKkUjmzoGQIxMhjcMnNnD3nKBpdGl
	3wdMpjo7l898sXLPV3DjDu/o5DVoDDA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-SQ1E0fcjPqmrgfk9fJdATA-1; Thu,
 28 May 2026 02:23:58 -0400
X-MC-Unique: SQ1E0fcjPqmrgfk9fJdATA-1
X-Mimecast-MFC-AGG-ID: SQ1E0fcjPqmrgfk9fJdATA_1779949436
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 559B119560B1;
	Thu, 28 May 2026 06:23:56 +0000 (UTC)
Received: from localhost (unknown [10.44.32.147])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB2721800357;
	Thu, 28 May 2026 06:23:52 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>, Paul Moore
 <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, James Carter
 <jwcart2@gmail.com>, Jason Zaman <perfinion@gentoo.org>, Jeffrey Vander
 Stoep <jeffv@google.com>
Subject: Re: Minimum kernel version for SELinux userspace
In-Reply-To: <CAEjxPJ7y-q=sFpd51ci5OvH9Qvf5-jx-7oTWOrrrhKSvF2YMng@mail.gmail.com>
References: <CAEjxPJ4bb+sBUPPVYbwkay7w6k1NJx_6adiLVbHnYa5vjb5SUA@mail.gmail.com>
 <CAEjxPJ5OLy3NVut1PW_vAVwR+qUBTv+oq2Ngt3R_Rk=Hx2FgXw@mail.gmail.com>
 <87mrxmnrz5.fsf@redhat.com>
 <CAEjxPJ7y-q=sFpd51ci5OvH9Qvf5-jx-7oTWOrrrhKSvF2YMng@mail.gmail.com>
Date: Thu, 28 May 2026 08:23:51 +0200
Message-ID: <87h5nsnjbc.fsf@redhat.com>
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

> On Tue, May 26, 2026 at 10:52=E2=80=AFAM Petr Lautrbach <plautrba@redhat.=
com> wrote:
>>
>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>
>> > On Thu, May 21, 2026 at 3:33=E2=80=AFPM Stephen Smalley
>> > <stephen.smalley.work@gmail.com> wrote:
>> >>
>> >> There are newer kernel APIs we could leverage to further improve the
>> >> SELinux userspace, but doing so would require setting a minimum kernel
>> >> version for new SELinux userspace releases. Not sure we've done that
>> >> previously.
>> >>
>> >> In particular, I'd like to be able to use some or all of the followin=
g:
>> >> open_tree() + move_mount(): v5.2
>> >> openat2(RESOLVE_*): v5.6
>> >> mount_setattr(): v5.12
>> >>
>> >> The question is what if any of these can we assume to be the minimum
>> >> kernel version going forward?
>> >> - kernel.org LTS kernels span 5.10 through 6.18 currently.
>> >> - Android common kernels track LTS kernels.
>> >> - RHEL 9 kernel was 5.14-based.
>> >> - Ubuntu 22.04 kernel was 5.15-based.
>> >> - Debian 12 kernel was 6.1-based.
>> >>
>> >> I would guess we could set the minimum kernel version to v5.12 and use
>> >> all of these interfaces, at least in code not used by Android.
>> >> Thoughts?
>> >
>> > As further context, I'm only looking at open_tree(), move_mount(), and
>> > mount_setattr() for sandbox/seunshare.c and at openat2(RESOLVE_*) for
>> > sandbox/seunshare.c, restorecond/watch.c, and
>> > libselinux/src/selinux_restorecon.c. None of these are used today by
>> > Android AFAIK, although selinux_restorecon() was based on
>> > selinux_android_restorecon() and might be re-unified with it some day.
>> >
>> > It would likely also be helpful to understand whether it is worth
>> > further rewriting of sandbox/seunshare.c or if it is likely to be
>> > obsoleted/replaced in the near term.
>>
>> We don't have any specific plan other than support it in existing
>> version for release RHELs
>>
>> For future, I'd say that using bwrap could make things much easier.
>> And I would not mind to move sandbox out of SELinuxProject/selinux to its
>> own repository like SELinuxProject/sandbox.
>
> Ok, do you have an opinion on setting a minimum kernel version for
> future SELinux userspace releases (not 3.11, but say 3.12 and later)
> so we can start using some or all of these interfaces without
> requiring backward-compatibility fallbacks?

The only longterm kernel which does not support mount_setattr() seems to
be 5.10.257. And you need this only for seunshare which is not a core
component. Therefore I'd set the minimum on mount_setattr() v5.12 and
label seunshare as unsupported and let it fail on older kernels.

Petr

