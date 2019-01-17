Return-Path: <SRS0=ZoZM=PZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B07C43387
	for <selinux@archiver.kernel.org>; Thu, 17 Jan 2019 14:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FD220859
	for <selinux@archiver.kernel.org>; Thu, 17 Jan 2019 14:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="U9tttZgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfAQObZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:31:25 -0500
Received: from upbd19pa11.eemsg.mail.mil ([214.24.27.86]:57753 "EHLO
        upbd19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQObZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Jan 2019 09:31:25 -0500
X-EEMSG-check-017: 182824303|UPBD19PA11_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Jan 2019 14:31:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547735480; x=1579271480;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=dUukYABOyMHZamInxRETT/pe3RnhjfD9wKtWWyOYDS0=;
  b=U9tttZgF1N1tFi0EhG1+mNHIqjx2zcp4OGhS4MP7PtYKzYHSuZSN8wvx
   6cDxdD83hdp8yp59DFX5iMPDuXBmY7mtCslHAqV13kyVHEzMHv9iMP4gy
   KTtM1ivnA/0VunlwDhnzq7YbQqYi5LTtqu9jp1OOJoYUcLja515EKJwLt
   +ke/ufykKMzhEScqTFH6gm+hJUyo4OYN66TIAaISwld51URz/aEEfavES
   ODM0v4PzaEC+esNF9jE3kIujRpjvDXx9Paxv4ddxfUgBtoMZhPE7fNedu
   Ms3I3l4KwxcE7kGP/kVKZev6GG6PTcb41Y2lUnZkrFxkQc3rh/BQNVULZ
   A==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539648000"; 
   d="scan'208";a="19618045"
IronPort-PHdr: =?us-ascii?q?9a23=3AopGmuBV8PFplJhLG6JiWQWB/u3/V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRCFt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KpwVhTmlDkIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94VS3?=
 =?us-ascii?q?BBXsJMXCJfBI2yYZYEA+4YMepFs4Xxol0Dpga8CwaxHuPi0iJGiH/o06000O?=
 =?us-ascii?q?ovHw/J0wMiEN0Sv3rZt8n1OaQIXOyp0KXFwzfOYvVL0jn98ojIdRUhrOmRU7?=
 =?us-ascii?q?Jsb8XR0UkvGB3Djl6NtILlOima1uAJs2eF7+trSOWii3U6pAFquTWv2scthZ?=
 =?us-ascii?q?XJhoIS0FzE8z55z5wvKd23T057f8epHZ1NvC+UMIt2R9ktQ2BuuCsiyrAJo4?=
 =?us-ascii?q?O7czULyJQ72RLeZfyHcoiS7hL4U+adOTh4hHN5eLK/mha96lKsxfH7Vsmx1l?=
 =?us-ascii?q?tBsylLksHUu3wQ2BHe5dKLR/tg8ku7xzqC2B7f5vtZLU0yiKHVMYQuwqQqmZ?=
 =?us-ascii?q?oWqUnDGyj2l1jog6KObUUk//So6/zgYrX7up+QL490hR/6MqQpgsG/Hf43Mh?=
 =?us-ascii?q?IPX2iG4uSwzqHj/E3lT7VKif06iK/Zv4zBJcsHvKK5Bg5V0oI75xa+CTepzs?=
 =?us-ascii?q?gYkGEaIF9Kdx+LlYjkN0zULPzmAvqznU6gnCpzy/DDJLLhA5HNLnbZkLfmeL?=
 =?us-ascii?q?Zw81Vcxxcozd1E+5JVCq0OIPL0WkPrstzYFQU2Pxa7w+bgFtVxzpkeVn6XAq?=
 =?us-ascii?q?+FLKPStkeF5vorI+aWeY8VpCz9JOM/6PP1l382h0ISfamz0psLcny3AvNmI0?=
 =?us-ascii?q?CBa3r2ntgBCXsKvhY5TOHyk12NTzpTZ3e0X6Ih6TA2E5ymDYjdSYC3mrCB3z?=
 =?us-ascii?q?m0HodQZm9YDlCAC3Dod5+LW6REVCXHGsJ9iHQgXKW9UYUo3hHm4Bf+wqd7NO?=
 =?us-ascii?q?Dd0jcVuZLqyJ5+4OiF0Vkp+Dh1CdmN+3+CQnsynW4SQTIymqdlrh9T0FCGhJ?=
 =?us-ascii?q?NkjuRYGNob3PZAVgM3JNaI1OBhI8zjUQLGONGSQRCpRcvwUmJ5dc4439JbOx?=
 =?us-ascii?q?U1IN6llB2WmnPzW7I=3D?=
X-IPAS-Result: =?us-ascii?q?A2BGAACikEBc/wHyM5BjHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?VopZk8zJ4QBk3xMAQEBAQEBBoE1iTCOToF7MAgBhEACglYiNgcNAQMBAQEBA?=
 =?us-ascii?q?QECAWwcDII6KQGCZwEFIw8BBVEJAg4KAgImAgJXBgEMBgIBAYJfPwGBdA0Pj?=
 =?us-ascii?q?y+bYYEvhC4BhgSBC4s0F3iBB4E4gjY1gx4CgSqDQIJXAolWhy5UkDgJhyKKa?=
 =?us-ascii?q?wYYgjKPWYoAhRiNQgExgVYrCAIYCCEPgycJhgCGcYQAIQMwgQUBAYdfgk0BA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Jan 2019 14:31:19 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0HEVJMT017432;
        Thu, 17 Jan 2019 09:31:19 -0500
Subject: Re: [PATCH] libselinux/audit2why.so: Filter out non-python related
 symbols
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <353f9889-d43c-9a14-4605-5ba1eac22284@tycho.nsa.gov>
 <20190115133629.21263-1-plautrba@redhat.com>
 <e6e56640-b2f6-abca-5c1b-4f192b6c8d7e@tycho.nsa.gov>
Message-ID: <cdb56541-46e1-9d6c-ae89-a947b5cc4310@tycho.nsa.gov>
Date:   Thu, 17 Jan 2019 09:33:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e6e56640-b2f6-abca-5c1b-4f192b6c8d7e@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/17/19 9:18 AM, Stephen Smalley wrote:
> On 1/15/19 8:36 AM, Petr Lautrbach wrote:
>> audit2why.so used to export libsepol.a symbols. We only need Python 
>> related
>> symbols:
>>
>> - initaudit2why for python 2
>> - PyInit_audit2why for python3
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> 
> I submitted a pull request to trigger Travis CI of this change here:
> https://github.com/SELinuxProject/selinux/pull/130

Hmm...broke the build when using PYVER=pypy3.5.

python-3.5audit2why.lo: In function `PyInit_audit2why':
audit2why.c:(.text+0xe): undefined reference to `PyPyModule_Create2'
audit2why.c:(.text+0x30): undefined reference to `PyPyModule_AddIntConstant'
audit2why.c:(.text+0x46): undefined reference to `PyPyModule_AddIntConstant'
audit2why.c:(.text+0x5c): undefined reference to `PyPyModule_AddIntConstant'
audit2why.c:(.text+0x72): undefined reference to `PyPyModule_AddIntConstant'
audit2why.c:(.text+0x88): undefined reference to `PyPyModule_AddIntConstant'
python-3.5audit2why.lo:audit2why.c:(.text+0x9e): more undefined 
references to `PyPyModule_AddIntConstant' follow
python-3.5audit2why.lo: In function `init':
audit2why.c:(.text+0x170): undefined reference to `PyPyExc_RuntimeError'
audit2why.c:(.text+0x17f): undefined reference to `PyPyErr_SetString'
audit2why.c:(.text+0x1a1): undefined reference to `PyPyArg_ParseTuple'
audit2why.c:(.text+0x2c0): undefined reference to `PyPyExc_RuntimeError'
audit2why.c:(.text+0x2cf): undefined reference to `PyPyExc_MemoryError'
audit2why.c:(.text+0x2de): undefined reference to `PyPyErr_SetString'
audit2why.c:(.text+0x329): undefined reference to `PyPyExc_ValueError'
audit2why.c:(.text+0x367): undefined reference to `PyPyExc_ValueError'
audit2why.c:(.text+0x372): undefined reference to `PyPyErr_SetString'
audit2why.c:(.text+0x387): undefined reference to `PyPy_BuildValue'
audit2why.c:(.text+0x3e6): undefined reference to `PyPyExc_ValueError'
audit2why.c:(.text+0x49a): undefined reference to `PyPyExc_RuntimeError'
audit2why.c:(.text+0x4b0): undefined reference to `PyPyExc_MemoryError'
audit2why.c:(.text+0x4c6): undefined reference to `PyPyExc_RuntimeError'
audit2why.c:(.text+0x4d5): undefined reference to `PyPyErr_SetString'
python-3.5audit2why.lo: In function `analyze':
audit2why.c:(.text+0x51d): undefined reference to `PyPyList_Type'
audit2why.c:(.text+0x53d): undefined reference to `PyPyArg_ParseTuple'
audit2why.c:(.text+0x553): undefined reference to `PyPyList_Size'
audit2why.c:(.text+0x5f9): undefined reference to `PyPyList_GetItem'
audit2why.c:(.text+0x601): undefined reference to `PyPyUnicode_AsUTF8'
audit2why.c:(.text+0x63f): undefined reference to `_PyPy_NoneStruct'
audit2why.c:(.text+0x657): undefined reference to `_PyPy_NoneStruct'
audit2why.c:(.text+0x66f): undefined reference to `_PyPy_NoneStruct'
audit2why.c:(.text+0x687): undefined reference to `_PyPy_NoneStruct'
audit2why.c:(.text+0x6f5): undefined reference to `_PyPy_NoneStruct'
python-3.5audit2why.lo:audit2why.c:(.text+0x70a): more undefined 
references to `_PyPy_NoneStruct' follow
python-3.5audit2why.lo: In function `analyze':
audit2why.c:(.text+0x728): undefined reference to `PyPy_BuildValue'
audit2why.c:(.text+0x90b): undefined reference to `PyPyExc_RuntimeError'
audit2why.c:(.text+0x91a): undefined reference to `PyPyErr_SetString'
audit2why.c:(.text+0x93c): undefined reference to `PyPy_BuildValue'
audit2why.c:(.text+0x955): undefined reference to `PyPyExc_MemoryError'
audit2why.c:(.text+0x964): undefined reference to `PyPyErr_SetString'
audit2why.c:(.text+0x981): undefined reference to `_PyPy_NoneStruct'
audit2why.c:(.text+0x9a0): undefined reference to `_PyPy_NoneStruct'
audit2why.c:(.text+0x9b8): undefined reference to `_PyPy_NoneStruct'
audit2why.c:(.text+0x9f3): undefined reference to `PyPyExc_RuntimeError'
audit2why.c:(.text+0x9fe): undefined reference to `PyPyErr_SetString'
audit2why.c:(.text+0xa3f): undefined reference to `PyPyExc_RuntimeError'
audit2why.c:(.text+0xa4f): undefined reference to `PyPyErr_SetString'
audit2why.c:(.text+0xb18): undefined reference to `_PyPy_NoneStruct'
audit2why.c:(.text+0xb2e): undefined reference to `PyPyList_New'
audit2why.c:(.text+0xb56): undefined reference to `PyPy_BuildValue'
audit2why.c:(.text+0xb68): undefined reference to `PyPyList_SetItem'
python-3.5audit2why.lo: In function `finish':
audit2why.c:(.text+0xbb3): undefined reference to `PyPyArg_ParseTuple'
audit2why.c:(.text+0xc7d): undefined reference to `_PyPy_NoneStruct'
clang-7: error: linker command failed with exit code 1 (use -v to see 
invocation)
Makefile:168: recipe for target 'python-3.5audit2why.so' failed

> 
>> ---
>>   libselinux/src/Makefile      | 2 +-
>>   libselinux/src/audit2why.map | 6 ++++++
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>   create mode 100644 libselinux/src/audit2why.map
>>
>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
>> index 8891086e..92e30738 100644
>> --- a/libselinux/src/Makefile
>> +++ b/libselinux/src/Makefile
>> @@ -165,7 +165,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
>>       $(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED 
>> -c -o $@ $<
>>   $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
>> -    $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux 
>> $(LDLIBS_LIBSEPOLA) $(PYLIBS)
>> +    $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux 
>> $(LDLIBS_LIBSEPOLA) $(PYLIBS) 
>> -Wl,-soname,audit2why.so,--version-script=audit2why.map,-z,defs
>>   %.o:  %.c policy.h
>>       $(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
>> diff --git a/libselinux/src/audit2why.map b/libselinux/src/audit2why.map
>> new file mode 100644
>> index 00000000..65989a8d
>> --- /dev/null
>> +++ b/libselinux/src/audit2why.map
>> @@ -0,0 +1,6 @@
>> +AUDIT2WHY_2.9 {
>> +  global:
>> +    initaudit2why;
>> +    PyInit_audit2why;
>> +  local: *;
>> +};
>>
> 

