Return-Path: <SRS0=INWG=WR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1696BC3A5A0
	for <selinux@archiver.kernel.org>; Wed, 21 Aug 2019 13:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D782822CF7
	for <selinux@archiver.kernel.org>; Wed, 21 Aug 2019 13:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UwFslZE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfHUN4H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:56:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42525 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbfHUN4G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Aug 2019 09:56:06 -0400
Received: by mail-lf1-f66.google.com with SMTP id s19so1860491lfb.9
        for <selinux@vger.kernel.org>; Wed, 21 Aug 2019 06:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ns8DMZPv6k41odjlM7JpWe0K8lZfRzmbTNvhbQqLO6M=;
        b=UwFslZE4tfWGGrwIEsnuWx112ARxg6tXyJybleO8UEuBLzXxo2Al0iHPEdTBMUuBoA
         KAtltPmBrf2n/Jz3eYXoNHFlt+XPCKKGu2LBCgqO4oy1BN7hqKD7f3sb3HAfeivEBUzM
         u3hYJS+9VjHsbCDG9zEwSBabIVGIF3+f5gB2838CEHN6xEdDObSES81y2Q1ohMHZdr0Y
         KaB29Rk0vwno2fgdXu3NKeIjwcZnV56npuyuVCUcR2261sZFQ4ff8CH4HKYdfXCKPXB2
         V/7sDro3nbPCRaHLj86lCCSDTigg5FXwWjUsOHELdQ5bKeMiROrN2xfJuvIxTavwCBL4
         I6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ns8DMZPv6k41odjlM7JpWe0K8lZfRzmbTNvhbQqLO6M=;
        b=L+sENv7qveJYW8IpmCyRUEL7xK+FS15EvG5gpFFAzBHOx0nCmLmtNSQeCZUj8TQJzU
         jHLFz1Zt5lCQnGoCgEzG/1lEFRuX67ryzU4LOWCgrvB4EhKyeIUe/gvxGyvuY5MaGOVc
         NQNiAzTfOz5OvXvbbHfqLtxSJ5VYl9hHQdhCddUu9Bf7xUaAXgpqo8jhS9U+AXOw2Jkn
         ZKREYaoUidAfqJmc8uS0w725cuCea6WEKrZUXZ0bkg6iBbIbThOFwZTWtgs3kP0ksMtK
         YOXKhAj7pO1qHLAVBvla9mGc/q7m1h0SoLftX1+3HiWIlhAarpObDvv3yvilISL+QVlk
         BAIA==
X-Gm-Message-State: APjAAAVNAHEw+xzzQIvkuf0i1KatyKmAgyJlCuGs999Dnxp8hHKRQVnH
        yqdsrAXQPBQoHmtB5OeVztNGNEmdtqtiEjx6pN2YJfs4
X-Google-Smtp-Source: APXvYqx+2nDGmqkxIIjquCYAPQe7evBFQp3UZFfKGHFPXmJPcwj5jGSuWmbrs4GcissOzk+vz7nINTFINWkY3x9UsTM=
X-Received: by 2002:a19:f007:: with SMTP id p7mr3491773lfc.24.1566395763652;
 Wed, 21 Aug 2019 06:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190821134547.96929-1-jeffv@google.com>
In-Reply-To: <20190821134547.96929-1-jeffv@google.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Wed, 21 Aug 2019 15:55:52 +0200
Message-ID: <CABXk95A7EwpBd1Snek9gvZRGKNsgD7q4cCmHp8xwQ93_gDx-Gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rtnetlink: gate MAC address with an LSM hook
To:     netdev@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 21, 2019 at 3:45 PM Jeff Vander Stoep <jeffv@google.com> wrote:
>
> MAC addresses are often considered sensitive because they are
> usually unique and can be used to identify/track a device or
> user [1].
>
> The MAC address is accessible via the RTM_NEWLINK message type of a
> netlink route socket[2]. Ideally we could grant/deny access to the
> MAC address on a case-by-case basis without blocking the entire
> RTM_NEWLINK message type which contains a lot of other useful
> information. This can be achieved using a new LSM hook on the netlink
> message receive path. Using this new hook, individual LSMs can select
> which processes are allowed access to the real MAC, otherwise a
> default value of zeros is returned. Offloading access control
> decisions like this to an LSM is convenient because it preserves the
> status quo for most Linux users while giving the various LSMs
> flexibility to make finer grained decisions on access to sensitive
> data based on policy.
>
> [1] https://adamdrake.com/mac-addresses-udids-and-privacy.html
> [2] Other access vectors like ioctl(SIOCGIFHWADDR) are already covered
> by existing LSM hooks.
>
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
>  include/linux/lsm_hooks.h |  8 ++++++++
>  include/linux/security.h  |  6 ++++++
>  net/core/rtnetlink.c      | 12 ++++++++++--
>  security/security.c       |  5 +++++
>  4 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index df1318d85f7d..dfcb2e11ff43 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -728,6 +728,12 @@
>   *
>   * Security hooks for Netlink messaging.
>   *
> + * @netlink_receive
> + *     Check permissions on a netlink message field before populating it.
> + *     @sk associated sock of task receiving the message.
> + *     @skb contains the sk_buff structure for the netlink message.
> + *     Return 0 if the data should be included in the message.
> + *
>   * @netlink_send:
>   *     Save security information for a netlink message so that permission
>   *     checking can be performed when the message is processed.  The security
> @@ -1673,6 +1679,7 @@ union security_list_options {
>         int (*sem_semop)(struct kern_ipc_perm *perm, struct sembuf *sops,
>                                 unsigned nsops, int alter);
>
> +       int (*netlink_receive)(struct sock *sk, struct sk_buff *skb);
>         int (*netlink_send)(struct sock *sk, struct sk_buff *skb);
>
>         void (*d_instantiate)(struct dentry *dentry, struct inode *inode);
> @@ -1952,6 +1959,7 @@ struct security_hook_heads {
>         struct hlist_head sem_associate;
>         struct hlist_head sem_semctl;
>         struct hlist_head sem_semop;
> +       struct hlist_head netlink_receive;
>         struct hlist_head netlink_send;
>         struct hlist_head d_instantiate;
>         struct hlist_head getprocattr;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5f7441abbf42..46b5af6de59e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -382,6 +382,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>                          char **value);
>  int security_setprocattr(const char *lsm, const char *name, void *value,
>                          size_t size);
> +int security_netlink_receive(struct sock *sk, struct sk_buff *skb);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_ismaclabel(const char *name);
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> @@ -1162,6 +1163,11 @@ static inline int security_setprocattr(const char *lsm, char *name,
>         return -EINVAL;
>  }
>
> +static inline int security_netlink_receive(struct sock *sk, struct sk_buff *skb)
> +{
> +       return 0;
> +}
> +
>  static inline int security_netlink_send(struct sock *sk, struct sk_buff *skb)
>  {
>         return 0;
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 1ee6460f8275..7d69fcb8d22e 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -1650,8 +1650,16 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>                 goto nla_put_failure;
>
>         if (dev->addr_len) {
> -               if (nla_put(skb, IFLA_ADDRESS, dev->addr_len, dev->dev_addr) ||
> -                   nla_put(skb, IFLA_BROADCAST, dev->addr_len, dev->broadcast))
> +               if (skb->sk && security_netlink_receive(skb->sk, skb)) {
> +                       if (!nla_reserve(skb, IFLA_ADDRESS, dev->addr_len))
> +                               goto nla_put_failure;


Is populating the field with zeros the right approach or should I just
omit it entirely?
Even though this change will only impact LSM users I would still like to
minimize the potential for breakage of userspace processes. Returning the same
packet size and format seems like the least fragile thing to do.


>
> +
> +               } else {
> +                       if (nla_put(skb, IFLA_ADDRESS, dev->addr_len,
> +                                   dev->dev_addr))
> +                               goto nla_put_failure;
> +               }
> +               if (nla_put(skb, IFLA_BROADCAST, dev->addr_len, dev->broadcast))
>                         goto nla_put_failure;
>         }
>
> diff --git a/security/security.c b/security/security.c
> index 250ee2d76406..35c5929921b2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1861,6 +1861,11 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>         return -EINVAL;
>  }
>
> +int security_netlink_receive(struct sock *sk, struct sk_buff *skb)
> +{
> +       return call_int_hook(netlink_receive, 0, sk, skb);
> +}
> +
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb)
>  {
>         return call_int_hook(netlink_send, 0, sk, skb);
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>
