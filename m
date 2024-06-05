Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E0B19D8BE
	for <selinux@vger.kernel.org>; Wed,  5 Jun 2024 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717609765; cv=none; b=m7Mwme8f0M7rNqwALPKHpNZxFlm0/tG5SBliScVdIEf5VlO+KnlpVHb/oesPViJVvDftVBICPiuY+AY9CwyYj9PvO8NIJKvuI/XfBZy5zST75an61QKnKDi1YU0YlaQII8afMWLSf6eCAIAlRzR7GPqVUMHgruOLg7W+dzh3y7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717609765; c=relaxed/simple;
	bh=CccRRJY5lAekbndO3YrGXo4+KPxl1CAyozSY175D2XM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ia4gHhhS0mh9S7bnyDBWlBN0u/4wVG2StQPvR8fFfYZLVTlwCJrVzxoxPLUjcxg7MjNkZm+iICE1Zh1v5J5qdeHW3DU1qhTnQamY8U6G1ITb0mRqgnJoJAQUzXcSEF9UWAj7+mlLwgs4o/K6zCt75grHlFutwtzucoHTv+Uxl5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BlBCabSk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlBCabSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717609762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzRRp1ydGa/jQAQLC/cmKGWh/a0imHsQJEkPLj9qV/o=;
	b=BlBCabSkG1/qah4jw+q8OMEB+YXyrODPiCmdAhbcNxKbrVZexYGO94hhCEeiJ+ucLwYOgh
	/FHt5pOCORuwFowu5Iswgd0fkyy1sqGt0fbEsIji3AfDuv+kel3Pf/8aMbqmV4Eo/YY/3+
	pIuwnpSzenIvDt9IIfUW5kItX/PHj7I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-qaEaqbuaNfOaoSd0ilxzlw-1; Wed,
 05 Jun 2024 13:49:20 -0400
X-MC-Unique: qaEaqbuaNfOaoSd0ilxzlw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05A331977032;
	Wed,  5 Jun 2024 17:49:20 +0000 (UTC)
Received: from localhost (unknown [10.45.226.59])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E8521955DC1;
	Wed,  5 Jun 2024 17:49:19 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH 1/4] sandbox: do not fail without xmodmap
In-Reply-To: <CAP+JOzQzQ6SCqRWSe0qEvF6c+ieG7egWFBkSC-hTX-yNLNpA1w@mail.gmail.com>
References: <20240514105651.225925-1-lautrbach@redhat.com>
 <CAP+JOzQzQ6SCqRWSe0qEvF6c+ieG7egWFBkSC-hTX-yNLNpA1w@mail.gmail.com>
Date: Wed, 05 Jun 2024 19:49:18 +0200
Message-ID: <87y17jcmap.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

James Carter <jwcart2@gmail.com> writes:

> On Tue, May 14, 2024 at 7:25=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
>>
>> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> For these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Merged, thanks!


>
>> ---
>>  sandbox/sandbox | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/sandbox/sandbox b/sandbox/sandbox
>> index fe631a92cecd..c2ae4de69128 100644
>> --- a/sandbox/sandbox
>> +++ b/sandbox/sandbox
>> @@ -479,7 +479,10 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T t=
empdir]] [-I includefile ] [-
>>
>>                      xmodmapfile =3D self.__homedir + "/.xmodmap"
>>                      xd =3D open(xmodmapfile, "w")
>> -                    subprocess.Popen(["/usr/bin/xmodmap", "-pke"], stdo=
ut=3Dxd).wait()
>> +                    try:
>> +                        subprocess.Popen(["/usr/bin/xmodmap", "-pke"], =
stdout=3Dxd).wait()
>> +                    except:
>> +                        pass
>>                      xd.close()
>>
>>                      self.__setup_sandboxrc(self.__options.wm)
>> --
>> 2.45.0
>>
>>

