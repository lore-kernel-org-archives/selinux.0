Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A48C49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 14:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6C92171F
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 14:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="huxAcjxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbfIPOqx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:46:53 -0400
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:9749 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732374AbfIPOqx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 10:46:53 -0400
X-EEMSG-check-017: 23049506|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="23049506"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Sep 2019 14:46:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568645203; x=1600181203;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2DO9UhilKmMTvz4NKjWc3WbXmrf0dqfv+FAb2SsUTxk=;
  b=huxAcjxeUUf3CbC05qVEJ86ySpC+GO6Sud3H+q3IwHPLTRjfzEqeKLIy
   izTlHAHMbNiB4vzVGO7EIeT2wMTtUAmme7SQ/r0akIl7EsKPGwVVoemRj
   44sqQjF+4nZnzC/dT7PHIlag6vILznwgzwIxYVBPp+HgO5Xn7gvWh/rBy
   mxFFMQN5N76IC5MvVm2NWTxlDUaTl79QlDjhOUHmx4ZL5OBWL3XuXcxEM
   9mJY1oa9/PNNl+KLkzlCM6TBFHwQzSUNGLu+R5K4G/p/ZbJr69shouq7N
   Xpu3h8MZkJWj5Fzyaoq1FvT7NBpmBZhSKU0tTe6tZxywujSeqED6o/Rxy
   A==;
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="27951295"
IronPort-PHdr: =?us-ascii?q?9a23=3AkskvpBFl3Ktoql8cPvxa6J1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yrsywAkXT6L1XgUPTWs2DsrQY0rGQ6vurBj1Ioc7Y9ixbKtoUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIVvJrwsxh?=
 =?us-ascii?q?bHrXdFeeBbzn5sKV6Pghrw/Mi98IN9/yhKp/4t68tMWrjmcqolSrBVEC4oOH?=
 =?us-ascii?q?0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi?=
 =?us-ascii?q?+i4LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHXm?=
 =?us-ascii?q?dKQNpfWDJdDYO9d4sPDvQOPeBEr4nmulACqQKyCRSwCO/zzzNFgHH53bc+0+?=
 =?us-ascii?q?88Dw/I2gIuFM8KvHjNotj4MKIeXOaox6fK0DrDdetb1yrj5ojGch4vov+CUr?=
 =?us-ascii?q?x/fsXT1UYhGBjIjkmSpIH/Iz+ZyuoAvmqd4uF9VeyvkWknqwRprzityMYjlp?=
 =?us-ascii?q?PGhpgJylza6C50x4Q1JNOkR0Fhe96kDIVcujqGN4p2XswiQ2ZotDw8yr0do5?=
 =?us-ascii?q?G3ZicKyJM5xxPGbfGMbouG4gr7WeqMLjp1i2hpdbKiixqo70StxfPwWtOp3F?=
 =?us-ascii?q?tMsyFLiMPDtmoX2BzW8sWHT/x98Vq/1juXzADT7/1EIVgzlarGN54t2r4wmY?=
 =?us-ascii?q?QXsUTEBiL2hF/5jLWXdkU54eik8fjnY7X6qZ+cMI94kAf+Pbg1msOjG+g4Nw?=
 =?us-ascii?q?kOX2yD9eS90r3s41H5Ta1XgvA5naTVqpDXKdkBqqKnDAJZzJwv5wunAzejyt?=
 =?us-ascii?q?sYnH0HLFxfeBKAiojkI1POIf7kAvilmVSsjClnyuvaPrzhHprNLn/DnK3nfb?=
 =?us-ascii?q?Zm8UFQ0gUzzddB555MELEOPOrzWlPttNzfFhI5NAm0w+H8CNV7zIwRRXyAD7?=
 =?us-ascii?q?SDMKzMrFCI5vggI/WWaIAJvzb9LuAv5+Tygn8hhV8dYa6p0IMRaHC5AvtmJE?=
 =?us-ascii?q?GZbmD3gtsbEGcKuQ0+TPfxiFCZVD5eaHmzU7g75jEhB4KsFZ3DSZy1gLydwC?=
 =?us-ascii?q?e7GYVbZntYBVCIEHfocZiEWvgXZSKMLc9ujCYEWaKiS4A/zxGushH1y759Iu?=
 =?us-ascii?q?rT4C0YusGr6N8gwOvfjxwwvRlzFMKU2GyOBzVzm2QTQTY90YhlrEB9w0vF2q?=
 =?us-ascii?q?991bgQM91Y4PdASU8bMpnH1KQuDdH5XQbIZZGIT1G9Wf2jXSF3Scg+lYwgeU?=
 =?us-ascii?q?F4Tte9hRnZw3DiV70KnLWRGMYc7rPX33+3Id10jXnByv9y3BEdXsJTODj+1e?=
 =?us-ascii?q?ZE/A/JCtuMyh7Img=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DEAAD7n39d/wHyM5BmHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?W0qgUAyKoQhkHAlmxoJAQEBAQEBAQEBNAECAQGCEoItAoJvIzcGDgIMAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFOoI6KQGCZwEFIxVBEAsJBQoCAiYCAlcGAQwGAgEBgl8/g?=
 =?us-ascii?q?gusRYEyhUyDN4FJgQwoAYt3gVdAgREnDIJfPodPglgEgS8Biy2JFIEylUcGg?=
 =?us-ascii?q?iaUegYbmRmOCZsSIoFYKwpBgWiBToJ6jikkAzCBBgEBj24BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Sep 2019 14:46:24 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8GEkNHF011040;
        Mon, 16 Sep 2019 10:46:23 -0400
Subject: Re: [Non-DoD Source] Re: [PATCH v2 1/1] libsepol: do not dereference
 a failed allocated pointer
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20190915191039.107622-1-nicolas.iooss@m4x.org>
 <CAFqZXNvZnTToFGBYXpk1X=4-N986ALTVUXvSJmvYyxNhvigLGQ@mail.gmail.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <89015ef1-e12c-eb6a-2856-0b74a15dc81b@tycho.nsa.gov>
Date:   Mon, 16 Sep 2019 10:48:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNvZnTToFGBYXpk1X=4-N986ALTVUXvSJmvYyxNhvigLGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/16/19 8:32 AM, Ondrej Mosnacek wrote:
> On Sun, Sep 15, 2019 at 9:11 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>>
>> When strs_stack_init(&stack) fails to allocate memory and stack is still
>> NULL, it should not be dereferenced with strs_stack_pop(stack).
>>
>> This issue has been found using Infer static analyzer.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> ---
>>   libsepol/src/kernel_to_cil.c  | 16 ++++++++++------
>>   libsepol/src/kernel_to_conf.c | 16 ++++++++++------
>>   2 files changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
>> index 01f5bc5bba75..ca2e4a9b265b 100644
>> --- a/libsepol/src/kernel_to_cil.c
>> +++ b/libsepol/src/kernel_to_cil.c
>> @@ -108,10 +108,12 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
>>          return str;
>>
>>   exit:
>> -       while ((new_val = strs_stack_pop(stack)) != NULL) {
>> -               free(new_val);
>> +       if (stack) {
>> +               while ((new_val = strs_stack_pop(stack)) != NULL) {
>> +                       free(new_val);
>> +               }
>> +               strs_stack_destroy(&stack);
>>          }
>> -       strs_stack_destroy(&stack);
>>
>>          return NULL;
> 
> Why not just replace the 'goto exit;' in the 'rc != 0' branch just
> after strs_stack_init() with a plain 'return NULL;'?  From my quick
> look into the code it seems this would be enough to fix the issue, but
> maybe I'm missing something.
> 

That would work, but I think I like this better. It clearly will prevent a 
problem if some future change makes it possible for stack to be NULL in some 
other way.

Jim

>>   }
>> @@ -251,10 +253,12 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
>>          return str;
>>
>>   exit:
>> -       while ((new_val = strs_stack_pop(stack)) != NULL) {
>> -               free(new_val);
>> +       if (stack) {
>> +               while ((new_val = strs_stack_pop(stack)) != NULL) {
>> +                       free(new_val);
>> +               }
>> +               strs_stack_destroy(&stack);
>>          }
>> -       strs_stack_destroy(&stack);
>>
>>          return NULL;
>>   }
>> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
>> index a44ba30a0a44..b49661625e03 100644
>> --- a/libsepol/src/kernel_to_conf.c
>> +++ b/libsepol/src/kernel_to_conf.c
>> @@ -106,10 +106,12 @@ static char *cond_expr_to_str(struct policydb *pdb, struct cond_expr *expr)
>>          return str;
>>
>>   exit:
>> -       while ((new_val = strs_stack_pop(stack)) != NULL) {
>> -               free(new_val);
>> +       if (stack) {
>> +               while ((new_val = strs_stack_pop(stack)) != NULL) {
>> +                       free(new_val);
>> +               }
>> +               strs_stack_destroy(&stack);
>>          }
>> -       strs_stack_destroy(&stack);
>>
>>          return NULL;
>>   }
>> @@ -247,10 +249,12 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
>>          return str;
>>
>>   exit:
>> -       while ((new_val = strs_stack_pop(stack)) != NULL) {
>> -               free(new_val);
>> +       if (stack) {
>> +               while ((new_val = strs_stack_pop(stack)) != NULL) {
>> +                       free(new_val);
>> +               }
>> +               strs_stack_destroy(&stack);
>>          }
>> -       strs_stack_destroy(&stack);
>>
>>          return NULL;
>>   }
>> --
>> 2.22.0
>>
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
