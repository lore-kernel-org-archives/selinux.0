Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09449C282DD
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 16:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58F820678
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 16:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gxklUfMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgAHQ5D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:57:03 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:47996 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgAHQ5D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 11:57:03 -0500
X-EEMSG-check-017: 42277230|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="42277230"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Jan 2020 16:34:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578501286; x=1610037286;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=q+hTctTrQnvJrdN4eh3L6lVbmM42nD0C7nBYTw1VXkk=;
  b=gxklUfMwjUL2wnbKh5VdxZP/bQMSJ2R7adLDoYVcSm6YDgPzNQmF4mP7
   dFF1NgF4685mJvaUQ7UfrnScAulWGU3evFxj1Iwt1BMiLOquFfXnCKsan
   UJoegpmkMTJLhH4DKiVER/wYNCL2eSmNSfVx9T2siYUDxJ0tBEdxK6Yc3
   H38xa9vPDqIFzE1bqed7KiG91XNLjzw1G1i9i7e/uxGwD4gjM8NkARALI
   dQoRugJGxR7OV3gzNUJPZOwItGp8WJJMF6STm1c7zLWmW1+qQIBUVXkX4
   3o4q8tYOICtm2qcF3bpAo7r+vXaFBQgqj75oaLur1XZAWhvW7CbtRGOTJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,410,1571702400"; 
   d="scan'208";a="31725813"
IronPort-PHdr: =?us-ascii?q?9a23=3Ar13YnxcWykHsUurWribdyWjTlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW5YB7h7PlgxGXEQZ/co6odzbaP6Oa6BDxLscbJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusQWgoZuJaU8xx?=
 =?us-ascii?q?jUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
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
 =?us-ascii?q?xh5E5E1Aoz0ddf6opTCrEEJ/LzQUnxu8bEARAnKAG02fjoB8h91owERWKDGL?=
 =?us-ascii?q?OWMKTXsVWQ/OIgP/GMZJMJuDb6M/Ul/+ThjWI9mVIGZammx4YXaHShEvRjJE?=
 =?us-ascii?q?WZZmDsjckbHWgWuQo+SfTgiEeeXj5Le3ayQ6U86ykgCI24CYfDR4atgKGO3S?=
 =?us-ascii?q?qgAJ1WaX5JCkqWHXfraYqEQfEMZzyWIsN7lTwET7ehGMcd0kSJsgPgxrgvC+?=
 =?us-ascii?q?3P/CQTuJGrgN9w4PbVnBo/3SZ5A8SUzyeGSGQizU0SQDpj57xyuUxwzB+41K?=
 =?us-ascii?q?F8h/FJXYhI6+hhThYxNZmayfdzTd/1RFSSLZ+yVF+6T4D+UnkKRdUrzopLOh?=
 =?us-ascii?q?ssFg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CwAAD9AxZe/wHyM5AaAUsdAQEBCQERBQUBgWoGAQsBA?=
 =?us-ascii?q?YF7gW0gEiqECYkDhmgBAQEBAQEGgRIliW6PTYF7CQEBAQEBAQEBATcBAYRAA?=
 =?us-ascii?q?oIONgcOAhABAQEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjFUEQCw4KAgImAgJXB?=
 =?us-ascii?q?g0GAgEBgl8/glMljiydaoEyhU+DOoE9gQ4oAYwyeYEHgTgMA4JdPodZgl4El?=
 =?us-ascii?q?x5Gl0OCQIJFk1cGAhmaYqs+CSmBWCsIAhgIIQ+DJ1AYDY0eF45BIwMwkHsBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 08 Jan 2020 16:34:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 008GY5BM037613;
        Wed, 8 Jan 2020 11:34:06 -0500
Subject: Re: [RFC PATCH] selinux: deprecate setting checkreqprot to 1
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
References: <20200107202322.27380-1-sds@tycho.nsa.gov>
 <CAHC9VhRH9aPY8ehdA4JseYSMxSCh3zORcM=EnH-srA4qrvQhiw@mail.gmail.com>
 <a6397631-12b7-c6b9-d735-75151b31bf4b@tycho.nsa.gov>
 <CAFqZXNubWE9--yweD0rEJVkvYUXaDJDMV2o3S3j6crrWkf-ASA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <00992981-ce53-07c8-f9c8-4e5d892579ae@tycho.nsa.gov>
Date:   Wed, 8 Jan 2020 11:35:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNubWE9--yweD0rEJVkvYUXaDJDMV2o3S3j6crrWkf-ASA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/8/20 11:26 AM, Ondrej Mosnacek wrote:
> On Wed, Jan 8, 2020 at 5:08 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 1/8/20 12:57 AM, Paul Moore wrote:
>>> On Tue, Jan 7, 2020 at 3:22 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>
>>>> Deprecate setting the SELinux checkreqprot tunable to 1 via kernel
>>>> parameter or /sys/fs/selinux/checkreqprot.  Setting it to 0 is left
>>>> intact for compatibility since Android and some Linux distributions
>>>> do so for security and treat an inability to set it as a fatal error.
>>>> Eventually setting it to 0 will become a no-op and the kernel will
>>>> stop using checkreqprot's value internally altogether.
>>>>
>>>> checkreqprot was originally introduced as a compatibility mechanism
>>>> for legacy userspace and the READ_IMPLIES_EXEC personality flag.
>>>> However, if set to 1, it weakens security by allowing mappings to be
>>>> made executable without authorization by policy.  The default value
>>>> for the SECURITY_SELINUX_CHECKREQPROT_VALUE config option was changed
>>>> from 1 to 0 in commit 2a35d196c160e3 ("selinux: change
>>>> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE default") and both Android
>>>> and Linux distributions began explicitly setting
>>>> /sys/fs/selinux/checkreqprot to 0 some time ago.
>>>>
>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>> ---
>>>> RFC-only, not yet tested.
>>>>
>>>>    Documentation/admin-guide/kernel-parameters.txt | 1 +
>>>>    security/selinux/Kconfig                        | 3 +++
>>>>    security/selinux/hooks.c                        | 4 ++++
>>>>    security/selinux/selinuxfs.c                    | 6 ++++++
>>>>    4 files changed, 14 insertions(+)
>>>
>>> No objection so long as the testing goes okay, although I don't think
>>> we will see any surprises.
>>
>> Booting with this patch did produce one surprise; it logged a warning
>> claiming that checkreqprot was set to 1 via kernel parameter on Fedora.
>> This was incorrect; it is actually defaulted to 1 via kernel config on
>> Fedora (Fedora kernel config still has
>> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1 at least in F31), so I
>> moved the check to checkreqprot_setup() so that it will only log if
>> explicitly set via kernel parameter.  Fedora is switching checkreqprot
>> to 0 from systemd-tmpfiles via an entry in
>> /usr/lib/tmpfiles.d/selinux-policy.conf, so at least it isn't left as 1
>> after startup.
> 
> Interesting... should I send a PR to change the kernel config on
> Fedora? Does anyone know why the
> /usr/lib/tmpfiles.d/selinux-policy.conf approach was used instead of
> just setting the kernel config option to 0? I assume the config option
> just didn't exist yet back then?

Yes, I would recommend doing so since the config option is being 
deprecated too.  The config option predates git so I don't think that 
was the issue; it was probably just a case of the SELinux userspace 
maintainers being able to package a tmpfiles.d config file easily and no 
kernel developer pushing the corresponding change.

I could see this potentially creating problems for architectures that 
still default to VM_EXEC being included in their VM_DATA_DEFAULT_FLAGS. 
For those, we might need to disable the FILE__EXECUTE check on 
mmap/mprotect just as we do for PROCESS__EXECMEM.

