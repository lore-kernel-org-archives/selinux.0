Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134C0C43381
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91872075A
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 15:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="nSnHpIZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfBVPrm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:47:42 -0500
Received: from upbd19pa12.eemsg.mail.mil ([214.24.27.87]:12690 "EHLO
        upbd19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfBVPrm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 10:47:42 -0500
X-EEMSG-check-017: 191062435|UPBD19PA12_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Feb 2019 15:47:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550850438; x=1582386438;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cSeYqt5JnaO0jO4Ud8/8nnaHHfgwXR8MNGJhPtwTw2w=;
  b=nSnHpIZ9/YdE4uc7avpl3tfn79MgbH7f8+QumpWtj8s11HwVxDdRPDIR
   /H9H3FOe3GhwNifyBB2BIrk29RhPYA/EHafJfwg8z73b8xXR5NKO8iC+N
   Dm8zKazcgxRF8PyTPsfxnmPD0Xwd8j5xCIOuvqPyRPyElwftQv21iers9
   Fbm+ej0XvY7o4z+Q3a50LgVFDmaLC4Zg49UkXC0UolfOvrdTEQlI92alY
   B6I5X1nahwvzUeYLmuLm9xFm7eUvIgGRpDeMc39FjmqsttS2xudzMJeEN
   TqqIilI3aFPB81iiONJY2rfYcugEaK3PbQY/8ftKiTaH/nA68/bgAfnHS
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,400,1544486400"; 
   d="scan'208";a="24222314"
IronPort-PHdr: =?us-ascii?q?9a23=3AeSau6xHBzzD9omrX+zTLTZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76p8++bnLW6fgltlLVR4KTs6sC17KG9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa+bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YfIepUqo/wrEYMoxSjHwmhHP7hxCFGhnH23qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodfvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VesCGaMpF5QsIkQ2xwoyk10L4GtY?=
 =?us-ascii?q?S+fCgU0Jgn3xnfa/iGc4eU4hPvTvqeLi1khH9jZbmxhA6y/FC9xuDzWcS4yl?=
 =?us-ascii?q?ZHojdfntXSuX0ByQbf5tWBR/Bg5EmuwyyP2BrW6uxcJEA0krfUJIA5z74rk5?=
 =?us-ascii?q?oTrVzDHijrmEXqlKOWdlsr+uyv6+n/frXpvIWcN45pigHlKKguhsy+Dvg4Mg?=
 =?us-ascii?q?gJRWSb//iz1Kb/8kHjRbVKj/k2nrHYsJDcO8sbura0DxJa34ss8RqyDyqq3M?=
 =?us-ascii?q?4GkXQIMl5JYg+Lg5DsO17UIfD4Cfm/g06rkDdu3/3GJaDuAo7WI3jfkLbuYb?=
 =?us-ascii?q?Z960lGxAo11tBQ/YhYCr4GIPLtQkPxrsDXDgclMwyoxObqEMhy2ZkCVm6VBa?=
 =?us-ascii?q?+ZLr3dsUWS5uIuPuaDepQYuDn4K/c/5v7uiWU1lkMafamsxZEXcmy3Hux6I0?=
 =?us-ascii?q?WFZnrhmsoOEWAPvgo/SuzqiUGNUT1Ja3a9RaI85z87CJ69AIjeWI+tjqKO3C?=
 =?us-ascii?q?GgHpJIem9KEFaMEXPwfYWeR/gMcD6SItNmkjEcTbiuUZIh1RW1uQ/i0bVnM+?=
 =?us-ascii?q?7U9jQdtZLk09h1/fPcmQsu+jxzCsSXy3uNQH1snmMUWz8227hyoVdjxVeH0K?=
 =?us-ascii?q?h4heFYFNNI6vNXXQc1K4Tcw/Z5C9/sQALBeMmGSFK8TtWhGzExQYF5/9hbT0?=
 =?us-ascii?q?F4GtOjhROL8DCrDaNdw7CCD9oz7K/GxXn9Ku5yzn/H0O8qiFxwEeVVMmjzvb?=
 =?us-ascii?q?Jy7wjeAcbylkydk6u7PfAH0DXl6HaIzW3IulpRFgF3T/OWDjgkekLKoIGhtQ?=
 =?us-ascii?q?v5RLi0BOFia1EZxA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2ALAAAgGHBc/wHyM5BlGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYFZKmdQATInhAeIGotTTAEBAQEBAQaBNXyIP45jgXssDAGBKgGDFQKDf?=
 =?us-ascii?q?iI0CQ0BAwEBAQEBAQIBbCiCOikBgmcBBRoJBBFBEAsOCgICEgETAgJXBg0GA?=
 =?us-ascii?q?gEBF4JIPQGBZQ2sBXwzhUSEaYELiz0XeIEHgREngjY1hUkCgkCCVwKJZhoGh?=
 =?us-ascii?q?klLO1qRKgmHPoNvgyWECAYZgXGFW4peZYtejVaFFjiBVisIAhgIIQ87gmwJg?=
 =?us-ascii?q?h8XjjwhAzCBBQEBjDkNFweCIAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 22 Feb 2019 15:47:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1MFlDvk008592;
        Fri, 22 Feb 2019 10:47:13 -0500
Subject: Re: [PATCH] scripts/selinux: modernize mdp
To:     Dominick Grift <dac.override@gmail.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>, paul@paul-moore.com,
        selinux@vger.kernel.org
References: <20190221184213.31303-1-sds@tycho.nsa.gov>
 <0aa33829-e3c6-7a28-b216-5b8244360e8c@tycho.nsa.gov>
 <20190221194405.GA28703@brutus.lan>
 <28db5c2b-9c0e-b127-2086-c343452ac2d9@tycho.nsa.gov>
 <20190221205609.GE28703@brutus.lan>
 <af32a034-b502-473f-6661-c99d48c5b0b0@tycho.nsa.gov>
 <87k1hr7s5a.fsf@gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b7aabc38-cff7-f9d9-d903-48fa031b8584@tycho.nsa.gov>
Date:   Fri, 22 Feb 2019 10:46:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87k1hr7s5a.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/22/19 10:35 AM, Dominick Grift wrote:
> Stephen Smalley <sds@tycho.nsa.gov> writes:
> 
>> On 2/21/19 3:56 PM, Dominick Grift wrote:
>>> On Thu, Feb 21, 2019 at 03:28:37PM -0500, Stephen Smalley wrote:
>>>> On 2/21/19 2:44 PM, Dominick Grift wrote:
>>>>> On Thu, Feb 21, 2019 at 02:34:38PM -0500, Stephen Smalley wrote:
>>>>>> On 2/21/19 1:42 PM, Stephen Smalley wrote:
>>>>>>> Derived in part from a patch by Dominick Grift.
>>>>>>>
>>>>>>> The MDP example no longer works on modern systems.  Fix it.
>>>>>>> While we are at it, add MLS support and enable it.
>>>>>>>
>>>>>>> NB This still does not work on systems using dbus-daemon instead of
>>>>>>> dbus-broker because dbus-daemon does not yet gracefully handle unknown
>>>>>>> classes/permissions.  This is a deficiency in libselinux's
>>>>>>> selinux_set_mapping() interface and underlying implementation,
>>>>>>> which was never fully updated to deal with unknown classes/permissions
>>>>>>> unlike the kernel.  Programs that instead use selinux_check_access()
>>>>>>> like dbus-broker do not have this problem.
>>>>>>
>>>>>> We could perhaps avoid this problem by having mdp always include at least a
>>>>>> core set of userspace classes/permissions in the policy it generates.  We
>>>>>> could also fix libselinux but that won't help on any existing distro.
>>>>>>
>>>>>>>
>>>>>>> Other known issues:
>>>>>>> - Not everything appears to be relabeled, so some files are left with invalid
>>>>>>> contexts and remapped to the unlabeled SID/context.
>>>>>>
>>>>>> This appears to be partly due to overuse of <<none>> in file_contexts (.fc)
>>>>>> files.  That excludes those parts of the filesystem from being relabeled at
>>>>>> all.  This was used to exclude pseudo filesystems (obsoleted by seclabel
>>>>>> mount option detection) or runtime directories/files whose labels were
>>>>>> derived from the creating process and couldn't be statically specified by
>>>>>> file_contexts.  To get my system back into working order even with targeted
>>>>>> policy, I had to strip all <<none>> entries out of my file_contexts* files
>>>>>> and then run setfiles -F with the list of filesystem mounts to relabel.
>>>>>> Otherwise, I'd have files left in the old contexts and the system wouldn't
>>>>>> even come up to user login, even if permissive.
>>>>>
>>>>> What <<none>> spec(s) in fedora would be so important that it causes the system to not come up to user login, even in permissive?
>>>>> Does the unlabeled isid not address these particular scenario's? and why not?
>>>>
>>>> Yes, I don't fully understand it myself; I just know that certain services
>>>> won't start successfully and it never reaches the point where I can login
>>>> locally or remotely.  But stripping the <<none>> entries and running
>>>> setfiles -F did fix it for me.  NB This was for converting back from mdp to
>>>> the Fedora targeted policy.  It wouldn't be an issue for converting to mdp
>>>> since that file_contexts has no <<none>> entries and has a default match for
>>>> /.*.
>>>
>>> I am going on a limb here so bear with me but; I suspect that it was
>> not the <<none>> that "did" it. I think it might have been the
>> additional setfiles -F that did it.
>>> I think the services did not come up because systemd was not able to compute its context from /sbin/init.
>>> If the above is actually the case then my question is:
>>> Why can't systemd compute its context from /sbin/init by relying on
>> the unlabeled isid. I mean if /sbin/init was mislabeled. then the
>> unlabeled isid should have kicked in. So why was systemd unable to use
>> that to compute its context?
>>
>> Yes, I think you are correct about the cause.  It appears that systemd
>> fetches the context of its executable via getfilecon_raw() ->
>> getxattr() and then calls security_compute_create() with that as the
>> 2nd argument. At that point systemd is still running in kernel_t,
>> which is allowed all capabilities including mac_admin.  Hence, the
>> getfilecon_raw() returns the actual on-disk xattr value even if it is
>> not a valid context rather than remapping it to the unlabeled context.
>> Then the security_compute_create() call fails since the 2nd argument
>> is not a valid context and we don't allow even mac_admin callers to
>> pass invalid contexts to selinuxfs interfaces; that is only for
>> getting/setting non-host policy contexts on files via
>> getxattr/setxattr and /proc/self/attr/fscreate.  Ways to resolve:
>>
>> 1) Remove mac_admin permission from kernel_t (and really anything
>> except for domains that specifically need to set unknown contexts,
>> e.g. for creating distro images with policies that differ from the
>> host).  Then getfilecon_raw() would return the unlabeled sid context
>> and security_compute_create() should just end up returning the 1st
>> context i.e. the kernel context (no transition defined on unlabeled).
> 
> This would not solve it for me because I saw it when i moved from
> dssp2-standard to dummy (so systemd was running in base_t via the kernel
> isid already i suppose, and well, base_t is unconfined)
> 
> dssp2-standard does not do mac_admin:
> 
> # sesearch -A -c capability2 -p mac_admin | wc -l
> 0
> 
>>
>> -or-
>>
>> 2) Allowing passing invalid contexts to selinuxfs from mac_admin
>> callers, remap internally to unlabeled context.  Then the
>> security_compute_create() call wouldn't have failed.  We didn't want
>> to do that because we wanted even mac_admin callers to be able to
>> validate contexts via security_check_context() aka
>> /sys/fs/selinux/context.
>>
> 
> I do not feel qualified to judge this option
> 
>> -or-
>>
>> 3) Manually fix the label on the systemd binary before rebooting.
>>
> 
> Generally the procedure is and was that if you change policy. you
> autorelabel in permissive mode. I am not 100% sure but I suspect that if
> you do that consistently, that things should work out. Maybe the autorelabel solution
> in fedora and systemd systems in general should be scrutinized some more
> to see if that is an area that can be improved.

Unfortunately autorelabel in permissive didn't appear to resolve it for 
me.  I had to boot with SELinux disabled and run setfiles by hand to fix it.

> 
>>>
>>>>
>>>> Maybe it is a case of processes with CAP_MAC_ADMIN fetching the raw context
>>>> (which is invalid under the current policy) and then trying to feed them
>>>> back to the kernel via a selinuxfs interface, e.g. security_compute_create()
>>>> or similar.  The kernel would reject those.
>>>>
>>>>>
>>>>> I am testing the patch now here (but in my scenario its a very minimal fedora with dssp2-standard policy)
>>>>>
>>>>>>
>>>>>> FWIW, Android policy doesn't use <<none>> at all.  But they also don't have
>>>>>> a /.* or equivalent entry as a default match, so anything not covered by a
>>>>>> more specific match is likewise not labeled. seapp_contexts handles the more
>>>>>> dynamic aspect of app directory labeling for Android.
>>>>>>
>>>>>> The other problem case for relabeling is the mount point directories, which
>>>>>> requires unmounting them all and relabeling them if we care. Otherwise
>>>>>> they'll just get the unlabeled context and as long as we allow mounting on
>>>>>> that, it should be ok.
>>>>>>
>>>>>>> - X will fail due to lack of a x_contexts file
>>>>>>> - libvirtd will fail due to lack of a virtual_domain_context file
>>>>>>
>>>>>> We could easily add these to the mdp policy.
>>>>>>
>>>>>>> - crond reports an error with "No security context"
>>>>>>
>>>>>> This is probably due to the lack of a contexts/default_contexts or any
>>>>>> contexts/users/ files in the dummy policy.
>>>>>>
>>>>>>>
>>>>>>> Changes to mdp:
>>>>>>> Add support for devtmpfs, required by modern Linux distributions.
>>>>>>> Add MLS support, with sample sensitivities, categories, and constraints.
>>>>>>> Generate fs_use and genfscon rules based on kernel configuration.
>>>>>>> Update list of filesystem types for fs_use and genfscon rules.
>>>>>>> Use object_r for object contexts.
>>>>>>>
>>>>>>> Changes to install_policy.sh:
>>>>>>> Bail immediately on any errors.
>>>>>>> Provide more helpful error messages when unable to find userspace tools.
>>>>>>> Refuse to run if SELinux is already enabled.
>>>>>>> Unconditionally move aside /etc/selinux/config and create a new one.
>>>>>>> Build policy with -U allow so that userspace object managers do not break.
>>>>>>> Build policy with MLS enabled by default.
>>>>>>> Add default seusers mapping and failsafe context for use by
>>>>>>> pam_selinux / libselinux.
>>>>>>> Set to permissive mode rather than enforcing to permit initial autorelabel.
>>>>>>> Update the list of filesystem types to be relabeled.
>>>>>>> Create /.autorelabel to trigger an autorelabel on reboot.
>>>>>>> Drop broken attempt to relabel the /dev mountpoint directory.
>>>>>>>
>>>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>>>> ---
>>>>>>>      scripts/selinux/install_policy.sh |  82 ++++++++-------
>>>>>>>      scripts/selinux/mdp/mdp.c         | 164 +++++++++++++++++++++++++-----
>>>>>>>      2 files changed, 183 insertions(+), 63 deletions(-)
>>>>>>>
>>>>>>> diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
>>>>>>> index 0b86c47baf7d..09eab4d0da5c 100755
>>>>>>> --- a/scripts/selinux/install_policy.sh
>>>>>>> +++ b/scripts/selinux/install_policy.sh
>>>>>>> @@ -1,30 +1,51 @@
>>>>>>>      #!/bin/sh
>>>>>>>      # SPDX-License-Identifier: GPL-2.0
>>>>>>> +set -e
>>>>>>>      if [ `id -u` -ne 0 ]; then
>>>>>>>      	echo "$0: must be root to install the selinux policy"
>>>>>>>      	exit 1
>>>>>>>      fi
>>>>>>> +
>>>>>>>      SF=`which setfiles`
>>>>>>>      if [ $? -eq 1 ]; then
>>>>>>> -	if [ -f /sbin/setfiles ]; then
>>>>>>> -		SF="/usr/setfiles"
>>>>>>> -	else
>>>>>>> -		echo "no selinux tools installed: setfiles"
>>>>>>> -		exit 1
>>>>>>> -	fi
>>>>>>> +	echo "Could not find setfiles"
>>>>>>> +	echo "Do you have policycoreutils installed?"
>>>>>>> +	exit 1
>>>>>>>      fi
>>>>>>> -cd mdp
>>>>>>> -
>>>>>>>      CP=`which checkpolicy`
>>>>>>> +if [ $? -eq 1 ]; then
>>>>>>> +	echo "Could not find checkpolicy"
>>>>>>> +	echo "Do you have checkpolicy installed?"
>>>>>>> +	exit 1
>>>>>>> +fi
>>>>>>>      VERS=`$CP -V | awk '{print $1}'`
>>>>>>> -./mdp policy.conf file_contexts
>>>>>>> -$CP -o policy.$VERS policy.conf
>>>>>>> +ENABLED=`which selinuxenabled`
>>>>>>> +if [ $? -eq 1 ]; then
>>>>>>> +	echo "Could not find selinuxenabled"
>>>>>>> +	echo "Do you have libselinux-utils installed?"
>>>>>>> +	exit 1
>>>>>>> +fi
>>>>>>> +
>>>>>>> +if selinuxenabled; then
>>>>>>> +    echo "SELinux is already enabled"
>>>>>>> +    echo "This prevents safely relabeling all files."
>>>>>>> +    echo "Boot with selinux=0 on the kernel command-line or"
>>>>>>> +    echo "SELINUX=disabled in /etc/selinux/config."
>>>>>>> +    exit 1
>>>>>>> +fi
>>>>>>> +
>>>>>>> +cd mdp
>>>>>>> +./mdp -m policy.conf file_contexts
>>>>>>> +$CP -U allow -M -o policy.$VERS policy.conf
>>>>>>>      mkdir -p /etc/selinux/dummy/policy
>>>>>>>      mkdir -p /etc/selinux/dummy/contexts/files
>>>>>>> +echo "__default__:user_u" > /etc/selinux/dummy/seusers
>>>>>>> +echo "base_r:base_t" > /etc/selinux/dummy/contexts/failsafe_context
>>>>>>> +
>>>>>>>      cp file_contexts /etc/selinux/dummy/contexts/files
>>>>>>>      cp dbus_contexts /etc/selinux/dummy/contexts
>>>>>>>      cp policy.$VERS /etc/selinux/dummy/policy
>>>>>>> @@ -33,37 +54,22 @@ FC_FILE=/etc/selinux/dummy/contexts/files/file_contexts
>>>>>>>      if [ ! -d /etc/selinux ]; then
>>>>>>>      	mkdir -p /etc/selinux
>>>>>>>      fi
>>>>>>> -if [ ! -f /etc/selinux/config ]; then
>>>>>>> -	cat > /etc/selinux/config << EOF
>>>>>>> -SELINUX=enforcing
>>>>>>> +if [ -f /etc/selinux/config ]; then
>>>>>>> +    echo "/etc/selinux/config exists, moving to /etc/selinux/config.bak."
>>>>>>> +    mv /etc/selinux/config /etc/selinux/config.bak
>>>>>>> +fi
>>>>>>> +echo "Creating new /etc/selinux/config for dummy policy."
>>>>>>> +cat > /etc/selinux/config << EOF
>>>>>>> +SELINUX=permissive
>>>>>>>      SELINUXTYPE=dummy
>>>>>>>      EOF
>>>>>>> -else
>>>>>>> -	TYPE=`cat /etc/selinux/config | grep "^SELINUXTYPE" | tail -1 | awk -F= '{ print $2 '}`
>>>>>>> -	if [ "eq$TYPE" != "eqdummy" ]; then
>>>>>>> -		selinuxenabled
>>>>>>> -		if [ $? -eq 0 ]; then
>>>>>>> -			echo "SELinux already enabled with a non-dummy policy."
>>>>>>> -			echo "Exiting.  Please install policy by hand if that"
>>>>>>> -			echo "is what you REALLY want."
>>>>>>> -			exit 1
>>>>>>> -		fi
>>>>>>> -		mv /etc/selinux/config /etc/selinux/config.mdpbak
>>>>>>> -		grep -v "^SELINUXTYPE" /etc/selinux/config.mdpbak >> /etc/selinux/config
>>>>>>> -		echo "SELINUXTYPE=dummy" >> /etc/selinux/config
>>>>>>> -	fi
>>>>>>> -fi
>>>>>>>      cd /etc/selinux/dummy/contexts/files
>>>>>>> -$SF file_contexts /
>>>>>>> +$SF -F file_contexts /
>>>>>>> -mounts=`cat /proc/$$/mounts | egrep "ext2|ext3|xfs|jfs|ext4|ext4dev|gfs2" | awk '{ print $2 '}`
>>>>>>> -$SF file_contexts $mounts
>>>>>>> +mounts=`cat /proc/$$/mounts | \
>>>>>>> +	egrep "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
>>>>>>> +	awk '{ print $2 '}`
>>>>>>> +$SF -F file_contexts $mounts
>>>>>>> -
>>>>>>> -dodev=`cat /proc/$$/mounts | grep "/dev "`
>>>>>>> -if [ "eq$dodev" != "eq" ]; then
>>>>>>> -	mount --move /dev /mnt
>>>>>>> -	$SF file_contexts /dev
>>>>>>> -	mount --move /mnt /dev
>>>>>>> -fi
>>>>>>> +touch /.autorelabel
>>>>>>> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
>>>>>>> index 073fe7537f6c..daad333c7252 100644
>>>>>>> --- a/scripts/selinux/mdp/mdp.c
>>>>>>> +++ b/scripts/selinux/mdp/mdp.c
>>>>>>> @@ -33,6 +33,7 @@
>>>>>>>      #include <unistd.h>
>>>>>>>      #include <string.h>
>>>>>>>      #include <sys/socket.h>
>>>>>>> +#include <linux/kconfig.h>
>>>>>>>      static void usage(char *name)
>>>>>>>      {
>>>>>>> @@ -95,10 +96,31 @@ int main(int argc, char *argv[])
>>>>>>>      	}
>>>>>>>      	fprintf(fout, "\n");
>>>>>>> -	/* NOW PRINT OUT MLS STUFF */
>>>>>>> +	/* print out mls declarations and constraints */
>>>>>>>      	if (mls) {
>>>>>>> -		printf("MLS not yet implemented\n");
>>>>>>> -		exit(1);
>>>>>>> +		fprintf(fout, "sensitivity s0;\n");
>>>>>>> +		fprintf(fout, "sensitivity s1;\n");
>>>>>>> +		fprintf(fout, "dominance { s0 s1 }\n");
>>>>>>> +		fprintf(fout, "category c0;\n");
>>>>>>> +		fprintf(fout, "category c1;\n");
>>>>>>> +		fprintf(fout, "level s0:c0.c1;\n");
>>>>>>> +		fprintf(fout, "level s1:c0.c1;\n");
>>>>>>> +#define SYSTEMLOW "s0"
>>>>>>> +#define SYSTEMHIGH "s1:c0.c1"
>>>>>>> +		for (i = 0; secclass_map[i].name; i++) {
>>>>>>> +			struct security_class_mapping *map = &secclass_map[i];
>>>>>>> +
>>>>>>> +			fprintf(fout, "mlsconstrain %s {\n", map->name);
>>>>>>> +			for (j = 0; map->perms[j]; j++)
>>>>>>> +				fprintf(fout, "\t%s\n", map->perms[j]);
>>>>>>> +			/*
>>>>>>> +			 * This requires all subjects and objects to be
>>>>>>> +			 * single-level (l2 eq h2), and that the subject
>>>>>>> +			 * level dominate the object level (h1 dom h2)
>>>>>>> +			 * in order to have any permissions to it.
>>>>>>> +			 */
>>>>>>> +			fprintf(fout, "} (l2 eq h2 and h1 dom h2);\n\n");
>>>>>>> +		}
>>>>>>>      	}
>>>>>>>      	/* types, roles, and allows */
>>>>>>> @@ -108,34 +130,126 @@ int main(int argc, char *argv[])
>>>>>>>      	for (i = 0; secclass_map[i].name; i++)
>>>>>>>      		fprintf(fout, "allow base_t base_t:%s *;\n",
>>>>>>>      			secclass_map[i].name);
>>>>>>> -	fprintf(fout, "user user_u roles { base_r };\n");
>>>>>>> -	fprintf(fout, "\n");
>>>>>>> +	fprintf(fout, "user user_u roles { base_r }");
>>>>>>> +	if (mls)
>>>>>>> +		fprintf(fout, " level %s range %s - %s", SYSTEMLOW,
>>>>>>> +			SYSTEMLOW, SYSTEMHIGH);
>>>>>>> +	fprintf(fout, ";\n");
>>>>>>> +
>>>>>>> +#define SUBJUSERROLETYPE "user_u:base_r:base_t"
>>>>>>> +#define OBJUSERROLETYPE "user_u:object_r:base_t"
>>>>>>>      	/* default sids */
>>>>>>>      	for (i = 1; i < initial_sid_to_string_len; i++)
>>>>>>> -		fprintf(fout, "sid %s user_u:base_r:base_t\n", initial_sid_to_string[i]);
>>>>>>> +		fprintf(fout, "sid %s " SUBJUSERROLETYPE "%s\n",
>>>>>>> +			initial_sid_to_string[i], mls ? ":" SYSTEMLOW : "");
>>>>>>>      	fprintf(fout, "\n");
>>>>>>> -	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
>>>>>>> -	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
>>>>>>> -	fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
>>>>>>> -	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
>>>>>>> -	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
>>>>>>> -	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
>>>>>>> -	fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
>>>>>>> -	fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
>>>>>>> +#define FS_USE(behavior, fstype)			    \
>>>>>>> +	fprintf(fout, "fs_use_%s %s " OBJUSERROLETYPE "%s;\n", \
>>>>>>> +		behavior, fstype, mls ? ":" SYSTEMLOW : "")
>>>>>>> +
>>>>>>> +	/*
>>>>>>> +	 * Filesystems whose inode labels can be fetched via getxattr.
>>>>>>> +	 */
>>>>>>> +#ifdef CONFIG_EXT2_FS_SECURITY
>>>>>>> +	FS_USE("xattr", "ext2");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_EXT3_FS_SECURITY
>>>>>>> +	FS_USE("xattr", "ext3");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_EXT4_FS_SECURITY
>>>>>>> +	FS_USE("xattr", "ext4");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_JFS_SECURITY
>>>>>>> +	FS_USE("xattr", "jfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_REISERFS_FS_SECURITY
>>>>>>> +	FS_USE("xattr", "reiserfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_JFFS2_FS_SECURITY
>>>>>>> +	FS_USE("xattr", "jffs2");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_XFS_FS
>>>>>>> +	FS_USE("xattr", "xfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_GFS2_FS
>>>>>>> +	FS_USE("xattr", "gfs2");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_BTRFS_FS
>>>>>>> +	FS_USE("xattr", "btrfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_F2FS_FS_SECURITY
>>>>>>> +	FS_USE("xattr", "f2fs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_OCFS2_FS
>>>>>>> +	FS_USE("xattr", "ocsfs2");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_OVERLAY_FS
>>>>>>> +	FS_USE("xattr", "overlay");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_SQUASHFS_XATTR
>>>>>>> +	FS_USE("xattr", "squashfs");
>>>>>>> +#endif
>>>>>>> +
>>>>>>> +	/*
>>>>>>> +	 * Filesystems whose inodes are labeled from allocating task.
>>>>>>> +	 */
>>>>>>> +	FS_USE("task", "pipefs");
>>>>>>> +	FS_USE("task", "sockfs");
>>>>>>> -	fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t;\n");
>>>>>>> -	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
>>>>>>> -	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
>>>>>>> +	/*
>>>>>>> +	 * Filesystems whose inode labels are computed from both
>>>>>>> +	 * the allocating task and the superblock label.
>>>>>>> +	 */
>>>>>>> +#ifdef CONFIG_UNIX98_PTYS
>>>>>>> +	FS_USE("trans", "devpts");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_HUGETLBFS
>>>>>>> +	FS_USE("trans", "hugetlbfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_TMPFS
>>>>>>> +	FS_USE("trans", "tmpfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_DEVTMPFS
>>>>>>> +	FS_USE("trans", "devtmpfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_POSIX_MQUEUE
>>>>>>> +	FS_USE("trans", "mqueue");
>>>>>>> +#endif
>>>>>>> -	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
>>>>>>> -	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
>>>>>>> -	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
>>>>>>> -	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
>>>>>>> -	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
>>>>>>> +#define GENFSCON(fstype, prefix)			     \
>>>>>>> +	fprintf(fout, "genfscon %s %s " OBJUSERROLETYPE "%s\n", \
>>>>>>> +		fstype, prefix, mls ? ":" SYSTEMLOW : "")
>>>>>>> -	fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
>>>>>>> +	/*
>>>>>>> +	 * Filesystems whose inodes are labeled from path prefix match
>>>>>>> +	 * relative to the filesystem root.  Depending on the filesystem,
>>>>>>> +	 * only a single label for all inodes may be supported.  Here
>>>>>>> +	 * we list the filesystem types for which per-file labeling is
>>>>>>> +	 * supported using genfscon; any other filesystem type can also
>>>>>>> +	 * be added by only with a single entry for all of its inodes.
>>>>>>> +	 */
>>>>>>> +#ifdef CONFIG_PROC_FS
>>>>>>> +	GENFSCON("proc", "/");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_SECURITY_SELINUX
>>>>>>> +	GENFSCON("selinuxfs", "/");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_SYSFS
>>>>>>> +	GENFSCON("sysfs", "/");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_DEBUG_FS
>>>>>>> +	GENFSCON("debugfs", "/");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_TRACING
>>>>>>> +	GENFSCON("tracefs", "/");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_PSTORE
>>>>>>> +	GENFSCON("pstore", "/");
>>>>>>> +#endif
>>>>>>> +	GENFSCON("cgroup", "/");
>>>>>>> +	GENFSCON("cgroup2", "/");
>>>>>>>      	fclose(fout);
>>>>>>> @@ -144,8 +258,8 @@ int main(int argc, char *argv[])
>>>>>>>      		printf("Wrote policy, but cannot open %s for writing\n", ctxout);
>>>>>>>      		usage(argv[0]);
>>>>>>>      	}
>>>>>>> -	fprintf(fout, "/ user_u:base_r:base_t\n");
>>>>>>> -	fprintf(fout, "/.* user_u:base_r:base_t\n");
>>>>>>> +	fprintf(fout, "/ " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
>>>>>>> +	fprintf(fout, "/.* " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
>>>>>>>      	fclose(fout);
>>>>>>>      	return 0;
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

