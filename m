Return-Path: <SRS0=SqeD=ZS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19B2C432C0
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 14:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787612071A
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 14:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="FDqqn593"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfKZOy3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:54:29 -0500
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:53816 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbfKZOy3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Nov 2019 09:54:29 -0500
X-EEMSG-check-017: 54791425|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,246,1571702400"; 
   d="scan'208";a="54791425"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Nov 2019 14:54:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574780068; x=1606316068;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=uxC22gYLR3KNaCwr/rWXK8D2t3E/EGI0NlKrgKy4PfQ=;
  b=FDqqn593n5pJeJ0YpkJiJLcrglEbIi2Pg9F27StEC/mLjNzxlaPMMvn8
   DK5KxrHHBeUpllzDa9DjrGKa21TTiQy90Ze0yQpYsXxmHxfiX0sry5Rns
   Xl6gY3GV5FNrK99w2ejfhMJLy+7drJlqgLht6MDUuf6+Tv+DYJ5zrwpKz
   qHysZMUFZ+2S/cbZM5Mm5FoyS5vayOz1wRQaZ6ltCWgQLyAbY9TWqCKS+
   cHHSkrAnRMB63cFUX8s7HoVhqYVq5nXW1S5QvauVjl85/yaNA4royPrw7
   IixPTA+JB49CGliqCQPn9CHjbjX2u+2FrqbYxdkxFeuYweh0s+W8IRwv/
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,246,1571702400"; 
   d="scan'208";a="30510243"
IronPort-PHdr: =?us-ascii?q?9a23=3ALGj7qBTtRrMi20MXm8RRY6vyfdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZBeEt8tkgFKBZ4jH8fUM07OQ7/m7HzVeut3f4DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajIpsJ6o+yx?=
 =?us-ascii?q?bEoWZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oSt0TDECj2mF7og6CKbEkk5uip5PjnYrXhvJOcMZN7ihriPag0n8y/AOA4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VD2TbhFlPE7krTVvIrEKckUuKK1GRJZ3p4m6xmlDjem1N?=
 =?us-ascii?q?oYnWMALFJAYB+HlJXmO0rVLfDkDfawn1SskDBxy/DAJb3uGI/BLnfEkLf/Zb?=
 =?us-ascii?q?p98VJTyBIvzdBD4JJZEqsBIPPvVU/xrtPYFAI2PBSozOn/CNVyzIIeWWSRDa?=
 =?us-ascii?q?+CK67dqkOI5uMpI+mQeoAVojD9JOY55/L0kXA5nlodd7Gz3ZQLcHC4AuhmI0?=
 =?us-ascii?q?KBbHrrh9cBFnwKvgwkQ+P2llKPSiRTaGivUKI8/D47FJiqApvERoComLaBxj?=
 =?us-ascii?q?u0HoVKZmBaDVCBCWzoeJuAW/cNbiKSP8BgnycaVbiuVYAhzwuitAzkxLp9KO?=
 =?us-ascii?q?rb5CkYuYjk1Nhv6O2A3S01oAZ1BMSUyW3Fb2h1mG4TD2ss3at/qFZx/Vy00a?=
 =?us-ascii?q?F5hfFDPdZP5vVVXx08OIKaxOt/XZS6fQTNZNqLAHOhWdOvCjwyBoY2xtgVZU?=
 =?us-ascii?q?92Fv24gxzD1jbsCLgQwfjDH5Ew86TBz1DvKMtnjXXLzq8six8hWMQcG3ehg/?=
 =?us-ascii?q?tE6wXLB4PP236cnqKueLVUiDXB70+f3GGOuwdeSwc2XqLbCyNMLnDKpMj0sx?=
 =?us-ascii?q?uRB4SlDq4qZ04Ykp+P?=
X-IPAS-Result: =?us-ascii?q?A2BMAAD6O91d/wHyM5BkGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQriQOGUQEBAQEBAQaBN4lpiiCHJAkBAQEBAQEBA?=
 =?us-ascii?q?QE3AQGEQAKCGjgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJuAQUjFVELGAICJ?=
 =?us-ascii?q?gICVwYBDAYCAQGCXz+CRwMJJbMigTKFT4M4gUiBDiiMMHiBB4E4D4JdPoIbh?=
 =?us-ascii?q?T6CXgSWYkaXDII2gjmKC4kMBhuCP4woizYtjhuBQpphIoFYKwgCGAghD4MnU?=
 =?us-ascii?q?BEUlSwjAzCPbwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 26 Nov 2019 14:54:05 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xAQEs0du094236;
        Tue, 26 Nov 2019 09:54:01 -0500
Subject: Re: [PATCH testsuite v3] policy: use the kernel_request_load_module()
 interface
To:     Richard Haines <richard_c_haines@btinternet.com>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20191126120623.736870-1-omosnace@redhat.com>
 <c765adb1e61950cb0f2aea6cbb7d4b94797b2a31.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2723e1c7-7e17-b8fc-757d-4a126ded8354@tycho.nsa.gov>
Date:   Tue, 26 Nov 2019 09:54:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c765adb1e61950cb0f2aea6cbb7d4b94797b2a31.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/26/19 9:51 AM, Richard Haines wrote:
> On Tue, 2019-11-26 at 13:06 +0100, Ondrej Mosnacek wrote:
>> ...instead of open-coding the rules. Also define a fallback to allow
>> the
>> policy to build even if the interface is not defined.
>>
>> Fixes: f5e5a0b8d005 ("selinux-testsuite: Add key_socket tests")
>> Cc: Richard Haines <richard_c_haines@btinternet.com>
>> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>> ---
>>
>> Change in v3: use different approach as suggested by Stephen
>> Change in v2: update also tests/Makefile for consistency
>>
>>   policy/test_key_socket.te | 8 ++++----
>>   policy/test_policy.if     | 6 ++++++
>>   2 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
>> index cde426b..f1c1606 100644
>> --- a/policy/test_key_socket.te
>> +++ b/policy/test_key_socket.te
>> @@ -13,7 +13,7 @@ typeattribute test_key_sock_t keysockdomain;
>>   allow test_key_sock_t self:capability { net_admin };
>>   allow test_key_sock_t self:key_socket { create write read setopt };
>>   # For CONFIG_NET_KEY=m
>> -allow test_key_sock_t kernel_t:system { module_request };
>> +kernel_request_load_module(test_key_sock_t)
>>   
>>   ################## Deny capability { net_admin }
>> ##########################
>>   #
>> @@ -29,7 +29,7 @@ typeattribute test_key_sock_no_net_admin_t
>> testdomain;
>>   typeattribute test_key_sock_no_net_admin_t keysockdomain;
>>   
>>   allow test_key_sock_no_net_admin_t self:key_socket { create write
>> read setopt };
>> -allow test_key_sock_no_net_admin_t kernel_t:system { module_request
>> };
>> +kernel_request_load_module(test_key_sock_t)
> 
> All the new entries have (test_key_sock_t) ??
> Anyway if you run the tests in the order they appear in 'test' script,
> then it just so happens that the module will be loaded for
> test_key_sock_t as it's first. I added the others just to cover the
> cases where I sometimes run out of sequence, so you could remove these
> if required.

Good catch!  Somehow I missed that.  Could probably just have a single 
kernel_request_load_module(keysockdomain) line?

> 
>>   
>>   ####################### Deny key_socket { create }
>> ##########################
>>   type test_key_sock_no_create_t;
>> @@ -50,7 +50,7 @@ typeattribute test_key_sock_no_write_t
>> keysockdomain;
>>   
>>   allow test_key_sock_no_write_t self:capability { net_admin };
>>   allow test_key_sock_no_write_t self:key_socket { create read setopt
>> };
>> -allow test_key_sock_no_write_t kernel_t:system { module_request };
>> +kernel_request_load_module(test_key_sock_t)
>>   
>>   ####################### Deny key_socket { read }
>> ##########################
>>   type test_key_sock_no_read_t;
>> @@ -61,7 +61,7 @@ typeattribute test_key_sock_no_read_t
>> keysockdomain;
>>   
>>   allow test_key_sock_no_read_t self:capability { net_admin };
>>   allow test_key_sock_no_read_t self:key_socket { create write setopt
>> };
>> -allow test_key_sock_no_read_t kernel_t:system { module_request };
>> +kernel_request_load_module(test_key_sock_t)
>>   
>>   #
>>   ########### Allow these domains to be entered from sysadm domain
>> ############
>> diff --git a/policy/test_policy.if b/policy/test_policy.if
>> index e1175e8..3f163cb 100644
>> --- a/policy/test_policy.if
>> +++ b/policy/test_policy.if
>> @@ -82,3 +82,9 @@ interface(`userdom_search_admin_dir', `
>>       userdom_search_user_home_content($1)
>>   ')
>>   ')
>> +
>> +# If the macro isn't defined, then most probably module_request
>> permission
>> +# is just not supported (and relevant operations should be just
>> allowed).
>> +ifdef(`kernel_request_load_module', `', ` dnl
>> +interface(`kernel_request_load_module', `')
>> +')
> 

