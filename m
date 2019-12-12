Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518B5C43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 13:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B1E2173E
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 13:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="hMBKmTGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfLLNpM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:45:12 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:46961 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbfLLNpM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 08:45:12 -0500
X-EEMSG-check-017: 37849060|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="37849060"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Dec 2019 13:45:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576158309; x=1607694309;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=EFW1coMtwW9ofosIm6NpMDgwS+faNJ0hNjkqfKaEBgI=;
  b=hMBKmTGRQ5oSIqDttRw02FJ/99lDrhBcjdqxvXPGlIHHpWbmCS9JzwGK
   C8QFXzE5hfiJn7nA4c8lBOuGUWqFZj/60pQpVnVg++qdYcOMIekMqcQzN
   fUdVhYUG9DCV2Yqxkwv4nF8919iyBTVRJLDyPaYA1hdtfe+T8KROO2Ty0
   eyxI2cVUF041E1ptNUA2dZZNMcFJljZXuo2I6wSaOROMbnxcUDXihlpP8
   ioJof7id9zlKsxC5hzMdXFv9l70ATnySNujuvnfgejSgB0GUXT72DB/Ly
   B4prkSMEQWa9F/S74QCC3JaFHMSSLaagEltVvULXZYuHjlfcgCGHi30xv
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,306,1571702400"; 
   d="scan'208";a="31032530"
IronPort-PHdr: =?us-ascii?q?9a23=3ANns6Xh2cdT/FOnt5smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIRKPad9pjvdHbS+e9qxAeQG9mCsLQd2rWd7v2ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBiyrwjduckbjIt/Iast1x?=
 =?us-ascii?q?XFpWdFdf5Lzm1yP1KTmBj85sa0/JF99ilbpuws+c1dX6jkZqo0VbNXAigoPG?=
 =?us-ascii?q?Az/83rqALMTRCT6XsGU2UZiQRHDg7Y5xznRJjxsy/6tu1g2CmGOMD9UL45VS?=
 =?us-ascii?q?i+46ptVRTnhj0HNzok+2/JjMJ+gr9QrBa4qxFxx4PYZYeYP+d8cKzAZ9MXXX?=
 =?us-ascii?q?dPUNhfVyJBAY2yYYUAAOUDMulEoIfwvEcOoBmkCAWwGO/ixD1Fi3nr1qM6ye?=
 =?us-ascii?q?QhFgTG0RQ9EdISrnvUtNX1O7kUUeuo0afIyC/Mb/dS2Tjj6InDbxcsoeqRUr?=
 =?us-ascii?q?JrasfR1UkuGB/FjlWXs4DlOSiV2f4Xv2iU6OpgS/uihmg6oA9yujii3togh4?=
 =?us-ascii?q?bGi44Pyl3I6D91zJg6KNGmUkJ3fNipG4ZKuS6ALYt5WMYiTnltuCY917IJp4?=
 =?us-ascii?q?a2fDMPyJQ73x7fbOGHc5SQ7hLjSumRJTB4iWp5eL2lnRay8FWgyvbmWsm11l?=
 =?us-ascii?q?ZKoC1FksLSuX8RzRDT9siGRed9/kemwzqP0Rzc6vpYLkwukKrbKpohzqYxlp?=
 =?us-ascii?q?oVr0vDAjf7lFj5gaKZbEkp+vWk5/75brjpuJOQLZJ4hhn7Mqs0m8y/Beo4Mh?=
 =?us-ascii?q?IJX2ie4em8z6Ds/VbiTbVWjvw5jqnZsJfAKcQdva62GRVZ0okk6xahFzumys?=
 =?us-ascii?q?gXnWEbLFJZfxKKl5PpNE/KIPD5C/e/nlutnSx1x/DJILLhGI/BLnvdn7f7e7?=
 =?us-ascii?q?Zy9UpcxBA0zdBF6JJeEqsBL+7rWk/tqNzYCQc0PBGuzOn7Etl90Z0eVnyVAq?=
 =?us-ascii?q?+DMaPdrEGH6/kgI+mJfoAVuTL9J+I56P7piH9q0WMaKLKk2ZoRdWCQAPtrOQ?=
 =?us-ascii?q?OabGDqj9NHFn0F+kISS+nrjlyJUnZ8fXe8Q+po6jgwToW4AJ3ZR4ygqLOE1S?=
 =?us-ascii?q?a/WJZRYzYVJEqLFCLTa4icW/oKIBmXK8tlny1MAaOtUKc9xBqus0n80LMhIe?=
 =?us-ascii?q?3KrH5L/an/3cR4srWA3So58iZ5WoHGgmw=3D?=
X-IPAS-Result: =?us-ascii?q?A2DyAAC7Q/Jd/wHyM5BkGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gW0gEiqEA4kDhmoGBoE3iVsOkUYJAQEBAQEBAQEBNwEBhEACgi44E?=
 =?us-ascii?q?wIQAQEBBAEBAQEBBQMBAWyFQ4I7KYJ7AQUjFVELGAICJgICITYGAQwGAgEBg?=
 =?us-ascii?q?l8/gkcDCSWtQoEyhU+CPg1jgUiBDiiMMnmBB4E4D4IoNT6CG4U+gl4EjRMSR?=
 =?us-ascii?q?IkaRnaVbUOCOoI8jxqEHQYbmkGOS4pjkWsigVgrCAIYCCEPgydQERSQLBeOQ?=
 =?us-ascii?q?SMDMJAlAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Dec 2019 13:45:05 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBCDinIf025005;
        Thu, 12 Dec 2019 08:44:50 -0500
Subject: Re: [PATCH v2] mcstrans: start early and stop late
To:     selinux@vger.kernel.org, Dominick Grift <dac.override@gmail.com>
References: <20191211134423.2357254-1-dac.override@gmail.com>
 <20191211142124.GB2233813@brutus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d992aba5-77a3-bd47-6cae-95fc5ecf10dd@tycho.nsa.gov>
Date:   Thu, 12 Dec 2019 08:45:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211142124.GB2233813@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/11/19 9:21 AM, Dominick Grift wrote:
> On Wed, Dec 11, 2019 at 02:44:23PM +0100, Dominick Grift wrote:
>> It stopped too early, exposing a bug in sudo selinux_restore_tty():
>>
>> SELINUX_ERR op=setxattr invalid_context="wheel.id:wheel.role:users.terminals.pty.pty_file:SystemLow"
>> avc:  denied  { mac_admin } for  pid=859 comm="sudo" capability=33 scontext=wheel.id:wheel.role:sudo.wheel.subj:s0 tcontext=wheel.id:wheel.role:sudo.wheel.subj:s0 tclass=capability2 permissive=0
>>
>> If we want to be able to reference human readable contexts in SELinuxContext= and nspawn -Z and -L then we need mcstrans ASAP
> 
> Unfortunately it does not quite seem to address this challenge, at least currently, but still
> I think systemd would need to refresh its label cache when mcstrans is started, as per systemd v245 that should be a little less painful than it is today
> Something like a: ExecStartPost=/bin/systemctl daemon-reload would do that then

I'm a little unclear on where the bug lies - you show a sudo denial, but 
refer to systemd as the culprit?

If we don't care about being able to use translated contexts in systemd 
unit files or options, it could always use the _raw interfaces to ensure 
that it is always dealing with the raw kernel contexts.  The translated 
contexts are mostly for display purposes for MLS labels/policies.

> 
>>
>> v2: stop late, but do stop
>> Signed-off-by: Dominick Grift <dac.override@gmail.com>
>> ---
>>   mcstrans/src/mcstrans.service | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/mcstrans/src/mcstrans.service b/mcstrans/src/mcstrans.service
>> index 09529432..c13cd09a 100644
>> --- a/mcstrans/src/mcstrans.service
>> +++ b/mcstrans/src/mcstrans.service
>> @@ -2,6 +2,9 @@
>>   Description=Translates SELinux MCS/MLS labels to human readable form
>>   Documentation=man:mcstransd(8)
>>   ConditionSecurity=selinux
>> +DefaultDependencies=no
>> +Before=shutdown.target sysinit.target
>> +Conflicts=shutdown.target
>>   
>>   [Service]
>>   ExecStart=/sbin/mcstransd -f
>> -- 
>> 2.24.0
>>
> 

