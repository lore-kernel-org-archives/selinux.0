Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199BFC48BD9
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 17:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F3E2064A
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 17:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ni3owQxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfF0RhE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:37:04 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:38905
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbfF0RhD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jun 2019 13:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561657022; bh=rnUz527IRvGW567ICOGBQkF2bL+EHKrlt8fZ7vdSjQk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Ni3owQxNlFEtLfv9eLApGhWT+/I/OWy6IvjezuhoZkeYwzumwiIjxxNltxE86/cxX1SuAgWyRZqCQ4hN5beFEiSyKlbab3HewqhHndCZXljlDS4vkkmLFxO4wyikshDkROwPPpJC3+pbTQJX/TUQI933PHK7s1Qb/7vsLzF9yGobnM6HnDbCsve3eidmqRw6ccuoeHnI2N+aMMmVk4WHkdZAdOvyk82QY+saHT8EyvVC6dETk5WMRuBeaupyncmWsVC8wh3bzRv/91c+58HX3kX+lqoR7CJ65dqhHnFRZkZ+YBXOJOIUvrSBWr+oo+de5X9muUTh8cr7R7z0531IOA==
X-YMail-OSG: DAf6OocVM1lXF9J9eCClcFYngMp58B16Z.hrcFT_XkEU4Vp.dl7WkZL2JhGASXT
 wJJxIQhXBkm8PZHqO9BZjlfT8bEqty4l.QaWAI_6ATfWQnEfNQfQY.t8pEOS6z3JilBp0smyumuE
 PVmHukDNbyJ185XQKhWSAC7uhCxhW16UjpUoyCXceTO1QCtzobfCopdydiKMBcBFyaxwtY49S_1Y
 xYhlTQq796Iq1sCSDSSrfmrg8ib62200rU6gnXfAo88KJiJlLAJuUPbqqLu8ru6u0fzmVfz7LZLc
 uscLYNSU4JWyXKPIM_p23V_4sEdm6JiHevyuG4nyQjI1gjiYSJrXGQHnWnzrdWELEK__4ZW2wH82
 C1jz07m.h4OUMnFb_doPO6Ax7tBvEiwCZJIPLF49oPwbEUzyEQLqdeJyPf6mBn15OcIR9Tc6UvtN
 3tXJqk0Spu3kgfJMspWjd778iVF5ZrvZzkTzOJtxdBN3AfnfXZ_nLcxy7vy59xK9A0SCleZjGTN0
 GWNxkEU_Trg.bvkx6D.r_kdLvWmDe8xiSVIW2k_abNn5GX_B4C0Yd1Kt6YS_DyIXyuzPcG4kCavH
 YoXnZFkHxeT86KFVA066Rkc1xA6EMfP0qLQIJrynonJmYLFCnh22xC2q19FgO.ZeTdUYR0CZjom1
 zDMG4Ptp.ToJPkSTz8oNnPcmYraKYODf7c9Md5eTPQ9g9rSeTjyzyK_klyziDVS7Qsbg9HPX0bS5
 JzUR6Bfb70wq3YVGgVRXH84why5NRMCHzM7IkIc.VSZwbRv1jcBFiey1dfGkVdRxRyMBGUMhhsoc
 54BMVdKzB2cgiqEKgXH9gNNkzNH5bIdxwmyLtj6p0vPGaqSa_vpBMP7ADeFWVEWjLOHQrIuGb5H7
 kMyYsYOW57xBhJ3lOPblpyrh7jK1oHiQbUFgmmecZf3MoeHVhZ6Men_JJ9xeuaAdOSfg4emebwN8
 qSZnb54QC88eXZV1Zn2jHZj4BW0lfEAnigHYF2igJxnTU2GgslZ75DfDkO0Z.Dx.ELPRj.jLIz0N
 3fflUlePQ7v3179Ef_e4sVcF8k64XW8qrqwvC1pGxZitLellZIXT6xcUtYs1EuUfdp8XHbbenLpp
 0OADqhZPPY_MFf33cjrLlIUnrmcFbKAoM2oCmkPX1YUMPnkT_fwqtwT_gDz1JAV6D8_6DuVwK7Ma
 ufiFMtAf0zznHewWURXIq.Ix7YHkr8UG_r3S7za4I_ynjyjs9.6N8uJlnCXxA9yibjcpt7_sfggh
 VyaK39fjIsJ5mg0RP1dMcWXZsSLo_YRiPRj33tB3zHmVb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Jun 2019 17:37:02 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp419.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 480be60ab50c2e1c914aa23408e129be;
          Thu, 27 Jun 2019 17:36:59 +0000 (UTC)
Subject: Re: [PATCH v4 17/23] LSM: Use lsmcontext in security_secid_to_secctx
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-18-casey@schaufler-ca.com>
 <201906262051.59B064019F@keescook>
 <cacf9eda-7486-80d3-f47d-b0dbb6872091@schaufler-ca.com>
 <201906271007.4248A3AE@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <e7b07964-1f00-b168-de8c-c63f7d2a1418@schaufler-ca.com>
Date:   Thu, 27 Jun 2019 10:36:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <201906271007.4248A3AE@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/27/2019 10:17 AM, Kees Cook wrote:
> On Thu, Jun 27, 2019 at 09:29:25AM -0700, Casey Schaufler wrote:
>> On 6/26/2019 8:53 PM, Kees Cook wrote:
>>> On Wed, Jun 26, 2019 at 12:22:28PM -0700, Casey Schaufler wrote:
>>>> Replace the (secctx,seclen) pointer pair with a single
>>>> lsmcontext pointer to allow return of the LSM identifier
>>>> along with the context and context length. This allows
>>>> security_release_secctx() to know how to release the
>>>> context. Callers have been modified to use or save the
>>>> returned data from the new structure.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> ---
>>>>  drivers/android/binder.c                | 24 ++++++---------
>>>>  include/linux/security.h                |  4 +--
>>>>  include/net/scm.h                       |  9 ++----
>>>>  kernel/audit.c                          | 29 +++++++-----------
>>>>  kernel/auditsc.c                        | 31 +++++++------------
>>>>  net/ipv4/ip_sockglue.c                  |  7 ++---
>>>>  net/netfilter/nf_conntrack_netlink.c    | 14 +++++----
>>>>  net/netfilter/nf_conntrack_standalone.c |  7 ++---
>>>>  net/netfilter/nfnetlink_queue.c         |  5 +++-
>>>>  net/netlabel/netlabel_unlabeled.c       | 40 ++++++++--------------=
---
>>>>  net/netlabel/netlabel_user.c            |  7 ++---
>>>>  security/security.c                     |  9 ++++--
>>>>  12 files changed, 72 insertions(+), 114 deletions(-)
>>>>
>>>> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
>>>> index 89e574be34cc..5d417a7b9bb3 100644
>>>> --- a/drivers/android/binder.c
>>>> +++ b/drivers/android/binder.c
>>>> @@ -2874,9 +2874,7 @@ static void binder_transaction(struct binder_p=
roc *proc,
>>>>  	binder_size_t last_fixup_min_off =3D 0;
>>>>  	struct binder_context *context =3D proc->context;
>>>>  	int t_debug_id =3D atomic_inc_return(&binder_last_id);
>>>> -	char *secctx =3D NULL;
>>>> -	u32 secctx_sz =3D 0;
>>>> -	struct lsmcontext scaff; /* scaffolding */
>>>> +	struct lsmcontext lsmctx;
>>> As James found, this needs to be zero initialized:
>>>
>>> struct lsmcontext lsmctx =3D { };
>> Thanks! I'll incorporate this in v5. It's great to
>> have y'all checking it out.
> I looked through other removed NULL assignments, and I think I see some=

> other issues...
>
>                 binder_alloc_copy_to_buffer(&target_proc->alloc,
>                                             t->buffer, buf_offset,
> -                                           secctx, secctx_sz);
> -               security_release_secctx(secctx, secctx_sz);
> -               secctx =3D NULL;
> +                                           lsmctx.context, lsmctx.len)=
;
> +               security_release_secctx(&lsmctx);
>
> The new security_release_secctx() performs the zeroing if there is a
> slot match... should it be unconditional? (And should the no-op version=

> also zero?)

I don't see a reason not to zero in all cases. I'll change that.

>
> @@ -2420,8 +2420,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct=

> svc_fh *fhp,
>         __be32 status;
>         int err;
>         struct nfs4_acl *acl =3D NULL;
> -       void *context =3D NULL;
> -       int contextlen;
> +       struct lsmcontext context;
>
> This needs the same =3D { } to retain the same meaning.

I'm going to have security_secid_to_secctx() initialize
the lsmcontext. There's no case where it should be used
to update an existing context, and it makes more sense to
do it in one place than to make all the callers worry
about it.

> And here:
>
> @@ -1191,8 +1191,8 @@ static int audit_receive_msg(struct sk_buff *skb,=

> struct nlmsghdr *nlh)
>         struct audit_buffer     *ab;
>         u16                     msg_type =3D nlh->nlmsg_type;
>         struct audit_sig_info   *sig_data;
> -       char                    *ctx =3D NULL;
>         u32                     len;
> +       struct lsmcontext       context;
>
> And here:
>
> @@ -2069,24 +2070,23 @@ void audit_log_key(struct audit_buffer *ab, cha=
r
> *key)
> =20
>  int audit_log_task_context(struct audit_buffer *ab)
>  {
> -       char *ctx =3D NULL;
> -       unsigned len;
>         int error;
> -       u32 sid;
> +       struct lsmblob le;
> +       struct lsmcontext context;
>
> and here:
>
>  static int audit_log_pid_context(struct audit_context *context, pid_t
> pid,
> -                                kuid_t auid, kuid_t uid, unsigned int
>                                  sessionid,
> -                                u32 sid, char *comm)
> +                                kuid_t auid, kuid_t uid,
> +                                unsigned int sessionid,
> +                                struct lsmblob *l, char *comm)
>  {
>         struct audit_buffer *ab;
> -       char *ctx =3D NULL;
> -       u32 len;
> +       struct lsmcontext lsmctx;
>
> Maybe here?
>
> -               if (osid) {
> -                       char *ctx =3D NULL;
> -                       u32 len;
> -                       if (security_secid_to_secctx(osid, &ctx, &len))=

>                         {
> -                               audit_log_format(ab, " osid=3D%u", osid=
);
> +               if (lsmblob_is_set(olsm)) {
> +                       struct lsmcontext lsmcxt;
> +                       if (security_secid_to_secctx(olsm, &lsmcxt))
>                                 *call_panic =3D 1;
>
> and:
>
> -       if (n->osid !=3D 0) {
> -               char *ctx =3D NULL;
> -               u32 len;
> +       if (lsmblob_is_set(&n->olsm)) {
> +               struct lsmcontext lsmctx;
> =20
>
> and:
>
> @@ -395,7 +401,7 @@ nfqnl_build_packet_message(struct net *net, struct
> nfqnl_instance *queue,
>         enum ip_conntrack_info uninitialized_var(ctinfo);
>         struct nfnl_ct_hook *nfnl_ct;
>         bool csum_verify;
> -       char *secdata =3D NULL;
> +       struct lsmcontext context;
>
> and:
>
> @@ -387,8 +387,7 @@ int netlbl_unlhsh_add(struct net *net,
>         struct net_device *dev;
>         struct netlbl_unlhsh_iface *iface;
>         struct audit_buffer *audit_buf =3D NULL;
> -       char *secctx =3D NULL;
> -       u32 secctx_len;
> +       struct lsmcontext context;
>
>
> Sorry I forgot to check those the first time through!
>

