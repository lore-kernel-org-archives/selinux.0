Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE525219F9
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629677; cv=none; b=QfoLtJiMgBmU1+N6/AlQEPpmXs1NAnxde2JwxXiVnDn+EZ67LLiAgYJj/GC8MR7Brl/srHGZ7PoF20SCMo+HkyHaPGk7tZBZXYON7zf6IkzPoekuaoO2rs8sv8W3yG0RhM7RqFfPmsZaFrD1mJTR2xPE47FkdFtBAod4qYuAvVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629677; c=relaxed/simple;
	bh=waiAxW+dKpwpKtM18batcOROvx/ysIw8Y9+0N5xC0Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T/5boK5l8RSRJJjCcXwSdclvD9gYeZA5HYUq1nDROJBKWFFWNL+gNq2EYOAIurUZAtp/wJpZLZlLeshha8YIKykfpD2HsjtMRVGwqO+7mY/6HdjOrJd+VpNv87RpuJR8gOqF1rJ4cZwYPlvByZHYeOVnkTf5+Z2D34cehmW+NhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=pDuh3OZD; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pDuh3OZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720629666; bh=2OijOwd35xgJveaDQP8zv24F/srwv/q2RYqa2egsL2c=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=pDuh3OZDvtwyoELdJ87vc1XFkqwJfkA3KyPRzQGeNvAmNVYwmvLu+QETrCfYtXH2vGgpRPHzMf5o2M2tmmLN9J2ClW6sZf6L4FroNrUpTIT5ap3v6iWYP+xpiGVvVXQKapMDrQBLeUgKPRTvPkD4jLEJ2+6gxB7160MNkNyQZwdUeSxqlgfG0gIgKYKA4X7O2w06PkFkH6vvXErz3F1YUBuFf2Ig9j5aMEotltn74zsa9R0g1vX4bhm9u3hsCgt4Y0kgBHaiNBIqm6ZHl/m02Hbr97wAksNNN6ehNMu+WTrnYOT6VWN9J7WutTbeRO5c7UMUO0952bFTuuKPzhZACw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720629666; bh=F7kwkmeSWBR9otZkRoL4iw7dJ/xKfE+uFhKmBrPO2kM=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=oPBUGC21UPoRFnQuAEJTcQF741IkFZZOZH5bk/7ep5ilQeG8xTAH6M/D+iPfIZPzKdL6WvGSvks+KbOz78TUwfOfEBWTJbxYx3nIpwG37E9Iu/5hS3oG0vW4NSQRMNNAVMbRpzi3jKU0noToly1oa7QvinnciGuq8nDvuXypkhmBHtxKWO9TIq3HEB+9Ucdy1Z5R7Bkkhakpmxki/TWm0jtTayIuYaHgr2ZK1V7Hss4Qc+T5ZRHeO3gKTibGtHgLBYL9EN81o5ZvLlmnCWulKZ7KYVjfIrV926jBM3aaDYNbP+g7wpqCiVUc/rfgXet6blSbiqYHadSb46wz7rKTOA==
X-YMail-OSG: f0jPSosVM1n127NKIAELG2N7PDDab6NPAdcT30tjX8EckingrBBXpi.HXUliN9q
 Ei3OXSSJp0qKtwIFLbEhh9VT.EJz1BEfy0PL4PXCirqtENhWfFAFbb.VFXerYsdvRJT0hP89.eaJ
 dVwynwxrLhllD4CbLpC_60cRSv3LKBQPdw9nTxWhaZ_NqmTebX2QLumMgZyrGJYdCGJNqOZ1wZrR
 gaOY02kNVN1_0gsI_2GqozNreIzJQrwBrfGDhyAGyBR4UJ4uEJ4S2z4nIynw02PkW0eV4iug4oVv
 iKT3OZKqXlEAR31S1momwhunPvdQBbwJbn7kRo7lMLd6icAFw9oTjQc_glWfey3dtFb3OMF2Bc7M
 fKtg_.Vuha8hAgjJtiCPv4dhl3DeXDutQhx4WZaws88AWmaYAWNChVvFom_7NJLu7P0_XvAh5eX7
 DkGcXiHPLyMcY6Sf4KalI_RTI3.BdDt3IkeoVI1Rt7u6RwBXSetVOv9epkbOfq52fh7v.YZmMLlU
 ugs5oVGMG2z9mBwLb1k6irKJPuRP0FcHAM909_YzkE7eBhZuhuJG2HHipVl6KiW4yr3naBnK17JX
 wDe07iNeNM0Iu45saogEXRQJMvN6lnEVqWx1Wxp8ER5n13wPEpeFI139fLXBOGi31kKsb.yt02fF
 rWXaSUrVvvq4vGOAgkVXraMnwj3jt4j8f.gxQ42lnEe1hUuYkY1K6A3P65l1.pnGPEQaUIyHxd4m
 gjT14mnJyRGKnBAh9JbSRNVeiFG9KwD1OPjPLYmYHgFkRPB2jOguBeNdCipyt3pZI1BIm_lZBWDl
 2DpxipBMYogzUF5X6kfVhmayVNtIV6FXKN5TW_Hek9o_RBO8J0HHHNncirOJ8QJTHBUefEGFWVcf
 GS6Kh9b_RGaQWzTgvrB36znIp8MiwKG_UKUuc5OYSPvj6PzGjhLRhmerQdvxyRHzSwihRxq3fczy
 zrAYjzK3aTZ.Yj1rIsbVmROD6wW0JFcml1uWG7XPV9Ct4T4THlpfd.i.PQmjZSWLB_XBkKk38k8d
 SHZ.y_2ZhlSVw1LWMJ6Uz4VtWSr01J3v_Bb778zhwqhvxdfmQiFIzgbR0gHWwA2QVuo8iJ9NAoz5
 RHpxfDI8CDCvs6kU_WIbUMcPhYyLXFk5Gn2zQ7SdgsZsdz5u3m4ZE6km4RuCnvUdasVnximidZ29
 kEWQ6I8yIFpFUfAJgA67tiTdPMMo7T0GrikS2Yn91cVqMEAhw_1kObjIX1eIcXYOmSo3J5mwVHNg
 IrjhP7hxrQYw80GrdS3HBzORhQsV2X2c0g8hzTScyrVMFHiCEQoRJOqsOIGmon2l6GEL9OSBD4ho
 EDgjts7Z6_o9pGTZC466.ZMVJGnRHwdBMzBEzC46iJCWHIF2PoB_5k9rU3DHTMNuKsN6QmBkDJfz
 QImHuGjjyCgRSYnjSOZyBVUg7HhMLiXBd5x91wu706M3vNWW0bV6Q7nMO59BjF1y1j_ilSMZLtaZ
 qszdCE8aqFk2Jmva3q6o.CTr.vV.Gm56AMBa9U_6XqppblByZktUBq1PRosP4AiEEX0mNYn33iGO
 VdjUuh9gfyKnsAmrnbk_rfmUaLgrNWaaNuY.cMVUFnXCyvjOYZy96lklOcSWUKbf7uBSDv64o70r
 JY07ReeVyGih6md.apRYCkeX7XZ0_eQDh1cuDQNmbZg5uStPpqfJz_SrNksOr1QBOTljXm_6KwXN
 e1AEY9s94QODtDBvJH61wAGgt_JW23AgGArbINSF5KjGm.5AObQmHZdz.jUAbbAxFia.v6.Cv.xB
 tTUvnXk9ABvSzOKpQTNO6S50ts4hgNTiyWIIFrp4yc96ToTfYeKDiUUp_GXFIivSRO3pai5_GPRu
 _ZxUTJKKXyLsktdLKEFBx8bm_tbrJXBdglqUxjd8gtUhnun2JMIMYGtFOOz.PDWEuN0mkhqOnbWI
 GXmKbTa_uT_dWls5BmEqEEULYXe8T6bY6LARI2IkxBvT5.q3KEl9jYdtZCCm1MxMBYXJp.VhmH.S
 zDJnTeUQDHoRuw9bXV45X5fRCRtRUVlUb9GI0_.E_CFOU_BM1OejAAAaodBSHcsZObnzUbTOFWza
 oePWAx3yNVlaz21qfOdTCYfokiOGvN2Ymbg7PNH_L6o6XilII0zrzsMaB3T3vSnOyfvbB3hMortP
 u46y_qMnZ7IfsOC.5Oe8O5lSM_vLNjWUgBjqYclTljgxwi2ndrfC4fMdi4unqs6WaqrZ8Pj8hyqh
 fA_tg1UpZxxZfHDj9JXQIBm8kaRi__k6CbT.JcD4qIaL8A8W8d9BTaktUsSVecMHOwOzTXXz07We
 btWxh_PxTGg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6f81bee5-7992-4641-9e43-e75bd0bac9cc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jul 2024 16:41:06 +0000
Received: by hermes--production-gq1-799bb7c8cf-9xr4w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e1c3df5f43dd1ca029467866f5d51778;
          Wed, 10 Jul 2024 16:41:04 +0000 (UTC)
Message-ID: <cda2665d-34c3-4276-afc6-e79e553b7664@schaufler-ca.com>
Date: Wed, 10 Jul 2024 09:41:03 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: Paul Moore <paul@paul-moore.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240710024029.669314-2-paul@paul-moore.com>
 <20240710.peiDu2aiD1su@digikod.net>
 <CAHC9VhTxz6eFFUBZYJ3kgneRqKMSqaW63cXuQvVs_tt88GU_OA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTxz6eFFUBZYJ3kgneRqKMSqaW63cXuQvVs_tt88GU_OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22464 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/10/2024 9:20 AM, Paul Moore wrote:
> On Wed, Jul 10, 2024 at 6:40 AM Mickaël Salaün <mic@digikod.net> wrote:
>> On Tue, Jul 09, 2024 at 10:40:30PM -0400, Paul Moore wrote:
>>> The LSM framework has an existing inode_free_security() hook which
>>> is used by LSMs that manage state associated with an inode, but
>>> due to the use of RCU to protect the inode, special care must be
>>> taken to ensure that the LSMs do not fully release the inode state
>>> until it is safe from a RCU perspective.
>>>
>>> This patch implements a new inode_free_security_rcu() implementation
>>> hook which is called when it is safe to free the LSM's internal inode
>>> state.  Unfortunately, this new hook does not have access to the inode
>>> itself as it may already be released, so the existing
>>> inode_free_security() hook is retained for those LSMs which require
>>> access to the inode.
>>>
>>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> I like this new hook.  It is definitely safer than the current approach.
> It would be nicer to simply have a single inode free hook, but it
> doesn't look like that is a possibility due to the inode
> synchronization methods and differing lifetimes of inodes and their
> associated LSM state.  At least the workaround isn't too ugly :)
>
>> To make it more consistent, I think we should also rename
>> security_inode_free() to security_inode_put() to highlight the fact that
>> LSM implementations should not free potential pointers in this blob
>> because they could still be dereferenced in a path walk.
> I'd prefer to keep the naming as-is in this patch since
> security_inode_free() does trigger the free'ing/release of the LSM
> state associated with the inode.
>
>>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>>> index 22d8b7c28074..f583f8cec345 100644
>>> --- a/security/landlock/fs.c
>>> +++ b/security/landlock/fs.c
>>> @@ -1198,13 +1198,16 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>>>
>>>  /* Inode hooks */
>>>
>>> -static void hook_inode_free_security(struct inode *const inode)
>>> +static void hook_inode_free_security_rcu(void *inode_sec)
>>>  {
>>> +     struct landlock_inode_security *lisec;
>> Please rename "lisec" to "inode_sec" for consistency with
>> get_inode_object()'s variables.
> Done.  That did conflict with the parameter name so I renamed the
> parameter everywhere to "inode_security".
>
>>>       /*
>>>        * All inodes must already have been untied from their object by
>>>        * release_inode() or hook_sb_delete().
>>>        */
>>> -     WARN_ON_ONCE(landlock_inode(inode)->object);
>>> +     lisec = inode_sec + landlock_blob_sizes.lbs_inode;
>>> +     WARN_ON_ONCE(lisec->object);
>>>  }
>> This looks good to me.
>>
>> We can add these footers:
>> Reported-by: syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/r/00000000000076ba3b0617f65cc8@google.com
> Thanks, metadata added.  This was a quick RFC patch so I didn't want
> to spend a lot of time chasing down metadata refs until I knew there
> was some basic support for this approach.  I still want to make sure
> it is okay with the IMA folks.
>
>> However, I'm wondering if we could backport this patch down to v5.15 .
>> I guess not, so I'll need to remove this hook implementation for
>> Landlock, backport it to v5.15, and then you'll need to re-add this
>> check with this patch.  At least it has been useful to spot this inode
>> issue, but it could still be useful to spot potential memory leaks with
>> a negligible performance impact.
> Yes, it's a bit complicated with the IMA/EVM promotion happening
> fairly recently.  I'm marking the patch with a stable tag, but
> considering we're at -rc7 and this needs at least one more respin,
> testing, ACKs, etc. it might not land in Linus' tree until sometime
> post v6.11-rc1.  Considering that, I might suggest dropping the
> Landlock hook in -stable and re-adding it to Linus' tree once this fix
> lands, but that decision is up to you.
>
>>> diff --git a/security/security.c b/security/security.c
>>> index b52e81ac5526..bc6805f7332e 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -1596,9 +1596,8 @@ int security_inode_alloc(struct inode *inode)
>>>
>>>  static void inode_free_by_rcu(struct rcu_head *head)
>>>  {
>>> -     /*
>>> -      * The rcu head is at the start of the inode blob
>>> -      */
>>> +     /* The rcu head is at the start of the inode blob */
>>> +     call_void_hook(inode_free_security_rcu, head);
>> For this to work, we need to extend the inode blob size (lbs_inode) with
>> sizeof(struct rcu_head).  The current implementation override the
>> content of the blob with a new rcu_head.
> Take a look at lsm_set_blob_sizes() and you'll see that the rcu_head
> struct is already accounted for in the inode->i_security blob.
>
>>> @@ -1606,20 +1605,21 @@ static void inode_free_by_rcu(struct rcu_head *head)
>>>   * security_inode_free() - Free an inode's LSM blob
>>>   * @inode: the inode
>>>   *
>>> - * Deallocate the inode security structure and set @inode->i_security to NULL.
>>> + * Release any LSM resources associated with @inode, although due to the
>>> + * inode's RCU protections it is possible that the resources will not be
>>> + * fully released until after the current RCU grace period has elapsed.
>>> + *
>>> + * It is important for LSMs to note that despite being present in a call to
>>> + * security_inode_free(), @inode may still be referenced in a VFS path walk
>>> + * and calls to security_inode_permission() may be made during, or after,
>>> + * a call to security_inode_free().  For this reason the inode->i_security
>>> + * field is released via a call_rcu() callback and any LSMs which need to
>>> + * retain inode state for use in security_inode_permission() should only
>>> + * release that state in the inode_free_security_rcu() LSM hook callback.
>>>   */
>>>  void security_inode_free(struct inode *inode)
>>>  {
>>>       call_void_hook(inode_free_security, inode);
>>> -     /*
>>> -      * The inode may still be referenced in a path walk and
>>> -      * a call to security_inode_permission() can be made
>>> -      * after inode_free_security() is called. Ideally, the VFS
>>> -      * wouldn't do this, but fixing that is a much harder
>>> -      * job. For now, simply free the i_security via RCU, and
>>> -      * leave the current inode->i_security pointer intact.
>>> -      * The inode will be freed after the RCU grace period too.
>>> -      */
>>>       if (inode->i_security)
>>>               call_rcu((struct rcu_head *)inode->i_security,
>>>                        inode_free_by_rcu);
>> We should have something like:
>> call_rcu(inode->i_security.rcu, inode_free_by_rcu);
> The unfortunate side effect of that is that the patch grows
> significantly as everyone that touches inode->i_security would need to
> be updated to use inode->i_security.data or something similar.  For a
> patch that we likely want to see backported to -stable that could make
> things more difficult than needed.
>
> However, I have always thought we should add some better
> structure/typing to these opaque LSM blobs both to get away from the
> raw pointer math and add a marginal layer of safety.  I've envisioned
> doing something like this:
>
>   struct lsm_blob_inode {
>     struct selinux_blob_inode selinux;
>     struct smack_blob_inode smack;
>     struct aa_blob_inode apparmor;
>     ...
>     struct rcu_head rcu;
>   }

I have considered doing this as part of the stacking effort for quite
some time. I've already done it for the lsmblob structure that will replace
most uses of the u32 secid in the LSM APIs. I am concerned that there would
be considerable gnashing of teeth over the potential increase in the blob
sizes for kernels compiled with LSMs that aren't active. I have been frantically
avoiding anything that might slow the stacking effort further. If this would
help moving this along I'll include it in v40.

>
> .. with lsm_blob_inode allocated and assigned to inode->i_security.
> Those LSMs that are enabled and require blob space would define their
> struct with the necessary fields, those that were disabled or did not
> require space would define an empty struct; some minor pre-processor
> checking and header file work would be needed, but it shouldn't be too
> bad.  Ideally, we would use the same approach for all of the LSM
> security blobs, only with different LSM supplied structs.  Perhaps
> once we land Casey's latest patchset I'll see about doing something
> like that, but right now we've got bigger problems to address.
>
> I'll hold off on posting a proper patch for this RFC until I hear back
> from Mini or Roberto on the IMA changes.
>
