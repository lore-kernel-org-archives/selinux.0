Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12D7C31E5D
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 17:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30D92084A
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 17:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dmj52hL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfFSRbw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:31:52 -0400
Received: from sonic308-13.consmr.mail.gq1.yahoo.com ([98.137.68.37]:40739
        "EHLO sonic308-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfFSRbv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 13:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560965509; bh=9yZe32GSiXisJrVfbFFg/wa1vZVy2hoNv0lRbiWuUW0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=dmj52hL3pkYeEYVJI/m7Obf0W3LywOPeSPTI0TQsCJCwqvNcQIaD7KiFfKSnr5OZhn5RlX4+m+/ZTHyg2MQpwOonSIv3mLkeUsmHOmaopDjIaPD0HS1Z6iaK8upB02Ue2t2XMI3pNj02xyY7bY6esa0B0l7h4EqKd47wjiR4nBHJBjlFFBpTP8hDBIm0K5aR9HKSvul7klQqCgVQfMZ1rZCZopQzay77OOrq9yUKQmLDBpGX2f0WBYXldVEDP9mCkpaX5NFRftLpvZATsiEVecVHGkYD1pj8zeBZ3jzRBohIZnC1qwDHwNAxBddEKvUDU9al4nrK8kNeMFA9mId9eg==
X-YMail-OSG: NjvuWOcVM1nZ68bMN0aa4UPOLmx8J1Y6n6KoGqz64e1ZlymfXDFcUiX0pgIuphd
 brZnyweRC5U68x7OtDXPXlvQetY_Ih_o0g4GqkQuT9.8kYPdGG1Y_AeoMYZGEav1Tg5FWAH5W2_I
 Otnw8NzD.PZZwFvoCOCMft8YFZM33lng5ZILQB.7GE8iXfQzS_tmNVwPZl5OH4kTdW.nU0cQ8n1.
 jcPKTYADUxJ84FDukbEdScXUt_7U0lv3Baa21jvlcXAj.v7nYeFlNyqTH_UI55AkM8_ZV5fY65Ki
 1Mwq00Tka2fTQ.Mt0NJZj3UhqNm9wxCggMDU9ddi7waufTCsArjtQhMduvfY9M3OB2VlNrVVcSwk
 PJ6TZWEurJZ_tWk3.O09gg2KclPXUHLG_twFnB9v_CaHf2k1IJJk.wR.GaYRTaTtQMygp5T23iWY
 0s7CBbhwxSAVZxWRCdRr0Z.tyKxIVEULmQyU7jQd9ZqPS.DfIgYIi8KppDhxbCA6YeSKLSjN9UKY
 fdhAeGb1VBROAEXEPD2MdMyFDoeSBUS7PoHFRgwdmJDzv2HmHaPTbnCt7nm6BYTb.5VZM_QJY1st
 ptfrHbZTwbistZdJ30_QujoMMyBk_HFplzsy7trb8MBbIKbuhUmoRQkc7A5e62fU_EmvpCMw0dvM
 DYp2NLwMWOXzsNX.tEgz.dErQ2DYpZKZKAH0lKtZdUkRWlfSZ3ZR0UhVt7Ir5pqfjmWst_QDWPjk
 1QdTX2UkrQCC7EHW4Aqbn2cd6dE.RrWhAeuQhjhofQSVDmTnov3HPlnTFcmgDrvyp0n1v4RUQO1t
 huQJCU6A0WEFOYteIVZ8Z_A.Dcngr3zQbzbFTLdZhzWinZenNPLjxBkB166fI0l06Btc.1frwWWC
 8JlXm9uO78fCL1qAePq_jYN5YZjwu_wnLH4O0iDwy9ApT6wkSqCjiLstc3FvU3HKAGUxy4lF96nc
 ynGxFqHAFXUxAINcUA_rw_vrwenj0QGA9kSj4hmPDzYM4LzLik.rBnmE6.8kzOCDN1T5ka2OXHFu
 Px2sqD5IfYlAWRA.9uq9Xxytzg5v9_MT0jBpgy1URDNpLcw7ziW.T7bbMiEipYNpBSFAko3mmCYp
 YbV7KOkiRMGxTEchXnyGRIQNvsscaHpLF.uL1t.gzuUWpJitJ7.u.KD0qByuJaV5adZjjMuMShJD
 q0p86nhLnbuu1xCsQGYx3S1vbI3WKn6fWFZ5L__RvI6uDNPOk0AO8rSbmQ2PrXgxvb0buUP3oY_h
 uePMMZ.iFnh9Rq9SNhrLsz9NzpAKilXqy4w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Jun 2019 17:31:49 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp407.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e6051dc983f6cf6f1ed8c55383c365f3;
          Wed, 19 Jun 2019 17:31:46 +0000 (UTC)
Subject: Re: [PATCH v2 18/25] LSM: Use lsmcontext in
 security_dentry_init_security
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-19-casey@schaufler-ca.com>
 <201906182238.4EBF8C17DB@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <063644f9-be64-175e-0bf2-cfa1afadc3d7@schaufler-ca.com>
Date:   Wed, 19 Jun 2019 10:31:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <201906182238.4EBF8C17DB@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/18/2019 10:41 PM, Kees Cook wrote:
> On Tue, Jun 18, 2019 at 04:05:44PM -0700, Casey Schaufler wrote:
>> Chance the security_dentry_init_security() interface to

Note to self: s/Chance/Change/

>> fill an lsmcontext structure instead of a void * data area
>> and a length. The lone caller of this interface is NFS4,
>> which may make copies of the data using its own mechanisms.
>> A rework of the nfs4 code to use the lsmcontext properly
>> is a significant project, so the coward's way out is taken,
>> and the lsmcontext data from security_dentry_init_security()
>> is copied, then released directly.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  fs/nfs/nfs4proc.c        | 26 ++++++++++++++++----------
>>  include/linux/security.h |  7 +++----
>>  security/security.c      | 20 ++++++++++++++++----
>>  3 files changed, 35 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index af1c0db29c39..952f805965bb 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -113,6 +113,7 @@ static inline struct nfs4_label *
>>  nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>>  	struct iattr *sattr, struct nfs4_label *label)
>>  {
>> +	struct lsmcontext context;
>>  	int err;
>> =20
>>  	if (label =3D=3D NULL)
>> @@ -122,21 +123,26 @@ nfs4_label_init_security(struct inode *dir, stru=
ct dentry *dentry,
>>  		return NULL;
>> =20
>>  	err =3D security_dentry_init_security(dentry, sattr->ia_mode,
>> -				&dentry->d_name, (void **)&label->label, &label->len);
>> -	if (err =3D=3D 0)
>> -		return label;
>> +					    &dentry->d_name, &context);
>> +
>> +	if (err)
>> +		return NULL;
>> +
>> +	label->label =3D kmemdup(context.context, context.len, GFP_KERNEL);
> I think this is wrong: for NUL-terminated strings, "context.len" isn't
> currently including the NUL byte (it's set to strlen()).
>
> So, if kmemdup() is used here, it means strlen() isn't correct in the
> context init helper, it should be using the "size" argument, etc.

Would all be true if the context where being set by lsmcontext_init,
but it's not. It's coming from the dentry_init_security hook, and
the one instance of that, selinux_dentry_init_security() sets the
size to strlen() + 1. The kmemdup() will include the terminating NUL.

I too wish that the hooks and their use where more consistent.
My sincere hope is that this revision of the infrastructure will
help that to some extent.

>> +	if (label->label =3D=3D NULL)
>> +		label =3D NULL;
>> +	else
>> +		label->len =3D context.len;
>> +
>> +	security_release_secctx(&context);
>> +
>> +	return label;
>> =20
>> -	return NULL;
>>  }
>>  static inline void
>>  nfs4_label_release_security(struct nfs4_label *label)
>>  {
>> -	struct lsmcontext scaff; /* scaffolding */
>> -
>> -	if (label) {
>> -		lsmcontext_init(&scaff, label->label, label->len, 0);
>> -		security_release_secctx(&scaff);
>> -	}
>> +	kfree(label->label);
> Should label be set to NULL here and len reduced to 0?

It wasn't before, and I'd hate to make too many assumptions
about what might be fragile in the NFS code.

>>  }
>>  static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs=
4_label *label)
>>  {
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 1fd87e80656f..92c4960dd57f 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -346,8 +346,8 @@ int security_sb_clone_mnt_opts(const struct super_=
block *oldsb,
>>  int security_add_mnt_opt(const char *option, const char *val,
>>  				int len, void **mnt_opts);
>>  int security_dentry_init_security(struct dentry *dentry, int mode,
>> -					const struct qstr *name, void **ctx,
>> -					u32 *ctxlen);
>> +					const struct qstr *name,
>> +					struct lsmcontext *ctx);
>>  int security_dentry_create_files_as(struct dentry *dentry, int mode,
>>  					struct qstr *name,
>>  					const struct cred *old,
>> @@ -718,8 +718,7 @@ static inline void security_inode_free(struct inod=
e *inode)
>>  static inline int security_dentry_init_security(struct dentry *dentry=
,
>>  						 int mode,
>>  						 const struct qstr *name,
>> -						 void **ctx,
>> -						 u32 *ctxlen)
>> +						 struct lsmcontext *ctx)
>>  {
>>  	return -EOPNOTSUPP;
>>  }
>> diff --git a/security/security.c b/security/security.c
>> index 2ea810fc4a45..23d8049ec0c1 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -453,6 +453,8 @@ void __init security_add_hooks(struct security_hoo=
k_list *hooks, int count,
>>  		 * secid in the lsmblob structure.
>>  		 */
>>  		if (hooks[i].head =3D=3D &security_hook_heads.audit_rule_match ||
>> +		    hooks[i].head =3D=3D
>> +			&security_hook_heads.dentry_init_security ||
>>  		    hooks[i].head =3D=3D &security_hook_heads.kernel_act_as ||
>>  		    hooks[i].head =3D=3D
>>  			&security_hook_heads.socket_getpeersec_dgram ||
>> @@ -1030,11 +1032,21 @@ void security_inode_free(struct inode *inode)
>>  }
>> =20
>>  int security_dentry_init_security(struct dentry *dentry, int mode,
>> -					const struct qstr *name, void **ctx,
>> -					u32 *ctxlen)
>> +				  const struct qstr *name,
>> +				  struct lsmcontext *cp)
>>  {
>> -	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode=
,
>> -				name, ctx, ctxlen);
>> +	int *display =3D current->security;
>> +	struct security_hook_list *hp;
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
>> +			     list)
>> +		if (*display =3D=3D 0 || *display =3D=3D hp->slot) {
>> +			cp->slot =3D hp->slot;
>> +			return hp->hook.dentry_init_security(dentry, mode,
>> +					name, (void **)&cp->context, &cp->len);
>> +		}
>> +
>> +	return -EOPNOTSUPP;
>>  }
>>  EXPORT_SYMBOL(security_dentry_init_security);
>> =20
>> --=20
>> 2.20.1
>>

