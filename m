Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93020C43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 17:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA3B2190C
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 17:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="W1fsN5xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfBORQM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:16:12 -0500
Received: from uhil19pa11.eemsg.mail.mil ([214.24.21.84]:5630 "EHLO
        uhil19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfBORQL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 12:16:11 -0500
X-EEMSG-check-017: 386177787|UHIL19PA11_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Feb 2019 17:16:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550250969; x=1581786969;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XG38ITWCKriWxUvKUmvPUZKec10Loa1pmT5WZTNrq30=;
  b=W1fsN5xi2Xz79oxTsUchG2I1evvzNwoQdAojzNRdGG9f0z6MqGFZ2fJo
   /k3X7yTaO6SCHyVfO3FFImN6CzeK7AnEty6jsZgzJkJCz4VP/MU3FVuZS
   MaYEgSPq2czPqKEHsDI09ZhUoimvbAixYSIxfx7UNFkKZy4uKlv4Wiv/0
   TsTKdKkUn3uV3rcYeSmegJjCMJg/EQ1KWGDArZhHYVEYl96ubhsC1opjW
   BMfXvjnNEgRTlKLVKubsd2Ezaw+p8RAzZc5RyAth+NRgMap+nrqut4BIR
   S2VJbdTyBfVrEUW3OhaUUC6Vw7M9BwrGkFN+O82sf8e+VAsG48WpRzdEA
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,373,1544486400"; 
   d="scan'208";a="20605035"
IronPort-PHdr: =?us-ascii?q?9a23=3ACMImiBC3X/c75hMAK5L4UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX6o8bcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEfYNMeNeooLgpVUBsAG+CBGxCu3xxD9Ghnz406M03O?=
 =?us-ascii?q?suEw7JwAMuEskSsHnXttj5KLseXO63waTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqE4NQujmHO4Z5Tc4uWWFltDsgxrEYtp?=
 =?us-ascii?q?O3YjIGxIkhyhXCcfKIaZKI7QjmVOuJJDd4g29qd6ynihap9Eig1vX8Vs6p0F?=
 =?us-ascii?q?ZWtiZFksfDtnQK1xHL9siIUOF9/ka82TaUzQzT9uFFLlw0larcMZIhxKI/lo?=
 =?us-ascii?q?EPvkjZGy/2mUH2gLeXdkUi5Oeo9/zqbqjpq5KTLYN5ihzyPr4wlsGwH+g0KB?=
 =?us-ascii?q?UCU3Ce+eum1b3j+UP5QK9Njv0ziqTZq43VJd8Aq66lAw5azoYj6xGlAzegy9?=
 =?us-ascii?q?QXh2MLLF1CeBKZl4TpIU3BIOjkDfejhFShiCpkyOraMbH7BZXNMGbMkK37fb?=
 =?us-ascii?q?Z89kFT1hE+zd9a551OC7EBJOj/VVP2tNzdFhU5KRC7w/77CNVh0YMTQXqPDb?=
 =?us-ascii?q?WEMKPWqlKI/vggI/SIZIMMvTb9LP8l5+TwgnMjhVAdeqyp14MNaH+kBvRmP1?=
 =?us-ascii?q?mZYX30j9caD2gKugs+TOr3iFyNSjNTeXmyULwm5j0hC4KpE53DRoazj7yFxi?=
 =?us-ascii?q?u7GYdWZm8VQmyLRFvvcoSCWvwPIA2II8F92mgIXLPnTJEszwuvuALSxL9uL+?=
 =?us-ascii?q?6S8Sod48HNzt9wstbPmAky+Do8NMGU12WAXikghW8TbyMn16B450pmwxGM1r?=
 =?us-ascii?q?Yu0K8QLsBa+/4cClRyDpXb1eEvTomoAg8=3D?=
X-IPAS-Result: =?us-ascii?q?A2CZAACS8mZc/wHyM5BkHAEBAQQBAQcEAQGBUgYBAQsBg?=
 =?us-ascii?q?VkpZ4EDJ4QGk35MAQEBAQEBBoEICCWJOY5egXssDAGEQAKDaiI1CA0BAwEBA?=
 =?us-ascii?q?QEBAQIBbCiCOikBgmcBBSMECwEFPAUQCQIOCgICJgICVwYNBgIBAYJfPQGBZ?=
 =?us-ascii?q?Q2QXZthfDOFRIRrgQuLKg8XeIEHgREnDIJfhQGDCYJXApBDgQaRcQmHPINvh?=
 =?us-ascii?q?yUGGZJ6mRCFFwMzgVYrCAIYCCEPO4JsCYIfF448IQMwgQUBAY8xAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Feb 2019 17:16:08 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1FHG87N024600;
        Fri, 15 Feb 2019 12:16:08 -0500
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
To:     Dominick Grift <dac.override@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <20190215145045.31945-1-sds@tycho.nsa.gov>
 <CAHC9VhS+F-QBU-oJpXw1aAP1=TpekD1GEYB8y-QqEib1mzbwMA@mail.gmail.com>
 <5c95e956-6d38-78dd-75e2-df2c37bd998a@tycho.nsa.gov>
 <3f279367-2c4f-5b26-e31b-58eb037b687b@tycho.nsa.gov>
 <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov>
 <0e556b37-90fa-7f3a-f60f-fa77acce6f5b@tycho.nsa.gov>
 <87zhqxkn8a.fsf@gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <95b39232-028a-9589-d15b-ba352954f2bd@tycho.nsa.gov>
Date:   Fri, 15 Feb 2019 12:16:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87zhqxkn8a.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/15/19 11:52 AM, Dominick Grift wrote:
> Stephen Smalley <sds@tycho.nsa.gov> writes:
> 
>> On 2/15/19 10:25 AM, Stephen Smalley wrote:
>>> On 2/15/19 10:05 AM, Stephen Smalley wrote:
>>>> On 2/15/19 10:03 AM, Stephen Smalley wrote:
>>>>> On 2/15/19 10:00 AM, Paul Moore wrote:
>>>>>> On Fri, Feb 15, 2019 at 9:51 AM Stephen Smalley
>>>>>> <sds@tycho.nsa.gov> wrote:
>>>>>>> Add basic MLS policy support to mdp.  Declares
>>>>>>> two sensitivities and two categories, defines
>>>>>>> mls constraints for all permissions requiring
>>>>>>> dominance (ala MCS), assigns the system-high
>>>>>>> level to initial SID contexts and the default user
>>>>>>> level, and assigns system-low level to filesystems.
>>>>>>>
>>>>>>> Also reworks the fs_use and genfscon rules to only
>>>>>>> generate rules for filesystems that are configured
>>>>>>> in the kernel.  In some cases this depends on a specific
>>>>>>> config option for security xattrs, in other cases security
>>>>>>> xattrs are unconditionally supported by a given filesystem
>>>>>>> if the filesystem is enabled, and in some cases the filesystem
>>>>>>> is always enabled in the kernel.  Dropped obsolete pseudo
>>>>>>> filesystems.
>>>>>>>
>>>>>>> NB The list of fs_use_* and genfscon rules emitted by mdp
>>>>>>> is very incomplete compared to refpolicy or Android sepolicy.
>>>>>>> We should probably expand it.
>>>>>>>
>>>>>>> Usage:
>>>>>>> scripts/selinux/mdp/mdp -m policy.conf file_contexts
>>>>>>> checkpolicy -M -o policy policy.conf
>>>>>>>
>>>>>>> Then install the resulting policy and file_contexts as usual.
>>>>>>>
>>>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>>>> ---
>>>>>>> v3 fixes up the file contexts generation code to also use
>>>>>>> SYSTEMLOW and
>>>>>>> collapse down to a single fprintf call per line.
>>>>>>>    scripts/selinux/mdp/mdp.c | 131
>>>>>>> ++++++++++++++++++++++++++++++--------
>>>>>>>    1 file changed, 103 insertions(+), 28 deletions(-)
>>>>>>
>>>>>> This is great Stephen, thanks for working on this - and rather quickly
>>>>>> too!  For those who don't follow the GitHub issues, I just opened an
>>>>>> issue yesterday mentioning it would be nice to add MLS support to the
>>>>>> mdp tool.
>>>>>>
>>>>>> Are you planning to keep playing with this?  I'm asking not because I
>>>>>> think it needs more work to be worthwhile, but rather I don't want to
>>>>>> merge something that you want to continue working on.  If you are
>>>>>> happy with this latest patch I think it is okay to merge this into
>>>>>> selinux/next, even at this late stage, simply because it is not part
>>>>>> of a built kernel, but rather a developer's tool.
>>>>>
>>>>> No, I think I'm done for now unless you find a problem with
>>>>> it. Absent some compelling use case for mdp it is hard to justify
>>>>> spending any more time on it.
>>>>
>>>> Note however that the instructions in
>>>> Documentation/admin-guide/LSM/SELinux.rst just say to run
>>>> scripts/selinux/install_policy.sh and since that doesn't pass -m to
>>>> mdp or -M to checkpolicy, no one will use this support unless they
>>>> do it all by hand.
>>>
>>> FWIW, a Fedora system wouldn't come up cleanly with this policy.
>>> Partly appears to be due to systemd having embedded security
>>> contexts specific to Fedora/refpolicy into its own configurations
>>> and partly due to MLS denials.  I don't even know if it would work
>>> before this change though...
>>
>> Couldn't seem to get a mdp-generated policy to boot on Fedora even in
>> permissive, before or after this change.  I assume it has to do with
>> leaking of contexts outside of the policy and/or missing config files
>> from the dummy policy (e.g. /etc/selinux/targeted/contexts/ has
>> systemd_contexts and other userspace config files that don't exist in
>> the mdp policy).  More evidence of the irrelevance of mdp...
> 
> Oh, right you need a "dbus_contexts" file probably. DBUS refuses to
> start without it, and these day's without dbus no system

There is actually a dbus_contexts file provided for mdp 
(scripts/selinux/mdp/dbus_contexts) but not a systemd_contexts or any 
other *_contexts files besides file_contexts.

> 
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
>>>>>>> index 073fe7537f6c..4223e2fea441 100644
>>>>>>> --- a/scripts/selinux/mdp/mdp.c
>>>>>>> +++ b/scripts/selinux/mdp/mdp.c
>>>>>>> @@ -33,6 +33,7 @@
>>>>>>>    #include <unistd.h>
>>>>>>>    #include <string.h>
>>>>>>>    #include <sys/socket.h>
>>>>>>> +#include <linux/kconfig.h>
>>>>>>>
>>>>>>>    static void usage(char *name)
>>>>>>>    {
>>>>>>> @@ -95,10 +96,31 @@ int main(int argc, char *argv[])
>>>>>>>           }
>>>>>>>           fprintf(fout, "\n");
>>>>>>>
>>>>>>> -       /* NOW PRINT OUT MLS STUFF */
>>>>>>> +       /* print out mls declarations and constraints */
>>>>>>>           if (mls) {
>>>>>>> -               printf("MLS not yet implemented\n");
>>>>>>> -               exit(1);
>>>>>>> +               fprintf(fout, "sensitivity s0;\n");
>>>>>>> +               fprintf(fout, "sensitivity s1;\n");
>>>>>>> +               fprintf(fout, "dominance { s0 s1 }\n");
>>>>>>> +               fprintf(fout, "category c0;\n");
>>>>>>> +               fprintf(fout, "category c1;\n");
>>>>>>> +               fprintf(fout, "level s0:c0.c1;\n");
>>>>>>> +               fprintf(fout, "level s1:c0.c1;\n");
>>>>>>> +#define SYSTEMLOW "s0"
>>>>>>> +#define SYSTEMHIGH "s1:c0.c1"
>>>>>>> +               for (i = 0; secclass_map[i].name; i++) {
>>>>>>> +                       struct security_class_mapping *map =
>>>>>>> &secclass_map[i];
>>>>>>> +
>>>>>>> +                       fprintf(fout, "mlsconstrain %s {\n",
>>>>>>> map->name);
>>>>>>> +                       for (j = 0; map->perms[j]; j++)
>>>>>>> +                               fprintf(fout, "\t%s\n",
>>>>>>> map->perms[j]);
>>>>>>> +                       /*
>>>>>>> +                        * This requires all subjects and
>>>>>>> objects to be
>>>>>>> +                        * single-level (l2 eq h2), and that the
>>>>>>> subject
>>>>>>> +                        * level dominate the object level (h1 dom h2)
>>>>>>> +                        * in order to have any permissions to it.
>>>>>>> +                        */
>>>>>>> +                       fprintf(fout, "} (l2 eq h2 and h1 dom
>>>>>>> h2);\n\n");
>>>>>>> +               }
>>>>>>>           }
>>>>>>>
>>>>>>>           /* types, roles, and allows */
>>>>>>> @@ -108,34 +130,87 @@ int main(int argc, char *argv[])
>>>>>>>           for (i = 0; secclass_map[i].name; i++)
>>>>>>>                   fprintf(fout, "allow base_t base_t:%s *;\n",
>>>>>>>                           secclass_map[i].name);
>>>>>>> -       fprintf(fout, "user user_u roles { base_r };\n");
>>>>>>> -       fprintf(fout, "\n");
>>>>>>> +       fprintf(fout, "user user_u roles { base_r }");
>>>>>>> +       if (mls)
>>>>>>> +               fprintf(fout, " level %s range %s - %s", SYSTEMHIGH,
>>>>>>> +                       SYSTEMLOW, SYSTEMHIGH);
>>>>>>> +       fprintf(fout, ";\n");
>>>>>>> +
>>>>>>> +#define USERROLETYPE "user_u:base_r:base_t"
>>>>>>>
>>>>>>>           /* default sids */
>>>>>>>           for (i = 1; i < initial_sid_to_string_len; i++)
>>>>>>> -               fprintf(fout, "sid %s user_u:base_r:base_t\n",
>>>>>>> initial_sid_to_string[i]);
>>>>>>> +               fprintf(fout, "sid %s " USERROLETYPE "%s\n",
>>>>>>> +                       initial_sid_to_string[i], mls ? ":"
>>>>>>> SYSTEMHIGH : "");
>>>>>>>           fprintf(fout, "\n");
>>>>>>>
>>>>>>> -       fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
>>>>>>> -       fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
>>>>>>> -       fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
>>>>>>> -       fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
>>>>>>> -       fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
>>>>>>> -       fprintf(fout, "fs_use_xattr reiserfs
>>>>>>> user_u:base_r:base_t;\n");
>>>>>>> -       fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
>>>>>>> -       fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
>>>>>>> -
>>>>>>> -       fprintf(fout, "fs_use_task eventpollfs
>>>>>>> user_u:base_r:base_t;\n");
>>>>>>> -       fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
>>>>>>> -       fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
>>>>>>> -
>>>>>>> -       fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
>>>>>>> -       fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
>>>>>>> -       fprintf(fout, "fs_use_trans hugetlbfs
>>>>>>> user_u:base_r:base_t;\n");
>>>>>>> -       fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
>>>>>>> -       fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
>>>>>>> -
>>>>>>> -       fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
>>>>>>> +#define FS_USE(behavior, fstype)                           \
>>>>>>> +       fprintf(fout, "fs_use_%s %s " USERROLETYPE "%s;\n", \
>>>>>>> +               behavior, fstype, mls ? ":" SYSTEMLOW : "")
>>>>>>> +
>>>>>>> +       /*
>>>>>>> +        * Filesystems whose inode labels can be fetched via getxattr.
>>>>>>> +        */
>>>>>>> +#ifdef CONFIG_EXT2_FS_SECURITY
>>>>>>> +       FS_USE("xattr", "ext2");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_EXT3_FS_SECURITY
>>>>>>> +       FS_USE("xattr", "ext3");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_EXT4_FS_SECURITY
>>>>>>> +       FS_USE("xattr", "ext4");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_JFS_SECURITY
>>>>>>> +       FS_USE("xattr", "jfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_REISERFS_FS_SECURITY
>>>>>>> +       FS_USE("xattr", "reiserfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_JFFS2_FS_SECURITY
>>>>>>> +       FS_USE("xattr", "jffs2");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_XFS_FS
>>>>>>> +       FS_USE("xattr", "xfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_GFS2_FS
>>>>>>> +       FS_USE("xattr", "gfs2");
>>>>>>> +#endif
>>>>>>> +
>>>>>>> +       /*
>>>>>>> +        * Filesystems whose inodes are labeled from allocating task.
>>>>>>> +        */
>>>>>>> +       FS_USE("task", "pipefs");
>>>>>>> +       FS_USE("task", "sockfs");
>>>>>>> +#ifdef CONFIG_POSIX_MQUEUE
>>>>>>> +       FS_USE("task", "mqueue");
>>>>>>> +#endif
>>>>>>> +
>>>>>>> +       /*
>>>>>>> +        * Filesystems whose inode labels are computed from both
>>>>>>> +        * the allocating task and the superblock label.
>>>>>>> +        */
>>>>>>> +#ifdef CONFIG_UNIX98_PTYS
>>>>>>> +       FS_USE("trans", "devpts");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_HUGETLBFS
>>>>>>> +       FS_USE("trans", "hugetlbfs");
>>>>>>> +#endif
>>>>>>> +#ifdef CONFIG_TMPFS
>>>>>>> +       FS_USE("trans", "tmpfs");
>>>>>>> +#endif
>>>>>>> +
>>>>>>> +
>>>>>>> +#define GENFSCON(fstype, prefix)                            \
>>>>>>> +       fprintf(fout, "genfscon %s %s " USERROLETYPE "%s\n", \
>>>>>>> +               fstype, prefix, mls ? ":" SYSTEMLOW : "")
>>>>>>> +
>>>>>>> +       /*
>>>>>>> +        * Filesystems whose inodes are labeled from path prefix match
>>>>>>> +        * relative to the filesystem root.  Depending on the
>>>>>>> filesystem,
>>>>>>> +        * only a single label for all inodes may be supported.
>>>>>>> +        */
>>>>>>> +       GENFSCON("proc", "/");
>>>>>>> +       GENFSCON("selinuxfs", "/");
>>>>>>>
>>>>>>>           fclose(fout);
>>>>>>>
>>>>>>> @@ -144,8 +219,8 @@ int main(int argc, char *argv[])
>>>>>>>                   printf("Wrote policy, but cannot open %s for
>>>>>>> writing\n", ctxout);
>>>>>>>                   usage(argv[0]);
>>>>>>>           }
>>>>>>> -       fprintf(fout, "/ user_u:base_r:base_t\n");
>>>>>>> -       fprintf(fout, "/.* user_u:base_r:base_t\n");
>>>>>>> +       fprintf(fout, "/ " USERROLETYPE "%s\n", mls ? ":"
>>>>>>> SYSTEMLOW : "");
>>>>>>> +       fprintf(fout, "/.* " USERROLETYPE "%s\n", mls ? ":"
>>>>>>> SYSTEMLOW : "");
>>>>>>>           fclose(fout);
>>>>>>>
>>>>>>>           return 0;
>>>>>>> -- 
>>>>>>> 2.20.1
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

