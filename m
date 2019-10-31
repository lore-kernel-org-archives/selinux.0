Return-Path: <SRS0=943q=YY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DE8CA9ECB
	for <selinux@archiver.kernel.org>; Thu, 31 Oct 2019 14:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A20F2087E
	for <selinux@archiver.kernel.org>; Thu, 31 Oct 2019 14:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="fX3onnYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfJaOBS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:01:18 -0400
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:17276 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJaOBR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Oct 2019 10:01:17 -0400
X-EEMSG-check-017: 27100263|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,250,1569283200"; 
   d="scan'208";a="27100263"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 31 Oct 2019 14:01:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572530475; x=1604066475;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=col7/cWDFlMV5lf9xijuimNrsbMldXgJLMjr8CUaIb0=;
  b=fX3onnYch7awOUcZRtNXj6wqlOD27k35qS/EInFWtIVBDsQ3sgTAAacf
   MXGEjPbCZxm/YWdoQ+4VGDFWptwqmzhujevtz9kTDsQOwWLMkp9IqCCJi
   f6+fGc5eB6yzTJ4reNS5IKQCHgOAcVrOTK+w8BBvXzwxLYqiJENx7O36k
   AmDRbcPMdHgKbM5qQWcrLOoFOLvLsHeVlYAa2lnYZtV0cmrGZcMOaFEdx
   TRWM8jh1DWEfpYq4vyj/DkzMoHjCh1LMTFiHPEQ9ny1qIxAcbtj6M3kQU
   bgcVLxp14Z2ARao7k+tKmuofeR6z1tx/BFb5+x5Tzp9vQmfL3fbjdAV18
   Q==;
X-IronPort-AV: E=Sophos;i="5.68,250,1569283200"; 
   d="scan'208";a="34932181"
IronPort-PHdr: =?us-ascii?q?9a23=3Ad2rzmhWUrRKRkiw3MzQG5KhPWZ7V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbBGOt8tkgFKBZ4jH8fUM07OQ7/m7HzVYvN3c7DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajZdiJ6o+yh?=
 =?us-ascii?q?bErWZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSsAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oPsUXMAi/2mELsgK+Qakok4fSn5/7iYrXnop+QL450igfgPaQygsGzHOs1Pw?=
 =?us-ascii?q?cUU2Wb5OiwzqPv8ELnTLlQk/E6iqzZv4rbJcQfqK65GQhV0oM75hakEjimy8?=
 =?us-ascii?q?8VnWUHLV1ZeBKHiJLlO1fVIP/iF/u/jFOskClzy/DcIrLhGonNLmTEkLr5Zb?=
 =?us-ascii?q?Zy8VNcyA4owNBH/Z1UF7UBLOv2Wk/2s9zYFAE2PxaozObgDdV3zpkeVn6XAq?=
 =?us-ascii?q?+FLKPStkeF5vkxLOmIZY8Vviv9Kvc+6v7wgn82h0UdcbOq3ZQJcnC4GOppI0?=
 =?us-ascii?q?GDbXrrmNcBHjRCgg1rdOX3jBWnVjlJaj7mR6sh4hkjAZ+iSILEQZqgxreG2X?=
 =?us-ascii?q?HoMIdRYzV9Fl2UEXruP76BUvMIZTPadtRtiRQYRLOhTMknzhjouwjknek0Zt?=
 =?us-ascii?q?HI8zEV4MqwnON+4PfewFRrqG15?=
X-IPAS-Result: =?us-ascii?q?A2AMAAAt6Lpd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBaQYBAQELAYFuBSyBQTIqhCiII4h5iWOPNoF7CQEBAQEBAQEBATQBAgEBh?=
 =?us-ascii?q?EACg3QkNAkOAgwBAQEEAQEBAQEFAwEBbIVDgjspAYJtAQUjFUEQCxgCAiYCA?=
 =?us-ascii?q?lcGDQYCAQGCXz+CUyWxBYEyhU6DQoFIgQ4oAYpygR4YeIEHgREngms+h1WCX?=
 =?us-ascii?q?gSWOpc2gi6CM5J8BhuZYaoNOYFYKwgCGAghD4MnUBAUgxIXFY4qJQMwgQUBA?=
 =?us-ascii?q?Y1lAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 31 Oct 2019 14:01:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9VE1CdG025563;
        Thu, 31 Oct 2019 10:01:13 -0400
Subject: Re: [RFC PATCH] selinux: add SELinux hooks for lockdown integrity and
 confidentiality
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
References: <20191030131633.9356-1-sds@tycho.nsa.gov>
 <CAHC9VhQG=2VwJiM=LrZxZaSXWELbsu61pw2ynNgL0NAO+SvYMA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <de944969-6d9f-8fbd-ffe1-4f9bdd7410f2@tycho.nsa.gov>
Date:   Thu, 31 Oct 2019 10:01:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQG=2VwJiM=LrZxZaSXWELbsu61pw2ynNgL0NAO+SvYMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/31/19 5:59 AM, Paul Moore wrote:
> On Wed, Oct 30, 2019 at 9:16 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> Add SELinux access control hooks for lockdown integrity and
>> confidentiality. This effectively mimics the current implementation of
>> lockdown (caveat noted below). If lockdown is enabled alongside SELinux,
>> then the lockdown access control will take precedence over the SELinux
>> lockdown implementation.
>>
>> Note that this SELinux implementation allows the integrity and
>> confidentiality reasons to be controlled independently from one another.
>> Thus, in an SELinux policy, one could allow integrity operations while
>> blocking confidentiality operations.
>>
>> (original patch authored by an intern who wishes to remain anonymous;
>> I am signing off on his behalf)
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>   security/selinux/hooks.c            | 22 ++++++++++++++++++++++
>>   security/selinux/include/classmap.h |  2 ++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 36e531b91df2..6722c6b4ae74 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -91,6 +91,7 @@
>>   #include <uapi/linux/mount.h>
>>   #include <linux/fsnotify.h>
>>   #include <linux/fanotify.h>
>> +#include <linux/security.h>
>>
>>   #include "avc.h"
>>   #include "objsec.h"
>> @@ -6799,6 +6800,25 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
>>   }
>>   #endif
>>
>> +static int selinux_lockdown(enum lockdown_reason what)
>> +{
>> +       u32 sid = current_sid();
>> +
>> +       if (what <= LOCKDOWN_INTEGRITY_MAX)
>> +               return avc_has_perm(&selinux_state,
>> +                               sid, sid,
>> +                               SECCLASS_LOCKDOWN, LOCKDOWN__INTEGRITY, NULL);
>> +       else if (what <= LOCKDOWN_CONFIDENTIALITY_MAX)
>> +               return avc_has_perm(&selinux_state,
>> +                               sid, sid,
>> +                               SECCLASS_LOCKDOWN, LOCKDOWN__CONFIDENTIALITY,
>> +                               NULL);
>> +
>> +       /* invalid reason */
>> +       pr_warn("SELinux: invalid lockdown reason\n");
>> +       return -EPERM;
>> +}
> 
> I don't have any objections to adding a hook to control access to the
> lockdown functionality (I think it's a good idea), but I am a little
> nervous about the granularity of the control.  Sticking with just an
> integrity and a confidentiality permission seems okay, but I worry
> about adding additional permissions until we have a better idea of how
> the lockdown functionality is adopted by developers and we see how the
> lockdown_reason evolves.

Ok, so let's discuss what if anything else is needed for a final non-RFC 
version of this patch.

One thing that I wondered about was whether we ought to include the 
reason information in the audit record as supplemental data via a new 
LSM_AUDIT_DATA_* type for help in policy debugging / development. 
However, the lockdown_reasons[] string array is presently private to the 
lockdown module so we would have to export that or replicate it for 
creating a string representation of the reason if we were to do so. 
That would expose the reasons in terms of audit data but not as a basis 
for the permission check. Note that the lockdown module logs these 
reason strings via pr_notice() when it denies access, so it appears that 
exposing the strings as part of audit data would not introduce any extra 
kernel stable ABI guarantees?

I also wasn't sure about the pr_warn() above.  If we reach it, it is 
effectively a kernel bug. We could mirror what the lockdown module does 
in lockdown_is_locked_down(), i.e. use WARN() instead.  Of course, the 
SELinux hook won't even be reached in this case if the lockdown module 
is enabled, but the lockdown module could be disabled so I guess we need 
to check it too.

If we take the lockdown class with just integrity and confidentiality 
permissions now and later introduce finer granularity, we'll presumably 
need a policy capability to select whether the coarse-grained or 
fine-grained permissions are used.
