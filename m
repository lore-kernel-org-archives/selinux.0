Return-Path: <SRS0=HWKQ=Q2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68204C43381
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 00:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C35B2086D
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 00:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PAei3EKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbfBSA2l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:28:41 -0500
Received: from sonic302-10.consmr.mail.bf2.yahoo.com ([74.6.135.49]:40608 "EHLO
        sonic302-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732277AbfBSA2l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Feb 2019 19:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1550536119; bh=QPsa1BEYPs9JLhLEDdgOIHM6KS83Srq3bOmZbQXIlZA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=PAei3EKgLx5zQa3bewgckyFir7t+L5TXp2sOa2CrW1PmHVfW/hXuHiZrHzgX1pTN9fe4Pkau23yEcrHgBsYiURcg0JgBfwP353G64+eh8vcdAhNw0tLkbi76puO9FePl43lATj6jNnt8jg/A5UOepRylWIJ89l8FEWSggYE1FjI/ykgGPy1WR60VQagJNZqgOf5JoW4x8tBimYMjxBtMwxLQTJnsHOdOkd2Xmqt3xNr0XHo2Pu0+mJbroFaFeIICNufRfQ80XlBNNALjqgTlSFY3E5TvlXrSeqZpwWp/vojZvsB/W8otM7WD8gzXRRipz6QuzZv7LQqUAXNrY7zkcQ==
X-YMail-OSG: .uKyB4YVM1ls.1rZirTLjy5i7TxwQR54USX_LK1xuL8nD.6LPBs7ZBIDqXGY6jm
 pUsCcUeeY._vGrv9f96Ap7X6bkyGcuR51Y0GS..V9FgqoyJMwN1VYLA.QLBYVlWfCLIoefiBETMg
 mj8MUzMH4W1n.AOkycdg5tY8qfhMztbQn_ktNTg4.vns3fGcK8Dn1CqLQzoN_Wutr2ePZfBMP_UP
 jxB3EzHzVyXd056N7L7JTHHDZHSe7Y7yZ9M6OCMiLkpXJvUq2OffwEfHTTnmOeln2OqX9hiugXYp
 ghF95a46Zx1dzpR74wniyQPn_OteqrBNu5GkADsGKWNz0PFEsEsxIxRK2H8invcEcAiLJPpEXFRl
 ScHcd4i5PnhfLnJ0cVv8Xogd0YH8c99V69D45CwhEwTYGiJ0l6aH.KpJfqumloGSEAaNQacbjRLv
 tFbaTNcJ0UL8pPiZ13WV47eqx7Tz2po_WWFjla1Nb8DhYjDYwP8f13FWI5QIMAVXegRzIQg0Bgni
 H0lLIJxUgw2La_nD1UR2ZDQVWlxEREjA3O4y17N06wdTlTo88D4q_eIhen0tzkq.A7vAKGlUAMos
 4fR0xke.Y6sMxabAAggtzMVVB8ZpEj6XWwlc2bNbBpJu0gvIMqV_R49eS637gp5h3wT4mVPUw7cP
 I2IKC1DeAG1bet2vr86N._78M5MEnlafv97VXWNUu0EgDtP1Ae8jiPDAX3tUF8jv4_yT14ntieg.
 errVo5ajYK5oucIZjRtAtejfRDkqGr4jGNBLdNKBomXPyi5W0tVWHcO7gzN65m.Nl1hLNE27ql7m
 QnnVzLzYuvxx8WLUHIP5goCS6KPUmRVC0GuGewr6SBr1jxbecyz61WGBa.B8wI.fP5YAnFXlBb5R
 WGbcNvrpz3LaPN9zTgvEsxH6IQ8uqSC9zjeUAQ6k3XQgd0YU1xM4BnNbUTYjOxjeGU9zFIY2E_vm
 AsMYrBCE3WplnWF.382Q3k2nD8.bk1FF.hs2PVo91iteLAG0MqyB3xkcz4BA4WQDa5AHY7Ra4_gG
 JH1LaZMqlYviA0EDXJlwUhhrf7dywRDQSSQ3Aq.mB_AbrMzkaL5QLE1ZdejoRGELGyxFeEdPEKxD
 DhjdBvwR.QQJBwUI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Tue, 19 Feb 2019 00:28:39 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp426.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c3439c9a64d6868a1d5bdffe3fa8bf91;
          Tue, 19 Feb 2019 00:28:36 +0000 (UTC)
Subject: Re: [PATCH v6 5/5] kernfs: initialize security of newly created nodes
To:     Ondrej Mosnacek <omosnace@redhat.com>, Tejun Heo <tj@kernel.org>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        casey@schaufler-ca.com
References: <20190214095015.16032-1-omosnace@redhat.com>
 <20190214095015.16032-6-omosnace@redhat.com>
 <20190214154854.GO50184@devbig004.ftw2.facebook.com>
 <CAFqZXNuOg9ex_WqCCKYzPQSeqbGmo-KP4Yh9TB4bbMZziG314A@mail.gmail.com>
 <20190215155014.GP50184@devbig004.ftw2.facebook.com>
 <CAFqZXNvVb75K9ZemVObcBB+rntL38_VfY5P6jyAbuwjymt6MQQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8c1ddde8-c7aa-7dca-3a0f-2d425c6879b4@schaufler-ca.com>
Date:   Mon, 18 Feb 2019 16:28:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNvVb75K9ZemVObcBB+rntL38_VfY5P6jyAbuwjymt6MQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/18/2019 2:03 AM, Ondrej Mosnacek wrote:
> On Fri, Feb 15, 2019 at 4:50 PM Tejun Heo <tj@kernel.org> wrote:
>> On Fri, Feb 15, 2019 at 04:45:44PM +0100, Ondrej Mosnacek wrote:
>>> On Thu, Feb 14, 2019 at 4:49 PM Tejun Heo <tj@kernel.org> wrote:
>>>> On Thu, Feb 14, 2019 at 10:50:15AM +0100, Ondrej Mosnacek wrote:
>>>>> +static int kernfs_node_init_security(struct kernfs_node *parent,
>>>>> +                                  struct kernfs_node *kn)
>>>> Can we skip the whole thing if security is not enabled?
>>> Do you mean just skipping the whole part when CONFIG_SECURITY=n? That
>>> is easy to do and I can add it in the next respin (although the
>>> compiler should be able to optimize most of it out in that case).
>> So the goal is allowing folks who don't use this to not pay.  It'd be
>> better the evaulation can be as late as possible but obviously there's
>> a point where that'd be too complicated.  Maybe "ever enabled in this
>> boot" is a good and simple enough at the same time?
> I don't think there is a way currently to check whether some LSM has
> been enabled at boot or not. I suppose we could add such function for
> this kind of heuristics, but I'm not sure how it would interplay with
> the plans to allow multiple LSM to be enabled simultaneously...
> Perhaps it would be better/easier to just add a
> security_kernfs_needs_init() function, which would simply check if the
> list of registered kernfs_init_security hooks is empty.
>
> I propose something like the patch below (the whitespace is mangled -
> intended just for visual review). I plan to fold it into the next
> respin if there are no objections to this approach.
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 735a6d382d9d..5b99205da919 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -625,6 +625,9 @@ static int kernfs_node_init_security(struct
> kernfs_node *parent,
>          struct qstr q;
>          int ret;
>
> +       if (!security_kernfs_needs_init() || !parent)
> +               return 0;
> +
>          if (!parent->iattr) {
>                  kernfs_iattr_init(&iattr_parent, parent);
>                  simple_xattrs_init(&xattr_parent);
> @@ -720,11 +723,9 @@ static struct kernfs_node
> *__kernfs_new_node(struct kernfs_root *root,
>                          goto err_out3;
>          }
>
> -       if (parent) {
> -               ret = kernfs_node_init_security(parent, kn);
> -               if (ret)
> -                       goto err_out3;
> -       }
> +       ret = kernfs_node_init_security(parent, kn);
> +       if (ret)
> +               goto err_out3;
>
>          return kn;
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 581944d1e61e..49a083dbc464 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -292,6 +292,7 @@ int security_inode_listsecurity(struct inode
> *inode, char *buffer, size_t buffer
>   void security_inode_getsecid(struct inode *inode, u32 *secid);
>   int security_inode_copy_up(struct dentry *src, struct cred **new);
>   int security_inode_copy_up_xattr(const char *name);
> +int security_kernfs_needs_init(void);
>   int security_kernfs_init_security(const struct qstr *qstr,
>                                    const struct iattr *dir_iattr,
>                                    struct simple_xattrs *dir_secattr,
> @@ -789,6 +790,11 @@ static inline int security_inode_copy_up(struct
> dentry *src, struct cred **new)
>          return 0;
>   }
>
> +static inline int security_kernfs_needs_init(void)
> +{
> +       return 0;
> +}
> +
>   static inline int security_kernfs_init_security(
>                  const struct qstr *qstr, const struct iattr *dir_iattr,
>                  struct simple_xattrs *dir_secattr, const struct iattr *iattr,
> diff --git a/security/security.c b/security/security.c
> index 836e0822874a..3c8b9b5baabc 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -892,6 +892,11 @@ int security_inode_copy_up_xattr(const char *name)
>   }
>   EXPORT_SYMBOL(security_inode_copy_up_xattr);
>
> +int security_kernfs_needs_init(void)
> +{
> +       return !hlist_empty(&security_hook_heads.kernfs_init_security);
> +}
> +

Yuck. That's an awful lot of infrastructure just to track
that state. May I suggest that instead you have the
security_kernfs_init_security() hook return -EOPNOTSUPP
in the no-LSM case (2nd argument to call_in_hook). You could
then have a state flag in kernfs that you can set to indicate
you don't need to call security_kernfs_init_security() again.

>   int security_kernfs_init_security(const struct qstr *qstr,
>                                    const struct iattr *dir_iattr,
>                                    struct simple_xattrs *dir_secattr,
>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Associate Software Engineer, Security Technologies
> Red Hat, Inc.
