Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DDCC31E5E
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 17:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065ED2084E
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 17:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XxnoMzew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfFSRKZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:10:25 -0400
Received: from sonic311-30.consmr.mail.gq1.yahoo.com ([98.137.65.211]:43625
        "EHLO sonic311-30.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbfFSRKY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 13:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560964221; bh=S8B4SkRVGpCsKYyjAUx4FvByk74Zgxgg/Mm6/wNy72Q=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=XxnoMzewunix9CTkYJL2cKFCmIiYJcYpUlH5eh+GHseD9fF992GzW61u5HTHYgo1YHKi1/TZp0NNxwRqNc8uWlS5IMpAL9eV7hPZxmF43UKoMz5JuS2wPlKSOKXgiy2nY1kLS0enXa6/cYJAlOH01apzp5MFrPWJzy3zpVWi2hR5B63RCnstCOWzdUTrGNzHatOKAp3512tyAsrBdN+/TIaBVd0DD+UpxMh4EWSNFrNtJhP6dEIDEMV4A89OkZFfp2rqoJDB/xL6kob74LYHd2jpYY8+pds97175/THYmMl/lXwo1eclir27HWQX7tvLkpftit8MMB6F2QJ841TWlQ==
X-YMail-OSG: gXF0riUVM1kYGVxY.IiVkkTrqSh19UUwLEhnZcE8__cKRjSPOuzN.Pr6PJsvXI3
 EOLa56swExgiUrhCh992kLz2YeYW5XhXXFXeS02vEJ0.UYKDTFppzGZ.MLw05aLFTeUjmtEN.x0_
 09XEMm3ddA7eyEaiXNGx1nan47de5s3f_9kZGRLS2Hh2cb9amMRSRMXLAr5TH7p6Ap4iZeX5QX.F
 pLskYVsOV9PFuEAg6ygc0Cub_jOkN6PrUtBrr9o.2IfUpwmAzpYJ0ExbnEV0YNIBKXZ3EDumKqNh
 D1fd28HaeahALCjFTNs8TsUdwxjmCZngZam9JGI4plagMhrQ9Ckig9kitL6ZgNRiWney4cTyrRgk
 cwA.WazeeNSxBPbcHA.1tj8vOMU5r29VAP6q52gMROOyAg4EfnYme44DhWIBro.fh5mDcskOkNjU
 hjrQGr.bVb9ou7RUaXHw9_sHncPbaQTVxXWYPorqx8z.WkYBore5QE.wuod7LpfK4RdL9x_ldHJF
 HriVIwfHDtcMtdcM0i8ynloGtC4yOcF6f7bkat7BmN3Non7nyjVIWIYGWEm6ehc0k39SD0YXul3b
 9Jk3WVX0NXwufSIWxO7_mRb_1FAX69DZBy5S5rq9mBb.bIvhXeGGMXJi7mb0ijSgyc5U_dvSi3Lv
 nnpZkjjbZZ1wL.DRqWBZt7n5hjmtqXoCqrjCY0uClqDrvjV4t_5DBdLVkWjtyHAMLKBUMyvXL09h
 BB9kZ1knx_VqUAlBoY0v9OBivJKTQcbfV_NtbUfkJUzYjd_XWzem0gcioCeiLQQAA1CnNl4gnVLc
 fVa8zqeM1OZ.k4I32X8MaqNzDNk0rEVUWY7OkGKCEKOXDtKUudUnlWxOay5hQGBz9leLXAOmYpaz
 j550rlY0z7gy2Gh0TZEMlI0Ikd.HNShOeaOy6pUMXJ2dyFtVsNHHD0jZAMdcsy8dgS9emAruKvWK
 RGq_AyIqzsX7CYzyB8WSQIuzPmjRgpU6X_1wQKMVU7OEmotREW5xzJTQSSOlBvvnVvF38aYRf_Ju
 bmDDt93qcSHd4odgHdF0KQ1Th4hLIyFgTpykIIEMpdon1VBdDKO06wgVwu5ViPZKuld8RmUkM3H.
 8aqsdWuuqmBViGjV6mupQ5.dalvml0GzBqiQpk3zRPKRYvbMaRCIRCsNSxFR_XzroQB5jlQ5kmL4
 x0BHv2PYPK5_9xHAnB9098LUOWx1HtgX4F_EQ6lYWszAg0OpvadRcsGTHLZcKeCWssgE60eAcjgp
 OedUkMICjdfx_Cl6deG9M8Y1NRH4d.ZMwK_XC
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Jun 2019 17:10:21 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp432.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9365e37c7721ad4736f39722b53d8d89;
          Wed, 19 Jun 2019 17:10:20 +0000 (UTC)
Subject: Re: [PATCH v2 16/25] LSM: Ensure the correct LSM context releaser
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-17-casey@schaufler-ca.com>
 <201906182231.349D240@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <dd8a9580-a737-d72b-098a-e1e8ebe32deb@schaufler-ca.com>
Date:   Wed, 19 Jun 2019 10:10:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <201906182231.349D240@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/18/2019 10:34 PM, Kees Cook wrote:
> On Tue, Jun 18, 2019 at 04:05:42PM -0700, Casey Schaufler wrote:
>> Add a new lsmcontext data structure to hold all the information
>> about a "security context", including the string, its size and
>> which LSM allocated the string. The allocation information is
>> necessary because LSMs have different policies regarding the
>> lifecycle of these strings. SELinux allocates and destroys
>> them on each use, whereas Smack provides a pointer to an entry
>> in a list that never goes away.
>>
>> Change the security_release_secctx() interface to use the
>> lsmcontext and call only the appropiate LSM hook. Change
>> the callers of security_release_secctx() to provide the
>> correct type of data, introducing scaffolding where required.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  drivers/android/binder.c                | 10 +++++--
>>  fs/kernfs/dir.c                         |  9 ++++--
>>  fs/kernfs/inode.c                       |  7 +++--
>>  fs/nfs/nfs4proc.c                       |  8 ++++--
>>  fs/nfsd/nfs4xdr.c                       |  7 +++--
>>  include/linux/security.h                | 37 +++++++++++++++++++++++-=
-
>>  include/net/scm.h                       |  4 ++-
>>  kernel/audit.c                          | 14 +++++++---
>>  kernel/auditsc.c                        | 12 ++++++--
>>  net/ipv4/ip_sockglue.c                  |  4 ++-
>>  net/netfilter/nf_conntrack_netlink.c    |  4 ++-
>>  net/netfilter/nf_conntrack_standalone.c |  4 ++-
>>  net/netfilter/nfnetlink_queue.c         | 13 ++++++---
>>  net/netlabel/netlabel_unlabeled.c       | 19 ++++++++++---
>>  net/netlabel/netlabel_user.c            |  4 ++-
>>  security/security.c                     | 12 +++++---
>>  security/smack/smack_lsm.c              | 14 +++++++---
>>  17 files changed, 140 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
>> index 9eb790200fba..f11b5ca5bc30 100644
>> --- a/drivers/android/binder.c
>> +++ b/drivers/android/binder.c
>> @@ -2876,6 +2876,7 @@ static void binder_transaction(struct binder_pro=
c *proc,
>>  	int t_debug_id =3D atomic_inc_return(&binder_last_id);
>>  	char *secctx =3D NULL;
>>  	u32 secctx_sz =3D 0;
>> +	struct lsmcontext scaff; /* scaffolding */
>> =20
>>  	e =3D binder_transaction_log_add(&binder_transaction_log);
>>  	e->debug_id =3D t_debug_id;
>> @@ -3158,7 +3159,8 @@ static void binder_transaction(struct binder_pro=
c *proc,
>>  		binder_alloc_copy_to_buffer(&target_proc->alloc,
>>  					    t->buffer, buf_offset,
>>  					    secctx, secctx_sz);
>> -		security_release_secctx(secctx, secctx_sz);
>> +		lsmcontext_init(&scaff, secctx, secctx_sz, 0);
>> +		security_release_secctx(&scaff);
>>  		secctx =3D NULL;
>>  	}
>>  	t->buffer->debug_id =3D t->debug_id;
>> @@ -3479,8 +3481,10 @@ static void binder_transaction(struct binder_pr=
oc *proc,
>>  	t->buffer->transaction =3D NULL;
>>  	binder_alloc_free_buf(&target_proc->alloc, t->buffer);
>>  err_binder_alloc_buf_failed:
>> -	if (secctx)
>> -		security_release_secctx(secctx, secctx_sz);
>> +	if (secctx) {
>> +		lsmcontext_init(&scaff, secctx, secctx_sz, 0);
>> +		security_release_secctx(&scaff);
>> +	}
>>  err_get_secctx_failed:
>>  	kfree(tcomplete);
>>  	binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
>> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
>> index b84d635567d3..92afad387237 100644
>> --- a/fs/kernfs/dir.c
>> +++ b/fs/kernfs/dir.c
>> @@ -532,9 +532,12 @@ void kernfs_put(struct kernfs_node *kn)
>>  	kfree_const(kn->name);
>> =20
>>  	if (kn->iattr) {
>> -		if (kn->iattr->ia_secdata)
>> -			security_release_secctx(kn->iattr->ia_secdata,
>> -						kn->iattr->ia_secdata_len);
>> +		struct lsmcontext scaff; /* scaffolding */
>> +		if (kn->iattr->ia_secdata) {
>> +			lsmcontext_init(&scaff, kn->iattr->ia_secdata,
>> +					kn->iattr->ia_secdata_len, 0);
>> +			security_release_secctx(&scaff);
>> +		}
>>  		simple_xattrs_free(&kn->iattr->xattrs);
>>  		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
>>  	}
>> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
>> index 0c1fd945ce42..02cde9dac5ee 100644
>> --- a/fs/kernfs/inode.c
>> +++ b/fs/kernfs/inode.c
>> @@ -349,6 +349,7 @@ static int kernfs_security_xattr_set(const struct =
xattr_handler *handler,
>>  {
>>  	struct kernfs_node *kn =3D inode->i_private;
>>  	struct kernfs_iattrs *attrs;
>> +	struct lsmcontext context;
>>  	void *secdata;
>>  	u32 secdata_len =3D 0;
>>  	int error;
>> @@ -368,8 +369,10 @@ static int kernfs_security_xattr_set(const struct=
 xattr_handler *handler,
>>  	error =3D kernfs_node_setsecdata(attrs, &secdata, &secdata_len);
>>  	mutex_unlock(&kernfs_mutex);
>> =20
>> -	if (secdata)
>> -		security_release_secctx(secdata, secdata_len);
>> +	if (secdata) {
>> +		lsmcontext_init(&context, secdata, secdata_len, 0);
>> +		security_release_secctx(&context);
>> +	}
>>  	return error;
>>  }
>> =20
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 4dbb0ee23432..af1c0db29c39 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -131,8 +131,12 @@ nfs4_label_init_security(struct inode *dir, struc=
t dentry *dentry,
>>  static inline void
>>  nfs4_label_release_security(struct nfs4_label *label)
>>  {
>> -	if (label)
>> -		security_release_secctx(label->label, label->len);
>> +	struct lsmcontext scaff; /* scaffolding */
>> +
>> +	if (label) {
>> +		lsmcontext_init(&scaff, label->label, label->len, 0);
>> +		security_release_secctx(&scaff);
>> +	}
>>  }
>>  static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs=
4_label *label)
>>  {
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 3de42a729093..bb3db033e144 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -2420,6 +2420,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struc=
t svc_fh *fhp,
>>  	__be32 status;
>>  	int err;
>>  	struct nfs4_acl *acl =3D NULL;
>> +	struct lsmcontext scaff; /* scaffolding */
>>  	void *context =3D NULL;
>>  	int contextlen;
>>  	bool contextsupport =3D false;
>> @@ -2919,8 +2920,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, stru=
ct svc_fh *fhp,
>> =20
>>  out:
>>  #ifdef CONFIG_NFSD_V4_SECURITY_LABEL
>> -	if (context)
>> -		security_release_secctx(context, contextlen);
>> +	if (context) {
>> +		lsmcontext_init(&scaff, context, contextlen, 0); /*scaffolding*/
>> +		security_release_secctx(&scaff);
>> +	}
>>  #endif /* CONFIG_NFSD_V4_SECURITY_LABEL */
>>  	kfree(acl);
>>  	if (tempfh) {
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 07a239292e02..8bd4f28ef532 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -76,6 +76,39 @@ enum lsm_event {
>>  	LSM_POLICY_CHANGE,
>>  };
>> =20
>> +/*
>> + * A "security context" is the text representation of
>> + * the information used by LSMs.
>> + * This structure contains the string, its length, and which LSM
>> + * it is useful for.
>> + */
>> +struct lsmcontext {
>> +	char	*context;	/* Provided by the module */
>> +	u32	len;
>> +	int	slot;		/* Identifies the module */
>> +};
>> +
>> +/**
>> + * lsmcontext_init - initialize an lsmcontext structure.
>> + * @cp: Pointer to the context to initialize
>> + * @context: Initial context, or NULL
>> + * @size: Size of context, or 0
>> + * @slot: Which LSM provided the context
>> + *
>> + * Fill in the lsmcontext from the provided information.
>> + */
>> +static inline void lsmcontext_init(struct lsmcontext *cp, char *conte=
xt,
>> +				   u32 size, int slot)
>> +{
>> +	cp->slot =3D slot;
>> +	cp->context =3D context;
>> +
>> +	if (context =3D=3D NULL || size =3D=3D 0)
>> +		cp->len =3D 0;
>> +	else
>> +		cp->len =3D strlen(context);
>> +}
> I worry about the use of the "size" argument (or rather, lack of use).
> If all contexts are going to be NUL-terminated strings, there should be=

> no "size" arg. If not, then "size" (or strneln(context, size)) should
> be used instead of strlen().

Once the scaffolding uses go away this is only ever called once,
with lsmcontext_init(cp, NULL, 0, 0) in security_release_secctx().
It probably makes the most sense to identify this as "for scaffolding"
and delete it when it is no longer needed.

>> +
>>  /*
>>   * Data exported by the security modules
>>   */
>> @@ -445,7 +478,7 @@ int security_ismaclabel(const char *name);
>>  int security_secid_to_secctx(struct lsmblob *l, char **secdata, u32 *=
seclen);
>>  int security_secctx_to_secid(const char *secdata, u32 seclen,
>>  			     struct lsmblob *l);
>> -void security_release_secctx(char *secdata, u32 seclen);
>> +void security_release_secctx(struct lsmcontext *cp);
>> =20
>>  void security_inode_invalidate_secctx(struct inode *inode);
>>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 c=
txlen);
>> @@ -1236,7 +1269,7 @@ static inline int security_secctx_to_secid(const=
 char *secdata,
>>  	return -EOPNOTSUPP;
>>  }
>> =20
>> -static inline void security_release_secctx(char *secdata, u32 seclen)=

>> +static inline void security_release_secctx(struct lsmcontext *cp)
>>  {
>>  }
>> =20
>> diff --git a/include/net/scm.h b/include/net/scm.h
>> index bcb0f8560cdf..d3e0ac961a11 100644
>> --- a/include/net/scm.h
>> +++ b/include/net/scm.h
>> @@ -92,6 +92,7 @@ static __inline__ int scm_send(struct socket *sock, =
struct msghdr *msg,
>>  #ifdef CONFIG_SECURITY_NETWORK
>>  static inline void scm_passec(struct socket *sock, struct msghdr *msg=
, struct scm_cookie *scm)
>>  {
>> +	struct lsmcontext context;
>>  	char *secdata;
>>  	u32 seclen;
>>  	int err;
>> @@ -101,7 +102,8 @@ static inline void scm_passec(struct socket *sock,=
 struct msghdr *msg, struct sc
>> =20
>>  		if (!err) {
>>  			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
>> -			security_release_secctx(secdata, seclen);
>> +			lsmcontext_init(&context, secdata, seclen, 0);/*scaffolding*/
>> +			security_release_secctx(&context);
>>  		}
>>  	}
>>  }
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index a52f8772477f..0467b2d284fa 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -1193,6 +1193,7 @@ static int audit_receive_msg(struct sk_buff *skb=
, struct nlmsghdr *nlh)
>>  	struct audit_sig_info   *sig_data;
>>  	char			*ctx =3D NULL;
>>  	u32			len;
>> +	struct lsmcontext	scaff; /* scaffolding */
>> =20
>>  	err =3D audit_netlink_ok(skb, msg_type);
>>  	if (err)
>> @@ -1437,15 +1438,18 @@ static int audit_receive_msg(struct sk_buff *s=
kb, struct nlmsghdr *nlh)
>>  		}
>>  		sig_data =3D kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
>>  		if (!sig_data) {
>> -			if (lsmblob_is_set(&audit_sig_lsm))
>> -				security_release_secctx(ctx, len);
>> +			if (lsmblob_is_set(&audit_sig_lsm)) {
>> +				lsmcontext_init(&scaff, ctx, len, 0);
>> +				security_release_secctx(&scaff);
>> +			}
>>  			return -ENOMEM;
>>  		}
>>  		sig_data->uid =3D from_kuid(&init_user_ns, audit_sig_uid);
>>  		sig_data->pid =3D audit_sig_pid;
>>  		if (lsmblob_is_set(&audit_sig_lsm)) {
>>  			memcpy(sig_data->ctx, ctx, len);
>> -			security_release_secctx(ctx, len);
>> +			lsmcontext_init(&scaff, ctx, len, 0);
>> +			security_release_secctx(&scaff);
>>  		}
>>  		audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
>>  				 sig_data, sizeof(*sig_data) + len);
>> @@ -2074,6 +2078,7 @@ int audit_log_task_context(struct audit_buffer *=
ab)
>>  	unsigned len;
>>  	int error;
>>  	struct lsmblob le;
>> +	struct lsmcontext scaff; /* scaffolding */
>> =20
>>  	security_task_getsecid(current, &le);
>>  	if (!lsmblob_is_set(&le))
>> @@ -2087,7 +2092,8 @@ int audit_log_task_context(struct audit_buffer *=
ab)
>>  	}
>> =20
>>  	audit_log_format(ab, " subj=3D%s", ctx);
>> -	security_release_secctx(ctx, len);
>> +	lsmcontext_init(&scaff, ctx, len, 0);
>> +	security_release_secctx(&scaff);
>>  	return 0;
>> =20
>>  error_path:
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index ebdd7eab9247..917e7550767a 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -942,6 +942,7 @@ static int audit_log_pid_context(struct audit_cont=
ext *context, pid_t pid,
>>  				 struct lsmblob *l, char *comm)
>>  {
>>  	struct audit_buffer *ab;
>> +	struct lsmcontext lsmcxt;
>>  	char *ctx =3D NULL;
>>  	u32 len;
>>  	int rc =3D 0;
>> @@ -959,7 +960,8 @@ static int audit_log_pid_context(struct audit_cont=
ext *context, pid_t pid,
>>  			rc =3D 1;
>>  		} else {
>>  			audit_log_format(ab, " obj=3D%s", ctx);
>> -			security_release_secctx(ctx, len);
>> +			lsmcontext_init(&lsmcxt, ctx, len, 0); /*scaffolding*/
>> +			security_release_secctx(&lsmcxt);
>>  		}
>>  	}
>>  	audit_log_format(ab, " ocomm=3D");
>> @@ -1171,6 +1173,7 @@ static void audit_log_fcaps(struct audit_buffer =
*ab, struct audit_names *name)
>> =20
>>  static void show_special(struct audit_context *context, int *call_pan=
ic)
>>  {
>> +	struct lsmcontext lsmcxt;
>>  	struct audit_buffer *ab;
>>  	int i;
>> =20
>> @@ -1203,7 +1206,8 @@ static void show_special(struct audit_context *c=
ontext, int *call_panic)
>>  				*call_panic =3D 1;
>>  			} else {
>>  				audit_log_format(ab, " obj=3D%s", ctx);
>> -				security_release_secctx(ctx, len);
>> +				lsmcontext_init(&lsmcxt, ctx, len, 0);
>> +				security_release_secctx(&lsmcxt);
>>  			}
>>  		}
>>  		if (context->ipc.has_perm) {
>> @@ -1350,6 +1354,7 @@ static void audit_log_name(struct audit_context =
*context, struct audit_names *n,
>>  		char *ctx =3D NULL;
>>  		u32 len;
>>  		struct lsmblob le;
>> +		struct lsmcontext lsmcxt;
>> =20
>>  		lsmblob_init(&le, n->osid);
>>  		if (security_secid_to_secctx(&le, &ctx, &len)) {
>> @@ -1358,7 +1363,8 @@ static void audit_log_name(struct audit_context =
*context, struct audit_names *n,
>>  				*call_panic =3D 2;
>>  		} else {
>>  			audit_log_format(ab, " obj=3D%s", ctx);
>> -			security_release_secctx(ctx, len);
>> +			lsmcontext_init(&lsmcxt, ctx, len, 0); /* scaffolding */
>> +			security_release_secctx(&lsmcxt);
>>  		}
>>  	}
>> =20
>> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
>> index e05f4ef68bd8..7834c357b60b 100644
>> --- a/net/ipv4/ip_sockglue.c
>> +++ b/net/ipv4/ip_sockglue.c
>> @@ -130,6 +130,7 @@ static void ip_cmsg_recv_checksum(struct msghdr *m=
sg, struct sk_buff *skb,
>> =20
>>  static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff =
*skb)
>>  {
>> +	struct lsmcontext context;
>>  	struct lsmblob lb;
>>  	char *secdata;
>>  	u32 seclen;
>> @@ -144,7 +145,8 @@ static void ip_cmsg_recv_security(struct msghdr *m=
sg, struct sk_buff *skb)
>>  		return;
>> =20
>>  	put_cmsg(msg, SOL_IP, SCM_SECURITY, seclen, secdata);
>> -	security_release_secctx(secdata, seclen);
>> +	lsmcontext_init(&context, secdata, seclen, 0); /* scaffolding */
>> +	security_release_secctx(&context);
>>  }
>> =20
>>  static void ip_cmsg_recv_dstaddr(struct msghdr *msg, struct sk_buff *=
skb)
>> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_c=
onntrack_netlink.c
>> index 6098b586da07..93f308b5845d 100644
>> --- a/net/netfilter/nf_conntrack_netlink.c
>> +++ b/net/netfilter/nf_conntrack_netlink.c
>> @@ -331,6 +331,7 @@ static int ctnetlink_dump_secctx(struct sk_buff *s=
kb, const struct nf_conn *ct)
>>  	int len, ret;
>>  	char *secctx;
>>  	struct lsmblob le;
>> +	struct lsmcontext context;
>> =20
>>  	lsmblob_init(&le, ct->secmark);
>>  	ret =3D security_secid_to_secctx(&le, &secctx, &len);
>> @@ -348,7 +349,8 @@ static int ctnetlink_dump_secctx(struct sk_buff *s=
kb, const struct nf_conn *ct)
>> =20
>>  	ret =3D 0;
>>  nla_put_failure:
>> -	security_release_secctx(secctx, len);
>> +	lsmcontext_init(&context, secctx, len, 0); /* scaffolding */
>> +	security_release_secctx(&context);
>>  	return ret;
>>  }
>>  #else
>> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/n=
f_conntrack_standalone.c
>> index 6e6fb1f9f6ba..0bde6a4426e3 100644
>> --- a/net/netfilter/nf_conntrack_standalone.c
>> +++ b/net/netfilter/nf_conntrack_standalone.c
>> @@ -176,6 +176,7 @@ static void ct_show_secctx(struct seq_file *s, con=
st struct nf_conn *ct)
>>  	u32 len;
>>  	char *secctx;
>>  	struct lsmblob le;
>> +	struct lsmcontext context;
>> =20
>>  	lsmblob_init(&le, ct->secmark);
>>  	ret =3D security_secid_to_secctx(&le, &secctx, &len);
>> @@ -184,7 +185,8 @@ static void ct_show_secctx(struct seq_file *s, con=
st struct nf_conn *ct)
>> =20
>>  	seq_printf(s, "secctx=3D%s ", secctx);
>> =20
>> -	security_release_secctx(secctx, len);
>> +	lsmcontext_init(&context, secctx, len, 0); /* scaffolding */
>> +	security_release_secctx(&context);
>>  }
>>  #else
>>  static inline void ct_show_secctx(struct seq_file *s, const struct nf=
_conn *ct)
>> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink=
_queue.c
>> index 105018d19318..ba767bdd1a9a 100644
>> --- a/net/netfilter/nfnetlink_queue.c
>> +++ b/net/netfilter/nfnetlink_queue.c
>> @@ -399,6 +399,7 @@ nfqnl_build_packet_message(struct net *net, struct=
 nfqnl_instance *queue,
>>  	enum ip_conntrack_info uninitialized_var(ctinfo);
>>  	struct nfnl_ct_hook *nfnl_ct;
>>  	bool csum_verify;
>> +	struct lsmcontext scaff; /* scaffolding */
>>  	char *secdata =3D NULL;
>>  	u32 seclen =3D 0;
>> =20
>> @@ -629,8 +630,10 @@ nfqnl_build_packet_message(struct net *net, struc=
t nfqnl_instance *queue,
>>  	}
>> =20
>>  	nlh->nlmsg_len =3D skb->len;
>> -	if (seclen)
>> -		security_release_secctx(secdata, seclen);
>> +	if (seclen) {
>> +		lsmcontext_init(&scaff, secdata, seclen, 0);
>> +		security_release_secctx(&scaff);
>> +	}
>>  	return skb;
>> =20
>>  nla_put_failure:
>> @@ -638,8 +641,10 @@ nfqnl_build_packet_message(struct net *net, struc=
t nfqnl_instance *queue,
>>  	kfree_skb(skb);
>>  	net_err_ratelimited("nf_queue: error creating packet message\n");
>>  nlmsg_failure:
>> -	if (seclen)
>> -		security_release_secctx(secdata, seclen);
>> +	if (seclen) {
>> +		lsmcontext_init(&scaff, secdata, seclen, 0);
>> +		security_release_secctx(&scaff);
>> +	}
>>  	return NULL;
>>  }
>> =20
>> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel=
_unlabeled.c
>> index 57e0f81a2ec5..2f8c7415b6ff 100644
>> --- a/net/netlabel/netlabel_unlabeled.c
>> +++ b/net/netlabel/netlabel_unlabeled.c
>> @@ -387,6 +387,7 @@ int netlbl_unlhsh_add(struct net *net,
>>  	struct net_device *dev;
>>  	struct netlbl_unlhsh_iface *iface;
>>  	struct audit_buffer *audit_buf =3D NULL;
>> +	struct lsmcontext context;
>>  	char *secctx =3D NULL;
>>  	u32 secctx_len;
>>  	struct lsmblob le;
>> @@ -457,7 +458,9 @@ int netlbl_unlhsh_add(struct net *net,
>>  					     &secctx,
>>  					     &secctx_len) =3D=3D 0) {
>>  			audit_log_format(audit_buf, " sec_obj=3D%s", secctx);
>> -			security_release_secctx(secctx, secctx_len);
>> +			/* scaffolding */
>> +			lsmcontext_init(&context, secctx, secctx_len, 0);
>> +			security_release_secctx(&context);
>>  		}
>>  		audit_log_format(audit_buf, " res=3D%u", ret_val =3D=3D 0 ? 1 : 0);=

>>  		audit_log_end(audit_buf);
>> @@ -488,6 +491,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *=
net,
>>  	struct netlbl_unlhsh_addr4 *entry;
>>  	struct audit_buffer *audit_buf;
>>  	struct net_device *dev;
>> +	struct lsmcontext context;
>>  	char *secctx;
>>  	u32 secctx_len;
>>  	struct lsmblob le;
>> @@ -516,7 +520,9 @@ static int netlbl_unlhsh_remove_addr4(struct net *=
net,
>>  		    security_secid_to_secctx(&le,
>>  					     &secctx, &secctx_len) =3D=3D 0) {
>>  			audit_log_format(audit_buf, " sec_obj=3D%s", secctx);
>> -			security_release_secctx(secctx, secctx_len);
>> +			/* scaffolding */
>> +			lsmcontext_init(&context, secctx, secctx_len, 0);
>> +			security_release_secctx(&context);
>>  		}
>>  		audit_log_format(audit_buf, " res=3D%u", entry !=3D NULL ? 1 : 0);
>>  		audit_log_end(audit_buf);
>> @@ -553,6 +559,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *=
net,
>>  	struct netlbl_unlhsh_addr6 *entry;
>>  	struct audit_buffer *audit_buf;
>>  	struct net_device *dev;
>> +	struct lsmcontext context;
>>  	char *secctx;
>>  	u32 secctx_len;
>>  	struct lsmblob le;
>> @@ -580,7 +587,8 @@ static int netlbl_unlhsh_remove_addr6(struct net *=
net,
>>  		    security_secid_to_secctx(&le,
>>  					     &secctx, &secctx_len) =3D=3D 0) {
>>  			audit_log_format(audit_buf, " sec_obj=3D%s", secctx);
>> -			security_release_secctx(secctx, secctx_len);
>> +			lsmcontext_init(&context, secctx, secctx_len, 0);
>> +			security_release_secctx(&context);
>>  		}
>>  		audit_log_format(audit_buf, " res=3D%u", entry !=3D NULL ? 1 : 0);
>>  		audit_log_end(audit_buf);
>> @@ -1094,6 +1102,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd=
,
>>  	int ret_val =3D -ENOMEM;
>>  	struct netlbl_unlhsh_walk_arg *cb_arg =3D arg;
>>  	struct net_device *dev;
>> +	struct lsmcontext context;
>>  	void *data;
>>  	u32 secid;
>>  	char *secctx;
>> @@ -1161,7 +1170,9 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd=
,
>>  			  NLBL_UNLABEL_A_SECCTX,
>>  			  secctx_len,
>>  			  secctx);
>> -	security_release_secctx(secctx, secctx_len);
>> +	/* scaffolding */
>> +	lsmcontext_init(&context, secctx, secctx_len, 0);
>> +	security_release_secctx(&context);
>>  	if (ret_val !=3D 0)
>>  		goto list_cb_failure;
>> =20
>> diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user=
=2Ec
>> index 4145adf55a22..fba861c4ffbb 100644
>> --- a/net/netlabel/netlabel_user.c
>> +++ b/net/netlabel/netlabel_user.c
>> @@ -98,6 +98,7 @@ struct audit_buffer *netlbl_audit_start_common(int t=
ype,
>>  					       struct netlbl_audit *audit_info)
>>  {
>>  	struct audit_buffer *audit_buf;
>> +	struct lsmcontext context;
>>  	char *secctx;
>>  	u32 secctx_len;
>>  	struct lsmblob le;
>> @@ -117,7 +118,8 @@ struct audit_buffer *netlbl_audit_start_common(int=
 type,
>>  	if (audit_info->secid !=3D 0 &&
>>  	    security_secid_to_secctx(&le, &secctx, &secctx_len) =3D=3D 0) {
>>  		audit_log_format(audit_buf, " subj=3D%s", secctx);
>> -		security_release_secctx(secctx, secctx_len);
>> +		lsmcontext_init(&context, secctx, secctx_len, 0);/*scaffolding*/
>> +		security_release_secctx(&context);
>>  	}
>> =20
>>  	return audit_buf;
>> diff --git a/security/security.c b/security/security.c
>> index 9cfdc664239e..d25c099b46d1 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -458,6 +458,7 @@ void __init security_add_hooks(struct security_hoo=
k_list *hooks, int count,
>>  			&security_hook_heads.socket_getpeersec_dgram ||
>>  		    hooks[i].head =3D=3D &security_hook_heads.secctx_to_secid ||
>>  		    hooks[i].head =3D=3D &security_hook_heads.secid_to_secctx ||
>> +		    hooks[i].head =3D=3D &security_hook_heads.release_secctx ||
>>  		    hooks[i].head =3D=3D &security_hook_heads.ipc_getsecid ||
>>  		    hooks[i].head =3D=3D &security_hook_heads.task_getsecid ||
>>  		    hooks[i].head =3D=3D &security_hook_heads.inode_getsecid ||
>> @@ -2083,16 +2084,19 @@ int security_secctx_to_secid(const char *secda=
ta, u32 seclen, struct lsmblob *l)
>>  }
>>  EXPORT_SYMBOL(security_secctx_to_secid);
>> =20
>> -void security_release_secctx(char *secdata, u32 seclen)
>> +void security_release_secctx(struct lsmcontext *cp)
>>  {
>> -	int *display =3D current->security;
>>  	struct security_hook_list *hp;
>> =20
>>  	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
>> -		if (*display =3D=3D LSMDATA_INVALID || *display =3D=3D hp->slot) {
>> -			hp->hook.release_secctx(secdata, seclen);
>> +		if (cp->slot =3D=3D hp->slot) {
>> +			hp->hook.release_secctx(cp->context, cp->len);
>> +			lsmcontext_init(cp, NULL, 0, 0);
>>  			return;
>>  		}
>> +
>> +	pr_warn("%s context \"%s\" from slot %d not released\n", __func__,
>> +		cp->context, cp->slot);
>>  }
>>  EXPORT_SYMBOL(security_release_secctx);
>> =20
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index e9560b078efe..3834b751d1e9 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -4439,11 +4439,16 @@ static int smack_secctx_to_secid(const char *s=
ecdata, u32 seclen, u32 *secid)
>>  	return 0;
>>  }
>> =20
>> -/*
>> - * There used to be a smack_release_secctx hook
>> - * that did nothing back when hooks were in a vector.
>> - * Now that there's a list such a hook adds cost.
>> +/**
>> + * smack_release_secctx - do everything necessary to free a context
>> + * @secdata: Unused
>> + * @seclen: Unused
>> + *
>> + * Do nothing but hold a slot in the hooks list.
>>   */
>> +static void smack_release_secctx(char *secdata, u32 seclen)
>> +{
>> +}
>> =20
>>  static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u=
32 ctxlen)
>>  {
>> @@ -4683,6 +4688,7 @@ static struct security_hook_list smack_hooks[] _=
_lsm_ro_after_init =3D {
>>  	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
>>  	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
>>  	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
>> +	LSM_HOOK_INIT(release_secctx, smack_release_secctx),
>>  	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
>>  	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
>>  	LSM_HOOK_INIT(inode_getsecctx, smack_inode_getsecctx),
>> --=20
>> 2.20.1
>>

