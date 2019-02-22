Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D55C43381
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 15:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A17920700
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 15:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6dr/EEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfBVPfe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:35:34 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36221 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfBVPfe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 10:35:34 -0500
Received: by mail-ed1-f67.google.com with SMTP id g9so2106681eds.3
        for <selinux@vger.kernel.org>; Fri, 22 Feb 2019 07:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wOtZ45icueBm5qQyG7C08XiryLSICu5E27yzNicKChM=;
        b=u6dr/EEtCp4HO2oChgZySCmDtGU/1zraULk9X8c5qmV956oNTGHJeUsnaVRTx/eihw
         6RNsL8i7BOIGlIUGgG8eNOAX3M7jU3/HF2Z+kSriz2woxgqy36XnsWttBLvlfSac1Ptw
         /Qh5TOmbB6hhBR2Eu0KWtI0uSoJubdVtdfJIg/HJQisGgiKyh+FgvEYFAL3HO347N4Lr
         qXRv5yfNq87h4jJKK49XIsdV5mTWQMwg753QJDAoMPVTl+rRsun149rFMgGyMRW/An3l
         fMjoADvUfO4hXEWNnEaCGFhx0MHamW5HNFmgZ6riLUvpWbbtsD9X0OyHjuiKuytcgkvf
         YmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=wOtZ45icueBm5qQyG7C08XiryLSICu5E27yzNicKChM=;
        b=HLypEalj52SeVV2TfuFxi55F4Rftp9Tb0C1U6H/S/phGxO+mWf3gs+rqt/w8iEfi+G
         dxkgys4ePZEhZWdEkO1FIdYJfHEDA6C/CIRw6aXM1BNiRI4zwzhmVVp2MjEF8FK2UvOB
         ilGqWcQ3B0E7DzGECywEy8k2FY/AsDSAvAZTxfNYttV4ZeIgP3EXQc1naZCVkkP4ixtq
         fJSkOqxMclo1QlLdQLiCIS0unyHjCyct00TbXh0eeL7ky04Zau6V04x1aaox3Om9wGE5
         OifcEkz4POOn1pxm/ryQKyfk5ZxzKWNCXwqB7U/usaIyBxB+wnbBnYWbzvcfDWWM6Btb
         of+g==
X-Gm-Message-State: AHQUAuaz62VQUMqEHPd7rm0FIVm/VlIc20dQZUO+2KIQBPqFLqzBKTCA
        j5Rsso9eiRcyETlTGYPMyg8MFaRB
X-Google-Smtp-Source: AHgI3IbZFS9Jo58piEDe+v0eh8qBAu/DT0Zhjv5J8tIlhQRdTMAzhE31VL41d7c4CiZOUrKOmSsI9A==
X-Received: by 2002:a17:906:2a98:: with SMTP id l24mr3345308eje.175.1550849731129;
        Fri, 22 Feb 2019 07:35:31 -0800 (PST)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id l15sm320963ejn.77.2019.02.22.07.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 07:35:30 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Dominick Grift <dominick.grift@defensec.nl>, paul@paul-moore.com,
        selinux@vger.kernel.org
Subject: Re: [PATCH] scripts/selinux: modernize mdp
References: <20190221184213.31303-1-sds@tycho.nsa.gov>
        <0aa33829-e3c6-7a28-b216-5b8244360e8c@tycho.nsa.gov>
        <20190221194405.GA28703@brutus.lan>
        <28db5c2b-9c0e-b127-2086-c343452ac2d9@tycho.nsa.gov>
        <20190221205609.GE28703@brutus.lan>
        <af32a034-b502-473f-6661-c99d48c5b0b0@tycho.nsa.gov>
Date:   Fri, 22 Feb 2019 16:35:29 +0100
In-Reply-To: <af32a034-b502-473f-6661-c99d48c5b0b0@tycho.nsa.gov> (Stephen
        Smalley's message of "Fri, 22 Feb 2019 10:13:46 -0500")
Message-ID: <87k1hr7s5a.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 2/21/19 3:56 PM, Dominick Grift wrote:
>> On Thu, Feb 21, 2019 at 03:28:37PM -0500, Stephen Smalley wrote:
>>> On 2/21/19 2:44 PM, Dominick Grift wrote:
>>>> On Thu, Feb 21, 2019 at 02:34:38PM -0500, Stephen Smalley wrote:
>>>>> On 2/21/19 1:42 PM, Stephen Smalley wrote:
>>>>>> Derived in part from a patch by Dominick Grift.
>>>>>>
>>>>>> The MDP example no longer works on modern systems.  Fix it.
>>>>>> While we are at it, add MLS support and enable it.
>>>>>>
>>>>>> NB This still does not work on systems using dbus-daemon instead of
>>>>>> dbus-broker because dbus-daemon does not yet gracefully handle unknown
>>>>>> classes/permissions.  This is a deficiency in libselinux's
>>>>>> selinux_set_mapping() interface and underlying implementation,
>>>>>> which was never fully updated to deal with unknown classes/permissions
>>>>>> unlike the kernel.  Programs that instead use selinux_check_access()
>>>>>> like dbus-broker do not have this problem.
>>>>>
>>>>> We could perhaps avoid this problem by having mdp always include at least a
>>>>> core set of userspace classes/permissions in the policy it generates.  We
>>>>> could also fix libselinux but that won't help on any existing distro.
>>>>>
>>>>>>
>>>>>> Other known issues:
>>>>>> - Not everything appears to be relabeled, so some files are left with invalid
>>>>>> contexts and remapped to the unlabeled SID/context.
>>>>>
>>>>> This appears to be partly due to overuse of <<none>> in file_contexts (.fc)
>>>>> files.  That excludes those parts of the filesystem from being relabeled at
>>>>> all.  This was used to exclude pseudo filesystems (obsoleted by seclabel
>>>>> mount option detection) or runtime directories/files whose labels were
>>>>> derived from the creating process and couldn't be statically specified by
>>>>> file_contexts.  To get my system back into working order even with targeted
>>>>> policy, I had to strip all <<none>> entries out of my file_contexts* files
>>>>> and then run setfiles -F with the list of filesystem mounts to relabel.
>>>>> Otherwise, I'd have files left in the old contexts and the system wouldn't
>>>>> even come up to user login, even if permissive.
>>>>
>>>> What <<none>> spec(s) in fedora would be so important that it causes the system to not come up to user login, even in permissive?
>>>> Does the unlabeled isid not address these particular scenario's? and why not?
>>>
>>> Yes, I don't fully understand it myself; I just know that certain services
>>> won't start successfully and it never reaches the point where I can login
>>> locally or remotely.  But stripping the <<none>> entries and running
>>> setfiles -F did fix it for me.  NB This was for converting back from mdp to
>>> the Fedora targeted policy.  It wouldn't be an issue for converting to mdp
>>> since that file_contexts has no <<none>> entries and has a default match for
>>> /.*.
>>
>> I am going on a limb here so bear with me but; I suspect that it was
> not the <<none>> that "did" it. I think it might have been the
> additional setfiles -F that did it.
>> I think the services did not come up because systemd was not able to compute its context from /sbin/init.
>> If the above is actually the case then my question is:
>> Why can't systemd compute its context from /sbin/init by relying on
> the unlabeled isid. I mean if /sbin/init was mislabeled. then the
> unlabeled isid should have kicked in. So why was systemd unable to use
> that to compute its context?
>
> Yes, I think you are correct about the cause.  It appears that systemd
> fetches the context of its executable via getfilecon_raw() ->
> getxattr() and then calls security_compute_create() with that as the
> 2nd argument. At that point systemd is still running in kernel_t,
> which is allowed all capabilities including mac_admin.  Hence, the
> getfilecon_raw() returns the actual on-disk xattr value even if it is
> not a valid context rather than remapping it to the unlabeled context.
> Then the security_compute_create() call fails since the 2nd argument
> is not a valid context and we don't allow even mac_admin callers to
> pass invalid contexts to selinuxfs interfaces; that is only for
> getting/setting non-host policy contexts on files via
> getxattr/setxattr and /proc/self/attr/fscreate.  Ways to resolve:
>
> 1) Remove mac_admin permission from kernel_t (and really anything
> except for domains that specifically need to set unknown contexts,
> e.g. for creating distro images with policies that differ from the
> host).  Then getfilecon_raw() would return the unlabeled sid context
> and security_compute_create() should just end up returning the 1st
> context i.e. the kernel context (no transition defined on unlabeled).

This would not solve it for me because I saw it when i moved from
dssp2-standard to dummy (so systemd was running in base_t via the kernel
isid already i suppose, and well, base_t is unconfined)

dssp2-standard does not do mac_admin:

# sesearch -A -c capability2 -p mac_admin | wc -l
0

>
> -or-
>
> 2) Allowing passing invalid contexts to selinuxfs from mac_admin
> callers, remap internally to unlabeled context.  Then the
> security_compute_create() call wouldn't have failed.  We didn't want
> to do that because we wanted even mac_admin callers to be able to
> validate contexts via security_check_context() aka
> /sys/fs/selinux/context.
>

I do not feel qualified to judge this option

> -or-
>
> 3) Manually fix the label on the systemd binary before rebooting.
>

Generally the procedure is and was that if you change policy. you
autorelabel in permissive mode. I am not 100% sure but I suspect that if
you do that consistently, that things should work out. Maybe the autorelabel solution
in fedora and systemd systems in general should be scrutinized some more
to see if that is an area that can be improved.

>>
>>>
>>> Maybe it is a case of processes with CAP_MAC_ADMIN fetching the raw context
>>> (which is invalid under the current policy) and then trying to feed them
>>> back to the kernel via a selinuxfs interface, e.g. security_compute_create()
>>> or similar.  The kernel would reject those.
>>>
>>>>
>>>> I am testing the patch now here (but in my scenario its a very minimal fedora with dssp2-standard policy)
>>>>
>>>>>
>>>>> FWIW, Android policy doesn't use <<none>> at all.  But they also don't have
>>>>> a /.* or equivalent entry as a default match, so anything not covered by a
>>>>> more specific match is likewise not labeled. seapp_contexts handles the more
>>>>> dynamic aspect of app directory labeling for Android.
>>>>>
>>>>> The other problem case for relabeling is the mount point directories, which
>>>>> requires unmounting them all and relabeling them if we care. Otherwise
>>>>> they'll just get the unlabeled context and as long as we allow mounting on
>>>>> that, it should be ok.
>>>>>
>>>>>> - X will fail due to lack of a x_contexts file
>>>>>> - libvirtd will fail due to lack of a virtual_domain_context file
>>>>>
>>>>> We could easily add these to the mdp policy.
>>>>>
>>>>>> - crond reports an error with "No security context"
>>>>>
>>>>> This is probably due to the lack of a contexts/default_contexts or any
>>>>> contexts/users/ files in the dummy policy.
>>>>>
>>>>>>
>>>>>> Changes to mdp:
>>>>>> Add support for devtmpfs, required by modern Linux distributions.
>>>>>> Add MLS support, with sample sensitivities, categories, and constraints.
>>>>>> Generate fs_use and genfscon rules based on kernel configuration.
>>>>>> Update list of filesystem types for fs_use and genfscon rules.
>>>>>> Use object_r for object contexts.
>>>>>>
>>>>>> Changes to install_policy.sh:
>>>>>> Bail immediately on any errors.
>>>>>> Provide more helpful error messages when unable to find userspace tools.
>>>>>> Refuse to run if SELinux is already enabled.
>>>>>> Unconditionally move aside /etc/selinux/config and create a new one.
>>>>>> Build policy with -U allow so that userspace object managers do not break.
>>>>>> Build policy with MLS enabled by default.
>>>>>> Add default seusers mapping and failsafe context for use by
>>>>>> pam_selinux / libselinux.
>>>>>> Set to permissive mode rather than enforcing to permit initial autorelabel.
>>>>>> Update the list of filesystem types to be relabeled.
>>>>>> Create /.autorelabel to trigger an autorelabel on reboot.
>>>>>> Drop broken attempt to relabel the /dev mountpoint directory.
>>>>>>
>>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>>> ---
>>>>>>     scripts/selinux/install_policy.sh |  82 ++++++++-------
>>>>>>     scripts/selinux/mdp/mdp.c         | 164 +++++++++++++++++++++++++-----
>>>>>>     2 files changed, 183 insertions(+), 63 deletions(-)
>>>>>>
>>>>>> diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
>>>>>> index 0b86c47baf7d..09eab4d0da5c 100755
>>>>>> --- a/scripts/selinux/install_policy.sh
>>>>>> +++ b/scripts/selinux/install_policy.sh
>>>>>> @@ -1,30 +1,51 @@
>>>>>>     #!/bin/sh
>>>>>>     # SPDX-License-Identifier: GPL-2.0
>>>>>> +set -e
>>>>>>     if [ `id -u` -ne 0 ]; then
>>>>>>     	echo "$0: must be root to install the selinux policy"
>>>>>>     	exit 1
>>>>>>     fi
>>>>>> +
>>>>>>     SF=`which setfiles`
>>>>>>     if [ $? -eq 1 ]; then
>>>>>> -	if [ -f /sbin/setfiles ]; then
>>>>>> -		SF="/usr/setfiles"
>>>>>> -	else
>>>>>> -		echo "no selinux tools installed: setfiles"
>>>>>> -		exit 1
>>>>>> -	fi
>>>>>> +	echo "Could not find setfiles"
>>>>>> +	echo "Do you have policycoreutils installed?"
>>>>>> +	exit 1
>>>>>>     fi
>>>>>> -cd mdp
>>>>>> -
>>>>>>     CP=`which checkpolicy`
>>>>>> +if [ $? -eq 1 ]; then
>>>>>> +	echo "Could not find checkpolicy"
>>>>>> +	echo "Do you have checkpolicy installed?"
>>>>>> +	exit 1
>>>>>> +fi
>>>>>>     VERS=`$CP -V | awk '{print $1}'`
>>>>>> -./mdp policy.conf file_contexts
>>>>>> -$CP -o policy.$VERS policy.conf
>>>>>> +ENABLED=`which selinuxenabled`
>>>>>> +if [ $? -eq 1 ]; then
>>>>>> +	echo "Could not find selinuxenabled"
>>>>>> +	echo "Do you have libselinux-utils installed?"
>>>>>> +	exit 1
>>>>>> +fi
>>>>>> +
>>>>>> +if selinuxenabled; then
>>>>>> +    echo "SELinux is already enabled"
>>>>>> +    echo "This prevents safely relabeling all files."
>>>>>> +    echo "Boot with selinux=0 on the kernel command-line or"
>>>>>> +    echo "SELINUX=disabled in /etc/selinux/config."
>>>>>> +    exit 1
>>>>>> +fi
>>>>>> +
>>>>>> +cd mdp
>>>>>> +./mdp -m policy.conf file_contexts
>>>>>> +$CP -U allow -M -o policy.$VERS policy.conf
>>>>>>     mkdir -p /etc/selinux/dummy/policy
>>>>>>     mkdir -p /etc/selinux/dummy/contexts/files
>>>>>> +echo "__default__:user_u" > /etc/selinux/dummy/seusers
>>>>>> +echo "base_r:base_t" > /etc/selinux/dummy/contexts/failsafe_context
>>>>>> +
>>>>>>     cp file_contexts /etc/selinux/dummy/contexts/files
>>>>>>     cp dbus_contexts /etc/selinux/dummy/contexts
>>>>>>     cp policy.$VERS /etc/selinux/dummy/policy
>>>>>> @@ -33,37 +54,22 @@ FC_FILE=/etc/selinux/dummy/contexts/files/file_contexts
>>>>>>     if [ ! -d /etc/selinux ]; then
>>>>>>     	mkdir -p /etc/selinux
>>>>>>     fi
>>>>>> -if [ ! -f /etc/selinux/config ]; then
>>>>>> -	cat > /etc/selinux/config << EOF
>>>>>> -SELINUX=enforcing
>>>>>> +if [ -f /etc/selinux/config ]; then
>>>>>> +    echo "/etc/selinux/config exists, moving to /etc/selinux/config.bak."
>>>>>> +    mv /etc/selinux/config /etc/selinux/config.bak
>>>>>> +fi
>>>>>> +echo "Creating new /etc/selinux/config for dummy policy."
>>>>>> +cat > /etc/selinux/config << EOF
>>>>>> +SELINUX=permissive
>>>>>>     SELINUXTYPE=dummy
>>>>>>     EOF
>>>>>> -else
>>>>>> -	TYPE=`cat /etc/selinux/config | grep "^SELINUXTYPE" | tail -1 | awk -F= '{ print $2 '}`
>>>>>> -	if [ "eq$TYPE" != "eqdummy" ]; then
>>>>>> -		selinuxenabled
>>>>>> -		if [ $? -eq 0 ]; then
>>>>>> -			echo "SELinux already enabled with a non-dummy policy."
>>>>>> -			echo "Exiting.  Please install policy by hand if that"
>>>>>> -			echo "is what you REALLY want."
>>>>>> -			exit 1
>>>>>> -		fi
>>>>>> -		mv /etc/selinux/config /etc/selinux/config.mdpbak
>>>>>> -		grep -v "^SELINUXTYPE" /etc/selinux/config.mdpbak >> /etc/selinux/config
>>>>>> -		echo "SELINUXTYPE=dummy" >> /etc/selinux/config
>>>>>> -	fi
>>>>>> -fi
>>>>>>     cd /etc/selinux/dummy/contexts/files
>>>>>> -$SF file_contexts /
>>>>>> +$SF -F file_contexts /
>>>>>> -mounts=`cat /proc/$$/mounts | egrep "ext2|ext3|xfs|jfs|ext4|ext4dev|gfs2" | awk '{ print $2 '}`
>>>>>> -$SF file_contexts $mounts
>>>>>> +mounts=`cat /proc/$$/mounts | \
>>>>>> +	egrep "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
>>>>>> +	awk '{ print $2 '}`
>>>>>> +$SF -F file_contexts $mounts
>>>>>> -
>>>>>> -dodev=`cat /proc/$$/mounts | grep "/dev "`
>>>>>> -if [ "eq$dodev" != "eq" ]; then
>>>>>> -	mount --move /dev /mnt
>>>>>> -	$SF file_contexts /dev
>>>>>> -	mount --move /mnt /dev
>>>>>> -fi
>>>>>> +touch /.autorelabel
>>>>>> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
>>>>>> index 073fe7537f6c..daad333c7252 100644
>>>>>> --- a/scripts/selinux/mdp/mdp.c
>>>>>> +++ b/scripts/selinux/mdp/mdp.c
>>>>>> @@ -33,6 +33,7 @@
>>>>>>     #include <unistd.h>
>>>>>>     #include <string.h>
>>>>>>     #include <sys/socket.h>
>>>>>> +#include <linux/kconfig.h>
>>>>>>     static void usage(char *name)
>>>>>>     {
>>>>>> @@ -95,10 +96,31 @@ int main(int argc, char *argv[])
>>>>>>     	}
>>>>>>     	fprintf(fout, "\n");
>>>>>> -	/* NOW PRINT OUT MLS STUFF */
>>>>>> +	/* print out mls declarations and constraints */
>>>>>>     	if (mls) {
>>>>>> -		printf("MLS not yet implemented\n");
>>>>>> -		exit(1);
>>>>>> +		fprintf(fout, "sensitivity s0;\n");
>>>>>> +		fprintf(fout, "sensitivity s1;\n");
>>>>>> +		fprintf(fout, "dominance { s0 s1 }\n");
>>>>>> +		fprintf(fout, "category c0;\n");
>>>>>> +		fprintf(fout, "category c1;\n");
>>>>>> +		fprintf(fout, "level s0:c0.c1;\n");
>>>>>> +		fprintf(fout, "level s1:c0.c1;\n");
>>>>>> +#define SYSTEMLOW "s0"
>>>>>> +#define SYSTEMHIGH "s1:c0.c1"
>>>>>> +		for (i = 0; secclass_map[i].name; i++) {
>>>>>> +			struct security_class_mapping *map = &secclass_map[i];
>>>>>> +
>>>>>> +			fprintf(fout, "mlsconstrain %s {\n", map->name);
>>>>>> +			for (j = 0; map->perms[j]; j++)
>>>>>> +				fprintf(fout, "\t%s\n", map->perms[j]);
>>>>>> +			/*
>>>>>> +			 * This requires all subjects and objects to be
>>>>>> +			 * single-level (l2 eq h2), and that the subject
>>>>>> +			 * level dominate the object level (h1 dom h2)
>>>>>> +			 * in order to have any permissions to it.
>>>>>> +			 */
>>>>>> +			fprintf(fout, "} (l2 eq h2 and h1 dom h2);\n\n");
>>>>>> +		}
>>>>>>     	}
>>>>>>     	/* types, roles, and allows */
>>>>>> @@ -108,34 +130,126 @@ int main(int argc, char *argv[])
>>>>>>     	for (i = 0; secclass_map[i].name; i++)
>>>>>>     		fprintf(fout, "allow base_t base_t:%s *;\n",
>>>>>>     			secclass_map[i].name);
>>>>>> -	fprintf(fout, "user user_u roles { base_r };\n");
>>>>>> -	fprintf(fout, "\n");
>>>>>> +	fprintf(fout, "user user_u roles { base_r }");
>>>>>> +	if (mls)
>>>>>> +		fprintf(fout, " level %s range %s - %s", SYSTEMLOW,
>>>>>> +			SYSTEMLOW, SYSTEMHIGH);
>>>>>> +	fprintf(fout, ";\n");
>>>>>> +
>>>>>> +#define SUBJUSERROLETYPE "user_u:base_r:base_t"
>>>>>> +#define OBJUSERROLETYPE "user_u:object_r:base_t"
>>>>>>     	/* default sids */
>>>>>>     	for (i = 1; i < initial_sid_to_string_len; i++)
>>>>>> -		fprintf(fout, "sid %s user_u:base_r:base_t\n", initial_sid_to_string[i]);
>>>>>> +		fprintf(fout, "sid %s " SUBJUSERROLETYPE "%s\n",
>>>>>> +			initial_sid_to_string[i], mls ? ":" SYSTEMLOW : "");
>>>>>>     	fprintf(fout, "\n");
>>>>>> -	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
>>>>>> -	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
>>>>>> -	fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
>>>>>> -	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
>>>>>> -	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
>>>>>> -	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
>>>>>> -	fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
>>>>>> -	fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
>>>>>> +#define FS_USE(behavior, fstype)			    \
>>>>>> +	fprintf(fout, "fs_use_%s %s " OBJUSERROLETYPE "%s;\n", \
>>>>>> +		behavior, fstype, mls ? ":" SYSTEMLOW : "")
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Filesystems whose inode labels can be fetched via getxattr.
>>>>>> +	 */
>>>>>> +#ifdef CONFIG_EXT2_FS_SECURITY
>>>>>> +	FS_USE("xattr", "ext2");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_EXT3_FS_SECURITY
>>>>>> +	FS_USE("xattr", "ext3");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_EXT4_FS_SECURITY
>>>>>> +	FS_USE("xattr", "ext4");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_JFS_SECURITY
>>>>>> +	FS_USE("xattr", "jfs");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_REISERFS_FS_SECURITY
>>>>>> +	FS_USE("xattr", "reiserfs");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_JFFS2_FS_SECURITY
>>>>>> +	FS_USE("xattr", "jffs2");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_XFS_FS
>>>>>> +	FS_USE("xattr", "xfs");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_GFS2_FS
>>>>>> +	FS_USE("xattr", "gfs2");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_BTRFS_FS
>>>>>> +	FS_USE("xattr", "btrfs");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_F2FS_FS_SECURITY
>>>>>> +	FS_USE("xattr", "f2fs");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_OCFS2_FS
>>>>>> +	FS_USE("xattr", "ocsfs2");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_OVERLAY_FS
>>>>>> +	FS_USE("xattr", "overlay");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_SQUASHFS_XATTR
>>>>>> +	FS_USE("xattr", "squashfs");
>>>>>> +#endif
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Filesystems whose inodes are labeled from allocating task.
>>>>>> +	 */
>>>>>> +	FS_USE("task", "pipefs");
>>>>>> +	FS_USE("task", "sockfs");
>>>>>> -	fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t;\n");
>>>>>> -	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
>>>>>> -	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
>>>>>> +	/*
>>>>>> +	 * Filesystems whose inode labels are computed from both
>>>>>> +	 * the allocating task and the superblock label.
>>>>>> +	 */
>>>>>> +#ifdef CONFIG_UNIX98_PTYS
>>>>>> +	FS_USE("trans", "devpts");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_HUGETLBFS
>>>>>> +	FS_USE("trans", "hugetlbfs");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_TMPFS
>>>>>> +	FS_USE("trans", "tmpfs");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_DEVTMPFS
>>>>>> +	FS_USE("trans", "devtmpfs");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_POSIX_MQUEUE
>>>>>> +	FS_USE("trans", "mqueue");
>>>>>> +#endif
>>>>>> -	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
>>>>>> -	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
>>>>>> -	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
>>>>>> -	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
>>>>>> -	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
>>>>>> +#define GENFSCON(fstype, prefix)			     \
>>>>>> +	fprintf(fout, "genfscon %s %s " OBJUSERROLETYPE "%s\n", \
>>>>>> +		fstype, prefix, mls ? ":" SYSTEMLOW : "")
>>>>>> -	fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
>>>>>> +	/*
>>>>>> +	 * Filesystems whose inodes are labeled from path prefix match
>>>>>> +	 * relative to the filesystem root.  Depending on the filesystem,
>>>>>> +	 * only a single label for all inodes may be supported.  Here
>>>>>> +	 * we list the filesystem types for which per-file labeling is
>>>>>> +	 * supported using genfscon; any other filesystem type can also
>>>>>> +	 * be added by only with a single entry for all of its inodes.
>>>>>> +	 */
>>>>>> +#ifdef CONFIG_PROC_FS
>>>>>> +	GENFSCON("proc", "/");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_SECURITY_SELINUX
>>>>>> +	GENFSCON("selinuxfs", "/");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_SYSFS
>>>>>> +	GENFSCON("sysfs", "/");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_DEBUG_FS
>>>>>> +	GENFSCON("debugfs", "/");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_TRACING
>>>>>> +	GENFSCON("tracefs", "/");
>>>>>> +#endif
>>>>>> +#ifdef CONFIG_PSTORE
>>>>>> +	GENFSCON("pstore", "/");
>>>>>> +#endif
>>>>>> +	GENFSCON("cgroup", "/");
>>>>>> +	GENFSCON("cgroup2", "/");
>>>>>>     	fclose(fout);
>>>>>> @@ -144,8 +258,8 @@ int main(int argc, char *argv[])
>>>>>>     		printf("Wrote policy, but cannot open %s for writing\n", ctxout);
>>>>>>     		usage(argv[0]);
>>>>>>     	}
>>>>>> -	fprintf(fout, "/ user_u:base_r:base_t\n");
>>>>>> -	fprintf(fout, "/.* user_u:base_r:base_t\n");
>>>>>> +	fprintf(fout, "/ " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
>>>>>> +	fprintf(fout, "/.* " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
>>>>>>     	fclose(fout);
>>>>>>     	return 0;
>>>>>>
>>>>>
>>>>
>>>
>>
>

-- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
