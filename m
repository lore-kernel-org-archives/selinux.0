Return-Path: <SRS0=s7s9=A3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7001DC433EB
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 19:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413F32076A
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 19:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PGufXFeu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgGPTNS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:13:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37646 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgGPTNR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jul 2020 15:13:17 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 48ED520B4909;
        Thu, 16 Jul 2020 12:13:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 48ED520B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594926796;
        bh=rJqLOziw2osdo15zsPugmz5im9Pv3tHMh1e9Igalmc8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PGufXFeubXILzI0FUQYAfve2Zm8SYb5HgltkEq/48sHn2lOJrw9tjMaDwamk2KUwH
         Cvqy9knLTQLdB4ki88SmMf51+IUaUfxuVvU66AMpz88PvI7qs6iP3qmxOL01T0Cdh3
         A72XDO/LEcgBDQd+QQHQg57Suwx/P+jSdqJg7cYA=
Subject: Re: [PATCH v2 4/5] LSM: Define SELinux function to measure security
 state
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200716174351.20128-1-nramas@linux.microsoft.com>
 <20200716174351.20128-5-nramas@linux.microsoft.com>
 <CAEjxPJ43eXK0xgrE=gDxZVg2SDTz4bkd7N4otjk-cvxf3fKL-g@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9478ddca-8298-5170-836d-8cbc7a070df2@linux.microsoft.com>
Date:   Thu, 16 Jul 2020 12:13:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ43eXK0xgrE=gDxZVg2SDTz4bkd7N4otjk-cvxf3fKL-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/16/20 11:54 AM, Stephen Smalley wrote:

>> The data for selinux-state in the above measurement is:
>> enabled=1;enforcing=0;checkreqprot=1;network_peer_controls=1;open_perms=1;extended_socket_class=1;always_check_network=0;cgroup_seclabel=1;nnp_nosuid_transition=1;genfs_seclabel_symlinks=0;
>>
>> The data for selinux-policy-hash in the above measurement is
>> the SHA256 hash of the SELinux policy.
> 
> Can you show an example of how to verify that the above measurement
> matches a given state and policy, e.g. the sha256sum commands and
> inputs to reproduce the same from an expected state and policy?
Sure - I'll provide an example.

>> +/* Pre-allocated buffer used for measuring state */
>> +static char *selinux_state_string;
>> +static size_t selinux_state_string_len;
>> +static char *selinux_state_string_fmt =
>> +       "%s=%d;%s=%d;%s=%d;%s=%d;%s=%d;%s=%d;%s=%d;%s=%d;%s=%d;%s=%d;";
>> +
>> +void __init selinux_init_measurement(void)
>> +{
>> +       selinux_state_string_len =
>> +       snprintf(NULL, 0, selinux_state_string_fmt,
>> +       "enabled", 0,
>> +       "enforcing", 0,
>> +       "checkreqprot", 0,
>> +       selinux_policycap_names[POLICYDB_CAPABILITY_NETPEER], 0,
>> +       selinux_policycap_names[POLICYDB_CAPABILITY_OPENPERM], 0,
>> +       selinux_policycap_names[POLICYDB_CAPABILITY_EXTSOCKCLASS], 0,
>> +       selinux_policycap_names[POLICYDB_CAPABILITY_ALWAYSNETWORK], 0,
>> +       selinux_policycap_names[POLICYDB_CAPABILITY_CGROUPSECLABEL], 0,
>> +       selinux_policycap_names[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION], 0,
>> +       selinux_policycap_names[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS],
>> +       0);
> 
> I was thinking you'd dynamically construct the format string with a
> for loop from 0 to POLICYDB_CAPABILITY_MAX
> and likewise for the values so that we wouldn't have to patch this
> code every time we add a new one.
That's a good point - will do.

> 
>> +
>> +       if (selinux_state_string_len < 0)
>> +               return;
> 
> How can this happen legitimately (i.e. as a result of something other
> than a kernel bug)?
Since snprintf can return an error I wanted to handle that. But I agree 
this should not happen for the input data to snprintf used here.

> 
>> +
>> +       ++selinux_state_string_len;
>> +
>> +       selinux_state_string = kzalloc(selinux_state_string_len, GFP_KERNEL);
>> +       if (!selinux_state_string)
>> +               selinux_state_string_len = 0;
>> +}
> 
> Not sure about this error handling approach (silent, proceeding as if
> the length was zero and then later failing with ENOMEM on every
> attempt?). I'd be more inclined to panic/BUG here but I know Linus
> doesn't like that.
I am not sure if failing (kernel panic/BUG) to "measure" LSM data under 
memory pressure conditions is the right thing. But I am open to treating 
this error as a fatal error. Please let me know.

> 
>> +       if (ret)
>> +               pr_err("%s: error %d\n", __func__, ret);
> 
> This doesn't seem terribly useful as an error message; I'd be inclined
> to drop it.
> 
Will do.

thanks,
  -lakshmi

