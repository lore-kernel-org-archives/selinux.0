Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB41C43381
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 13:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B22206B7
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 13:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVTAxPKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfBVNkJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:40:09 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41516 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBVNkJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 08:40:09 -0500
Received: by mail-ed1-f68.google.com with SMTP id x7so1765188eds.8
        for <selinux@vger.kernel.org>; Fri, 22 Feb 2019 05:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mg+84RAeQkM5W+SCJkMFATX8zJI7FcXk5clyGoO6vaU=;
        b=uVTAxPKU4ueyUH2TQhwY9p560Xp9jayHBAziOgcThqcKeLwLzVZwIZxmoXInG5/RZq
         sXhZMj/whj76M/sTKi5BbHCn/flDg6OStqC8g7MDru084xkgfouwk2LZNxizOKhRoQcR
         +zsla2C12xq1Z9NEBvGswar/St8LllGLuIyi3Z925npTXL/9/5KVQ4kj0jDUdRRvZ8cj
         riONlFfQywrVqxTwvvDQMnSKA6V3Ulp0pO23iygqW3Izjs78u57P9qOmHvrwHFi9a6k4
         8WU9vPeV8lguuU95bx+k1UcjP8LK/fgq76jyFjXtJKzHYTjxI2T5vtu+8G6YsEpqqylz
         n9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=mg+84RAeQkM5W+SCJkMFATX8zJI7FcXk5clyGoO6vaU=;
        b=RIWytTS0Av2C+gBmQEGJxOrRAdED7B68MgMoOJRvIV4+q9ijrp4o2oGKwaXtgg9Nxk
         om0Rm7fZRHI1DTigxV8Pz02ygdVF181FBRrvBRmxQDxZgdwYqJIs3HEoAsWF/22Eeako
         dIj5PBddBBYZTJTWof1Q9JWNXW7DBsRrhrDyYYkvAGMwDcj485H/YBXWQaf+2T8lZ4Wa
         gkhnW53L54nz8IplkckLwfvEw/mQA/ftCyXHdZ5qnSKzA2fpEVjqm0A0swnQxFMqCG4k
         lFeES99xpb1ZV2S6weI7RfOGYGhx7cilN7TUvkemS3+/toEXereM5R7bEnXH8VBwXdEJ
         nEAw==
X-Gm-Message-State: AHQUAuagc1KECXflWFdiM09h5Yej8WRL1gmfNeMEB52PvR2egifY63uQ
        8dvr2xFPYt4wk5hqcXWaC1g86Nf1
X-Google-Smtp-Source: AHgI3IbwxADYAB2oSX9BVCGL5YLSNztwJad8Y1BKVQ+xIDcxpASMJd+1aSEKRxBU7iuDzirZrgSg8A==
X-Received: by 2002:aa7:db14:: with SMTP id t20mr3210667eds.231.1550842805636;
        Fri, 22 Feb 2019 05:40:05 -0800 (PST)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id z13sm407412edk.75.2019.02.22.05.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 05:40:04 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Dominick Grift <dominick.grift@defensec.nl>, paul@paul-moore.com,
        selinux@vger.kernel.org
Subject: Re: [PATCH v6] scripts/selinux: modernize mdp
References: <20190221213147.1590-1-sds@tycho.nsa.gov>
        <20190222085518.GA28321@brutus.lan>
        <2ad07cfb-33a6-d9cc-f442-560905b4d646@tycho.nsa.gov>
Date:   Fri, 22 Feb 2019 14:40:04 +0100
In-Reply-To: <2ad07cfb-33a6-d9cc-f442-560905b4d646@tycho.nsa.gov> (Stephen
        Smalley's message of "Fri, 22 Feb 2019 08:04:48 -0500")
Message-ID: <87o9746ix7.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 2/22/19 3:55 AM, Dominick Grift wrote:
>> On Thu, Feb 21, 2019 at 04:31:47PM -0500, Stephen Smalley wrote:
>>> Derived in part from a patch by Dominick Grift.
>>>
>>> The MDP example no longer works on modern systems.  Fix it.
>>> While we are at it, add MLS support and enable it.
>>>
>>> NB This still does not work on systems using dbus-daemon instead of
>>> dbus-broker because dbus-daemon does not yet gracefully handle unknown
>>> classes/permissions.  This appears to be a deficiency in libselinux's
>>> selinux_set_mapping() interface and underlying implementation,
>>> which was never fully updated to deal with unknown classes/permissions
>>> unlike the kernel.  The same problem also occurs with XSELinux.
>>> Programs that instead use selinux_check_access() like dbus-broker
>>> should not have this problem.
>>>
>>> Changes to mdp:
>>> Add support for devtmpfs, required by modern Linux distributions.
>>> Add MLS support, with sample sensitivities, categories, and constraints.
>>> Generate fs_use and genfscon rules based on kernel configuration.
>>> Update list of filesystem types for fs_use and genfscon rules.
>>> Use object_r for object contexts.
>>>
>>> Changes to install_policy.sh:
>>> Bail immediately on any errors.
>>> Provide more helpful error messages when unable to find userspace tools.
>>> Refuse to run if SELinux is already enabled.
>>> Unconditionally move aside /etc/selinux/config and create a new one.
>>> Build policy with -U allow so that userspace object managers do not break.
>>> Build policy with MLS enabled by default.
>>> Create seusers, failsafe_context, and default_contexts for use by
>>> pam_selinux / libselinux.
>>> Create x_contexts for the SELinux X extension.
>>> Create virtual_domain_context and virtual_image_context for libvirtd.
>>> Set to permissive mode rather than enforcing to permit initial autorelabel.
>>> Update the list of filesystem types to be relabeled.
>>> Write -F to /.autorelabel to cause a forced autorelabel on reboot.
>>> Drop broken attempt to relabel the /dev mountpoint directory.
>>>
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> ---
>>> v6 fixes the seusers and failsafe_contexts to include :s0
>>> as per Dominick's comments. It also adds a default_contexts
>>> configuration for good measure, although this might not be
>>> necessary. It creates a minimal working x_contexts configuration
>>> to appease XSELinux, although XSELinux still has problems due
>>> to the lack of the userspace class/perms definitions. It
>>> creates empty virtual_*_context files to make libvirtd happy.
>>> It writes -F to /.autorelabel as per Dominick's comments to
>>> trigger a forced relabel. It also fixes mdp to correctly generate
>>> fs_use rules for ext3 and ext2 when using ext4 as the driver.
>>> These days ext4 is always used to handle ext3 mounts and it can
>>> also be used for ext2.  This version is called v6 to distinguish it from
>>> Dominick's earlier patch sequence, which went up to v4, and then
>>> my previous coalesced patch is logically v5.
>>>
>>>   scripts/selinux/install_policy.sh |  92 ++++++++++-------
>>>   scripts/selinux/mdp/mdp.c         | 165 +++++++++++++++++++++++++-----
>>>   2 files changed, 194 insertions(+), 63 deletions(-)
>>
>> Acked-by: Dominick Grift <dominick.grift@defensec.nl>
>>
>> I was pretty sure that seusers entries need both current as well as
>> clearance (s0-s0 instead of just s0) but just s0 works in this
>> scenario atleast
>
> They should be semantically equivalent; s0 means both low and high
> levels are s0, while s0-s0 means that same thing.  You only need to
> explicitly specify separate low-high levels if they differ.  s0 is
> essentially shorthand for s0-s0, just like c0.c3 is shorthand for
> c0,c1,c2,c3.

That is what I expected too. Something prompted me to explicitly specify
s0-s0 in dssp2 though. It may have been a wrong observation or may be a
bug somewhere in dssp2. I'd have to look into it. It works fine with
dummy, indeed

>
>> I did not test the X and virt_contexts aspects.
>
> It occurred to me that part of the problem I am having with XWayland
> might be due to the absence of the xserver_object_manager boolean in
> the dummy policy.  In targeted policy, that boolean determines whether
> or not XSELinux enables its object manager functionality (defaults to
> false in targeted policy).  Possibly I should add a stub bool
> xserver_object_manager false; declaration to the mdp-generated policy
> to disable XSELinux at runtime.
>
> I also have a patch that tries to add the support for unknown
> classes/perms to selinux_set_mapping() to fix dbus-daemon, but I'm
> still testing it.  XSELinux is still falling over with that patch but
> I think that might be a bug in XSELinux/XWayland.

Not sure if i would go into that rabbit hole of trying to support any
non-essential user space object managers in dummy.

BTW. XACE does work. I leverage it in dssp2-standard to isolate flatpaks
(block screenscraping, keylogging, and clipboard reading) It's rough and
there seems to be a bug in the DRI3 code that prevents the
screenscraping part from working except in environmets without DRI3 like
XQL/Spice.

Main issue is that X clients often can't deal properly with the presence
of XACE. One annoying example is the clipboard isolation. I often by instinct try to
paste urls from my browers into my flatpak'ed IRC client, but since XACE does not allow the
flatpak to read the clipboard selection, the IRC client instantly crashes

>
>>
>>>
>>> diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
>>> index 0b86c47baf7d..2dccf141241d 100755
>>> --- a/scripts/selinux/install_policy.sh
>>> +++ b/scripts/selinux/install_policy.sh
>>> @@ -1,30 +1,61 @@
>>>   #!/bin/sh
>>>   # SPDX-License-Identifier: GPL-2.0
>>> +set -e
>>>   if [ `id -u` -ne 0 ]; then
>>>   	echo "$0: must be root to install the selinux policy"
>>>   	exit 1
>>>   fi
>>> +
>>>   SF=`which setfiles`
>>>   if [ $? -eq 1 ]; then
>>> -	if [ -f /sbin/setfiles ]; then
>>> -		SF="/usr/setfiles"
>>> -	else
>>> -		echo "no selinux tools installed: setfiles"
>>> -		exit 1
>>> -	fi
>>> +	echo "Could not find setfiles"
>>> +	echo "Do you have policycoreutils installed?"
>>> +	exit 1
>>>   fi
>>>   -cd mdp
>>> -
>>>   CP=`which checkpolicy`
>>> +if [ $? -eq 1 ]; then
>>> +	echo "Could not find checkpolicy"
>>> +	echo "Do you have checkpolicy installed?"
>>> +	exit 1
>>> +fi
>>>   VERS=`$CP -V | awk '{print $1}'`
>>>   -./mdp policy.conf file_contexts
>>> -$CP -o policy.$VERS policy.conf
>>> +ENABLED=`which selinuxenabled`
>>> +if [ $? -eq 1 ]; then
>>> +	echo "Could not find selinuxenabled"
>>> +	echo "Do you have libselinux-utils installed?"
>>> +	exit 1
>>> +fi
>>> +
>>> +if selinuxenabled; then
>>> +    echo "SELinux is already enabled"
>>> +    echo "This prevents safely relabeling all files."
>>> +    echo "Boot with selinux=0 on the kernel command-line or"
>>> +    echo "SELINUX=disabled in /etc/selinux/config."
>>> +    exit 1
>>> +fi
>>> +
>>> +cd mdp
>>> +./mdp -m policy.conf file_contexts
>>> +$CP -U allow -M -o policy.$VERS policy.conf
>>>     mkdir -p /etc/selinux/dummy/policy
>>>   mkdir -p /etc/selinux/dummy/contexts/files
>>>   +echo "__default__:user_u:s0" > /etc/selinux/dummy/seusers
>>> +echo "base_r:base_t:s0" > /etc/selinux/dummy/contexts/failsafe_context
>>> +echo "base_r:base_t:s0 base_r:base_t:s0" > /etc/selinux/dummy/default_contexts
>>> +cat > /etc/selinux/dummy/contexts/x_contexts <<EOF
>>> +client * user_u:base_r:base_t:s0
>>> +property * user_u:object_r:base_t:s0
>>> +extension * user_u:object_r:base_t:s0
>>> +selection * user_u:object_r:base_t:s0
>>> +event * user_u:object_r:base_t:s0
>>> +EOF
>>> +touch /etc/selinux/dummy/contexts/virtual_domain_context
>>> +touch /etc/selinux/dummy/contexts/virtual_image_context
>>> +
>>>   cp file_contexts /etc/selinux/dummy/contexts/files
>>>   cp dbus_contexts /etc/selinux/dummy/contexts
>>>   cp policy.$VERS /etc/selinux/dummy/policy
>>> @@ -33,37 +64,22 @@ FC_FILE=/etc/selinux/dummy/contexts/files/file_contexts
>>>   if [ ! -d /etc/selinux ]; then
>>>   	mkdir -p /etc/selinux
>>>   fi
>>> -if [ ! -f /etc/selinux/config ]; then
>>> -	cat > /etc/selinux/config << EOF
>>> -SELINUX=enforcing
>>> +if [ -f /etc/selinux/config ]; then
>>> +    echo "/etc/selinux/config exists, moving to /etc/selinux/config.bak."
>>> +    mv /etc/selinux/config /etc/selinux/config.bak
>>> +fi
>>> +echo "Creating new /etc/selinux/config for dummy policy."
>>> +cat > /etc/selinux/config << EOF
>>> +SELINUX=permissive
>>>   SELINUXTYPE=dummy
>>>   EOF
>>> -else
>>> -	TYPE=`cat /etc/selinux/config | grep "^SELINUXTYPE" | tail -1 | awk -F= '{ print $2 '}`
>>> -	if [ "eq$TYPE" != "eqdummy" ]; then
>>> -		selinuxenabled
>>> -		if [ $? -eq 0 ]; then
>>> -			echo "SELinux already enabled with a non-dummy policy."
>>> -			echo "Exiting.  Please install policy by hand if that"
>>> -			echo "is what you REALLY want."
>>> -			exit 1
>>> -		fi
>>> -		mv /etc/selinux/config /etc/selinux/config.mdpbak
>>> -		grep -v "^SELINUXTYPE" /etc/selinux/config.mdpbak >> /etc/selinux/config
>>> -		echo "SELINUXTYPE=dummy" >> /etc/selinux/config
>>> -	fi
>>> -fi
>>>     cd /etc/selinux/dummy/contexts/files
>>> -$SF file_contexts /
>>> +$SF -F file_contexts /
>>>   -mounts=`cat /proc/$$/mounts | egrep
>>> "ext2|ext3|xfs|jfs|ext4|ext4dev|gfs2" | awk '{ print $2 '}`
>>> -$SF file_contexts $mounts
>>> +mounts=`cat /proc/$$/mounts | \
>>> +	egrep "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
>>> +	awk '{ print $2 '}`
>>> +$SF -F file_contexts $mounts
>>>   -
>>> -dodev=`cat /proc/$$/mounts | grep "/dev "`
>>> -if [ "eq$dodev" != "eq" ]; then
>>> -	mount --move /dev /mnt
>>> -	$SF file_contexts /dev
>>> -	mount --move /mnt /dev
>>> -fi
>>> +echo "-F" > /.autorelabel
>>> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
>>> index 073fe7537f6c..edaba8e51651 100644
>>> --- a/scripts/selinux/mdp/mdp.c
>>> +++ b/scripts/selinux/mdp/mdp.c
>>> @@ -33,6 +33,7 @@
>>>   #include <unistd.h>
>>>   #include <string.h>
>>>   #include <sys/socket.h>
>>> +#include <linux/kconfig.h>
>>>     static void usage(char *name)
>>>   {
>>> @@ -95,10 +96,31 @@ int main(int argc, char *argv[])
>>>   	}
>>>   	fprintf(fout, "\n");
>>>   -	/* NOW PRINT OUT MLS STUFF */
>>> +	/* print out mls declarations and constraints */
>>>   	if (mls) {
>>> -		printf("MLS not yet implemented\n");
>>> -		exit(1);
>>> +		fprintf(fout, "sensitivity s0;\n");
>>> +		fprintf(fout, "sensitivity s1;\n");
>>> +		fprintf(fout, "dominance { s0 s1 }\n");
>>> +		fprintf(fout, "category c0;\n");
>>> +		fprintf(fout, "category c1;\n");
>>> +		fprintf(fout, "level s0:c0.c1;\n");
>>> +		fprintf(fout, "level s1:c0.c1;\n");
>>> +#define SYSTEMLOW "s0"
>>> +#define SYSTEMHIGH "s1:c0.c1"
>>> +		for (i = 0; secclass_map[i].name; i++) {
>>> +			struct security_class_mapping *map = &secclass_map[i];
>>> +
>>> +			fprintf(fout, "mlsconstrain %s {\n", map->name);
>>> +			for (j = 0; map->perms[j]; j++)
>>> +				fprintf(fout, "\t%s\n", map->perms[j]);
>>> +			/*
>>> +			 * This requires all subjects and objects to be
>>> +			 * single-level (l2 eq h2), and that the subject
>>> +			 * level dominate the object level (h1 dom h2)
>>> +			 * in order to have any permissions to it.
>>> +			 */
>>> +			fprintf(fout, "} (l2 eq h2 and h1 dom h2);\n\n");
>>> +		}
>>>   	}
>>>     	/* types, roles, and allows */
>>> @@ -108,34 +130,127 @@ int main(int argc, char *argv[])
>>>   	for (i = 0; secclass_map[i].name; i++)
>>>   		fprintf(fout, "allow base_t base_t:%s *;\n",
>>>   			secclass_map[i].name);
>>> -	fprintf(fout, "user user_u roles { base_r };\n");
>>> -	fprintf(fout, "\n");
>>> +	fprintf(fout, "user user_u roles { base_r }");
>>> +	if (mls)
>>> +		fprintf(fout, " level %s range %s - %s", SYSTEMLOW,
>>> +			SYSTEMLOW, SYSTEMHIGH);
>>> +	fprintf(fout, ";\n");
>>> +
>>> +#define SUBJUSERROLETYPE "user_u:base_r:base_t"
>>> +#define OBJUSERROLETYPE "user_u:object_r:base_t"
>>>     	/* default sids */
>>>   	for (i = 1; i < initial_sid_to_string_len; i++)
>>> -		fprintf(fout, "sid %s user_u:base_r:base_t\n", initial_sid_to_string[i]);
>>> +		fprintf(fout, "sid %s " SUBJUSERROLETYPE "%s\n",
>>> +			initial_sid_to_string[i], mls ? ":" SYSTEMLOW : "");
>>>   	fprintf(fout, "\n");
>>>   -	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
>>> -	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
>>> -	fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
>>> -	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
>>> -	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
>>> -	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
>>> -	fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
>>> -	fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
>>> +#define FS_USE(behavior, fstype)			    \
>>> +	fprintf(fout, "fs_use_%s %s " OBJUSERROLETYPE "%s;\n", \
>>> +		behavior, fstype, mls ? ":" SYSTEMLOW : "")
>>> +
>>> +	/*
>>> +	 * Filesystems whose inode labels can be fetched via getxattr.
>>> +	 */
>>> +#ifdef CONFIG_EXT2_FS_SECURITY
>>> +	FS_USE("xattr", "ext2");
>>> +#endif
>>> +#ifdef CONFIG_EXT4_FS_SECURITY
>>> +#ifdef CONFIG_EXT4_USE_FOR_EXT2
>>> +	FS_USE("xattr", "ext2");
>>> +#endif
>>> +	FS_USE("xattr", "ext3");
>>> +	FS_USE("xattr", "ext4");
>>> +#endif
>>> +#ifdef CONFIG_JFS_SECURITY
>>> +	FS_USE("xattr", "jfs");
>>> +#endif
>>> +#ifdef CONFIG_REISERFS_FS_SECURITY
>>> +	FS_USE("xattr", "reiserfs");
>>> +#endif
>>> +#ifdef CONFIG_JFFS2_FS_SECURITY
>>> +	FS_USE("xattr", "jffs2");
>>> +#endif
>>> +#ifdef CONFIG_XFS_FS
>>> +	FS_USE("xattr", "xfs");
>>> +#endif
>>> +#ifdef CONFIG_GFS2_FS
>>> +	FS_USE("xattr", "gfs2");
>>> +#endif
>>> +#ifdef CONFIG_BTRFS_FS
>>> +	FS_USE("xattr", "btrfs");
>>> +#endif
>>> +#ifdef CONFIG_F2FS_FS_SECURITY
>>> +	FS_USE("xattr", "f2fs");
>>> +#endif
>>> +#ifdef CONFIG_OCFS2_FS
>>> +	FS_USE("xattr", "ocsfs2");
>>> +#endif
>>> +#ifdef CONFIG_OVERLAY_FS
>>> +	FS_USE("xattr", "overlay");
>>> +#endif
>>> +#ifdef CONFIG_SQUASHFS_XATTR
>>> +	FS_USE("xattr", "squashfs");
>>> +#endif
>>> +
>>> +	/*
>>> +	 * Filesystems whose inodes are labeled from allocating task.
>>> +	 */
>>> +	FS_USE("task", "pipefs");
>>> +	FS_USE("task", "sockfs");
>>>   -	fprintf(fout, "fs_use_task eventpollfs
>>> user_u:base_r:base_t;\n");
>>> -	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
>>> -	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
>>> +	/*
>>> +	 * Filesystems whose inode labels are computed from both
>>> +	 * the allocating task and the superblock label.
>>> +	 */
>>> +#ifdef CONFIG_UNIX98_PTYS
>>> +	FS_USE("trans", "devpts");
>>> +#endif
>>> +#ifdef CONFIG_HUGETLBFS
>>> +	FS_USE("trans", "hugetlbfs");
>>> +#endif
>>> +#ifdef CONFIG_TMPFS
>>> +	FS_USE("trans", "tmpfs");
>>> +#endif
>>> +#ifdef CONFIG_DEVTMPFS
>>> +	FS_USE("trans", "devtmpfs");
>>> +#endif
>>> +#ifdef CONFIG_POSIX_MQUEUE
>>> +	FS_USE("trans", "mqueue");
>>> +#endif
>>>   -	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
>>> -	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
>>> -	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
>>> -	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
>>> -	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
>>> +#define GENFSCON(fstype, prefix)			     \
>>> +	fprintf(fout, "genfscon %s %s " OBJUSERROLETYPE "%s\n", \
>>> +		fstype, prefix, mls ? ":" SYSTEMLOW : "")
>>>   -	fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
>>> +	/*
>>> +	 * Filesystems whose inodes are labeled from path prefix match
>>> +	 * relative to the filesystem root.  Depending on the filesystem,
>>> +	 * only a single label for all inodes may be supported.  Here
>>> +	 * we list the filesystem types for which per-file labeling is
>>> +	 * supported using genfscon; any other filesystem type can also
>>> +	 * be added by only with a single entry for all of its inodes.
>>> +	 */
>>> +#ifdef CONFIG_PROC_FS
>>> +	GENFSCON("proc", "/");
>>> +#endif
>>> +#ifdef CONFIG_SECURITY_SELINUX
>>> +	GENFSCON("selinuxfs", "/");
>>> +#endif
>>> +#ifdef CONFIG_SYSFS
>>> +	GENFSCON("sysfs", "/");
>>> +#endif
>>> +#ifdef CONFIG_DEBUG_FS
>>> +	GENFSCON("debugfs", "/");
>>> +#endif
>>> +#ifdef CONFIG_TRACING
>>> +	GENFSCON("tracefs", "/");
>>> +#endif
>>> +#ifdef CONFIG_PSTORE
>>> +	GENFSCON("pstore", "/");
>>> +#endif
>>> +	GENFSCON("cgroup", "/");
>>> +	GENFSCON("cgroup2", "/");
>>>     	fclose(fout);
>>>   @@ -144,8 +259,8 @@ int main(int argc, char *argv[])
>>>   		printf("Wrote policy, but cannot open %s for writing\n", ctxout);
>>>   		usage(argv[0]);
>>>   	}
>>> -	fprintf(fout, "/ user_u:base_r:base_t\n");
>>> -	fprintf(fout, "/.* user_u:base_r:base_t\n");
>>> +	fprintf(fout, "/ " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
>>> +	fprintf(fout, "/.* " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
>>>   	fclose(fout);
>>>     	return 0;
>>> -- 
>>> 2.20.1
>>>
>>
>

-- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
