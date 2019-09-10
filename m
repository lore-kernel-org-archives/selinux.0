Return-Path: <SRS0=Wrvk=XF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8015FC49ED7
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 20:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4601621019
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 20:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="haP9zaT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfIJUKq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Sep 2019 16:10:46 -0400
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:2090 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfIJUKq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Sep 2019 16:10:46 -0400
X-EEMSG-check-017: 26367404|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="scan'208";a="26367404"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Sep 2019 20:09:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568146183; x=1599682183;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=DGejK8kpKKUFWlXRwx1Ktus2nJDVlQr0c4d1SeEFFng=;
  b=haP9zaT7z59de/ROHGiXDn81rXCAm2biYKo9TMZmqoUUIJ+0yIak7Zat
   MzvxSZn9QQJMvnf2nT5gMWeEEWaufDyQfOysr2s/pl0Y/nyDwfCe3c2OE
   /CV1fkBhdQ2aN2yoA8pOHgqT9BQWLe3N1bwIX8GbfT5VKqdIHS6mL3yzI
   xqmVG3tSyY31XeNTz15ymNWsfS9kjk5pG86/MzrRtol+9NamVh5tSewtT
   RuW8LoC2lH8QJRoHsNcvSv/StSlgCuR7WLR+KHAJoip9AEJgPK8DCa8ln
   ZxaY7CkQsI7UIDB3SUo4W2EJ+GSnLwzohy0kUiZbi6qWFSC55vJs+cs50
   w==;
X-IronPort-AV: E=Sophos;i="5.64,490,1559520000"; 
   d="scan'208";a="32658855"
IronPort-PHdr: =?us-ascii?q?9a23=3AiqaRyBJoMlLKl50SFdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfKPnxwZ3uMQTl6Ol3ixeRBMOHsqkC07Kd6vq6ESxYuNDd6SpEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQYjId4Nqo91h?=
 =?us-ascii?q?TFrmZWd+hI2GhkIU6fkwvm6sq/4ZJv7T5ct+49+8JFTK73Y7k2QbtEATo8Lm?=
 =?us-ascii?q?s7/tfrtR7NTQuO4nsTTGAbmQdWDgbG8R/3QI7/vjP1ueRh1iaaO9b2Ta0vVj?=
 =?us-ascii?q?S586hrUh7ohzwZODM/7Wral9Z/jKNfoBKmuhx/34vZa5ybOfZiYq/Qe84RSH?=
 =?us-ascii?q?FfVchNSSNOHoK8b5MOD+UfO+ZYs5L9rEYKoRenGAWgGP/jxjpOi3D4x6061/?=
 =?us-ascii?q?kqHx/A0gIuAtkCtG3YodvxOasXV+2+0avGwijZb/5OxDnz9obIfBAir/+CU7?=
 =?us-ascii?q?1/fsjexlUgGQ7eklWdqpboMy+J2ukDsWWW6fdrW+K1i24grgF8ujqvx8kwhY?=
 =?us-ascii?q?bTnIIV1k7I/jh+zYY3K9y3VFR0YcS4EJdOrCyaK4t3Td8iQ2Fvoio6zKYGto?=
 =?us-ascii?q?ShcCgFz5Qn2QfSZvqaeIaL+hLuTPudLDh3iX5/eL+zmgy+/Vavx+HiTMW4zV?=
 =?us-ascii?q?BHpTdfnNbWrHACzRnT59CCSvt640iuxy6C1xvW6uFYOUA0krfbK4I5zr4wiJ?=
 =?us-ascii?q?UTtUPDEzfqmErslq+Wd1gk+vOy5+T7YrTpup+cN4huhgH4LqsugdCwDf49Mg?=
 =?us-ascii?q?gPW2iX4eW81Lv98k3lWLhGk/I7n6bDvJ3aOMgXvLC1DgBL3oo59hqzFzKm38?=
 =?us-ascii?q?4ZnXkDIlJFYhWHj43xNlHMLvH3Ee2wg06wkDt13P3GIr3gDYnNLnjEirvhe6?=
 =?us-ascii?q?195FRGxAo8ytBf+YpYCqsdL/LrRk/xqNvYAwc/Mwy13+nnD9F92ZkFWW6VA6?=
 =?us-ascii?q?+ZN6TSsUST5u80JumBa4AUtCz6K/g/6P7klWU5lkMFfam1wZsXb2i1Hu94LE?=
 =?us-ascii?q?WdYHrshMoBEGgRswogQ+zllkeCXSRQZ3msRaI84C80CIa8AYfEXICtj+/J4C?=
 =?us-ascii?q?DuOJxdYWRPERitFnDzbM3QXfYHbyabOYlglTsfTpCkF59n0guh4kuy0LdjL+?=
 =?us-ascii?q?zJ6gUGup/5ktt4/evekVc17zMnId6a1jSPUGp9hH9SD2s0w6t2u1An4kuS2q?=
 =?us-ascii?q?h/xfpDHJpc4O0fAVRyDoLV0+EvU4O6YQnGZNrcDQ/9E9g=3D?=
X-IPAS-Result: =?us-ascii?q?A2D7AADjAXhd/wHyM5BlHgEGBwaBVQcLAYFtKoE/ATIqh?=
 =?us-ascii?q?CGPEoIPmR6BewkBAQEBAQEBAQE0AQIBAYISgi0CgkkjNgcOAgwBAQEEAQEBA?=
 =?us-ascii?q?QEGAwEBbIU6gjopAYJnAQUjDwEFUQkCCQ8CAiYCAlcGAQwGAgEBgl8/gguMa?=
 =?us-ascii?q?5tvgTKFS4MsgUmBDCiLeIFXQIERJ4JrPodPglgEgS8BiyKKPpU3BoIllHEGG?=
 =?us-ascii?q?5kKjX+abwIvgVgrCkGBaIFOgnqOKSQDMIEGAQGPIAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Sep 2019 20:09:43 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8AK9fW5018040;
        Tue, 10 Sep 2019 16:09:41 -0400
Subject: Re: [Non-DoD Source] [PATCH 3/9] libsepol: do not dereference a
 failed allocated pointer
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190901180636.31586-1-nicolas.iooss@m4x.org>
 <20190901180636.31586-4-nicolas.iooss@m4x.org>
 <18ca1f8d-6934-f3e3-31aa-a2a5d1493ffc@tycho.nsa.gov>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <f922c2fb-b8bb-6b73-6c51-0daff051b256@tycho.nsa.gov>
Date:   Tue, 10 Sep 2019 16:11:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <18ca1f8d-6934-f3e3-31aa-a2a5d1493ffc@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/10/19 2:52 PM, jwcart2 wrote:
> On 9/1/19 2:06 PM, Nicolas Iooss wrote:
>> When strs_stack_init(&stack) fails to allocate memory and stack is still
>> NULL, it should not be dereferenced with strs_stack_pop(stack).
>>
>> This issue has been found using Infer static analyzer.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> ---
>>   libsepol/src/kernel_to_cil.c  | 8 +++++---
>>   libsepol/src/kernel_to_conf.c | 8 +++++---
>>   2 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
>> index 320af37b2bc8..9fcc254707ba 100644
>> --- a/libsepol/src/kernel_to_cil.c
>> +++ b/libsepol/src/kernel_to_cil.c
>> @@ -108,10 +108,12 @@ static char *cond_expr_to_str(struct policydb *pdb, 
>> struct cond_expr *expr)
>>       return str;
>>   exit:
>> -    while ((new_val = strs_stack_pop(stack)) != NULL) {
>> -        free(new_val);
>> +    if (stack) {
>> +        while ((new_val = strs_stack_pop(stack)) != NULL) {
>> +            free(new_val);
>> +        }
>> +        strs_stack_destroy(&stack);
>>       }
>> -    strs_stack_destroy(&stack);
>>       return NULL;
>>   }
> 
> constraint_expr_to_str() has the same problem.
> 
>> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
>> index 930bafabdd4b..2c8da49a11ab 100644
>> --- a/libsepol/src/kernel_to_conf.c
>> +++ b/libsepol/src/kernel_to_conf.c
>> @@ -106,10 +106,12 @@ static char *cond_expr_to_str(struct policydb *pdb, 
>> struct cond_expr *expr)
>>       return str;
>>   exit:
>> -    while ((new_val = strs_stack_pop(stack)) != NULL) {
>> -        free(new_val);
>> +    if (stack != NULL) {

I forgot to mention that you should just use "if (stack) {" like above so the 
syntax is consistent.

Thanks,
Jim

>> +        while ((new_val = strs_stack_pop(stack)) != NULL) {
>> +            free(new_val);
>> +        }
>> +        strs_stack_destroy(&stack);
>>       }
>> -    strs_stack_destroy(&stack);
>>       return NULL;
>>   }
>>
> 
> Same comment here. constraint_expr_to_str() also needs to be fixed.
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
