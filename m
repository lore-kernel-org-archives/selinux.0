Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01C3C282DD
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 16:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E5F20673
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 16:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="d3BcISy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgAHQIE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:08:04 -0500
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:22588 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgAHQID (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 11:08:03 -0500
X-EEMSG-check-017: 67234857|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="67234857"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Jan 2020 16:08:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578499680; x=1610035680;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SCg9qsTQol+h65PNw8G8a1vfiS3F94OyQFAZ8A6M3K8=;
  b=d3BcISy3Wndd2Rqhr2VPaYBxggcJjMTbiSsH/Jqv0dKtobYlMUBLISaV
   EnyONxcTnh/YdgiZiaWYwDhcZuTUs2CO1wGHZkPbwmmzO1XiYbHUA5p2s
   1uly8Tb7FTV9PlyQjx3lkU/A2PHeGUHkE9Myf7FRc3DmcVwV8fMYudWnV
   WQWv2CtzYIk74TYSuTn8V5mXdnCSXrxjBWvPlZvKArSFK+s8w1wPpo6+U
   TmlaqKWKJvwBFo+hx4GhBW+BccMEba1cWDknQoTPsT4QQI1hex4PK7wSB
   /GgU5PXIbBRxlg18YTh1xchv+8CC1C4mx4np8bekoc8z69y0mDbJVLH6y
   w==;
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="31724232"
IronPort-PHdr: =?us-ascii?q?9a23=3AtiqE1Bdaj0Y1pZlQI9T09Qo6lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW4bR7h7PlgxGXEQZ/co6odzbaP6Oa6BDxLsczJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusQWgoZuJaU8xg?=
 =?us-ascii?q?XUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezBQ2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmuz46x6UbtZ?=
 =?us-ascii?q?O0cyUG0pQqywPFZ/CZfIWE/AjvWPuXLDxlnnxqYqi/iAy38UW4z+38UdS730?=
 =?us-ascii?q?hSoypel9nMqmgN1xvO6sibUvd9/lmu2TKI1w3L9uFLO1o0lavGK5462LIwl5?=
 =?us-ascii?q?wTsUrEHi/thkr5kLWadlkk++e06+TnZa/qppmAOI9vlg7yKKEums27AeggMw?=
 =?us-ascii?q?gOWXaU+fik2bH+8kD0T69Gg/0rnqXDrpzXKtoXqrSkDwNN14Ys8Re/DzOo0N?=
 =?us-ascii?q?QCmnkHKUpIeAmagIjyIFzOPPD5Auu/g1SrijtrwevGMaf7DpXCKXjDjq/tfa?=
 =?us-ascii?q?xh5E5E1Aoz0ddf6opMCr4bPfLzXlT8tMTCAR8kNwy42uPnCNJ61oMER22DGL?=
 =?us-ascii?q?OWMKTXsVWQ/OIgP/GMZJMJuDb6M/Ul/ODhjXs4mV8bYKmo0oAaaG63Hvt4OU?=
 =?us-ascii?q?WVe3nsjckbEWcMoAU+SPbmiFqYUT5cf3yyRb4z5iknCIK6CofOXoetgLmG3C?=
 =?us-ascii?q?egGJ1ZfHxJBU6XHHfyaYqLRvcMZziOIsN7jjMEUr2hGMcd0kSWvRL+g59gKf?=
 =?us-ascii?q?DZsnkAvI/n/MB8+umWkBY17zEyBMOYhTKjVWZxy1gUSic20aY3mkl0zlOOwO?=
 =?us-ascii?q?AsmPBDPcBC7PNOFAEhPNjTyPIsWIO6YR7IYtrcEAXued6hGzxkC4tsktI=3D?=
X-IPAS-Result: =?us-ascii?q?A2BQAADF/BVe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoFA?=
 =?us-ascii?q?QELAYF8gW0gEiqECYkDhmcBAQEBAQEGgTeJbo9NFIFnCQEBAQEBAQEBATcBA?=
 =?us-ascii?q?YRAAoIONgcOAhABAQEEAQEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIwQRQQULC?=
 =?us-ascii?q?xgCAiYCAlcGDQYCAQGCXz+CUwUgqxB1fzOFT4M6gT2BDigBjDJ5gQeBOA+CX?=
 =?us-ascii?q?T6EMYMogl4EjT+JX0aXQ4JAgkWTVwYbmmKrPQEygVgrCAIYCCEPgydQGA2NH?=
 =?us-ascii?q?heOQSMDMJB7AQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 08 Jan 2020 16:07:59 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 008G7Nia028155;
        Wed, 8 Jan 2020 11:07:23 -0500
Subject: Re: [RFC PATCH] selinux: deprecate setting checkreqprot to 1
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
References: <20200107202322.27380-1-sds@tycho.nsa.gov>
 <CAHC9VhRH9aPY8ehdA4JseYSMxSCh3zORcM=EnH-srA4qrvQhiw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a6397631-12b7-c6b9-d735-75151b31bf4b@tycho.nsa.gov>
Date:   Wed, 8 Jan 2020 11:08:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRH9aPY8ehdA4JseYSMxSCh3zORcM=EnH-srA4qrvQhiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/8/20 12:57 AM, Paul Moore wrote:
> On Tue, Jan 7, 2020 at 3:22 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> Deprecate setting the SELinux checkreqprot tunable to 1 via kernel
>> parameter or /sys/fs/selinux/checkreqprot.  Setting it to 0 is left
>> intact for compatibility since Android and some Linux distributions
>> do so for security and treat an inability to set it as a fatal error.
>> Eventually setting it to 0 will become a no-op and the kernel will
>> stop using checkreqprot's value internally altogether.
>>
>> checkreqprot was originally introduced as a compatibility mechanism
>> for legacy userspace and the READ_IMPLIES_EXEC personality flag.
>> However, if set to 1, it weakens security by allowing mappings to be
>> made executable without authorization by policy.  The default value
>> for the SECURITY_SELINUX_CHECKREQPROT_VALUE config option was changed
>> from 1 to 0 in commit 2a35d196c160e3 ("selinux: change
>> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE default") and both Android
>> and Linux distributions began explicitly setting
>> /sys/fs/selinux/checkreqprot to 0 some time ago.
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>> RFC-only, not yet tested.
>>
>>   Documentation/admin-guide/kernel-parameters.txt | 1 +
>>   security/selinux/Kconfig                        | 3 +++
>>   security/selinux/hooks.c                        | 4 ++++
>>   security/selinux/selinuxfs.c                    | 6 ++++++
>>   4 files changed, 14 insertions(+)
> 
> No objection so long as the testing goes okay, although I don't think
> we will see any surprises.

Booting with this patch did produce one surprise; it logged a warning 
claiming that checkreqprot was set to 1 via kernel parameter on Fedora. 
This was incorrect; it is actually defaulted to 1 via kernel config on 
Fedora (Fedora kernel config still has 
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1 at least in F31), so I 
moved the check to checkreqprot_setup() so that it will only log if 
explicitly set via kernel parameter.  Fedora is switching checkreqprot 
to 0 from systemd-tmpfiles via an entry in 
/usr/lib/tmpfiles.d/selinux-policy.conf, so at least it isn't left as 1 
after startup.

> However, as you pointed out earlier, we should probably add an entry
> to Documentation/ABI/obsolete; while the "checkreqprot" selinuxfs node
> isn't going away, we are restricting it in a way which was previously
> allowed.

Ok, I'll do that and add the documentation maintainers to the next 
version of the patch.  I'll follow your example on using sysfs-selinux 
as the prefix but we'll see if they prefer selinuxfs- instead.

> 
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index eed51293d6cf..c894ddfa1393 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -512,6 +512,7 @@
>>                          Default value is set via a kernel config option.
>>                          Value can be changed at runtime via
>>                                  /sys/fs/selinux/checkreqprot.
>> +                       Setting checkreqprot to 1 is deprecated.
>>
>>          cio_ignore=     [S390]
>>                          See Documentation/s390/common_io.rst for details.
>> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
>> index 1014cb0ee956..9e921fc72538 100644
>> --- a/security/selinux/Kconfig
>> +++ b/security/selinux/Kconfig
>> @@ -88,6 +88,9 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
>>            'checkreqprot=' boot parameter.  It may also be changed at runtime
>>            via /sys/fs/selinux/checkreqprot if authorized by policy.
>>
>> +         WARNING: this option is deprecated and will be removed in a future
>> +         kernel release.
>> +
>>            If you are unsure how to answer this question, answer 0.
>>
>>   config SECURITY_SELINUX_SIDTAB_HASH_BITS
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 63a6e36abe9f..11d47bb7d40a 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -7149,7 +7149,11 @@ static __init int selinux_init(void)
>>
>>          memset(&selinux_state, 0, sizeof(selinux_state));
>>          enforcing_set(&selinux_state, selinux_enforcing_boot);
>> +
>>          selinux_state.checkreqprot = selinux_checkreqprot_boot;
>> +       if (selinux_state.checkreqprot)
>> +               pr_warn("SELinux: checkreqprot set to 1 via kernel parameter.  This is deprecated.\n");
>> +
>>          selinux_ss_init(&selinux_state.ss);
>>          selinux_avc_init(&selinux_state.avc);
>>
>> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>> index 79c710911a3c..c6c136eee371 100644
>> --- a/security/selinux/selinuxfs.c
>> +++ b/security/selinux/selinuxfs.c
>> @@ -668,6 +668,12 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
>>          if (sscanf(page, "%u", &new_value) != 1)
>>                  goto out;
>>
>> +       if (new_value) {
>> +               char comm[sizeof(current->comm)];
>> +               memcpy(comm, current->comm, sizeof(comm));
>> +               pr_warn_once("SELinux: %s (%d) set checkreqprot to 1.  This is deprecated.\n", comm, current->pid);
>> +       }
>> +
>>          fsi->state->checkreqprot = new_value ? 1 : 0;
>>          length = count;
>>   out:
>> --
>> 2.24.1
> 

