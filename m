Return-Path: <SRS0=VtfE=Q5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65F1C43381
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 20:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93904206BB
	for <selinux@archiver.kernel.org>; Fri, 22 Feb 2019 20:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="QWwWCuqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfBVUz5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:55:57 -0500
Received: from upbd19pa12.eemsg.mail.mil ([214.24.27.87]:30516 "EHLO
        upbd19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfBVUz4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Feb 2019 15:55:56 -0500
X-EEMSG-check-017: 191182919|UPBD19PA12_EEMSG_MP12.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Feb 2019 20:55:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550868952; x=1582404952;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=v3KucyLOgUK7/F5rlB2DVkjpGv35EKUwaEsn5aqsDvg=;
  b=QWwWCuqPsLfp7VfcdZZS7soizhQiXOYtmWkUJ5tsLoBXl/AxVhmfVmF5
   yfYKvMrjbklUnxzS5H3LM6Opx7tSLTOvUj3PfpvWnI/wAjCBXbdYAINLn
   qecOkSHRasvVwv9+0DHQ6GRfdvLW8u5QlvCxtRsC3pBaUyFhFpaU4piyE
   TnTQgAEyrNpfQ8get0djDpKUUxDF5U1IwUy6z6D/sG5o9OfWhQ20SxLzl
   oCzCdWOlXTLRiu0RLSXDCsKdtNGF+le3qG05xzxg9c8BrRx7fGZIPR123
   63VIMAQ3FCf/fK4maiht2oXVv3OmoJBfzy2ZzaRfhP5imu9joa7J5laAT
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,401,1544486400"; 
   d="scan'208";a="24242235"
IronPort-PHdr: =?us-ascii?q?9a23=3AzDSULBU67zSTlt15R0KH1lYc8sjV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSEv6dThVPEFb/W9+hDw7KP9fy4CSpYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uLxi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpUsZXxq14IoBCjBwejGfnvxydViHH2w6M63e?=
 =?us-ascii?q?cvHw/I0wMvHd0BrHvaoc7pNKoRS+250LXEwDvBYv5QxDzz6JLIchckofyUQL?=
 =?us-ascii?q?xwbdTeyVEvFwzbiFWbtJHrPzaP2eQJt2iU8ephXv+ohm48tg5xuSOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUOYx2QsY4TGFpviY30qYJto?=
 =?us-ascii?q?S4fCQQzZQn2QbTa+SAc4iM4xLsSOaQLS1ki31/ZLKygQu5/0u4yuDkS8W531?=
 =?us-ascii?q?lHojBFn9XRrHwByRPe5tadRvdg+EqqxCyB2BrJ6u5eJEA5ja/bK5k8zbEujp?=
 =?us-ascii?q?cTqkHDHjPumEXxka+Wal0o+ui25OTjZbXrvoOcOJVuigH/L6QugdazAfg4Mw?=
 =?us-ascii?q?cSX2ib/v6w1Lv/8k3iXLpGlPg2kqjdsJzCJMQboLC2AxNN34o+5BuyAC2q3d?=
 =?us-ascii?q?QFkXUdMl5IdwyLg5L0N13WJfD3F/a/g1CikDdxwPDGO6XsAo7QIXjYi7rhYb?=
 =?us-ascii?q?Z85FJcyAo019xf4YlUBasbLPL8XU/xqsTUDgUlPAys3+bnFNJ925sDVmKIB6?=
 =?us-ascii?q?+ZMaXSsV6U6eIsOeWMa5UVuDfzK/g5/PPhkGE2mVEDcqmvxpsYdmy3Eu5gI0?=
 =?us-ascii?q?WdeXDsmMsOEX8WvgoiS+znkEWCXiROZ3a2RK88/is0CJ+iDYvaQ4Cth7uB3D?=
 =?us-ascii?q?2lEZFMem9GDVWMG2/yd4qYQ/cMdD6SIsh5nzwfS7ehT44h1ReztA710LdnMO?=
 =?us-ascii?q?XU9TMCtZ7519h6+ffTlRcs+jxwFcid1HuNT25slGMSWzA2xLx/oVB6ylqbya?=
 =?us-ascii?q?h4h+ZXFcFP5/NTSQg1L4XRz/ZkBN/vWgLOZMuJREy6TdWhBDFiBu42lvMJZk?=
 =?us-ascii?q?d7Gt6hxj/Z3iS2S+sZkLmKAp0/8eTTxXn/O+5xxnjL0rIshB8gRp0cG3ehg/?=
 =?us-ascii?q?tE6wXLB4PP236cnqKueLVUiDXB70+f3GGOuwdeSwc2XqLbCyNMLnDKpMj0sx?=
 =?us-ascii?q?uRB4SlDq4qZ04Yk5aP?=
X-IPAS-Result: =?us-ascii?q?A2AKAAABYXBc/wHyM5BkGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYFZKmdQATInhAeIGowmAQEBAQEBBoE1fIg/jmOBeywMAYEqAYMVAoN+I?=
 =?us-ascii?q?jQJDQEDAQEBAQEBAgFsKII6KQGCZgEBAQECASMECwEFQRAJAhgCAhIBEwICV?=
 =?us-ascii?q?wYNBgIBAYJTDD0BgWUFCI9+m2F8M4owgQuLPRd4gQeBESeCNjWFSQKCQIJXA?=
 =?us-ascii?q?olmGgaGSYEGWpEqCYc+g2+DJYQIBhmBcYVbi0OLXo1WhRY4gVYrCAIYCCEPO?=
 =?us-ascii?q?4JsCYIfF448IQMwgQUBAYw5DRcHgiABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 22 Feb 2019 20:55:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1MKtovk017150;
        Fri, 22 Feb 2019 15:55:50 -0500
Subject: Re: [PATCH v6] scripts/selinux: modernize mdp
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     paul@paul-moore.com, selinux@vger.kernel.org,
        Petr Lautrbach <plautrba@redhat.com>
References: <20190221213147.1590-1-sds@tycho.nsa.gov>
 <20190222085518.GA28321@brutus.lan>
 <a127c2fc-9a1e-3169-fe0a-1f07f896fc06@tycho.nsa.gov>
 <20190222202617.GA16944@brutus.lan>
 <9b6e1392-0492-cd4c-c5b3-e17125f55da9@tycho.nsa.gov>
Message-ID: <819a099c-8d9d-5e07-7f3a-c7863254ce92@tycho.nsa.gov>
Date:   Fri, 22 Feb 2019 15:55:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9b6e1392-0492-cd4c-c5b3-e17125f55da9@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/22/19 3:44 PM, Stephen Smalley wrote:
> On 2/22/19 3:26 PM, Dominick Grift wrote:
>> On Fri, Feb 22, 2019 at 03:17:10PM -0500, Stephen Smalley wrote:
>>> On 2/22/19 3:55 AM, Dominick Grift wrote:
>>>> On Thu, Feb 21, 2019 at 04:31:47PM -0500, Stephen Smalley wrote:
>>>>> Derived in part from a patch by Dominick Grift.
>>>>>
>>>>> The MDP example no longer works on modern systems.  Fix it.
>>>>> While we are at it, add MLS support and enable it.
>>>>>
>>>>> NB This still does not work on systems using dbus-daemon instead of
>>>>> dbus-broker because dbus-daemon does not yet gracefully handle unknown
>>>>> classes/permissions.  This appears to be a deficiency in libselinux's
>>>>> selinux_set_mapping() interface and underlying implementation,
>>>>> which was never fully updated to deal with unknown classes/permissions
>>>>> unlike the kernel.  The same problem also occurs with XSELinux.
>>>>> Programs that instead use selinux_check_access() like dbus-broker
>>>>> should not have this problem.
>>>>>
>>>>> Changes to mdp:
>>>>> Add support for devtmpfs, required by modern Linux distributions.
>>>>> Add MLS support, with sample sensitivities, categories, and 
>>>>> constraints.
>>>>> Generate fs_use and genfscon rules based on kernel configuration.
>>>>> Update list of filesystem types for fs_use and genfscon rules.
>>>>> Use object_r for object contexts.
>>>>>
>>>>> Changes to install_policy.sh:
>>>>> Bail immediately on any errors.
>>>>> Provide more helpful error messages when unable to find userspace 
>>>>> tools.
>>>>> Refuse to run if SELinux is already enabled.
>>>>> Unconditionally move aside /etc/selinux/config and create a new one.
>>>>> Build policy with -U allow so that userspace object managers do not 
>>>>> break.
>>>>> Build policy with MLS enabled by default.
>>>>> Create seusers, failsafe_context, and default_contexts for use by
>>>>> pam_selinux / libselinux.
>>>>> Create x_contexts for the SELinux X extension.
>>>>> Create virtual_domain_context and virtual_image_context for libvirtd.
>>>>> Set to permissive mode rather than enforcing to permit initial 
>>>>> autorelabel.
>>>>> Update the list of filesystem types to be relabeled.
>>>>> Write -F to /.autorelabel to cause a forced autorelabel on reboot.
>>>>> Drop broken attempt to relabel the /dev mountpoint directory.
>>>>>
>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>> ---
>>>>> v6 fixes the seusers and failsafe_contexts to include :s0
>>>>> as per Dominick's comments. It also adds a default_contexts
>>>>> configuration for good measure, although this might not be
>>>>> necessary. It creates a minimal working x_contexts configuration
>>>>> to appease XSELinux, although XSELinux still has problems due
>>>>> to the lack of the userspace class/perms definitions. It
>>>>> creates empty virtual_*_context files to make libvirtd happy.
>>>>> It writes -F to /.autorelabel as per Dominick's comments to
>>>>> trigger a forced relabel. It also fixes mdp to correctly generate
>>>>> fs_use rules for ext3 and ext2 when using ext4 as the driver.
>>>>> These days ext4 is always used to handle ext3 mounts and it can
>>>>> also be used for ext2.  This version is called v6 to distinguish it 
>>>>> from
>>>>> Dominick's earlier patch sequence, which went up to v4, and then
>>>>> my previous coalesced patch is logically v5.
>>>>>
>>>>>    scripts/selinux/install_policy.sh |  92 ++++++++++-------
>>>>>    scripts/selinux/mdp/mdp.c         | 165 
>>>>> +++++++++++++++++++++++++-----
>>>>>    2 files changed, 194 insertions(+), 63 deletions(-)
>>>>
>>>> Acked-by: Dominick Grift <dominick.grift@defensec.nl>
>>>>
>>>> I was pretty sure that seusers entries need both current as well as 
>>>> clearance (s0-s0 instead of just s0) but just s0 works in this 
>>>> scenario atleast
>>>> I did not test the X and virt_contexts aspects.
>>>
>>> Hmm...so even with the fix for libselinux selinux_set_mapping (which
>>> addresses the dbus-daemon issue), I can't login under the dummy 
>>> policy if
>>> the system is set to enforcing.  I get the following from pam_selinux:
>>>
>>> sshd[2015]: pam_selinux(sshd:session): Failed to translate security 
>>> class
>>> context. Invalid argument
>>> sshd[2015]: pam_selinux(sshd:session): Security context
>>> user_u:base_r:base_t:s0 is not allowed for user_u:base_r:base_t:s0
>>> sshd[2015]: pam_selinux(sshd:session): Unable to get valid context 
>>> for sds
>>>
>>> Looking at the pam_selinux code, it performs a userspace permission 
>>> check on
>>> the context class, contains permission, in order to validate that the 
>>> MLS
>>> level is authorized for the Linux user. The normal context validation 
>>> is not
>>> sufficient for this purpose since the SELinux user in the security 
>>> context
>>> to which the Linux username is mapped may be authorized for a wider 
>>> range
>>> than the Linux user. pam_selinux directly calls 
>>> string_to_security_class(),
>>> string_to_av_perm(), and security_compute_av() instead of using
>>> selinux_check_access(), so it doesn't honor allow_unknown presently.  Is
>>> this fixed in rawhide?
>>
>> No I do not believe that this is fixed in rawhide, but might be able 
>> to work around that by removing the the env_params option from the 
>> pam_selinux call in /etc/pam.d/sshd.
>>
>> I know, not ideal.
> 
> (cc Petr)
> 
> Any chance we could get pam_selinux to use selinux_check_access() 
> instead, or, if not, to check security_deny_unknown() and handle 
> failures of string_to_security_class()/string_to_av_perm() accordingly?

The latter might be preferable to avoid the overhead of creating an AVC 
just for a single permission check.  Should be just a matter of adding 
calls to security_deny_unknown() in the error handling paths for both 
string_*() mapping functions and returning success instead of failure if 
it returns 0.

> 
>>
>>>
>>>>
>>>>>
>>>>> diff --git a/scripts/selinux/install_policy.sh 
>>>>> b/scripts/selinux/install_policy.sh
>>>>> index 0b86c47baf7d..2dccf141241d 100755
>>>>> --- a/scripts/selinux/install_policy.sh
>>>>> +++ b/scripts/selinux/install_policy.sh
>>>>> @@ -1,30 +1,61 @@
>>>>>    #!/bin/sh
>>>>>    # SPDX-License-Identifier: GPL-2.0
>>>>> +set -e
>>>>>    if [ `id -u` -ne 0 ]; then
>>>>>        echo "$0: must be root to install the selinux policy"
>>>>>        exit 1
>>>>>    fi
>>>>> +
>>>>>    SF=`which setfiles`
>>>>>    if [ $? -eq 1 ]; then
>>>>> -    if [ -f /sbin/setfiles ]; then
>>>>> -        SF="/usr/setfiles"
>>>>> -    else
>>>>> -        echo "no selinux tools installed: setfiles"
>>>>> -        exit 1
>>>>> -    fi
>>>>> +    echo "Could not find setfiles"
>>>>> +    echo "Do you have policycoreutils installed?"
>>>>> +    exit 1
>>>>>    fi
>>>>> -cd mdp
>>>>> -
>>>>>    CP=`which checkpolicy`
>>>>> +if [ $? -eq 1 ]; then
>>>>> +    echo "Could not find checkpolicy"
>>>>> +    echo "Do you have checkpolicy installed?"
>>>>> +    exit 1
>>>>> +fi
>>>>>    VERS=`$CP -V | awk '{print $1}'`
>>>>> -./mdp policy.conf file_contexts
>>>>> -$CP -o policy.$VERS policy.conf
>>>>> +ENABLED=`which selinuxenabled`
>>>>> +if [ $? -eq 1 ]; then
>>>>> +    echo "Could not find selinuxenabled"
>>>>> +    echo "Do you have libselinux-utils installed?"
>>>>> +    exit 1
>>>>> +fi
>>>>> +
>>>>> +if selinuxenabled; then
>>>>> +    echo "SELinux is already enabled"
>>>>> +    echo "This prevents safely relabeling all files."
>>>>> +    echo "Boot with selinux=0 on the kernel command-line or"
>>>>> +    echo "SELINUX=disabled in /etc/selinux/config."
>>>>> +    exit 1
>>>>> +fi
>>>>> +
>>>>> +cd mdp
>>>>> +./mdp -m policy.conf file_contexts
>>>>> +$CP -U allow -M -o policy.$VERS policy.conf
>>>>>    mkdir -p /etc/selinux/dummy/policy
>>>>>    mkdir -p /etc/selinux/dummy/contexts/files
>>>>> +echo "__default__:user_u:s0" > /etc/selinux/dummy/seusers
>>>>> +echo "base_r:base_t:s0" > 
>>>>> /etc/selinux/dummy/contexts/failsafe_context
>>>>> +echo "base_r:base_t:s0 base_r:base_t:s0" > 
>>>>> /etc/selinux/dummy/default_contexts
>>>>> +cat > /etc/selinux/dummy/contexts/x_contexts <<EOF
>>>>> +client * user_u:base_r:base_t:s0
>>>>> +property * user_u:object_r:base_t:s0
>>>>> +extension * user_u:object_r:base_t:s0
>>>>> +selection * user_u:object_r:base_t:s0
>>>>> +event * user_u:object_r:base_t:s0
>>>>> +EOF
>>>>> +touch /etc/selinux/dummy/contexts/virtual_domain_context
>>>>> +touch /etc/selinux/dummy/contexts/virtual_image_context
>>>>> +
>>>>>    cp file_contexts /etc/selinux/dummy/contexts/files
>>>>>    cp dbus_contexts /etc/selinux/dummy/contexts
>>>>>    cp policy.$VERS /etc/selinux/dummy/policy
>>>>> @@ -33,37 +64,22 @@ 
>>>>> FC_FILE=/etc/selinux/dummy/contexts/files/file_contexts
>>>>>    if [ ! -d /etc/selinux ]; then
>>>>>        mkdir -p /etc/selinux
>>>>>    fi
>>>>> -if [ ! -f /etc/selinux/config ]; then
>>>>> -    cat > /etc/selinux/config << EOF
>>>>> -SELINUX=enforcing
>>>>> +if [ -f /etc/selinux/config ]; then
>>>>> +    echo "/etc/selinux/config exists, moving to 
>>>>> /etc/selinux/config.bak."
>>>>> +    mv /etc/selinux/config /etc/selinux/config.bak
>>>>> +fi
>>>>> +echo "Creating new /etc/selinux/config for dummy policy."
>>>>> +cat > /etc/selinux/config << EOF
>>>>> +SELINUX=permissive
>>>>>    SELINUXTYPE=dummy
>>>>>    EOF
>>>>> -else
>>>>> -    TYPE=`cat /etc/selinux/config | grep "^SELINUXTYPE" | tail -1 
>>>>> | awk -F= '{ print $2 '}`
>>>>> -    if [ "eq$TYPE" != "eqdummy" ]; then
>>>>> -        selinuxenabled
>>>>> -        if [ $? -eq 0 ]; then
>>>>> -            echo "SELinux already enabled with a non-dummy policy."
>>>>> -            echo "Exiting.  Please install policy by hand if that"
>>>>> -            echo "is what you REALLY want."
>>>>> -            exit 1
>>>>> -        fi
>>>>> -        mv /etc/selinux/config /etc/selinux/config.mdpbak
>>>>> -        grep -v "^SELINUXTYPE" /etc/selinux/config.mdpbak >> 
>>>>> /etc/selinux/config
>>>>> -        echo "SELINUXTYPE=dummy" >> /etc/selinux/config
>>>>> -    fi
>>>>> -fi
>>>>>    cd /etc/selinux/dummy/contexts/files
>>>>> -$SF file_contexts /
>>>>> +$SF -F file_contexts /
>>>>> -mounts=`cat /proc/$$/mounts | egrep 
>>>>> "ext2|ext3|xfs|jfs|ext4|ext4dev|gfs2" | awk '{ print $2 '}`
>>>>> -$SF file_contexts $mounts
>>>>> +mounts=`cat /proc/$$/mounts | \
>>>>> +    egrep "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
>>>>> +    awk '{ print $2 '}`
>>>>> +$SF -F file_contexts $mounts
>>>>> -
>>>>> -dodev=`cat /proc/$$/mounts | grep "/dev "`
>>>>> -if [ "eq$dodev" != "eq" ]; then
>>>>> -    mount --move /dev /mnt
>>>>> -    $SF file_contexts /dev
>>>>> -    mount --move /mnt /dev
>>>>> -fi
>>>>> +echo "-F" > /.autorelabel
>>>>> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
>>>>> index 073fe7537f6c..edaba8e51651 100644
>>>>> --- a/scripts/selinux/mdp/mdp.c
>>>>> +++ b/scripts/selinux/mdp/mdp.c
>>>>> @@ -33,6 +33,7 @@
>>>>>    #include <unistd.h>
>>>>>    #include <string.h>
>>>>>    #include <sys/socket.h>
>>>>> +#include <linux/kconfig.h>
>>>>>    static void usage(char *name)
>>>>>    {
>>>>> @@ -95,10 +96,31 @@ int main(int argc, char *argv[])
>>>>>        }
>>>>>        fprintf(fout, "\n");
>>>>> -    /* NOW PRINT OUT MLS STUFF */
>>>>> +    /* print out mls declarations and constraints */
>>>>>        if (mls) {
>>>>> -        printf("MLS not yet implemented\n");
>>>>> -        exit(1);
>>>>> +        fprintf(fout, "sensitivity s0;\n");
>>>>> +        fprintf(fout, "sensitivity s1;\n");
>>>>> +        fprintf(fout, "dominance { s0 s1 }\n");
>>>>> +        fprintf(fout, "category c0;\n");
>>>>> +        fprintf(fout, "category c1;\n");
>>>>> +        fprintf(fout, "level s0:c0.c1;\n");
>>>>> +        fprintf(fout, "level s1:c0.c1;\n");
>>>>> +#define SYSTEMLOW "s0"
>>>>> +#define SYSTEMHIGH "s1:c0.c1"
>>>>> +        for (i = 0; secclass_map[i].name; i++) {
>>>>> +            struct security_class_mapping *map = &secclass_map[i];
>>>>> +
>>>>> +            fprintf(fout, "mlsconstrain %s {\n", map->name);
>>>>> +            for (j = 0; map->perms[j]; j++)
>>>>> +                fprintf(fout, "\t%s\n", map->perms[j]);
>>>>> +            /*
>>>>> +             * This requires all subjects and objects to be
>>>>> +             * single-level (l2 eq h2), and that the subject
>>>>> +             * level dominate the object level (h1 dom h2)
>>>>> +             * in order to have any permissions to it.
>>>>> +             */
>>>>> +            fprintf(fout, "} (l2 eq h2 and h1 dom h2);\n\n");
>>>>> +        }
>>>>>        }
>>>>>        /* types, roles, and allows */
>>>>> @@ -108,34 +130,127 @@ int main(int argc, char *argv[])
>>>>>        for (i = 0; secclass_map[i].name; i++)
>>>>>            fprintf(fout, "allow base_t base_t:%s *;\n",
>>>>>                secclass_map[i].name);
>>>>> -    fprintf(fout, "user user_u roles { base_r };\n");
>>>>> -    fprintf(fout, "\n");
>>>>> +    fprintf(fout, "user user_u roles { base_r }");
>>>>> +    if (mls)
>>>>> +        fprintf(fout, " level %s range %s - %s", SYSTEMLOW,
>>>>> +            SYSTEMLOW, SYSTEMHIGH);
>>>>> +    fprintf(fout, ";\n");
>>>>> +
>>>>> +#define SUBJUSERROLETYPE "user_u:base_r:base_t"
>>>>> +#define OBJUSERROLETYPE "user_u:object_r:base_t"
>>>>>        /* default sids */
>>>>>        for (i = 1; i < initial_sid_to_string_len; i++)
>>>>> -        fprintf(fout, "sid %s user_u:base_r:base_t\n", 
>>>>> initial_sid_to_string[i]);
>>>>> +        fprintf(fout, "sid %s " SUBJUSERROLETYPE "%s\n",
>>>>> +            initial_sid_to_string[i], mls ? ":" SYSTEMLOW : "");
>>>>>        fprintf(fout, "\n");
>>>>> -    fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
>>>>> -    fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
>>>>> -    fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
>>>>> -    fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
>>>>> -    fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
>>>>> -    fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
>>>>> -    fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
>>>>> -    fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
>>>>> +#define FS_USE(behavior, fstype)                \
>>>>> +    fprintf(fout, "fs_use_%s %s " OBJUSERROLETYPE "%s;\n", \
>>>>> +        behavior, fstype, mls ? ":" SYSTEMLOW : "")
>>>>> +
>>>>> +    /*
>>>>> +     * Filesystems whose inode labels can be fetched via getxattr.
>>>>> +     */
>>>>> +#ifdef CONFIG_EXT2_FS_SECURITY
>>>>> +    FS_USE("xattr", "ext2");
>>>>> +#endif
>>>>> +#ifdef CONFIG_EXT4_FS_SECURITY
>>>>> +#ifdef CONFIG_EXT4_USE_FOR_EXT2
>>>>> +    FS_USE("xattr", "ext2");
>>>>> +#endif
>>>>> +    FS_USE("xattr", "ext3");
>>>>> +    FS_USE("xattr", "ext4");
>>>>> +#endif
>>>>> +#ifdef CONFIG_JFS_SECURITY
>>>>> +    FS_USE("xattr", "jfs");
>>>>> +#endif
>>>>> +#ifdef CONFIG_REISERFS_FS_SECURITY
>>>>> +    FS_USE("xattr", "reiserfs");
>>>>> +#endif
>>>>> +#ifdef CONFIG_JFFS2_FS_SECURITY
>>>>> +    FS_USE("xattr", "jffs2");
>>>>> +#endif
>>>>> +#ifdef CONFIG_XFS_FS
>>>>> +    FS_USE("xattr", "xfs");
>>>>> +#endif
>>>>> +#ifdef CONFIG_GFS2_FS
>>>>> +    FS_USE("xattr", "gfs2");
>>>>> +#endif
>>>>> +#ifdef CONFIG_BTRFS_FS
>>>>> +    FS_USE("xattr", "btrfs");
>>>>> +#endif
>>>>> +#ifdef CONFIG_F2FS_FS_SECURITY
>>>>> +    FS_USE("xattr", "f2fs");
>>>>> +#endif
>>>>> +#ifdef CONFIG_OCFS2_FS
>>>>> +    FS_USE("xattr", "ocsfs2");
>>>>> +#endif
>>>>> +#ifdef CONFIG_OVERLAY_FS
>>>>> +    FS_USE("xattr", "overlay");
>>>>> +#endif
>>>>> +#ifdef CONFIG_SQUASHFS_XATTR
>>>>> +    FS_USE("xattr", "squashfs");
>>>>> +#endif
>>>>> +
>>>>> +    /*
>>>>> +     * Filesystems whose inodes are labeled from allocating task.
>>>>> +     */
>>>>> +    FS_USE("task", "pipefs");
>>>>> +    FS_USE("task", "sockfs");
>>>>> -    fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t;\n");
>>>>> -    fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
>>>>> -    fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
>>>>> +    /*
>>>>> +     * Filesystems whose inode labels are computed from both
>>>>> +     * the allocating task and the superblock label.
>>>>> +     */
>>>>> +#ifdef CONFIG_UNIX98_PTYS
>>>>> +    FS_USE("trans", "devpts");
>>>>> +#endif
>>>>> +#ifdef CONFIG_HUGETLBFS
>>>>> +    FS_USE("trans", "hugetlbfs");
>>>>> +#endif
>>>>> +#ifdef CONFIG_TMPFS
>>>>> +    FS_USE("trans", "tmpfs");
>>>>> +#endif
>>>>> +#ifdef CONFIG_DEVTMPFS
>>>>> +    FS_USE("trans", "devtmpfs");
>>>>> +#endif
>>>>> +#ifdef CONFIG_POSIX_MQUEUE
>>>>> +    FS_USE("trans", "mqueue");
>>>>> +#endif
>>>>> -    fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
>>>>> -    fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
>>>>> -    fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
>>>>> -    fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
>>>>> -    fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
>>>>> +#define GENFSCON(fstype, prefix)                 \
>>>>> +    fprintf(fout, "genfscon %s %s " OBJUSERROLETYPE "%s\n", \
>>>>> +        fstype, prefix, mls ? ":" SYSTEMLOW : "")
>>>>> -    fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
>>>>> +    /*
>>>>> +     * Filesystems whose inodes are labeled from path prefix match
>>>>> +     * relative to the filesystem root.  Depending on the filesystem,
>>>>> +     * only a single label for all inodes may be supported.  Here
>>>>> +     * we list the filesystem types for which per-file labeling is
>>>>> +     * supported using genfscon; any other filesystem type can also
>>>>> +     * be added by only with a single entry for all of its inodes.
>>>>> +     */
>>>>> +#ifdef CONFIG_PROC_FS
>>>>> +    GENFSCON("proc", "/");
>>>>> +#endif
>>>>> +#ifdef CONFIG_SECURITY_SELINUX
>>>>> +    GENFSCON("selinuxfs", "/");
>>>>> +#endif
>>>>> +#ifdef CONFIG_SYSFS
>>>>> +    GENFSCON("sysfs", "/");
>>>>> +#endif
>>>>> +#ifdef CONFIG_DEBUG_FS
>>>>> +    GENFSCON("debugfs", "/");
>>>>> +#endif
>>>>> +#ifdef CONFIG_TRACING
>>>>> +    GENFSCON("tracefs", "/");
>>>>> +#endif
>>>>> +#ifdef CONFIG_PSTORE
>>>>> +    GENFSCON("pstore", "/");
>>>>> +#endif
>>>>> +    GENFSCON("cgroup", "/");
>>>>> +    GENFSCON("cgroup2", "/");
>>>>>        fclose(fout);
>>>>> @@ -144,8 +259,8 @@ int main(int argc, char *argv[])
>>>>>            printf("Wrote policy, but cannot open %s for writing\n", 
>>>>> ctxout);
>>>>>            usage(argv[0]);
>>>>>        }
>>>>> -    fprintf(fout, "/ user_u:base_r:base_t\n");
>>>>> -    fprintf(fout, "/.* user_u:base_r:base_t\n");
>>>>> +    fprintf(fout, "/ " OBJUSERROLETYPE "%s\n", mls ? ":" SYSTEMLOW 
>>>>> : "");
>>>>> +    fprintf(fout, "/.* " OBJUSERROLETYPE "%s\n", mls ? ":" 
>>>>> SYSTEMLOW : "");
>>>>>        fclose(fout);
>>>>>        return 0;
>>>>> -- 
>>>>> 2.20.1
>>>>>
>>>>
>>>
>>
> 

