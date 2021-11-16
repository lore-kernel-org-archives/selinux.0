Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B288C433FE
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 15:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D98B61407
	for <selinux@archiver.kernel.org>; Tue, 16 Nov 2021 15:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbhKPPpH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbhKPPoY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Nov 2021 10:44:24 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5F2C061210
        for <selinux@vger.kernel.org>; Tue, 16 Nov 2021 07:41:27 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f18so54401339lfv.6
        for <selinux@vger.kernel.org>; Tue, 16 Nov 2021 07:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQVLv28qLvOMThfXKeEX7kjMwc0n27Rblt7cNMv/kw4=;
        b=oD/4Zomz7Zbyyh0wtL96TnJYDgYSO7iTaZNxEEN0p74KgYzVqNiIBL1mMWsztnTa3o
         OSU5Af5NxHYvT0AAR+eIS5lHJCG8R0G1B19EHEbt/eqCLFkLtqP7g2GwxmdeRVfku1IT
         3RYHlR0hfpm1Ue0lgQbCxmfv0qx9gW+R94FN1mMeL79Abb5shWN2Zv+9DKxO0yrNPSTQ
         iiVb20PbvAgt4YPkCsRWDGn46YvGCPxnYV8q9SHlVXiptDvTYJZk41k/FILBsUrkvvuC
         NHJdSpBYtTk5nuS1D/976dFAv4LNWx/y9w8pXReShhoQG/5ysGFNVHsByGlSFSRVYcAc
         rolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQVLv28qLvOMThfXKeEX7kjMwc0n27Rblt7cNMv/kw4=;
        b=bz6MBbmkR2m3oPbY1fZ7gTSAs2KC8VFmd7WU7KbewuDtXi5bXEqF68XBXT2FMjQ7R7
         9oGqlkl5YdwrUTAhJG8Lhs8KyaG/b+q84uhMPA34ODyeUS05UyaYTUzwLZPGsAgyr/V1
         OSbitsosGbiT5lz6s3881hoSY86tlrr50JALE4F44Klxweb10EyIe2R8WXcA1ZOkRmr3
         RfO5YY+9bO4ovrZzaU+tlT2Tu9d04WyGcg5Qa3jwn3OoYgnoVASe9/hw+l9Qz01sw1hr
         /yp90x69hBltaCczVertMEfSomT/nZZVEKdezAQ78rnuuc/lxWX52fanw3Sa4+rI/WA5
         b3Yg==
X-Gm-Message-State: AOAM531iD4grFDoX8Ev6Hb8+GS9l4BJIeMTCJzN+ETNr4k0S4I5JgIQ4
        k+A7Wf6PEzGIUX0QQnl2xM+k/dw2+fhBAqnHRoM=
X-Google-Smtp-Source: ABdhPJyZ7U2A0hqGJxpdc1N/Xoo6MDR9HoQ40smbOhy7CFuuyNeNYhuayfeLG26yaUP/HUlgaWCW9WE929N9ni5AK+A=
X-Received: by 2002:a05:6512:3f2:: with SMTP id n18mr7546073lfq.646.1637077285573;
 Tue, 16 Nov 2021 07:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20211110111308.3463879-1-brambonne@google.com>
In-Reply-To: <20211110111308.3463879-1-brambonne@google.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 16 Nov 2021 10:41:14 -0500
Message-ID: <CAEjxPJ5ZiVHuYNXBgkKLb2CLCkpUqo-20mAm-sqbk=zt9NH-MQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: Add netlink xperm support
To:     Bram Bonne <brambonne@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 10, 2021 at 6:13 AM Bram Bonne <brambonne@google.com> wrote:
>
> Reuse the existing extended permissions infrastructure to support
> sepolicy for different netlink message types.
>
> When individual netlink message types are omitted only the existing
> permissions are checked. As is the case for ioctl xperms, this feature
> is intended to provide finer granularity for nlmsg_read and nlmsg_write
> permissions, as they may be too imprecise. For example, a single
> NETLINK_ROUTE socket may provide access to both an interface's IP
> address and to its ARP table, which might have different privacy
> implications. In addition, the set of message types has grown over time,
> so even if the current list is acceptable, future additions might not be.
> It was suggested before on the mailing list [1] that extended permissions
> would be a good fit for this purpose.
>
> Existing policy using the nlmsg_read and nlmsg_write permissions will
> continue to work as-is. Similar to ioctl xperms, netlink xperms allow
> for a more fine-grained policy where needed.
>
> Example policy on Android, preventing regular apps from accessing the
> device's MAC address and ARP table, but allowing this access to
> privileged apps, looks as follows:
>
> allow netdomain self:netlink_route_socket {
>         create read getattr write setattr lock append connect getopt
>         setopt shutdown nlmsg_read
> };
> allowxperm netdomain self:netlink_route_socket nlmsg ~{
>         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> };
> allowxperm priv_app self:netlink_route_socket nlmsg {
>         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> };
>
> Android currently uses code similar to [1] as a temporary workaround to
> limit access to certain netlink message types; our hope is that this patch
> will allow us to move back to upstream code with an approach that works for
> everyone.
>
> [1] https://lore.kernel.org/selinux/CAHC9VhRSUhozBycHMZcMaJsibJDxNMsTsKVT2zOnW=5H4R4mdg@mail.gmail.com/
>
> Signed-off-by: Bram Bonne <brambonne@google.com>
> ---
>  security/selinux/hooks.c       | 24 +++++++++++++++++++++++-
>  security/selinux/ss/avtab.h    |  1 +
>  security/selinux/ss/services.c | 23 ++++++++++++++++++++++-
>  3 files changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e7ebd45ca345..a503865fabed 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4662,6 +4662,28 @@ static int sock_has_perm(struct sock *sk, u32 perms)
>                             &ad);
>  }
>
> +static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_type)
> +{
> +       struct sk_security_struct *sksec = sk->sk_security;
> +       struct common_audit_data ad;
> +       struct lsm_network_audit net = {0,};
> +       u8 xperm;
> +
> +       if (sksec->sid == SECINITSID_KERNEL)
> +               return 0;
> +
> +       ad.type = LSM_AUDIT_DATA_NET;
> +       ad.u.net = &net;
> +       ad.u.net->sk = sk;
> +
> +       // nlmsg_types comfortably fit into a single driver, see RTM_MAX in uapi/linux/rtnetlink.h
> +       xperm = nlmsg_type & 0xff;

This seems like a dangerous assumption; obviously not all netlink
users are rtnetlink. Even if all existing netlink users follow this,
nothing prevents userspace from creating a netlink message that
violates it AFAIK, at which point you will just silently discard the
higher bits. If we think we can get away with this restriction, then
we need to enforce it here (i.e. return an error if they do not fit);
if not,
then we likely need to support multiple drivers with a simple mapping
of the upper bits to driver.

> +
> +       return avc_has_extended_perms(&selinux_state,
> +                           current_sid(), sksec->sid, sksec->sclass, perms, 0, xperm,
> +                           &ad);
> +}
> +
>  static int selinux_socket_create(int family, int type,
>                                  int protocol, int kern)
>  {
> @@ -6037,7 +6059,7 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
>
>                 rc = selinux_nlmsg_lookup(sclass, nlh->nlmsg_type, &perm);
>                 if (rc == 0) {
> -                       rc = sock_has_perm(sk, perm);
> +                       rc = nlmsg_sock_has_extended_perms(sk, perm, nlh->nlmsg_type);
>                         if (rc)
>                                 return rc;
>                 } else if (rc == -EINVAL) {
> diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> index d3ebea8d146f..f69aa7bc3dc3 100644
> --- a/security/selinux/ss/avtab.h
> +++ b/security/selinux/ss/avtab.h
> @@ -55,6 +55,7 @@ struct avtab_extended_perms {
>  /* These are not flags. All 256 values may be used */
>  #define AVTAB_XPERMS_IOCTLFUNCTION     0x01
>  #define AVTAB_XPERMS_IOCTLDRIVER       0x02
> +#define AVTAB_XPERMS_NLMSG             0x03
>         /* extension of the avtab_key specified */
>         u8 specified; /* ioctl, netfilter, ... */
>         /*
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index e5f1b2757a83..7bbb070e9ff5 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -591,7 +591,7 @@ static void type_attribute_bounds_av(struct policydb *policydb,
>
>  /*
>   * flag which drivers have permissions
> - * only looking for ioctl based extended permssions
> + * only looking for ioctl/netlink based extended permissions
>   */
>  void services_compute_xperms_drivers(
>                 struct extended_perms *xperms,
> @@ -607,6 +607,9 @@ void services_compute_xperms_drivers(
>                 /* if allowing permissions within a driver */
>                 security_xperm_set(xperms->drivers.p,
>                                         node->datum.u.xperms->driver);
> +       } else if (node->datum.u.xperms->specified == AVTAB_XPERMS_NLMSG) {
> +               /* all netlink permissions are included in driver 0 */
> +               xperms->drivers.p[0] |= 1;
>         }
>
>         xperms->len = 1;
> @@ -970,6 +973,9 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
>                 if (!security_xperm_test(node->datum.u.xperms->perms.p,
>                                         xpermd->driver))
>                         return;
> +       } else if (node->datum.u.xperms->specified == AVTAB_XPERMS_NLMSG) {
> +               if (xpermd->driver != node->datum.u.xperms->driver)
> +                       return;
>         } else {
>                 BUG();
>         }
> @@ -985,6 +991,11 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
>                                 xpermd->allowed->p[i] |=
>                                         node->datum.u.xperms->perms.p[i];
>                 }
> +               if (node->datum.u.xperms->specified == AVTAB_XPERMS_NLMSG) {
> +                       for (i = 0; i < ARRAY_SIZE(xpermd->allowed->p); i++)
> +                               xpermd->allowed->p[i] |=
> +                                       node->datum.u.xperms->perms.p[i];
> +               }
>         } else if (node->key.specified == AVTAB_XPERMS_AUDITALLOW) {
>                 xpermd->used |= XPERMS_AUDITALLOW;
>                 if (node->datum.u.xperms->specified == AVTAB_XPERMS_IOCTLDRIVER) {
> @@ -996,6 +1007,11 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
>                                 xpermd->auditallow->p[i] |=
>                                         node->datum.u.xperms->perms.p[i];
>                 }
> +               if (node->datum.u.xperms->specified == AVTAB_XPERMS_NLMSG) {
> +                       for (i = 0; i < ARRAY_SIZE(xpermd->auditallow->p); i++)
> +                               xpermd->auditallow->p[i] |=
> +                                       node->datum.u.xperms->perms.p[i];
> +               }
>         } else if (node->key.specified == AVTAB_XPERMS_DONTAUDIT) {
>                 xpermd->used |= XPERMS_DONTAUDIT;
>                 if (node->datum.u.xperms->specified == AVTAB_XPERMS_IOCTLDRIVER) {
> @@ -1007,6 +1023,11 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
>                                 xpermd->dontaudit->p[i] |=
>                                         node->datum.u.xperms->perms.p[i];
>                 }
> +               if (node->datum.u.xperms->specified == AVTAB_XPERMS_NLMSG) {
> +                       for (i = 0; i < ARRAY_SIZE(xpermd->dontaudit->p); i++)
> +                               xpermd->dontaudit->p[i] |=
> +                                       node->datum.u.xperms->perms.p[i];
> +               }
>         } else {
>                 BUG();
>         }
> --
> 2.34.0.rc0.344.g81b53c2807-goog
>
