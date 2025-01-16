Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210122DC2B
	for <selinux@vger.kernel.org>; Thu, 16 Jan 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043682; cv=none; b=PHMtVs+34ei9+H2tIQ8owsSriyhVZ7wywaY+fCGnT+kQTkIAMnc7Ko3ZZL4F7E+lFmhInAB27E9IQM9wJZ/VRNhw0WY9w0jMQiiRU4o8ynsFdEEnjMXnYH9b4Oa+FmLw2ZohQkiq69niZENL5HPnvdyYUWhBz6mX2EjgMUQc5d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043682; c=relaxed/simple;
	bh=Nip+82EDPDb0jFtj3sYe+PPu3HylBiCJNQbrk8+iFdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FRLYuBmUSzE4iymqFe0nre8cywNZMcNtEGtJLoONvWTdN/VhARUIJPzntzjG145PoKcklOopiZiJFAr4ppT/5Np2SIQoFQWMOGXTpKCVO8S+6dt5Q7oVD4YXHXeQFdwdxznA0PwkzcLcl4pyCAOugz1Pc3JJ/GmOetkBM3Weoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSgZ/U78; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSgZ/U78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737043679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIayQO31bvWHP7w5SRtWREZ+PALCBQ1c2YUrimRk+LY=;
	b=BSgZ/U784o/6QZ8whba8IZL1YJmmeeHu3d4B6mhzLlZygNJ0BASz3Gw6VNX+C8ateTiM+y
	abpIs2zV4bgygc3vINQYVm0rF8DBQK6k+ASqHhwOsttKZuBLRfGaRPsPqfSj6TEv8ZxlFu
	6cH1NKCfKeIaExbXduVPBnAGzkmBvuk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-XjjMNsyvN7KXqEeHwCwGDA-1; Thu,
 16 Jan 2025 11:07:54 -0500
X-MC-Unique: XjjMNsyvN7KXqEeHwCwGDA-1
X-Mimecast-MFC-AGG-ID: XjjMNsyvN7KXqEeHwCwGDA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 085071955F36;
	Thu, 16 Jan 2025 16:07:53 +0000 (UTC)
Received: from localhost (unknown [10.39.196.32])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 816CE195608A;
	Thu, 16 Jan 2025 16:07:52 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: James Carter <jwcart2@gmail.com>, cgzones@googlemail.com,
 selinux@vger.kernel.org
Cc: 
Subject: Re: [PATCH 1/2] libsepol/cil: free nlmsg hashtable on error
In-Reply-To: <CAP+JOzTfK0gyiqnnoaOGb11o8iy26Obpw5P=ypoftH1jbUy-Mg@mail.gmail.com>
References: <20250108163149.104958-1-cgoettsche@seltendoof.de>
 <20250108163149.104958-2-cgoettsche@seltendoof.de>
 <CAP+JOzTfK0gyiqnnoaOGb11o8iy26Obpw5P=ypoftH1jbUy-Mg@mail.gmail.com>
Date: Thu, 16 Jan 2025 17:07:51 +0100
Message-ID: <87a5bqwxm0.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

James Carter <jwcart2@gmail.com> writes:

> On Wed, Jan 8, 2025 at 11:32=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
>>
>> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>>
>> Free the hashtable for nlmsg xperm rules similar to the ioctl hashtable.
>>
>> Fixes: 1fd41f48 ("libsepol/cil: add support for xperms in conditional po=
licies")
>> Reported-by: oss-fuzz (issue 388376332)
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Merged. Thanks!

>> ---
>>  libsepol/cil/src/cil_binary.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary=
.c
>> index 070bf525..e84188a0 100644
>> --- a/libsepol/cil/src/cil_binary.c
>> +++ b/libsepol/cil/src/cil_binary.c
>> @@ -2616,6 +2616,8 @@ int cil_booleanif_to_policydb(policydb_t *pdb, con=
st struct cil_db *db, struct c
>>         return SEPOL_OK;
>>
>>  exit:
>> +       hashtab_map(avrulex_nlmsg_table, __cil_avrulex_xperm_destroy, NU=
LL);
>> +       hashtab_destroy(avrulex_nlmsg_table);
>>         hashtab_map(avrulex_ioctl_table, __cil_avrulex_xperm_destroy, NU=
LL);
>>         hashtab_destroy(avrulex_ioctl_table);
>>         if (tmp_cond) {
>> --
>> 2.47.1
>>
>>

