Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCFF6A348
	for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963639; cv=none; b=rjPuYb14MqxvvOx+1v2tSZkaq0BxP2YKxhfk8kJn2mQNauIDTXjbLD9TiuoA/MufPY9GMQMm9G5eJgqLwjuYt96SjbChTF6zVr/9wXzzSzHtHgqoCkX4nSFojTspmNGTqcAeftVynKI3lKRzZm6PNOQWKgl8VWN0qCWCLFF+Kcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963639; c=relaxed/simple;
	bh=j/v78hVY8poJ8hn7cYD3SkZQoLRPkgbmJayS6tmqB/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lelxjm6FQaXgXxe7u+Nv+TZicUeAN/MtG/oI2kTS4w1A3ypZmok0gw6ABB1NLCL9HCo+WzU1sV092H5EBJnDt4eSBzbWKB4m9cJNDLGzgMhPVa8g09stXFJH2Xj99Z54+K+6zdrgKBR/PwPmnsj4I5S+W9GDbYs75S5UDDd99U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNE4s5iI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNE4s5iI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710963636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/v78hVY8poJ8hn7cYD3SkZQoLRPkgbmJayS6tmqB/k=;
	b=eNE4s5iIIp2yP8otvNpozLYCCqBRbLK+poYpXFfkxogPtung5Vp778EzfS/KzkRlEHa7j2
	G3mSUs+ie0iONM3jZcKH/gBqEXKeaBwig1hGuRmwGh7JdwVay01VH0wwY5l0jue4CJ2kFe
	pEYAbQ/gcOOkuYtp4wDuOFhCdqqjj/o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-lW7rukleMOu-0Du7h_M6lQ-1; Wed,
 20 Mar 2024 15:40:32 -0400
X-MC-Unique: lW7rukleMOu-0Du7h_M6lQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B70A380673E;
	Wed, 20 Mar 2024 19:40:30 +0000 (UTC)
Received: from localhost (unknown [10.45.224.71])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0C46F111E404;
	Wed, 20 Mar 2024 19:40:29 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: Where to look for system services modified for SELinux
In-Reply-To: <87msqs90lf.fsf@redhat.com>
References: <41f73ba5-7d43-4a19-a373-84f05c03d95b.ref@schaufler-ca.com>
 <41f73ba5-7d43-4a19-a373-84f05c03d95b@schaufler-ca.com>
 <CAEjxPJ7nCf1SYRb5cAg=wFOM5r8C-y9XNJAijfU3dVxyYuYQ+g@mail.gmail.com>
 <29fcb989-bfc8-4afb-a6b0-4474f32ae996@schaufler-ca.com>
 <87msqs90lf.fsf@redhat.com>
Date: Wed, 20 Mar 2024 20:40:25 +0100
Message-ID: <87jzlw8zfa.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Petr Lautrbach <plautrba@redhat.com> writes:

> Casey Schaufler <casey@schaufler-ca.com> writes:
>
>> On 3/20/2024 8:50 AM, Stephen Smalley wrote:
>>> On Tue, Mar 19, 2024 at 7:03=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
>>>> It would be very helpful if I could find documentation about, or even a
>>>> list of, system services that have been enhanced in support of SELinux.
>>>> I'm doing this as part of the LSM stacking effort, looking for things =
that
>>>> may require additional work for the multiple LSM environment. I already
>>>> know about systemd, dbus and the pam module.
>>> (re-send in plaintext mode, with some additional info appended at the e=
nd)
>>>
>>> There is an old list at
>>> https://github.com/SELinuxProject/selinux/wiki/Userspace-Packages
>>>
>>> But the only way to get an accurate up-to-date list is to use your
>>> favorite package manager and ask it for the list of all packages that
>>> depend on libselinux. That will be more than just services of course.
>>> Technically that might not get all of them since some could just be
>>> directly using the xattr system calls, the /proc/pid/attr interface,
>>> and/or the /sys/fs/selinux interface without using the libselinux
>>> wrappers.
>>>
>>> Some SELinux-aware services besides the ones you listed above and not
>>> in the original list on GitHub include nscd (part of glibc), sssd,
>>> Xorg, PostgreSQL, libvirtd, all the modern cron variants, and various
>>> container runtimes/daemons. The extent to which they use SELinux APIs
>>> varies though, from those that are merely getting/setting SELinux
>>> process or file contexts to full-fledged userspace object managers /
>>> policy enforcers.
>>>
>>> Then there is a completely different list for Android, but not sure
>>> you care about it.
>>
>> Thank you, that's been a big help. Turns out Fedora 39 installs 93
>> packages with "selinux" in the title. Yoiks!
>
> Title could be misleading as there are -selinux packages with custom
> policies.
>
> But there's about 95 packages which require libselinux:
>
> $ sudo dnf repoquery --disablerepo=3D\* --enablerepo=3Dfedora --whatrequi=
res=3D'libselinux.so.1()(64bit)' --qf '%{sourcerpm}' | uniq=20

sourcegraph found 103 .spec files with BuildRequires: libselinux-devel

https://sourcegraph.com/search?q=3Dcontext:global+repo:%5Esrc.fedoraproject=
.org/+BuildRequires:+libselinux-devel&patternType=3Dregexp&sm=3D0

