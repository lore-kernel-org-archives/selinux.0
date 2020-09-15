Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0307C43461
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 23:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7C520715
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 23:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aFqX8INS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgIOXox (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 19:44:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53852 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgIOOdp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 10:33:45 -0400
Received: from chpebeni.northamerica.corp.microsoft.com (pool-108-15-23-247.bltmmd.fios.verizon.net [108.15.23.247])
        by linux.microsoft.com (Postfix) with ESMTPSA id 443CE208971C;
        Tue, 15 Sep 2020 07:33:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 443CE208971C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600180424;
        bh=tm4e9jBT8cB/ndPVVcoJytzYAoNftLas9+L46ZclHrs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aFqX8INSBuUiKDfLYuN4z/nBcTnHfm2lAlLoaNnR27cjr3zaZbegS+c4/6w94sSlc
         OXO/qSHRFVNHXl54ZfGpnn8X1JpbpV+8lovBCkkPyfMMJLpFe3CuSp5tm3iltMMXen
         pSHzBsi5ZobWC/YqR0V4cIZOa/lUyHrFekkeruus=
Subject: Re: [RFC PATCH 1/1] libselinux: Revise userspace AVC avc_log() for
 auditable events.
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Steve Grubb <sgrubb@redhat.com>
References: <20200915130516.561693-1-chpebeni@linux.microsoft.com>
 <CAEjxPJ77s7WHqixbD60LnEOG_+WYc2mOj0cTPMoKXqk8M5zqBg@mail.gmail.com>
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
Message-ID: <6bff0d2f-5e33-213f-dfe5-e3af01474860@linux.microsoft.com>
Date:   Tue, 15 Sep 2020 10:33:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ77s7WHqixbD60LnEOG_+WYc2mOj0cTPMoKXqk8M5zqBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/15/20 9:34 AM, Stephen Smalley wrote:
> On Tue, Sep 15, 2020 at 9:11 AM Chris PeBenito
> <chpebeni@linux.microsoft.com> wrote:
>>
>> I put up a PR for dbus-broker to revise its auditing:
>>
>> https://github.com/bus1/dbus-broker/pull/240
>>
>> Steve Grubb mentioned that there wasn't much useful info in terms of the audit
>> message itself, since it isn't key:value pairs.
> 
> Does that matter since it is all just stuffed as a string value for
> the msg= field?
> 
>> I'm looking to revise the avc_log() messages for SELINUX_ERROR,
>> SELINUX_SETENFORCE, and SELINUX_POLICYLOAD messages such that they
>> more closely reseble the kernel audits.
>>
>> *This patch is _incomplete*; I implemented a few changes to get early feedback
>> on the direction I'm taking.  What seems potentially contentious is the
>> 'lsm=selinux_uavc' and op= choices.
> 
> Yes, I don't see the point of using a different lsm= value than just
> "selinux"; the fact that it is a userspace event should get reflected
> in some other way, right?

Fair point.  It's reflected in USER_MAC_POLICY_LOAD instead of MAC_POLICY_LOAD, 
as an example.


>> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
>> index 572b2159..35ea59b6 100644
>> --- a/libselinux/src/avc_internal.c
>> +++ b/libselinux/src/avc_internal.c
>> @@ -59,14 +59,14 @@ int avc_process_setenforce(int enforcing)
>>          int rc = 0;
>>
>>          avc_log(SELINUX_SETENFORCE,
>> -               "%s:  received setenforce notice (enforcing=%d)\n",
>> +               "%s:  op=setenforce lsm=selinux_uavc enforcing=%d res=1",
>>                  avc_prefix, enforcing);
>>          if (avc_setenforce)
>>                  goto out;
>>          avc_enforcing = enforcing;
>>          if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
>>                  avc_log(SELINUX_ERROR,
>> -                       "%s:  cache reset returned %d (errno %d)\n",
>> +                       "%s:  op=cache_reset lsm=selinux_uavc rc=%d errno=%d res=0",
>>                          avc_prefix, rc, errno);
> 
> If we do this at all, I would think the op= would still be setenforce
> and this would just be an error for it.

At this point we already audited success for the setenforce operation.  Wouldn't 
it be confusing to have a op=setenforce res=1 and then immediately op=setenforce 
res=0?

> Looking at the kernel, we aren't even checking avc_ss_reset() for
> failure and none of the kernel avc callbacks ever return an error.

I'm not deeply familiar with the AVC intricacies.  If the cache fails to clear, 
then there could be wrong cache entries, no?  If so, I would argue that it's 
worthy of an audit.  If not, then I agree that it's not auditable.


>> @@ -157,7 +157,7 @@ static int avc_netlink_receive(void *buf, unsigned buflen, int blocking)
>>                  return -1;
>>          }
>>          else if (rc < 1) {
>> -               avc_log(SELINUX_ERROR, "%s:  netlink poll: error %d\n",
>> +               avc_log(SELINUX_ERROR, "%s:  op=netlink_poll lsm=selinux_uavc errno=%d res=0",
>>                          avc_prefix, errno);
>>                  return rc;
>>          }
> 
> Not sure what to do with these; arguably they aren't audit events at
> all, just error logging.

Perhaps the question is: are any of SELINUX_ERROR actually auditable?  If so, it 
would seem the answer is to either add another log level for auditable errors. 
If not, then the few UAVC users that audit SELINUX_ERROR need to be fixed. 
Alternatively we could change these non-auditable SELINUX_ERRORs to 
SELINUX_WARNING, since admins can't do much about these in most (all?) cases.


Maybe we should add a log callback function to libselinux that UAVC users could 
optionally use.  It would audit where appropriate and otherwise syslog/stderr 
the message.  That would provide an upgrade path for consistent auditing while 
still allowing UAVC users the option to handle the log callback another way when 
desired.  A another option would be to introduce a new callback specifically for 
auditing.

-- 
Chris PeBenito
