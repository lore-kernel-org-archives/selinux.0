Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29713C388F9
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 12:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88672087E
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 12:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="k0hxVfV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgJ3Md5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 08:33:57 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:41657
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726572AbgJ3Md4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 08:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604061235; bh=5SfRZimfNxjBdeZCtircb4uOt+W13bQCtEGkwspjHBE=; h=To:Cc:References:From:Subject:Date:In-Reply-To:From:Subject; b=k0hxVfV34KgfMfwlAEYrOsrMKS5ZBjm15qQlncpx7OQbHa8ZHbBhsJWvBYK3ETs7oq2FMUwiFwq6XvlRUAlgRyXSFqsZDmNmr9OOTBuO8qesTPK4UKBWw8dOZBp6MeKBJPrndhx+ZmJy90f1MojKP3QxB2k4XV5GM+Ru5JW1IBraaZlv5jEtGEYF8paSqvAnXPFcBGPPo8AJHkjCy4VcCjnOAYZ/VoeJ8ITjTMjOo6X/rZN7vT21nl6yPf+PC3xDWWIWxaO5qSMU4vHr0DJj05vS4quaMyB1zV0VOcKvplHoRYxohKtHAU5ntvOSIoB47YJOJInLfbKXmLUVLRiLiA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604061235; bh=19Gxv4a1RnJObh7SDe7f3woVbjgBJu3ue1jiFg7rNWo=; h=To:From:Subject:Date; b=Ayte3Fdv+uO8JGdDdBRpwlNrYGN5wMGc25Hwjq5oob6UISgXEBDXsPJsW6sJPj7MfcxL34IXrWg5qh9vDXwDc/yGeW5Qc7LoJcmlkYQ+S8Uj43mYYMHWW5ohlVDpgfFEtf37J2XNzfutCDRoBsBHrj8Tmml3bl36EQcWAgjs/JkMhtpJByVL8kN+0MtbMrnu5hor6nf4n5xNu9SvZr241psLebfCJ0JFu52TejVQD2FFssslrC8zyW0MMt8JjDLRcZkHfPyBSEfJm0meASFUWU7EkZadXRV5vUCyXnZjtD7dvXmiMUDlQj1RvapTw4KLEZW0br9p95f4uvxux4nU2Q==
X-YMail-OSG: kKRGvEwVM1kPQcQYitgPDIodofkxYAHNgPdkvljdiG.E1PL3j0aosMMlDnnO05s
 xGXLZPaI77WxkkgrOCQPyN12p7_Q5PnnM.TFGkzVuY08F2.P1lP3RMES5sC7SO_tVDO9CuOWptSB
 PlF2B4b2UI5PUeirmawTDpbQsH.1qwEd6RrfFccorit4jEmKWd2uhbOL8rrYm3kcTGmebjx.t8cN
 zCjtoNWCu0ovdNUF15vM.xqiWqGaAOOxGHf42PuTLVSAgAqjkqpr63UMY9gjlNvEfLwwVBwrBL09
 FHcP1GQWaRz7dHXdMKCARcJr3_0xrJq1jiYhPAGVULKF0XS48wj1yeYnMD1dZp4RmWCVkTDzlCrc
 VjuOanMFhHGNm71Yv4NwiUV.pF5Tl3YgPn3adMI9zk.TDto6QRkRc.S_MpGxabomqiMo47sIA9Ba
 YtrcaL4F6gbR.AkxYFK7Dd122962ZB.TcEQbLcHZCl7vrLYjCYBnwk3dE_9ed0dpxtDkiI14N7vt
 IqEVWikj9MYo6xdmfBwFXkzjvQn8v9Vls_eze8VcieHEnbHIUBklufVHw65BvIzqXMDsUnjj0tKl
 OHASaC1aXo68dWamTVNvMT82n50e3TmYwRPW56qV0GXL52dCUM64AwPUKGOiOIAHIO.Sf51OEvF2
 N23EJLtu_1bl6mCBi9BNTCDAp4NXqOHITlhPb3jpvdOF2Fezh.64JIEajlnjIh3nnEasQypmQo7L
 ganCMooCLBkv2akO5eSLMe42RNpzVJDjBKHMZFdqJSrPD7t9mutB443w_wRbZIys.7iXfsjHcGNW
 L8_mhKalyTE9T32P10Iylefaa3EFtf9fLZTviia2tY.XSN9HJ2I1hnCLOanXA13czcacv_yY_yt.
 wTHmNYkYvTyOL3B8jCYtoYkTSZjGOhLaLGsgzstODA8lvm6ulQYTRBurh.mtt5GBcvaroNK9dixO
 8e6FWEfpZCAr8zi9bWBzhBAHtg.iaKJAARonn5c80v5UAUW5OSFt94CsULCIe.aFQ9OXKJIPu9C5
 wXhuOrhkJqCmzU2xjzhgzu8n3GLwx3o_OSkkdcsu4tuGkUneSG5CshXpD.ZepGG5o95hfaOvr8A7
 YKua.Dg7C9i.0k0DMZrRzW26mWT4_HIRCmX6n3m8ttf623vkcfqDk.zjMv7fgDqrWfm9AxG9cq.3
 NrWF0RmYYXA0u4zOkvKP9FBMgK4G5C6GNb8_jhjNaF60fyjZy1UQ0cttQd8pAQg8uTcxypKQ7NCi
 7H0dcBb3Erj3RPyjs3Yp0sQYeMyhz7IZrOigUgC0rk.qi9RRqelpsA5cQfRaksMaIEYjM3zrPdpB
 kWS4DvnmWfP7qcngSgcINS6_Dc9YGwgVljQE7zPjxrcUDpBaaBt9y1IRrThOhI9CrEWzyIVXnV6y
 l8V9OEQ6ZdB.LI4ht1wYojguRS2wgCGwGongWibINm8uLw029rg4zl3Fz42LWdMsxkELjBTu4_6o
 fiAJhvHV9BuU9roxqTq6.dR21EPoAGRj2ebXAZKDNNCuXksQSV1mkEhxhzeCR8Ce9Mr3KfOknKGp
 nIkCxkjv9_Rs53hL9BW9irRNENNhH9zg.8nATVgKHVdRGJ1gdzRKS8lkTNXdVatyN0i3pr9EZapJ
 swVz9xgn92MGTnrCKR3oKRb6PTn2OEhlKtBVPwJ5E2_vcGaEWYo8OxnwD9BIxpzp5a_SWtWglrC6
 JNcr9w2NJxQXkrT.DfKVDzHuQA1gzqkcvgxxxQXx8QYZRPW3jd55bKsiAqqSGHICEQ3ha9Tn8OOA
 2DUiuRUklzua8xCUCTHabzW2rHWmgygMer.njMEM0XGJiJCv2xu1Gk4bGVeUMKjl1HZHmQKdHV8n
 GkEG_MgMxaG.xMEkRhLSqO_28gTaIFZKlMiAN3scx17fb0SdOdcLDZhdJdc3Kk3Bnc3G8rDU7nIp
 ADFg07tTvLQNY0yltbeL4z3CHuvkwll.PxVgeIILA04F6SWlpbut2AusV8FAsrmBme1BWYY9k0C6
 oSHJbs_9yCruxaJFEj2FeYDy3wGaIzDTFf7A3Dkh7_0h5yjQZ1HuDcolHwbmpaqPP4L9PvAj5R9C
 3sxTwvvgnJn9RVm.94Kk_x0buHoHRCRTpb4JXUl4XRC0YJlcMfye578Lx3iAvA3oBW9669NukMen
 PGE.Ux6LY.xeiZEsHC3w.ksgonwifqRYyLE7q6b_ZkxP25lC13_qmiunJ7_heLiIZ4J18ypj0G7g
 qjWf1qwR5vDOfIwdknAtg7M1.XB1cToN5_xcJbdj6hj_Kkslt_aTqFypXXkFnPPs9hl1eU_RKVHW
 fzlIQxppZowEimbYrICnBRufXG0H0LwtxlWBJm_DSg2FpDJzHWvmWwZY.cDzHLinpSyJ6B4exL2A
 sZZ4J.9M.D9d_Vfp1VQPap7wvex4tayRHojSaqvFlS3BaFliWov5opfj.SUs5F8uFrEtnNYAV5az
 D6iW0JouAwomqojqf1pboe2Y_lwbNka6jYoNhLeIbIuG738216TYYGZ5C08c1tMzFGZf4SeN4Cz4
 1xJqj6AtzfW1Z.YLu2hO5csv6l6htE8rRPDFY6OW_tFVn8b3buKytBlqTsonMYfPn0vfvFknPzPN
 Yxhq856diZVtFaK24_.vboWDLMQPT1lb3WnbKi95iZjdxlUujhldx0vVaR5pTK5.MD_vHChrqVjU
 dswcX0DwXlBePynynT0oi11vtH8ngBZNStMCkxdN9MdF_14kBx0Rf1jYI0jvzgaVWmRrqAUl2o9Y
 72iuHcT7WivrSqECM1CiFKOafVIM0Frs.PajSHzOV6_Ieje25Xont6EVVyF20gaaZI_tnA0wZE5n
 _0MAL4zkvUnWFXWI7DdV5FoDmegYaL4XG9gItQqDDuGlD1VaOuN4aNiQ4SEHXfh494xi_dFsO1yw
 lMWP9tqmTqRNb6_0ltFBW7Jy2icRKBZptm8WEqgQ6ZULriR.OMTopWcv7eSwxMLHlJRteLt5tqxb
 zCAZEia8QfTdCTajnJur.Y.Ii0IoAk1ElTH8vX4CbNsDH2tGvq2hdHo8svA1VNetiYC0DkTK2Bt6
 ZOPhlWpMCa71y7lUc1O8mK2ilDQ8wZiWrd4C2KIwG_lWFLMZEpF3.lPbaIGDQavCX2zaUrYmCrmp
 wDLAhV0edd_Cznmo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Oct 2020 12:33:55 +0000
Received: by smtp421.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e8c15fd5307494bdc630f772ae42f868;
          Fri, 30 Oct 2020 12:33:51 +0000 (UTC)
To:     Hou Tao <houtao1@huawei.com>, Chen Jun <chenjun102@huawei.com>,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        rui.xiang@huawei.com, guohanjun@huawei.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20201028020615.8789-1-chenjun102@huawei.com>
 <c2eba2fb-79f8-eb48-ddd1-77fbc205ebff@schaufler-ca.com>
 <c9e1646e-f242-4d76-f482-f6281585860e@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC PATCH v2] selinux: Fix kmemleak after disabling selinux
 runtime
Message-ID: <70f2c67a-eb8a-5c28-9f78-838b397370b3@schaufler-ca.com>
Date:   Fri, 30 Oct 2020 05:33:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <c9e1646e-f242-4d76-f482-f6281585860e@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16944 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/30/2020 12:57 AM, Hou Tao wrote:
> Hi,
>
> On 2020/10/29 0:29, Casey Schaufler wrote:
>> On 10/27/2020 7:06 PM, Chen Jun wrote:
>>> From: Chen Jun <c00424029@huawei.com>
>>>
>>> Kmemleak will report a problem after using
>>> "echo 1 > /sys/fs/selinux/disable" to disable selinux on runtime.
>> Runtime disable of SELinux has been deprecated. It would be
>> wasteful to make these changes in support of a facility that
>> is going away.
>>
> But this sysfs file will still be present and workable on LTS kernel ve=
rsions, so
> is the proposed fixe OK for these LTS kernel versions ?

It's not my call to make. Paul Moore has the voice that matters here.
I think that the trivial memory leak here is inconsequential compared
to the overhead you're introducing by leaving the NO_DEL hooks enabled.

>
> Regards,
> Tao
>
>
>>> kmemleak report=EF=BC=9A
>>> unreferenced object 0xffff901281c208a0 (size 96):
>>>   comm "swapper/0", pid 1, jiffies 4294668265 (age 692.799s)
>>>   hex dump (first 32 bytes):
>>>     00 40 c8 81 12 90 ff ff 03 00 00 00 05 00 00 00  .@..............=

>>>     03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................=

>>>   backtrace:
>>>     [<0000000014622ef8>] selinux_sb_alloc_security+0x1b/0xa0
>>>     [<00000000044914e1>] security_sb_alloc+0x1d/0x30
>>>     [<000000009f9d5ffd>] alloc_super+0xa7/0x310
>>>     [<000000003c5f0b5b>] sget_fc+0xca/0x230
>>>     [<00000000367a9996>] vfs_get_super+0x37/0x110
>>>     [<000000001c47e818>] vfs_get_tree+0x20/0xc0
>>>     [<00000000d239b404>] fc_mount+0x9/0x30
>>>     [<00000000708a102f>] vfs_kern_mount.part.36+0x6a/0x80
>>>     [<000000005db542fe>] kern_mount+0x1b/0x30
>>>     [<0000000051919f9f>] init_sel_fs+0x8b/0x119
>>>     [<000000000f328fe0>] do_one_initcall+0x3f/0x1d0
>>>     [<000000008a6ceb81>] kernel_init_freeable+0x1b4/0x1f2
>>>     [<000000003a425dcd>] kernel_init+0x5/0x110
>>>     [<000000004e8d6c9d>] ret_from_fork+0x22/0x30
>>>
>>> "echo 1 > /sys/fs/selinux/disable" will delete the hooks.
>>> Any memory alloced by calling HOOKFUNCTION (like call_int_hook(sb_all=
oc_security, 0, sb))
>>> has no chance to be freed after deleting hooks.
>>>
>>> Add a flag to mark a hook not be delete when deleting hooks.
>>>
>>> Signed-off-by: Chen Jun <chenjun102@huawei.com>
>>> ---
>>>  include/linux/lsm_hooks.h |  6 +++++-
>>>  security/selinux/hooks.c  | 20 ++++++++++----------
>>>  2 files changed, 15 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index c503f7ab8afb..85de731b0c74 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -1554,6 +1554,7 @@ struct security_hook_list {
>>>  	struct hlist_head		*head;
>>>  	union security_list_options	hook;
>>>  	char				*lsm;
>>> +	bool				no_del;
>>>  } __randomize_layout;
>>> =20
>>>  /*
>>> @@ -1582,6 +1583,8 @@ struct lsm_blob_sizes {
>>>   */
>>>  #define LSM_HOOK_INIT(HEAD, HOOK) \
>>>  	{ .head =3D &security_hook_heads.HEAD, .hook =3D { .HEAD =3D HOOK }=
 }
>>> +#define LSM_HOOK_INIT_NO_DEL(HEAD, HOOK) \
>>> +	{ .head =3D &security_hook_heads.HEAD, .hook =3D { .HEAD =3D HOOK }=
, .no_del =3D 1 }
>>> =20
>>>  extern struct security_hook_heads security_hook_heads;
>>>  extern char *lsm_names;
>>> @@ -1638,7 +1641,8 @@ static inline void security_delete_hooks(struct=
 security_hook_list *hooks,
>>>  	int i;
>>> =20
>>>  	for (i =3D 0; i < count; i++)
>>> -		hlist_del_rcu(&hooks[i].list);
>>> +		if (!hooks[i].no_del)
>>> +			hlist_del_rcu(&hooks[i].list);
>>>  }
>>>  #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
>>> =20
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 6b1826fc3658..daff084fd1c7 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -6974,8 +6974,8 @@ static struct security_hook_list selinux_hooks[=
] __lsm_ro_after_init =3D {
>>>  	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds)=
,
>>>  	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
>>> =20
>>> -	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
>>> -	LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
>>> +	LSM_HOOK_INIT_NO_DEL(sb_free_security, selinux_sb_free_security),
>>> +	LSM_HOOK_INIT_NO_DEL(sb_free_mnt_opts, selinux_free_mnt_opts),
>>>  	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
>>>  	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
>>>  	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
>>> @@ -7081,7 +7081,7 @@ static struct security_hook_list selinux_hooks[=
] __lsm_ro_after_init =3D {
>>> =20
>>>  	LSM_HOOK_INIT(ismaclabel, selinux_ismaclabel),
>>>  	LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
>>> -	LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
>>> +	LSM_HOOK_INIT_NO_DEL(release_secctx, selinux_release_secctx),
>>>  	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_sec=
ctx),
>>>  	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
>>>  	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
>>> @@ -7107,7 +7107,7 @@ static struct security_hook_list selinux_hooks[=
] __lsm_ro_after_init =3D {
>>>  	LSM_HOOK_INIT(socket_getpeersec_stream,
>>>  			selinux_socket_getpeersec_stream),
>>>  	LSM_HOOK_INIT(socket_getpeersec_dgram, selinux_socket_getpeersec_dg=
ram),
>>> -	LSM_HOOK_INIT(sk_free_security, selinux_sk_free_security),
>>> +	LSM_HOOK_INIT_NO_DEL(sk_free_security, selinux_sk_free_security),
>>>  	LSM_HOOK_INIT(sk_clone_security, selinux_sk_clone_security),
>>>  	LSM_HOOK_INIT(sk_getsecid, selinux_sk_getsecid),
>>>  	LSM_HOOK_INIT(sock_graft, selinux_sock_graft),
>>> @@ -7121,7 +7121,7 @@ static struct security_hook_list selinux_hooks[=
] __lsm_ro_after_init =3D {
>>>  	LSM_HOOK_INIT(secmark_refcount_inc, selinux_secmark_refcount_inc),
>>>  	LSM_HOOK_INIT(secmark_refcount_dec, selinux_secmark_refcount_dec),
>>>  	LSM_HOOK_INIT(req_classify_flow, selinux_req_classify_flow),
>>> -	LSM_HOOK_INIT(tun_dev_free_security, selinux_tun_dev_free_security)=
,
>>> +	LSM_HOOK_INIT_NO_DEL(tun_dev_free_security, selinux_tun_dev_free_se=
curity),
>>>  	LSM_HOOK_INIT(tun_dev_create, selinux_tun_dev_create),
>>>  	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
>>>  	LSM_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
>>> @@ -7130,7 +7130,7 @@ static struct security_hook_list selinux_hooks[=
] __lsm_ro_after_init =3D {
>>>  	LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
>>>  	LSM_HOOK_INIT(ib_endport_manage_subnet,
>>>  		      selinux_ib_endport_manage_subnet),
>>> -	LSM_HOOK_INIT(ib_free_security, selinux_ib_free_security),
>>> +	LSM_HOOK_INIT_NO_DEL(ib_free_security, selinux_ib_free_security),
>>>  #endif
>>>  #ifdef CONFIG_SECURITY_NETWORK_XFRM
>>>  	LSM_HOOK_INIT(xfrm_policy_free_security, selinux_xfrm_policy_free),=

>>> @@ -7144,7 +7144,7 @@ static struct security_hook_list selinux_hooks[=
] __lsm_ro_after_init =3D {
>>>  #endif
>>> =20
>>>  #ifdef CONFIG_KEYS
>>> -	LSM_HOOK_INIT(key_free, selinux_key_free),
>>> +	LSM_HOOK_INIT_NO_DEL(key_free, selinux_key_free),
>>>  	LSM_HOOK_INIT(key_permission, selinux_key_permission),
>>>  	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
>>>  #ifdef CONFIG_KEY_NOTIFICATIONS
>>> @@ -7162,13 +7162,13 @@ static struct security_hook_list selinux_hook=
s[] __lsm_ro_after_init =3D {
>>>  	LSM_HOOK_INIT(bpf, selinux_bpf),
>>>  	LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
>>>  	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
>>> -	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
>>> -	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
>>> +	LSM_HOOK_INIT_NO_DEL(bpf_map_free_security, selinux_bpf_map_free),
>>> +	LSM_HOOK_INIT_NO_DEL(bpf_prog_free_security, selinux_bpf_prog_free)=
,
>>>  #endif
>>> =20
>>>  #ifdef CONFIG_PERF_EVENTS
>>>  	LSM_HOOK_INIT(perf_event_open, selinux_perf_event_open),
>>> -	LSM_HOOK_INIT(perf_event_free, selinux_perf_event_free),
>>> +	LSM_HOOK_INIT_NO_DEL(perf_event_free, selinux_perf_event_free),
>>>  	LSM_HOOK_INIT(perf_event_read, selinux_perf_event_read),
>>>  	LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
>>>  #endif
>> .
>>

