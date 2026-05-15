Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7636CDF3
	for <selinux@vger.kernel.org>; Fri, 15 May 2026 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854071; cv=none; b=oOHsJj5F4u0CsJV/WI/n5G/D5nccIWKVZ2hLqjgQRfAv0iDRLftpq2qop9qP2eQS/SQy3rbJrVeDWrjri4/qNMtE0xa7GQw3nVaqzfndOs6OwGUd4xSmRIQ3CPyrVfj/l1379aBqqY5vUsTb54i3Q35vkshIHTxSR1Vd5kFdf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854071; c=relaxed/simple;
	bh=2PmSD7IgKc4XG+sXuS6PvHHWwdB39TZVuJm4VsDu+3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dlk2AXjgWkQYlraCyanj7g/G2bioXN5Oi2n+IeF+WBE8y1NnIv/edJZ0YntSDwokLg65/dAYerLGmwGMb/mJxxG7mfq5D9MmlESOjuuf9QGHC4j2m/UfNo2P/Mdx/wxTTS3RTKT7H04Wb99e5eXeI//j0MNI7NxKePkflmbNPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4rNQhFj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4rNQhFj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778854068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NrWTYkMdUqYuqu1Q/8F0A+dodfwRtliVqfwjesoqkUA=;
	b=G4rNQhFj2a9nTz+nYJtWbq3qIjCvndKOvecu29Oh31xbPZbnyr3IGyu92KntKraBscqE8Q
	xJPcWNwPQXFwOQPupkmmmh+BcaFfWAjMp5yKNSrwGpJAtGoTSzMH2YGps7ReDGMiL8PwnG
	jFa8Mo0qtRt9+HXxB0t4U+2f9bM72mo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-bksGBBJjNM-lk8sR5z6ItA-1; Fri,
 15 May 2026 10:07:45 -0400
X-MC-Unique: bksGBBJjNM-lk8sR5z6ItA-1
X-Mimecast-MFC-AGG-ID: bksGBBJjNM-lk8sR5z6ItA_1778854063
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CD8B195609E;
	Fri, 15 May 2026 14:07:43 +0000 (UTC)
Received: from localhost (unknown [10.44.49.163])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0C1B30001A2;
	Fri, 15 May 2026 14:07:42 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>, Cathy Hu
 <cahu@suse.de>
Cc: fvogt@suse.com
Subject: Re: [PATCH v2] restorecon: Only log error on readonly fs (bsc#1232226)
In-Reply-To: <CAP+JOzT7y0dMq5oseWN+86Dq0Mzv0MOK=EUquhLVLnvkDNna-w@mail.gmail.com>
References: <20260430113302.2841721-2-cahu@suse.de>
 <CAP+JOzT7y0dMq5oseWN+86Dq0Mzv0MOK=EUquhLVLnvkDNna-w@mail.gmail.com>
Date: Fri, 15 May 2026 16:07:41 +0200
Message-ID: <87ecjchiky.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

James Carter <jwcart2@gmail.com> writes:

> On Thu, Apr 30, 2026 at 7:34=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>>
>> Problem:
>>
>> Before this change, when restorecon encountered a read-only filesystem,
>> it would set the error code to 255, not continue traversing, but
>> continue with other paths:
>> "restorecon: Could not set context for <path>:  Read-only file system"
>>
>> For callers there is no way to distinguish from that error code if it
>> encountered a serious error, or a read-only fs was not relabelled, or
>> both. However, not failing when a read-only fs is traversed is
>> acceptable in most if not all cases.
>>
>> This caused issues when e.g. restorecon was used in autorelabel
>> mechanisms during boot to relabel the file system. When it encountered
>> a read-only BTRFS subvolume, the return code would be set to 255 and
>> we had to fail the relabel service, as it might be a more severe issue.
>>
>> Behaviour change in this commit:
>>
>> With this change, restorecon logs the encounter of a ro file system, con=
tinues and finishes with return code 0:
>> "Read only filesystem, relabel not possible: <path>"
>>
>> Other mechanims that were considered to fix this issue and why they were
>> not used:
>>
>> - -x skip all subvolumes: break cases of subvolumes which aren't mounted=
 explicitly but still need to be relabelled
>> - caller generates skippable locations and these get automatically fed
>>   into restorecon: error prone and needs to be manually maintained in
>> certain scenarios
>> - caller ignores non-zero return code: not good idea, it would cover up
>>   issues that would be hard to debug in the future
>> - skip only ro btrfs subvolumes: I started writing a poc and discovered =
it is not easily
>>   possible without either pulling libbtrfs in as dependency or having
>>   a lot of ioctl calls which likely will lead to performance degradation
>>   or tracking the btrfs status inside of restorecon, which would be a
>>   big code change for a problem that might be also there on other file
>>   systems
>>
>> Discussion and context:
>>
>> - "Question regarding restorecon and btrfs read-only snapshots" Thread:
>> https://lore.kernel.org/selinux/98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@sus=
e.de/
>>
>> - (open)SUSE bug: https://bugzilla.suse.com/show_bug.cgi?id=3D1232226
>>
>> Signed-off-by: Cathy Hu <cahu@suse.de>
>
> Acked-by: James Carter <jwcart2@gmail.com>


Merged, thanks!

>> ---
>>  libselinux/src/selinux_restorecon.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinu=
x_restorecon.c
>> index 8fadf4d2..e8545e27 100644
>> --- a/libselinux/src/selinux_restorecon.c
>> +++ b/libselinux/src/selinux_restorecon.c
>> @@ -774,10 +774,14 @@ static int restorecon_sb(const char *pathname, con=
st struct stat *sb,
>>                 if (!flags->nochange) {
>>                         if (lsetfilecon(pathname, newcon) < 0) {
>>                                 /* Ignore files removed during relabelin=
g if ignore_noent is set */
>> -                               if (flags->ignore_noent && errno =3D=3D =
ENOENT)
>> +                               if (flags->ignore_noent && errno =3D=3D =
ENOENT) {
>>                                         goto out;
>> -                               else
>> +                               } else if (errno =3D=3D EROFS) {
>> +                                       selinux_log(SELINUX_INFO, "Read =
only filesystem, relabel not possible: %s\n", pathname);
>> +                                       goto out;
>> +                               } else {
>>                                         goto err;
>> +                               }
>>                         }
>>
>>                         updated =3D true;
>> --
>> 2.53.0
>>
>>

