Return-Path: <SRS0=yrd7=PT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84284C43387
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 15:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA3C20675
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 15:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Zm+EXNd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbfAKP7l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:59:41 -0500
Received: from uphb19pa11.eemsg.mail.mil ([214.24.26.85]:28079 "EHLO
        USFB19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729359AbfAKP7l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Jan 2019 10:59:41 -0500
X-EEMSG-check-017: 110815649|USFB19PA14_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Jan 2019 15:59:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547222379; x=1578758379;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DML1NxfOpuITXFddmteygNx2pJeODe/ZJPRQ8dywCNo=;
  b=Zm+EXNd2ZFFqNTQ3+klBz357vz9LwmkgSF13l/WBZ15GOv/QnEoApF5m
   eRnshI3ZuF/Yd3GkW9kXDQgXmEPohmXnnopG07Zm7k0EHd4pJeCf8u6AP
   hurVKMcSf3dbiwDTePoWYx3LA5irZJL3DDIKi7GmuMn/vsl/Ob+21aHWA
   o3v7j4ubOW3wzXVi0XBedZ89rQWvuO8VCqPux1Nmht7zeLwvWtVSv4J6z
   +0DBYu9RRZ7Mo7VpZWQPol8OeosHAPjPgOoH8Bv4f6OJEYOD/efwtzimW
   QDwQbEH3vYf4yeE7CfhR43F38cK6Uxxh/cJ0cApd+mwHgTtCdMm7eh9Fd
   A==;
X-IronPort-AV: E=Sophos;i="5.56,466,1539648000"; 
   d="scan'208";a="19450391"
IronPort-PHdr: =?us-ascii?q?9a23=3A0FPUQB1d+Ra8AB+3smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMTIvad9pjvdHbS+e9qxAeQG9mDu7Qc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYAhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/1jcKPAZtMaXX?=
 =?us-ascii?q?ROUdpNVyJPBYO8apEAD+sHPe1Fq4XwqF8DoR64CAaiHuPvziJDiGHw06M0zu?=
 =?us-ascii?q?8tFRjK0Q0lE98IrX/arsj6NL0KXO6o0qfIwzXNYfBY1zjz54fHcAwur/6XUL?=
 =?us-ascii?q?Jscsfc01UjGx/Lg1iSr4HuIjOb1v4Ks2ie9+duSP6vhHA/qwFxvDevwNonhJ?=
 =?us-ascii?q?TMho0PzlDE8Tt2wYYoLtC/U050fMWkHYBMtyCaK4R2QsQiT3tuuCYh0LIKo5?=
 =?us-ascii?q?G7fC8UyJk+wRPUdvKJc4+N4h35VeaRJy91hH1keLKjhxay7FOvxvf9VsmzyF?=
 =?us-ascii?q?pKoDRKncTLtnAXzRPT8taISvxl/kelxzmDzQfT6vtLIU0yiKHVKIYhz6Ytmp?=
 =?us-ascii?q?ccvknPBC/7lFjsgKOIeUgo5PKk5/nhb777vJGTLZV0hRv7Mqk2n8y/Bvk3PR?=
 =?us-ascii?q?YWUmiA/OS8yKXj/UrkQLVWlvE2krfWsJTdJckDuq62GRVV0oc+6xakFTumzN?=
 =?us-ascii?q?QZkmUHLFJCYh6HiZTmO0rSL/ziCPe/glCsnC9qx/DAILLhHo3AImXMnbruZ7?=
 =?us-ascii?q?pw61NQxBAtwd1Q+Z5YEKwNLOr2WkDrtdzYChE5Mxazw+biENh9zZ4RWXmUD6?=
 =?us-ascii?q?+FMKLdrV+I5uU1L+mKf48aoizxK/ci5/7wlXM5g0MSfbG13ZsLb3C1BuxmI0?=
 =?us-ascii?q?GDbnrxntcBC3wFsRAlQezwllKNTD5TaGyuX64m+j47D4emB5/ZRo+xmLyBwD?=
 =?us-ascii?q?u7HppOa2BdFF+MFXbod4OZW/YDcy+SPMBhnSIeVbS7SI8uywuutAnkxLpjNO?=
 =?us-ascii?q?bU/TcYtZ2wnORystXeiQt60TVpE96X2mqNBzVsmmoVWyU81YhlrEB9w0vF2q?=
 =?us-ascii?q?991a92D9tWsshVXx86OJiU9OlzD9T/S0qVZduSYEq3SdWhRzcqR5Q+xMFYMB?=
 =?us-ascii?q?U1IMmrkh2Wh3niOLQSjbHeQcFr/w=3D=3D?=
X-IPAS-Result: A2C2AQDwvDhc/wHyM5A
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 11 Jan 2019 15:59:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0BFxbFS015827;
        Fri, 11 Jan 2019 10:59:37 -0500
Subject: Re: RFC: introduce new library versions for added symbols
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SELinux <selinux@vger.kernel.org>
References: <pjdmuo8fl9s.fsf@redhat.com>
 <391a8f7b-b8b0-32a4-29ff-f85eccec0712@tycho.nsa.gov>
 <pjdlg3rfkkq.fsf@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <353f9889-d43c-9a14-4605-5ba1eac22284@tycho.nsa.gov>
Date:   Fri, 11 Jan 2019 11:01:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <pjdlg3rfkkq.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/11/19 7:24 AM, Petr Lautrbach wrote:
> 
> Stephen Smalley <sds@tycho.nsa.gov> writes:
> 
>> On 1/10/19 12:57 PM, Petr Lautrbach wrote:
>>> I used abi-compliance-checker [1] and compared the latest sources 
>>> with 2.8
>>> release [2].
>>> It looks like there's one symbol added to audit2why.so.
>>
>> audit2why.so needs a .map file or equivalent; it shouldn't be 
>> exporting all of
>> the libsepol.a symbols.  We don't guarantee ABI or API compatibility for
>> anything not in libsepol.map.
>>
> 
> I'll prepare a patch for that.

Does audit2why.so actually need to export any symbols other than 
PyInit_audit2why()?  It only gets used for audit2why.

> 
>>>
>>> Then I tried the same thing with 2.7 [3] and 2.6 [4] and noticed that
>>> there were added new symbols even to LIBSEMANAGE_1.0 while since 2.3
>>> there's already LIBSEMANAGE_1.1.
>>> It's a bug which breaks automatic dependency checking. So I propose
>>> to fix symbol version mappings in order to be in relation with the
>>> release where they was introduced, e.g. for libsemanage:
>>>
>>> diff --git a/libsemanage/src/libsemanage.map 
>>> b/libsemanage/src/libsemanage.map
>>> index 02036696..45e90215 100644
>>> --- a/libsemanage/src/libsemanage.map
>>> +++ b/libsemanage/src/libsemanage.map
>>> @@ -18,8 +18,6 @@ LIBSEMANAGE_1.0 {
>>>   semanage_root;
>>>   semanage_user_*; semanage_bool_*; semanage_seuser_*;
>>>   semanage_iface_*; semanage_port_*; semanage_context_*;
>>> - semanage_ibpkey_*;
>>> - semanage_ibendport_*;
>>>   semanage_node_*;
>>>   semanage_fcontext_*; semanage_access_check;
>>> semanage_set_create_store;
>>>   semanage_is_connected; semanage_get_disable_dontaudit; 
>>> semanage_set_disable_dontaudit;
>>> @@ -63,3 +61,19 @@ LIBSEMANAGE_1.1 {
>>>   semanage_module_remove_key;
>>>   semanage_set_store_root;
>>> } LIBSEMANAGE_1.0;
>>> +
>>> +LIBSEMANAGE_2.5 {
>>> + global:
>>> + semanage_module_extract;
>>> +} LIBSEMANAGE_1.1;
>>> +
>>> +LIBSEMANAGE_2.7 {
>>> + global:
>>> + semanage_ibpkey_*;
>>> + semanage_ibendport_*;
>>> +} LIBSEMANAGE_2.5;
>>> +
>>> +LIBSEMANAGE_2.8 {
>>> + global:
>>> + semanage_fcontext_list_homedirs;
>>> +} LIBSEMANAGE_2.7;
>>>
>>>
>>> If this is acceptable, I would prepare a patch with symbol versions
>>> starting with 2.5 as LIBSEMANAGE_1.1 was introduced in 2.4.
>>
>> Will this break compatibility for binaries built against earlier
>> versions?
> 
> I was under impression that is should be enough to list symbols in
> different versions but it looks like a symbol is assigned only to
> one/the latest version.
> 
> # semodule -B
> semodule: relocation error: /lib64/libsemanage.so.1: symbol 
> sepol_ibendport_modify version LIBSEPOL_1.0 not defined in file 
> libsepol.so.1 with link time reference
> 
> I'm still investigating this but given that there's only one reported
> change between the latest and 2.8 and it  should be covered by audit2why
> map file, it probably doesn't make sense to do this change retroactively 
> now.
> 
> Just for the future we need to keep in mind that new symbols needs new 
> versions
> in .map files.
> 
> 
> 
>>
>>>
>>> [1] http://lvc.github.io/abi-compliance-checker/
>>> [2]
>>> https://plautrba.fedorapeople.org/selinux/compat_reports/2.8_to_2.9-rc0/compat_report.html 
>>>
>>> [3]
>>> https://plautrba.fedorapeople.org/selinux/compat_reports/2.7_to_2.9-rc0/compat_report.html 
>>>
>>> [4]
>>> https://plautrba.fedorapeople.org/selinux/compat_reports/2.6_to_2.9-rc0/compat_report.html 
>>>
>>>
>>> Petr
> 

