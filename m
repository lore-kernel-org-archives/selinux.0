Return-Path: <SRS0=aI9x=QV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D55BC43381
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 20:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FE02192B
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 20:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="F4YMS3K/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390428AbfBNUWh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:22:37 -0500
Received: from uphb19pa08.eemsg.mail.mil ([214.24.26.82]:31719 "EHLO
        USFB19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387849AbfBNUWh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Feb 2019 15:22:37 -0500
X-EEMSG-check-017: 112463787|USFB19PA11_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2019 20:22:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550175753; x=1581711753;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QNJz6BRPbqud/hi9eHTrdHHKCnVcj12SzJzbKS604vg=;
  b=F4YMS3K/YvGHVy/LcFrIRbAZ568slNkmk2vqe6QyiwbdCMKXHXwQf+S+
   B79xaqfiyxaeCCHix8XVqvZTYyMKtZHN2ai6Q79ALKMPwq4JZk8bEue8b
   4W4v95UKydRnYJL5w5O5WWuy+z8lZjs1qUd0o4W1jbKSQm3k8DVfZ2Hi4
   IyfQyZBr9fOBdXH6oaxWDLo1krA1QGP8wOKwKAbRMZnz6jA8eLW+oJrSx
   BFbCZAKNP6BD5lS17m+BulQqB1lqCeHWGRzJ90TWm9IDeq8RfDd3BPEn8
   6PiQvTWeFpP0DDtbddTvqi9Jawl42mZuEF5qYVUd+CnEWDEzK2QaZ5f0t
   w==;
X-IronPort-AV: E=Sophos;i="5.58,369,1544486400"; 
   d="scan'208";a="20572177"
IronPort-PHdr: =?us-ascii?q?9a23=3AaRDG/R+nue3o7f9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B42ukcTK2v8tzYMVDF4r011RmVBdWds6oMotGVmpioYXYH75eFvSJKW713fD?=
 =?us-ascii?q?hBt/8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFR?=
 =?us-ascii?q?XjLwp1Ifn+FpLPg8it2O2+557ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyh?=
 =?us-ascii?q?zHontJf+RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKW?=
 =?us-ascii?q?E169b1uhTFUACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMsPsTbAwRD?=
 =?us-ascii?q?+s8aFlRhH1gysDLjI17n3bhsl2galGohyuugZ/zpbJbo+VKvR+cKDTc90USm?=
 =?us-ascii?q?VOXMleSyNPD5igb4YMFecNIfpUoof/qlYIsBCwBROsBOTqyjJQm3H2wbM10/?=
 =?us-ascii?q?whEQ7Y2gwrAs8AsHHOo9XxMKcdT+C0x7TPwDXYcvxWwizw6JTIcx89ofGMWq?=
 =?us-ascii?q?h8cczKyUY1DQ/FgVKQqZL8Mj6Ty+8DsHCb4vJ9We+ghGMrsQF8riW1yssyhY?=
 =?us-ascii?q?TFmJgZxk3C+C5k2og6P8e4R1R+YdO8FZtQsDyVOJVuT8M5RmFopD46yrobuZ?=
 =?us-ascii?q?6nZCQKyIooxxrYa/Gfb4iH+AjjVOeMITdjnn5lZLK+iAqy8Uin0OH8UNW70E?=
 =?us-ascii?q?1WoSZfl9nMt3QN2wTS6siBVPR94l+s1SuA2g3c8O1JIV04mbDFJ5Mu3LI8jI?=
 =?us-ascii?q?cfvVzGHiDsmUX2iKGWdl8j+uit8+nneajppoSHOo9oigDxLqQumsulDeQ+KQ?=
 =?us-ascii?q?gBRXKX+eu71L395UH5WqlFjuUqkqnFt5DXPdwbqbSkAw9RyYsj8wywDyqi0N?=
 =?us-ascii?q?gBmHkHK1VFeAiZgITzJ17OJ/X4B++lg1uwiDdr2+zGPrr5D5XWMHfDlLbhfb?=
 =?us-ascii?q?Bg609T0wcz099f6IxOCr0bI/L8RFXxtNrGAR89KQC0xPznCNounr8ZDHqGH6?=
 =?us-ascii?q?uxKKrPtRqN4eU1Lq+HY4pGliz6Lq0e+/P2jXI/0WQYdK2t0IpfPGu0Bdx6Mk?=
 =?us-ascii?q?6ZZjzqmd5HHmAU6FltBNf2gUGPBGYAL025WLgxs3RhUI8=3D?=
X-IPAS-Result: =?us-ascii?q?A2B3AAB7zWVc/wHyM5BkHAEBAQQBAQcEAQGBUgYBAQsBg?=
 =?us-ascii?q?VkpgWonhAaUCk0BAQEBAQaBCC2JOI5bgXs4AYRAAoNjIjUIDQEDAQEBAQEBA?=
 =?us-ascii?q?gFsKII6KYJnAQEBAQIBIwQLAQU6BxAJAhgCAiYCAlcTBgIBAYJfPYFmBQiPP?=
 =?us-ascii?q?JthfDOKNoELizkXeIEHgREngmuICoJXApBAgQaRDFwJiyiHJgYZgW6JEodzn?=
 =?us-ascii?q?hoBNYFWKwgCGAghD4MngigXjjwhAzCBBQEBj1UBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Feb 2019 20:22:22 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1EKMLl9019064;
        Thu, 14 Feb 2019 15:22:21 -0500
Subject: Re: [PATCH] scripts/selinux: add basic mls support to mdp
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org
References: <20190214191417.1469-1-sds@tycho.nsa.gov>
 <89b6edf0-b912-de7e-9ebe-dd2bd81004a6@tycho.nsa.gov>
Message-ID: <40480c97-fa8d-54eb-510e-1973c2ad1d74@tycho.nsa.gov>
Date:   Thu, 14 Feb 2019 15:22:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <89b6edf0-b912-de7e-9ebe-dd2bd81004a6@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/14/19 2:35 PM, Stephen Smalley wrote:
> On 2/14/19 2:14 PM, Stephen Smalley wrote:
>> Add basic MLS support to mdp.  Usage:
>> scripts/selinux/mdp/mdp -m policy.conf file_contexts
>> checkpolicy -M -o policy policy.conf
>>
>> Then install the resulting policy and file_contexts as usual.
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>   scripts/selinux/mdp/mdp.c | 131 ++++++++++++++++++++++++++++++--------
>>   1 file changed, 103 insertions(+), 28 deletions(-)
>>
>> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
>> index 073fe7537f6c..4672ee5cc1bd 100644
>> --- a/scripts/selinux/mdp/mdp.c
>> +++ b/scripts/selinux/mdp/mdp.c
>> @@ -97,8 +97,19 @@ int main(int argc, char *argv[])
>>       /* NOW PRINT OUT MLS STUFF */
>>       if (mls) {
>> -        printf("MLS not yet implemented\n");
>> -        exit(1);
>> +        fprintf(fout, "sensitivity s0;\n");
> 
> Do we want more than one sensitivity for this example?
> 
>> +        fprintf(fout, "dominance { s0 }\n"); > +        fprintf(fout, 
>> "category c0;\n");
>> +        fprintf(fout, "category c1;\n");
>> +        fprintf(fout, "level s0:c0.c1;\n\n");
>> +        for (i = 0; secclass_map[i].name; i++) {
>> +            struct security_class_mapping *map = &secclass_map[i];
>> +
>> +            fprintf(fout, "mlsconstrain %s {\n", map->name);
>> +            for (j = 0; map->perms[j]; j++)
>> +                fprintf(fout, "\t%s\n", map->perms[j]);
>> +            fprintf(fout, "} (l1 eq l2 and h1 eq h2);\n\n");
> 
> This constraint prohibits all permissions between s0:c0.c1 and s0:c0 
> (and vice versa) or between s0:c0 and s0 (or vice versa), for example. 
> It requires both low and high levels to be identical for any access to 
> be granted.  Not very useful.
> 
> Alternatively, we could require dominance (dom), in which case s0:c0.c1 
> would have all permissions to s0:c0, s0:c1, or just s0, while s0:c0 
> would no permissions to s0:c0.c1 or to s0:c1.  A little more interesting 
> but still probably not usable for anything.

OTOH, the MCS constraints are almost entirely written using dominance 
only, with a few exceptions.  If we included the highest sensitivity and 
all categories in the kernel initial SID context, then init would 
inherit that context (no domain transitions defined by mdp) and one 
could manually start a process with fewer or no categories via runcon or 
similar to exercise the constraints.  Still not very usable but might 
suffice for demonstration purposes.

> 
> Or we could split up the constraints into separate constraints on the 
> "read" operations versus the "write" operations like MCS or MLS.  But 
> that requires manually writing the constraints; we can't auto-generate 
> them for all classes/permissions that way without a separate 
> specification of which ones are reads and which ones are writes.  And we 
> would also likely need/want separate constraints on "create", 
> "transition", etc in order to ensure properly handling of the low/high 
> relationships.
> 
> Also, since there is only one domain/type defined by mdp, we can't have 
> some domains/types exempted and others not, so it is all or nothing.
> 
> Kind of hard to create a useful mls policy example without a richer TE 
> policy for mdp.
> 
>> +        }
>>       }
>>       /* types, roles, and allows */
>> @@ -108,34 +119,92 @@ int main(int argc, char *argv[])
>>       for (i = 0; secclass_map[i].name; i++)
>>           fprintf(fout, "allow base_t base_t:%s *;\n",
>>               secclass_map[i].name);
>> -    fprintf(fout, "user user_u roles { base_r };\n");
>> -    fprintf(fout, "\n");
>> +    fprintf(fout, "user user_u roles { base_r }");
>> +    if (mls)
>> +        fprintf(fout, " level s0 range s0 - s0:c0.c1");
>> +    fprintf(fout, ";\n");
>>       /* default sids */
>> -    for (i = 1; i < initial_sid_to_string_len; i++)
>> -        fprintf(fout, "sid %s user_u:base_r:base_t\n", 
>> initial_sid_to_string[i]);
>> +    for (i = 1; i < initial_sid_to_string_len; i++) {
>> +        fprintf(fout, "sid %s user_u:base_r:base_t",
>> +            initial_sid_to_string[i]);
>> +        if (mls)
>> +            fprintf(fout, ":s0");
>> +        fprintf(fout, "\n");
>> +    }
>>       fprintf(fout, "\n");
>> -    fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
>> -    fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
>> -    fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
>> -    fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
>> -    fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
>> -    fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
>> -    fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
>> -    fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
>> -
>> -    fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t;\n");
>> -    fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
>> -    fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
>> -
>> -    fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
>> -    fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
>> -    fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
>> -    fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
>> -    fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
>> -
>> -    fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
>> +    fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +    fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +    fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +    fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +    fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +    fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +    fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +    fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +
>> +    fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +    fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +    fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +
>> +    fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +    fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +    fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +    fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +    fprintf(fout, "fs_use_trans shm user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, ";\n");
>> +
>> +    fprintf(fout, "genfscon proc / user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, "\n");
>>       fclose(fout);
>> @@ -144,8 +213,14 @@ int main(int argc, char *argv[])
>>           printf("Wrote policy, but cannot open %s for writing\n", 
>> ctxout);
>>           usage(argv[0]);
>>       }
>> -    fprintf(fout, "/ user_u:base_r:base_t\n");
>> -    fprintf(fout, "/.* user_u:base_r:base_t\n");
>> +    fprintf(fout, "/ user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, "\n");
>> +    fprintf(fout, "/.* user_u:base_r:base_t");
>> +    if (mls)
>> +        fprintf(fout, ":s0");
>> +    fprintf(fout, "\n");
>>       fclose(fout);
>>       return 0;
>>
> 

