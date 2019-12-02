Return-Path: <SRS0=5g5+=ZY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA980C432C0
	for <selinux@archiver.kernel.org>; Mon,  2 Dec 2019 21:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C9820675
	for <selinux@archiver.kernel.org>; Mon,  2 Dec 2019 21:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="hqT4irol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfLBVR5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:17:57 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:51038 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBVR5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Dec 2019 16:17:57 -0500
X-EEMSG-check-017: 32042840|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,270,1571702400"; 
   d="scan'208";a="32042840"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 02 Dec 2019 21:17:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575321474; x=1606857474;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VuPmL+nvHg3FnEE8uFc+CSSZqNasar69WreUsm3A/dA=;
  b=hqT4irolYjsaJoot/USXEH3m+MNPVTi1f0E6p7YOzaNR3Irmhzb1h6xJ
   nmrgkZIgWqoNjd091WcqE7/JBonEIQRs9l+8gnD5kwiZnlTa40EwiKQa8
   EYNlxt2aaJkP3wKNhqjTWS5Zvn03nfx54AGyD3AKvUooAZ4kgSGl2THx1
   cYxhGtuBhsck4KZFVbTiGskUGAkqxtCI/1dRtQoUxA3x1zYSGYZkl7117
   qcl+lo7vWA/JrOJhLS5frG9pGYNatrOARdjEuMFr5E1nlN9DJ6hgmrK1L
   Jzr/VHaOn1aS1ehvKLZ2sCvgTSfyp8PHS+cEY2XxeIP3MLUQvDitG6fjM
   w==;
X-IronPort-AV: E=Sophos;i="5.69,270,1571702400"; 
   d="scan'208";a="36218389"
IronPort-PHdr: =?us-ascii?q?9a23=3An7TjHxMyZKV88AnIQRMl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/T9rarrMEGX3/hxlliBBdydt6sfzbOJ7uu5BTJIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQjTtsQajpZuJ6kwxx?=
 =?us-ascii?q?DUvnZGZuNayH9yK1mOhRj8/MCw/JBi8yRUpf0s8tNLXLv5caolU7FWFSwqPG?=
 =?us-ascii?q?8p6sLlsxnDVhaP6WAHUmoKiBpIAhPK4w/8U5zsryb1rOt92C2dPc3rUbA5XC?=
 =?us-ascii?q?mp4ql3RBP0jioMKiU0+3/LhMNukK1boQqhpx1hzI7SfIGVL+d1cqfEcd8HWW?=
 =?us-ascii?q?ZNQsNdWipPDYOma4sEEvQPM+BWoYLgo1cCtBWzCA2pCO7p1zRGhGL53bci3u?=
 =?us-ascii?q?o8EQ/IwgIgEdEAvnvao9r6NrsdX++uwanUzjjOde9a1Svz5YXKdB0qvPGCXa?=
 =?us-ascii?q?h3ccrU0UQhCh/FgUuIqYzlITyV0PkGvXWe7+V6UeKvj3AoqgFsqTWo3ccjl5?=
 =?us-ascii?q?LJi5kJylHE6Sp5wIE1Kce+SE5ge9GoCpRQtyaEN4ZvRM4pXmJmuD4ix7Ebtp?=
 =?us-ascii?q?O2czIGxZQ6yxLFdfCKfJaE7gj+WOuXPDx2nmhqeKiliBa36UWgz+r8WdSq31?=
 =?us-ascii?q?tStSpFl8XMtmgK1xzO9siLUvt98Vml2TaIzw3T9vtLIVo1larGMJ4t2L8wlp?=
 =?us-ascii?q?wdsUTEBS/5hln5gLWKdkQk5ueo6+Pnbq/gppCALI97lhvyMqEvmsy7Geg4Mw?=
 =?us-ascii?q?4OUHaH+emkybHu8kL0TK9Kg/EriKXVrp/XKdoBqqKkGwNV15ws6xe7Dzeoyt?=
 =?us-ascii?q?QYmnwHIUpeeB2alIjkIE3OIfDkAve/hFSgijFrx+vcMbH7DZXNKWbDnK/7fb?=
 =?us-ascii?q?lh805c1BYzzddH6pJTD7EBJ+nzWknru9PEEBA0KBa0zPj6B9V9zIweRXiDDb?=
 =?us-ascii?q?OeMKPXqVWI/P4gI/GQZI8JvzbwM+Ml6ODqjX84n18dYKao0IAJaHC3APtmOV?=
 =?us-ascii?q?+VYXnyjdcbF2cFoA4+QPbtiF2YXj5Zf2yyUL4k5jEnFIKmCp/ORpqsgLOd3C?=
 =?us-ascii?q?e0BIdWaX1eBV+QCXjod5+LW/YKaC2MOc9siScLVaSgS48nyRGhqhX6y7x5Ie?=
 =?us-ascii?q?rI4CEXqZXj1N0mr9HUwDY0+SZ5DYy41HqLRmp5nStcQDoxx6Z2qkFV0FqP0a?=
 =?us-ascii?q?FkxfdfEIoXr+hEVgY8KI700eN3EZbxVxjHc9PPT0ypEfu8BjRkdc48298DZQ?=
 =?us-ascii?q?5GHtymih3Sl36xD6Q9i62ABJty9LnVmXf2OZAumD79yKA9ggx+EYN0Pmq8i/?=
 =?us-ascii?q?s6rlOCCg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BZAAC1fuVd/wHyM5BmGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQriQOGWAEBAQEBAQaBN4lpiiCHJAkBAQEBAQEBA?=
 =?us-ascii?q?QE3AQGEQAKCLzgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJuAQUjDwEFQRAJA?=
 =?us-ascii?q?g4KAgImAgJXBgEMBgIBAYJfP4JHAwkllzmbc4EyiHeBSIEOKIwweYEHgTgPg?=
 =?us-ascii?q?l0+ghuFPoJeBI0HiiaXEYI4gjmTGgYbgkGMLIs2LY4dgUKaZiKBWCsIAhgII?=
 =?us-ascii?q?Q+DJ1ARFJtKIwMwkUoBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 02 Dec 2019 21:17:52 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB2LHiSS185754;
        Mon, 2 Dec 2019 16:17:45 -0500
Subject: Re: [PATCH testsuite v6] policy: use the kernel_request_load_module()
 interface
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
References: <20191128140807.900061-1-omosnace@redhat.com>
 <f8c21ed7-eda6-e63b-7e94-616055852244@tycho.nsa.gov>
Message-ID: <a6ac931f-7a84-cff5-c988-7810c0b0f306@tycho.nsa.gov>
Date:   Mon, 2 Dec 2019 16:18:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f8c21ed7-eda6-e63b-7e94-616055852244@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/2/19 9:37 AM, Stephen Smalley wrote:
> On 11/28/19 9:08 AM, Ondrej Mosnacek wrote:
>> ...instead of open-coding the rules. Also define a fallback to allow the
>> policy to build even if the interface is not defined.
>>
>> Fixes: f5e5a0b8d005 ("selinux-testsuite: Add key_socket tests")
>> Cc: Richard Haines <richard_c_haines@btinternet.com>
>> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Thanks, merged.

> 
>> ---
>>
>> Change in v6: avoid apostrophes in comments
>> Change in v5: call the macro only once for the whole domain
>> Change in v4: fix copy-paste mistakes spotted by Richard
>> Change in v3: use different approach as suggested by Stephen
>> Change in v2: update also tests/Makefile for consistency
>>
>>   policy/test_key_socket.te | 8 +++-----
>>   policy/test_policy.if     | 8 +++++++-
>>   2 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
>> index cde426b..64d2cee 100644
>> --- a/policy/test_key_socket.te
>> +++ b/policy/test_key_socket.te
>> @@ -12,8 +12,6 @@ typeattribute test_key_sock_t keysockdomain;
>>   # key_socket rules:
>>   allow test_key_sock_t self:capability { net_admin };
>>   allow test_key_sock_t self:key_socket { create write read setopt };
>> -# For CONFIG_NET_KEY=m
>> -allow test_key_sock_t kernel_t:system { module_request };
>>   ################## Deny capability { net_admin } 
>> ##########################
>>   #
>> @@ -29,7 +27,6 @@ typeattribute test_key_sock_no_net_admin_t testdomain;
>>   typeattribute test_key_sock_no_net_admin_t keysockdomain;
>>   allow test_key_sock_no_net_admin_t self:key_socket { create write 
>> read setopt };
>> -allow test_key_sock_no_net_admin_t kernel_t:system { module_request };
>>   ####################### Deny key_socket { create } 
>> ##########################
>>   type test_key_sock_no_create_t;
>> @@ -50,7 +47,6 @@ typeattribute test_key_sock_no_write_t keysockdomain;
>>   allow test_key_sock_no_write_t self:capability { net_admin };
>>   allow test_key_sock_no_write_t self:key_socket { create read setopt };
>> -allow test_key_sock_no_write_t kernel_t:system { module_request };
>>   ####################### Deny key_socket { read } 
>> ##########################
>>   type test_key_sock_no_read_t;
>> @@ -61,10 +57,12 @@ typeattribute test_key_sock_no_read_t keysockdomain;
>>   allow test_key_sock_no_read_t self:capability { net_admin };
>>   allow test_key_sock_no_read_t self:key_socket { create write setopt };
>> -allow test_key_sock_no_read_t kernel_t:system { module_request };
>>   #
>>   ########### Allow these domains to be entered from sysadm domain 
>> ############
>>   #
>>   miscfiles_domain_entry_test_files(keysockdomain)
>>   userdom_sysadm_entry_spec_domtrans_to(keysockdomain)
>> +
>> +# For CONFIG_NET_KEY=m
>> +kernel_request_load_module(keysockdomain)
>> diff --git a/policy/test_policy.if b/policy/test_policy.if
>> index e1175e8..cefc8fb 100644
>> --- a/policy/test_policy.if
>> +++ b/policy/test_policy.if
>> @@ -76,9 +76,15 @@ interface(`mount_rw_pid_files', `
>>   ')
>>   ')
>> -# Refpolicy doesn't have admin_home_t - assume /root will be 
>> user_home_dir_t.
>> +# Refpolicy does not have admin_home_t - assume /root will be 
>> user_home_dir_t.
>>   ifdef(`userdom_search_admin_dir', `', ` dnl
>>   interface(`userdom_search_admin_dir', `
>>       userdom_search_user_home_content($1)
>>   ')
>>   ')
>> +
>> +# If the macro is not defined, then most probably module_request 
>> permission
>> +# is just not supported (and relevant operations should be just 
>> allowed).
>> +ifdef(`kernel_request_load_module', `', ` dnl
>> +interface(`kernel_request_load_module', `')
>> +')
>>
> 

