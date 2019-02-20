Return-Path: <SRS0=OyWE=Q3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA20C43381
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 19:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8182146E
	for <selinux@archiver.kernel.org>; Wed, 20 Feb 2019 19:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8ZVZKUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfBTTea (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:34:30 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37275 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfBTTea (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Feb 2019 14:34:30 -0500
Received: by mail-it1-f196.google.com with SMTP id z124so18489538itc.2
        for <selinux@vger.kernel.org>; Wed, 20 Feb 2019 11:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ci+v+8fKC3T6Q3uzwUtSfNN0Zjew9wnMXsAM4rvtIQs=;
        b=R8ZVZKUTj9FEwFZ0nVH7gzvu2kFZ4kcYq7M1r1kGEL9fYyQy9ns6cuQfyIJ1OycEXs
         Dgb04JoWpUIF0l278VYE/pLaWZEjxtP8w4lEkC4xI3M6//a5F9cxOkMdwPE+CrGUSIKA
         4eKu51ehA4B+zM9UQZR+8PV6OJj/xqhy42l0ZufKTM6/AjVlJttJbl47PlqqXDNwetDr
         wqZJOVH8lAPbqfPbCJjwlldZV4mSxYe6Om2KtZcy7Konn+Bo6eK9mC6GTccYzy1tTIeP
         8qeBxWL9j+Vfk8rBBb2DB5OEopjN0e1bIj5uYRt9LWyiZiI7eI7xNJmpH0TIeEwG/9i9
         +89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ci+v+8fKC3T6Q3uzwUtSfNN0Zjew9wnMXsAM4rvtIQs=;
        b=bdoNPcjf6uc6dto4MseBGe+46PwEx7+vUfTSKW0vW87s82rAovEDaKNIBr7qcoI8dG
         CzteolCF4Uw3D7qAIs9rbmXKG2Ce8E5YV68B9x+FWqOCHS/KuHIRz1h4kHCiRycfllH2
         7GhnDWS698WssZS97mqSY40jTUaAKwQAI6EFGqqmPduMLD/RYaWuRr17gdXyewnad6Or
         lzy9lDTMRnkmEmP0tmnq2iAVs14d+NxyixqCoglAgeggJs1Txv+JfUut49KZ9VHR8oUD
         zajSIqYpvWLJgTgHxGPuJsmL4icMRoE58H0sg3wXyvA7YJnxmv5ibhYtKb9S5xzL9hMB
         0FXw==
X-Gm-Message-State: AHQUAuZCzzpGd/sEebb3vcjVF528hj9xOpU75bK4sYIczy/RYuGUJuCW
        imLQK8+TyqqdFCsHqJow8cnq6+ZGqzlz3V5XRLk=
X-Google-Smtp-Source: AHgI3IbkfIqxVF8abMJ9Q3o7cXQCFSX9oRLehAlO5baUc5HVUg1m6Rgp+4L0vLd0UMJ8+DpNn37+GFkltyH4kslUSJE=
X-Received: by 2002:a6b:e202:: with SMTP id z2mr22137849ioc.133.1550691269103;
 Wed, 20 Feb 2019 11:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20190220123354.1589-1-dominick.grift@defensec.nl> <20190220153408.1857-1-dominick.grift@defensec.nl>
In-Reply-To: <20190220153408.1857-1-dominick.grift@defensec.nl>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Wed, 20 Feb 2019 14:34:16 -0500
Message-ID: <CAB9W1A1DVgp7buZZQ1=Gpjo7=AnbEa6DPh1q145bzRcr=co8Dw@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/selinux: modernize mdp
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 20, 2019 at 10:34 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> The MDP example no longer works on modern systems.
>
> Add support for devtmpfs. This is required by login programs to relabel terminals.
> Compile the policy with deny_unknown allow status to anticipate user space object managers in core components such as systemd.
> Add default seusers mapping and failsafe context for the SELinux PAM module.
>
> V2:
> Fix existing file test for setfiles.
> Add a file test for checkpolicy similar to the test for setfiles for consistency.
> Execute setfiles with -F to ensure that customizables are relabeled as well in scenarios where filesystems are labeled but where SELinux is disabled.
>
> V3: Fixes file test that was introduced in V2.
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
>  scripts/selinux/install_policy.sh | 21 ++++++++++++++++-----
>  scripts/selinux/mdp/mdp.c         |  1 +
>  2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/selinux/install_policy.sh b/scripts/selinux/install_policy.sh
> index 0b86c47baf7d..e32f333f14cc 100755
> --- a/scripts/selinux/install_policy.sh
> +++ b/scripts/selinux/install_policy.sh
> @@ -6,7 +6,7 @@ if [ `id -u` -ne 0 ]; then
>  fi
>  SF=`which setfiles`
>  if [ $? -eq 1 ]; then
> -       if [ -f /sbin/setfiles ]; then
> +       if [ -f /usr/setfiles ]; then
>                 SF="/usr/setfiles"

I don't believe we've ever installed setfiles anywhere other than
/sbin/setfile or /usr/sbin/setfiles so no other locations should be
used.  Maybe just drop the inner if statement entirely.

>         else
>                 echo "no selinux tools installed: setfiles"
> @@ -17,14 +17,25 @@ fi
>  cd mdp
>
>  CP=`which checkpolicy`
> +if [ $? -eq 1 ]; then
> +       if [ -f /usr/checkpolicy ]; then
> +               CP="/usr/checkpolicy"

Similarly for /usr/bin/checkpolicy or /bin/checkpolicy.

> +       else
> +               echo "no selinux tools installed: checkpolicy"
> +               exit 1
> +       fi
> +fi
>  VERS=`$CP -V | awk '{print $1}'`
>
>  ./mdp policy.conf file_contexts
> -$CP -o policy.$VERS policy.conf
> +$CP -U allow -o policy.$VERS policy.conf
>
>  mkdir -p /etc/selinux/dummy/policy
>  mkdir -p /etc/selinux/dummy/contexts/files
>
> +echo "__default__:user_u" > /etc/selinux/dummy/seusers
> +echo "base_r:base_t" > /etc/selinux/dummy/contexts/failsafe_context
> +
>  cp file_contexts /etc/selinux/dummy/contexts/files
>  cp dbus_contexts /etc/selinux/dummy/contexts
>  cp policy.$VERS /etc/selinux/dummy/policy
> @@ -55,15 +66,15 @@ else
>  fi
>
>  cd /etc/selinux/dummy/contexts/files
> -$SF file_contexts /
> +$SF -F file_contexts /
>
>  mounts=`cat /proc/$$/mounts | egrep "ext2|ext3|xfs|jfs|ext4|ext4dev|gfs2" | awk '{ print $2 '}`
> -$SF file_contexts $mounts
> +$SF -F file_contexts $mounts
>
>
>  dodev=`cat /proc/$$/mounts | grep "/dev "`
>  if [ "eq$dodev" != "eq" ]; then
>         mount --move /dev /mnt

I recall seeing errors from mount when running this script about
invalid usage of mount --move?

> -       $SF file_contexts /dev
> +       $SF -F file_contexts /dev
>         mount --move /mnt /dev
>  fi
> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
> index 073fe7537f6c..cf06d5694cbc 100644
> --- a/scripts/selinux/mdp/mdp.c
> +++ b/scripts/selinux/mdp/mdp.c
> @@ -131,6 +131,7 @@ int main(int argc, char *argv[])
>
>         fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
>         fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
> +       fprintf(fout, "fs_use_trans devtmpfs user_u:base_r:base_t;\n");

This will conflict with my patch but probably your patch should be
applied first since it fixes current usage of mdp, and then mine can
be re-based and introduce the MLS support (which hopefully can now be
tested on Fedora). Ideally we'd add fs_use* and genfscon statements
for all filesystems supported by the kernel but that can come later.

>         fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
>         fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
>         fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
> --
> 2.21.0.rc1
>
