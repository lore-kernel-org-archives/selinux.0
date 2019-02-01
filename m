Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DE2C282DA
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 18:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA32520844
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 18:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="A6DNhSwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfBAS26 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:28:58 -0500
Received: from uphb19pa12.eemsg.mail.mil ([214.24.26.86]:63235 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbfBAS26 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Feb 2019 13:28:58 -0500
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Feb 2019 13:28:58 EST
X-EEMSG-check-017: 179224437|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Feb 2019 18:19:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1549045167; x=1580581167;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ruY6MboQAFfzIgoIu6ZlbKBehd3Zxk8CurRoTm0aKzo=;
  b=A6DNhSwjI+oJc7gvO5sR1WHQaDjwXbkWBMO04TTtnr9Xa6pbIosvU2lV
   DZTCbXi+FrDbIiTvM675P1OjsbcKFvjQeBctdM1mnZcHyOnG0eHfj5may
   B1LIAKe7ia21sDsuReQ+F5H1x5NoXyU8kiXA2A521Df+W4sY9Hrtp/PEz
   /dyAyvyvst3DES+hUB3PdwBrIZqc1TVCSSYCYw6iia37ouwF88HPCAUfE
   VRtz1oCi2lVYG/UiB+6vDiSnvS6vtnm3Zidv4jgQDNS40lQ+uoDX6fmKC
   aD6MG3jttVzvfiBRKq5JK87mTmu7JQ9Kk85sH5spqH/Efmm7aoh5v4Rqm
   g==;
X-IronPort-AV: E=Sophos;i="5.56,549,1539648000"; 
   d="scan'208";a="23401086"
IronPort-PHdr: =?us-ascii?q?9a23=3AFbrKohd95uWFsI1HZO7TWONhlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW+YB7h7PlgxGXEQZ/co6odzbaO4+a4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahYr5+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYNI/pUo4z7qlATrxWxGBOsCfvyxDFWiH/43a403e?=
 =?us-ascii?q?ovHg7J3gMvA90AvW/IrNj3LqoeTfy5wafKwDjFcvhY2S396I/Nch05o/GNU6?=
 =?us-ascii?q?5/ftDLyUkzCQ/Ok1KdqY7rPjyJzOsNqXSb4/R7WOKzi28otwFxoj+1yscqkY?=
 =?us-ascii?q?nGnJgZyl/D9SVn2Ys4I8CzRk1jYdO8DZdduC6XO5F2T88/WW1kpik3xqMctZ?=
 =?us-ascii?q?KmeiUB1Y4pyATFa/OddoiF+hfjVOGMLjhmnH9lY7e/hwqq8Uin1+38StG40F?=
 =?us-ascii?q?ZUoSpBldnBrmwN2AbJ6siGV/t95V2t2SqP1g/P6uFEJlo4lazHJJ463rE8jJ?=
 =?us-ascii?q?8TsUXHHiPumUX2irGZdlk89+S15Onqba/qq5+BO4NulA3zPboiltaiDeggNw?=
 =?us-ascii?q?gBRWmb+eCy1L35+k35Ra1Hjv84k6bFqp/aP9gbqrCiDg9J0ocs9xa/DzC83N?=
 =?us-ascii?q?QehnkINkhJeB2Aj4j3I13OOuz3De+jg1Swlzdm3/bGPrz9DZXKKnjMiqzhca?=
 =?us-ascii?q?x8605bzwoz1stf6olRCrwOL/P/QEjxtMbXDhUhKQy73/7nCMlh1oMZQW+PGq?=
 =?us-ascii?q?uZP7nPsV+U/OIgOPODaZQPuDnjNvcl5+ThjWMjlVABeqmp2IMdaGqkEfR+P0?=
 =?us-ascii?q?WZfX3sj88aEWgUugo+TerqiECNUDNIeXayULwz5ishBIKlE4jDXIatj6KF3C?=
 =?us-ascii?q?uhGZ1WfG9GWRiwFiLOdo6DX/4XIAOVJdR62mgCVLOmT4Y6kxCpsxTh4787Pq?=
 =?us-ascii?q?zT4CJO8drb2cRvr8naiA0o/zV/D4zJy2WEUn1ulGogXTI63Klj50d6zwHQ/7?=
 =?us-ascii?q?J/hqlaCtda/e8TGlM4KpXV1fAgI8zjUQLGONGSQRCpRcvwUmJ5dc4439JbOx?=
 =?us-ascii?q?U1IN6llB2WmnPwW7I=3D?=
X-IPAS-Result: =?us-ascii?q?A2ANAABojFRc/wHyM5BkGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYFaKYE3ATInhAOIGotzgWAtmA4UgWc4AYRAAoMRIjQJDQEDAQEBAQEBA?=
 =?us-ascii?q?gFsKII6KQGCZgEBAQECASMEEUEFCwsJDwICJgICVwYBDAYCAQGCXz+BegipU?=
 =?us-ascii?q?nwzhUOEcIELizWBVkCBESeCa4RpgyGCVwKBLAGPRDqRPAYDkjAGGZJALYMDh?=
 =?us-ascii?q?nCTITiBVisKQYFogU6CUo4pIQMwgQUBAYwRAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 01 Feb 2019 18:19:26 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions.infosec.tycho.ncsc.mil [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x11IJN3j000984;
        Fri, 1 Feb 2019 13:19:23 -0500
Subject: Re: [Non-DoD Source] Re: [PATCH 1/3] libsepol: Fix RESOURCE_LEAK
 defects reported by coverity scan
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
References: <20190131132226.19030-1-plautrba@redhat.com>
 <CAJfZ7=mK=okzh1S8_1h6_TPRMTXEUQyHUccTf-Uai=Az8SDRQg@mail.gmail.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <28fe4f11-54ad-830c-ea95-2656b1e5569d@tycho.nsa.gov>
Date:   Fri, 1 Feb 2019 13:19:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=mK=okzh1S8_1h6_TPRMTXEUQyHUccTf-Uai=Az8SDRQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/31/19 4:17 PM, Nicolas Iooss wrote:
> On Thu, Jan 31, 2019 at 2:22 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>   libsepol/cil/src/cil_binary.c      | 12 ++++++++++++
>>   libsepol/cil/src/cil_resolve_ast.c | 10 ++++++++++
>>   libsepol/cil/src/cil_symtab.c      |  1 +
>>   libsepol/src/expand.c              |  3 +++
>>   libsepol/src/kernel_to_cil.c       |  2 ++
>>   libsepol/src/kernel_to_conf.c      |  2 ++
>>   6 files changed, 30 insertions(+)
>>
>> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
>> index 0cc6eeb1..a645c95d 100644
>> --- a/libsepol/cil/src/cil_binary.c
>> +++ b/libsepol/cil/src/cil_binary.c
>> @@ -912,6 +912,8 @@ int cil_sensalias_to_policydb(policydb_t *pdb, struct cil_alias *cil_alias)
>>          key = cil_strdup(cil_alias->datum.fqn);
>>          rc = symtab_insert(pdb, SYM_LEVELS, key, sepol_alias, SCOPE_DECL, 0, NULL);
>>          if (rc != SEPOL_OK) {
>> +               if (rc == 1)
>> +                       free(sepol_alias);
>>                  goto exit;
>>          }
> 
> There is something weird here. The exit label starts with
> "level_datum_destroy(sepol_alias);". This is not a serious issue
> because level_datum_destroy() does not do anything, but after this
> patch, cil_sensalias_to_policydb()'s code seems to use sepol_alias
> after freeing it.
> 
> Should the call to level_datum_destroy(sepol_alias) be removed, or
> moved before free(sepol_alias)?
> 

The real problem is the statement after the "level_datum_destroy(sepol_alias);".
The "free(sepol_level);" should be "free(sepol_alias);".
The sepol_level references a datum passed back by hashtab_search() in 
__cil_get_sepol_class_datum() and is not a new object.

Jim

> Thanks,
> Nicolas
> 
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
