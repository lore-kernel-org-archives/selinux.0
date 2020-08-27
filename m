Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C36C433DF
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 15:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45F02087D
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 15:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="K4EIZkC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgH0Py2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgH0PyZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 11:54:25 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3A3CC061264
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 08:54:24 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id A94A02A1007;
        Thu, 27 Aug 2020 17:54:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl A94A02A1007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1598543662;
        bh=PSyGfirpGLo6RGYoi0Fn5ww6nKIWGEYzLxwprkPKpb8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=K4EIZkC5wdSkqkpl/+tTxU3lzEvKfHduQccBZFXdd91EkGr/a+BBEJG819/ke6dGA
         9igAW0aIsChGk1cIoUX4xRgeS24skwylWsO3Fy0WqBK/9gou3rwPMxsVNLZ6rmLZU4
         YmH15Bx38ZdrX88Skl6DbgeGDQ1TBWYdjgZbMXQE=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Chris PeBenito <chpebeni@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: Userspace AVC auditing on policy load
References: <332168a5.dd08.174309a9344.Webtop.99@btinternet.com>
Date:   Thu, 27 Aug 2020 17:54:18 +0200
In-Reply-To: <332168a5.dd08.174309a9344.Webtop.99@btinternet.com> (Richard
        Haines's message of "Thu, 27 Aug 2020 16:47:50 +0100 (BST)")
Message-ID: <ypjl1rjsqe39.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Richard Haines <richard_c_haines@btinternet.com> writes:

> On Wed, 2020-08-26 at 15:15 -0400, Chris PeBenito wrote:
>> On 8/26/20 3:07 PM, Dominick Grift wrote:
>>> Chris PeBenito <chpebeni@linux.microsoft.com> writes:
>>>
>
>>>> On 8/26/20 10:46 AM, Stephen Smalley wrote:
>>>>> On Wed, Aug 26, 2020 at 10:35 AM Chris PeBenito
>>>>> <chpebeni@linux.microsoft.com> wrote:
>>>>>> On 8/26/20 9:25 AM, Chris PeBenito wrote:
>>>>>>> I was looking into this dbus-broker audit message, which
>>>>>>> has the wrong audit type:
>>>>>>>
>
>>>>>>> audit[422]: USER_AVC pid=422 uid=999 auid=4294967295
>>>>>>> ses=4294967295
>>>>>>> subj=system_u:system_r:system_dbusd_t msg='avc:  received
>>>>>>> policyload notice
>>>>>>> (seqno=2)
>>>>>>>
>
>>>>>>> This is due to dbus-broker setting their avc log callback
>>>>>>> to send USER_AVC audit
>>>>>>> messages for everything that comes to the libselinux log
>>>>>>> callback. I think the
>>>>>>> right thing to do there is to change it to emit
>>>>>>> USER_SELINUX_ERR audit messages
>>>>>>> if the log message is SELINUX_ERROR, otherwise log the
>>>>>>> message using their
>>>>>>> regular method (stderr I think).
>>>>>>>
>
>>>>>>> But the question became, why is the userspace AVC not
>>>>>>> simply emitting its own
>>>>>>> USER_MAC_POLICY_LOAD audit message instead of sending a
>>>>>>> message to the log
>>>>>>> callback?
>>>>>>
>
>>>>>> Ok, I missed that there is a SELINUX_AVC log type and that's
>>>>>> how the userspace
>>>>>> denial messages are sent out. How about adding
>>>>>> SELINUX_POLICYLOAD and
>>>>>> SELINUX_ENFORCE log types so that callers can emit
>>>>>> appropriate audit messages?
>>>>> Do we need two different new types or just one?  Otherwise, I
>>>>> don't
>>>>> have a problem with adding new ones as long as it doesn't break
>>>>> existing applications.
>>>>
>
>>>> Regarding the risk of breaking existing applications, I did some
>>>> checking on some userspace AVC users and what they do in their
>>>> log
>>>> callback:
>>>>
>
>>>> * systemd only audits SELINUX_AVC and SELINUX_ERROR messages and
>>>>    ignores others(as Petr noted)
>>>> * xorg-server audits SELINUX_AVC correctly but audits
>>>> SELINUX_INFO as
>>>>    USER_MAC_POLICY_LOAD and everything else it ignores the type
>>>> and
>>>>   audits as AUDIT_USER_SELINUX_ERR
>>>> * dbus-broker ignores type and audits everything as USER_AVC
>>>> * dbus-service ignores type and audits everything as USER AVC
>>>> * pam: pam_rootok ignores type and audits everything as USER_AVC
>>>> * sepgsql custom AVC implementation (this was news to me)
>>>> * shadow-utils only audits SELINUX_AVC and SELINUX_ERROR messages
>>>> and
>>>>    others go to syslog
>>>> * cronie: no callback set
>>>>
>
>>>> That's all the ones I could think of.  Which ones am I missing?
>>>
>
>>> Probably libreswan, AFAIK that one might also still be using
>>> avc_has_perm() instead of selinux_check_access().
>>
>
>> You're correct, it is still use avc_has_perm().  There is no log
>> callback set here.
>>
>
> ipsec-tools (racoon) is another. I did patches for this and LibreSwan
> a few years ago, they never went far:
>
> ipsec-tools:
> https://marc.info/?l=ipsec-tools-devel&m=149441917501329&w=2
> LibreSwan:
> https://lists.libreswan.org/pipermail/swan-dev/2017-May/001860.html
>
>

Looking at the libreswan thread, the situation changed significantly
since avc_has_perm() is just no longer supported AFAIK. So labeled-ipsec
is currently just broken. Also RHEL6 is EOL so that should not be an
issue.

Maybe it is possible to revive that thread?

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
