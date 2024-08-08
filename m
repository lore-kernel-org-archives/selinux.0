Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284831494B5
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723149669; cv=none; b=iroeaQTFRpeuwCt9//vRiOG3QxcbokcPyvZa4T++kASQaUGNPs/S6VFMzzSkxR+ebdjXSaCVIWHfOkVX3mN1HG9ZFsLXfBMbGORwZHk9H2cwxOkRBuWZ5XqZMrFBXO3PjfzufcCVkNvXT5Aigck/vsMExPjdpbHO5vD9W/FvS5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723149669; c=relaxed/simple;
	bh=8c4fRjKtLaDxadYVf4tH7YI83pcDs483FX3Mk+HmEvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYEIYXWQHoYZMaVoeUv5i9Cv4Grr7Rg5xA4VPomrXg1jnm9B6RA+SvoN5G1TW22fHMCdMB54m2XqCCPJTPBj88Z6UCvCqnm6cP/Jd53qsSSNt6DEHM8ZnY+dI/59vkFllIJSuYqeTHXm1JSznPblDIh+8YP4G733zjRsIBtOHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QyBS7uUZ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QyBS7uUZ"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e0ea24477f0so884418276.2
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2024 13:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723149667; x=1723754467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47GICyzC2wsg72IYW9hbDwZbOSRLvptGet3pY/U01PA=;
        b=QyBS7uUZIfV8fh51RxZcPHJg78toMntdKD+Czo1gkx1XJloDuLGqzVmvPq9Sg4tTEK
         RaB0Lh767Xyhro1YEMDzSRaCb1DB2YQrmspJThlOZTKMxFLwR61PsGLkXr91evMBvkpr
         VfDg8FbHmGVlnEIgGMfnNzPyrtP0KDLvFf46xfNPkP5lumMtooTs/IzBcfdlk8UU7w2N
         QOlJ5mATBVxvrK6L8EXLIzyJDx11OT6vdP5CvsnC4y2P/A6Sw4tqGSzCn3CyN42z5qJ1
         CcgdvOf06Aseeouz1nHgcUtqwWQ95BeAjGBbsczKkybDdSJVz3iu5Zw1mfZqkHHLmbJi
         TyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723149667; x=1723754467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47GICyzC2wsg72IYW9hbDwZbOSRLvptGet3pY/U01PA=;
        b=q3tFt7lxcpHi6ZtCXhkLtrg/vjw4R+jZGDjRoediPwEcMddbo4r9tfNiLODQisP9ck
         gikjinQvYcAagdWz4Y3VciV2OlvxLwU8peZneluA5zPdBxjLi4DPEo1SCygfv1BfOzvG
         v8KtzcraQNzz0OFhl6WA//dGEmHLIGVZ71oaZwUQ9K+VBWMRq4i4gPZe9DJOy6dwhr5z
         udN/+4HYOVGhTmz2R+5TrunynbjE7MWriF3kdY4XBL36wtjM8xT870wsmlflPZSuT0By
         N7MlSfaQyANe3YXkJAB3xKlf7eiOfFzMRbHkWzjtI/2nklFICVWVKXC/fJ1cxlxk7893
         ryJw==
X-Forwarded-Encrypted: i=1; AJvYcCX+eyh3eBy8uV5xSFRIB9rU1RWUAgRoy8swVdQ+cd9me7OjEzUXbAcVsHESsk3PhZ5Vtk4ezsFuGO0GmXat1FozBPzT/7n8qw==
X-Gm-Message-State: AOJu0YyDryPx66Z7v56Zm3++TimXZqW2AoxC3zqJ6xzGWK344MuU+8Ww
	vvkl/tTvXBY2N2Se+0c1BGNR7c6yc7uZ8ZwnunQr1bZRa0Fr/yx6n8ZsPfqc53KOlK3pDqxlEkl
	n4hOXeLquMgWSTsdkSA78t9IJgjV5558h9eX5
X-Google-Smtp-Source: AGHT+IHoVkNERNU07XQScwT0BUcd8pt6tw/nehsU6Jtn5wJK8NwgmGYtb18Q9QxjOFECkVSI6YxnqRBaByC2KT58+y8=
X-Received: by 2002:a05:6902:2e0f:b0:e0b:f69b:da19 with SMTP id
 3f1490d57ef6-e0e9dbb268bmr3874613276.40.1723149667133; Thu, 08 Aug 2024
 13:41:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ba8477ed-b7a1-4833-a01a-b7d43ddb47b8@huawei.com>
 <ZrPmoLKJEf1wiFmM@marcreisner.com> <CAHC9VhSWVdiuK+VtbjV6yJiCp=2+6Bji_86mSkj1eeRL4g_Jfg@mail.gmail.com>
 <7fb19e0a-118d-46a1-8d1b-ab71c545d7ed@huawei.com> <0806d149-905c-49b2-930f-5d6d0f8890c9@huawei.com>
 <CAEjxPJ5S9sz4PaRMVLyP6PWdLCG_bBxj7nw53EhU5+L1TM7kFg@mail.gmail.com>
 <4d2e1d4f-659a-428f-a167-faaaa4eca18a@huawei.com> <ZrTeT8_pzD8fH-_P@marcreisner.com>
 <zk5ffj6otbixbnppw4shxgz4tjulagm7du457gzi4qg7zrtdkk@e7mbwyzhdtrx> <ZrUd-ZUe12FahKIc@marcreisner.com>
In-Reply-To: <ZrUd-ZUe12FahKIc@marcreisner.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Aug 2024 16:40:55 -0400
Message-ID: <CAHC9VhS2T+Ld0hpP9aioJKEMkjUH-iQbHbiRkAPHgCWJgDBaQw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] selinux: use vma_is_initial_stack() and vma_is_initial_heap()
To: Marc Reisner <reisner.marc@gmail.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	omosnace@redhat.com, peterz@infradead.org, selinux@vger.kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 3:35=E2=80=AFPM Marc Reisner <reisner.marc@gmail.com=
> wrote:
> On Thu, Aug 08, 2024 at 02:00:09PM -0400, Liam R. Howlett wrote:
> > Have a look at the mmapstress 3 test in ltp [1].  The tests pokes holes
> > and mmaps into those holes throughout the brk range.
> >
> > [1]. https://github.com/linux-test-project/ltp/blob/master/testcases/ke=
rnel/mem/mmapstress/mmapstress03.c
>
> In investigating this further, with additional reproducers, I believe
> that the whole bug is in vma_is_initial_heap().

That's my feeling at this point too.  Unfortunately, there are a few
callers other than SELinux so I don't want to change the helper
function without an explicit ACK from the mm folks and I think now
that we understand the problem we want to get this fixed ASAP in
Linus' tree (and get it marked for -stable).

I just posted a patch that reverts just our use of
vma_is_initial_heap() in favor of our old logic and adds a few lines
of comments about the problem with vma_is_initial_heap().  I'm okay
with moving back to vma_is_initial_heap() when it's fixed, but I'd
prefer it to be fixed for a while before we transition back to it.
We've gotten burned twice now with vma_is_initial_heap() so I'm going
to be a little extra cautious here.

https://lore.kernel.org/selinux/20240808203353.202352-2-paul@paul-moore.com

> What do you all think about this patch? If it doesn't have any obvious
> flaws I can submit it (along with a revert for the revert).

I'll leave the mm folks to weigh in on the fix to
vma_is_initial_heap(), but as I said above, please don't submit a
patch to SELinux right now, I want the fixed version of
vma_is_initial_heap() to "soak" for a bit before we go back to it.

--=20
paul-moore.com
