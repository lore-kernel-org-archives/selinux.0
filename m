Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A23FC43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 15:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F49206C0
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 15:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BfwOrCgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfBOPA7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:00:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41894 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfBOPA7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 10:00:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id z25so795028ljk.8
        for <selinux@vger.kernel.org>; Fri, 15 Feb 2019 07:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TzCRur4Getd4FYAATOPBx1tiJTSuNQx2T4hYuhJeb4=;
        b=BfwOrCgGHwAOnZkdAG5Z97lH3qlLfTYcQsaziskWVFmdz53E9rhh5qyywFDPoekz8r
         v18U37tviogfsuY/5tjQNQBScBWLGEgCrwdapuZ/slgjnuz4xBVRnVDlNF5DFRDYrapW
         v6V2BJgqe8msqzoDfRhVwBLEcqmrN8T7sqzfPhYwBaB9pH8CysxIsvJz5VEGzzrLgYG1
         EoPU42sdBH2eLXkaFqPhJwQhhDE0266+VXf3jHa7JAII7+/TUOp5amyt1KFFxKchTDB7
         T9ODofeGvCdQNoN30Y6dIXCtsnxfDjl/V2w9dJrYTEN1LWYZOIAxSADsdwQRMryEXxhk
         nWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TzCRur4Getd4FYAATOPBx1tiJTSuNQx2T4hYuhJeb4=;
        b=jxkip4M4dFsfk4ddGlFfM2dFbgn14n2BNP7I2kMK451tzSEMQD6Vn+dkzPHz+GEOmY
         05Of6dycVOcEBb+rNKJlM48aGyVZwa47MO5ZH6bocEmJeXcH5s8s4rihLJ6qpuLAneXl
         K7iSPzaUrV3K6s7v5NFF1ZeVa4WAUoO0xlOHdxphpcv0zYW0KqCQhuXx62r2Ro3uksTE
         16jm5PFxvEiUc6xZjcO/wpK+aM4+Bc2VJXtYpbAA/EbIGkmaaBC27tqChvbUKLFT9x+b
         qU7FPCZpbtwqOUse9jAiHpd+kjYwcIIQINX59ylCawCJsl7TXcFK995xdHk0PHRIidxM
         eYhQ==
X-Gm-Message-State: AHQUAuZMdRPndKL57lYmZubdEV3p55WA220wsMS3Mp/zckkbdalfyc4f
        o+jOhlkRSMwH69Zw5BLPAyF2UXj3NuFLsHffTcVj
X-Google-Smtp-Source: AHgI3IY8cnv60cyH4wiDgWYbzhSHpiYmuO6F3GAIuhLFBzLefbFTQVFi1nQvonhzQj2wlyOcoEEBRqkvi0/168IZYxY=
X-Received: by 2002:a2e:3308:: with SMTP id d8-v6mr5790320ljc.38.1550242856564;
 Fri, 15 Feb 2019 07:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20190215145045.31945-1-sds@tycho.nsa.gov>
In-Reply-To: <20190215145045.31945-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Feb 2019 10:00:39 -0500
Message-ID: <CAHC9VhS+F-QBU-oJpXw1aAP1=TpekD1GEYB8y-QqEib1mzbwMA@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 15, 2019 at 9:51 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Add basic MLS policy support to mdp.  Declares
> two sensitivities and two categories, defines
> mls constraints for all permissions requiring
> dominance (ala MCS), assigns the system-high
> level to initial SID contexts and the default user
> level, and assigns system-low level to filesystems.
>
> Also reworks the fs_use and genfscon rules to only
> generate rules for filesystems that are configured
> in the kernel.  In some cases this depends on a specific
> config option for security xattrs, in other cases security
> xattrs are unconditionally supported by a given filesystem
> if the filesystem is enabled, and in some cases the filesystem
> is always enabled in the kernel.  Dropped obsolete pseudo
> filesystems.
>
> NB The list of fs_use_* and genfscon rules emitted by mdp
> is very incomplete compared to refpolicy or Android sepolicy.
> We should probably expand it.
>
> Usage:
> scripts/selinux/mdp/mdp -m policy.conf file_contexts
> checkpolicy -M -o policy policy.conf
>
> Then install the resulting policy and file_contexts as usual.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> v3 fixes up the file contexts generation code to also use SYSTEMLOW and
> collapse down to a single fprintf call per line.
>  scripts/selinux/mdp/mdp.c | 131 ++++++++++++++++++++++++++++++--------
>  1 file changed, 103 insertions(+), 28 deletions(-)

This is great Stephen, thanks for working on this - and rather quickly
too!  For those who don't follow the GitHub issues, I just opened an
issue yesterday mentioning it would be nice to add MLS support to the
mdp tool.

Are you planning to keep playing with this?  I'm asking not because I
think it needs more work to be worthwhile, but rather I don't want to
merge something that you want to continue working on.  If you are
happy with this latest patch I think it is okay to merge this into
selinux/next, even at this late stage, simply because it is not part
of a built kernel, but rather a developer's tool.

> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
> index 073fe7537f6c..4223e2fea441 100644
> --- a/scripts/selinux/mdp/mdp.c
> +++ b/scripts/selinux/mdp/mdp.c
> @@ -33,6 +33,7 @@
>  #include <unistd.h>
>  #include <string.h>
>  #include <sys/socket.h>
> +#include <linux/kconfig.h>
>
>  static void usage(char *name)
>  {
> @@ -95,10 +96,31 @@ int main(int argc, char *argv[])
>         }
>         fprintf(fout, "\n");
>
> -       /* NOW PRINT OUT MLS STUFF */
> +       /* print out mls declarations and constraints */
>         if (mls) {
> -               printf("MLS not yet implemented\n");
> -               exit(1);
> +               fprintf(fout, "sensitivity s0;\n");
> +               fprintf(fout, "sensitivity s1;\n");
> +               fprintf(fout, "dominance { s0 s1 }\n");
> +               fprintf(fout, "category c0;\n");
> +               fprintf(fout, "category c1;\n");
> +               fprintf(fout, "level s0:c0.c1;\n");
> +               fprintf(fout, "level s1:c0.c1;\n");
> +#define SYSTEMLOW "s0"
> +#define SYSTEMHIGH "s1:c0.c1"
> +               for (i = 0; secclass_map[i].name; i++) {
> +                       struct security_class_mapping *map = &secclass_map[i];
> +
> +                       fprintf(fout, "mlsconstrain %s {\n", map->name);
> +                       for (j = 0; map->perms[j]; j++)
> +                               fprintf(fout, "\t%s\n", map->perms[j]);
> +                       /*
> +                        * This requires all subjects and objects to be
> +                        * single-level (l2 eq h2), and that the subject
> +                        * level dominate the object level (h1 dom h2)
> +                        * in order to have any permissions to it.
> +                        */
> +                       fprintf(fout, "} (l2 eq h2 and h1 dom h2);\n\n");
> +               }
>         }
>
>         /* types, roles, and allows */
> @@ -108,34 +130,87 @@ int main(int argc, char *argv[])
>         for (i = 0; secclass_map[i].name; i++)
>                 fprintf(fout, "allow base_t base_t:%s *;\n",
>                         secclass_map[i].name);
> -       fprintf(fout, "user user_u roles { base_r };\n");
> -       fprintf(fout, "\n");
> +       fprintf(fout, "user user_u roles { base_r }");
> +       if (mls)
> +               fprintf(fout, " level %s range %s - %s", SYSTEMHIGH,
> +                       SYSTEMLOW, SYSTEMHIGH);
> +       fprintf(fout, ";\n");
> +
> +#define USERROLETYPE "user_u:base_r:base_t"
>
>         /* default sids */
>         for (i = 1; i < initial_sid_to_string_len; i++)
> -               fprintf(fout, "sid %s user_u:base_r:base_t\n", initial_sid_to_string[i]);
> +               fprintf(fout, "sid %s " USERROLETYPE "%s\n",
> +                       initial_sid_to_string[i], mls ? ":" SYSTEMHIGH : "");
>         fprintf(fout, "\n");
>
> -       fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
> -       fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
> -       fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
> -       fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
> -       fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
> -       fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
> -       fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
> -       fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
> -
> -       fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t;\n");
> -       fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
> -       fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
> -
> -       fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
> -       fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
> -       fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
> -       fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
> -       fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
> -
> -       fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
> +#define FS_USE(behavior, fstype)                           \
> +       fprintf(fout, "fs_use_%s %s " USERROLETYPE "%s;\n", \
> +               behavior, fstype, mls ? ":" SYSTEMLOW : "")
> +
> +       /*
> +        * Filesystems whose inode labels can be fetched via getxattr.
> +        */
> +#ifdef CONFIG_EXT2_FS_SECURITY
> +       FS_USE("xattr", "ext2");
> +#endif
> +#ifdef CONFIG_EXT3_FS_SECURITY
> +       FS_USE("xattr", "ext3");
> +#endif
> +#ifdef CONFIG_EXT4_FS_SECURITY
> +       FS_USE("xattr", "ext4");
> +#endif
> +#ifdef CONFIG_JFS_SECURITY
> +       FS_USE("xattr", "jfs");
> +#endif
> +#ifdef CONFIG_REISERFS_FS_SECURITY
> +       FS_USE("xattr", "reiserfs");
> +#endif
> +#ifdef CONFIG_JFFS2_FS_SECURITY
> +       FS_USE("xattr", "jffs2");
> +#endif
> +#ifdef CONFIG_XFS_FS
> +       FS_USE("xattr", "xfs");
> +#endif
> +#ifdef CONFIG_GFS2_FS
> +       FS_USE("xattr", "gfs2");
> +#endif
> +
> +       /*
> +        * Filesystems whose inodes are labeled from allocating task.
> +        */
> +       FS_USE("task", "pipefs");
> +       FS_USE("task", "sockfs");
> +#ifdef CONFIG_POSIX_MQUEUE
> +       FS_USE("task", "mqueue");
> +#endif
> +
> +       /*
> +        * Filesystems whose inode labels are computed from both
> +        * the allocating task and the superblock label.
> +        */
> +#ifdef CONFIG_UNIX98_PTYS
> +       FS_USE("trans", "devpts");
> +#endif
> +#ifdef CONFIG_HUGETLBFS
> +       FS_USE("trans", "hugetlbfs");
> +#endif
> +#ifdef CONFIG_TMPFS
> +       FS_USE("trans", "tmpfs");
> +#endif
> +
> +
> +#define GENFSCON(fstype, prefix)                            \
> +       fprintf(fout, "genfscon %s %s " USERROLETYPE "%s\n", \
> +               fstype, prefix, mls ? ":" SYSTEMLOW : "")
> +
> +       /*
> +        * Filesystems whose inodes are labeled from path prefix match
> +        * relative to the filesystem root.  Depending on the filesystem,
> +        * only a single label for all inodes may be supported.
> +        */
> +       GENFSCON("proc", "/");
> +       GENFSCON("selinuxfs", "/");
>
>         fclose(fout);
>
> @@ -144,8 +219,8 @@ int main(int argc, char *argv[])
>                 printf("Wrote policy, but cannot open %s for writing\n", ctxout);
>                 usage(argv[0]);
>         }
> -       fprintf(fout, "/ user_u:base_r:base_t\n");
> -       fprintf(fout, "/.* user_u:base_r:base_t\n");
> +       fprintf(fout, "/ " USERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
> +       fprintf(fout, "/.* " USERROLETYPE "%s\n", mls ? ":" SYSTEMLOW : "");
>         fclose(fout);
>
>         return 0;
> --
> 2.20.1
>


-- 
paul moore
www.paul-moore.com
