Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43033FDBEF
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807141; cv=none; b=jRaQxAuivW3LLDYE7KLmu3SVudOL3EH4fOfN4IHhszjwV3AOxP8lxMt6QXbEkKsoRYkgH7bKGkBjx+KaKTZY0rnwKNAvupyamitiZkwWnNR9J4XGr70OWxafZ0UK+o90txIbQQjNYIiTl8YNbIEwk6zo/qCaQXax5XeXQ21pT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807141; c=relaxed/simple;
	bh=/wfQkImIAS8YsjDrFWErKaE4zwaHtr2gxw/8MbjesXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tcjMCXRP10zaMUwx4AfpLEV/c/6DS9vrNCK5LzX32cd4WEsWvSSsHYucKSA5g93IbQzZ/EvxQH1beVuGVurRWmCekH9d2L/Eue+3Is+t4MtnNEDNM3z7VceIUBUpJ+3bP9cwOZLFQEkrd7cu5ErrrjoZd+xzzFcvQKdzDNHu/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSbQ8Mf8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSbQ8Mf8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779807138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wfQkImIAS8YsjDrFWErKaE4zwaHtr2gxw/8MbjesXI=;
	b=JSbQ8Mf80myyIo7Wlx41m1MJIjTnJCvgDIhHY+0HXSpfOMl6bMbxwBYg6x+iCDszY89cKV
	7bx6pTaPj1N9ITspghgJ2o0veFEIxKig8eixL98lO0gmmdjKKcDDqjsvfvqyy9YU1gQ97t
	BkGVMWQRtDXk/PnH0XdUzUwwi2k+AFA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-y7leA3vxMQOGdyLqd1h8tQ-1; Tue,
 26 May 2026 10:52:17 -0400
X-MC-Unique: y7leA3vxMQOGdyLqd1h8tQ-1
X-Mimecast-MFC-AGG-ID: y7leA3vxMQOGdyLqd1h8tQ_1779807136
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D397E19560B3;
	Tue, 26 May 2026 14:52:15 +0000 (UTC)
Received: from localhost (unknown [10.44.33.146])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3814A300019F;
	Tue, 26 May 2026 14:52:15 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, SElinux list
 <selinux@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>,
 James Carter <jwcart2@gmail.com>, Jason Zaman <perfinion@gentoo.org>,
 Jeffrey Vander Stoep <jeffv@google.com>
Subject: Re: Minimum kernel version for SELinux userspace
In-Reply-To: <CAEjxPJ5OLy3NVut1PW_vAVwR+qUBTv+oq2Ngt3R_Rk=Hx2FgXw@mail.gmail.com>
References: <CAEjxPJ4bb+sBUPPVYbwkay7w6k1NJx_6adiLVbHnYa5vjb5SUA@mail.gmail.com>
 <CAEjxPJ5OLy3NVut1PW_vAVwR+qUBTv+oq2Ngt3R_Rk=Hx2FgXw@mail.gmail.com>
Date: Tue, 26 May 2026 16:52:14 +0200
Message-ID: <87mrxmnrz5.fsf@redhat.com>
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

> On Thu, May 21, 2026 at 3:33=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> There are newer kernel APIs we could leverage to further improve the
>> SELinux userspace, but doing so would require setting a minimum kernel
>> version for new SELinux userspace releases. Not sure we've done that
>> previously.
>>
>> In particular, I'd like to be able to use some or all of the following:
>> open_tree() + move_mount(): v5.2
>> openat2(RESOLVE_*): v5.6
>> mount_setattr(): v5.12
>>
>> The question is what if any of these can we assume to be the minimum
>> kernel version going forward?
>> - kernel.org LTS kernels span 5.10 through 6.18 currently.
>> - Android common kernels track LTS kernels.
>> - RHEL 9 kernel was 5.14-based.
>> - Ubuntu 22.04 kernel was 5.15-based.
>> - Debian 12 kernel was 6.1-based.
>>
>> I would guess we could set the minimum kernel version to v5.12 and use
>> all of these interfaces, at least in code not used by Android.
>> Thoughts?
>
> As further context, I'm only looking at open_tree(), move_mount(), and
> mount_setattr() for sandbox/seunshare.c and at openat2(RESOLVE_*) for
> sandbox/seunshare.c, restorecond/watch.c, and
> libselinux/src/selinux_restorecon.c. None of these are used today by
> Android AFAIK, although selinux_restorecon() was based on
> selinux_android_restorecon() and might be re-unified with it some day.
>
> It would likely also be helpful to understand whether it is worth
> further rewriting of sandbox/seunshare.c or if it is likely to be
> obsoleted/replaced in the near term.

We don't have any specific plan other than support it in existing
version for release RHELs

For future, I'd say that using bwrap could make things much easier.
And I would not mind to move sandbox out of SELinuxProject/selinux to its
own repository like SELinuxProject/sandbox.

Petr

