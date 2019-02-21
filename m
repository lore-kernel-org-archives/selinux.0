Return-Path: <SRS0=eFyr=Q4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A553CC43381
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 19:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E782083B
	for <selinux@archiver.kernel.org>; Thu, 21 Feb 2019 19:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="TgdlKkz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfBUTex (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:34:53 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:24591 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfBUTew (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Feb 2019 14:34:52 -0500
X-EEMSG-check-017: 687740953|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.58,396,1544486400"; 
   d="scan'208";a="687740953"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Feb 2019 19:34:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550777679; x=1582313679;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=N9lEqIpybIrK2Ua4mooOk45HF+AHTM9hPgWv4oqADKk=;
  b=TgdlKkz9YPJT6eh/wwVKUoHDC3LP7q/Sx8E2kCvp75iURCEPCcpQVOaH
   0Gc9No642S1xQ8y9la3Nu2n0DCm2h6neAxjTQuVcZHFzVhc6iPiwhAnNB
   IH5c5LCfmCE+FGMOf+kisaI5ht5ma80HPOpk4cvfLVMdKa0KK9WzLyGRZ
   IXvqVOWWsQG57jCWfc4FqTyR0kMkrdyh4H76yhy7/gNOArgOxu8oyze4t
   dtXNBFqC/5M6rHHh56a3aN/nK4NBAj5uS7LLOwA/lRgblcN92XUW4gGRw
   SqemJIRsxyqPBcRgWw+AFy6ua4IyW+9jghJKtZRw57m9e1C2m4vzh5fbE
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,396,1544486400"; 
   d="scan'208";a="24188348"
IronPort-PHdr: =?us-ascii?q?9a23=3AYBQnpBR6JWJWUs+zPxYmqqciLNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zZReN2/xhgRfzUJnB7Loc0qyK6/CmATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbB/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4KlxSB/slSwJKTg3/m/KgcB0la5Xvg6tqxl5zoXJYo+aKeB+c7vAc90ES2?=
 =?us-ascii?q?pPXsVfWSJPDYyzbYQAE+UPMP1Er4T/vVYCsQeyCAeuCe7p1zRGhmX23ao/0+?=
 =?us-ascii?q?k5DA/GwBIvH8oOsHvKqtX+KbocUeWvw6nMyTXMcfNX0ir65YjTbx8huuqBXa?=
 =?us-ascii?q?5wcMXNyUkvEBnJjlOLqYP/JT+V2eMNs3aC4udmSOmhhWknqwRrrTiuwMchkp?=
 =?us-ascii?q?LGiZgWylze8CV53p45JcW/SE5/YN6rDJtRuzuGOIRsXsMvRXxjtiUiyrAepJ?=
 =?us-ascii?q?K2cycHxI4nyhLCcfCLbYeF7gz5WOqMJzpzmWhrd6ilhxmo9Eit0uj8Vs6p31?=
 =?us-ascii?q?lUtidFidzMtmwV1xzU98iHVuNx/ke/1jaL0ADe8v1ELloularaNp4h2aQ8lo?=
 =?us-ascii?q?YTsEvfHi/2n1/6jKmKeUU/5uek8eHnYrTippOENo90jB/xMrg2l8CiDuk1PR?=
 =?us-ascii?q?ICUmiG9eimyrHu8lP1TK9XgvEul6nWqpHaJcAVpq6jBA9V154u6w2iADe9y9?=
 =?us-ascii?q?kYgXkGI05FeBKAlYTpPUrOL+riAfewhFSsji9nx+raMb35HpXNMn/Dna/5fb?=
 =?us-ascii?q?ln9k5czBE+zchF6JJJDrENOffzWkj2tNzCEBA1KRC7w+HiCN9lzIMRRXqPAr?=
 =?us-ascii?q?OFMKPVqVKH++UvI+yNZI8TuTbyN/sl6+ThjX8jmF8dc7Wp0IAKZ3+mEPRpPU?=
 =?us-ascii?q?OZYWHyjdgdC2sKuA4+RvTwiFKeST5Te2qyX6Uk6zEgFo2mCYbDRoawgL2Oxy?=
 =?us-ascii?q?q7AJJWaX5cClyWEnfnaZ+EW/ESZyKWOMNhlSYEVbfyA7MmgAmnqQvS07N6Kq?=
 =?us-ascii?q?/R/SoCuNTo090myffUkEQJ6TFsD8mbm1qIRmVwk3JAEyQ6x4hjsEd9zRGFyq?=
 =?us-ascii?q?E+jPtGQ48Ar8hVWxs3YMaPh9dxDMr/D0ebJto=3D?=
X-IPAS-Result: =?us-ascii?q?A2AnAADQ/G5c/wHyM5BlHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VkqZ4EDJ4QHiBqMIQEBAQEBAQaBNYk7jmOBeywMAYEqAYMVAoN6IjQJDQEDA?=
 =?us-ascii?q?QEBAQEBAgFsKII6KYJnAQEBAQIBIwQRQRALGAICEgETAgJXEwYCAQGCXz0Bg?=
 =?us-ascii?q?WUFCKxdfDOFRIRsgQuLPRd4gQeBESeCa4VJAoI/glcCiWYghkhLO5F/CYc+g?=
 =?us-ascii?q?2+DJIQHBhmBcYVailxki1mNT4UWOIFWKwgCGAghDzuCbAmCHxeOPCEDMIEFA?=
 =?us-ascii?q?QGMOQ0XgicBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 21 Feb 2019 19:34:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1LJYcRX015886;
        Thu, 21 Feb 2019 14:34:38 -0500
Subject: Re: [PATCH] scripts/selinux: modernize mdp
To:     paul@paul-moore.com
Cc:     dominick.grift@defensec.nl, selinux@vger.kernel.org
References: <20190221184213.31303-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0aa33829-e3c6-7a28-b216-5b8244360e8c@tycho.nsa.gov>
Date:   Thu, 21 Feb 2019 14:34:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221184213.31303-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/21/19 1:42 PM, Stephen Smalley wrote:
> Derived in part from a patch by Dominick Grift.
> 
> The MDP example no longer works on modern systems.  Fix it.
> While we are at it, add MLS support and enable it.
> 
> NB This still does not work on systems using dbus-daemon instead of
> dbus-broker because dbus-daemon does not yet gracefully handle unknown
> classes/permissions.  This is a deficiency in libselinux's
> selinux_set_mapping() interface and underlying implementation,
> which was never fully updated to deal with unknown classes/permissions
> unlike the kernel.  Programs that instead use selinux_check_access()
> like dbus-broker do not have this problem.

We could perhaps avoid this problem by having mdp always include at 
least a core set of userspace classes/permissions in the policy it 
generates.  We could also fix libselinux but that won't help on any 
existing distro.

> 
> Other known issues:
> - Not everything appears to be relabeled, so some files are left with invalid
> contexts and remapped to the unlabeled SID/context.

This appears to be partly due to overuse of <<none>> in file_contexts 
(.fc) files.  That excludes those parts of the filesystem from being 
relabeled at all.  This was used to exclude pseudo filesystems 
(obsoleted by seclabel mount option detection) or runtime 
directories/files whose labels were derived from the creating process 
and couldn't be statically specified by file_contexts.  To get my system 
back into working order even with targeted policy, I had to strip all 
<<none>> entries out of my file_contexts* files and then run setfiles -F 
with the list of filesystem mounts to relabel.  Otherwise, I'd have 
files left in the old contexts and the system wouldn't even come up to 
user login, even if permissive.

FWIW, Android policy doesn't use <<none>> at all.  But they also don't 
have a /.* or equivalent entry as a default match, so anything not 
covered by a more specific match is likewise not labeled. 
seapp_contexts handles the more dynamic aspect of app directory labeling 
for Android.

The other problem case for relabeling is the mount point directories, 
which requires unmounting them all and relabeling them if we care. 
Otherwise they'll just get the unlabeled context and as long as we allow 
mounting on that, it should be ok.

> - X will fail due to lack of a x_contexts file
> - libvirtd will fail due to lack of a virtual_domain_context file

We could easily add these to the mdp policy.

> - crond reports an error with "No security context"

This is probably due to the lack of a contexts/default_contexts or any 
contexts/users/ files in the dummy policy.

> 
> Changes to mdp:
> Add support for devtmpfs, required by modern Linux distributions.
> Add MLS support, with sample sensitivities, categories, and constraints.
> Generate fs_use and genfscon rules based on kernel configuration.
> Update list of filesystem types for fs_use and genfscon rules.
> Use object_r for object contexts.
> 
> Changes to install_policy.sh:
> Bail immediately on any errors.
> Provide more helpful error messages when unable to find userspace tools.
> Refuse to run if SELinux is already enabled.
> Unconditionally move aside /etc/selinux/config and create a new one.
> Build policy with -U allow so that userspace object managers do not break.
> Build policy with MLS enabled by default.
> Add default seusers mapping and failsafe context for use by
> pam_selinux / libselinux.
> Set to permissive mode rather than enforcing to permit initial autorelabel.
> Update the list of filesystem types to be relabeled.
> Create /.autorelabel to trigger an autorelabel on reboot.
> Drop broken attempt to relabel the /dev mountpoint directory.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>   scripts/selinux/install_policy.sh |  82 ++++++++-------
>   scripts/selinux/mdp/mdp.c         | 164 +++++++++++++++++++++++++-----
>   2 files changed, 183 insertions(+), 63 deletions(-)
> 
> diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
> index 0b86c47baf7d..09eab4d0da5c 100755
> --- a/scripts/selinux/install_policy.sh
> +++ b/scripts/selinux/install_policy.sh
> @@ -1,30 +1,51 @@
>   #!/bin/sh
>   # SPDX-License-Identifier: GPL-2.0
> +set -e
>   if [ `id -u` -ne 0 ]; then
>   	echo "$0: must be root to install the selinux policy"
>   	exit 1
>   fi
> +
>   SF=`which setfiles`
>   if [ $? -eq 1 ]; then
> -	if [ -f /sbin/setfiles ]; then
> -		SF="/usr/setfiles"
> -	else
> -		echo "no selinux tools installed: setfiles"
> -		exit 1
> -	fi
> +	echo "Could not find setfiles"
> +	echo "Do you have policycoreutils installed?"
> +	exit 1
>   fi
>   
> -cd mdp
> -
>   CP=`which checkpolicy`
> +if [ $? -eq 1 ]; then
> +	echo "Could not find checkpolicy"
> +	echo "Do you have checkpolicy installed?"
> +	exit 1
> +fi
>   VERS=`$CP -V | awk '{print $1}'`
>   
> -./mdp policy.conf file_contexts
> -$CP -o policy.$VERS policy.conf
> +ENABLED=`which selinuxenabled`
> +if [ $? -eq 1 ]; then
> +	echo "Could not find selinuxenabled"
> +	echo "Do you have libselinux-utils installed?"
> +	exit 1
> +fi
> +
> +if selinuxenabled; then
> +    echo "SELinux is already enabled"
> +    echo "This prevents safely relabeling all files."
> +    echo "Boot with selinux=0 on the kernel command-line or"
> +    echo "SELINUX=disabled in /etc/selinux/config."
> +    exit 1
> +fi
> +
> +cd mdp
> +./mdp -m policy.conf file_contexts
> +$CP -U allow -M -o policy.$VERS policy.conf
>   
>   mkdir -p /etc/selinux/dummy/policy
>   mkdir -p /etc/selinux/dummy/contexts/files
>   
> +echo "__default__:user_u" > /etc/selinux/dummy/seusers
> +echo "base_r:base_t" > /etc/selinux/dummy/contexts/failsafe_context
> +
>   cp file_contexts /etc/selinux/dummy/contexts/files
>   cp dbus_contexts /etc/selinux/dummy/contexts
>   cp policy.$VERS /etc/selinux/dummy/policy
> @@ -33,37 +54,22 @@ FC_FILE=/etc/selinux/dummy/contexts/files/file_contexts
>   if [ ! -d /etc/selinux ]; then
>   	mkdir -p /etc/selinux
>   fi
> -if [ ! -f /etc/selinux/config ]; then
> -	cat > /etc/selinux/config << EOF
> -SELINUX=enforcing
> +if [ -f /etc/selinux/config ]; then
> +    echo "/etc/selinux/config exists, moving to /etc/selinux/config.bak."
> +    mv /etc/selinux/config /etc/selinux/config.bak
> +fi
> +echo "Creating new /etc/selinux/config for dummy policy."
> +cat > /etc/selinux/config << EOF
> +SELINUX=permissive
>   SELINUXTYPE=dummy
>   EOF
> -else
> -	TYPE=`cat /etc/selinux/config | grep "^SELINUXTYPE" | tail -1 | awk -F= '{ print $2 '}`
> -	if [ "eq$TYPE" != "eqdummy" ]; then
> -		selinuxenabled
> -		if [ $? -eq 0 ]; then
> -			echo "SELinux already enabled with a non-dummy policy."
> -			echo "Exiting.  Please install policy by hand if that"
> -			echo "is what you REALLY want."
> -			exit 1
> -		fi
> -		mv /etc/selinux/config /etc/selinux/config.mdpbak
> -		grep -v "^SELINUXTYPE" /etc/selinux/config.mdpbak >> /etc/selinux/config
> -		echo "SELINUXTYPE=dummy" >> /etc/selinux/config
> -	fi
> -fi
>   
>   cd /etc/selinux/dummy/contexts/files
> -$SF file_contexts /
> +$SF -F file_contexts /
>   
> -mounts=`cat /proc/$$/mounts | egrep "ext2|ext3|xfs|jfs|ext4|ext4dev|gfs2" | awk '{ print $2 '}`
> -$SF file_contexts $mounts
> +mounts=`cat /proc/$$/mounts | \
> +	egrep "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
> +	awk '{ print $2 '}`
> +$SF -F file_contexts $mounts
>   
> -
> -dodev=`cat /proc/$$/mounts | grep "/dev "`
> -if [ "eq$dodev" != "eq" ]; then
> -	mount --move /dev /mnt
> -	$SF file_contexts /dev
> -	mount --move /mnt /dev
> -fi
> +touch /.autorelabel
> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
> index 073fe7537f6c..daad333c7252 100644
> --- a/scripts/selinux/mdp/mdp.c
> +++ b/scripts/selinux/mdp/mdp.c
> @@ -33,6 +33,7 @@
>   #include <unistd.h>
>   #include <string.h>
>   #include <sys/socket.h>
> +#include <linux/kconfig.h>
>   
>   static void usage(char *name)
>   {
> @@ -95,10 +96,31 @@ int main(int argc, char *argv[])
>   	}
>   	fprintf(fout, "\n");
>   
> -	/* NOW PRINT OUT MLS STUFF */
> +	/* print out mls declarations and constraints */
>   	if (mls) {
> -		printf("MLS not yet implemented\n");
> -		exit(1);
> +		fprintf(fout, "sensitivity s0;\n");
> +		fprintf(fout, "sensitivity s1;\n");
> +		fprintf(fout, "dominance { s0 s1 }\n");
> +		fprintf(fout, "category c0;\n");
> +		fprintf(fout, "category c1;\n");
> +		fprintf(fout, "level s0:c0.c1;\n");
> +		fprintf(fout, "level s1:c0.c1;\n");
> +#define SYSTEMLOW "s0"
> +#define SYSTEMHIGH "s1:c0.c1"
> +		for (i = 0; secclass_map[i].name; i++) {
> +			struct security_class_mapping *map = &secclass_map[i];
> +
> +			fprintf(fout, "mlsconstrain %s {\n", map->name);
> +			for (j = 0; map->perms[j]; j++)
> +				fprintf(fout, "\t%s\n", map->perms[j]);
> +			/*
> +			 * This requires all subjects and objects to be
> +			 * single-level (l2 eq h2), and that the subject
> +			 * level dominate the object level (h1 dom h2)
> +			 * in order to have any permissions to it.
> +			 */
> +			fprintf(fout, "} (l2 eq h2 and h1 dom h2);\n\n");
> +		}
>   	}
>   
>   	/* types, roles, and allows */
> @@ -108,34 +130,126 @@ int main(int argc, char *argv[])
>   	for (i = 0; secclass_map[i].name; i++)
>   		fprintf(fout, "allow base_t base_t:%s *;\n",
>   			secclass_map[i].name);
> -	fprintf(fout, "user user_u roles { base_r };\n");
> -	fprintf(fout, "\n");
> +	fprintf(fout, "user user_u roles { base_r }");
> +	if (mls)
> +		fprintf(fout, " level %s range %s - %s", SYSTEMLOW,
> +			SYSTEMLOW, SYSTEMHIGH);
> +	fprintf(fout, ";\n");
> +
> +#define SUBJUSERROLETYPE "user_u:base_r:base_t"
> +#define OBJUSERROLETYPE "user_u:object_r:base_t"
>   
>   	/* default sids */
>   	for (i = 1; i < initial_sid_to_string_len; i++)
> -		fprintf(fout, "sid %s user_u:base_r:base_t\n", initial_sid_to_string[i]);
> +		fprintf(fout, "sid %s " SUBJUSERROLETYPE "%s\n",
> +			initial_sid_to_string[i], mls ? ":" SYSTEMLOW : "");
>   	fprintf(fout, "\n");
>   
> -	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
> +#define FS_USE(behavior, fstype)			    \
> +	fprintf(fout, "fs_use_%s %s " OBJUSERROLETYPE "%s;\n", \
> +		behavior, fstype, mls ? ":" SYSTEMLOW : "")
> +
> +	/*
> +	 * Filesystems whose inode labels can be fetched via getxattr.
> +	 */
> +#ifdef CONFIG_EXT2_FS_SECURITY
> +	FS_USE("xattr", "ext2");
> +#endif
> +#ifdef CONFIG_EXT3_FS_SECURITY
> +	FS_USE("xattr", "ext3");
> +#endif
> +#ifdef CONFIG_EXT4_FS_SECURITY
> +	FS_USE("xattr", "ext4");
> +#endif
> +#ifdef CONFIG_JFS_SECURITY
> +	FS_USE("xattr", "jfs");
> +#endif
> +#ifdef CONFIG_REISERFS_FS_SECURITY
> +	FS_USE("xattr", "reiserfs");
> +#endif
> +#ifdef CONFIG_JFFS2_FS_SECURITY
> +	FS_USE("xattr", "jffs2");
> +#endif
> +#ifdef CONFIG_XFS_FS
> +	FS_USE("xattr", "xfs");
> +#endif
> +#ifdef CONFIG_GFS2_FS
> +	FS_USE("xattr", "gfs2");
> +#endif
> +#ifdef CONFIG_BTRFS_FS
> +	FS_USE("xattr", "btrfs");
> +#endif
> +#ifdef CONFIG_F2FS_FS_SECURITY
> +	FS_USE("xattr", "f2fs");
> +#endif
> +#ifdef CONFIG_OCFS2_FS
> +	FS_USE("xattr", "ocsfs2");
> +#endif
> +#ifdef CONFIG_OVERLAY_FS
> +	FS_USE("xattr", "overlay");
> +#endif
> +#ifdef CONFIG_SQUASHFS_XATTR
> +	FS_USE("xattr", "squashfs");
> +#endif
> +
> +	/*
> +	 * Filesystems whose inodes are labeled from allocating task.
> +	 */
> +	FS_USE("task", "pipefs");
> +	FS_USE("task", "sockfs");
>   
> -	fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
> +	/*
> +	 * Filesystems whose inode labels are computed from both
> +	 * the allocating task and the superblock label.
> +	 */
> +#ifdef CONFIG_UNIX98_PTYS
> +	FS_USE("trans", "devpts");
> +#endif
> +#ifdef CONFIG_HUGETLBFS
> +	FS_USE("trans", "hugetlbfs");
> +#endif
> +#ifdef CONFIG_TMPFS
> +	FS_USE("trans", "tmpfs");
> +#endif
> +#ifdef CONFIG_DEVTMPFS
> +	FS_USE("trans", "devtmpfs");
> +#endif
> +#ifdef CONFIG_POSIX_MQUEUE
> +	FS_USE("trans", "mqueue");
> +#endif
>   
> -	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
> +#define GENFSCON(fstype, prefix)			     \
> +	fprintf(fout, "genfscon %s %s " OBJUSERROLETYPE "%s\n", \
> +		fstype, prefix, mls ? ":" SYSTEMLOW : "")
>   
> -	fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
> +	/*
> +	 * Filesystems whose inodes are labeled from path prefix match
> +	 * relative to the filesystem root.  Depending on the filesystem,
> +	 * only a single label for all inodes may be supported.  Here
> +	 * we list the filesystem types for which per-file labeling is
> +	 * supported using genfscon; any other filesystem type can also
> +	 * be added by only with a single entry for all of its inodes.
> +	 */
> +#ifdef CONFIG_PROC_FS
> +	GENFSCON("proc", "/");
> +#endif
> +#ifdef CONFIG_SECURITY_SELINUX
> +	GENFSCON("selinuxfs", "/");
> +#endif
> +#ifdef CONFIG_SYSFS
> +	GENFSCON("sysfs", "/");
> +#endif
> +#ifdef CONFIG_DEBUG_FS
> +	GENFSCON("debugfs", "/");
> +#endif
> +#ifdef CONFIG_TRACING
> +	GENFSCON("tracefs", "/");
> +#endif
> +#ifdef CONFIG_PSTORE
> +	GENFSCON("pstore", "/");
> +#endif
> +	GENFSCON("cgroup", "/");
> +	GENFSCON("cgroup2", "/");
>   
>   	fclose(fout);
>   
> @@ -144,8 +258,8 @@ int main(int argc, char *argv[])
>   		printf("Wrote policy, but cannot open %s for writing\n", ctxout);
>   		usage(argv[0]);
>   	}
> -	fprintf(fout, "/ user_u:base_r:base_t\n");
> -	fprintf(fout, "/.* user_u:base_r:base_t\n");
> +	fprintf(fout, "/ " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
> +	fprintf(fout, "/.* " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
>   	fclose(fout);
>   
>   	return 0;
> 

