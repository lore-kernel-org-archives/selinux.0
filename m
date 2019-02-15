Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84988C43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 15:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9DE207E0
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 15:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZMv3znK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfBOPFP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:05:15 -0500
Received: from uphb19pa10.eemsg.mail.mil ([214.24.26.84]:49530 "EHLO
        USFB19PA13.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726137AbfBOPFP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 10:05:15 -0500
X-EEMSG-check-017: 234638913|USFB19PA13_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Feb 2019 15:05:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550243105; x=1581779105;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kc1mXMrlIR2ksDpp5co8w+JWSU7LVhLCbKfQo/Az4tQ=;
  b=ZMv3znK5Pjm/VuHCgB7gvFR2ogEEmBY3WR0XiTMgg8P9huyW0J1iB2GD
   OI25LU3fTRXBgMTsX6q9U7uJNqsYBir+GYF7p2XJsTCygNKXKrRof6RdO
   dfcch/ZcLONHFss31Q11HzTI0LBOkihBh1RnkiOPh7NFkSctbV4NkhHeZ
   mDF/VjwA57XKPCpGSLJGPZUbI8IWLwD2ZVaOcq+LL1OYlvP+UJHBDrvwY
   Fn+HUfq3wl1a8d/OkhWCbPljbYCZMt6DP9ivBQlq9Q9WwsVow2r7XyzVK
   wV55VPhLAQfBFK7C7WCqzkHRu6xeaSbfOOPmjwU9Fuzq2qQgm7NM+v+wu
   A==;
X-IronPort-AV: E=Sophos;i="5.58,373,1544486400"; 
   d="scan'208";a="20596452"
IronPort-PHdr: =?us-ascii?q?9a23=3AT5+wZxxH8LvupIjXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2+4RIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HQbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RS?=
 =?us-ascii?q?qt4LtqSB/wiScIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyaOuB+fqfAdt0EQ2?=
 =?us-ascii?q?RPUNtaWyhYDo+ic4cDCuwMNvtaoYbgvVsDtQawCwmyCuPhyTFGiHH50qI43O?=
 =?us-ascii?q?s9Hg/LxxAgEtEUvXjIsNn4OqUfXOaox6fI1zXDaPZW1C/g5ojUbB8hufGMUq?=
 =?us-ascii?q?x2ccHM1EcvEhnKjlGUqYP7PzKey+MAs3OG4Op7Tu+vl24mpB1xojio3MssjJ?=
 =?us-ascii?q?LJiZgPxlDL8iV53p84KNulQ0B4ed6pCIZcui6VOodsQs4uXntktDg1x7EYo5?=
 =?us-ascii?q?K3YS4Hw4k9yRHFcfyIaY2I7wrmVOaWPDh3mmpoeKm6hxau6UigzfD8VtWs3F?=
 =?us-ascii?q?ZKsCVFlt7Mu2gR1xPJ8MiHS+Z9/ly71TaT1wHc9uFEIUcumardN5Eh2aI/mo?=
 =?us-ascii?q?AWsUTCGi/6gET2jKmIeUU44uWk9uvqb7r8qpKcKoN4kB/yP6swlsClHOg0Kg?=
 =?us-ascii?q?0OUHKa+eS42r3j50r5QLBSg/0tj6bZq4vXJdgbp6GlAw9V1Zwv6xCkDzi8yt?=
 =?us-ascii?q?gYkn4HLExddBKdk4fpI03OIOz/Dfqnm1Sjiiprx/TdM735GJrNM3zDnK7kfb?=
 =?us-ascii?q?Z67E5c0hQ8wcpD6JJTD7ELOOjzVVPptNzEEh85NBS5w/35B9V514MeX3+PA6?=
 =?us-ascii?q?CCPaPMvl+H+PgvL/OPZIALojb9LeYq5/r0gX8+g18dcvrh4ZxCUHmlGrxDJE?=
 =?us-ascii?q?KDbDK4mt4cFU8Stxc6Centj0ePFzVUYiDhcbg742QAFI++DYrFDruoibiF0T?=
 =?us-ascii?q?bzSoZafUhaG1uMFjHubIzCVPASPnHBavR9myAJAODyA7Qq0guj4UqjkeJq?=
X-IPAS-Result: =?us-ascii?q?A2AaAADS02Zc/wHyM5BkGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?wMBAQEBCwGBWSlngQMnhAaTfUwBAQEBAQEGgQgtiTmOXoF7LAwBhEACg2oiN?=
 =?us-ascii?q?gcNAQMBAQEBAQECAWwogjopAYJnAQUjBAsBBTwFEAkCGAICJgICVwYNBgIBA?=
 =?us-ascii?q?YJfPQGBZQ2QApthfDOKL4ELizkXeIEHgTiCa4gKglcCkEOBBpFxCYc8g2+HJ?=
 =?us-ascii?q?QYZknqeKwExgVYrCAIYCCEPO4JsCYIfF448IQMwgQUBAY8xAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Feb 2019 15:05:03 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1FF53B2011274;
        Fri, 15 Feb 2019 10:05:03 -0500
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
References: <20190215145045.31945-1-sds@tycho.nsa.gov>
 <CAHC9VhS+F-QBU-oJpXw1aAP1=TpekD1GEYB8y-QqEib1mzbwMA@mail.gmail.com>
 <5c95e956-6d38-78dd-75e2-df2c37bd998a@tycho.nsa.gov>
Message-ID: <3f279367-2c4f-5b26-e31b-58eb037b687b@tycho.nsa.gov>
Date:   Fri, 15 Feb 2019 10:05:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5c95e956-6d38-78dd-75e2-df2c37bd998a@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/15/19 10:03 AM, Stephen Smalley wrote:
> On 2/15/19 10:00 AM, Paul Moore wrote:
>> On Fri, Feb 15, 2019 at 9:51 AM Stephen Smalley <sds@tycho.nsa.gov> 
>> wrote:
>>> Add basic MLS policy support to mdp.  Declares
>>> two sensitivities and two categories, defines
>>> mls constraints for all permissions requiring
>>> dominance (ala MCS), assigns the system-high
>>> level to initial SID contexts and the default user
>>> level, and assigns system-low level to filesystems.
>>>
>>> Also reworks the fs_use and genfscon rules to only
>>> generate rules for filesystems that are configured
>>> in the kernel.  In some cases this depends on a specific
>>> config option for security xattrs, in other cases security
>>> xattrs are unconditionally supported by a given filesystem
>>> if the filesystem is enabled, and in some cases the filesystem
>>> is always enabled in the kernel.  Dropped obsolete pseudo
>>> filesystems.
>>>
>>> NB The list of fs_use_* and genfscon rules emitted by mdp
>>> is very incomplete compared to refpolicy or Android sepolicy.
>>> We should probably expand it.
>>>
>>> Usage:
>>> scripts/selinux/mdp/mdp -m policy.conf file_contexts
>>> checkpolicy -M -o policy policy.conf
>>>
>>> Then install the resulting policy and file_contexts as usual.
>>>
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> ---
>>> v3 fixes up the file contexts generation code to also use SYSTEMLOW and
>>> collapse down to a single fprintf call per line.
>>>   scripts/selinux/mdp/mdp.c | 131 ++++++++++++++++++++++++++++++--------
>>>   1 file changed, 103 insertions(+), 28 deletions(-)
>>
>> This is great Stephen, thanks for working on this - and rather quickly
>> too!  For those who don't follow the GitHub issues, I just opened an
>> issue yesterday mentioning it would be nice to add MLS support to the
>> mdp tool.
>>
>> Are you planning to keep playing with this?  I'm asking not because I
>> think it needs more work to be worthwhile, but rather I don't want to
>> merge something that you want to continue working on.  If you are
>> happy with this latest patch I think it is okay to merge this into
>> selinux/next, even at this late stage, simply because it is not part
>> of a built kernel, but rather a developer's tool.
> 
> No, I think I'm done for now unless you find a problem with it.  Absent 
> some compelling use case for mdp it is hard to justify spending any more 
> time on it.

Note however that the instructions in 
Documentation/admin-guide/LSM/SELinux.rst just say to run 
scripts/selinux/install_policy.sh and since that doesn't pass -m to mdp 
or -M to checkpolicy, no one will use this support unless they do it all 
by hand.

> 
>>
>>> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
>>> index 073fe7537f6c..4223e2fea441 100644
>>> --- a/scripts/selinux/mdp/mdp.c
>>> +++ b/scripts/selinux/mdp/mdp.c
>>> @@ -33,6 +33,7 @@
>>>   #include <unistd.h>
>>>   #include <string.h>
>>>   #include <sys/socket.h>
>>> +#include <linux/kconfig.h>
>>>
>>>   static void usage(char *name)
>>>   {
>>> @@ -95,10 +96,31 @@ int main(int argc, char *argv[])
>>>          }
>>>          fprintf(fout, "\n");
>>>
>>> -       /* NOW PRINT OUT MLS STUFF */
>>> +       /* print out mls declarations and constraints */
>>>          if (mls) {
>>> -               printf("MLS not yet implemented\n");
>>> -               exit(1);
>>> +               fprintf(fout, "sensitivity s0;\n");
>>> +               fprintf(fout, "sensitivity s1;\n");
>>> +               fprintf(fout, "dominance { s0 s1 }\n");
>>> +               fprintf(fout, "category c0;\n");
>>> +               fprintf(fout, "category c1;\n");
>>> +               fprintf(fout, "level s0:c0.c1;\n");
>>> +               fprintf(fout, "level s1:c0.c1;\n");
>>> +#define SYSTEMLOW "s0"
>>> +#define SYSTEMHIGH "s1:c0.c1"
>>> +               for (i = 0; secclass_map[i].name; i++) {
>>> +                       struct security_class_mapping *map = 
>>> &secclass_map[i];
>>> +
>>> +                       fprintf(fout, "mlsconstrain %s {\n", map->name);
>>> +                       for (j = 0; map->perms[j]; j++)
>>> +                               fprintf(fout, "\t%s\n", map->perms[j]);
>>> +                       /*
>>> +                        * This requires all subjects and objects to be
>>> +                        * single-level (l2 eq h2), and that the subject
>>> +                        * level dominate the object level (h1 dom h2)
>>> +                        * in order to have any permissions to it.
>>> +                        */
>>> +                       fprintf(fout, "} (l2 eq h2 and h1 dom 
>>> h2);\n\n");
>>> +               }
>>>          }
>>>
>>>          /* types, roles, and allows */
>>> @@ -108,34 +130,87 @@ int main(int argc, char *argv[])
>>>          for (i = 0; secclass_map[i].name; i++)
>>>                  fprintf(fout, "allow base_t base_t:%s *;\n",
>>>                          secclass_map[i].name);
>>> -       fprintf(fout, "user user_u roles { base_r };\n");
>>> -       fprintf(fout, "\n");
>>> +       fprintf(fout, "user user_u roles { base_r }");
>>> +       if (mls)
>>> +               fprintf(fout, " level %s range %s - %s", SYSTEMHIGH,
>>> +                       SYSTEMLOW, SYSTEMHIGH);
>>> +       fprintf(fout, ";\n");
>>> +
>>> +#define USERROLETYPE "user_u:base_r:base_t"
>>>
>>>          /* default sids */
>>>          for (i = 1; i < initial_sid_to_string_len; i++)
>>> -               fprintf(fout, "sid %s user_u:base_r:base_t\n", 
>>> initial_sid_to_string[i]);
>>> +               fprintf(fout, "sid %s " USERROLETYPE "%s\n",
>>> +                       initial_sid_to_string[i], mls ? ":" 
>>> SYSTEMHIGH : "");
>>>          fprintf(fout, "\n");
>>>
>>> -       fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
>>> -       fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
>>> -       fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
>>> -       fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
>>> -       fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
>>> -       fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
>>> -       fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
>>> -       fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
>>> -
>>> -       fprintf(fout, "fs_use_task eventpollfs 
>>> user_u:base_r:base_t;\n");
>>> -       fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
>>> -       fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
>>> -
>>> -       fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
>>> -       fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
>>> -       fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
>>> -       fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
>>> -       fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
>>> -
>>> -       fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
>>> +#define FS_USE(behavior, fstype)                           \
>>> +       fprintf(fout, "fs_use_%s %s " USERROLETYPE "%s;\n", \
>>> +               behavior, fstype, mls ? ":" SYSTEMLOW : "")
>>> +
>>> +       /*
>>> +        * Filesystems whose inode labels can be fetched via getxattr.
>>> +        */
>>> +#ifdef CONFIG_EXT2_FS_SECURITY
>>> +       FS_USE("xattr", "ext2");
>>> +#endif
>>> +#ifdef CONFIG_EXT3_FS_SECURITY
>>> +       FS_USE("xattr", "ext3");
>>> +#endif
>>> +#ifdef CONFIG_EXT4_FS_SECURITY
>>> +       FS_USE("xattr", "ext4");
>>> +#endif
>>> +#ifdef CONFIG_JFS_SECURITY
>>> +       FS_USE("xattr", "jfs");
>>> +#endif
>>> +#ifdef CONFIG_REISERFS_FS_SECURITY
>>> +       FS_USE("xattr", "reiserfs");
>>> +#endif
>>> +#ifdef CONFIG_JFFS2_FS_SECURITY
>>> +       FS_USE("xattr", "jffs2");
>>> +#endif
>>> +#ifdef CONFIG_XFS_FS
>>> +       FS_USE("xattr", "xfs");
>>> +#endif
>>> +#ifdef CONFIG_GFS2_FS
>>> +       FS_USE("xattr", "gfs2");
>>> +#endif
>>> +
>>> +       /*
>>> +        * Filesystems whose inodes are labeled from allocating task.
>>> +        */
>>> +       FS_USE("task", "pipefs");
>>> +       FS_USE("task", "sockfs");
>>> +#ifdef CONFIG_POSIX_MQUEUE
>>> +       FS_USE("task", "mqueue");
>>> +#endif
>>> +
>>> +       /*
>>> +        * Filesystems whose inode labels are computed from both
>>> +        * the allocating task and the superblock label.
>>> +        */
>>> +#ifdef CONFIG_UNIX98_PTYS
>>> +       FS_USE("trans", "devpts");
>>> +#endif
>>> +#ifdef CONFIG_HUGETLBFS
>>> +       FS_USE("trans", "hugetlbfs");
>>> +#endif
>>> +#ifdef CONFIG_TMPFS
>>> +       FS_USE("trans", "tmpfs");
>>> +#endif
>>> +
>>> +
>>> +#define GENFSCON(fstype, prefix)                            \
>>> +       fprintf(fout, "genfscon %s %s " USERROLETYPE "%s\n", \
>>> +               fstype, prefix, mls ? ":" SYSTEMLOW : "")
>>> +
>>> +       /*
>>> +        * Filesystems whose inodes are labeled from path prefix match
>>> +        * relative to the filesystem root.  Depending on the 
>>> filesystem,
>>> +        * only a single label for all inodes may be supported.
>>> +        */
>>> +       GENFSCON("proc", "/");
>>> +       GENFSCON("selinuxfs", "/");
>>>
>>>          fclose(fout);
>>>
>>> @@ -144,8 +219,8 @@ int main(int argc, char *argv[])
>>>                  printf("Wrote policy, but cannot open %s for 
>>> writing\n", ctxout);
>>>                  usage(argv[0]);
>>>          }
>>> -       fprintf(fout, "/ user_u:base_r:base_t\n");
>>> -       fprintf(fout, "/.* user_u:base_r:base_t\n");
>>> +       fprintf(fout, "/ " USERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : 
>>> "");
>>> +       fprintf(fout, "/.* " USERROLETYPE "%s\n", mls ? ":" SYSTEMLOW 
>>> : "");
>>>          fclose(fout);
>>>
>>>          return 0;
>>> -- 
>>> 2.20.1
>>>
>>
>>
> 

