Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361F8C43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 15:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B93A208C3
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 15:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Feg6n0tE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfLKPyY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:54:24 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:24757 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbfLKPyX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 10:54:23 -0500
X-EEMSG-check-017: 34595258|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="34595258"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Dec 2019 15:54:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576079661; x=1607615661;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=tloPCO7unuiDaBG4vyJs9b0EP/z1AyHkiP6SbU+r56E=;
  b=Feg6n0tEa4WSnyNFltH/PJco9KDr1Chk8bjXI05JxhWUaPWOzQYe0mJm
   RRRX6FSU1QLZYTItVRnWUNGK0AY+q87JjlN4YfkP5QW33jVmWR8kC8Qt8
   DLI6IjaAOWiF/RP3xXQssCJ1IiLQwmDSk8p5cNX2n1dsDtg2OdAfvGQav
   f5XPQmifmi66FfzTqtdqbKf8pqnCL80q0aNwBLk3Tl2oXb+t+N3u3ZfXm
   g7mIBBkTRCBj8AvbbYxDE36ES+W450SBsSENHPUdTdT4cP74AhwGeQ9B4
   3mfJ4q8AdEP7tsPQlcaoCId1j6GWTtuVRIbzSsnj9AGDYZp3vNB68Mtie
   g==;
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="30995826"
IronPort-PHdr: =?us-ascii?q?9a23=3A0PG3VxVjq3kodilC5rzCGo60qCDV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRSEt8tkgFKBZ4jH8fUM07OQ7/m7HzVRvN3e7TgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajI9iJ6o+yB?=
 =?us-ascii?q?bEomZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+27ZkMxwiL9QrgynqRJx3oXYZJiZOOR6c6/Ye94RWG?=
 =?us-ascii?q?hPUdtLVyFZH42yb5UBD+QCM+hWoYbyqFkBogexCwS3GOPiySVFimPq0aA00e?=
 =?us-ascii?q?ksFxzN0gw6H9IJtXTZtMj7NLsMXuCtzKnH0zPDZO5L1zf48ofIdhQhru+MXL?=
 =?us-ascii?q?ltdsfR0lQgFxjeg1WMqY3qIzOV1uMXv2id9OpvT/iji2EgqwFvuzWiwNonhI?=
 =?us-ascii?q?fOhoIQ0F/E9CN5zZ46Jd25VE57YcOkH4BKuy6GMIt2R8UvSHxrtiYi0rAKpJ?=
 =?us-ascii?q?G2cScQxJkn2hLTceKLfoeW7h75SeqcJypzimh/d7KlnRmy9FCtyuj7Vsapzl?=
 =?us-ascii?q?lHtjFFktzQtnAV0BzT99SHRuN9/ki/3TaP0Bje6v1eLkAulKrbNoUhzqQxlp?=
 =?us-ascii?q?oVv0TDGTT2l1vqg6OMakUl+vSn6+TgYrn8oJ+TK5R0hR3kPqQrm8y/Bfw0Mg?=
 =?us-ascii?q?kIX2eF5eSxzKDv8EL2TblQjvA6j7PVvI7VKMgFvKK1HhdZ0oM55Ba+Czem3s?=
 =?us-ascii?q?4YnX4CLF9dYxKIkpPpNkrSIPH4Efi/g1OsnC1tx/DdJLLtGJrNLn/dkLv5Z7?=
 =?us-ascii?q?Zy91ZcyBYvzdBY/59UCLYBIOnzWk/1rtPYCAI2Phe7w+biEtp914ceVXiTDa?=
 =?us-ascii?q?+eNaPYqUWI6f43I+mQeI8Vvy7wK+M76P7qjH85n0IdfKay0JsJZ3C3AO5mL1?=
 =?us-ascii?q?+aYXXymNcBF3kFvg4kQOztkl2CXm0bW3HnfaUn5iwyQLmtDYLCSoSuh7KMxm?=
 =?us-ascii?q?/vHJpNZmRPDFykHnLhdoHCUPAJPmbaOcJlkzoZRZC/RII7kxKjrgn3z/xgNO?=
 =?us-ascii?q?WH1DcfsMfYyNVt5+DV3So3/DhwAtXVh3qBVEloj2gIQHkwx6k5rktjnATQmZ?=
 =?us-ascii?q?NkiuBVQIQAr8hCVR03YNuGnuE=3D?=
X-IPAS-Result: =?us-ascii?q?A2A6AABdD/Fd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBbQMBAQELAYFzgRhVIBIqhAOJA4ZsAQEBAQEBBoE3iWmRRgkBAQEBAQEBA?=
 =?us-ascii?q?QErDAEBg3tFAoIpNwYOAhABAQEEAQEBAQEFAwEBbIU3DII7KYJ7AQUjDwEFU?=
 =?us-ascii?q?QkCDgoCAiYCAlcGAQwGAgEBgl8/AYJSJQ+RTZt0gTKEOgGEUYFIgQ4oAYwxe?=
 =?us-ascii?q?YEHgTgPgl0+gReBTQKBLINHgl4El0iXI4I5gjyEaI5MBhuDNpcKjFqBcIhJk?=
 =?us-ascii?q?38jgVgrCAIYCCEPgycJRxEUjHIXg1CFZYUMIwMwjGSCQQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 11 Dec 2019 15:54:20 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBBFs6GO187010;
        Wed, 11 Dec 2019 10:54:06 -0500
Subject: Re: [PATCH] python/semanage: check variable type of port before
 trying to split
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Joshua Schmidlkofer <joshland@gmail.com>, selinux@vger.kernel.org
References: <CAHduLLQV07RPLcV-3ffaebEosQS_DRAk_7ZconHbdkx8oAHejQ@mail.gmail.com>
 <ef5d3b3d-5f6f-7f74-0409-9425bfd9b7af@tycho.nsa.gov>
Message-ID: <7f1e2dcc-2dd7-82b9-cb66-a79205672935@tycho.nsa.gov>
Date:   Wed, 11 Dec 2019 10:54:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ef5d3b3d-5f6f-7f74-0409-9425bfd9b7af@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/10/19 3:38 PM, Stephen Smalley wrote:
> On 12/6/19 7:17 PM, Joshua Schmidlkofer wrote:
>> While using Ansible's Selinux module to manage ports, I discovered
>> that numerical ports caused an unhandled exception in 'seobject.py'.
>> This appears to be a bug, and I am proposing a fix which checks the
>> type of the argument before operating on it.  This maintains the
>> original functionality in the case of a string, and acts in the same
>> fashion if you supply an integer.
>>
>> I did not find any open bug report against the SELinux project. The
>> downstream bug report is here:
>> https://github.com/ansible/ansible/issues/60968
>>
>>
>> Signed-off-by: Joshua Schmidlkofer <joshua@joshuainnovates.us>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Thanks, applied.

> 
>> ---
>>   python/semanage/seobject.py | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
>> index dc413ca5..0e9ce290 100644
>> --- a/python/semanage/seobject.py
>> +++ b/python/semanage/seobject.py
>> @@ -1070,7 +1070,11 @@ class portRecords(semanageRecords):
>>           if port == "":
>>               raise ValueError(_("Port is required"))
>>
>> -        ports = port.split("-")
>> +        if isinstance(port, str):
>> +            ports = port.split('-', 1)
>> +        else:
>> +            ports = (port,)
>> +
>>           if len(ports) == 1:
>>               high = low = int(ports[0])
>>           else:
>> -- 
>> 2.23.0
>>
> 

