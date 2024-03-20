Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FA885297
	for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962120; cv=none; b=F0FdDVIysg7u0tQG+uWUFXHZuiIboVFk6Sk5yICLXyny8qDpvGyZ/fEvZpm51ykn3TUVI9u1l+g9hMXjhl0dJG91TBV2NmAohlgPp9M7+WMxGy4yeg2W35AMUbCOTTJJ7XsVIu/c7A5YtAWYrpyg8/sZAHvUeV6EK57nbSJdX9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962120; c=relaxed/simple;
	bh=kIfft2pUNZ09mIU2Co3r1wtqab641rkmNva7SJpc+4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jru8opwXP3VmP+RxbZi/dqnFAiSGXBc1fRAMrNYqyPzgLLvpqvMvUi9sgMv2KtBMGRMgS53dyvJhEavyL1+ZuTLnCyvzsc8TWK7B8kYEiG1fi0jX5Q9W9sN/Ydz9osPUGFCn6qnY1TFGhkBEjJWKB6kMu9bLB3Zd+rwZsra8eRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfoSXN2d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfoSXN2d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710962117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kIfft2pUNZ09mIU2Co3r1wtqab641rkmNva7SJpc+4A=;
	b=AfoSXN2d9OY4fqdMTtN/158wpuhselux/W1QPiyNKDQdQmeq+o/BvRIjKixA2agLnyiiP1
	d5RVcyS4hOvfuzyWvpozSFuHPHzMK3UPG72+f32bSpSTQMw0yzwyX7pdtITJA7sZjHIshe
	Tox6Kzono5OVAfYgmcCTxzn7xrj1FD4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-f_BLBk-FNOylApWPq8aB0w-1; Wed, 20 Mar 2024 15:15:14 -0400
X-MC-Unique: f_BLBk-FNOylApWPq8aB0w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4D1D8007A7;
	Wed, 20 Mar 2024 19:15:13 +0000 (UTC)
Received: from localhost (unknown [10.45.224.71])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9532E492BCA;
	Wed, 20 Mar 2024 19:15:13 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley
 <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: Where to look for system services modified for SELinux
In-Reply-To: <29fcb989-bfc8-4afb-a6b0-4474f32ae996@schaufler-ca.com>
References: <41f73ba5-7d43-4a19-a373-84f05c03d95b.ref@schaufler-ca.com>
 <41f73ba5-7d43-4a19-a373-84f05c03d95b@schaufler-ca.com>
 <CAEjxPJ7nCf1SYRb5cAg=wFOM5r8C-y9XNJAijfU3dVxyYuYQ+g@mail.gmail.com>
 <29fcb989-bfc8-4afb-a6b0-4474f32ae996@schaufler-ca.com>
Date: Wed, 20 Mar 2024 20:15:08 +0100
Message-ID: <87msqs90lf.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 3/20/2024 8:50 AM, Stephen Smalley wrote:
>> On Tue, Mar 19, 2024 at 7:03=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
>>> It would be very helpful if I could find documentation about, or even a
>>> list of, system services that have been enhanced in support of SELinux.
>>> I'm doing this as part of the LSM stacking effort, looking for things t=
hat
>>> may require additional work for the multiple LSM environment. I already
>>> know about systemd, dbus and the pam module.
>> (re-send in plaintext mode, with some additional info appended at the en=
d)
>>
>> There is an old list at
>> https://github.com/SELinuxProject/selinux/wiki/Userspace-Packages
>>
>> But the only way to get an accurate up-to-date list is to use your
>> favorite package manager and ask it for the list of all packages that
>> depend on libselinux. That will be more than just services of course.
>> Technically that might not get all of them since some could just be
>> directly using the xattr system calls, the /proc/pid/attr interface,
>> and/or the /sys/fs/selinux interface without using the libselinux
>> wrappers.
>>
>> Some SELinux-aware services besides the ones you listed above and not
>> in the original list on GitHub include nscd (part of glibc), sssd,
>> Xorg, PostgreSQL, libvirtd, all the modern cron variants, and various
>> container runtimes/daemons. The extent to which they use SELinux APIs
>> varies though, from those that are merely getting/setting SELinux
>> process or file contexts to full-fledged userspace object managers /
>> policy enforcers.
>>
>> Then there is a completely different list for Android, but not sure
>> you care about it.
>
> Thank you, that's been a big help. Turns out Fedora 39 installs 93
> packages with "selinux" in the title. Yoiks!

Title could be misleading as there are -selinux packages with custom
policies.

But there's about 95 packages which require libselinux:

$ sudo dnf repoquery --disablerepo=3D\* --enablerepo=3Dfedora --whatrequire=
s=3D'libselinux.so.1()(64bit)' --qf '%{sourcerpm}' | uniq=20



