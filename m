Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA123F20FE
	for <selinux@vger.kernel.org>; Tue, 28 Apr 2026 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373053; cv=none; b=ERFj5fj1pz8rvrU4SfJW7mJXl1sHpd31LHI4zmLSlIWvJjzTcSQPOz50TnLrEI9CStfuB8DNc01PLycVLrhT1m3mIIGYJxD5jxb/jxhFAqD509eXmuUI81kIxAvMkS+d03CB26IfKi+V06G+ghJ/4CfTGTfT4NlnKdCI2W6whFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373053; c=relaxed/simple;
	bh=ORMv5H9wHqRt7HVbA60Bm0+ZQvZhSqxJpUDZPvra9oQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPH21lck2L1y1zOkoTP2ZOgR0MoHT5YaSpXpOdw/foAdxyvSOpgljVZd4cja8OnNbvoupXfwZAm0e9iEsOCJ0DwbXVm1vINHHB7TqfB5Zf/eXaIwEN2TtrjSbzL9OBgXamArlZNKBy0ekAkOw4MhNsGzbam+wtWKhz1r1WE1hu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5oj5GHl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5oj5GHl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777373051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2z3OWI4VftdmbqdBEo5XFubciaTxWrOgcpk2v9cxHtU=;
	b=O5oj5GHlgbzugCEGEYYp+DxN7DgySyp7BM06L7Mb8n0kzbXVIU4xbp5zYam/F5SGRs4Pcb
	7YkX5/IrlqZ3uToU8X/aI0n1nb2XUBkZ7O3wLjcdosb31FRm3IlNhcwdCdMlR8OPCKGHAq
	SkEMGkApCklq4n1iSU2hQtCxxz6MnAw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-N3RHaa2GPi2xuy7wwHQyPg-1; Tue,
 28 Apr 2026 06:44:09 -0400
X-MC-Unique: N3RHaa2GPi2xuy7wwHQyPg-1
X-Mimecast-MFC-AGG-ID: N3RHaa2GPi2xuy7wwHQyPg_1777373048
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89F091800473;
	Tue, 28 Apr 2026 10:44:08 +0000 (UTC)
Received: from localhost (unknown [10.44.32.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 175153000C22;
	Tue, 28 Apr 2026 10:44:07 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Cathy Hu <cahu@suse.de>, selinux@vger.kernel.org
Subject: Re: [PATCH] restorecon: Only log error on readonly fs (bsc#1257996)
In-Reply-To: <53d9cc60-73a0-4c65-90c7-58cb51f1f6a5@suse.de>
References: <20260310153249.2077092-3-cahu@suse.de>
 <875x5ctkeu.fsf@redhat.com> <53d9cc60-73a0-4c65-90c7-58cb51f1f6a5@suse.de>
Date: Tue, 28 Apr 2026 12:44:06 +0200
Message-ID: <87tssvs6tl.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Cathy Hu <cahu@suse.de> writes:

> On 4/27/26 6:52 PM, Petr Lautrbach wrote:
>> Cathy Hu <cahu@suse.de> writes:
>> 
>>> Signed-off-by: Cathy Hu <cahu@suse.de>
>>> ---
>>> RFC Patch for the issue described in thread "Question regarding restorecon and btrfs read-only snapshots"
>>>
>> 
>> Could you point me where I can find the thread and is bsc#1257996?
>
> "Question regarding restorecon and btrfs read-only snapshots" Thread:
> https://lore.kernel.org/selinux/98f87fd6-6d3e-4539-ad8f-1a0dc09aa890@suse.de/
>
> bsc#1257996: Good point, that is the wrong bug number, the right one is:
> https://bugzilla.suse.com/show_bug.cgi?id=1232226
> I will refresh the patch after the discussion
>
>
>> 
>> What's the expected outcome? Before this change I see:
>> 
>> $ sudo restorecon -R -v /mnt/
>> restorecon: Could not set context for /mnt:  Read-only file system
>> restorecon: Could not set context for /mnt/lost+found:  Read-only file system
>> restorecon: Could not set context for /mnt/a:  Read-only file system
>> restorecon: Could not set context for /mnt/1:  Read-only file system
>> 
>> After:
>> 
>> $ sudo restorecon -R -v /mnt/
>> Read only filesystem, relabel not possible: /mnt
>> Read only filesystem, relabel not possible: /mnt/lost+found
>> Read only filesystem, relabel not possible: /mnt/a
>> Read only filesystem, relabel not possible: /mnt/1
>> 
>> This seems to be only a cosmetic change.
>
> return value should be 0 with the change, before that it was 255.
> So before it was failing, now it is traverse and log only
>

thanks for the pointers, it's clear now.

Is it expected that it would work only in first level of subdirectories?

$ mount | grep /mnt
/dev/loop0 on /mnt type ext4 (ro,relatime,seclabel)
/dev/loop1 on /mnt/rw type ext4 (rw,relatime,seclabel)
/dev/loop2 on /mnt/a/b/c/d/rw type ext4 (rw,relatime,seclabel)

$ sudo restorecon -R -v /mnt
Read only filesystem, relabel not possible: /mnt
Read only filesystem, relabel not possible: /mnt/lost+found
Read only filesystem, relabel not possible: /mnt/a
Relabeled /mnt/rw from system_u:object_r:user_home_t:s0 to system_u:object_r:mnt_t:s0
Read only filesystem, relabel not possible: /mnt/1

It seems to be useful just for one specific use case.

Also could you please improve the commit message so it contains some
reason, uses case and the final effect? it will help future reviewers to better
understand this change.


Petr


>> 
>> Petr
>> 
>> 
>>>   libselinux/src/selinux_restorecon.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
>>> index 8fadf4d2..e8545e27 100644
>>> --- a/libselinux/src/selinux_restorecon.c
>>> +++ b/libselinux/src/selinux_restorecon.c
>>> @@ -774,10 +774,14 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
>>>   		if (!flags->nochange) {
>>>   			if (lsetfilecon(pathname, newcon) < 0) {
>>>   				/* Ignore files removed during relabeling if ignore_noent is set */
>>> -				if (flags->ignore_noent && errno == ENOENT)
>>> +				if (flags->ignore_noent && errno == ENOENT) {
>>>   					goto out;
>>> -				else
>>> +				} else if (errno == EROFS) {
>>> +					selinux_log(SELINUX_INFO, "Read only filesystem, relabel not possible: %s\n", pathname);
>>> +					goto out;
>>> +				} else {
>>>   					goto err;
>>> +				}
>>>   			}
>>>   
>>>   			updated = true;
>>> -- 
>>> 2.53.0
>> 

