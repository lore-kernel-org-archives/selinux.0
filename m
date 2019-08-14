Return-Path: <SRS0=pl+I=WK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45E5C32753
	for <selinux@archiver.kernel.org>; Wed, 14 Aug 2019 21:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1B92133F
	for <selinux@archiver.kernel.org>; Wed, 14 Aug 2019 21:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="d4THLmHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfHNVIh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Aug 2019 17:08:37 -0400
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:59517 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfHNVIg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Aug 2019 17:08:36 -0400
X-EEMSG-check-017: 5256479|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,386,1559520000"; 
   d="scan'208";a="5256479"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Aug 2019 21:08:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1565816903; x=1597352903;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=19fficksSkuDhgBYnEeD9fTPuiTQtFLT58RRdoEUdz0=;
  b=d4THLmHTELOnH0RtF/a0j33tqBouxyfhIn4LoKdYgM+FT8zDOKHAbQVZ
   X48uVayhmelrBfrviOIlEjUaORjWBU4q8KuJAp/ea0QEdMTp5d0WCL1Mg
   oPa/fwE1AzTPrVzxdYb0o/ivD6HU7XGSeC1+wr+4vlBLac8YqXQZrIy5A
   fHSP76KYdXYKAJxWOi51rvnVitvvcPfQq+zDzc9ltmMcWVM0I3i9n/5tw
   R2rlOcQItGOSlkHPbFwDP2zgmckCWRTxXr724JqBV9KYTKBicw/ftm5Fw
   WjwAalE8oBo5E7/xkOJN4BJaufXUs+Pu/uDfgbKQ/Xwi3cGW6T5r7pB6m
   w==;
X-IronPort-AV: E=Sophos;i="5.64,386,1559520000"; 
   d="scan'208";a="26807048"
IronPort-PHdr: =?us-ascii?q?9a23=3AMmlxshf4pJe0Qak94Wh1HYLHlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc2+ZBKN2/xhgRfzUJnB7Loc0qyK6vqmADZRqsfa+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAiooQnLq8Uan49vJqk1xx?=
 =?us-ascii?q?bHv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4yydYsPC/cKM/heoYfzulACqQKyCAeoCe/qzDJDm3340rAg0+?=
 =?us-ascii?q?k5DA/IwgIgEdINvnraotr6O6UdXvy6wqTT0TXObelb1Svh5IXGcB0sp+yHU7?=
 =?us-ascii?q?JqccrWzEkiDx7LjkmOpoz9PzOayOINuHWG4eplT+2vj2onpB9xozOywcoskZ?=
 =?us-ascii?q?TGhpkOx1DY9SR23IY1JdqiRE59et6rCoFcty6dN4toW84vRXxjtiUiyrAepJ?=
 =?us-ascii?q?K2cycHxI4nyhLCcfCLbYeF7gz5WOqMJzpzmWhrd6ilhxmo9Eit0uj8Vs6p31?=
 =?us-ascii?q?lUtidFidzMtmwV1xzU98iHVuNx/ke/1jaL0ADe8v1ELloularaNp4h2aQ8lo?=
 =?us-ascii?q?YTsEvfHi/2n1/6jKmKeUU/5uek8eHnYrTippOENo90jB/xMrg2l8CiDuk1PR?=
 =?us-ascii?q?ICUmiG9eimyrHu8lP1TK9XgvEul6nWqpHaJcAVpq6jBA9V154u6w2iADe9y9?=
 =?us-ascii?q?kYgXkGI05FeBKAlYTpPUrOL+riAfewhFSsji9nx+raMb35HpXNMn/Dna/5fb?=
 =?us-ascii?q?ln9k5czBE+zchF6JJJDrENOffzWkj2tNzCEBA1KRC7w+HiCN9lzIMRRXqPAr?=
 =?us-ascii?q?OFMKPVqVKI/O0vLPKXaY8PpjnyNvgl6OTyjXMjhVAdeqyp14MNaH+kBvRmP1?=
 =?us-ascii?q?mZYX30j9cEFmcKpBY+TOvsiF2HSjNce3ayX7g75jE+CYKmEILDSpqqgLyb0y?=
 =?us-ascii?q?exBodWaXxeClCQDXfocJ2JW/ULaCKSJM9tiD4EVb+hS4A70xGurxH1y7x8I+?=
 =?us-ascii?q?XI4CIYs5Xj1N505+LPjx4y8SZ4ANia02GIV2t0hH8HRycq3KBjpkxw0kyD3r?=
 =?us-ascii?q?Z8g/xZE9xT+vxIXxwkNZ7T0eN6Ecr+WgHfcdeTTlapXNGmDSs2TtIrzN8Ee1?=
 =?us-ascii?q?x9FMm6jhDfwyqqBKcYl76OBJwz6KLcxXnxJ91mxnbAzqYhikcpQspVOW2hnK?=
 =?us-ascii?q?5/+BDZB5TVnEWBi6aqaaMc0TbJ9Gee0WqOu1pVXxR1UarfQX8QfFPWrdXl5k?=
 =?us-ascii?q?zYS7+iE7InPRVdycSaMKtFdsXpjUlaRPfkINneZ2Oxm2GtBReH37+Md5TldH?=
 =?us-ascii?q?kA3CXHCUgEjwAS8W+DNQg5GyihvmbeAyJ1GFLxbEPj7/N+pGm4TkAq1QGKaV?=
 =?us-ascii?q?Nu176v9h4Sn/ycROsZ3qgYtyc5tzV0AFG90srSC9qBoQphYapdbcon71dayG?=
 =?us-ascii?q?3ZthB9M4e6L698m1Eecx54v1/02xprDYVAlNAgrGk2wwpqNaKYzFRBeiuD3Z?=
 =?us-ascii?q?/uIL3XJXf98Quva6HM3lHe1NaX+qEV5PskrFXjuVLhKk13y3x615Fw1HyG69?=
 =?us-ascii?q?2eFAMPVbrpW1szsh19oKvXJCI64tWQnUdtOqm9qDOK9M84TME/yxmvZJ8LKq?=
 =?us-ascii?q?yOPBX/H80TG46lL+l83xCAZwgDOqh98684MsfuI/KN16mqMOtIgCOtjWMB5p?=
 =?us-ascii?q?t0lE2L6XwvZPTP2sM+3/yA3gaBHwz5hVOlv9G/zZtIfhkOD2G/zm7iH4cXaa?=
 =?us-ascii?q?psK9VYQVyyKtG6k40tz6XmXGRVoRv6XAIL?=
X-IPAS-Result: =?us-ascii?q?A2AJDwC2d1Rd/wHyM5BmHAEBAQQBAQcEAQGBZ4FuKoE/M?=
 =?us-ascii?q?iqEHo8MTQEBAQEBAQaBCS2JaooEhTeBZwkBAQEBAQEBAQE0AQIBAYQ/AoMNI?=
 =?us-ascii?q?zgTAgQBAQEEAQEBAwEGAwEBbIUzgjopAYJmAQEBAQMjBBFBEAsVAwICERUCA?=
 =?us-ascii?q?lcGAQwGAgEBF4JIP4F3FKsgfzOFSIMsgUmBDCiLaRd4gQeBOIFWYDU+g38lA?=
 =?us-ascii?q?QFdgkyCWASVHpVCbQmCH4IhiT+ITQYbgjCHL45eLY0qmhIhgVgrCAIYCCEPO?=
 =?us-ascii?q?4Jsgk4XFY4pIwMwgQYBAYt5gkMBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Aug 2019 21:08:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7EL8GR5016120;
        Wed, 14 Aug 2019 17:08:17 -0400
Subject: Re: [RFC PATCH v2] security, capability: pass object information to
 security_capable
To:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>
Cc:     mortonm@chromium.org, john.johansen@canonical.com,
        selinux@vger.kernel.org, James Morris <jmorris@namei.org>,
        luto@amacapital.net, linux-security-module@vger.kernel.org,
        linux-audit@redhat.com, Nicholas Franck <nhfran2@tycho.nsa.gov>,
        Serge Hallyn <serge@hallyn.com>
References: <20190801144313.1014-1-acgoide@tycho.nsa.gov>
 <CAHC9VhTSWiz45vh+M+sgu+ePwgFPZ4Mr8GmRZQjsGWQSzkjbLg@mail.gmail.com>
 <b79617aa-2b40-40bf-9f35-0f5be8e34d3f@tycho.nsa.gov>
 <20190813212710.wimxgfunrijqwuqt@madcap2.tricolour.ca>
 <CAHC9VhTWY4vtsmCn8X3TjR1HdsB1-wqBLs03vZVv0SmWQ-Ab2Q@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b47e07bc-1b01-c5f0-305d-e6fe014b00d8@tycho.nsa.gov>
Date:   Wed, 14 Aug 2019 17:08:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTWY4vtsmCn8X3TjR1HdsB1-wqBLs03vZVv0SmWQ-Ab2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/14/19 3:59 PM, Paul Moore wrote:
> On Tue, Aug 13, 2019 at 5:27 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>> On 2019-08-13 11:01, Aaron Goidel wrote:
>>> On 8/8/19 12:30 PM, Paul Moore wrote:
>>>> On Thu, Aug 1, 2019 at 10:43 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
>>>>> From: Nicholas Franck <nhfran2@tycho.nsa.gov>
>>>>>
>>>>> At present security_capable does not pass any object information
>>>>> and therefore can neither audit the particular object nor take it
>>>>> into account. Augment the security_capable interface to support
>>>>> passing supplementary data. Use this facility initially to convey
>>>>> the inode for capability checks relevant to inodes. This only
>>>>> addresses capable_wrt_inode_uidgid calls; other capability checks
>>>>> relevant to inodes will be addressed in subsequent changes. In the
>>>>> future, this will be further extended to pass object information for
>>>>> other capability checks such as the target task for CAP_KILL.
>>>>>
>>>>> In SELinux this new information is leveraged here to include the inode
>>>>> in the audit message. In the future, it could also be used to perform
>>>>> a per inode capability checks.
>>>>>
>>>>> It would be possible to fold the existing opts argument into this new
>>>>> supplementary data structure. This was omitted from this change to
>>>>> minimize changes.
>>>>>
>>>>> Signed-off-by: Nicholas Franck <nhfran2@tycho.nsa.gov>
>>>>> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
>>>>> ---
>>>>> v2:
>>>>> - Changed order of audit prints so optional information comes second
>>>>> ---
>>>>>    include/linux/capability.h             |  7 ++++++
>>>>>    include/linux/lsm_audit.h              |  5 +++-
>>>>>    include/linux/lsm_hooks.h              |  3 ++-
>>>>>    include/linux/security.h               | 23 +++++++++++++-----
>>>>>    kernel/capability.c                    | 33 ++++++++++++++++++--------
>>>>>    kernel/seccomp.c                       |  2 +-
>>>>>    security/apparmor/capability.c         |  8 ++++---
>>>>>    security/apparmor/include/capability.h |  4 +++-
>>>>>    security/apparmor/ipc.c                |  2 +-
>>>>>    security/apparmor/lsm.c                |  5 ++--
>>>>>    security/apparmor/resource.c           |  2 +-
>>>>>    security/commoncap.c                   | 11 +++++----
>>>>>    security/lsm_audit.c                   | 21 ++++++++++++++--
>>>>>    security/safesetid/lsm.c               |  3 ++-
>>>>>    security/security.c                    |  5 ++--
>>>>>    security/selinux/hooks.c               | 20 +++++++++-------
>>>>>    security/smack/smack_access.c          |  2 +-
>>>>>    17 files changed, 110 insertions(+), 46 deletions(-)
>>>>
>>>> You should CC the linux-audit list, I've added them on this mail.
>>>>
>>>> I had hoped to see some thought put into the idea of dynamically
>>>> emitting the proper audit records as I mentioned in the previous patch
>>>> set, but regardless there are some comments on this code as written
>>>> ...
>>>>
>>>>> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
>>>>> index 33028c098ef3..18cc7c956b69 100644
>>>>> --- a/security/lsm_audit.c
>>>>> +++ b/security/lsm_audit.c
>>>>> @@ -229,9 +229,26 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>>>>>           case LSM_AUDIT_DATA_IPC:
>>>>>                   audit_log_format(ab, " key=%d ", a->u.ipc_id);
>>>>>                   break;
>>>>> -       case LSM_AUDIT_DATA_CAP:
>>>>> -               audit_log_format(ab, " capability=%d ", a->u.cap);
>>>>> +       case LSM_AUDIT_DATA_CAP: {
>>>>> +               const struct inode *inode;
>>>>> +
>>>>> +               audit_log_format(ab, " capability=%d ", a->u.cap_struct.cap);
>>>>> +               if (a->u.cap_struct.cad) {
>>>>> +                       switch (a->u.cap_struct.cad->type) {
>>>>> +                       case CAP_AUX_DATA_INODE: {
>>>>> +                               inode = a->u.cap_struct.cad->u.inode;
>>>>> +
>>>>> +                               audit_log_format(ab, " dev=");
>>>>> +                               audit_log_untrustedstring(ab,
>>>>> +                                       inode->i_sb->s_id);
>>>>> +                               audit_log_format(ab, " ino=%lu",
>>>>> +                                       inode->i_ino);
>>>>> +                               break;
>>>>> +                       }
>>>>
>>>> Since you are declaring "inode" further up, there doesn't appear to be
>>>> any need for the CAP_AUX_DATA_INODE braces, please remove them.
>>>>
>>>> The general recommended practice when it comes to "sometimes" fields
>>>> in an audit record, is to always record them in the record, but use a
>>>> value of "?" when there is nothing relevant to record.  For example,
>>>> when *not* recording inode information you would do something like the
>>>> following:
>>>>
>>>>     audit_log_format(ab, " dev=? ino=?");
>>>>
>>> The issue this brings up is what happens when this is expanded to more
>>> cases? Assuming there will be a case here for logging audit data for task
>>> based capabilities (CAP_AUX_DATA_TASK), what do we want to have happen if we
>>> are recording *neither* inode information nor task information (say a PID)?
>>> If we log something in the inode case, we presumably don't want to call
>>> audit_log_format(ab, " dev=?, pid=?") as well. (And vice versa for when we
>>> log a pid and no inode).
>>
>> Yup.  This record is already a mess due to that.
>>
>> The general solution is to either use a new record type for each
>> variant, or to use an auxiliary record for each additional piece of
>> information.  The long term solution that has been suggested it to move
>> away from a text message format.
> 
> This is why I was suggesting that Aaron look into allowing the LSMs to
> request generation of audit records in the earlier thread (and
> mentioned it again at the top of my comments in this thread).

How would that work? The behavior we want is to capture some information 
about the inode whenever there is a capability denial upon an attempted 
access to that inode.  Allowing the LSM to enable audit collection on a 
per-process basis doesn't appear to help with that goal, because this is 
something we want for all processes.  Further, we don't really want the 
rest of the audit collection machinery engaged here; we just want the 
inode information for this specific inode, and we have the inode readily 
accessible in the caller of the LSM hook already, so we don't need to do 
it earlier.

Further, in the future we want to be able to take the inode security 
label into consideration as part of the capability checking, which is 
independent of audit entirely.  So the rest of the patch will still be 
required even if the audit solution ends up being different.
