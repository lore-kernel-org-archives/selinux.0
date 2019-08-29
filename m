Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4B2C3A59F
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 20:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E89C22CEA
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 20:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="dI7jbQcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfH2URk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:17:40 -0400
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:16816 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfH2URj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 16:17:39 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Aug 2019 16:17:38 EDT
X-EEMSG-check-017: 19845992|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,444,1559520000"; 
   d="scan'208";a="19845992"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA40.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Aug 2019 20:10:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567109431; x=1598645431;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yzVVwjmDG/Lq2E2sE4UG7APdJsNTUK/rEj+kYw7cwi4=;
  b=dI7jbQcz+3MAOOxQ3i2KTTWBg5TOjVeWTWlaceKX0iZDnglpha+EjebY
   cPo6GG8fMsDJLej90/EiqqjlCG07zvNdQMQpewCQxa8Jdb11hPk0JQ0cI
   KuveaEy1k8XPj9yLhsOchE28Qlu7Uja4fk20CDmixwYQzITK+skRIn0/a
   8V1UR61VzRr6MSZedB7AV2MOYlEOva88TtYZ5/MJTAIEFqbwyQuHwErjf
   hGOKoooHxKisSpA+AyRBo/NxowXVvTdIVHjxanQ/BzMTheDjZ+5BwQQ2L
   O4Myn72oK4BdXmJKFK0naxu+f1AXed0brxKS82sOLqszJYO7f0V0ILmIG
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,444,1559520000"; 
   d="scan'208";a="32151453"
IronPort-PHdr: =?us-ascii?q?9a23=3AG0S1chHZHt3D01fzhww3iJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zrsmwAkXT6L1XgUPTWs2DsrQY0rCQ6v66EjVcud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMhm6txjdu8gIjYdtN6o8xQ?=
 =?us-ascii?q?fFqWZUdupLwm9lOUidlAvm6Meq+55j/SVQu/Y/+MNFTK73Yac2Q6FGATo/K2?=
 =?us-ascii?q?w669HluhfFTQuU+3sTSX4WnQZSAwjE9x71QJH8uTbnu+Vn2SmaOcr2Ta0oWT?=
 =?us-ascii?q?mn8qxmRgPkhDsBOjUk62zclNB+g7xHrxKgvxx/wpDbYIeJNPplY6jRecoWSX?=
 =?us-ascii?q?ddUspNUiBMBI2zb5ELD+EcI+hWqYfzrEYKoRenBQShAObjxzlVjXH0wKI6yf?=
 =?us-ascii?q?wsHxzY0gwuH9wAs3rao9v6O6gQTe+7w7LFzSnBYv5MxTvx9IbFfxInrPqRXb?=
 =?us-ascii?q?xwa83RyUw3GgPHgFSftZbqPymJ1ugTrmOW6OhgVOyzhGE9sQFxviajy9wwio?=
 =?us-ascii?q?jJmo0VylfE+T9/wIYuP9K0UkF7Ydm6EJZJsSyRKoh4Qts6Tm11tys3xacKtJ?=
 =?us-ascii?q?6mcCQQ1pgqyADTZ+aaf4WO/xntTvyeIS1ii3JgYL+/ghGy/lW+xeDkTcm01U?=
 =?us-ascii?q?pKrjJCktnRqnABzxzT5daDSvt65kqhxSyA1xrS6uFZOkA4j7bbKp49zb4wkZ?=
 =?us-ascii?q?ofq0LDETPtmErqlqOWc0Qk+uyw5+TmZLXpuIOcOpdphgzxPakigMyyDfkiPg?=
 =?us-ascii?q?QQUGWX5/6w2KD78U38WrpKj/k2kqfDsJDdIMQWvqy5AgFJ3Yk58Ra/Eymq3c?=
 =?us-ascii?q?8EnXgHMF1FeBWHg5LvO1HVOv/0F/i/g1OykDtz3fDJIqXhAonRLnjEiLrhf7?=
 =?us-ascii?q?F961VcyAou199T/YlbCqsAIPL1R0DxsMLXAwQlPAyu3ubnDsly1oMeWG2SGK?=
 =?us-ascii?q?CZLLndvUWU6eIoJumGfJUVtyrlK/g5+/7uimc0mUQDcqmt3JsXbm24H/t9Lk?=
 =?us-ascii?q?WHbnrjnM0BHX0JvgUgVuzqjkONUTpJa3a1RaI86WJzNIXzL4DYRp2kyJab3S?=
 =?us-ascii?q?G3GpAeMmJBEVCRGDHibYSCV/MBQCmIP8lqki0IXKSoDYQm0Ef9mhX9zu9lMe?=
 =?us-ascii?q?Hd4DFC/cbhy9N8/fGJvQ0j/jxzScKG2ieCSH8izTBAfCM/wK0q+R818VyEy6?=
 =?us-ascii?q?UtxqUFRNE=3D?=
X-IPAS-Result: =?us-ascii?q?A2AbBwDzL2hd/wHyM5BmHQEBBQEHBQGBZwKBbCqBPwEyK?=
 =?us-ascii?q?oQhkHMlfpoVCQEBAQEBAQEBATQBAgEBghKCLQKCWSM4EwILAQEBBAEBAQEBB?=
 =?us-ascii?q?gMBAWyFOkIBEAGBZikBgmYBAQEBAgEjBBFBBQsLCQ8CAiYCAlcGDQYCAQGCX?=
 =?us-ascii?q?z+BfA+sIX8zhUqDNoFJgQwoAYt2gVdAgREnDIIqNT6HT4JYBIEuAYsUiHuVX?=
 =?us-ascii?q?W0GA4IglE0GG4IylistjniZECGBWCsKQYFogU6CTheOPiMDMIEGAQGFKIleA?=
 =?us-ascii?q?QE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 29 Aug 2019 20:10:30 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7TKARav018371;
        Thu, 29 Aug 2019 16:10:27 -0400
Subject: Re: [Non-DoD Source] [PATCH] Add default_range glblub support
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     selinux@vger.kernel.org, Steve Smalley <sds@tycho.nsa.gov>
References: <20190826142009.2241-1-joshua.brindle@crunchydata.com>
 <d6b2555e-fbda-b3e2-d451-a6e9500e3646@tycho.nsa.gov>
 <CAGB+Vh41FrvMOs2MoONi23gmve0i3oz3m70Fbitkj629EiMBHg@mail.gmail.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <496c9521-dd58-7164-f3c6-c233c8f5dc5f@tycho.nsa.gov>
Date:   Thu, 29 Aug 2019 16:12:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGB+Vh41FrvMOs2MoONi23gmve0i3oz3m70Fbitkj629EiMBHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/29/19 3:25 PM, Joshua Brindle wrote:
> On Thu, Aug 29, 2019 at 3:12 PM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
>>
>> On 8/26/19 10:20 AM, Joshua Brindle wrote:
>>> Policy developers can set a default_range default to glblub and
>>> computed contexts will be the intersection of the ranges of the
>>> source and target contexts. For example, one can add a default with
>>> this cil:
>>>
>>> (defaultrange db_table glblub);
>>>
>>> and then test using the compute_create utility:
>>>
>>> $ ./compute_create system_u:system_r:kernel_t:s0:c1,c2,c5-s0:c1.c20 system_u:system_r:kernel_t:s0:c0.c20-s0:c0.c36 db_table
>>> system_u:object_r:kernel_t:s0:c1,c2,c5-s0:c1.c20
>>>
>>
>> It would be nice to say what glblub means and to have an example for checkpolicy
>> as well.
>>
> 
> Can do.
> 
> <snip>
>>> --- a/libsepol/cil/src/cil_policy.c
>>> +++ b/libsepol/cil/src/cil_policy.c
>>> @@ -834,6 +834,9 @@ static void cil_default_ranges_to_policy(FILE *out, struct cil_list *defaults)
>>>                case CIL_DEFAULT_TARGET_LOW_HIGH:
>>>                        fprintf(out," %s %s", CIL_KEY_TARGET, CIL_KEY_LOW_HIGH);
>>>                        break;
>>> +             case CIL_DEFAULT_GLBLUB:
>>> +                     fprintf(out," %s %s", CIL_KEY_TARGET, CIL_KEY_GLBLUB);
>>
>> I think you just want fprintf(out," %s", CIL_KEY_GLBLUB);
> 
> Yea, you are right. I wonder why this even works then?
> 
> <snip>
> 
>>> --- a/libsepol/src/kernel_to_conf.c
>>> +++ b/libsepol/src/kernel_to_conf.c
>>> @@ -673,6 +673,9 @@ static int write_default_range_to_conf(FILE *out, char *class_name, class_datum_
>>>        case DEFAULT_TARGET_LOW_HIGH:
>>>                dft = "target low-high";
>>>                break;
>>> +     case DEFAULT_GLBLUB:
>>> +             dft = "glblub";
>>> +             break;
>>>        default:
>>>                sepol_log_err("Unknown default type value: %i", class->default_range);
>>>                return -1;
>>
>> You need to update kernel_to_cil.c as well.
> 
> Good catch. As a side note changing the policy has many more touch
> points than it use to (this is my first time making an update that
> include CIL). Is there some checklist or developer readme or something
> available?
> 

No, there is no checklist. I can see how it would be useful though.

> Also, it isn't clear how to test all the combinations. I did add:
> 
> Add via CIL module (which combos does that test?)
That tests secilc

> Add to exported CIL base (is that really the same as above?)
That also tests secilc

> Add to .te base
> 
That tests checkmodule

> What would I have needed to do to see that kernel_to_cil.c hadn't been updated?
> 

1. checkpolicy -M -C -o foo.cil foo.conf
    This converts conf to cil and tests module_to_cil.c.

2. checkpolicy -M -C -b -o foo.cil foo.bin
    This converts kernel binary to cil and tests kernel_to_cil.c

3. checkpolicy -M -F -b -o foo.conf foo.bin
    This converts kernel binary to conf and tests kernel_to_conf.c

4. secil2conf -o foo.conf foo.cil
    This converts cil to conf and tests cil_policy.c

I think that covers everything. It is complicated.

> <snip>
> 
>>> --- a/libsepol/src/write.c
>>> +++ b/libsepol/src/write.c
>>> @@ -46,6 +46,11 @@
>>>    #include "private.h"
>>>    #include "mls.h"
>>>
>>> +#define glblub_version ((p->policy_type == POLICY_KERN && \
>>> +                  p->policyvers >= POLICYDB_VERSION_GLBLUB) || \
>>> +                 (p->policy_type == POLICY_BASE && \
>>> +                  p->policyvers >= MOD_POLICYDB_VERSION_GLBLUB))
>>> +
>>>    struct policy_data {
>>>        struct policy_file *fp;
>>>        struct policydb *p;
>>> @@ -1034,6 +1039,13 @@ static int class_write(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
>>>             p->policyvers >= MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS)) {
>>>                buf[0] = cpu_to_le32(cladatum->default_user);
>>>                buf[1] = cpu_to_le32(cladatum->default_role);
>>> +             if (!glblub_version && cladatum->default_range == DEFAULT_GLBLUB) {
>>> +                     WARN(fp->handle,
>>> +                             "class %s default_range set to GLBLUB but policy version is %d (%d required), discarding",
>>> +                             p->p_class_val_to_name[cladatum->s.value - 1], p->policyvers,
>>> +                             p->policy_type == POLICY_KERN? POLICYDB_VERSION_GLBLUB:MOD_POLICYDB_VERSION_GLBLUB);
>>> +                        cladatum->default_range = 0;
>>> +                }
>>>                buf[2] = cpu_to_le32(cladatum->default_range);
>>>                items = put_entry(buf, sizeof(uint32_t), 3, fp);
>>>                if (items != 3)
>>>
>>
>> Everything else looks ok, but I haven't tested it yet.
> 
> Thanks. You can test using the test suite as well, I'm impressed that
> adding a bunch of sensitivities to an mcs policy works as well as it
> does!
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
