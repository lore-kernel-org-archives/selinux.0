Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633F2274FD0
	for <selinux@vger.kernel.org>; Fri, 27 Feb 2026 01:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772156707; cv=pass; b=Yt9EvVY+y+TwgKsfv25W+0LnLxVrW6dqPxeCPhQ/OkQiy9wQQHDQ0yLB1dr63OjlnEKNx52JowHzWmICrWYkYS0qU0hnvz6Wtw6Xr81e0m5Wxqt0rsSLvh8IGg5r/K354L6QbjSeC2c2a+ltJQjDXiJTXCxVLtZArgw15f/vczs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772156707; c=relaxed/simple;
	bh=A9/FuuRodWBdA/YCNxdboEFB1nPkr9fFGj5+n2QE7r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5XDn9WXTmKoSCaBYSa1357ydZXc+TotcYxSlyWoZ12EXAUYtmo6S+hBLZ2Tv8C1h2xG/VtgVdsDgbSD6aCGHgXk5HwGdOo7JNX0C7qeRUpidgTWCmxZ8Ng8hkxw9awOD33J8SRuYOo32TLgpeVPjRJImfuW+9DVfXw735xiucA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iuFJTO9D; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuFJTO9D"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5069a785ed2so147301cf.1
        for <selinux@vger.kernel.org>; Thu, 26 Feb 2026 17:45:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772156704; cv=none;
        d=google.com; s=arc-20240605;
        b=eRz2zryEJTWQfSy+P4lTaQT8xS5bXPl7+MJshbAs1DDTpUcoLdgMt7nDtL0O+5TrtS
         Fu9QazOMPiUOLnvQvCVi4+1OLI/5c8mMdedOQbHYC53pprKRcyMQRHgQLFGnivJE1PjG
         3l8aCfWmomi6L61A7EnuJ6dBsHPwRV3O6V3IMx2MCYnPZmeXQf3F1p5Q7zZ9tJEWO7vL
         s35nImjLDTeXbEvbk4l/4XoAtcSRgdqqVbvxmUkPjE3K3mhWlO8umouG+bxqD+CD0dH0
         X/aJR1x/3jmiLMmsECK5aG3BVr/BIRUNdvCPhi7PWQMURtGF0gCbECgqDK/BJ/WTBYOR
         Smcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gd8Or4jw+KaN2n4zfa69DEJe3MtMYrG1oPRqq6BDF7o=;
        fh=FZBClHCJ7Bz8JyHHT1l8EiHNpzHHf3Y7B+1qnofyGmc=;
        b=PPoDkwHHfYcVBWklvc35AuCEE6yNAPP5Xxg+Qvoilzq91Zt3H4FaqkAez4kJzuHNUB
         TKFczBPpZ/nX7TpoprsbOAVjQ3jrAT0T6shCLLvh3y+TYU4wWMns5aqT6OHwRIUHgnZE
         Oe+FglhwIcNmMf6xBxG2AO86vDl8fLm2PTmPP4mQ5HZPiKBG4y2Qilfd9dUc4SoTMBAl
         gG+C2bxvM254zDX3JCjuVSBLOq6xzngCqlGgP/jB3xLo14f/ItsakN/BVfr8dUwHNfEF
         2IxeJZKlG1bMQ/I2VfCCVwu76v41H3JD0FwAUbxf/td6WJ+Sy0iQ8r/5zs5uDj99qNjY
         ZG7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772156704; x=1772761504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gd8Or4jw+KaN2n4zfa69DEJe3MtMYrG1oPRqq6BDF7o=;
        b=iuFJTO9DbdGjG4OvKuWk4If3FJ0gGrAHoecGtwpVcimJmjewgXFgfz3PHhZPUE0V0v
         7EcpHH6CepGotyILGoOceTjE3sViKeBY8n2K9xorNnM/IQtnlwzgFQn3PbwxU3hNQ1iK
         SjKMQ8feQzqH6cZgNjbx/CyZTbo03oUXl2EORN6HpCgd19KxZgKQGEi6IbA+V72M8sGU
         RJ2SgDlHP0QTwDZP12k12pABftzdyJypuQHzyQ1QrjEsuAc/zxglLpavYUQ0lSw7tPjv
         yLbShlaA++ffgtAuOQjprzxvPl1PRDR763JEcRb4a6LvORWwaKJt4P7zSP95OxZ8R8kh
         kEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772156704; x=1772761504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gd8Or4jw+KaN2n4zfa69DEJe3MtMYrG1oPRqq6BDF7o=;
        b=mCeqwVRrk5GvPdBKS13volxljuhZmBtS78j9t2AYDsWd3gQy6fNkOMo4r/6KA5lf7Z
         wWKbNnyhcsUZ31ZMD4lwrad5GDyIYDP6QIy6/mWEteX3ZD8xaaMGRqJQEE9NkGv+hQBw
         O2oYNDTcTKZSL07di1tGswYybNzREU5LLzRUAjGGW/CazD5vRCkaqJ4SSoClA5P4RBYs
         J5OUBJYYBLzgiBhSAZzaDmgH5mtdPG7oasLG5FGuyq5qI06778bOAfiTFqzq9fAZjmuO
         RwQqoDtUW4aZmGRTrclgI0zCpyRJw77q/fu0R2etIZfWTma4y3rEowg+X27ASt3+/xP6
         zAAA==
X-Forwarded-Encrypted: i=1; AJvYcCWJK8PeLYv7VZP6pmyh0MdvGXpYDCNIq5eL4BLr3MHkXB9SzmUlya6FgmYjtQoVYlgefgzL2BFg@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2HqS7pkC5vGLFXrFb1pGU8q1WS280jBlgwkPq7bCG8hy4EwO
	dEk3gSd+Y/Z4X6Wau6gjOPjW2ACQP4l9v58Fhv76qARcMcaN0TFqcF0n1zolfq97b7GBMqQqkm+
	a3gBdZerct6or9iTcyOYD6Fo4BT1gEVN2isJwEvaR
X-Gm-Gg: ATEYQzw+b3xKCU1qZJWO/oAqJPp3MqtP1d8NhRDEWy1/iqXttsAWwJViynwrGQFWFht
	7MMYggsJOD+5Sl9CvnQUGhfrWUytLYLrzH4FKu6BLdnV+3p+h/SbMlTULKyzAt4rUuTyyFlTBSj
	pB6rVoBKLSx72YOgx1f/PwtfU/DAu3XqdfELLvKlr5kyDJfXKSTACOjTV6zNH+ZrI64mTgWZtTo
	sK0fr0ECgGfw8E1F1tQ1lPe3Ed7Ow1vtnI5JFX9ehCIO/Hy+E2UJS3PEFQqDz6HpqCv1ye9Jr6T
	MP0abH4b/tI65eXbQvsUK+mz4iF6xLM9DRjPQA==
X-Received: by 2002:a05:622a:1b88:b0:501:5180:3c90 with SMTP id
 d75a77b69052e-50745532dfemr18764911cf.15.1772156703182; Thu, 26 Feb 2026
 17:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769509130.git.antony.antony@secunet.com> <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
In-Reply-To: <b7b1bee9456ac4ada8941c93c2cc17f07d0b1912.1769509131.git.antony.antony@secunet.com>
From: Yan Yan <evitayan@google.com>
Date: Thu, 26 Feb 2026 17:44:51 -0800
X-Gm-Features: AaiRm53RIy5a1ijBLPj6Ygqdb2JxFNfGepc651c7uIHrwPbAadO3XxmZ9r_l9Xk
Message-ID: <CADHa2dAxVFQULCKnsjSmSPrK+VTJyyT-5P5BAYGdhO5wKDKqig@mail.gmail.com>
Subject: Re: [PATCH ipsec-next v5 8/8] xfrm: add XFRM_MSG_MIGRATE_STATE for
 single SA migration
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Chiachang Wang <chiachangwang@google.com>, devel@linux-ipsec.org, 
	Simon Horman <horms@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	Nathan Harold <nharold@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Antony,

May I request that we also support updating the XFRMA_SET_MARK as part
of the new XFRM_MSG_MIGRATE_STATE message?

In Android, the primary use case for migration is switching the
underlying physical network for an IPsec tunnel (e.g. VPN, Wifi
calling). Currently, due to the limits of XFRM_MSG_MIGRATE, we are
forced to use a separate UPDSA call to update the set-mark. Supporting
XFRMA_SET_MARK within the migrate message would allow us to update the
addresses and the routing mark together in one atomic call.

Regarding the logic, I believe the set-mark can follow the same
omit-to-clear pattern as XFRMA_ENCAP and XFRMA_OFFLOAD_DEV.

What do you think?

Yan and Nathan


On Tue, Jan 27, 2026 at 2:44=E2=80=AFAM Antony Antony <antony.antony@secune=
t.com> wrote:
>
> Add a new netlink method to migrate a single xfrm_state.
> Unlike the existing migration mechanism (SA + policy), this
> supports migrating only the SA and allows changing the reqid.
>
> The reqid is invariant in the old migration.
>
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
> v1->v2: merged next patch here to fix use uninitialized value
>         - removed unnecessary inline
>         - added const when possible
>
> v2->v3: free the skb on the error path
>
> v3->v4: preserve reqid invariant for each state migrated
>
> v4->v5: - set portid, seq in XFRM_MSG_MIGRATE_STATE netlink notification
>         - rename error label to out for clarity
>         - add locking and synchronize after cloning
>         - change some if(x) to if(!x) for clarity
>         - call __xfrm_state_delete() inside the lock
>         - return error from xfrm_send_migrate_state() instead of always
>           returning 0
> ---
>  include/net/xfrm.h          |   1 +
>  include/uapi/linux/xfrm.h   |  11 +++
>  net/xfrm/xfrm_policy.c      |   1 +
>  net/xfrm/xfrm_state.c       |   8 +-
>  net/xfrm/xfrm_user.c        | 176 ++++++++++++++++++++++++++++++++++++
>  security/selinux/nlmsgtab.c |   3 +-
>  6 files changed, 195 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 6064ea0a6f2b..906027aec40b 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -686,6 +686,7 @@ struct xfrm_migrate {
>         u8                      mode;
>         u16                     reserved;
>         u32                     old_reqid;
> +       u32                     new_reqid;
>         u16                     old_family;
>         u16                     new_family;
>  };
> diff --git a/include/uapi/linux/xfrm.h b/include/uapi/linux/xfrm.h
> index a23495c0e0a1..60b1f201b237 100644
> --- a/include/uapi/linux/xfrm.h
> +++ b/include/uapi/linux/xfrm.h
> @@ -227,6 +227,9 @@ enum {
>  #define XFRM_MSG_SETDEFAULT XFRM_MSG_SETDEFAULT
>         XFRM_MSG_GETDEFAULT,
>  #define XFRM_MSG_GETDEFAULT XFRM_MSG_GETDEFAULT
> +
> +       XFRM_MSG_MIGRATE_STATE,
> +#define XFRM_MSG_MIGRATE_STATE XFRM_MSG_MIGRATE_STATE
>         __XFRM_MSG_MAX
>  };
>  #define XFRM_MSG_MAX (__XFRM_MSG_MAX - 1)
> @@ -507,6 +510,14 @@ struct xfrm_user_migrate {
>         __u16                           new_family;
>  };
>
> +struct xfrm_user_migrate_state {
> +       struct xfrm_usersa_id id;
> +       xfrm_address_t new_saddr;
> +       xfrm_address_t new_daddr;
> +       __u16 new_family;
> +       __u32 new_reqid;
> +};
> +
>  struct xfrm_user_mapping {
>         struct xfrm_usersa_id           id;
>         __u32                           reqid;
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index 854dfc16ed55..72678053bd69 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -4672,6 +4672,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u=
8 dir, u8 type,
>                 if ((x =3D xfrm_migrate_state_find(mp, net, if_id))) {
>                         x_cur[nx_cur] =3D x;
>                         nx_cur++;
> +                       mp->new_reqid =3D x->props.reqid; /* reqid is inv=
ariant in XFRM_MSG_MIGRATE */
>                         xc =3D xfrm_state_migrate(x, mp, encap, net, xuo,=
 extack);
>                         if (xc) {
>                                 x_new[nx_new] =3D xc;
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 2e03871ae872..945e0e470c0f 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1979,7 +1979,6 @@ static struct xfrm_state *xfrm_state_clone_and_setu=
p(struct xfrm_state *orig,
>         memcpy(&x->lft, &orig->lft, sizeof(x->lft));
>         x->props.mode =3D orig->props.mode;
>         x->props.replay_window =3D orig->props.replay_window;
> -       x->props.reqid =3D orig->props.reqid;
>
>         if (orig->aalg) {
>                 x->aalg =3D xfrm_algo_auth_clone(orig->aalg);
> @@ -2053,7 +2052,7 @@ static struct xfrm_state *xfrm_state_clone_and_setu=
p(struct xfrm_state *orig,
>                         goto error;
>         }
>
> -
> +       x->props.reqid =3D m->new_reqid;
>         x->props.family =3D m->new_family;
>         memcpy(&x->id.daddr, &m->new_daddr, sizeof(x->id.daddr));
>         memcpy(&x->props.saddr, &m->new_saddr, sizeof(x->props.saddr));
> @@ -2159,9 +2158,10 @@ int xfrm_state_migrate_install(const struct xfrm_s=
tate *x,
>                                struct xfrm_user_offload *xuo,
>                                struct netlink_ext_ack *extack)
>  {
> -       if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) =
{
> +       if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family) |=
|
> +           x->props.reqid !=3D xc->props.reqid) {
>                 /*
> -                * Care is needed when the destination address
> +                * Care is needed when the destination address or reqid
>                  * of the state is to be updated as it is a part of tripl=
et.
>                  */
>                 xfrm_state_insert(xc);
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 26b82d94acc1..79e65e3e278a 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -3052,6 +3052,20 @@ static int xfrm_add_acquire(struct sk_buff *skb, s=
truct nlmsghdr *nlh,
>  }
>
>  #ifdef CONFIG_XFRM_MIGRATE
> +static void copy_from_user_migrate_state(struct xfrm_migrate *ma,
> +                                        const struct xfrm_user_migrate_s=
tate *um)
> +{
> +       memcpy(&ma->old_daddr, &um->id.daddr, sizeof(ma->old_daddr));
> +       memcpy(&ma->new_daddr, &um->new_daddr, sizeof(ma->new_daddr));
> +       memcpy(&ma->new_saddr, &um->new_saddr, sizeof(ma->new_saddr));
> +
> +       ma->proto =3D um->id.proto;
> +       ma->new_reqid =3D um->new_reqid;
> +
> +       ma->old_family =3D um->id.family;
> +       ma->new_family =3D um->new_family;
> +}
> +
>  static int copy_from_user_migrate(struct xfrm_migrate *ma,
>                                   struct xfrm_kmaddress *k,
>                                   struct nlattr **attrs, int *num,
> @@ -3154,7 +3168,167 @@ static int xfrm_do_migrate(struct sk_buff *skb, s=
truct nlmsghdr *nlh,
>         kfree(xuo);
>         return err;
>  }
> +
> +static int build_migrate_state(struct sk_buff *skb,
> +                              const struct xfrm_user_migrate_state *m,
> +                              const struct xfrm_encap_tmpl *encap,
> +                              const struct xfrm_user_offload *xuo,
> +                              u32 portid, u32 seq)
> +{
> +       int err;
> +       struct nlmsghdr *nlh;
> +       struct xfrm_user_migrate_state *um;
> +
> +       nlh =3D nlmsg_put(skb, portid, seq, XFRM_MSG_MIGRATE_STATE,
> +                       sizeof(struct xfrm_user_migrate_state), 0);
> +       if (!nlh)
> +               return -EMSGSIZE;
> +
> +       um =3D nlmsg_data(nlh);
> +       *um =3D *m;
> +
> +       if (encap) {
> +               err =3D nla_put(skb, XFRMA_ENCAP, sizeof(*encap), encap);
> +               if (err)
> +                       goto out_cancel;
> +       }
> +
> +       if (xuo) {
> +               err =3D nla_put(skb, XFRMA_OFFLOAD_DEV, sizeof(*xuo), xuo=
);
> +               if (err)
> +                       goto out_cancel;
> +       }
> +
> +       nlmsg_end(skb, nlh);
> +       return 0;
> +
> +out_cancel:
> +       nlmsg_cancel(skb, nlh);
> +       return err;
> +}
> +
> +static unsigned int xfrm_migrate_state_msgsize(bool with_encap, bool wit=
h_xuo)
> +{
> +       return NLMSG_ALIGN(sizeof(struct xfrm_user_migrate_state)) +
> +               (with_encap ? nla_total_size(sizeof(struct xfrm_encap_tmp=
l)) : 0) +
> +               (with_xuo ? nla_total_size(sizeof(struct xfrm_user_offloa=
d)) : 0);
> +}
> +
> +static int xfrm_send_migrate_state(const struct xfrm_user_migrate_state =
*um,
> +                                  const struct xfrm_encap_tmpl *encap,
> +                                  const struct xfrm_user_offload *xuo,
> +                                  u32 portid, u32 seq)
> +{
> +       int err;
> +       struct sk_buff *skb;
> +       struct net *net =3D &init_net;
> +
> +       skb =3D nlmsg_new(xfrm_migrate_state_msgsize(!!encap, !!xuo), GFP=
_ATOMIC);
> +       if (!skb)
> +               return -ENOMEM;
> +
> +       err =3D build_migrate_state(skb, um, encap, xuo, portid, seq);
> +       if (err < 0) {
> +               kfree_skb(skb);
> +               return err;
> +       }
> +
> +       return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_MIGRATE);
> +}
> +
> +static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *n=
lh,
> +                                struct nlattr **attrs, struct netlink_ex=
t_ack *extack)
> +{
> +       int err =3D -ESRCH;
> +       struct xfrm_state *x;
> +       struct xfrm_state *xc;
> +       struct net *net =3D sock_net(skb->sk);
> +       struct xfrm_encap_tmpl *encap =3D NULL;
> +       struct xfrm_user_offload *xuo =3D NULL;
> +       struct xfrm_migrate m =3D {};
> +       struct xfrm_user_migrate_state *um =3D nlmsg_data(nlh);
> +
> +       if (!um->id.spi) {
> +               NL_SET_ERR_MSG(extack, "Invalid SPI 0x0");
> +               return -EINVAL;
> +       }
> +
> +       copy_from_user_migrate_state(&m, um);
> +
> +       x =3D xfrm_user_state_lookup(net, &um->id, attrs, &err);
> +       if (!x) {
> +               NL_SET_ERR_MSG(extack, "Can not find state");
> +               return err;
> +       }
> +
> +       if (!x->dir) {
> +               NL_SET_ERR_MSG(extack, "State direction is invalid");
> +               err =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       if (attrs[XFRMA_ENCAP]) {
> +               encap =3D kmemdup(nla_data(attrs[XFRMA_ENCAP]), sizeof(*e=
ncap),
> +                               GFP_KERNEL);
> +               if (!encap) {
> +                       err =3D -ENOMEM;
> +                       goto out;
> +               }
> +       }
> +
> +       if (attrs[XFRMA_OFFLOAD_DEV]) {
> +               xuo =3D kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
> +                             sizeof(*xuo), GFP_KERNEL);
> +               if (!xuo) {
> +                       err =3D -ENOMEM;
> +                       goto out;
> +               }
> +       }
> +
> +       xc =3D xfrm_state_migrate_create(x, &m, encap, net, xuo, extack);
> +       if (!xc) {
> +               if (extack && !extack->_msg)
> +                       NL_SET_ERR_MSG(extack, "State migration clone fai=
led");
> +               err =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       spin_lock_bh(&x->lock);
> +       /* synchronize to prevent SN/IV reuse */
> +       xfrm_migrate_sync(xc, x);
> +       __xfrm_state_delete(x);
> +       spin_unlock_bh(&x->lock);
> +
> +       err =3D xfrm_state_migrate_install(x, xc, &m, xuo, extack);
> +       if (err < 0) {
> +               /*
> +                * In this rare case both the old SA and the new SA
> +                * will disappear.
> +                * Alternatives risk duplicate SN/IV usage which must not=
 occur.
> +                * Userspace must handle this error, -EEXIST.
> +                */
> +               goto out;
> +       }
> +
> +       err =3D xfrm_send_migrate_state(um, encap, xuo, nlh->nlmsg_pid,
> +                                     nlh->nlmsg_seq);
> +       if (err < 0)
> +               NL_SET_ERR_MSG(extack, "Failed to send migration notifica=
tion");
> +out:
> +       xfrm_state_put(x);
> +       kfree(encap);
> +       kfree(xuo);
> +       return err;
> +}
> +
>  #else
> +static int xfrm_do_migrate_state(struct sk_buff *skb, struct nlmsghdr *n=
lh,
> +                                struct nlattr **attrs, struct netlink_ex=
t_ack *extack)
> +{
> +       NL_SET_ERR_MSG(extack, "XFRM_MSG_MIGRATE_STATE is not supported")=
;
> +       return -ENOPROTOOPT;
> +}
> +
>  static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
>                            struct nlattr **attrs, struct netlink_ext_ack =
*extack)
>  {
> @@ -3307,6 +3481,7 @@ const int xfrm_msg_min[XFRM_NR_MSGTYPES] =3D {
>         [XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] =3D sizeof(u32),
>         [XFRM_MSG_SETDEFAULT  - XFRM_MSG_BASE] =3D XMSGSIZE(xfrm_userpoli=
cy_default),
>         [XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] =3D XMSGSIZE(xfrm_userpoli=
cy_default),
> +       [XFRM_MSG_MIGRATE_STATE - XFRM_MSG_BASE] =3D XMSGSIZE(xfrm_user_m=
igrate_state),
>  };
>  EXPORT_SYMBOL_GPL(xfrm_msg_min);
>
> @@ -3400,6 +3575,7 @@ static const struct xfrm_link {
>         [XFRM_MSG_GETSPDINFO  - XFRM_MSG_BASE] =3D { .doit =3D xfrm_get_s=
pdinfo   },
>         [XFRM_MSG_SETDEFAULT  - XFRM_MSG_BASE] =3D { .doit =3D xfrm_set_d=
efault   },
>         [XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] =3D { .doit =3D xfrm_get_d=
efault   },
> +       [XFRM_MSG_MIGRATE_STATE - XFRM_MSG_BASE] =3D { .doit =3D xfrm_do_=
migrate_state },
>  };
>
>  static int xfrm_reject_unused_attr(int type, struct nlattr **attrs,
> diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> index 2c0b07f9fbbd..655d2616c9d2 100644
> --- a/security/selinux/nlmsgtab.c
> +++ b/security/selinux/nlmsgtab.c
> @@ -128,6 +128,7 @@ static const struct nlmsg_perm nlmsg_xfrm_perms[] =3D=
 {
>         { XFRM_MSG_MAPPING, NETLINK_XFRM_SOCKET__NLMSG_READ },
>         { XFRM_MSG_SETDEFAULT, NETLINK_XFRM_SOCKET__NLMSG_WRITE },
>         { XFRM_MSG_GETDEFAULT, NETLINK_XFRM_SOCKET__NLMSG_READ },
> +       { XFRM_MSG_MIGRATE_STATE, NETLINK_XFRM_SOCKET__NLMSG_WRITE },
>  };
>
>  static const struct nlmsg_perm nlmsg_audit_perms[] =3D {
> @@ -203,7 +204,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, =
u32 *perm)
>                  * structures at the top of this file with the new mappin=
gs
>                  * before updating the BUILD_BUG_ON() macro!
>                  */
> -               BUILD_BUG_ON(XFRM_MSG_MAX !=3D XFRM_MSG_GETDEFAULT);
> +               BUILD_BUG_ON(XFRM_MSG_MAX !=3D XFRM_MSG_MIGRATE_STATE);
>
>                 if (selinux_policycap_netlink_xperm()) {
>                         *perm =3D NETLINK_XFRM_SOCKET__NLMSG;
> --
> 2.39.5
>


--=20
--
Best,
Yan
