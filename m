Return-Path: <SRS0=eFyr=Q4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FC5C43381
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 20:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5C12080F
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 20:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="X3eEGO37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfBUUXL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:23:11 -0500
Received: from upbd19pa07.eemsg.mail.mil ([214.24.27.82]:53081 "EHLO
        upbd19pa07.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfBUUXK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Feb 2019 15:23:10 -0500
X-EEMSG-check-017: 201554779|UPBD19PA07_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa07.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Feb 2019 20:22:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550780568; x=1582316568;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Er1f5ePXbfDksB1j2Jd4HVbNnRqG4Cjw6/7hGbr3YcA=;
  b=X3eEGO37QoO36zeOK0H3pxuGZmO5x2sfo7ZWfz4Ib2CUESFpx1qDNUh9
   uJRy6ZI2zHWBtgl1BA5cRHIh4bC97oEvpIhRZrd8yRbfq1gtTIodK/zXq
   IKpCvhxudjh3AWave7kOs85Vv1KMfXNfoUUyEKSnIs5OUESZx8TQ2oq7K
   jfjVr7KdlLVe6EM/iLQxuqHAJohTfXEtyW+jranVNC/xAHry0UcEMnTf0
   47kLNmHfwxkN2mOZXe9yFfHW1IrqXPuiSTxs2OYlq63MQEePMMr++9iEo
   q3C66h3fhqthdoYb/ihY+IuAW+Q5j+FFeHKR6y0k+MBDpygqWuVd0geW3
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,396,1544486400"; 
   d="scan'208";a="24191975"
IronPort-PHdr: =?us-ascii?q?9a23=3AKQ/UbxDRAJ6lT8VQAPrNUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX8r8bcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEfYNMeNeooLgpVUBsAG+CBGxCu3xxD9Ghnz406M03O?=
 =?us-ascii?q?suEw7JwAMuEskSsHnWttj5KLseXO63waTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqHpxQtySAOIt3RMMvW3pntzw5yrEcvJ?=
 =?us-ascii?q?67YjAGyIwgxx7bavyIb4iJ7gj/W+mLPTd1gm9udrGnhxuq7EStxeLxWtO03V?=
 =?us-ascii?q?pXtCZJjNbBum4X2xDO7MWMV+Fz8V272TmV0gDe8uREIUcpmqXFM5Mh2bswlo?=
 =?us-ascii?q?YLsUTEAy/2hF36jK+IeUUg/eil8/jnba/8pp+dKo90kRvyMrgum8OjAeQ4NR?=
 =?us-ascii?q?ICX26H9uSnyLLv50j5QLROjvEuk6nZto7VJdgDq6KkDAJY3Zwv5haiAzu8zt?=
 =?us-ascii?q?gVkmcLIEhYdB6fiojmIVDOIPT2DfelhFSslS9mx+vbMb36GZjNMnjCn6vhfb?=
 =?us-ascii?q?Z68UJczhEzwspF65JbDbEBPur/WlXtu9zAEh85Lwu0zv76B9V604MeWGSPAq?=
 =?us-ascii?q?6FP6PRq1OI6fgvI+iCZI8JozvyNuYq5/Dwgn8/gl8SY7Wm0YERaHC8Bv5mOV?=
 =?us-ascii?q?mWYWLwgtcdFmcHphI+Q/b3iF2GSjNTf2y9X7845j0iDYKmCoDDRpqzj7CbwC?=
 =?us-ascii?q?i7GZhWbHhcCl+QCXfoa5mEW/AUZSKJPMBhlj0EVb68S44uzhyuqgD6xKR9Lu?=
 =?us-ascii?q?bO+S0Xq4jj1N5r6O3Xjx0y8iZ0D8vOm12KGk1zm2IORjQ1lI9loEJhggOP1q?=
 =?us-ascii?q?15hf1TFppc/fJHTi82OJDRyfd3AJb0XlSSUM2OTQOdXti+ATw3Buk0ytsKbl?=
 =?us-ascii?q?c1T86ulTjfziGqBPkTjLXNC5sqpPGPl0PtLtpwni6VnJIqiEMrF44WbzWr?=
X-IPAS-Result: =?us-ascii?q?A2ALAABcB29c/wHyM5BlGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYFZKmeBAyeEB4gajCEBAQEBAQEGgRAliTuOY4F7LAwBgSoBgxUCg3oiN?=
 =?us-ascii?q?AkNAQMBAQEBAQECAWwogjopAYJnAQUjBBFBEAsYAgImAgJXBg0GAgEBgl89A?=
 =?us-ascii?q?YFlDaxKfDOFRIRrgQuLPRd4gQeBEScMgl+EWoMwglcCigaGSEs7kX8Jhz6Db?=
 =?us-ascii?q?4crBhmBcYVailxki1mNT4UWOIFWKwgCGAghDzuCbAmCHxeOPCEDMIEFAQGMN?=
 =?us-ascii?q?4JNAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 21 Feb 2019 20:22:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1LKMkLC002981;
        Thu, 21 Feb 2019 15:22:46 -0500
Subject: Re: [PATCH] scripts/selinux: modernize mdp
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     paul@paul-moore.com, selinux@vger.kernel.org
References: <20190221184213.31303-1-sds@tycho.nsa.gov>
 <20190221201142.GB28703@brutus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e1a257e6-fed3-9614-e243-1c8825cdf56a@tycho.nsa.gov>
Date:   Thu, 21 Feb 2019 15:22:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221201142.GB28703@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/21/19 3:11 PM, Dominick Grift wrote:
> On Thu, Feb 21, 2019 at 01:42:13PM -0500, Stephen Smalley wrote:
>> Derived in part from a patch by Dominick Grift.
>>
>> The MDP example no longer works on modern systems.  Fix it.
>> While we are at it, add MLS support and enable it.
>>
>> NB This still does not work on systems using dbus-daemon instead of
>> dbus-broker because dbus-daemon does not yet gracefully handle unknown
>> classes/permissions.  This is a deficiency in libselinux's
>> selinux_set_mapping() interface and underlying implementation,
>> which was never fully updated to deal with unknown classes/permissions
>> unlike the kernel.  Programs that instead use selinux_check_access()
>> like dbus-broker do not have this problem.
>>
>> Other known issues:
>> - Not everything appears to be relabeled, so some files are left with invalid
>> contexts and remapped to the unlabeled SID/context.
>> - X will fail due to lack of a x_contexts file
>> - libvirtd will fail due to lack of a virtual_domain_context file
>> - crond reports an error with "No security context"
>>
>> Changes to mdp:
>> Add support for devtmpfs, required by modern Linux distributions.
>> Add MLS support, with sample sensitivities, categories, and constraints.
>> Generate fs_use and genfscon rules based on kernel configuration.
>> Update list of filesystem types for fs_use and genfscon rules.
>> Use object_r for object contexts.
>>
>> Changes to install_policy.sh:
>> Bail immediately on any errors.
>> Provide more helpful error messages when unable to find userspace tools.
>> Refuse to run if SELinux is already enabled.
>> Unconditionally move aside /etc/selinux/config and create a new one.
>> Build policy with -U allow so that userspace object managers do not break.
>> Build policy with MLS enabled by default.
>> Add default seusers mapping and failsafe context for use by
>> pam_selinux / libselinux.
>> Set to permissive mode rather than enforcing to permit initial autorelabel.
>> Update the list of filesystem types to be relabeled.
>> Create /.autorelabel to trigger an autorelabel on reboot.
>> Drop broken attempt to relabel the /dev mountpoint directory.
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>>   scripts/selinux/install_policy.sh |  82 ++++++++-------
>>   scripts/selinux/mdp/mdp.c         | 164 +++++++++++++++++++++++++-----
>>   2 files changed, 183 insertions(+), 63 deletions(-)
>>
>> diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
>> index 0b86c47baf7d..09eab4d0da5c 100755
>> --- a/scripts/selinux/install_policy.sh
>> +++ b/scripts/selinux/install_policy.sh
>> @@ -1,30 +1,51 @@
>>   #!/bin/sh
>>   # SPDX-License-Identifier: GPL-2.0
>> +set -e
>>   if [ `id -u` -ne 0 ]; then
>>   	echo "$0: must be root to install the selinux policy"
>>   	exit 1
>>   fi
>> +
>>   SF=`which setfiles`
>>   if [ $? -eq 1 ]; then
>> -	if [ -f /sbin/setfiles ]; then
>> -		SF="/usr/setfiles"
>> -	else
>> -		echo "no selinux tools installed: setfiles"
>> -		exit 1
>> -	fi
>> +	echo "Could not find setfiles"
>> +	echo "Do you have policycoreutils installed?"
>> +	exit 1
>>   fi
>>   
>> -cd mdp
>> -
>>   CP=`which checkpolicy`
>> +if [ $? -eq 1 ]; then
>> +	echo "Could not find checkpolicy"
>> +	echo "Do you have checkpolicy installed?"
>> +	exit 1
>> +fi
>>   VERS=`$CP -V | awk '{print $1}'`
>>   
>> -./mdp policy.conf file_contexts
>> -$CP -o policy.$VERS policy.conf
>> +ENABLED=`which selinuxenabled`
>> +if [ $? -eq 1 ]; then
>> +	echo "Could not find selinuxenabled"
>> +	echo "Do you have libselinux-utils installed?"
>> +	exit 1
>> +fi
>> +
>> +if selinuxenabled; then
>> +    echo "SELinux is already enabled"
>> +    echo "This prevents safely relabeling all files."
>> +    echo "Boot with selinux=0 on the kernel command-line or"
>> +    echo "SELINUX=disabled in /etc/selinux/config."
>> +    exit 1
>> +fi
>> +
>> +cd mdp
>> +./mdp -m policy.conf file_contexts
>> +$CP -U allow -M -o policy.$VERS policy.conf
>>   
>>   mkdir -p /etc/selinux/dummy/policy
>>   mkdir -p /etc/selinux/dummy/contexts/files
>>   
>> +echo "__default__:user_u" > /etc/selinux/dummy/seusers
> 
> Should this be "__default__:user_u:s0-s0"?
> 
>> +echo "base_r:base_t" > /etc/selinux/dummy/contexts/failsafe_context
> 
> Should this be "base_r:base_t:s0"?

Ah, thanks - good catch.  I couldn't really tell because I'm fighting 
with a broken dbus-daemon (F29) and X, so my ability to test is limited. 
  I'll fix in the next version along with a few other items I've noticed.

> 
>> +
>>   cp file_contexts /etc/selinux/dummy/contexts/files
>>   cp dbus_contexts /etc/selinux/dummy/contexts
>>   cp policy.$VERS /etc/selinux/dummy/policy
>> @@ -33,37 +54,22 @@ FC_FILE=/etc/selinux/dummy/contexts/files/file_contexts
>>   if [ ! -d /etc/selinux ]; then
>>   	mkdir -p /etc/selinux
>>   fi
>> -if [ ! -f /etc/selinux/config ]; then
>> -	cat > /etc/selinux/config << EOF
>> -SELINUX=enforcing
>> +if [ -f /etc/selinux/config ]; then
>> +    echo "/etc/selinux/config exists, moving to /etc/selinux/config.bak."
>> +    mv /etc/selinux/config /etc/selinux/config.bak
>> +fi
>> +echo "Creating new /etc/selinux/config for dummy policy."
>> +cat > /etc/selinux/config << EOF
>> +SELINUX=permissive
>>   SELINUXTYPE=dummy
>>   EOF
>> -else
>> -	TYPE=`cat /etc/selinux/config | grep "^SELINUXTYPE" | tail -1 | awk -F= '{ print $2 '}`
>> -	if [ "eq$TYPE" != "eqdummy" ]; then
>> -		selinuxenabled
>> -		if [ $? -eq 0 ]; then
>> -			echo "SELinux already enabled with a non-dummy policy."
>> -			echo "Exiting.  Please install policy by hand if that"
>> -			echo "is what you REALLY want."
>> -			exit 1
>> -		fi
>> -		mv /etc/selinux/config /etc/selinux/config.mdpbak
>> -		grep -v "^SELINUXTYPE" /etc/selinux/config.mdpbak >> /etc/selinux/config
>> -		echo "SELINUXTYPE=dummy" >> /etc/selinux/config
>> -	fi
>> -fi
>>   
>>   cd /etc/selinux/dummy/contexts/files
>> -$SF file_contexts /
>> +$SF -F file_contexts /
>>   
>> -mounts=`cat /proc/$$/mounts | egrep "ext2|ext3|xfs|jfs|ext4|ext4dev|gfs2" | awk '{ print $2 '}`
>> -$SF file_contexts $mounts
>> +mounts=`cat /proc/$$/mounts | \
>> +	egrep "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
>> +	awk '{ print $2 '}`
>> +$SF -F file_contexts $mounts
>>   
>> -
>> -dodev=`cat /proc/$$/mounts | grep "/dev "`
>> -if [ "eq$dodev" != "eq" ]; then
>> -	mount --move /dev /mnt
>> -	$SF file_contexts /dev
>> -	mount --move /mnt /dev
>> -fi
>> +touch /.autorelabel
> 
> Probably best to instead: "echo "-F" > /.autorelabel"?
> 
>> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
>> index 073fe7537f6c..daad333c7252 100644
>> --- a/scripts/selinux/mdp/mdp.c
>> +++ b/scripts/selinux/mdp/mdp.c
>> @@ -33,6 +33,7 @@
>>   #include <unistd.h>
>>   #include <string.h>
>>   #include <sys/socket.h>
>> +#include <linux/kconfig.h>
>>   
>>   static void usage(char *name)
>>   {
>> @@ -95,10 +96,31 @@ int main(int argc, char *argv[])
>>   	}
>>   	fprintf(fout, "\n");
>>   
>> -	/* NOW PRINT OUT MLS STUFF */
>> +	/* print out mls declarations and constraints */
>>   	if (mls) {
>> -		printf("MLS not yet implemented\n");
>> -		exit(1);
>> +		fprintf(fout, "sensitivity s0;\n");
>> +		fprintf(fout, "sensitivity s1;\n");
>> +		fprintf(fout, "dominance { s0 s1 }\n");
>> +		fprintf(fout, "category c0;\n");
>> +		fprintf(fout, "category c1;\n");
>> +		fprintf(fout, "level s0:c0.c1;\n");
>> +		fprintf(fout, "level s1:c0.c1;\n");
>> +#define SYSTEMLOW "s0"
>> +#define SYSTEMHIGH "s1:c0.c1"
>> +		for (i = 0; secclass_map[i].name; i++) {
>> +			struct security_class_mapping *map = &secclass_map[i];
>> +
>> +			fprintf(fout, "mlsconstrain %s {\n", map->name);
>> +			for (j = 0; map->perms[j]; j++)
>> +				fprintf(fout, "\t%s\n", map->perms[j]);
>> +			/*
>> +			 * This requires all subjects and objects to be
>> +			 * single-level (l2 eq h2), and that the subject
>> +			 * level dominate the object level (h1 dom h2)
>> +			 * in order to have any permissions to it.
>> +			 */
>> +			fprintf(fout, "} (l2 eq h2 and h1 dom h2);\n\n");
>> +		}
>>   	}
>>   
>>   	/* types, roles, and allows */
>> @@ -108,34 +130,126 @@ int main(int argc, char *argv[])
>>   	for (i = 0; secclass_map[i].name; i++)
>>   		fprintf(fout, "allow base_t base_t:%s *;\n",
>>   			secclass_map[i].name);
>> -	fprintf(fout, "user user_u roles { base_r };\n");
>> -	fprintf(fout, "\n");
>> +	fprintf(fout, "user user_u roles { base_r }");
>> +	if (mls)
>> +		fprintf(fout, " level %s range %s - %s", SYSTEMLOW,
>> +			SYSTEMLOW, SYSTEMHIGH);
>> +	fprintf(fout, ";\n");
>> +
>> +#define SUBJUSERROLETYPE "user_u:base_r:base_t"
>> +#define OBJUSERROLETYPE "user_u:object_r:base_t"
>>   
>>   	/* default sids */
>>   	for (i = 1; i < initial_sid_to_string_len; i++)
>> -		fprintf(fout, "sid %s user_u:base_r:base_t\n", initial_sid_to_string[i]);
>> +		fprintf(fout, "sid %s " SUBJUSERROLETYPE "%s\n",
>> +			initial_sid_to_string[i], mls ? ":" SYSTEMLOW : "");
>>   	fprintf(fout, "\n");
>>   
>> -	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
>> -	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
>> -	fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
>> -	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
>> -	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
>> -	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
>> -	fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
>> -	fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
>> +#define FS_USE(behavior, fstype)			    \
>> +	fprintf(fout, "fs_use_%s %s " OBJUSERROLETYPE "%s;\n", \
>> +		behavior, fstype, mls ? ":" SYSTEMLOW : "")
>> +
>> +	/*
>> +	 * Filesystems whose inode labels can be fetched via getxattr.
>> +	 */
>> +#ifdef CONFIG_EXT2_FS_SECURITY
>> +	FS_USE("xattr", "ext2");
>> +#endif
>> +#ifdef CONFIG_EXT3_FS_SECURITY
>> +	FS_USE("xattr", "ext3");
>> +#endif
>> +#ifdef CONFIG_EXT4_FS_SECURITY
>> +	FS_USE("xattr", "ext4");
>> +#endif
>> +#ifdef CONFIG_JFS_SECURITY
>> +	FS_USE("xattr", "jfs");
>> +#endif
>> +#ifdef CONFIG_REISERFS_FS_SECURITY
>> +	FS_USE("xattr", "reiserfs");
>> +#endif
>> +#ifdef CONFIG_JFFS2_FS_SECURITY
>> +	FS_USE("xattr", "jffs2");
>> +#endif
>> +#ifdef CONFIG_XFS_FS
>> +	FS_USE("xattr", "xfs");
>> +#endif
>> +#ifdef CONFIG_GFS2_FS
>> +	FS_USE("xattr", "gfs2");
>> +#endif
>> +#ifdef CONFIG_BTRFS_FS
>> +	FS_USE("xattr", "btrfs");
>> +#endif
>> +#ifdef CONFIG_F2FS_FS_SECURITY
>> +	FS_USE("xattr", "f2fs");
>> +#endif
>> +#ifdef CONFIG_OCFS2_FS
>> +	FS_USE("xattr", "ocsfs2");
>> +#endif
>> +#ifdef CONFIG_OVERLAY_FS
>> +	FS_USE("xattr", "overlay");
>> +#endif
>> +#ifdef CONFIG_SQUASHFS_XATTR
>> +	FS_USE("xattr", "squashfs");
>> +#endif
>> +
>> +	/*
>> +	 * Filesystems whose inodes are labeled from allocating task.
>> +	 */
>> +	FS_USE("task", "pipefs");
>> +	FS_USE("task", "sockfs");
>>   
>> -	fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t;\n");
>> -	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
>> -	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
>> +	/*
>> +	 * Filesystems whose inode labels are computed from both
>> +	 * the allocating task and the superblock label.
>> +	 */
>> +#ifdef CONFIG_UNIX98_PTYS
>> +	FS_USE("trans", "devpts");
>> +#endif
>> +#ifdef CONFIG_HUGETLBFS
>> +	FS_USE("trans", "hugetlbfs");
>> +#endif
>> +#ifdef CONFIG_TMPFS
>> +	FS_USE("trans", "tmpfs");
>> +#endif
>> +#ifdef CONFIG_DEVTMPFS
>> +	FS_USE("trans", "devtmpfs");
>> +#endif
>> +#ifdef CONFIG_POSIX_MQUEUE
>> +	FS_USE("trans", "mqueue");
>> +#endif
>>   
>> -	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
>> -	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
>> -	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
>> -	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
>> -	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
>> +#define GENFSCON(fstype, prefix)			     \
>> +	fprintf(fout, "genfscon %s %s " OBJUSERROLETYPE "%s\n", \
>> +		fstype, prefix, mls ? ":" SYSTEMLOW : "")
>>   
>> -	fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
>> +	/*
>> +	 * Filesystems whose inodes are labeled from path prefix match
>> +	 * relative to the filesystem root.  Depending on the filesystem,
>> +	 * only a single label for all inodes may be supported.  Here
>> +	 * we list the filesystem types for which per-file labeling is
>> +	 * supported using genfscon; any other filesystem type can also
>> +	 * be added by only with a single entry for all of its inodes.
>> +	 */
>> +#ifdef CONFIG_PROC_FS
>> +	GENFSCON("proc", "/");
>> +#endif
>> +#ifdef CONFIG_SECURITY_SELINUX
>> +	GENFSCON("selinuxfs", "/");
>> +#endif
>> +#ifdef CONFIG_SYSFS
>> +	GENFSCON("sysfs", "/");
>> +#endif
>> +#ifdef CONFIG_DEBUG_FS
>> +	GENFSCON("debugfs", "/");
>> +#endif
>> +#ifdef CONFIG_TRACING
>> +	GENFSCON("tracefs", "/");
>> +#endif
>> +#ifdef CONFIG_PSTORE
>> +	GENFSCON("pstore", "/");
>> +#endif
>> +	GENFSCON("cgroup", "/");
>> +	GENFSCON("cgroup2", "/");
>>   
>>   	fclose(fout);
>>   
>> @@ -144,8 +258,8 @@ int main(int argc, char *argv[])
>>   		printf("Wrote policy, but cannot open %s for writing\n", ctxout);
>>   		usage(argv[0]);
>>   	}
>> -	fprintf(fout, "/ user_u:base_r:base_t\n");
>> -	fprintf(fout, "/.* user_u:base_r:base_t\n");
>> +	fprintf(fout, "/ " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
>> +	fprintf(fout, "/.* " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
>>   	fclose(fout);
>>   
>>   	return 0;
>> -- 
>> 2.20.1
>>
> 

