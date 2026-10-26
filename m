Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793022119;
	b=Ad0FZfuia1dUpfuAeWmLY4WomdYpUmbaWc11IkkOUY/yozSynYqqKmALz6wofN5Bo6gj
	 SDxq4GQoyW5E/FaY/BuBBGf8RQgZWniO1U+F3lCkzMXXzjRTu3cENVgbULof/Auvi4moL
	 Do2nc0mTean6A2jV+lwYDV4QhUopymfSXFxVZN/oHJfdEL9RlFxeKAsj8TXc3s5b4KLoM
	 cpiGktlifcEk/+ke6jnjfJHXMcp1rjwrUpbdM3YcQOYcadonCQm2q6dtQ4vgkbow2jvHA
	 9uAjy1GbepssmsJ/sMkwJZ/+pQVh2YRC1VuoK5azYVxxLFRkEd4avcTZFmFcOaXXW+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=IrdSL+BD8en7HJvlQPxD9x0uSQVq16vCseAP6v6nHb8=;
	b=QW+AbBMFuQIIsuIwOLChk5/WIjF4QLQJHkG3+yxI4aoksE8GzXtHyRYrOe9j25/w6Z3I
	 hd6OraugtDCrQuGO4w+AwgCXvksczXZ/92w0OWMOeWIvGOz7lpxhNUNlFuG7uqNS5FCxk
	 OqiXboiwfQemIhRCLFLhc9p35QPNeeewSbBSPK4zYxvpKGYU3c6lTQ2yRUwLVDAQdXR9B
	 41fUSUn9m0LoQ9KAiebjW0QZVqAWdfl9MG0GRPqXqR8nuW0sXM96NqVDBjMIBQ4qtug4E
	 bJ8gzx3cNL219esXugOxAySGfDixmsyPmSNLe8BG2vUumUOJV6q5COh3MR3ICWJknww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eLeiXxob;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94242606A31A
	for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 13:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94242606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eLeiXxob
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6767d92cde6so2754976d50.0
        for <selinux@vger.kernel.org>; Mon, 26 Oct 2026 06:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793022119; cv=none;
        d=google.com; s=arc-20260327;
        b=g5fZG6KDQ5ouKmojZaI21eh5mUSWYzOm8xzCxSIoxyJKS/7/vJ9pWRDoRpZmh9/tmd
         gK0UgrHiPcIF0wfzgI5YwcW/vpYcjcac5ONsW9ywi4plaOR5/czG98TrUdXXJUvVV/96
         HpDPtXP0ajVxJfuQ0nrvJvbBtYFo9Ezce4lLwscZ7vbas/kDd88fDYgTIT9g7qAEUKin
         rMB1grnyCCL593G/OeB9C18jYgWKKqomqlV2P1Srm5LBx4Ql6m28JEYpYAL/9niC4tau
         78eykokLKYbE1wR0ekkqznbhJiMlV2jD2eJTqpkkWk870SovRwDODnejBdqvQaY6tKPt
         Wgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IrdSL+BD8en7HJvlQPxD9x0uSQVq16vCseAP6v6nHb8=;
        fh=oY3YJwlQJe6qc1tfsT1YP2sL1SDhL9BUcCb87gGht54=;
        b=olG0Bk+tGNsZVq7WJ3lPjeNejIttXhX7dH12zwT+yN8RlNarbA2JXUd4aicKDnEw5o
         SiHDKS0wR62c5nsE12ecrzYT5wLia+h+Qgdhu0TMTUVb0JOkE2pCvmJEqVKPtRIVOePp
         mbMEdf7tV3D/ANCVTE+N4ssSklACQu2M3Wnm5rzEjr/YUQZ+KbaWJ4fmqN2onC/SPMDw
         pBOSclTLEAHgjneD4/s/RUjxKBkJ2nYvynCeUu6aQOpxjSjWYU5ebm0QVHxJ1frCU7Pb
         be1/5Q3RjqQ6QWpTZg59JO+D+XV4LxtAMtj64HOlKSf25pI0yBjTINvwkJBiCuAdC4xT
         Ngkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793022119; x=1793626919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IrdSL+BD8en7HJvlQPxD9x0uSQVq16vCseAP6v6nHb8=;
        b=eLeiXxobURaShO9MoChmC7cPMWns4PGzNp2C7YDKfZY/lVine+EjeLjLhtHOk8H+Wm
         vjL25aHNCV8IZAUdj95shY3lud0XdcFLPW9yxmWQLXup6dOG/+l/kpCNmCilws/LYFe9
         M33Lwt/yyczvhWOiqzmHarfraFeQh4MFjKBzM1i2PoLcGbbsXk8kE58sGKV9SuH+K8Or
         /5lwVkPN8qn8MUroA1U5S704ACdX/8pIMcQmo6c9sIaJ3NvvzSUnlFI+tXrtE9yJZ61U
         hRhe2DpXCppAJI9g2BvgN6Eww8FP9Gqx8O6037hBORS7rpFlbehQlgpIyn3/YMcJh69s
         d0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022119; x=1793626919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IrdSL+BD8en7HJvlQPxD9x0uSQVq16vCseAP6v6nHb8=;
        b=wpOd64ZdLqaemgcgcE43+BJCQwtOvs650FNoGgxnpNWm/D4Km7EJtrWsIyKrljHTge
         d38c8dz5zoSM049HKZyhLWU8MMRsI0qfRrL3YHwuw3UNNIOx+rVcZ7/5XJ9nTs/PvJmZ
         0P+CJYVNAsSNJgDY4v1OYBpfcCae97ITrcsaG5r0KyrUo7CsbqPD5ejGHJgLaj6QLAWD
         p4qfh+g1Zsg6wpUm0nVza2bOoAVdiWuSKIRxy15W9cDIOfp9NnVefqYzubZnTpke86k+
         rb4pry+kb0pAzqKiINapymWHFvSa0wDym/hqKpOmg4OmqgmMfuyp5UXKOaIY2zC0x157
         uDDQ==
X-Gm-Message-State: AFq9FYIbVwujUi6yxxFyd1jO8TvKBlyvNzECCuWOy0iarIvoncrpSm8L
	lf2+6hGT9PxjbcnT8/uWb/Djcc04CUcI4GVJcgYrTLPzDZLmI+oFge/pVwwFVV6eHqvmTFD9WVz
	AM1swnDfnHOt6dVaLzGWcBKGxhz4b0zDEp101g9E=
X-Gm-Gg: AYBFou1UcT9E+j0ZBv4rgAliLi8kda3ydR8rqqsbB1xdxUO9m82p9INDrzPIiWq8rTG
	nO1mO0+8tC5ucMrsCcg+ejZbBf5D7MIjjaXDfk1bWz4E0Qn1FczuAk1IZiVCnzyjSUB6WYsVINE
	TSfhHPO7eeDZHLeYz43nEu+awyy7RQjeYqv1aMjuY/paSDQXpGwoyLKjflhbL4mIDVnGcYtV9UO
	OS3mf8XYsEKyCBzGwhEOpgnRFD5qwbRUEMMjmSetkXpZoTUdZJKQ3rtEpJNLj+7lLRJOpQLMORX
	nbuxUX0sIJF7df/vG14Yvpx7PbPyhjDZpn6AGzKubGm5mKwzrWi3I7Nh6v5oV6zAIGLjRWHZrV2
	0i5RE5LoV85fuojKDhS1qPi4VbxXforEn/mdezsJ+wPOpmM6uJg2urFIxBiUNZJGc8zFozxKSnZ
	0cXyEIiFvj7G7WFFK7QOJEmBiMP2o5Kc9tCZVF8LcOzmA=
X-Received: by 2002:a05:690e:4393:b0:677:c014:29c7 with SMTP id
 956f58d0204a3-67a4543939amr3746792d50.57.1793022118603; Mon, 26 Oct 2026
 06:41:58 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023183112.61272-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261023183112.61272-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 26 Oct 2026 09:41:47 -0400
X-Gm-Features: AclHuK-gXB35UDm9gTN62NIBZF57xhyIIdq_5440VjkD2ZbMAb8wjtTUgIb8hhM
Message-ID: <CAEjxPJ6pwR-L6b=v50eEegQvbM6cZjAz1b02-OsWXVOs0sdMOg@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: preserve cached records when replacement
 cloning fails
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cathy.hu@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 2:31=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Both dbase_llist_set() and dbase_llist_modify() free the old record
> before cloning its replacement. Record clone functions such as
> sepol_bool_clone() leave the output pointer unchanged on allocation
> failure. A failed update therefore leaves entry->data dangling, and a
> subsequent query or cleanup accesses freed memory.
>
> Clone into a temporary pointer first and replace the cached record
> only after success, preserving the original record contents on
> failure.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
