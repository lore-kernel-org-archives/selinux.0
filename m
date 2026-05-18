Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A041401A17
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107057; cv=pass; b=c1lP7bcCyOMmP3wpn0u6zuOn+Q091kHrfLWJc7yJ9OeXtOLLnbugP62xs6Xxv24/s3ils4qUkKWxDkf7/eTfjxDVyeCj2rdN4fF+i3ukNJCXgSWFJM7Gf5gKS3fiJxUHZ3RrHXFFHe3gSD95VylBZHAAwDGMFLPxFC49lyiNB3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107057; c=relaxed/simple;
	bh=eEui1lyafBB+ChbIUcOgIAGnx3+5i9tAu3uECLz3JU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGrKdC8E3EQQFQJBFbRgzCblA3DYkIHYJBL9B+n5yFwgMzEJfUMYMi7/nyvuSl09Q8Uo6BlBVcm14rGjJhgp2IjrbdL1SH+qU0KNhJvzRSY24/IDrdk+1FAzFy2s5VjOXJnR8B7zTLPPWQni+g8HM5PxCLazucpfU6HZXwWwDTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JosvHRfr; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JosvHRfr"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c7b9f54d3deso1803657a12.1
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 05:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779107055; cv=none;
        d=google.com; s=arc-20240605;
        b=DazBXkFaQ6+qeG7EQhaWtoDwhBwJv6LsHmwGVEJwv5+mCkj0DMQERDD/E4VKgpCxYX
         n4IcL8tDCLobhWqLSGMn/h8lO142JaSZeHozVxpWhg86rZukg4YBoblqLuhkVAgcf01G
         eaQxu9iHI07n58POW1NkCozmfk8+oqeaEk+XcLwh57q27PhTCLBJs8xJwWPXsubaHNf/
         EDkEBzQyFIKEzytyoO4iIijue95J2fNK0Z4AqHoArQlIBYbJPfZY/G1yqxXZUCDk64Ou
         HmOJk5sKRfmkJt5p0uO+1GZewVyCcJazzXeVisu4FX73ddy2G8LK95/h+M3RXOU03uu9
         0+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lvsFKF7ox5hJCZHNanmgc3SKQHFAoo02pJe0Uh8C9jA=;
        fh=EB0n6i5cCP71V/PmRMQdBjLWPIbyUghkPWCIbv2FTss=;
        b=Qdbd8cV/xys45kWgFnc23vfFrQFcjbtYd7UOHHBl40s0d1ybcBDBYPXeOJ8PAWMcNz
         urW5Bs83cmeKflKma1+kCqrCCphoz2jtNnbeQFdNL5BlwNeFqSDP4mPo3ftRv0Bl86dW
         i82vs5MEJ6gVwq7E3r7NcM/TMnktYhPAPrvs2PjB5OP4YfD05/xq0GKh3T8mHC3z20cj
         1F5SQhZwscX4RXKPcj+NC5n1qi+HOgTeDX5yQXSSSR11F1W9tDD6iVVQLWnb1EwC6Kv+
         X3qZcsYK2yjLdeOUHvUqNPlFWUKfrnCHpRBJrPfqGqRhP+4JJXCwUCZMBlkVEMUvWEx+
         saqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107055; x=1779711855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvsFKF7ox5hJCZHNanmgc3SKQHFAoo02pJe0Uh8C9jA=;
        b=JosvHRfrak+DWd9pd6ZDKZCvTenq9ZYn6EKCvdZJII8ssQJf1U4aMAP00j0Q9V+L6b
         vGusVZASqgbP/yPLDL3N+15xCyR7QG5K8IIwxs/GRqKhpQKzuQn4mNDV8VDI5nHH9EH0
         4g2rEIIGugtzB0VKadTEqegpdjADrWkCsHUiytIm+hb5uJyU9hOfmMZnUf/dpzX7K+7U
         tEM4Kktwj8kTETmHPhkcywX/PHWBXOY4ZnJfpGcAGPnaoZd3VSt1Gfbk3WOLFJC8Vvdo
         btamy1ReXTC//k40WGvl9/DwU7Ts0KTh1ZuTKYZXqjtpeVPKo288lKSGujKTb3y8ShRM
         jRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107055; x=1779711855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lvsFKF7ox5hJCZHNanmgc3SKQHFAoo02pJe0Uh8C9jA=;
        b=cPlTDWqodF6APnD6511KseXJABHV9UDGOxakfcIudx98/UdL0INCfvTw0heFjEiXV2
         E8Hh2sCZB5gQJQweBdOgLu6aMvLqzmSqxMH9bZowrE6+uRNV49DCigtgkF/4HG0uUQ7x
         wCWfGwKG8o81mM5fZBrGRueoVrFhV0ia2NLq7I2KZUHzTQ1v6HFCVDqCONEwH85HFYdR
         DgCuvWB49y929auRsAz7DrvspOyqLlXlvluRqABLL6yFqGiy+gzHA+4xUYbNdno8QAcV
         DE0HTZq1R7c95j0R8dNEiE6W0fDci8y9AVwrcEpMDGBGk0dCe9AZi6TQYUWMIAzaVUaW
         erow==
X-Gm-Message-State: AOJu0YyPBLlZgu001FSqSHK/TjOiuxQfQ5u/osy4lFVJVjN/PgmDGxD7
	DMP6jk3HH8YXsgARTfMl02z4FFCwv4H2+LuoeT7UQgznxtBDDO2KhXX7AqBs6n2ESTDoaCNL5dm
	RBulM2VrV3qYcErYFUIIXjX8HEAZ37tY=
X-Gm-Gg: Acq92OHKzIl8K+NgkhucFuSkrM30MMjH76qwjqlY1VCwJBNmR9Q4x8BAoAtd/GMHYbc
	1Os15duJ8zY5/juF0DuqlkVahUWwuCVKtsl8cuiJdmwTu5v9EFdgXpvPxWSr5dr75/sDXdKtPqz
	xCK7UfteIEroq4/unk2pUwxRV16rwZM7A4c/CawmnBiwS3vX0CXp4KXs7slRwTNzcjq09fxXMJa
	CdwUc3puoNGJTw9hykkgYGHw3JDmkPpQOjlfJYXBLmVoB62OzAchlmKAF+oY1P8FjTsCiz0H1k6
	esibk8kdLp4sM1z8zQ==
X-Received: by 2002:a05:6a20:7f9b:b0:3a2:f05a:793f with SMTP id
 adf61e73a8af0-3b22ee1e06cmr17262372637.51.1779107055404; Mon, 18 May 2026
 05:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <rKg1X_SSNB9SOzR6jIcabSwbkzTU032ccV6kLwmvjEZzs_syLg3_Ct-Wz0tzhvnXBHlbSiEBXAPL2JnWm6b7aNzs0PRf8eRpUX8aTWEyDAM=@proton.me>
In-Reply-To: <rKg1X_SSNB9SOzR6jIcabSwbkzTU032ccV6kLwmvjEZzs_syLg3_Ct-Wz0tzhvnXBHlbSiEBXAPL2JnWm6b7aNzs0PRf8eRpUX8aTWEyDAM=@proton.me>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 08:24:03 -0400
X-Gm-Features: AVHnY4KzdqLeRHu8kyC8jaifkcbWuQtgxF0rTaalXWT0VNcaTvdn0X5iqu2CUFk
Message-ID: <CAEjxPJ7ptbECmgo4=3j7YN4G4EP5Fp_ee=Te=FQo8VOxD3VnMg@mail.gmail.com>
Subject: Re: [PATCH 0/2] selinuxfs: fix inconsistent policy state and
 deprecated op return value
To: BoxStrike <BoxStrike@proton.me>
Cc: "selinux@vger.kernel.org" <selinux@vger.kernel.org>, "paul@paul-moore.com" <paul@paul-moore.com>, 
	"eparis@parisplace.org" <eparis@parisplace.org>, NeilBrown <neil@brown.name>, 
	Jeffrey Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 6:15=E2=80=AFAM BoxStrike <BoxStrike@proton.me> wro=
te:
>
> Hi Linux Team
> While reviewing selinuxfs.c I found two bugs. Patches are included below.

Thank you for the report. However, please see
https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started
for information on how to prepare and submit patches for SELinux. Also
see the comments below.

> ---
>
> [PATCH 1/2] selinuxfs: fix inconsistent policy state on partial swap fail=
ure
>
> In sel_make_policy_nodes(), the boolean directory swap and the class
> directory swap are performed as two separate, non-atomic operations.
> If the boolean swap succeeds but the subsequent class swap fails
> (e.g. -ENOMEM from start_renaming_two_dentries), the function jumps
> to 'out' leaving the filesystem in an inconsistent state:
>
>   - fsi->bool_dir points to the newly populated boolean dentries
>   - fsi->class_dir still points to the old class dentries
>
> This means /selinux/booleans/ reflects the new policy while
> /selinux/class/ still reflects the previous one. This mismatch
> persists until the next successful policy load.
>
> Fix this by rolling back the boolean swap when the class swap fails,
> so both directories either reflect the new policy or both reflect
> the old one.
>
>
> ---
>  diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -519,8 +519,22 @@ static int sel_make_policy_nodes(...)
>
>   /* classes */
>   ret =3D start_renaming_two_dentries(&rd, tmp_class_dir, fsi->class_dir)=
;
> - if (ret)
> - goto out;
> + if (ret) {
> + /*
> + * Bool swap already committed above. Roll it back so
> + * booleans and classes don't reflect different policies.
> + */
> + struct renamedata rd_rollback =3D {};
> + rd_rollback.old_parent =3D fsi->sb->s_root;
> + rd_rollback.new_parent =3D tmp_parent;
> + if (!start_renaming_two_dentries(&rd_rollback,
> + fsi->bool_dir,
> + tmp_bool_dir)) {
> + d_exchange(fsi->bool_dir, tmp_bool_dir);
> + swap(fsi->bool_num, bool_num);
> + swap(fsi->bool_pending_names, bool_names);
> + swap(fsi->bool_pending_values, bool_values);
> + fsi->bool_dir =3D tmp_bool_dir;
> + end_renaming(&rd_rollback);
> + }
> + goto out;
> + }

Your patch seems to have been whitespace-damaged by your mail client
and you should only send one patch per email; use git send-email as
per the getting started guide I referenced above. However, I am not
sure that this change is necessary or correct. I do not believe that
start_renaming_two_dentries() can ever actually fail on selinuxfs
because selinuxfs generally doesn't support userspace modifications of
the directory tree and the only changes that do occur happen while
holding the policy_mutex, so they cannot interleave with one another.

There may however be a separate issue here in that IIUC userspace can
see the tree (i.e. perform lookups on it) in the intermediate state
where bool_dir has been renamed into place but class_dir has not. I
don't think this was possible before commit 833d2b3a072f7ff ("Add
start_renaming_two_dentries()") and I missed this at that time. In
practice however I am unsure that this can cause any real harm because
there is no inter-dependence between the class and bool definitions,
sel_read_bool() takes the policy mutex and therefore will wait for the
policy commit to complete, sel_read_class() doesn't depend on any
policy state, and we generally only append to the class/perm
definitions upon policy updates to avoid userspace breakage. That
said, I may be missing something.

>
>   d_exchange(tmp_class_dir, fsi->class_dir);
>   fsi->class_dir =3D tmp_class_dir;
>
> ---
>
> [PATCH 2/2] selinuxfs: return -EINVAL from deprecated sel_write_user
>
> sel_write_user() is a deprecated interface that logs an error and
> returns 2 (bytes written). selinux_transaction_write() interprets
> any rv > 0 as success and returns the original write size to
> userspace, making callers believe the operation succeeded.
>
> Return -EINVAL instead to make the deprecation explicit at the
> syscall level, consistent with how sel_write_disable() and
> sel_write_checkreqprot() behave in terms of intent (though those
> also have the same issue -- a follow-up could address them).
>
> ---
>  diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>  --- a/security/selinux/selinuxfs.c
>  +++ b/security/selinux/selinuxfs.c
>  @@ -998,9 +998,7 @@ static ssize_t sel_write_user(...)
>   {
>   pr_err_once("SELinux: %s (%d) wrote to user. This is no longer supporte=
d.\n",
>      current->comm, current->pid);
>  - buf[0] =3D '0';
>  - buf[1] =3D 0;
>  - return 2;
>  + return -EINVAL;

We explicitly did not want to return an error here to avoid breaking
userspace. That was explicitly noted
in the commit message that introduced this change. So NAK to this one.

>   }
>
> ---
>
> Note: I also noticed that sel_make_policycap() assigns the name
> "unknown" to all policy capabilities beyond ARRAY_SIZE(selinux_policycap_=
names),
> resulting in multiple dentries with the same name being passed to
> d_alloc_name(). This may warrant a separate fix (e.g. using a
> formatted name like "unknown_%u"). I can send a patch for that
> separately if useful.

Arguably that should be a BUG() instead but I'll defer to Paul on that one.

>
> Thanks for your time.
>
> Eneshan Erdo=C4=9Fan Karaca
>
> My github:https://github.com/Kisaca-Enes
>
