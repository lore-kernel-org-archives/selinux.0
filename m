Return-Path: <SRS0=obw9=P5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40EFC7112F
	for <selinux@archiver.kernel.org>; Mon, 21 Jan 2019 12:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDBB20879
	for <selinux@archiver.kernel.org>; Mon, 21 Jan 2019 12:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfAUMPM convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:15:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbfAUMPM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 21 Jan 2019 07:15:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C8BC934CC;
        Mon, 21 Jan 2019 12:15:11 +0000 (UTC)
Received: from workstation (unknown [10.43.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFD8817AEC;
        Mon, 21 Jan 2019 12:15:10 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux/audit2why.so: Filter out non-python related symbols
References: <353f9889-d43c-9a14-4605-5ba1eac22284@tycho.nsa.gov>
        <20190115133629.21263-1-plautrba@redhat.com>
        <e6e56640-b2f6-abca-5c1b-4f192b6c8d7e@tycho.nsa.gov>
        <cdb56541-46e1-9d6c-ae89-a947b5cc4310@tycho.nsa.gov>
Date:   Mon, 21 Jan 2019 13:15:09 +0100
In-Reply-To: <cdb56541-46e1-9d6c-ae89-a947b5cc4310@tycho.nsa.gov> (Stephen
        Smalley's message of "Thu, 17 Jan 2019 09:33:20 -0500")
Message-ID: <pjdmunudx6a.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 21 Jan 2019 12:15:11 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 1/17/19 9:18 AM, Stephen Smalley wrote:
>> On 1/15/19 8:36 AM, Petr Lautrbach wrote:
>>> audit2why.so used to export libsepol.a symbols. We only need Python related
>>> symbols:
>>>
>>> - initaudit2why for python 2
>>> - PyInit_audit2why for python3
>>>
>>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>>
>> I submitted a pull request to trigger Travis CI of this change here:
>> https://github.com/SELinuxProject/selinux/pull/130
>
> Hmm...broke the build when using PYVER=pypy3.5.

This is fixed by the latest patches sent by Nicolas:

https://github.com/bachradsusi/SELinuxProject-selinux/commits/audit2why.so-with-travis-fixes
https://travis-ci.org/bachradsusi/SELinuxProject-selinux/builds/482366289


> python-3.5audit2why.lo: In function `PyInit_audit2why':
> audit2why.c:(.text+0xe): undefined reference to `PyPyModule_Create2'
> audit2why.c:(.text+0x30): undefined reference to `PyPyModule_AddIntConstant'
> audit2why.c:(.text+0x46): undefined reference to `PyPyModule_AddIntConstant'
> audit2why.c:(.text+0x5c): undefined reference to `PyPyModule_AddIntConstant'
> audit2why.c:(.text+0x72): undefined reference to `PyPyModule_AddIntConstant'
> audit2why.c:(.text+0x88): undefined reference to `PyPyModule_AddIntConstant'
> python-3.5audit2why.lo:audit2why.c:(.text+0x9e): more undefined references to
> `PyPyModule_AddIntConstant' follow
> python-3.5audit2why.lo: In function `init':
> audit2why.c:(.text+0x170): undefined reference to `PyPyExc_RuntimeError'
> audit2why.c:(.text+0x17f): undefined reference to `PyPyErr_SetString'
> audit2why.c:(.text+0x1a1): undefined reference to `PyPyArg_ParseTuple'
> audit2why.c:(.text+0x2c0): undefined reference to `PyPyExc_RuntimeError'
> audit2why.c:(.text+0x2cf): undefined reference to `PyPyExc_MemoryError'
> audit2why.c:(.text+0x2de): undefined reference to `PyPyErr_SetString'
> audit2why.c:(.text+0x329): undefined reference to `PyPyExc_ValueError'
> audit2why.c:(.text+0x367): undefined reference to `PyPyExc_ValueError'
> audit2why.c:(.text+0x372): undefined reference to `PyPyErr_SetString'
> audit2why.c:(.text+0x387): undefined reference to `PyPy_BuildValue'
> audit2why.c:(.text+0x3e6): undefined reference to `PyPyExc_ValueError'
> audit2why.c:(.text+0x49a): undefined reference to `PyPyExc_RuntimeError'
> audit2why.c:(.text+0x4b0): undefined reference to `PyPyExc_MemoryError'
> audit2why.c:(.text+0x4c6): undefined reference to `PyPyExc_RuntimeError'
> audit2why.c:(.text+0x4d5): undefined reference to `PyPyErr_SetString'
> python-3.5audit2why.lo: In function `analyze':
> audit2why.c:(.text+0x51d): undefined reference to `PyPyList_Type'
> audit2why.c:(.text+0x53d): undefined reference to `PyPyArg_ParseTuple'
> audit2why.c:(.text+0x553): undefined reference to `PyPyList_Size'
> audit2why.c:(.text+0x5f9): undefined reference to `PyPyList_GetItem'
> audit2why.c:(.text+0x601): undefined reference to `PyPyUnicode_AsUTF8'
> audit2why.c:(.text+0x63f): undefined reference to `_PyPy_NoneStruct'
> audit2why.c:(.text+0x657): undefined reference to `_PyPy_NoneStruct'
> audit2why.c:(.text+0x66f): undefined reference to `_PyPy_NoneStruct'
> audit2why.c:(.text+0x687): undefined reference to `_PyPy_NoneStruct'
> audit2why.c:(.text+0x6f5): undefined reference to `_PyPy_NoneStruct'
> python-3.5audit2why.lo:audit2why.c:(.text+0x70a): more undefined references to
> `_PyPy_NoneStruct' follow
> python-3.5audit2why.lo: In function `analyze':
> audit2why.c:(.text+0x728): undefined reference to `PyPy_BuildValue'
> audit2why.c:(.text+0x90b): undefined reference to `PyPyExc_RuntimeError'
> audit2why.c:(.text+0x91a): undefined reference to `PyPyErr_SetString'
> audit2why.c:(.text+0x93c): undefined reference to `PyPy_BuildValue'
> audit2why.c:(.text+0x955): undefined reference to `PyPyExc_MemoryError'
> audit2why.c:(.text+0x964): undefined reference to `PyPyErr_SetString'
> audit2why.c:(.text+0x981): undefined reference to `_PyPy_NoneStruct'
> audit2why.c:(.text+0x9a0): undefined reference to `_PyPy_NoneStruct'
> audit2why.c:(.text+0x9b8): undefined reference to `_PyPy_NoneStruct'
> audit2why.c:(.text+0x9f3): undefined reference to `PyPyExc_RuntimeError'
> audit2why.c:(.text+0x9fe): undefined reference to `PyPyErr_SetString'
> audit2why.c:(.text+0xa3f): undefined reference to `PyPyExc_RuntimeError'
> audit2why.c:(.text+0xa4f): undefined reference to `PyPyErr_SetString'
> audit2why.c:(.text+0xb18): undefined reference to `_PyPy_NoneStruct'
> audit2why.c:(.text+0xb2e): undefined reference to `PyPyList_New'
> audit2why.c:(.text+0xb56): undefined reference to `PyPy_BuildValue'
> audit2why.c:(.text+0xb68): undefined reference to `PyPyList_SetItem'
> python-3.5audit2why.lo: In function `finish':
> audit2why.c:(.text+0xbb3): undefined reference to `PyPyArg_ParseTuple'
> audit2why.c:(.text+0xc7d): undefined reference to `_PyPy_NoneStruct'
> clang-7: error: linker command failed with exit code 1 (use -v to see
> invocation)
> Makefile:168: recipe for target 'python-3.5audit2why.so' failed
>
>>
>>> ---
>>>   libselinux/src/Makefile      | 2 +-
>>>   libselinux/src/audit2why.map | 6 ++++++
>>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>>   create mode 100644 libselinux/src/audit2why.map
>>>
>>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
>>> index 8891086e..92e30738 100644
>>> --- a/libselinux/src/Makefile
>>> +++ b/libselinux/src/Makefile
>>> @@ -165,7 +165,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
>>>       $(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@
>>> $<
>>>   $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
>>> -    $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux
>>> $(LDLIBS_LIBSEPOLA) $(PYLIBS)
>>> +    $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux
>>> $(LDLIBS_LIBSEPOLA) $(PYLIBS)
>>> -Wl,-soname,audit2why.so,--version-script=audit2why.map,-z,defs
>>>   %.o:  %.c policy.h
>>>       $(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
>>> diff --git a/libselinux/src/audit2why.map b/libselinux/src/audit2why.map
>>> new file mode 100644
>>> index 00000000..65989a8d
>>> --- /dev/null
>>> +++ b/libselinux/src/audit2why.map
>>> @@ -0,0 +1,6 @@
>>> +AUDIT2WHY_2.9 {
>>> +  global:
>>> +    initaudit2why;
>>> +    PyInit_audit2why;
>>> +  local: *;
>>> +};
>>>
>>
