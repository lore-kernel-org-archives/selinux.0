Return-Path: <SRS0=yrd7=PT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E92BC43444
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 01:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F904214C6
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 01:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PN6SnlDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfAKBh1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:37:27 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46776 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbfAKBh1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jan 2019 20:37:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id y14so9665762lfg.13
        for <selinux@vger.kernel.org>; Thu, 10 Jan 2019 17:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAJZgrcw3XACm1Rfy+PvFtt6jlYwdA3ls/yx2LhjlHM=;
        b=PN6SnlDZw6Gj/O9O0sqtw5nc4CQcf119SLPX4nNkPK0V6JnI66m+rot0qV+97/MLUL
         u9Lui+qRFWrZbQyxYV2CctoeRN4IETiM1zZ3acHEUwRJx6Ecr0hBiD4z1FwrJFsGKq8Z
         bP3tCgPUuMjDYPn8SdRVi6HuktRdw2u0U0SYcoH3LsJ4omTl1lp3CHSxzkR26XT/M4FG
         u7dfZ0kOuKLoIepFubdJkeKWIJ6o1ANPAHMAIODkeoteIZziFSpjzsa6edzrf5MsRgKG
         jxzKOzLsgbS1dsZK58nwn160Q11t7rizcULmvEo3wMteRi4EZ1g9m1AgPMJNEdQx28Jp
         3jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAJZgrcw3XACm1Rfy+PvFtt6jlYwdA3ls/yx2LhjlHM=;
        b=Iz3nug9MWzE3S3PZbpCQkMq02eJFIJXVbA2CK+uL4rRFAaGImBis3YrqWdlclpXBqB
         /h6kLuqX92kuQx5TfYcHNUfCqE+qB4gz1mJald91RpRjB2VSlAMDzuSQIwVsbpOwp8iZ
         faBUjmeJPc/y+tN6flAKzeQdW79Dd1Zg80rgjikdSX/1WjdRISxv6PFV7H6M1BDPVZdk
         efySuwqr7nXgE9OcuINnAoPjL9q0WD3NHBBO0ojeWirK5JWO8o6U/Sbwcf/WvqpLx8JQ
         v54eAHG8d7lnE7kl9RuYj0JexoO3VxTySBtLm6OZdxrnDUYeiuUAdlmAutUR2/EcTDiD
         ZPdw==
X-Gm-Message-State: AJcUukd7BT9UzNAESqKLbh1OGoVeYugan/uPgFK6/5VQzzaOomd2sQQT
        OVOSq/WmZ9EJ9N9zOQydnePE0iAsoE0JvPdCNFtV
X-Google-Smtp-Source: ALg8bN43Sx2TqfY/2aO9CjeCgMqoG9nVfwSOuHPIKQKmNFqVPvGtm75/Mff/M6zyfNzolItRVvfuIqEuJzYINQNsx30=
X-Received: by 2002:a19:8fce:: with SMTP id s75mr6820819lfk.151.1547170644176;
 Thu, 10 Jan 2019 17:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20181212151056.2938-1-sds@tycho.nsa.gov> <20181212151056.2938-2-sds@tycho.nsa.gov>
In-Reply-To: <20181212151056.2938-2-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jan 2019 20:37:12 -0500
Message-ID: <CAHC9VhRAxqNA5rFreuBN-oi7k5SiCU19wzZ60RO9XUEe4=qfJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: stop passing MAY_NOT_BLOCK to the AVC upon follow_link
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, bmktuwien@gmail.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 12, 2018 at 10:08 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> commit bda0be7ad9948 ("security: make inode_follow_link RCU-walk aware")
> switched selinux_inode_follow_link() to use avc_has_perm_flags() and
> pass down the MAY_NOT_BLOCK flag if called during RCU walk.  However,
> the only test of MAY_NOT_BLOCK occurs during slow_avc_audit()
> and only if passing an inode as audit data (LSM_AUDIT_DATA_INODE).  Since
> selinux_inode_follow_link() passes a dentry directly, passing MAY_NOT_BLOCK
> here serves no purpose.  Switch selinux_inode_follow_link() to use
> avc_has_perm() and drop avc_has_perm_flags() since there are no other
> users.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/avc.c         | 24 ++----------------------
>  security/selinux/hooks.c       |  5 ++---
>  security/selinux/include/avc.h |  5 -----
>  3 files changed, 4 insertions(+), 30 deletions(-)

I just merged both 1/2 and 2/2 into selinux/next, thanks Stephen.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 5de18a6d5c3f..9b63d8ee1687 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -867,9 +867,8 @@ static int avc_update_node(struct selinux_avc *avc,
>          * permissive mode that only appear when in enforcing mode.
>          *
>          * See the corresponding handling in slow_avc_audit(), and the
> -        * logic in selinux_inode_follow_link and selinux_inode_permission
> -        * for the VFS MAY_NOT_BLOCK flag, which is transliterated into
> -        * AVC_NONBLOCKING for avc_has_perm_noaudit().
> +        * logic in selinux_inode_permission for the MAY_NOT_BLOCK flag,
> +        * which is transliterated into AVC_NONBLOCKING.
>          */
>         if (flags & AVC_NONBLOCKING)
>                 return 0;
> @@ -1209,25 +1208,6 @@ int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
>         return rc;
>  }
>
> -int avc_has_perm_flags(struct selinux_state *state,
> -                      u32 ssid, u32 tsid, u16 tclass, u32 requested,
> -                      struct common_audit_data *auditdata,
> -                      int flags)
> -{
> -       struct av_decision avd;
> -       int rc, rc2;
> -
> -       rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested,
> -                                 (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
> -                                 &avd);
> -
> -       rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
> -                       auditdata, flags);
> -       if (rc2)
> -               return rc2;
> -       return rc;
> -}
> -
>  u32 avc_policy_seqno(struct selinux_state *state)
>  {
>         return state->avc->avc_cache.latest_notif;
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9b05f84808d9..f012d2eb159e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3139,9 +3139,8 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
>         if (IS_ERR(isec))
>                 return PTR_ERR(isec);
>
> -       return avc_has_perm_flags(&selinux_state,
> -                                 sid, isec->sid, isec->sclass, FILE__READ, &ad,
> -                                 rcu ? MAY_NOT_BLOCK : 0);
> +       return avc_has_perm(&selinux_state,
> +                           sid, isec->sid, isec->sclass, FILE__READ, &ad);
>  }
>
>  static noinline int audit_inode_permission(struct inode *inode,
> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> index 74ea50977c20..7be0e1e90e8b 100644
> --- a/security/selinux/include/avc.h
> +++ b/security/selinux/include/avc.h
> @@ -153,11 +153,6 @@ int avc_has_perm(struct selinux_state *state,
>                  u32 ssid, u32 tsid,
>                  u16 tclass, u32 requested,
>                  struct common_audit_data *auditdata);
> -int avc_has_perm_flags(struct selinux_state *state,
> -                      u32 ssid, u32 tsid,
> -                      u16 tclass, u32 requested,
> -                      struct common_audit_data *auditdata,
> -                      int flags);
>
>  int avc_has_extended_perms(struct selinux_state *state,
>                            u32 ssid, u32 tsid, u16 tclass, u32 requested,
> --
> 2.19.2
>


-- 
paul moore
www.paul-moore.com
