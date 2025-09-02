Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE3305078
	for <selinux@vger.kernel.org>; Tue,  2 Sep 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829542; cv=none; b=nklz1KuAssJ9SpaBEOiHlo0ymja2ThzMNd6Rxn3MOLAdrRE4fxGvckttQmDx2w2UJDuc3/5OfegmKvGtWb6K/MllZQ7jmFf7tQmFf0Qs6mP4y7JzBuNIqfK/aK8VZ5M2ueYmARbDjqYuLkA9BKBJg161lhrbiv/ucnZEWKCFJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829542; c=relaxed/simple;
	bh=2SR9P1O+YrASSHlefAO/UYRjrCdaIm4AAsUtCVxBgwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h5QRcjAzvhw6U7LmRS6VgP1wCfYa82UCoMgiVnpatHKm4amX7g/FAAznfISMLKU3leup5ET+DCoNQLZZ35nsdqiVFX8kWhOAweLSjmdcHg2beWTBvgXfVBVK6Ztbck/rd9sAFzExwcDUuB1Hwy8SgXaoUs/lgOETJmS0Z63bk1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVHq4q99; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVHq4q99"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756829539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6S9vrvf2fdzJPkWV+rZ11kMbAZVmJ3VXFSkiQqwQ/0=;
	b=HVHq4q99te5T5NWpS8g7rcmUMbfer0TYe384lW9M613amk2GaajhRwwE1sHP47DXRJ299L
	NZ4MUUpfXsv3Qak76QdwlJm6Q+nC2oCZ2AJ0TYJVWsZQExB2l1VqMpAKCEGD35VAmPmYEC
	+aKCN0WIEXCrK3YcA5enLF9hXDu5Lhk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-dY95ORt5Ozixu8cKApAr2A-1; Tue,
 02 Sep 2025 12:12:18 -0400
X-MC-Unique: dY95ORt5Ozixu8cKApAr2A-1
X-Mimecast-MFC-AGG-ID: dY95ORt5Ozixu8cKApAr2A_1756829536
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64F4F195604F;
	Tue,  2 Sep 2025 16:12:16 +0000 (UTC)
Received: from localhost (unknown [10.45.224.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B54AE19560B4;
	Tue,  2 Sep 2025 16:12:15 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, "Richard W.M. Jones"
 <rjones@redhat.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] setfiles: Add -A option to disable
 SELINUX_RESTORECON_ADD_ASSOC
In-Reply-To: <CAEjxPJ499HdhmsfX7kbchq7JFW07RD6jY5CrZMAAc3wZ+bbjXQ@mail.gmail.com>
References: <20250901143412.2904562-1-rjones@redhat.com>
 <20250901143412.2904562-2-rjones@redhat.com>
 <CAEjxPJ499HdhmsfX7kbchq7JFW07RD6jY5CrZMAAc3wZ+bbjXQ@mail.gmail.com>
Date: Tue, 02 Sep 2025 18:12:14 +0200
Message-ID: <871poo96ld.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Mon, Sep 1, 2025 at 10:34=E2=80=AFAM Richard W.M. Jones <rjones@redhat=
.com> wrote:
>>
>> SELINUX_RESTORECON_ADD_ASSOC tracks conflicts between inodes that have
>> differing contexts.  However doing this involves building a large
>> internal hashtable that stores the full path of every file examined by
>> setfiles.  For filesystems that have very large numbers of files or
>> long pathnames, this uses a lot of memory, which makes SELinux
>> relabelling in constrained memory environments infeasible.
>>
>> This adds a new setfiles -A option that disables this tracking.
>>
>> For example, using setfiles to relabel a filesystem with 15 million
>> files took 3.7GB of RAM.  Using this option, the same filesystem can
>> be relabelled in 121MB (albeit with no warnings or errors possible for
>> conflicting labels, but for our use case we don't care about that.)
>>
>> Fixes: https://issues.redhat.com/browse/RHEL-111505
>> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
>
> I don't think we usually include downstream issue tracker links in our
> upstream commit messages, but no need to re-submit just for that.

FTR in git log there are already about 60 references to bugzilla.redhat.com=
 and
issues.redhat.com is replacement of bugzilla.redhat.com for issues
reported on RHEL or CentOS. There are also bugs.debian.org,
bugs.gentoo.org, bugs.chromium.org references.


Until these issue trackers disappear, it could be a good source for another
context or related discussions.

> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
>> ---
>>  policycoreutils/setfiles/setfiles.8 | 4 ++++
>>  policycoreutils/setfiles/setfiles.c | 5 ++++-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfi=
les/setfiles.8
>> index eabf0a1c..7c9c5d39 100644
>> --- a/policycoreutils/setfiles/setfiles.8
>> +++ b/policycoreutils/setfiles/setfiles.8
>> @@ -23,6 +23,7 @@ setfiles \- set SELinux file security contexts.
>>  .RB [ \-I | \-D ]
>>  .RB [ \-T
>>  .IR nthreads ]
>> +.RB [ \-A ]
>>  .I spec_file
>>  .IR pathname \ ...
>>
>> @@ -187,6 +188,9 @@ use up to
>>  threads.  Specify 0 to create as many threads as there are available
>>  CPU cores; 1 to use only a single thread (default); or any positive
>>  number to use the given number of threads (if possible).
>> +.TP
>> +.B \-A
>> +do not track conflicting inodes (saves memory)
>>
>>  .SH "ARGUMENTS"
>>  .TP
>> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfi=
les/setfiles.c
>> index ad09f840..40f2e7fe 100644
>> --- a/policycoreutils/setfiles/setfiles.c
>> +++ b/policycoreutils/setfiles/setfiles.c
>> @@ -147,7 +147,7 @@ int main(int argc, char **argv)
>>         const char *base;
>>         int errors =3D 0;
>>         const char *ropts =3D "e:f:hiIDlmno:pqrsvFURW0xT:";
>> -       const char *sopts =3D "c:de:f:hiIDlmno:pqr:svCEFUR:W0T:";
>> +       const char *sopts =3D "c:de:f:hiIDlmno:pqr:svCEFUR:W0T:A";
>>         const char *opts;
>>         union selinux_callback cb;
>>         long unsigned skipped_errors;
>> @@ -375,6 +375,9 @@ int main(int argc, char **argv)
>>                         if (*optarg =3D=3D '\0' || *endptr !=3D '\0')
>>                                 usage(argv[0]);
>>                         break;
>> +               case 'A':
>> +                       r_opts.add_assoc =3D 0;
>> +                       break;
>>                 case 'h':
>>                 case '?':
>>                         usage(argv[0]);
>> --
>> 2.50.1
>>
>>

