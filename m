Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB272F37
	for <selinux@vger.kernel.org>; Tue, 18 Mar 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303468; cv=none; b=oMCk+O60su7QN7Rc4PF7/AhMlJjpTU4dvgzstRGaCJVBPBvIxdAfKLJrDe2niY9wDa5824D2mOwjQHNAc1cZRfprLb8bwEonfzdqbnoX6qprAgwcOe4QBUZH+BGA/GteNaBSwXI0m1uhNLRDdMCcMyGhQGHHwC5SEtdTyPh+LUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303468; c=relaxed/simple;
	bh=u6JXKDdN7p+RD8/eB3tELG8o72KuHSsiMQnNrxp/x6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K2SmowhPS+8IerZIaKIYhMjsrlDozlPmiCtPNYxJnmIE76F1dZyILke2akhwTWXjMxBRgZQCRnmyjvLh/iSvc2ZgtFDXv1I/pU7k6+GvlMgkI5VArGs4OXL7fs2kp2XtG/N6RCMowbGF4xY3JID0Cnxr8nChnPrDlE8m28JS7SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmnZgwXN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmnZgwXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742303461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6JXKDdN7p+RD8/eB3tELG8o72KuHSsiMQnNrxp/x6c=;
	b=VmnZgwXND7GzIH+dgQ5IkPwGHdTAlK7jCRg9lfIiWGY3OA/2nZE0Gdduh+oW4k4D/TJnuk
	vvqFXmcMqi9jdnlhSMrRpZ1lvqDFF6FQo0cZlFdKocoRIPcDvQ/0VsOcu7ogYpUESaQxVz
	OvLIko+A1FXjmj4DgHBD6cNzWGwCc3Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-inKUovQiNqWmPJCLHy9Urw-1; Tue,
 18 Mar 2025 09:10:41 -0400
X-MC-Unique: inKUovQiNqWmPJCLHy9Urw-1
X-Mimecast-MFC-AGG-ID: inKUovQiNqWmPJCLHy9Urw_1742303440
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C37DC1828A8D;
	Tue, 18 Mar 2025 13:10:39 +0000 (UTC)
Received: from localhost (unknown [10.45.224.166])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 225CD1828A83;
	Tue, 18 Mar 2025 13:10:38 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Cathy Hu <cahu@suse.de>, fvogt@suse.com, selinux@suse.de, Stephen
 Smalley <stephen.smalley.work@gmail.com>
Subject: Re: Question regarding restorecon and btrfs read-only snapshots
In-Reply-To: <CAEjxPJ4DZs_1dPuO87UPpuvQL-PEq6zq9KA64SQvzsT1Mq8CqQ@mail.gmail.com>
References: <98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@suse.de>
 <87senb7mt4.fsf@redhat.com> <8ca3a1ed-0f53-4da9-a86b-75699f306f8c@suse.de>
 <87plif7egm.fsf@redhat.com>
 <CAEjxPJ4DZs_1dPuO87UPpuvQL-PEq6zq9KA64SQvzsT1Mq8CqQ@mail.gmail.com>
Date: Tue, 18 Mar 2025 14:10:37 +0100
Message-ID: <87msdi7acy.fsf@redhat.com>
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

> On Mon, Mar 17, 2025 at 1:32=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
>>
>> Cathy Hu <cahu@suse.de> writes:
>>
>> > On 17.03.25 15:29, Petr Lautrbach wrote:
>> >>
>> >> You could use `-e <directory>` to exclude read only subdirectories.
>> >>
>> >
>> > Yes that is possible, but also requires a manual change by the user to=
 set
>> > this up together with the snapshot (same as telling them to add <<none=
>>),
>> > which we would like to avoid.
>>
>> Your -relabel.service's are generated and so can be restorecon options
>> there.
>>
>> Fedora uses fixfiles -
>> https://github.com/SELinuxProject/selinux/blob/main/policycoreutils/scri=
pts/fixfiles
>> - which detects ro filesystems and skip them.
>
> We already have logic in libselinux/src/selinux_restorecon.c to
> exclude filesystems that lack seclabel support; should we augment this
> to also exclude read-only filesystems to avoid the need to work around
> this in all callers?
>

https://github.com/SELinuxProject/selinux/blob/main/libselinux/src/selinux_=
restorecon.c#L238

You're right, I didn't know about that.

I think it would make sense to exclude also `ro` mount points.

>>
>>
>>
>> > Is there a reason why these r-o subvolumes are not skipped by default?
>> > Could they be skipped without a problem and it is just missing the imp=
lementation?
>> >
>> > Thanks :)
>> >
>> > Kind regards,
>> > Cathy
>> >

