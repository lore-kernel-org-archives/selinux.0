Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341B9132121
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143276; cv=none; b=ZUSSI3SXSQcr8km1oBivXCwFiOnlCQX7k1wfHfngSMFYn9pfU70J/efNl47It3PZXtCLI4OCyk2JAkwpqGKBNSK7vDyJqb3f79Asoz8JAg2QJcxNtnHIcN0Sn48//VBh5dXd21oNoi+597upYXX7/i/7SLVfPtMv9Uz0fWTVc1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143276; c=relaxed/simple;
	bh=5IfyEJz8QpokWbMzXhStf85MyqUqHTAYB4QBbP8MUTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWSIktU5vosjgl6sG48U+8175nGWF1UWouTfQeSPzAu6covf2QiGbf0IR97d6+7hUwLC5ZL5rSIBTKi2nnQRvqWOuDf5v/0e8FwmTz/7nhA+UcVUu6+RjCahvkQs+GAWnwdEQp4BCNkqhtPt4sYzZZ2L19lHMx3dd9ByOY5v4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnKK5kqW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnKK5kqW"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-75a6c290528so952470a12.1
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2024 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723143274; x=1723748074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9b/UCPdympi6kLEXUDe5cOZpoiMP6gQXppImwep3XMY=;
        b=mnKK5kqW7tn5C5jASaRplAFPMoRyGe2o5cq+07nTfQBbCUG2FNQSK/cNbhk36Hnl5G
         IbH9R7uFYwrGDLNM26AZB5C0Y5XqDnXBAS6uxlxN130jeMs6FPVLwxLW5xWiOIIbnj0z
         +1jPRp3wB6mqQp0ib8S6syEdlrk+oHkZO624cBlj6dAAskJf+88N5jiK9qh/71d56gdH
         UHyMOXeTiymUyGnYUgoiHYtq2Mk3YasJifdqO1YxpGeDyq95eBwHtVYGNfD7mLtwjbAf
         oe0GYUeKa/cPJlmZqnB95nwB2oOM9R7NhB4fVTj7LWNndi3ccejqwwOunyaq3E1uIKT/
         NAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143274; x=1723748074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9b/UCPdympi6kLEXUDe5cOZpoiMP6gQXppImwep3XMY=;
        b=RMTfbvxWxvwz11jjDfnH8S/naoCe60u4TsjB/cRCV5W6qh4s2x4mT3xoMV1DoVjT+0
         +8nGXQDUYwFLCM1bq//RT03Rt5K1zjK5NffN9abNxwl7jomj05c5uQy/+HuCxlJv7Iqo
         6IUt03TIf6Ib8YBR05qtb73SfM336cw5mkfj6hHa4Xc13ylGgkNtq28oeDQgzuf+PXmV
         iqxR/PlXb4sAYD0i+ByQ2PIdrIQW1LM395O4Jyhr0PdfnPSUqr7gmyI8m0Cc46m/7Y5M
         KlVWWAEUhGegpsy7hjSjR2wi7OrcnZONZgUMU8kMHKfY8Ez+NMRu11xCj8sfs4QRqpb6
         A1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWIwnl4FIQRzTXre3L8TB7Vg8pDeHXSmVgD4TaFaNyUwIS1q0Fgg8ZN+uep3spnyDew6lPXuRumAmmng/7/OWpT9zdCMfx+dQ==
X-Gm-Message-State: AOJu0YyJ1phEd4YAUx1EdXiYS2UDXUW/ZlifF2F3HbFaUOYl52Y95lIB
	EAYBejDL1UQJarn4Sok0R2srocAwKu7jdaYZSb9IfChrZzpHVfIfZ49POkxR4lUdTnoerigPJwJ
	sWyXri137IJr7+BRb8ju+olRIuzg=
X-Google-Smtp-Source: AGHT+IGwMBTqKaAq4eS3RFXifkuhq6wTRECTBzVLrh6vpi706SqYKXjJnvJE5ovIM52rejttWGvvbqyLRR6pL+905DE=
X-Received: by 2002:a17:90b:180a:b0:2c4:e333:35e5 with SMTP id
 98e67ed59e1d1-2d1c347484emr3267942a91.36.1723143274456; Thu, 08 Aug 2024
 11:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808130909.1027860-1-wangkefeng.wang@huawei.com>
 <CAEjxPJ4b2Xcptmi2cJNyh=N=1ky=yfg_wVB1yDLwr8uuhujxew@mail.gmail.com> <CAHC9VhRz=drY-=W64VezugemWsBgaQZS_NQ2TZzrS0-fhZgg6A@mail.gmail.com>
In-Reply-To: <CAHC9VhRz=drY-=W64VezugemWsBgaQZS_NQ2TZzrS0-fhZgg6A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 8 Aug 2024 14:54:23 -0400
Message-ID: <CAEjxPJ5JsNF=ypOFJxLGB3aBOAXLC7av+_HWS_FObfdGz+d0AQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "selinux: use vma_is_initial_stack() and vma_is_initial_heap()"
To: Paul Moore <paul@paul-moore.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Marc Reisner <reisner.marc@gmail.com>, david@redhat.com, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 11:48=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Aug 8, 2024 at 9:40=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Aug 8, 2024 at 9:09=E2=80=AFAM Kefeng Wang <wangkefeng.wang@hua=
wei.com> wrote:
> > >
> > > This reverts commit 68df1baf158fddc07b6f0333e4c81fe1ccecd6ff.
> > >
> > > The selinux only want to check whether the VMA range is within the he=
ap
> > > range or not, but vma_is_initial_heap() helper will check the interse=
ction
> > > between the two ranges, which leads to some issue, let's turn back to=
 the
> > > original validation.
> > >
> > > Reported-by: Marc Reisner <reisner.marc@gmail.com>
> > > Closes: https://lore.kernel.org/all/ZrPmoLKJEf1wiFmM@marcreisner.com/
> > > Fixes: 68df1baf158f ("selinux: use vma_is_initial_stack() and vma_is_=
initial_heap()")
> > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >
> > I was only going to recommend reverting the change to the heap check
> > but in case Paul is fine with a straight revert,
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> I was hoping that the mm folks would put together a quick patch to fix
> what looks like a problem with the helper, but I'm not sure when that
> is going to happen and with other callers I don't want to change the
> helper and break a different part of the kernel.  Unfortunately that
> leaves us with needing a revert, but like Stephen said, I think
> reverting just the heap helper is the right thing to do right now; I
> also want to put a comment in there for the next time someone tries to
> re-add the vma_is_initial_heap().  Give me some time, I'll have a
> patch out for this later today.

FWIW, I tossed the reproducer code from Marc Reisner into a branch of
the SELinux testsuite and wrapped it up with an added test to the mmap
tests here:
https://github.com/stephensmalley/selinux-testsuite/tree/execheapregression

Passes with the revert, fails without.
Would need to be modified to be portable to actually be suitable for
inclusion though.
