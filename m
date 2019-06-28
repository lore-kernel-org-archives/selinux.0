Return-Path: <SRS0=x6Ba=U3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430E5C4321A
	for <selinux@archiver.kernel.org>; Fri, 28 Jun 2019 18:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203AC205C9
	for <selinux@archiver.kernel.org>; Fri, 28 Jun 2019 18:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfF1SJ2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:09:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39175 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfF1SJ2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Jun 2019 14:09:28 -0400
Received: from static-50-53-46-226.bvtn.or.frontiernet.net ([50.53.46.226] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hgvIc-0001iH-2G; Fri, 28 Jun 2019 18:08:38 +0000
Subject: Re: [PATCH v4 15/23] LSM: Specify which LSM to display
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-16-casey@schaufler-ca.com>
 <89561452-86f9-fd9a-1390-0cd4bde1fd62@tycho.nsa.gov>
 <7944672e-a590-44a3-743a-48c1785a5464@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <16102220-d8bf-fb15-5298-8ebaa98543e2@canonical.com>
Date:   Fri, 28 Jun 2019 11:08:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <7944672e-a590-44a3-743a-48c1785a5464@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/28/19 9:15 AM, Casey Schaufler wrote:
> On 6/28/2019 7:45 AM, Stephen Smalley wrote:
>> On 6/26/19 3:22 PM, Casey Schaufler wrote:
>>> Create a new entry "display" in /proc/.../attr for controlling
>>> which LSM security information is displayed for a process.
>>> The name of an active LSM that supplies hooks for human readable
>>> data may be written to "display" to set the value. The name of
>>> the LSM currently in use can be read from "display".
>>> At this point there can only be one LSM capable of display
>>> active.
>>
>> IIUC, presently, at the end of the entire series,
>>
>> 1) Any process can change its display attribute to any enabled security module, and no security module can veto that change.
> 
> That is correct. If a security module could hoard the display it
> could prevent user space from functioning in a multiple module
> environment.
> 

It should be noted that this is also just for legacy, we agreed
last year that smack and apparmor would move to new none shared
interfaces by default, and ideally other LSMs would as well.
Smack has already added its process dir and apparmor has its
in apparmor-next

The display LSM allows for the current interfaces to be used
in a stacking situation for things like LSM in legacy container.

>> 2) The display attribute is inherited across fork and exec, even execs that change credentials, and again no security module has control over the inheritance of this attribute.
> 
> Also correct. Scripts don't work otherwise.
> 
>>
>> 3) Setting the display attribute affects more than just the contexts read or written by the process itself:
>> - Contexts reported in audit logs,
>> - Contexts passed across binder (generated in sender context, delivered to receiver),
>> - Contexts passed to NFS servers for new files,
>> - Contexts returned by NFS servers for existing files,
>> - Netlink-related contexts (?possibly generated in sender context rather than receiver context?),
>> - This list may not be complete.
> 
> Any of which can be changed should a more rational behavior be proposed.
> One possibility is to use lsm='value',lsm='value' encoding for internal
> communications, but there's been considerable resistance to anything
> like that.
> 

This is the part of the patchset that I am least happy with but
it is a hard problem, and so far using display has been the only
option that has been even sort of agreed to.


>> 4) A security_secid_to_secctx() in one process' context (e.g. sender) or with one display value followed later by a security_secctx_to_secid() call in a different process' context (e.g. receiver) or with a different display value may ask a different security module to perform the reverse translation of the context than the forward translation.
> 
> Do you have an example of where this might happen?
> Contexts are rarely used within the kernel. The usual
> behavior is to generate them, send them out to user space,
> and delete them. They get cached in some networking code,
> but not in cases where more than one (existing) security
> module will ever use them. Binder may be an exception, but
> only SELinux (currently) supports binder.
> 
> 
>> Is that correct?  If so, it seems problematic.
> 
> Balancing backward compatibility with new behavior is hard!
> What would you suggest for audit logs? Should we put all LSM
> data in every record?

If we could it would be better, but again how to do it. Every
option presented has been rejected.

> Is NFS a concern for anyone not using
> SELinux?
> 
Yes. Just because it isn't currently used doesn't mean it isn't
a concern or desired. 

> There is no user space that uses display, and it's going
> to take some time to work out all the kinks before we even
> think about teaching systemd about it.
> 

I'm not even sure we want to teach systemd et al. about it,
it would be far better to teach them about
  /proc/*/attr/{smack,apparmor,...}/*


But yes its going to take time to get the userspace updated.
