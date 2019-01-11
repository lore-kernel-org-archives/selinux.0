Return-Path: <SRS0=yrd7=PT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97D7C43387
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 12:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCBE20870
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 12:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfAKMY4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:24:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfAKMY4 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 11 Jan 2019 07:24:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1376C00C0F8;
        Fri, 11 Jan 2019 12:24:55 +0000 (UTC)
Received: from workstation (unknown [10.43.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE90D601A3;
        Fri, 11 Jan 2019 12:24:54 +0000 (UTC)
References: <pjdmuo8fl9s.fsf@redhat.com> <391a8f7b-b8b0-32a4-29ff-f85eccec0712@tycho.nsa.gov>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SELinux <selinux@vger.kernel.org>
Subject: Re: RFC: introduce new library versions for added symbols
In-reply-to: <391a8f7b-b8b0-32a4-29ff-f85eccec0712@tycho.nsa.gov>
Date:   Fri, 11 Jan 2019 13:24:53 +0100
Message-ID: <pjdlg3rfkkq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 11 Jan 2019 12:24:55 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 1/10/19 12:57 PM, Petr Lautrbach wrote:
>> I used abi-compliance-checker [1] and compared the latest 
>> sources with 2.8
>> release [2].
>> It looks like there's one symbol added to audit2why.so.
>
> audit2why.so needs a .map file or equivalent; it shouldn't be 
> exporting all of
> the libsepol.a symbols.  We don't guarantee ABI or API 
> compatibility for
> anything not in libsepol.map.
>

I'll prepare a patch for that.

>>
>> Then I tried the same thing with 2.7 [3] and 2.6 [4] and 
>> noticed that
>> there were added new symbols even to LIBSEMANAGE_1.0 while 
>> since 2.3
>> there's already LIBSEMANAGE_1.1.
>> It's a bug which breaks automatic dependency checking. So I 
>> propose
>> to fix symbol version mappings in order to be in relation with 
>> the
>> release where they was introduced, e.g. for libsemanage:
>>
>> diff --git a/libsemanage/src/libsemanage.map 
>> b/libsemanage/src/libsemanage.map
>> index 02036696..45e90215 100644
>> --- a/libsemanage/src/libsemanage.map
>> +++ b/libsemanage/src/libsemanage.map
>> @@ -18,8 +18,6 @@ LIBSEMANAGE_1.0 {
>>   semanage_root;
>>   semanage_user_*; semanage_bool_*; semanage_seuser_*;
>>   semanage_iface_*; semanage_port_*; semanage_context_*;
>> - semanage_ibpkey_*;
>> - semanage_ibendport_*;
>>   semanage_node_*;
>>   semanage_fcontext_*; semanage_access_check;
>> semanage_set_create_store;
>>   semanage_is_connected; semanage_get_disable_dontaudit;  
>> semanage_set_disable_dontaudit;
>> @@ -63,3 +61,19 @@ LIBSEMANAGE_1.1 {
>>   semanage_module_remove_key;
>>   semanage_set_store_root;
>> } LIBSEMANAGE_1.0;
>> +
>> +LIBSEMANAGE_2.5 {
>> + global:
>> + semanage_module_extract;
>> +} LIBSEMANAGE_1.1;
>> +
>> +LIBSEMANAGE_2.7 {
>> + global:
>> + semanage_ibpkey_*;
>> + semanage_ibendport_*;
>> +} LIBSEMANAGE_2.5;
>> +
>> +LIBSEMANAGE_2.8 {
>> + global:
>> + semanage_fcontext_list_homedirs;
>> +} LIBSEMANAGE_2.7;
>>
>>
>> If this is acceptable, I would prepare a patch with symbol 
>> versions
>> starting with 2.5 as LIBSEMANAGE_1.1 was introduced in 2.4.
>
> Will this break compatibility for binaries built against earlier
> versions?

I was under impression that is should be enough to list symbols in
different versions but it looks like a symbol is assigned only to
one/the latest version.

# semodule -B
semodule: relocation error: /lib64/libsemanage.so.1: symbol 
sepol_ibendport_modify version LIBSEPOL_1.0 not defined in file 
libsepol.so.1 with link time reference

I'm still investigating this but given that there's only one 
reported
change between the latest and 2.8 and it  should be covered by 
audit2why
map file, it probably doesn't make sense to do this change 
retroactively now.

Just for the future we need to keep in mind that new symbols needs 
new versions
in .map files.



>
>>
>> [1] http://lvc.github.io/abi-compliance-checker/
>> [2]
>> https://plautrba.fedorapeople.org/selinux/compat_reports/2.8_to_2.9-rc0/compat_report.html 
>>
>> [3]
>> https://plautrba.fedorapeople.org/selinux/compat_reports/2.7_to_2.9-rc0/compat_report.html 
>>
>> [4]
>> https://plautrba.fedorapeople.org/selinux/compat_reports/2.6_to_2.9-rc0/compat_report.html 
>>
>>
>> Petr

