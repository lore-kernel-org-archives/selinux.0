Return-Path: <SRS0=klO3=NE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93672C004D3
	for <selinux@archiver.kernel.org>; Wed, 24 Oct 2018 15:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC30207DD
	for <selinux@archiver.kernel.org>; Wed, 24 Oct 2018 15:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="LZnclzqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC30207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=crunchydata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJXX6i (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:58:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44292 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeJXX6i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Oct 2018 19:58:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id o17-v6so315172qtq.11
        for <selinux@vger.kernel.org>; Wed, 24 Oct 2018 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a1c1o52GIaGZn0+cJyEmLD2GBOoIFeSWjtjxuUYkgmU=;
        b=LZnclzqrGixb3AMKnQU560ilSFOjnAZZCR+eyP2rh2yxY+KNTwHoPHvfLvCpRA+EA/
         Ov8TrcPhNxSsxln49YpX4+Rw9z/N80fYjyQDkCzO7KJxqQX6vBEgfGIoOhOvAwnAWQKz
         Ws/J3+WYydyjb5Eaf1XQ3Q4FxZu1DoA3uTxdJL6FB1hXmolYyn+blnFiYVOZiBD3kO0B
         jfuyh7P5l1xXFQigwCvteRMuI9vFwXAR4KSY+aLmlFWpKVaqjpOXwrTmB+D3B25Xq+Sf
         PU8QSUiH8ZkQqxB0jabTrZVOv9pI6lnwQYOMSNRF5be7o2TIUFGW2GqeUpbyKod0jHij
         KLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a1c1o52GIaGZn0+cJyEmLD2GBOoIFeSWjtjxuUYkgmU=;
        b=qby+hUbnS1/aiiW5tRhUogMtiKU0obHlYHFJBrMp5zKWEH2orarYNDCZ0sRCsnKjTm
         j8zW4hd6JPRKXCwaye6p1WkrPYwNV8eot+f3HhdenUUe6/G8gAnYipqVw9QgIu4uQ3fL
         Ss+jf5KfynMIzzxIUu7D51WQZ0nZ9uTcf6fkjJ6/1OvElUgssvs79BecnU1ZuDO57KcV
         eyCfKLXwX5uB+YVkNeUPmunIAr30kyflA0irm8C1QQ0V+3Tau3hzmgt0PyRyQiIWMyyh
         /K4CK08Odo6ma3JOZ4bq01N0PClMYJIeIKJUb7VYCzokxlhTKIHzIS4WCZGPoDjbTF3S
         J5rQ==
X-Gm-Message-State: AGRZ1gK1t6R/vyYYAvN7r3SMrcVgV3own04GCx89g7vvauP8TiXfRbtS
        Rd4vYhiaJRNPQOlbQwjX4z1dBywxyfY=
X-Google-Smtp-Source: AJdET5dxgyyC0W0C8CBfI1sOkMM601fQt73+WTv8IvPmMZaBVJJwd8pau5C77fX4tl0oPAVVrkV8qg==
X-Received: by 2002:a0c:edc9:: with SMTP id i9mr2933922qvr.116.1540395004802;
        Wed, 24 Oct 2018 08:30:04 -0700 (PDT)
Received: from [10.0.1.161] (pool-68-134-6-138.bltmmd.fios.verizon.net. [68.134.6.138])
        by smtp.gmail.com with ESMTPSA id e39-v6sm3672891qte.43.2018.10.24.08.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 08:30:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] mcstrans: remove unused getpeercon_raw() call
From:   Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
In-Reply-To: <da69011b-3492-5b2f-f0fe-5e5979fefe8b@tycho.nsa.gov>
Date:   Wed, 24 Oct 2018 11:30:02 -0400
Cc:     selinux@vger.kernel.org,
        Joshua Brindle <joshua.brindle@crunchydata.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <31E3F70E-27F0-4816-A749-F9CB9A0D475E@crunchydata.com>
References: <20181024145915.20172-1-yuli@crunchydata.com>
 <da69011b-3492-5b2f-f0fe-5e5979fefe8b@tycho.nsa.gov>
To:     Stephen Smalley <sds@tycho.nsa.gov>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Yeah, good point. I=E2=80=99ll resend.

> On Oct 24, 2018, at 11:18 AM, Stephen Smalley <sds@tycho.nsa.gov> =
wrote:
>=20
> On 10/24/2018 10:59 AM, Yuli Khodorkovskiy wrote:
>> There is a call to getpeercon_raw() in mcstransd, but nothing is done
>> with the context. The purpose of process_request() is to translate a
>> context and we would like that to succeed even if, for some reason,
>> getpeercon_raw() fails.
>=20
> If we are going to remove that, then shouldn't we also remove the TODO =
comment about performing a check using the peercon?
>=20
>> Signed-off-by: Yuli Khodorkovskiy <yuli@crunchydata.com>
>> Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
>> ---
>>  mcstrans/src/mcstransd.c | 6 ------
>>  1 file changed, 6 deletions(-)
>> diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
>> index d7fc5dea..abbdea7e 100644
>> --- a/mcstrans/src/mcstransd.c
>> +++ b/mcstrans/src/mcstransd.c
>> @@ -142,13 +142,8 @@ process_request(int fd, uint32_t function, char =
*data1, char *UNUSED(data2))
>>  {
>>  	int32_t result;
>>  	char *out =3D NULL;
>> -	char *peercon =3D NULL;
>>  	int ret;
>>  -	ret =3D getpeercon_raw(fd, &peercon);
>> -	if (ret < 0)
>> -		return ret;
>> -
>>  	/* TODO: Check if MLS clearance (in peercon) dominates the MLS =
label
>>  	 * (in the request input).
>>  	 */
>> @@ -184,7 +179,6 @@ process_request(int fd, uint32_t function, char =
*data1, char *UNUSED(data2))
>>  	}
>>    	free(out);
>> -	freecon(peercon);
>>    	return ret;
>>  }
>=20

