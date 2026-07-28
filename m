Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315A3C345C;
	Tue, 28 Jul 2026 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260532; cv=none; b=nctiIghAPmzkFDR64evBvrw0q5KW2utGvM2MT+ap5kikoyFbYdfmuyDPAjtIuB/v08rzCx5Qwrgg3GvtRPrTx2sdrbWwTzoJ9g+o7/7vMaKKlYxPktLbS74SaiRCR4upno/8TET/TSWyppgWFC/I42cu9EIpbjyxnQ7lizMqpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260532; c=relaxed/simple;
	bh=suTdVVxiaEvBKvyTOJY036bsXmHy+cNHnLj/b2Y7XIs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RT10m6f3XLmnLv+9Q7WXNVwqokdXJEFGfvHp3iPswrzZJWOhNWjYeXqOZu2y3ehaTC0xxParN4xymI+xd4c1lhvE42DwvQMDHG+6vd0WANvCFmE+0iLSuHvfpaDAGZm687goashiZTY9FA6K3qGtLiekjQKpbZrt84IOnXM3Sy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kxiSW4kb; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kxiSW4kb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1785260527; x=1785519727;
	bh=Y/rdncE3MRRvkT9UhPnZ7PkmuXv60/JIg2Qb1f3t8yo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kxiSW4kbvJDh1WT6qghiNsOFUrN5xJpC/ly0GfJlj/mutV1HAavbeayrJLaIK7kBH
	 JgvCN1lq/WBfZjwchdcOOp4OJI01gOt5f8E4cNpyywj0V0OnBqyaebZgS0YGIV5/rc
	 f+OkPrWruWY41cTgVutFE5ZQdu7bqTTCjzeqwd/z3FTtkBg7z9vWmEHhB9XVSNO+Yx
	 tQsLhD02L+A0g8i5FBT2hzt6497A+DvuwgG8gYC5jeszstJnTkdKum89UCGC2Kk4Di
	 /IeD+y6h8ypC/AZEKTUa1/p5MOIIvYd5mxw1KZSstTJmOTA8E6G8pZ4zFak8FSkAAX
	 oFG4vANDfTV5A==
Date: Tue, 28 Jul 2026 17:42:03 +0000
To: Stephen Smalley <stephen.smalley.work@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?utf-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selinux: reject a class permission count below its inherited common
Message-ID: <20260728174158.70827-1-hexlabsecurity@proton.me>
In-Reply-To: <CAEjxPJ4X_p6Qpebe9cV=eruOVM2HXHMDWsWJpQA3QoBc+W1kXA@mail.gmail.com>
References: <20260727-b4-disp-eed1276a-v2-0-82d58cf5f882@proton.me> <20260727-b4-disp-eed1276a-v2-2-82d58cf5f882@proton.me> <CAEjxPJ4X_p6Qpebe9cV=eruOVM2HXHMDWsWJpQA3QoBc+W1kXA@mail.gmail.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 547b78c4ae40762ced44032a35108662ce713d9e
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jul 2026 10:43:39 -0400, Stephen Smalley wrote:
> Sashiko again made some interesting observations but not about your patch=
 per se,
> https://lore.kernel.org/selinux/20260728014625.C7A391F000E9@smtp.kernel.o=
rg/T/#u

The first one reproduces. security_get_permissions() sizes the array by the
class's permissions.nprim and fills it by value, so any index no perm datum
claims stays NULL, and sel_make_perm_files() passes every entry to
sel_attach_file() -> d_alloc_name() -> hashlen_string(). One u32 in the pol=
icy
image is enough: on the policy I tested, class process has nel =3D=3D nprim=
 =3D=3D 31
and inherits no common, so raising its nprim to 39 leaves slots 31..38
unwritten.

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:hashlen_string+0xa/0xc0
  Call Trace:
   d_alloc_name+0x61/0xa0
   sel_make_policy_nodes+0xb35/0x1310
   sel_write_load+0x2a5/0x490

load_unaligned_zeropad() doesn't absorb it: ex_handler_zeropad() rounds the
address down and bails unless fault_addr =3D=3D addr + sizeof(long), so a N=
ULL
base takes the ordinary fault.

It doesn't stop at the loading task. sel_make_policy_nodes() runs under
selinux_state.policy_mutex and the only unlock is the out_unlock label the
oops never reaches, so every later load blocks in D state; SIGKILL doesn't
clear it and only a reboot recovers. Under panic_on_oops it is a panic at
step one.

The second observation is real as stated: get_permissions_callback() does
overwrite perms[value - 1], and the cleanup loop walks i < nperms freeing
whichever pointer survived, so the first kstrdup() leaks. What makes it wor=
th
more than its severity is that it also defeats the obvious fix for the firs=
t
one. Requiring the counts to add up -- nel plus the inherited nprim equals
permissions.nprim -- doesn't close the gap, because symtab_insert() hashes
and compares the name only, so two perms may carry the same value: the coun=
t
still matches and one slot is still never written. The property that holds =
is
that the values present are exactly {1..nprim}, onto and injective, where t=
he
two patches on the list establish only "into".

The classes side has the same shape: get_classes_callback() also writes at
value - 1, and sel_make_classes() passes classes[i] to sel_make_dir(). By
inspection; I have not reproduced that one.

Policy crafter and the full log on request.

Thanks for the ack.

Bryam

