Return-Path: <SRS0=R+7g=WL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B96FC3A589
	for <selinux@archiver.kernel.org>; Thu, 15 Aug 2019 13:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1412083B
	for <selinux@archiver.kernel.org>; Thu, 15 Aug 2019 13:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ombG3rVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbfHONLN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:11:13 -0400
Received: from UCOL19PA35.eemsg.mail.mil ([214.24.24.195]:18350 "EHLO
        UCOL19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731282AbfHONLM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Aug 2019 09:11:12 -0400
X-EEMSG-check-017: 9917566|UCOL19PA35_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,389,1559520000"; 
   d="scan'208";a="9917566"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Aug 2019 13:10:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1565874611; x=1597410611;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CsgFPhyaaTYaMoquI7Vzspn/vm9NC5vDTwIw29i+C4k=;
  b=ombG3rVpNGcniGAfy43KxScEBfYVEOPFioEduNQ7pWBLmvCTgdUIgBca
   PqvuYj0yWph5vETishED9LNeid+URBwFVtrHdK1LzHOgwTAKn0jYANFki
   g2GvRzD3gQNqpgK2oo+cmv6qF0E3LNlIztRufAx+EbHuoCtiHTyHw3FB6
   DEwSUZUC//ApadpC5hv89/VcDS4BoelR0H8VmY9lB++5lLV5esTMRmnzU
   dE5Ukc85kC4caRdYeeiwfJnOLftivXLXG1tPBv74fmB0HBhqFtLi2wW5k
   I54/9zr71DH+0TeJoujkzFy0ExduVGWTkGVaZEgHP9Z67cH2BWW4syOdm
   A==;
X-IronPort-AV: E=Sophos;i="5.64,389,1559520000"; 
   d="scan'208";a="26824749"
IronPort-PHdr: =?us-ascii?q?9a23=3AgJd7ahJkAeChGtizwNmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKfvyrarrMEGX3/hxlliBBdydt6sezbON6uu9CSQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagf79+Ngi6oAvMusUZgYZvKbs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1YAqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1wavSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLNxEY1DQPFiVOQopHkMTOS1+QCrnaU7+59Xu+okWEotw5xoj+uxsgxlI?=
 =?us-ascii?q?bEnZ4Vy1DY+iV5x4Y5P9u4SFVhbtK+H5tQsD+aOpJwT8g/QG9ooD43xqAJtJ?=
 =?us-ascii?q?O0ZiQHyIkrywTBZ/GIbYSE+A/vWeCMKjlinn1lYqiwhxOq/Eilze3zS9e73U?=
 =?us-ascii?q?5RripAjtnMrncN1wHP6sSfSvty4EOh2TGX2gDP8O5EO0E0lbfAK5I73r4xlo?=
 =?us-ascii?q?YcsUTEHiPsnkX5kLSWeVk+9uit6uTnZq3qpp6aN4BqlgHzKrkil8OwDOgiMg?=
 =?us-ascii?q?UCQnKX9fqz2bH950H1Xa1GjvgsnanYtJDaK94bpqm8AwJNyIks9xm/DzCn0N?=
 =?us-ascii?q?sFg3YKN05FeRKbgIjpPFHCOvb4DeyljFi2nzdrwO7GMqX7AprRNnjDjKvhfb?=
 =?us-ascii?q?Fl5k5E0gUz0NRf6olMCr4bPfLzXlb9tNnfDh8+KQy73fzrB8l61oMbQWiPGL?=
 =?us-ascii?q?OWMLvOsV+U4eIiO/OMZIAOtzvmMfgq+ePhjX8jll8BZ6WmwZwXaHWgFPR8P0?=
 =?us-ascii?q?qZeWbsgssGEWoSuwo+S/bqiEGFUT5VYna/RL4z5jEhCIKhCIfDR52tgLmb0C?=
 =?us-ascii?q?e8BJ1WaXhMCkqQHnfwa4WER/AMZTqQIs9mkjwEU6KtS40m1RGurgD6zaFnIf?=
 =?us-ascii?q?TS+iADqZ3szt515+rVlREz6TN7FcCd33uRQGFzm2MCXyU207xnoUxh1leD1r?=
 =?us-ascii?q?B1g+dGGtxX5vNJVBo6NJHHwuxkBND9RBjBcs2KSFm4WNWmBy8+TtYrz98JeU?=
 =?us-ascii?q?Z9FM2ojgrf0CqyH78Vi7uLCYQ28qLZ2HjxPdx9y3fd1KQ6iVkpWM5POnOnhq?=
 =?us-ascii?q?Jl8AjTHYHJmV2Dl6m2baQcwDLN9GCbwGqKoUFYTAlwXL7fUnAafETZsc725l?=
 =?us-ascii?q?vDT7+yE7snNhFNycicJatWctfpl0lJRO//ONTCZGK8g2OwBReOxrORY4vmYn?=
 =?us-ascii?q?4d0zvBB0gZiQAT/GqGNAgnCiekpGLRESFuFVbxbE737+l+p220TlUuwwGJcU?=
 =?us-ascii?q?Jhzby19QARhfCGTPMTxL0Esj87qzpoBFa9w87WC92YqgplfaVcZ8494Vhe2W?=
 =?us-ascii?q?3DqgxyI52gL7x5i14EbQt4okPu2A9rColajccqq3YqxhJoKa2EyFNBay+Y3Z?=
 =?us-ascii?q?foN73MNGby5h+vZLDN11HeytmW/qMP6fQ+q1n5oA6pEU8ioD1b1Ixt2maYrr?=
 =?us-ascii?q?DNCxAfGcbpW1sz3wBzurWfZy46/Y6S3nppZ+38iSPPw9IkAqMezx+ke9pOeP?=
 =?us-ascii?q?efGBTaD9wRB8/oLvcj3VeucERXEvpV8fsdNtmhcbOp36+nMeIoyDutgmNG7I?=
 =?us-ascii?q?1VzlOH9y06TPXBmZkC3afLjUO8Sz7ggQL54YjMkodeaGRXRzHuxA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CaDwBIWFVd/wHyM5BlHAEBAQQBAQcEAQGBZ4FuKoE+A?=
 =?us-ascii?q?TIqhB+PDE0BAQEBAQEGgQktfohsigSFN4FnCQEBAQEBAQEBATQBAgEBhD8Cg?=
 =?us-ascii?q?xMjOBMCBAEBAQQBAQEDAQYDAQFshTOCOikBgmYBAQEBAyMEEUEQCxUDAgIRD?=
 =?us-ascii?q?gcCAlcGAQwGAgEBF4JIP4F3FKoFfzOFSIMrgUmBDCiLaRd4gQeBESeBVmA1P?=
 =?us-ascii?q?oN/JQEBXYJMglgElR6VQm0Jgh+LYIhNBhuCMIcwhBaKSC2NKpQshWchgVgrC?=
 =?us-ascii?q?AIYCCEPO4Jsgk4XFY4pIwMwgQYBAYtegkMBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Aug 2019 13:10:10 +0000
Received: from moss-callisto.infosec.tycho.ncsc.mil (moss-callisto [192.168.25.136])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7FDA8Wl005388;
        Thu, 15 Aug 2019 09:10:08 -0400
Subject: Re: [Non-DoD Source] Re: [RFC PATCH v2] security, capability: pass
 object information to security_capable
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Richard Guy Briggs <rgb@redhat.com>, mortonm@chromium.org,
        john.johansen@canonical.com, selinux@vger.kernel.org,
        James Morris <jmorris@namei.org>, luto@amacapital.net,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        Nicholas Franck <nhfran2@tycho.nsa.gov>,
        Serge Hallyn <serge@hallyn.com>
References: <20190801144313.1014-1-acgoide@tycho.nsa.gov>
 <CAHC9VhTSWiz45vh+M+sgu+ePwgFPZ4Mr8GmRZQjsGWQSzkjbLg@mail.gmail.com>
 <b79617aa-2b40-40bf-9f35-0f5be8e34d3f@tycho.nsa.gov>
 <20190813212710.wimxgfunrijqwuqt@madcap2.tricolour.ca>
 <CAHC9VhTWY4vtsmCn8X3TjR1HdsB1-wqBLs03vZVv0SmWQ-Ab2Q@mail.gmail.com>
 <b47e07bc-1b01-c5f0-305d-e6fe014b00d8@tycho.nsa.gov>
 <CAHC9VhRzz52bVwMikM7C65vCCSLb0=y1HtB50o-H0G3AMHqRNw@mail.gmail.com>
From:   Aaron Goidel <acgoide@tycho.nsa.gov>
Message-ID: <cb2833ee-3a12-9c7d-6c5b-c7944e74b3e9@tycho.nsa.gov>
Date:   Thu, 15 Aug 2019 09:10:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRzz52bVwMikM7C65vCCSLb0=y1HtB50o-H0G3AMHqRNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/14/19 5:27 PM, Paul Moore wrote:
> On Wed, Aug 14, 2019 at 5:08 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 8/14/19 3:59 PM, Paul Moore wrote:
>>> On Tue, Aug 13, 2019 at 5:27 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>>>> On 2019-08-13 11:01, Aaron Goidel wrote:
>>>>> On 8/8/19 12:30 PM, Paul Moore wrote:
>>>>>> On Thu, Aug 1, 2019 at 10:43 AM Aaron Goidel <acgoide@tycho.nsa.gov> wrote:
>>>>>>> From: Nicholas Franck <nhfran2@tycho.nsa.gov>
>>>>>>>
>>>>>>> At present security_capable does not pass any object information
>>>>>>> and therefore can neither audit the particular object nor take it
>>>>>>> into account. Augment the security_capable interface to support
>>>>>>> passing supplementary data. Use this facility initially to convey
>>>>>>> the inode for capability checks relevant to inodes. This only
>>>>>>> addresses capable_wrt_inode_uidgid calls; other capability checks
>>>>>>> relevant to inodes will be addressed in subsequent changes. In the
>>>>>>> future, this will be further extended to pass object information for
>>>>>>> other capability checks such as the target task for CAP_KILL.
>>>>>>>
>>>>>>> In SELinux this new information is leveraged here to include the inode
>>>>>>> in the audit message. In the future, it could also be used to perform
>>>>>>> a per inode capability checks.
>>>>>>>
>>>>>>> It would be possible to fold the existing opts argument into this new
>>>>>>> supplementary data structure. This was omitted from this change to
>>>>>>> minimize changes.
>>>>>>>
>>>>>>> Signed-off-by: Nicholas Franck <nhfran2@tycho.nsa.gov>
>>>>>>> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
>>>>>>> ---
>>>>>>> v2:
>>>>>>> - Changed order of audit prints so optional information comes second
>>>>>>> ---
>>>>>>>     include/linux/capability.h             |  7 ++++++
>>>>>>>     include/linux/lsm_audit.h              |  5 +++-
>>>>>>>     include/linux/lsm_hooks.h              |  3 ++-
>>>>>>>     include/linux/security.h               | 23 +++++++++++++-----
>>>>>>>     kernel/capability.c                    | 33 ++++++++++++++++++--------
>>>>>>>     kernel/seccomp.c                       |  2 +-
>>>>>>>     security/apparmor/capability.c         |  8 ++++---
>>>>>>>     security/apparmor/include/capability.h |  4 +++-
>>>>>>>     security/apparmor/ipc.c                |  2 +-
>>>>>>>     security/apparmor/lsm.c                |  5 ++--
>>>>>>>     security/apparmor/resource.c           |  2 +-
>>>>>>>     security/commoncap.c                   | 11 +++++----
>>>>>>>     security/lsm_audit.c                   | 21 ++++++++++++++--
>>>>>>>     security/safesetid/lsm.c               |  3 ++-
>>>>>>>     security/security.c                    |  5 ++--
>>>>>>>     security/selinux/hooks.c               | 20 +++++++++-------
>>>>>>>     security/smack/smack_access.c          |  2 +-
>>>>>>>     17 files changed, 110 insertions(+), 46 deletions(-)
>>>>>>
>>>>>> You should CC the linux-audit list, I've added them on this mail.
>>>>>>
>>>>>> I had hoped to see some thought put into the idea of dynamically
>>>>>> emitting the proper audit records as I mentioned in the previous patch
>>>>>> set, but regardless there are some comments on this code as written
>>>>>> ...
>>>>>>
>>>>>>> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
>>>>>>> index 33028c098ef3..18cc7c956b69 100644
>>>>>>> --- a/security/lsm_audit.c
>>>>>>> +++ b/security/lsm_audit.c
>>>>>>> @@ -229,9 +229,26 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>>>>>>>            case LSM_AUDIT_DATA_IPC:
>>>>>>>                    audit_log_format(ab, " key=%d ", a->u.ipc_id);
>>>>>>>                    break;
>>>>>>> -       case LSM_AUDIT_DATA_CAP:
>>>>>>> -               audit_log_format(ab, " capability=%d ", a->u.cap);
>>>>>>> +       case LSM_AUDIT_DATA_CAP: {
>>>>>>> +               const struct inode *inode;
>>>>>>> +
>>>>>>> +               audit_log_format(ab, " capability=%d ", a->u.cap_struct.cap);
>>>>>>> +               if (a->u.cap_struct.cad) {
>>>>>>> +                       switch (a->u.cap_struct.cad->type) {
>>>>>>> +                       case CAP_AUX_DATA_INODE: {
>>>>>>> +                               inode = a->u.cap_struct.cad->u.inode;
>>>>>>> +
>>>>>>> +                               audit_log_format(ab, " dev=");
>>>>>>> +                               audit_log_untrustedstring(ab,
>>>>>>> +                                       inode->i_sb->s_id);
>>>>>>> +                               audit_log_format(ab, " ino=%lu",
>>>>>>> +                                       inode->i_ino);
>>>>>>> +                               break;
>>>>>>> +                       }
>>>>>>
>>>>>> Since you are declaring "inode" further up, there doesn't appear to be
>>>>>> any need for the CAP_AUX_DATA_INODE braces, please remove them.
>>>>>>
>>>>>> The general recommended practice when it comes to "sometimes" fields
>>>>>> in an audit record, is to always record them in the record, but use a
>>>>>> value of "?" when there is nothing relevant to record.  For example,
>>>>>> when *not* recording inode information you would do something like the
>>>>>> following:
>>>>>>
>>>>>>      audit_log_format(ab, " dev=? ino=?");
>>>>>>
>>>>> The issue this brings up is what happens when this is expanded to more
>>>>> cases? Assuming there will be a case here for logging audit data for task
>>>>> based capabilities (CAP_AUX_DATA_TASK), what do we want to have happen if we
>>>>> are recording *neither* inode information nor task information (say a PID)?
>>>>> If we log something in the inode case, we presumably don't want to call
>>>>> audit_log_format(ab, " dev=?, pid=?") as well. (And vice versa for when we
>>>>> log a pid and no inode).
>>>>
>>>> Yup.  This record is already a mess due to that.
>>>>
>>>> The general solution is to either use a new record type for each
>>>> variant, or to use an auxiliary record for each additional piece of
>>>> information.  The long term solution that has been suggested it to move
>>>> away from a text message format.
>>>
>>> This is why I was suggesting that Aaron look into allowing the LSMs to
>>> request generation of audit records in the earlier thread (and
>>> mentioned it again at the top of my comments in this thread).
>>
>> How would that work? The behavior we want is to capture some information
>> about the inode whenever there is a capability denial upon an attempted
>> access to that inode.  Allowing the LSM to enable audit collection on a
>> per-process basis doesn't appear to help with that goal, because this is
>> something we want for all processes.  Further, we don't really want the
>> rest of the audit collection machinery engaged here ...
> 
> I read this as "we want to audit this information, but we don't to
> turn on the very thing which is designed to do this".  At some point,
> if you want to audit things, you actually need to turn on auditing.
> 
>> ... we just want the
>> inode information for this specific inode, and we have the inode readily
>> accessible in the caller of the LSM hook already, so we don't need to do
>> it earlier.
> 
> Aaron appeared to be complaining that if we stuck to the current best
> practices regarding record formatting for the LSM generated audit
> record, the record was going to get complicated when people started
> adding additional information.  FWIW, I don't disagree.  The only real
> alternative I've seen thus far is to look into having the LSM enable
> certain records, if anyone has another idea I'm all ears/eyes.
> 
>> Further, in the future we want to be able to take the inode security
>> label into consideration as part of the capability checking, which is
>> independent of audit entirely.  So the rest of the patch will still be
>> required even if the audit solution ends up being different.
> 
> That's a different topic, I don't think there are any remaining
> objections to passing the inode information here.
> 

I'm looking at how to enable LSMs to selectively turn on audit 
collection. So there seems to be two key points: audit_alloc() and 
__audit_syscall_entry(). Would it suffice to define a single boolean 
hook that takes the task and call it from both functions, to decide 
whether to override an AUDIT_DISABLED state in audit_alloc() and to 
override a 0 audit_n_rules in __audit_syscall_entry(). In audit_alloc() 
if audit_filter_task() returned AUDIT_DISABLED and the hook returned 
true, we would change the state to AUDIT_BUILD_CONTEXT. In 
__audit_syscall_entry(), if the hook returned true, we would set dummy 
to 0. Obviously, we could have a more general hook which lets us return 
arbitrary audit states, but, it isn't clear how we would reconcile 
conflicting results from audit_filter_task() and the hook for any 
situation other than AUDIT_DISABLED. We could also potentially use a 
different hook in __audit_syscall_entry(), though I don't think that we 
want the LSMs trying to interpret the syscall number or arguments.

Do you think that is sufficiently general or would you suggest something 
different?

-- 
Aaron
