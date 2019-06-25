Return-Path: <SRS0=B9fV=UY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E64C4646C
	for <selinux@archiver.kernel.org>; Tue, 25 Jun 2019 01:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB7B20644
	for <selinux@archiver.kernel.org>; Tue, 25 Jun 2019 01:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oOBkx4TY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfFYBBM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jun 2019 21:01:12 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:44778
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729261AbfFYBBL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jun 2019 21:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561424468; bh=sjwUFRLvFIb9goh4G4DHNE4250lyrd2QyVe4lhJFtyk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=oOBkx4TYZ0eRb7c0KIECWEuz+kAqUCK8wa51zGv6VOYmAhp0EubqbBmnNmMeC0fDAruh1SRwoHVxUHNJo3QDYuV6Xo3RzhpWOX+KEhZwSCDTOBlxiWT2jwTKRhX0SCv27+IVmTRQwpLJjJKX1fJUvhKAuBg6ovWEbsuit1bvVtrfxEXGFd87D42jLPJcauioUHdOnrDLR7yHKjDp924CYhKzWNmyy+0g0XL5dZsjTu9KYpp5aNghopB7i4X5xSwctL++TrlNrJSkv874OkCMHpHaF1ZtQMJ/WFrj0bitWtaS4+WP/WwtkqB4X5hYVOqL6VKLzMVG5Yh34lO3ARmWSw==
X-YMail-OSG: Bct65z0VM1lRlT3BptmtrbIpMBzoRuA9xZc9X2nD4kKH03pmeoWoHP6GTOEF1zI
 FO68w2UaNAEeZCJ4G8QYYfPFXo5qKrUnMW0juX89g5mcZUht5u4IWriE8KJCBPvpcx9V8LX6PRrn
 wVZXwUdbuuROPWmxkkaFvsh8LiXTe8x_.g3BPYPvHvOMnxrRQybF4PfE2h08SolAHGuiIT7IhnXl
 fvb19Ayn5fgNr5Ipe4zBpp5K0BanBOGM_AWDgyAoGmVmpVeKubViltte1MxeUHF4GQugfKqyRMJy
 li4KyramviC2kqPdsJ8FGBQ9YakqxiRfY_htK4x2TQKrP_urL4pMzRCxUhIY6W6SE7KAKZ5slqoa
 6V.RL9xwX79R3N3o.eA.AcCE1WW6I3BtPu2xZaM8jd2x302qYjzriT29DNCMq2yvgcXAobyDCGfS
 ewvOYu5bOiGyjFWCkPE4c78bzbRCkq2cZdDwCVlOxhTsVjA2r819oA2q0FMNCa0KQgiiZ0PlP3st
 Po0NPbuBPC4dWBzco9DAQfUGm4jKz_TM9k_CYZ2b0DKizQbF2vX67MVrZTcsVbPRAc5Wj.UpC.Yv
 _PHVKL489wZX7EMX.ixZ9_9GgNHFf3GLIXRZxGG.l1pv2EPlcFLs_QoGmXc7qImdWsF7lpCx6s9T
 UPms_JJRza.CKPgQ1B8e3c0o56LCjAKlQW28nrhCg9Crd2EBybz1VLjyeLwbJtESYODz67QEOM_D
 7ZbTUvf6oUS2fMV1CxNoOVVoeBBYaSyw78_IAiGDAWGoLYkCCYZMZ5GYzHnn6PAsRoElmK.GXDhB
 nJ6x9n2BUgpFqduqelcLtDKyJ66ZATAwsDfxL6g5ZrQfllzmZF5_nwYh87bZK8UtQ697G9A5BgnM
 t6hgh0SMpJt1V2Vvn5YmDfCkHjnX9abxiclTEA2xbEzq1LElpWqluFLQnz9hxvOeUEEdNeY2h5vV
 95bHnqqe4AV91c8uH5NeVXPfdPdO_JnCHyO.I6LKpO2lZA4fdjkkwic4tTxuUsoxJsH5B0RrEBBt
 eIyonj9yJqMt3ZU0dLuWb1A9L3d9id6vFj3xc8eZmWSufxgL7UdRdWFe8plwhpVrCNHh9eW3sYxq
 MXn7Zdx_yiod16ZCO55NTK8mBN.OfiFQ1yFiECW9_7_N7bj3qHYTSsK05YtkTrOBFu6KCiq9UGT6
 svPLZun4tukAKQ_RSyoUbYsC0Vu6.HHgnaol6.nxWUYkKAYHf8lwypWLtE5T_2VJIYvjZ4OcdNs0
 NFg4PLC2WncGFp7ZgnPQrn6Xi.oO4l2g__cyGIn24DE1n
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Jun 2019 01:01:08 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp412.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d5df0f7eb2ec9ba5918f0e7ccd202bb4;
          Tue, 25 Jun 2019 01:01:06 +0000 (UTC)
Subject: Re: [PATCH v3 21/24] Audit: Store LSM audit information in an lsmblob
To:     John Johansen <john.johansen@canonical.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov,
        Eric Paris <eparis@redhat.com>, casey@schaufler-ca.com
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-22-casey@schaufler-ca.com>
 <79cd4a92-c221-eda4-58ba-730b5c2680d7@canonical.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <0ad8f906-16ff-61af-ce7c-0ea1e9760d03@schaufler-ca.com>
Date:   Mon, 24 Jun 2019 18:01:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <79cd4a92-c221-eda4-58ba-730b5c2680d7@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/24/2019 2:33 PM, John Johansen wrote:
> On 6/21/19 11:52 AM, Casey Schaufler wrote:
>> Change the audit code to store full lsmblob data instead of
>> a single u32 secid. This allows for multiple security modules
>> to use the audit system at the same time. It also allows the
>> removal of scaffolding code that was included during the
>> revision of LSM interfaces.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> I know Kees raised this too, but I haven't seen a reply
>
> Eric (Paul is already CCed): I have directly added you because of
> the question below.
>
> In summary there isn't necessarily a single secid any more, and
> we need to know whether dropping the logging of the secid or
> logging all secids is the correct action.

It is to be considered that this is an error case. If
everything is working normally you should have produced
a secctx previously, which you'll have included in the
audit record. Including the secid in the record ought to
be pointless, as the secid is strictly an internal token
with no meaning outside the running kernel. You are providing
no security relevant information by providing the secid.
I will grant the possibility that the secid might be useful
in debugging, but for that a pr_warn is more appropriate
than a field in the audit record.

>
>> ---
>>  kernel/audit.h   |  6 +++---
>>  kernel/auditsc.c | 38 +++++++++++---------------------------
>>  2 files changed, 14 insertions(+), 30 deletions(-)
>>
>> diff --git a/kernel/audit.h b/kernel/audit.h
>> index 29e29c6f4afb..a8dd479e9556 100644
>> --- a/kernel/audit.h
>> +++ b/kernel/audit.h
>> @@ -91,7 +91,7 @@ struct audit_names {
>>  	kuid_t			uid;
>>  	kgid_t			gid;
>>  	dev_t			rdev;
>> -	u32			osid;
>> +	struct lsmblob		olsm;
>>  	struct audit_cap_data	fcap;
>>  	unsigned int		fcap_ver;
>>  	unsigned char		type;		/* record type */
>> @@ -148,7 +148,7 @@ struct audit_context {
>>  	kuid_t		    target_auid;
>>  	kuid_t		    target_uid;
>>  	unsigned int	    target_sessionid;
>> -	struct lsmblob   target_lsm;
>> +	struct lsmblob	    target_lsm;
>>  	char		    target_comm[TASK_COMM_LEN];
>> =20
>>  	struct audit_tree_refs *trees, *first_trees;
>> @@ -165,7 +165,7 @@ struct audit_context {
>>  			kuid_t			uid;
>>  			kgid_t			gid;
>>  			umode_t			mode;
>> -			u32			osid;
>> +			struct lsmblob		olsm;
>>  			int			has_perm;
>>  			uid_t			perm_uid;
>>  			gid_t			perm_gid;
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index 0478680cd0a8..d3ad13f11788 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -646,17 +646,15 @@ static int audit_filter_rules(struct task_struct=
 *tsk,
>>  			if (f->lsm_rule) {
>>  				/* Find files that match */
>>  				if (name) {
>> -					lsmblob_init(&blob, name->osid);
>>  					result =3D security_audit_rule_match(
>> -								&blob,
>> +								&name->olsm,
>>  								f->type,
>>  								f->op,
>>  								f->lsm_rule);
>>  				} else if (ctx) {
>>  					list_for_each_entry(n, &ctx->names_list, list) {
>> -						lsmblob_init(&blob, n->osid);
>>  						if (security_audit_rule_match(
>> -								&blob,
>> +								&n->olsm,
>>  								f->type,
>>  								f->op,
>>  								f->lsm_rule)) {
>> @@ -668,8 +666,7 @@ static int audit_filter_rules(struct task_struct *=
tsk,
>>  				/* Find ipc objects that match */
>>  				if (!ctx || ctx->type !=3D AUDIT_IPC)
>>  					break;
>> -				lsmblob_init(&blob, ctx->ipc.osid);
>> -				if (security_audit_rule_match(&blob,
>> +				if (security_audit_rule_match(&ctx->ipc.olsm,
>>  							      f->type, f->op,
>>  							      f->lsm_rule))
>>  					++result;
>> @@ -1187,21 +1184,18 @@ static void show_special(struct audit_context =
*context, int *call_panic)
>>  				context->socketcall.args[i]);
>>  		break; }
>>  	case AUDIT_IPC: {
>> -		u32 osid =3D context->ipc.osid;
>> +		struct lsmblob *olsm =3D &context->ipc.olsm;
>> =20
>>  		audit_log_format(ab, "ouid=3D%u ogid=3D%u mode=3D%#ho",
>>  				 from_kuid(&init_user_ns, context->ipc.uid),
>>  				 from_kgid(&init_user_ns, context->ipc.gid),
>>  				 context->ipc.mode);
>> -		if (osid) {
>> +		if (lsmblob_is_set(olsm)) {
>>  			struct lsmcontext lsmcxt;
>> -			struct lsmblob blob;
>> =20
>> -			lsmblob_init(&blob, osid);
>> -			if (security_secid_to_secctx(&blob, &lsmcxt)) {
>> -				audit_log_format(ab, " osid=3D%u", osid);
> I am not comfortable just dropping this I would think logging all secid=
s is the
> correct action here.
>
>
>> +			if (security_secid_to_secctx(olsm, &lsmcxt))
>>  				*call_panic =3D 1;
>> -			} else {
>> +			else {
>>  				audit_log_format(ab, " obj=3D%s", lsmcxt.context);
>>  				security_release_secctx(&lsmcxt);
>>  			}
>> @@ -1346,13 +1340,10 @@ static void audit_log_name(struct audit_contex=
t *context, struct audit_names *n,
>>  				 from_kgid(&init_user_ns, n->gid),
>>  				 MAJOR(n->rdev),
>>  				 MINOR(n->rdev));
>> -	if (n->osid !=3D 0) {
>> -		struct lsmblob blob;
>> +	if (lsmblob_is_set(&n->olsm)) {
>>  		struct lsmcontext lsmctx;
>> =20
>> -		lsmblob_init(&blob, n->osid);
>> -		if (security_secid_to_secctx(&blob, &lsmctx)) {
>> -			audit_log_format(ab, " osid=3D%u", n->osid);
> and here
>
>
>> +		if (security_secid_to_secctx(&n->olsm, &lsmctx)) {
>>  			if (call_panic)
>>  				*call_panic =3D 2;
>>  		} else {
>> @@ -1906,17 +1897,13 @@ static inline int audit_copy_fcaps(struct audi=
t_names *name,
>>  void audit_copy_inode(struct audit_names *name, const struct dentry *=
dentry,
>>  		      struct inode *inode, unsigned int flags)
>>  {
>> -	struct lsmblob blob;
>> -
>>  	name->ino   =3D inode->i_ino;
>>  	name->dev   =3D inode->i_sb->s_dev;
>>  	name->mode  =3D inode->i_mode;
>>  	name->uid   =3D inode->i_uid;
>>  	name->gid   =3D inode->i_gid;
>>  	name->rdev  =3D inode->i_rdev;
>> -	security_inode_getsecid(inode, &blob);
>> -	/* scaffolding until osid is updated */
>> -	name->osid =3D blob.secid[0];
>> +	security_inode_getsecid(inode, &name->olsm);
>>  	if (flags & AUDIT_INODE_NOEVAL) {
>>  		name->fcap_ver =3D -1;
>>  		return;
>> @@ -2266,14 +2253,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct=
 mq_attr *mqstat)
>>  void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
>>  {
>>  	struct audit_context *context =3D audit_context();
>> -	struct lsmblob blob;
>>  	context->ipc.uid =3D ipcp->uid;
>>  	context->ipc.gid =3D ipcp->gid;
>>  	context->ipc.mode =3D ipcp->mode;
>>  	context->ipc.has_perm =3D 0;
>> -	security_ipc_getsecid(ipcp, &blob);
>> -	/* scaffolding on the [0] - change "osid" to a lsmblob */
>> -	context->ipc.osid =3D blob.secid[0];
>> +	security_ipc_getsecid(ipcp, &context->ipc.olsm);
>>  	context->type =3D AUDIT_IPC;
>>  }
>> =20
>>

