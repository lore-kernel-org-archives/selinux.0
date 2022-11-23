Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702C0C43219
	for <selinux@archiver.kernel.org>; Wed, 23 Nov 2022 18:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbiKWS33 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Nov 2022 13:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiKWS3P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Nov 2022 13:29:15 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ECBD1039
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 10:29:13 -0800 (PST)
Received: from [192.168.1.108] (ip98-168-40-103.ph.ph.cox.net [98.168.40.103])
        by linux.microsoft.com (Postfix) with ESMTPSA id 36B9D20B83C2;
        Wed, 23 Nov 2022 10:29:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36B9D20B83C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669228153;
        bh=NOhNRzNvELFQpRjIRlYlBWwNwS9zlYdoHK6+aufe5aE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MvIPqkJLEw5oDOHnj/6tj/S+ZW2rX6kqwqDzJABIu38wyWvfyZQ2KgdTr0lRu/4Hm
         MdGnbW1xrgqTKI6TVAR1q3/X9/7Ie+TNaW++w3IU/XrwHQo33NVaRJ/wE4XEC7lw8I
         7hYtbtDjEc3N9cjCJCB1mXUGhbaPcRnG6uPCd01Y=
Message-ID: <efaabcb6-ad95-4123-800c-775651e1d54b@linux.microsoft.com>
Date:   Wed, 23 Nov 2022 11:29:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: secilc genfscon parsing error
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SELinux <selinux@vger.kernel.org>
References: <d11c25c5-727e-342a-162a-e3851ff03d27@linux.microsoft.com>
 <87ilj5h799.fsf@defensec.nl> <87edtth73u.fsf@defensec.nl>
Content-Language: en-US
From:   Matthew Sheets <masheets@linux.microsoft.com>
In-Reply-To: <87edtth73u.fsf@defensec.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 11/23/2022 11:13 AM, Dominick Grift wrote:
> Dominick Grift <dominick.grift@defensec.nl> writes:
> 
> Whoops that was wrong (not sure why that worked), this should be ok
> (still works):
> 
> root@brutus:~# cat > mytest.cil <<EOF
> 
> (block foo (blockinherit .sysfile.base_template) (genfscon sysfs "/foo" file sysfile_context))
>     
> EOF
> root@brutus:~# semodule -i mytest.cil
> root@brutus:~# seinfo --genfscon | grep foo
>     genfscon sysfs /foo -- sys.id:sys.role:foo.sysfile:s0
> root@brutus:~#
> 
>> Matthew Sheets <masheets@linux.microsoft.com> writes:
>>
>>> Hi,
>>>
>>> I am seeing a parsing error from secilc when trying to compile the
>>> following line:
>>> (genfscon sysfs "/zap" file (system_u object_r foo ((s0) (s0))))
>>
>> Works fine here (unless i am overlooking something:
>>
>> root@brutus:~# cat > mytest.cil <<EOF
>>> (blockinherit .sysfile.base_template)
>>> EOF
>> root@brutus:~# cat > mytest.cil <<EOF
>>> (block foo (blockinherit .sysfile.base_template) (genfscon "/foo" file sysfile_context))
>>> EOF
>> root@brutus:~# semodule -i mytest.cil
>> root@brutus:~# echo $?
>> 0
>> root@brutus:~# seinfo --genfscon | grep foo
>>     genfscon /foo file  sys.id:sys.role:foo.sysfile:s0
>> root@brutus:~#
>>
>>>
>>> But according to the documentation here:
>>> https://github.com/SELinuxProject/selinux/blob/master/secilc/docs/cil_file_labeling_statements.md#genfscon
>>> I believe this should be a valid line.
>>>
>>> The compiler error given is:
>>> Invalid syntax
>>> Bad genfscon declaration at out.cil:129
>>> Failed to build AST
>>> Failed to compile cildb: -1
>>>
>>> If I remove the file keyword everything compiles correctly.
>>>
>>> Other interesting points of data:
>>>
>>> In ref policy there is the following line in selinux.te
>>> genfscon selinuxfs /booleans/ -- gen_context(system_u:object_r:boolean_t,s0)
>>>
>>> When compiling this to cil with checkpolicy the following line is produced:
>>> (genfscon selinuxfs "/booleans/" (system_u object_r boolean_t
>>> (systemlow systemlow)))
>>> Which has no reference to the optional file_type field.
>>>
> 

I figured it out.  I had two versions of libsepol.so and was linking to 
the older one.  Thanks for the help.
