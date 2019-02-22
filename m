Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D0FC43381
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 20:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324ED206BB
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 20:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="J/wgF1Vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfBVUpG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:45:06 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:53665 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVUpG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 15:45:06 -0500
X-EEMSG-check-017: 688322918|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.58,401,1544486400"; 
   d="scan'208";a="688322918"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Feb 2019 20:44:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550868294; x=1582404294;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3SlLamKHm8tUQCbkcpo5VqYKc8ya0G22I45oNPzCqz8=;
  b=J/wgF1VxWSgwy3EUyjog5qAfon4Opr5Y9SY4dm8hcKrR+EnN7pIX/DBB
   DdooYT0681xL12+0WRCZSDhlSIvWEuqGUNbi/Wjpcnzz+JVJwbUC/bgiV
   5UZ9jHkENv8e+4X167BWJQOLyOyq53/fW2X6oZTfdQupdMT3B0PnQ/u6n
   e1RlETDQeXYBEOApzadN+ZPhNyXce3YumNlMrsftbFzPi2KsETIXB00EU
   brIdazk5Sj7Iwrm2Xu8PiBO5w39nvsHU0TA8XYfSxZM/+9UmxTwi+klY+
   JqMeBCCsTLNSV9LntehbyI1X/tuTvPtNzEY0KyGpcxJHzV8oMDq3BBsA8
   A==;
X-IronPort-AV: E=Sophos;i="5.58,401,1544486400"; 
   d="scan'208";a="24241712"
IronPort-PHdr: =?us-ascii?q?9a23=3AdotjDRT8jfW8gN8e9+DEaQ5srNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZBeFt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KpwVhTmlDkIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94VS3?=
 =?us-ascii?q?BBXsJMXCJfBI2yYZYEA+4YMepGs4Xxol0Dpga8CwaxHuPi0iJGiGH43aM60O?=
 =?us-ascii?q?ovHw/J0wMiEN0Sv3rZt8n1OaUIXOyp0KXFwzfOYvVL0jn98ojIdRUhrOmRU7?=
 =?us-ascii?q?Jsb8XR0UkvGB3Djl6NtILlOima1uAJs2eF7+trSOWii3U6pAFquTWv2scthZ?=
 =?us-ascii?q?XJhoIS0FzE8z55z5wvKd23T057f8epHZ1NvC+UMIt2R9ktQ2BuuCsi0bIJo5?=
 =?us-ascii?q?27cDIPyJQ53xLfc/uHc4yJ4h3/VOedOyt3i2h5eL+5mh288lCgx/XhWsS731?=
 =?us-ascii?q?tGtCpInsTWunwT2BHf9NKLRuZ780y8wziAzRrT5ftBIU0skKrbLIMuzaAom5?=
 =?us-ascii?q?oItETDAjf2mELrjK+Kbkkk+van6+DgYrj+up+TLZV0igDjMqQ1gMC/HeQ5PR?=
 =?us-ascii?q?QOX2ic4+i80qHs/VblT7lQi/02k63ZvIjbJcQduKG5HxdY3pss5huwFTur0M?=
 =?us-ascii?q?kUkWMZIF9KZh6LlZXlN0nLIP/iDPe/h1qskC1sx/DDJrDhGYjCLmPYnbf9fb?=
 =?us-ascii?q?dy905cyA0pwdBZ/JJbEKsNIP30Wk/vrNDYFAM2MxSow+b7D9Vwzp4RWWWKAq?=
 =?us-ascii?q?+YNqPSsEOH5uE1L+mDfo8VuTj9K+Q+6vHzk3A5l0ESfa+y3ZQJdH+0BPJmI0?=
 =?us-ascii?q?GBa3r2ntgBCXsKvhY5TOHykF2NSyNTZ3KpUqIk/D47FYamAZ7GRoCqh7yBxj?=
 =?us-ascii?q?m0EodKaWBBD1CGCW3oeJmcW/cQdCKSJddskicaWrilSo8h0wyutQDhxrp5Ie?=
 =?us-ascii?q?rb5DcYuYjg1Ndr/e3Tkw899ThuA8SayWGNQHl+nnkUSD8uwKB/vUt9x0+b0a?=
 =?us-ascii?q?h8mfNYCMBT5+lSXQggLpPc1fJ1BM3yWg3bYteFUkqpQtKjAWJ5ctVk79gLYk?=
 =?us-ascii?q?B8ENbqoQrC0TbiV7MSkr2NBZc3tK3G3nbtD8pwxXvAz6QqyV8iFJhhL2qj05?=
 =?us-ascii?q?Vj+hDTCoiBqECQk6KnZOxIxyLW3HuSxmqJ+kdDWUh/VruTDiNXXVffsdmsvh?=
 =?us-ascii?q?CKdLSpE7lyd1IbkcM=3D?=
X-IPAS-Result: =?us-ascii?q?A2AKAAB5XnBc/wHyM5BkGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYFZKmdQATInhAeIGowmAQEBAQEBBoEQJYk7jmOBeywMAYEqAYMVAoN+I?=
 =?us-ascii?q?jQJDQEDAQEBAQEBAgFsKII6KQGCZwEFIwQRQRALGAICEgETAgJXBg0GAgEBg?=
 =?us-ascii?q?lMMPQGBZQ2rW3wzhUSEbIELiz0XeIEHgREnDIJfhUkCgkCCVwKKAAaGSUs7W?=
 =?us-ascii?q?pEqCYc+g2+DJYQIBhmBcYVbi0OLXo1WhRY4gVYrCAIYCCEPO4JsCYIfF448I?=
 =?us-ascii?q?QMwgQUBAYw5DRcHgiABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 22 Feb 2019 20:44:52 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1MKip2T017063;
        Fri, 22 Feb 2019 15:44:51 -0500
Subject: Re: [PATCH v6] scripts/selinux: modernize mdp
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     paul@paul-moore.com, selinux@vger.kernel.org,
        Petr Lautrbach <plautrba@redhat.com>
References: <20190221213147.1590-1-sds@tycho.nsa.gov>
 <20190222085518.GA28321@brutus.lan>
 <a127c2fc-9a1e-3169-fe0a-1f07f896fc06@tycho.nsa.gov>
 <20190222202617.GA16944@brutus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9b6e1392-0492-cd4c-c5b3-e17125f55da9@tycho.nsa.gov>
Date:   Fri, 22 Feb 2019 15:44:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222202617.GA16944@brutus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/22/19 3:26 PM, Dominick Grift wrote:
> On Fri, Feb 22, 2019 at 03:17:10PM -0500, Stephen Smalley wrote:
>> On 2/22/19 3:55 AM, Dominick Grift wrote:
>>> On Thu, Feb 21, 2019 at 04:31:47PM -0500, Stephen Smalley wrote:
>>>> Derived in part from a patch by Dominick Grift.
>>>>
>>>> The MDP example no longer works on modern systems.  Fix it.
>>>> While we are at it, add MLS support and enable it.
>>>>
>>>> NB This still does not work on systems using dbus-daemon instead of
>>>> dbus-broker because dbus-daemon does not yet gracefully handle unknown
>>>> classes/permissions.  This appears to be a deficiency in libselinux's
>>>> selinux_set_mapping() interface and underlying implementation,
>>>> which was never fully updated to deal with unknown classes/permissions
>>>> unlike the kernel.  The same problem also occurs with XSELinux.
>>>> Programs that instead use selinux_check_access() like dbus-broker
>>>> should not have this problem.
>>>>
>>>> Changes to mdp:
>>>> Add support for devtmpfs, required by modern Linux distributions.
>>>> Add MLS support, with sample sensitivities, categories, and constraints.
>>>> Generate fs_use and genfscon rules based on kernel configuration.
>>>> Update list of filesystem types for fs_use and genfscon rules.
>>>> Use object_r for object contexts.
>>>>
>>>> Changes to install_policy.sh:
>>>> Bail immediately on any errors.
>>>> Provide more helpful error messages when unable to find userspace tools.
>>>> Refuse to run if SELinux is already enabled.
>>>> Unconditionally move aside /etc/selinux/config and create a new one.
>>>> Build policy with -U allow so that userspace object managers do not break.
>>>> Build policy with MLS enabled by default.
>>>> Create seusers, failsafe_context, and default_contexts for use by
>>>> pam_selinux / libselinux.
>>>> Create x_contexts for the SELinux X extension.
>>>> Create virtual_domain_context and virtual_image_context for libvirtd.
>>>> Set to permissive mode rather than enforcing to permit initial autorelabel.
>>>> Update the list of filesystem types to be relabeled.
>>>> Write -F to /.autorelabel to cause a forced autorelabel on reboot.
>>>> Drop broken attempt to relabel the /dev mountpoint directory.
>>>>
>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>> ---
>>>> v6 fixes the seusers and failsafe_contexts to include :s0
>>>> as per Dominick's comments. It also adds a default_contexts
>>>> configuration for good measure, although this might not be
>>>> necessary. It creates a minimal working x_contexts configuration
>>>> to appease XSELinux, although XSELinux still has problems due
>>>> to the lack of the userspace class/perms definitions. It
>>>> creates empty virtual_*_context files to make libvirtd happy.
>>>> It writes -F to /.autorelabel as per Dominick's comments to
>>>> trigger a forced relabel. It also fixes mdp to correctly generate
>>>> fs_use rules for ext3 and ext2 when using ext4 as the driver.
>>>> These days ext4 is always used to handle ext3 mounts and it can
>>>> also be used for ext2.  This version is called v6 to distinguish it from
>>>> Dominick's earlier patch sequence, which went up to v4, and then
>>>> my previous coalesced patch is logically v5.
>>>>
>>>>    scripts/selinux/install_policy.sh |  92 ++++++++++-------
>>>>    scripts/selinux/mdp/mdp.c         | 165 +++++++++++++++++++++++++-----
>>>>    2 files changed, 194 insertions(+), 63 deletions(-)
>>>
>>> Acked-by: Dominick Grift <dominick.grift@defensec.nl>
>>>
>>> I was pretty sure that seusers entries need both current as well as clearance (s0-s0 instead of just s0) but just s0 works in this scenario atleast
>>> I did not test the X and virt_contexts aspects.
>>
>> Hmm...so even with the fix for libselinux selinux_set_mapping (which
>> addresses the dbus-daemon issue), I can't login under the dummy policy if
>> the system is set to enforcing.  I get the following from pam_selinux:
>>
>> sshd[2015]: pam_selinux(sshd:session): Failed to translate security class
>> context. Invalid argument
>> sshd[2015]: pam_selinux(sshd:session): Security context
>> user_u:base_r:base_t:s0 is not allowed for user_u:base_r:base_t:s0
>> sshd[2015]: pam_selinux(sshd:session): Unable to get valid context for sds
>>
>> Looking at the pam_selinux code, it performs a userspace permission check on
>> the context class, contains permission, in order to validate that the MLS
>> level is authorized for the Linux user. The normal context validation is not
>> sufficient for this purpose since the SELinux user in the security context
>> to which the Linux username is mapped may be authorized for a wider range
>> than the Linux user. pam_selinux directly calls string_to_security_class(),
>> string_to_av_perm(), and security_compute_av() instead of using
>> selinux_check_access(), so it doesn't honor allow_unknown presently.  Is
>> this fixed in rawhide?
> 
> No I do not believe that this is fixed in rawhide, but might be able to work around that by removing the the env_params option from the pam_selinux call in /etc/pam.d/sshd.
> 
> I know, not ideal.

(cc Petr)

Any chance we could get pam_selinux to use selinux_check_access() 
instead, or, if not, to check security_deny_unknown() and handle 
failures of string_to_security_class()/string_to_av_perm() accordingly?

> 
>>
>>>
>>>>
>>>> diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
>>>> index 0b86c47baf7d..2dccf141241d 100755
>>>> --- a/scripts/selinux/install_policy.sh
>>>> +++ b/scripts/selinux/install_policy.sh
>>>> @@ -1,30 +1,61 @@
>>>>    #!/bin/sh
>>>>    # SPDX-License-Identifier: GPL-2.0
>>>> +set -e
>>>>    if [ `id -u` -ne 0 ]; then
>>>>    	echo "$0: must be root to install the selinux policy"
>>>>    	exit 1
>>>>    fi
>>>> +
>>>>    SF=`which setfiles`
>>>>    if [ $? -eq 1 ]; then
>>>> -	if [ -f /sbin/setfiles ]; then
>>>> -		SF="/usr/setfiles"
>>>> -	else
>>>> -		echo "no selinux tools installed: setfiles"
>>>> -		exit 1
>>>> -	fi
>>>> +	echo "Could not find setfiles"
>>>> +	echo "Do you have policycoreutils installed?"
>>>> +	exit 1
>>>>    fi
>>>> -cd mdp
>>>> -
>>>>    CP=`which checkpolicy`
>>>> +if [ $? -eq 1 ]; then
>>>> +	echo "Could not find checkpolicy"
>>>> +	echo "Do you have checkpolicy installed?"
>>>> +	exit 1
>>>> +fi
>>>>    VERS=`$CP -V | awk '{print $1}'`
>>>> -./mdp policy.conf file_contexts
>>>> -$CP -o policy.$VERS policy.conf
>>>> +ENABLED=`which selinuxenabled`
>>>> +if [ $? -eq 1 ]; then
>>>> +	echo "Could not find selinuxenabled"
>>>> +	echo "Do you have libselinux-utils installed?"
>>>> +	exit 1
>>>> +fi
>>>> +
>>>> +if selinuxenabled; then
>>>> +    echo "SELinux is already enabled"
>>>> +    echo "This prevents safely relabeling all files."
>>>> +    echo "Boot with selinux=0 on the kernel command-line or"
>>>> +    echo "SELINUX=disabled in /etc/selinux/config."
>>>> +    exit 1
>>>> +fi
>>>> +
>>>> +cd mdp
>>>> +./mdp -m policy.conf file_contexts
>>>> +$CP -U allow -M -o policy.$VERS policy.conf
>>>>    mkdir -p /etc/selinux/dummy/policy
>>>>    mkdir -p /etc/selinux/dummy/contexts/files
>>>> +echo "__default__:user_u:s0" > /etc/selinux/dummy/seusers
>>>> +echo "base_r:base_t:s0" > /etc/selinux/dummy/contexts/failsafe_context
>>>> +echo "base_r:base_t:s0 base_r:base_t:s0" > /etc/selinux/dummy/default_contexts
>>>> +cat > /etc/selinux/dummy/contexts/x_contexts <<EOF
>>>> +client * user_u:base_r:base_t:s0
>>>> +property * user_u:object_r:base_t:s0
>>>> +extension * user_u:object_r:base_t:s0
>>>> +selection * user_u:object_r:base_t:s0
>>>> +event * user_u:object_r:base_t:s0
>>>> +EOF
>>>> +touch /etc/selinux/dummy/contexts/virtual_domain_context
>>>> +touch /etc/selinux/dummy/contexts/virtual_image_context
>>>> +
>>>>    cp file_contexts /etc/selinux/dummy/contexts/files
>>>>    cp dbus_contexts /etc/selinux/dummy/contexts
>>>>    cp policy.$VERS /etc/selinux/dummy/policy
>>>> @@ -33,37 +64,22 @@ FC_FILE=/etc/selinux/dummy/contexts/files/file_contexts
>>>>    if [ ! -d /etc/selinux ]; then
>>>>    	mkdir -p /etc/selinux
>>>>    fi
>>>> -if [ ! -f /etc/selinux/config ]; then
>>>> -	cat > /etc/selinux/config << EOF
>>>> -SELINUX=enforcing
>>>> +if [ -f /etc/selinux/config ]; then
>>>> +    echo "/etc/selinux/config exists, moving to /etc/selinux/config.bak."
>>>> +    mv /etc/selinux/config /etc/selinux/config.bak
>>>> +fi
>>>> +echo "Creating new /etc/selinux/config for dummy policy."
>>>> +cat > /etc/selinux/config << EOF
>>>> +SELINUX=permissive
>>>>    SELINUXTYPE=dummy
>>>>    EOF
>>>> -else
>>>> -	TYPE=`cat /etc/selinux/config | grep "^SELINUXTYPE" | tail -1 | awk -F= '{ print $2 '}`
>>>> -	if [ "eq$TYPE" != "eqdummy" ]; then
>>>> -		selinuxenabled
>>>> -		if [ $? -eq 0 ]; then
>>>> -			echo "SELinux already enabled with a non-dummy policy."
>>>> -			echo "Exiting.  Please install policy by hand if that"
>>>> -			echo "is what you REALLY want."
>>>> -			exit 1
>>>> -		fi
>>>> -		mv /etc/selinux/config /etc/selinux/config.mdpbak
>>>> -		grep -v "^SELINUXTYPE" /etc/selinux/config.mdpbak >> /etc/selinux/config
>>>> -		echo "SELINUXTYPE=dummy" >> /etc/selinux/config
>>>> -	fi
>>>> -fi
>>>>    cd /etc/selinux/dummy/contexts/files
>>>> -$SF file_contexts /
>>>> +$SF -F file_contexts /
>>>> -mounts=`cat /proc/$$/mounts | egrep "ext2|ext3|xfs|jfs|ext4|ext4dev|gfs2" | awk '{ print $2 '}`
>>>> -$SF file_contexts $mounts
>>>> +mounts=`cat /proc/$$/mounts | \
>>>> +	egrep "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
>>>> +	awk '{ print $2 '}`
>>>> +$SF -F file_contexts $mounts
>>>> -
>>>> -dodev=`cat /proc/$$/mounts | grep "/dev "`
>>>> -if [ "eq$dodev" != "eq" ]; then
>>>> -	mount --move /dev /mnt
>>>> -	$SF file_contexts /dev
>>>> -	mount --move /mnt /dev
>>>> -fi
>>>> +echo "-F" > /.autorelabel
>>>> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
>>>> index 073fe7537f6c..edaba8e51651 100644
>>>> --- a/scripts/selinux/mdp/mdp.c
>>>> +++ b/scripts/selinux/mdp/mdp.c
>>>> @@ -33,6 +33,7 @@
>>>>    #include <unistd.h>
>>>>    #include <string.h>
>>>>    #include <sys/socket.h>
>>>> +#include <linux/kconfig.h>
>>>>    static void usage(char *name)
>>>>    {
>>>> @@ -95,10 +96,31 @@ int main(int argc, char *argv[])
>>>>    	}
>>>>    	fprintf(fout, "\n");
>>>> -	/* NOW PRINT OUT MLS STUFF */
>>>> +	/* print out mls declarations and constraints */
>>>>    	if (mls) {
>>>> -		printf("MLS not yet implemented\n");
>>>> -		exit(1);
>>>> +		fprintf(fout, "sensitivity s0;\n");
>>>> +		fprintf(fout, "sensitivity s1;\n");
>>>> +		fprintf(fout, "dominance { s0 s1 }\n");
>>>> +		fprintf(fout, "category c0;\n");
>>>> +		fprintf(fout, "category c1;\n");
>>>> +		fprintf(fout, "level s0:c0.c1;\n");
>>>> +		fprintf(fout, "level s1:c0.c1;\n");
>>>> +#define SYSTEMLOW "s0"
>>>> +#define SYSTEMHIGH "s1:c0.c1"
>>>> +		for (i = 0; secclass_map[i].name; i++) {
>>>> +			struct security_class_mapping *map = &secclass_map[i];
>>>> +
>>>> +			fprintf(fout, "mlsconstrain %s {\n", map->name);
>>>> +			for (j = 0; map->perms[j]; j++)
>>>> +				fprintf(fout, "\t%s\n", map->perms[j]);
>>>> +			/*
>>>> +			 * This requires all subjects and objects to be
>>>> +			 * single-level (l2 eq h2), and that the subject
>>>> +			 * level dominate the object level (h1 dom h2)
>>>> +			 * in order to have any permissions to it.
>>>> +			 */
>>>> +			fprintf(fout, "} (l2 eq h2 and h1 dom h2);\n\n");
>>>> +		}
>>>>    	}
>>>>    	/* types, roles, and allows */
>>>> @@ -108,34 +130,127 @@ int main(int argc, char *argv[])
>>>>    	for (i = 0; secclass_map[i].name; i++)
>>>>    		fprintf(fout, "allow base_t base_t:%s *;\n",
>>>>    			secclass_map[i].name);
>>>> -	fprintf(fout, "user user_u roles { base_r };\n");
>>>> -	fprintf(fout, "\n");
>>>> +	fprintf(fout, "user user_u roles { base_r }");
>>>> +	if (mls)
>>>> +		fprintf(fout, " level %s range %s - %s", SYSTEMLOW,
>>>> +			SYSTEMLOW, SYSTEMHIGH);
>>>> +	fprintf(fout, ";\n");
>>>> +
>>>> +#define SUBJUSERROLETYPE "user_u:base_r:base_t"
>>>> +#define OBJUSERROLETYPE "user_u:object_r:base_t"
>>>>    	/* default sids */
>>>>    	for (i = 1; i < initial_sid_to_string_len; i++)
>>>> -		fprintf(fout, "sid %s user_u:base_r:base_t\n", initial_sid_to_string[i]);
>>>> +		fprintf(fout, "sid %s " SUBJUSERROLETYPE "%s\n",
>>>> +			initial_sid_to_string[i], mls ? ":" SYSTEMLOW : "");
>>>>    	fprintf(fout, "\n");
>>>> -	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
>>>> -	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
>>>> -	fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
>>>> -	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
>>>> -	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
>>>> -	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
>>>> -	fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
>>>> -	fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
>>>> +#define FS_USE(behavior, fstype)			    \
>>>> +	fprintf(fout, "fs_use_%s %s " OBJUSERROLETYPE "%s;\n", \
>>>> +		behavior, fstype, mls ? ":" SYSTEMLOW : "")
>>>> +
>>>> +	/*
>>>> +	 * Filesystems whose inode labels can be fetched via getxattr.
>>>> +	 */
>>>> +#ifdef CONFIG_EXT2_FS_SECURITY
>>>> +	FS_USE("xattr", "ext2");
>>>> +#endif
>>>> +#ifdef CONFIG_EXT4_FS_SECURITY
>>>> +#ifdef CONFIG_EXT4_USE_FOR_EXT2
>>>> +	FS_USE("xattr", "ext2");
>>>> +#endif
>>>> +	FS_USE("xattr", "ext3");
>>>> +	FS_USE("xattr", "ext4");
>>>> +#endif
>>>> +#ifdef CONFIG_JFS_SECURITY
>>>> +	FS_USE("xattr", "jfs");
>>>> +#endif
>>>> +#ifdef CONFIG_REISERFS_FS_SECURITY
>>>> +	FS_USE("xattr", "reiserfs");
>>>> +#endif
>>>> +#ifdef CONFIG_JFFS2_FS_SECURITY
>>>> +	FS_USE("xattr", "jffs2");
>>>> +#endif
>>>> +#ifdef CONFIG_XFS_FS
>>>> +	FS_USE("xattr", "xfs");
>>>> +#endif
>>>> +#ifdef CONFIG_GFS2_FS
>>>> +	FS_USE("xattr", "gfs2");
>>>> +#endif
>>>> +#ifdef CONFIG_BTRFS_FS
>>>> +	FS_USE("xattr", "btrfs");
>>>> +#endif
>>>> +#ifdef CONFIG_F2FS_FS_SECURITY
>>>> +	FS_USE("xattr", "f2fs");
>>>> +#endif
>>>> +#ifdef CONFIG_OCFS2_FS
>>>> +	FS_USE("xattr", "ocsfs2");
>>>> +#endif
>>>> +#ifdef CONFIG_OVERLAY_FS
>>>> +	FS_USE("xattr", "overlay");
>>>> +#endif
>>>> +#ifdef CONFIG_SQUASHFS_XATTR
>>>> +	FS_USE("xattr", "squashfs");
>>>> +#endif
>>>> +
>>>> +	/*
>>>> +	 * Filesystems whose inodes are labeled from allocating task.
>>>> +	 */
>>>> +	FS_USE("task", "pipefs");
>>>> +	FS_USE("task", "sockfs");
>>>> -	fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t;\n");
>>>> -	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
>>>> -	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
>>>> +	/*
>>>> +	 * Filesystems whose inode labels are computed from both
>>>> +	 * the allocating task and the superblock label.
>>>> +	 */
>>>> +#ifdef CONFIG_UNIX98_PTYS
>>>> +	FS_USE("trans", "devpts");
>>>> +#endif
>>>> +#ifdef CONFIG_HUGETLBFS
>>>> +	FS_USE("trans", "hugetlbfs");
>>>> +#endif
>>>> +#ifdef CONFIG_TMPFS
>>>> +	FS_USE("trans", "tmpfs");
>>>> +#endif
>>>> +#ifdef CONFIG_DEVTMPFS
>>>> +	FS_USE("trans", "devtmpfs");
>>>> +#endif
>>>> +#ifdef CONFIG_POSIX_MQUEUE
>>>> +	FS_USE("trans", "mqueue");
>>>> +#endif
>>>> -	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
>>>> -	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
>>>> -	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
>>>> -	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
>>>> -	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
>>>> +#define GENFSCON(fstype, prefix)			     \
>>>> +	fprintf(fout, "genfscon %s %s " OBJUSERROLETYPE "%s\n", \
>>>> +		fstype, prefix, mls ? ":" SYSTEMLOW : "")
>>>> -	fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
>>>> +	/*
>>>> +	 * Filesystems whose inodes are labeled from path prefix match
>>>> +	 * relative to the filesystem root.  Depending on the filesystem,
>>>> +	 * only a single label for all inodes may be supported.  Here
>>>> +	 * we list the filesystem types for which per-file labeling is
>>>> +	 * supported using genfscon; any other filesystem type can also
>>>> +	 * be added by only with a single entry for all of its inodes.
>>>> +	 */
>>>> +#ifdef CONFIG_PROC_FS
>>>> +	GENFSCON("proc", "/");
>>>> +#endif
>>>> +#ifdef CONFIG_SECURITY_SELINUX
>>>> +	GENFSCON("selinuxfs", "/");
>>>> +#endif
>>>> +#ifdef CONFIG_SYSFS
>>>> +	GENFSCON("sysfs", "/");
>>>> +#endif
>>>> +#ifdef CONFIG_DEBUG_FS
>>>> +	GENFSCON("debugfs", "/");
>>>> +#endif
>>>> +#ifdef CONFIG_TRACING
>>>> +	GENFSCON("tracefs", "/");
>>>> +#endif
>>>> +#ifdef CONFIG_PSTORE
>>>> +	GENFSCON("pstore", "/");
>>>> +#endif
>>>> +	GENFSCON("cgroup", "/");
>>>> +	GENFSCON("cgroup2", "/");
>>>>    	fclose(fout);
>>>> @@ -144,8 +259,8 @@ int main(int argc, char *argv[])
>>>>    		printf("Wrote policy, but cannot open %s for writing\n", ctxout);
>>>>    		usage(argv[0]);
>>>>    	}
>>>> -	fprintf(fout, "/ user_u:base_r:base_t\n");
>>>> -	fprintf(fout, "/.* user_u:base_r:base_t\n");
>>>> +	fprintf(fout, "/ " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
>>>> +	fprintf(fout, "/.* " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
>>>>    	fclose(fout);
>>>>    	return 0;
>>>> -- 
>>>> 2.20.1
>>>>
>>>
>>
> 

