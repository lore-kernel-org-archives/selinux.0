Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D386C169C4
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 16:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E29A2082C
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 16:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NwSiVTvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbfAaQjI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:39:08 -0500
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:43652 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388493AbfAaQjI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Jan 2019 11:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1548952746; bh=VP4YSb4SrA3XoluAnmo+SdrZV9R84fMYlxmzyrvxAyA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=NwSiVTvZXQgOrUmrz12AL+vekPCatCJmeBEL380yosAHJwMybYBuZO+FkTsrTfRzoqIqOFPCSe+28RAYTVUNpoCXP9UmCaZwFXbwfUdqcBAxk+0md6GGlfMFghaYIfm8J/6dUJHf42B3e3gxy0U8Au6rqTdUQ9pZimv1QWRfsu2UZi1vNhPdlSXfqWAfKKTKU5Fx8qGyuQjOpYoxqpstdTZV4yKUfOZjN58N0xKyVw6uakSTvpAL4Iz9gy6wkpRJi0n4MGyY/i8vz5R3yNAtzfnjGzC2+VsxdjlNaNtFFTqBFlS5eeVLPQZ4X+OpBtWCzErkuMx7Qp3FOrGwZdbqCQ==
X-YMail-OSG: mJx0d1cVM1kuaEnqh_OrCcBC8GeNFiLryIqqHr3VGemGxFpwncAkLS.u1zmotH.
 7WTNJfplZYZRQsJUmEqsQ499b1KGsMItxjyC8rakfqLQyen9rvO74B.tiTb58hUVAao48tp3P1JW
 2rwBiSkRMAc6ZVyPLFY0vU8MUtMKDmOxG9zolGVsj9VohsMvbvmHLZdJ2o9zwVxFN9xkWvrZ0dMc
 xRSuU0OcIe7iKzBxgR5zjwfM5vVhrhCKRitpAUKcUVlH3aaiVFPJUyphFSt0WaUqE5mJSNFc4DVj
 dk8KoyuHXtqx0_9TBoA9GcSvCNsOi4rEe.xT2Rs60pzbIZH4wpPZLZD4IzBhZ52BVyA2.Cq3FI61
 j5v9geHRleWZUjs5fWHanPrOJde0D1DPggufyQk.BOWzGixt0wHDPV2L1FAzrnFl3c7bW9eqK6bK
 y9cugxEtQns97mcPc8b2.uHnJ7vhUQX3O9z6MAAP66gWiBJJbpIYVQX7YOXBBUBKnxvyKBQ.K5Dp
 KTfylG.VTJk0Pa06qwzW7DbY3LVUq0GDvh2Va65Nrx7QaVrmx_Hp4n9mvZJP5AAjKrDSg.dSWwpc
 QQToHKD5tvxyu8H4cg3.Qv6hTqQ1Fet9aMbIabVjjXyTk9BTooU5G4Qx2KNJiW3DUA_HqW1.Nsgf
 uVoFNlBU6xHvBLrRXzcXIT.oVAdmjd67a5IA_NbTH6ktKeXUssk97iRCmE4teZaTUvZcmVI.OLmp
 f24BXbxNuF7xsYF5CMAwlwZ4ypSIUpdj.Zk7Vbipj2fdiVoT_82.sZB72T32v8zluW8UKpAKLgof
 RaL0ol_f.wjXvVZkYpn2TtPG_HJQGMGZv.yjRt8YIPXbQDfP0XI.nwf6En.0taVF1lhb5h.sC7D.
 Yt319zsNFpKMR9NtsYU0giDMMEeEeqCmyx_PIK0v6Xl2qqzPT85FqThihbWahhhesu9Tev3fRw2m
 8pcJY63ppWsRqEXhx_YcOndv_ZRcSizq4sMzpUD6qgBM6S.BCuhV9F3A.bYOeCoOwytPOj0Grc5S
 dTNcXEYh6Pw3NGzqa0AyfJSkPPCR1HYIT47D2hUCDfC03mKcX26lzpxncRxhjBfX._lq7tlkIZQ6
 f1BOwI7lBWOUi9DvW7r5Wl0pdQb8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Thu, 31 Jan 2019 16:39:06 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 98cc0d3b076bd18c7df9321b4f34cea0;
          Thu, 31 Jan 2019 16:39:06 +0000 (UTC)
Subject: Re: [PATCH v3 5/5] kernfs: initialize security of newly created nodes
To:     Ondrej Mosnacek <omosnace@redhat.com>, Tejun Heo <tj@kernel.org>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <20190130114150.27807-1-omosnace@redhat.com>
 <20190130114150.27807-6-omosnace@redhat.com>
 <20190130170911.GZ50184@devbig004.ftw2.facebook.com>
 <CAFqZXNt0jNg2-bNbtsCX2=7bcb_GaxCnHfSyck=GksXBTkWJ-g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ebe3c70e-2bde-9fca-bb05-b46173e09b69@schaufler-ca.com>
Date:   Thu, 31 Jan 2019 08:39:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNt0jNg2-bNbtsCX2=7bcb_GaxCnHfSyck=GksXBTkWJ-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/31/2019 2:20 AM, Ondrej Mosnacek wrote:
> Hi Tejun,
>
> On Wed, Jan 30, 2019 at 6:09 PM Tejun Heo <tj@kernel.org> wrote:
>> Hello,
>>
>> On Wed, Jan 30, 2019 at 12:41:50PM +0100, Ondrej Mosnacek wrote:
>>> @@ -673,6 +698,12 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>>>                       goto err_out3;
>>>       }
>>>
>>> +     if (parent) {
>>> +             ret = kernfs_node_init_security(parent, kn);
>>> +             if (ret)
>>> +                     goto err_out3;
>>> +     }
>> So, doing this unconditionally isn't a good idea.  kernfs doesn't use
>> the usual dentry/inode because there are machines with 6, even 7 digit
>> number of kernfs nodes and some of them even failed to boot due to
>> memory shortage.  Please don't blow it up by default.
> Hm, I see... basically the only thing that gets allocated in
> kernfs_node_init_security() by default (at least under SELinux/ no
> LSM) is the kernfs_iattrs structures, so I assume you are pointing at
> that. I think this can be easily fixed, if we again use the assumption
> that whenever the parent node has only default attributes
> (parent->iattrs == NULL), then the child node should also have just
> default attributes (and so we don't need to call kernfs_iattrs() on it
> nor call the security hook). Something along these lines:
>
> [...]
> +static int kernfs_node_init_security(struct kernfs_node *parent,
> +                                    struct kernfs_node *kn)
> +{
> +       struct kernfs_iattrs *attrs, *pattrs;
> +       struct qstr q;
> +
> +       pattrs = parent->iattrs;
> +       if (!pattrs)
> +               return 0;
> +
> +       attrs = kernfs_iattrs(kn);
> +       if (!attrs)
> +               return -ENOMEM;
> +
> +       q.name = kn->name;
> +       q.hash_len = hashlen_string(parent, kn->name);
> [...]
>
> Technically this might make some LSMs unhappy, if they want to set
> some non-default context even if parent is all default,

The only possibility I see as a potential problem is a kernfs
mounted with the smackfstransmute=Something option. This sets
the security.SMACK64 to "Something" and the security.SMACK64TRANSMUTE
to true on the root node. But that doesn't seem like a rational
thing to do for a kernfs based filesystem.

> but this is
> already impossible now and in this case I think we have no better
> choice than sacrificing a bit of flexibility for memory efficiency,
> which is apparently critical here.
>
> Tejun, Casey, would the above modification be fine with you?

I *think so*, but I can't say 100% that I really understand the
entire issue.

>
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Associate Software Engineer, Security Technologies
> Red Hat, Inc.
>
