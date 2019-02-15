Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD93FC43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 19:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE93222A1
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 19:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="eyOoX5ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfBOTaS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:30:18 -0500
Received: from uphb19pa13.eemsg.mail.mil ([214.24.26.87]:11099 "EHLO
        usfb19pa16.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730282AbfBOTaR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 14:30:17 -0500
X-EEMSG-check-017: 167004863|USFB19PA16_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa16.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Feb 2019 19:30:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550259014; x=1581795014;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=T+w/05GxMfh7cO5j7vR8eFOIBd989JKKfJbAuAZNMUc=;
  b=eyOoX5kekiRbmnNHQ3Wir3lD5pPy7b8GKpcXAvcHqaYSVo1oxC/9TDT9
   zm4SkUnA3CNguK7za6dj2rYpJZXpzB26lzuw4AZ+y1Sz8tSQ2vd9L7Ypz
   xLS9S+lUt1uo9DryNEziFIb+2COgA5FGnpGnVtEVzJn2NFqwfIVcctA95
   cb9xo6M92gYbBs/2mw6aSx9NjzBH39lUJCuadNbb3cT7j/PzjG4/iCLk0
   rQWkANbf7+bQ0B4/EKiBlDXo5SkapesEetMlS0+cpkT0yfBwJTtmfI6aF
   Ii6Ngc4jgKgtGXQh0VohxA1tdL/MLLOgubvU/kT5Afja9I6PTNj4gPmDk
   A==;
X-IronPort-AV: E=Sophos;i="5.58,373,1544486400"; 
   d="scan'208";a="23997219"
IronPort-PHdr: =?us-ascii?q?9a23=3AjNZxxxBkIHvQClfUbjsdUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPXzocbcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEvYNMeNeooLgpVUBsAG+CBGxCu3xxD9Ghnz406M03O?=
 =?us-ascii?q?suEw7JwAMuEskSsHnWttj5KLseXO63waTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqHpxQtySAOIt3RMMvW25ouCcmyr0GpJ?=
 =?us-ascii?q?60ZzIGx4ggxx7abfGMbouG4gr7WeqMLjp1i2hpdbKiixqo70StxfPwWtOp3F?=
 =?us-ascii?q?tMsyFLiMPDtmoX2BzW8sWHT/x98Vq/1juXzADT7/1EIVgzlarGN54t2r4wmY?=
 =?us-ascii?q?QXsUTEBiL2hF/5jLWXdkU54eik8fjnY7X6qZ+cMI94kAf+Pbg1msOjG+g4Nw?=
 =?us-ascii?q?kOX2yD9eS90r3s41H5Ta1XgvA5naTVqpDXKdkBqqKnDAJZzJwv5wunAzejyt?=
 =?us-ascii?q?sYnH0HLFxfeBKAiojkI0rOL+3jDfqkn1StkCtkx/DBPrH7BJXNNWLMnK3ufb?=
 =?us-ascii?q?Z69U5Q0BAzwsxH55JIFrEBJ+r+VVLru9PEFBM5NBK0zPj9CNVn14MRRHyAD7?=
 =?us-ascii?q?SWMKPXq1CI5+YvL/OQa48SvTb3M+Il6OL2jX8lhV8derGk3YMNZ3ClGvRrOF?=
 =?us-ascii?q?2ZbmDxgtcFCGsKuw0+TOvwiFKcSzJce3GyX6ck7DEhFI2mFZvDRpyqgLGZxy?=
 =?us-ascii?q?e0AJlWZmFAClCRHnblbJuEW/gSZyKIOMNhkSILVaKnS4A/0RGirgj6y6BoLr?=
 =?us-ascii?q?mcxipNmZXm1d507O6bugsz+yA8W8iU2CeKUWxuhGIEShc52al+pQp2zVLVle?=
 =?us-ascii?q?BAiuFcXflU4OlEGlMiPIPY5/RzFtS3XwXGZNrPQ1GjFIaIGzY0G+ktzscObk?=
 =?us-ascii?q?A1INCrihTOzmL+GLMOv6CaD5wztKTH1j7+INgrmCWO77Uok1RzGpgHDmahnK?=
 =?us-ascii?q?MqslGKX4M=3D?=
X-IPAS-Result: =?us-ascii?q?A2CdAABLEmdc/wHyM5BkGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFZKWeBAyeEBpRLAQEBAQEBBoEICCWJKw6QWTAIAYRAAoNqIjcGDQEDA?=
 =?us-ascii?q?QEBAQEBAgFsHAyCOikBgmcBBQ4VFS0PBRALDgoCAiYCAiE2BgEMBgIBAYJfP?=
 =?us-ascii?q?QGBWgMIDQ+sRYEvhUSCQQ2CHoELiyoPF3iBB4ERJwyCX4JXRwKEaoJXApEOO?=
 =?us-ascii?q?5E+MwmHPINvg3CDNQYZgW+JFId3ikGFR4Esh1yFKyKBVisIAhgIIQ87gmwJg?=
 =?us-ascii?q?h8XgQABB4JDinEhAzCBBQEBjzEBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Feb 2019 19:30:12 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1FJUCx9005355;
        Fri, 15 Feb 2019 14:30:12 -0500
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
To:     Dominick Grift <dac.override@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
References: <20190215145045.31945-1-sds@tycho.nsa.gov>
 <CAHC9VhS+F-QBU-oJpXw1aAP1=TpekD1GEYB8y-QqEib1mzbwMA@mail.gmail.com>
 <5c95e956-6d38-78dd-75e2-df2c37bd998a@tycho.nsa.gov>
 <3f279367-2c4f-5b26-e31b-58eb037b687b@tycho.nsa.gov>
 <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov>
 <0e556b37-90fa-7f3a-f60f-fa77acce6f5b@tycho.nsa.gov>
 <87zhqxkn8a.fsf@gmail.com> <87r2c9klrh.fsf@gmail.com>
 <CAHC9VhR9b8udyh7WWAw0-G64DuaLBN59QXByteBdVbtZKnUj-A@mail.gmail.com>
 <87lg2g97sr.fsf@gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <98436a4a-0048-2839-acff-b1bc38075a8c@tycho.nsa.gov>
Date:   Fri, 15 Feb 2019 14:30:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87lg2g97sr.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/15/19 2:21 PM, Dominick Grift wrote:
> Paul Moore <paul@paul-moore.com> writes:
> 
>> On Fri, Feb 15, 2019 at 12:24 PM Dominick Grift <dac.override@gmail.com> wrote:
>>> Dominick Grift <dac.override@gmail.com> writes:
>>>> Stephen Smalley <sds@tycho.nsa.gov> writes:
>>>>
>>>>> On 2/15/19 10:25 AM, Stephen Smalley wrote:
>>>>>> On 2/15/19 10:05 AM, Stephen Smalley wrote:
>>>>>>> On 2/15/19 10:03 AM, Stephen Smalley wrote:
>>>>>>>> On 2/15/19 10:00 AM, Paul Moore wrote:
>>>>>>>>> On Fri, Feb 15, 2019 at 9:51 AM Stephen Smalley
>>>>>>>>> <sds@tycho.nsa.gov> wrote:
>>>>>>>>>> Add basic MLS policy support to mdp.  Declares
>>>>>>>>>> two sensitivities and two categories, defines
>>>>>>>>>> mls constraints for all permissions requiring
>>>>>>>>>> dominance (ala MCS), assigns the system-high
>>>>>>>>>> level to initial SID contexts and the default user
>>>>>>>>>> level, and assigns system-low level to filesystems.
>>>>>>>>>>
>>>>>>>>>> Also reworks the fs_use and genfscon rules to only
>>>>>>>>>> generate rules for filesystems that are configured
>>>>>>>>>> in the kernel.  In some cases this depends on a specific
>>>>>>>>>> config option for security xattrs, in other cases security
>>>>>>>>>> xattrs are unconditionally supported by a given filesystem
>>>>>>>>>> if the filesystem is enabled, and in some cases the filesystem
>>>>>>>>>> is always enabled in the kernel.  Dropped obsolete pseudo
>>>>>>>>>> filesystems.
>>>>>>>>>>
>>>>>>>>>> NB The list of fs_use_* and genfscon rules emitted by mdp
>>>>>>>>>> is very incomplete compared to refpolicy or Android sepolicy.
>>>>>>>>>> We should probably expand it.
>>>>>>>>>>
>>>>>>>>>> Usage:
>>>>>>>>>> scripts/selinux/mdp/mdp -m policy.conf file_contexts
>>>>>>>>>> checkpolicy -M -o policy policy.conf
>>>>>>>>>>
>>>>>>>>>> Then install the resulting policy and file_contexts as usual.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>>>>>>> ---
>>>>>>>>>> v3 fixes up the file contexts generation code to also use
>>>>>>>>>> SYSTEMLOW and
>>>>>>>>>> collapse down to a single fprintf call per line.
>>>>>>>>>>    scripts/selinux/mdp/mdp.c | 131
>>>>>>>>>> ++++++++++++++++++++++++++++++--------
>>>>>>>>>>    1 file changed, 103 insertions(+), 28 deletions(-)
>>>>>>>>>
>>>>>>>>> This is great Stephen, thanks for working on this - and rather quickly
>>>>>>>>> too!  For those who don't follow the GitHub issues, I just opened an
>>>>>>>>> issue yesterday mentioning it would be nice to add MLS support to the
>>>>>>>>> mdp tool.
>>>>>>>>>
>>>>>>>>> Are you planning to keep playing with this?  I'm asking not because I
>>>>>>>>> think it needs more work to be worthwhile, but rather I don't want to
>>>>>>>>> merge something that you want to continue working on.  If you are
>>>>>>>>> happy with this latest patch I think it is okay to merge this into
>>>>>>>>> selinux/next, even at this late stage, simply because it is not part
>>>>>>>>> of a built kernel, but rather a developer's tool.
>>>>>>>>
>>>>>>>> No, I think I'm done for now unless you find a problem with
>>>>>>>> it. Absent some compelling use case for mdp it is hard to justify
>>>>>>>> spending any more time on it.
>>>>>>>
>>>>>>> Note however that the instructions in
>>>>>>> Documentation/admin-guide/LSM/SELinux.rst just say to run
>>>>>>> scripts/selinux/install_policy.sh and since that doesn't pass -m to
>>>>>>> mdp or -M to checkpolicy, no one will use this support unless they
>>>>>>> do it all by hand.
>>>>>>
>>>>>> FWIW, a Fedora system wouldn't come up cleanly with this policy.
>>>>>> Partly appears to be due to systemd having embedded security
>>>>>> contexts specific to Fedora/refpolicy into its own configurations
>>>>>> and partly due to MLS denials.  I don't even know if it would work
>>>>>> before this change though...
>>>>>
>>>>> Couldn't seem to get a mdp-generated policy to boot on Fedora even in
>>>>> permissive, before or after this change.  I assume it has to do with
>>>>> leaking of contexts outside of the policy and/or missing config files
>>>>> from the dummy policy (e.g. /etc/selinux/targeted/contexts/ has
>>>>> systemd_contexts and other userspace config files that don't exist in
>>>>> the mdp policy).  More evidence of the irrelevance of mdp...
>>>>
>>>> Oh, right you need a "dbus_contexts" file probably. DBUS refuses to
>>>> start without it, and these day's without dbus no system
>>>
>>> My dssp2-minimal [1] policy is my alternative to mdp.
>>>
>>> https://github.com/DefenSec/dssp2-minimal
>>>
>>> It is not quite as simple as mpd but it think it is decent balance
>>> between having something useful and still easy to read.
>>
>> While dssp2-minimal is much smaller than reference policy, it's still
>> an order of magnitude larger than the mdp generated policy.  I'm not
>> sure if this is something you care about, but if you wanted to work on
>> getting mdp to the point where it would allow a Fedora system (or any
>> modern SELinux based system for that matter) to boot, that could be
>> useful, even if I'm not convinced it needs to be a priority at the
>> moment.
> 
> It is also an order of magnitude more useful than mdp.
> 
> I suppose I could look at what it would take to get it to boot on some
> rainy afternoon. Should not be hard, but i hesitate to polute mdp with
> user space access vectors. It feels like setting a precendent somehow.

In theory, if using selinux_check_access() to check permissions and if 
the policy sets allow_unknown=true, then the absence of the userspace 
classes and access vectors should just cause all userspace permission 
checks to pass.

Of course, not all userspace object managers use selinux_check_access(), 
and may not check security_deny_unknown() directly.

> 
>>
>> Besides, haven't you always wanted to get a patch accepted into the
>> kernel Dominick? ;)
> 
> Not particularly, no.
> 

