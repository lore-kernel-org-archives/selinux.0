Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CC3C4CEC9
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 12:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A48205F4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 12:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="lx+/Uizs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfIRMZp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:25:45 -0400
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:15453 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbfIRMZp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 08:25:45 -0400
X-EEMSG-check-017: 9818726|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="9818726"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Sep 2019 12:23:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568809424; x=1600345424;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=oBDsGG5X0WOlYgSvzdT5JgmckLuMyP9zKNO9XLDPOjM=;
  b=lx+/UizscVgc7X4rpX99WmTmwJfnVg5I7hwGTQzwaQiu9jAslgqMQ9Ec
   r0MMdeywtA4/zKLx1+M4wZvpUBJMpP2qIOWjDK/8N6S+Wgesik4l/mUg+
   GeGaNNt2a3N2QexzmT9SRFeejzP2VGchlJw/9nc3dR3JrHZll/VcL/SEC
   pYLTw9hBqTQuxUZsdJjRo+919Cn74FEi9pKPGrLGG1tAW4aDUAvFltwCa
   3S9yD2rTOzv9j/BP0RZGY7If2G8AVbPS7NsReqOXOymmyS/6PQ1NbiFVh
   sWj/qlLyfBBS8ujZ0TrqaQxrJ5HtBj8VVeEUJpytVjM7ggjKhRMj97gTM
   w==;
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="28039023"
IronPort-PHdr: =?us-ascii?q?9a23=3AlKy9KRY1/VOlB1teF+A4MUn/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsm+bnLW6fgltlLVR4KTs6sC17ON9fmwEjFYqdbZ6TZeKcYKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZsJ6or1x?=
 =?us-ascii?q?fEoXREduRKyWh1IV6fgwvw6t2/8ZJ+7Shcoe4t+9JFXa7nY6k2ULtUASg8PW?=
 =?us-ascii?q?so/sPrrx7DTQWO5nsYTGoblwdDDhbG4h/nQJr/qzP2ueVh1iaUO832Vq00Vi?=
 =?us-ascii?q?+576h3Uh/oiTwIOCA//WrKl8F/lqNboBampxxi347ZZZyeOfRicq/Be94RWH?=
 =?us-ascii?q?FMVdhNWSNfHoy8bpMPD+sfMuZes4n9vEYFoR+nCQWxGO/j1jpEi3n40q0g1+?=
 =?us-ascii?q?QqDB/I0gouEdkTtHjYtdv4OaMXXe2z0aLGzyjMb+lO1Dng6IbGbB4hr/KCU7?=
 =?us-ascii?q?1+fsXey1UgGQzeg1WMqoHoJS+Z2vgDvmWZ6edrSOKhi3QgqwF0ujWh29sshZ?=
 =?us-ascii?q?fRhoIV1F/E8zhyzpswJdKiTE57ZcCrEZtNvCydLIt5X9giTnp0uCc61rIGuZ?=
 =?us-ascii?q?m7cDIMyJQ83RHTcfOHc4+W4h/6UuuaPDR2hGp9db6iiBu//lKsx+3hWsWuzl?=
 =?us-ascii?q?pHoTRJnsPRun0Lyhfd8NKISuFn8UekwTuP0gfT5fxaLk0sjqrbLoIhwqY3lp?=
 =?us-ascii?q?oOrUTPBi/2l1vyjK+Rbkgk5vKn6/7mYrX7vZ+QLZN0iwHiPaQuncyzG+I4PR?=
 =?us-ascii?q?QVX2eH4+i80bzj/UnhTLVLiP05jLXZvYjHKckUqaO1GQ9Y3ps55xqhADqqzs?=
 =?us-ascii?q?4UkWQfIFJAYh2HjozpO1/UIPD/CPeym0+snypwx/3dIr3gAonCLnjEkLv7e7?=
 =?us-ascii?q?Z98FRTxBA8zdBY+ZJYEqsBL+7rWk/tqNzYCQc0Mwm1w+bkFtpxzJseVniLAq?=
 =?us-ascii?q?+cMaPStkOI5v4oI+SXeIAVoiv9K/456P7ujX42hEUSfbWz0pcNdH+4GfFmKV?=
 =?us-ascii?q?2DYXXwmtcBDXsKvg0mQezxllKCVT9TZ3CvX6Mz/Tw7Fo2mApnZRoy3g7yOwj?=
 =?us-ascii?q?27HptIaWBCEFyMFm3od4rXE8sLPQeTIcIpqjUAULmmV5MmnUWrtQz3jaJuKu?=
 =?us-ascii?q?/V/TEEsrrozsVz7O3CmRgu/Hp/CMHLlymWQmV1mH4YbyE50bo5okFnzFqHl6?=
 =?us-ascii?q?9ijK92D9tWsshVXx86OJiU9OlzD9T/S0qVZduSYEq3SdWhRzcqR5Q+xMFYMB?=
 =?us-ascii?q?U1IMmrkh2Wh3niOLQSjbHeQcVvo68=3D?=
X-IPAS-Result: =?us-ascii?q?A2AqAQBnIYJd/wHyM5BmHQEBBQEHBQGBVQYBCwGBbSqBQ?=
 =?us-ascii?q?DIqhCKPD1ABAQEGgTZ+iHaPLYF7CQEBAQEBAQEBATQBAgEBhD8CgwMjNgcOA?=
 =?us-ascii?q?gwBAQEEAQEBAQEFAwEBbIU5gjopAYJnAQUjDwEFUQkCGAICJgICVwYBDAYCA?=
 =?us-ascii?q?QGCXz+BdxSUX5tvgTKIe4FJgQwoAYwIGHiBB4ERJ4I2NT6HT4JYBIxqA5Eqj?=
 =?us-ascii?q?mGCLIIukk8GG4I2i3CKeo4PmwoELYFYKwgCGAghD4MnUBAUkC8kAzCBBgEBj?=
 =?us-ascii?q?24BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Sep 2019 12:23:42 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8ICNglH007551;
        Wed, 18 Sep 2019 08:23:42 -0400
Subject: Re: [PATCH v2] libselinux: fix string conversion of unknown perms
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>,
        selinux@vger.kernel.org
References: <20190916203015.19474-1-mike.palmiotto@crunchydata.com>
 <629b332a-eaf7-2107-a243-62b5b66ef061@tycho.nsa.gov>
Message-ID: <70ffaf5f-3aa3-ba6e-6fc6-c7f91c3ae5bc@tycho.nsa.gov>
Date:   Wed, 18 Sep 2019 08:23:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <629b332a-eaf7-2107-a243-62b5b66ef061@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/18/19 8:19 AM, Stephen Smalley wrote:
> On 9/16/19 4:30 PM, Mike Palmiotto wrote:
>> Commit c19395d72295f5e69275d98df5db22dfdf214b6c fixed some handling of 
>> unknown
>> classes/permissions, but missed the case where an unknown permission 
>> is loaded
>> and then subsequently logged, either via denial or auditallow. If a 
>> permission
>> set has some valid values mixed with unknown values, say `{ read write 
>> foo }`,
>> a check on `{ read write foo }` would fail to log the entire set.
>>
>> To fix this, skip over the bad permissions/classes when expanding them to
>> strings. The unknowns should be logged during `selinux_set_mapping`, so
>> there is no need for further logging of the actual unknown permissions.
> 
> It seems like we have a similar pattern in print_access_vector(), 
> avc_dump_av(); if security_av_perm_to_string() returns NULL, we break 
> out of the loops and skip the remaining bits.  We do however log the hex 
> value of the any remaining bits set in the av, so we don't lose all 
> information.  I think we can still take this patch as is but was 
> wondering whether the other cases ought to be similarly handled?

I have merged this patch now.

> 
>>
>> Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
>> ---
>>   libselinux/src/stringrep.c | 24 ++++++++----------------
>>   1 file changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
>> index ad29f76d..b9bf3ee6 100644
>> --- a/libselinux/src/stringrep.c
>> +++ b/libselinux/src/stringrep.c
>> @@ -268,7 +268,7 @@ const char 
>> *security_av_perm_to_string(security_class_t tclass,
>>   int security_av_string(security_class_t tclass, access_vector_t av, 
>> char **res)
>>   {
>> -    unsigned int i = 0;
>> +    unsigned int i;
>>       size_t len = 5;
>>       access_vector_t tmp = av;
>>       int rc = 0;
>> @@ -276,19 +276,12 @@ int security_av_string(security_class_t tclass, 
>> access_vector_t av, char **res)
>>       char *ptr;
>>       /* first pass computes the required length */
>> -    while (tmp) {
>> +    for (i = 0; tmp; tmp >>= 1, i++) {
>>           if (tmp & 1) {
>>               str = security_av_perm_to_string(tclass, av & (1<<i));
>>               if (str)
>>                   len += strlen(str) + 1;
>> -            else {
>> -                rc = -1;
>> -                errno = EINVAL;
>> -                goto out;
>> -            }
>>           }
>> -        tmp >>= 1;
>> -        i++;
>>       }
>>       *res = malloc(len);
>> @@ -298,7 +291,6 @@ int security_av_string(security_class_t tclass, 
>> access_vector_t av, char **res)
>>       }
>>       /* second pass constructs the string */
>> -    i = 0;
>>       tmp = av;
>>       ptr = *res;
>> @@ -308,12 +300,12 @@ int security_av_string(security_class_t tclass, 
>> access_vector_t av, char **res)
>>       }
>>       ptr += sprintf(ptr, "{ ");
>> -    while (tmp) {
>> -        if (tmp & 1)
>> -            ptr += sprintf(ptr, "%s ", security_av_perm_to_string(
>> -                           tclass, av & (1<<i)));
>> -        tmp >>= 1;
>> -        i++;
>> +    for (i = 0; tmp; tmp >>= 1, i++) {
>> +        if (tmp & 1) {
>> +            str = security_av_perm_to_string(tclass, av & (1<<i));
>> +            if (str)
>> +                ptr += sprintf(ptr, "%s ", str);
>> +        }
>>       }
>>       sprintf(ptr, "}");
>>   out:
>>
> 

