Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4593BC3A5A6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 12:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C274205F4
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 12:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="cZ+l1lge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388819AbfISMRQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:17:16 -0400
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:27913 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388585AbfISMRQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 08:17:16 -0400
X-EEMSG-check-017: 24486745|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,523,1559520000"; 
   d="scan'208";a="24486745"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Sep 2019 12:17:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568895435; x=1600431435;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8BJkF35Xlb/0IPIiKQK1iCQQhS0lX8DONiVnzlPSQzY=;
  b=cZ+l1lgefKhVTK5vjcPVZqEsD5/b8p+CJovZPlEH5p97tdGL7zAjjpXI
   8oRqTp5Y+TsaDGDhZqRhAp3JKLVg3RfPrpty/FuIHutli/htUkGZo4xoM
   xNxUa8uSpYxg3t5Hysosx+3zqTh8KcKrLq9ld3Oi5OrRH7Sxsq1+Q02ZI
   E+tQo+n3ef+pQd3rIRr9+gPH7yRwXxmJoDN2rGLHrTMjwptpQz2xw6iDz
   wo3yYwcIahJlYqizUbsNN1GhFb98+dIPJnptIchEnuSyzUcVDcfY9ZepB
   BIo87vMwBOk4fkazfOChs/BP5XqZjX8iaSY3FdHXzEvpJhVwdnmDC5R15
   w==;
X-IronPort-AV: E=Sophos;i="5.64,523,1559520000"; 
   d="scan'208";a="28089743"
IronPort-PHdr: =?us-ascii?q?9a23=3AkLPJcRN/awzw/0gqsZEl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/z6oMbcNUDSrc9gkEXOFd2Cra4d0KyM6+u9ASRAuc/H7ClYNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULj4ZuMLg9xg?=
 =?us-ascii?q?fGrnZIZ+hd2GdkKU6Okxrm6cq84YBv/z5Mt/498sJLTLn3cbk/QbFEFjotLn?=
 =?us-ascii?q?o75NfstRnNTAuP4mUTX2ALmRdWAAbL8Q/3UI7pviT1quRy1i+aPdbrTb8vQj?=
 =?us-ascii?q?St871rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4BSG?=
 =?us-ascii?q?FfQsheSTBOAoKkb4sOEeUBO/pYr5LgrFcKtBeyGBWgCP/qxjJOiHD2x6k62P?=
 =?us-ascii?q?k/Hw/A0gIrAtYCvG3KoNjxMasfV/2+wqvVwjXZd/5YxCnz6IbIfB4ir/+DU7?=
 =?us-ascii?q?1/fsjNxkcgDA7FkledpJb5Mz+J2OkAsW6W5PdgW+K1jG4nrhl8rCWzxsgyko?=
 =?us-ascii?q?nJhpwaylbZ/itkxYY6P9m4SEplbt+kDZBdsDqaOJZtQs45X2FpuDo1yr0BuZ?=
 =?us-ascii?q?KheigK044oywTQa/yAbYiF+xTuX/ufLzd/gXJqYrO/hxCq/Ei80O3zTNe00F?=
 =?us-ascii?q?dRriZcjtbMt2oB1xvJ6siIUvd98Uah2SqP1wDO8e5IO1w7la3eK5Mn37U+lY?=
 =?us-ascii?q?ITvFzeEiL5l0j6lq+belg+9uS25OnrfK/qqoKaOoRpkA/xKL4ulda6AekgNw?=
 =?us-ascii?q?gOWHWU9vqk2b34+E35XK1KjvorkqnFqJzaJdoUpqq+AwJNzoYs8Qy/Dza70N?=
 =?us-ascii?q?QDh3UHMFJEdw6Hj4juIV3OJuz3DeyjjFi2lTdrxvTGMqXgApXLMHfDjK/sca?=
 =?us-ascii?q?ty5kNT0gY+zc1T64hKBrwOPv7/QFL9uMTdDhAjMgy0x+jnCM961oMbQW+PGb?=
 =?us-ascii?q?KWMLjJvF+U5uMgP+mMZIgPtDb7MPgq/eTijXA+mV8DZaWpx4cYaGikHvR6JE?=
 =?us-ascii?q?WUeX3sgtIGEWcRuAoxVvDlh0OZXD5JeXm9QqI86SsnCI68EYjDQYWtiqSb3C?=
 =?us-ascii?q?inBp1WenxGCleUHHfwbYqERvMMZTmKIsB7jzwEUaGtS4om1RGprg/11aBrIf?=
 =?us-ascii?q?bT+i0drZjjzsR65/XPlREu8jx5F9+d3H+JT2F1mGMIWjA30bthoUxy1FiDy7?=
 =?us-ascii?q?J0g/9GGtxJ4fNGTAM6OYTbz+xgBNChEj7GK/CPREyrQJ2DBio3R9k8wJdaZE?=
 =?us-ascii?q?N6ANOrhR3rxSemA7YJ0beMAcpn3Ljb2i3KO8tly3vAnJIkhl0iT9oHYXaqnY?=
 =?us-ascii?q?Zj5gPTAMjPiEzfmKG0I/dPlBXR/XuOmDLd9HpTVxR9BOCcByES?=
X-IPAS-Result: =?us-ascii?q?A2CcAADecINd/wHyM5BlHAEBAQQBAQcEAQGBVQUBAQsBg?=
 =?us-ascii?q?W0qbVIBMiqEIo9gAQEBAQEBBoE2iXSPLRSBZwkBAQEBAQEBAQEtBwECAQGEP?=
 =?us-ascii?q?wKDAyM2Bw4CDAEBAQQBAQEBAQUDAQFshS0MgjopAYJmAQEBAQIBIxVBBQsLD?=
 =?us-ascii?q?goCAhEVAgJXBg0GAgEBgl8/AYF2BQ8PrX6BMoQ3AYEUgzGBQwaBDCgBjAgYe?=
 =?us-ascii?q?IEHgTiCaz6BDoFTAoEcIxlIgkyCWASWAJcGgiyCLoRXjX0GG5kjlieTAQMug?=
 =?us-ascii?q?VgrCAIYCCEPgydQEBSBWheDT4UUhVskAzAKfAEBjSkVghoWAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 19 Sep 2019 12:17:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8JCHEY1005083;
        Thu, 19 Sep 2019 08:17:14 -0400
Subject: Re: [PATCH] selinux-testsuite: apply perltidy to infiniband test
 scripts
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
References: <20190918125507.10778-1-sds@tycho.nsa.gov>
 <CAFqZXNuZ00pFj_vyzJ3W3x2Fbs=NA+NDMCUR9fwpaerUfRU-pQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2ac5eb4d-b44f-bbe2-58fd-8a9c1758e4b9@tycho.nsa.gov>
Date:   Thu, 19 Sep 2019 08:17:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNuZ00pFj_vyzJ3W3x2Fbs=NA+NDMCUR9fwpaerUfRU-pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/19/19 3:43 AM, Ondrej Mosnacek wrote:
> On Wed, Sep 18, 2019 at 2:55 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> The infiniband test scripts weren't compliant with perltidy so
>> make check-syntax was failing.  Fix it.
> 
> Unfortunately there is some disconnect between the perltidy version
> available in the Travis CI environment and the newer versions
> available in more recent distributions... See this commit in the
> audit-testsuite [1] - the decision is to follow the Travis format as
> the common "standard" (there is really no better way until we patch
> the Travis script to install newer peritidy somehow...).

Ok, I reverted this change. Wondering if this could be controlled 
through any of the perltidy options, or fixed by using a newer image 
e.g. bionic.

> Just in case you don't know, anyone can easily enable Travis CI on
> their GitHub fork - just go to https://travis-ci.org/, log in with
> your GitHub account, and switch the corresponding project to enabled.
> That way you can just push a branch to your fork, it will be tested
> and you will get a report to (just) your mailbox. I.e. you can do the
> canonical syntax check without opening a PR against the upstream repo.
> 
> [1] https://github.com/linux-audit/audit-testsuite/commit/7ff3e434bc243e667ebb26a22b64176e662fddec
> 
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>   tests/infiniband_endport/test | 2 +-
>>   tests/infiniband_pkey/test    | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/infiniband_endport/test b/tests/infiniband_endport/test
>> index 0021e0d69af4..f071fbc18cf8 100755
>> --- a/tests/infiniband_endport/test
>> +++ b/tests/infiniband_endport/test
>> @@ -40,7 +40,7 @@ ok( $result, 0 );
>>
>>   foreach (@denied_device_port) {
>>       @dev_port_pair = split( / /, $_ );
>> -    $result = system
>> +    $result        = system
>>   "runcon -t test_ibendport_manage_subnet_t smpquery PKeyTable -C $dev_port_pair[0] -P $dev_port_pair[1] -D 1 2>/dev/null";
>>
>>       if ( $result >> 8 eq 0 ) {
>> diff --git a/tests/infiniband_pkey/test b/tests/infiniband_pkey/test
>> index 3ee4d13c8ffe..382c25913ca0 100755
>> --- a/tests/infiniband_pkey/test
>> +++ b/tests/infiniband_pkey/test
>> @@ -32,7 +32,7 @@ close($f);
>>
>>   # The gid sysfs shows a fully expanded ipv6 address, just take the
>>   # top half.
>> -@tmp = unpack( '(a20)*', $gid );
>> +@tmp           = unpack( '(a20)*', $gid );
>>   $subnet_prefix = $tmp[0] . ":";
>>
>>   @labeled_pkeys = split( /,/, $conf{SELINUX_INFINIBAND_TEST_LABELED_PKEYS} );
>> --
>> 2.21.0
>>
> 

