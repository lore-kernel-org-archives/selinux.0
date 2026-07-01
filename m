Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7394481232
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921749; cv=none; b=g0Oiz8inCujeQDAmYK5PYZQRi+qevEMpFCzhhbMaQiKEl8s5pKxaIztIjVSaIea0vDF8Lc4PZ9Y5XyqZ0gb9vzKc2D2lBG2PJKUchV9i/++GhBHETxNrmccwNh5i1zg/SikXPLNCn02ym7cuibd3QLcDMI56jglJmNcIdMaB5nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921749; c=relaxed/simple;
	bh=BUyxi0gsTsDJtsOf5mP1C/EgGrCkTuhqS8huvfjevhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FrkLdfurmhDikxa5bXBpgS2yvkZDitd7OFSdkQYKjMpbgrP134sLomJmFARnO3WqBRcpoxxst5IhEh3yv+1v0ixxJUItpaVZPte4IqrGLB1xG/iE/MmtzF9BO3PNc1tMZxQQxS6ysw/xq+LxzgMpKVgrotI4xhXXnPkstAmNeDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q26tp1zN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q26tp1zN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782921746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tZDqBwseImBAqr94/Neupj10fuvpg2sP6zvm00fviW4=;
	b=Q26tp1zNB8FagfLe513PztUZgDmeCS+WdToBiAjV0kJ31ylQASZpRFny0gGXvsaPjp0S3S
	ljd/lSTnWvhi0+U6VL2GIbAXGddIIKHSisFyoB1erJt6QEVu2mIKeYWwB93YuTLF3ABtVK
	ZPAf82vXb6vZaIpQLK5a4hOLOBfrtec=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-YqbfSgm6NO6-Nn0oNEqXPw-1; Wed,
 01 Jul 2026 12:02:23 -0400
X-MC-Unique: YqbfSgm6NO6-Nn0oNEqXPw-1
X-Mimecast-MFC-AGG-ID: YqbfSgm6NO6-Nn0oNEqXPw_1782921741
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72077187958A;
	Wed,  1 Jul 2026 16:02:21 +0000 (UTC)
Received: from localhost (unknown [10.44.33.50])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03BF236F04;
	Wed,  1 Jul 2026 16:02:20 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: jwcart2@gmail.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] libselinux: selinux_restorecon(): fstat() if
 skip_multilink set
In-Reply-To: <87tsqisoop.fsf@redhat.com>
References: <20260628004130.28649-1-stephen.smalley.work@gmail.com>
 <87tsqisoop.fsf@redhat.com>
Date: Wed, 01 Jul 2026 18:02:19 +0200
Message-ID: <87qzlmsnp0.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Petr Lautrbach <lautrbach@redhat.com> writes:

> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
>> selinux_restorecon() must call fstat() on every entry if skip_multilink
>> is set to fetch the st_nlink value.
>>
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>

Merged, thanks!

>
>> ---
>>  libselinux/src/selinux_restorecon.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
>> index 0159fb7f..b34d8e60 100644
>> --- a/libselinux/src/selinux_restorecon.c
>> +++ b/libselinux/src/selinux_restorecon.c
>> @@ -1271,13 +1271,15 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
>>  
>>  		/*
>>  		 * Skip fstat() when d_type already gives the file type and
>> -		 * neither xdev (st_dev) nor add_assoc (st_ino) is needed.
>> +		 * none of xdev (st_dev), add_assoc (st_ino), or
>> +		 * skip_multilink (st_nlink) are needed.
>>  		 * Directories always fstat for cycle detection and walk_push().
>>  		 */
>>  		mode_t mode_from_dtype = d_type_to_mode(de->d_type);
>>  		bool need_fstat =
>>  			mode_from_dtype == 0 || S_ISDIR(mode_from_dtype) ||
>> -			state->flags.set_xdev || state->flags.add_assoc;
>> +			state->flags.set_xdev || state->flags.add_assoc ||
>> +			state->flags.skip_multilink;
>>  
>>  		if (need_fstat) {
>>  			if (fstat(fd, ent_sb) < 0) {
>> -- 
>> 2.54.0

