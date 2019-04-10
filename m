Return-Path: <SRS0=bkjU=SM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EB9C10F11
	for <selinux@archiver.kernel.org>; Wed, 10 Apr 2019 12:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D872083E
	for <selinux@archiver.kernel.org>; Wed, 10 Apr 2019 12:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFQODgif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfDJM2f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:28:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44150 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbfDJM2f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Apr 2019 08:28:35 -0400
Received: by mail-io1-f68.google.com with SMTP id u12so1889551iop.11;
        Wed, 10 Apr 2019 05:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2+2v34H2l6Fr1ceoeXxkslMdkKvOrl49zQpF+Dm/N8=;
        b=uFQODgifkZ4JmJ2NBNqrq+z+eThz1ubrrCju7gVvLooF4KYnZRDL8eqQV1EdCsD5Y2
         iSG01nL3AGSPGT735UyVEQ24VmQ85oNc+6yUAbs5+dvUTrdTseUxcSbt/SC14KE81sly
         yDTVhie/Zuvbb5kOAIzmAnA5vx2Oa+rLFaAMF7/WNYkQ+GAFQSzaGyePbi/Eai29Heh1
         7AyathqWPEzIT4lfc7wzdICunlsNkbFZg4Wg4bm2/GVQ69sXFvtVWd7UoUcHQ5DcThST
         r5t6uh1A/hIO3q4SVXGGQhbw56SL/8KKMm8ZlExo5Eh1tTmqT/OsXcFtt1pOfPr0ZMrs
         XuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2+2v34H2l6Fr1ceoeXxkslMdkKvOrl49zQpF+Dm/N8=;
        b=Gy/Ippb8tEvykKDs6zewnXc8CdSyTx7fyZsmphffHtrKk0FjejYohBfa6n1WuEjcyz
         d83jGlQylR6H9MTr38h61HGFqZOEx0qbl3VNVm7Cqwle058nHTuQFDu57miekuFff03h
         bE80ZBB/2HIP8WJJHk4u/Y/fochwFEHiomAEnpklk/FlEYp8K7eK513NeU+6SmNuDKBX
         aAgxnikyu66BYbgAfapIZBO+5lBeqmnbY9lktX4RrTTZ4kjlRma9wxbC+2wHNW4RTRHJ
         AF9Mhed8AyKs+/xVt/SKuRFkyGX304+LZdbkOQZSWHWmyDDeT/i/DDEZ3+CxzRIufgwb
         fyKw==
X-Gm-Message-State: APjAAAXtlDSNEGodl6HL1tjwMCv+zINwrHUEiEXAmWVGFJL0Xfpb7hmP
        DmnFuc8dEzDfFDNYAaf+UdqPh2uXgULJWdEpGlA=
X-Google-Smtp-Source: APXvYqyKMdgggzkb4eON30HC1xRYmrYYzHlEAQPyUvaemlYzMonGGjIiwD9hlPPoCx7JuAqsdI0LqtEfAcLrucniqec=
X-Received: by 2002:a6b:c3cc:: with SMTP id t195mr26920250iof.11.1554899314082;
 Wed, 10 Apr 2019 05:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190409213946.1667-1-casey@schaufler-ca.com> <20190409213946.1667-28-casey@schaufler-ca.com>
In-Reply-To: <20190409213946.1667-28-casey@schaufler-ca.com>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Wed, 10 Apr 2019 08:28:27 -0400
Message-ID: <CAB9W1A3hMkcKa5RokzBag7yyW2WwcDceaZyQWDoYOF6steEjJQ@mail.gmail.com>
Subject: Re: [PATCH 27/59] NET: Store LSM access information in the socket
 blob for UDS
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 9, 2019 at 5:42 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> UNIX domain socket connections don't have sufficient
> space in the socket buffer (skb) secmark for more than
> one Linux security module (LSM) to pass data. Expanding
> the secmark has been ruled out as an option. Store the
> necessary data in the socket security blob pointed to
> by the skb socket.

I don't believe this is correct.  The secid in the unix_skb_parms is
not the same as the secmark in the sk_buff, and I don't know if we are
necessarily prohibited from expanding it.  Also, I don't think you can
just store it in the socket security blob, especially without any form
of locking, as that can be shared across multiple sk_buffs.

>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h | 20 +++++++++++++++++++-
>  net/unix/af_unix.c       | 14 ++++++++------
>  security/security.c      | 17 ++++++++++++++++-
>  3 files changed, 43 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index e76d7a9dbe50..c413dcc1905a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -71,6 +71,7 @@ struct ctl_table;
>  struct audit_krule;
>  struct user_namespace;
>  struct timezone;
> +struct sk_buff;
>
>  enum lsm_event {
>         LSM_POLICY_CHANGE,
> @@ -100,6 +101,22 @@ static inline bool lsm_export_any(struct lsm_export *l)
>                 ((l->flags & LSM_EXPORT_APPARMOR) && l->apparmor));
>  }
>
> +static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
> +{
> +       if (l->flags != m->flags || l->flags == LSM_EXPORT_NONE)
> +               return false;
> +       if (l->flags & LSM_EXPORT_SELINUX &&
> +           (l->selinux != m->selinux || l->selinux == 0))
> +               return false;
> +       if (l->flags & LSM_EXPORT_SMACK &&
> +           (l->smack != m->smack || l->smack == 0))
> +               return false;
> +       if (l->flags & LSM_EXPORT_APPARMOR &&
> +           (l->apparmor != m->apparmor || l->apparmor == 0))
> +               return false;
> +       return true;
> +}
> +
>  /**
>   * lsm_export_secid - pull the useful secid out of a lsm_export
>   * @data: the containing data structure
> @@ -143,6 +160,8 @@ static inline void lsm_export_to_all(struct lsm_export *data, u32 secid)
>                       LSM_EXPORT_APPARMOR;
>  }
>
> +extern struct lsm_export *lsm_export_skb(struct sk_buff *skb);
> +
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>                        int cap, unsigned int opts);
> @@ -174,7 +193,6 @@ extern int cap_task_setnice(struct task_struct *p, int nice);
>  extern int cap_vm_enough_memory(struct mm_struct *mm, long pages);
>
>  struct msghdr;
> -struct sk_buff;
>  struct sock;
>  struct sockaddr;
>  struct socket;
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 4d4107927ba2..afe9c9f1adeb 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -143,21 +143,23 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
>  #ifdef CONFIG_SECURITY_NETWORK
>  static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>  {
> -       lsm_export_secid(&scm->le, &(UNIXCB(skb).secid));
> +       struct lsm_export *ble = lsm_export_skb(skb);
> +
> +       *ble = scm->le;
>  }
>
>  static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>  {
> -       lsm_export_to_all(&scm->le, UNIXCB(skb).secid);
> +       struct lsm_export *ble = lsm_export_skb(skb);
> +
> +       scm->le = *ble;
>  }
>
>  static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
>  {
> -       u32 best_secid;
> -
> -       lsm_export_secid(&scm->le, &best_secid);
> -       return (best_secid == UNIXCB(skb).secid);
> +       return lsm_export_equal(&scm->le, lsm_export_skb(skb));
>  }
> +
>  #else
>  static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
>  { }
> diff --git a/security/security.c b/security/security.c
> index 69983ad68233..015c38c882ba 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -46,7 +46,22 @@ static struct kmem_cache *lsm_file_cache;
>  static struct kmem_cache *lsm_inode_cache;
>
>  char *lsm_names;
> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
> +
> +/* Socket blobs include infrastructure managed data */
> +static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
> +       .lbs_sock = sizeof(struct lsm_export),
> +};
> +
> +/**
> + * lsm_export_skb - pointer to the lsm_export associated with the skb
> + * @skb: the socket buffer
> + *
> + * Returns a pointer to the LSM managed data.
> + */
> +struct lsm_export *lsm_export_skb(struct sk_buff *skb)
> +{
> +       return skb->sk->sk_security;
> +}
>
>  /* Boot-time LSM user choice */
>  static __initdata const char *chosen_lsm_order;
> --
> 2.19.1
>
